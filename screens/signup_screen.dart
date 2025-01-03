import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../factories/user_factory.dart';
import '../state_management/user_provider.dart';
import '../utils/helpers.dart';
import '../utils/formatter.dart';

// Định nghĩa màn hình đăng ký, là một StatefulWidget vì màn hình này có trạng thái thay đổi khi người dùng nhập liệu
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers cho các trường nhập liệu (email, mật khẩu, tên, số điện thoại...)
  final _emailController = TextEditingController(); // Điều khiển nhập email
  final _passwordController = TextEditingController(); // Điều khiển nhập mật khẩu
  final _confirmPasswordController = TextEditingController(); // Điều khiển nhập xác nhận mật khẩu
  final _nameController = TextEditingController(); // Điều khiển nhập tên
  final _phoneController = TextEditingController(); // Điều khiển nhập số điện thoại

  // FocusNodes để lắng nghe trạng thái tiêu điểm của các trường nhập liệu (ví dụ: khi người dùng nhập vào trường nào, trường đó có tiêu điểm)
  final _emailFocusNode = FocusNode(); // FocusNode cho email
  final _passwordFocusNode = FocusNode(); // FocusNode cho mật khẩu
  final _confirmPasswordFocusNode = FocusNode(); // FocusNode cho xác nhận mật khẩu
  final _nameFocusNode = FocusNode(); // FocusNode cho tên
  final _phoneFocusNode = FocusNode(); // FocusNode cho số điện thoại

  // Lỗi hiển thị (khi trường nhập liệu không hợp lệ)
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _nameError;
  String? _phoneError;

  bool _isLoading = false; // Trạng thái loading, bật lên khi đang xử lý đăng ký

  @override
  void initState() {
    super.initState();
    // Thêm listener cho các FocusNode để khi trường nhập liệu mất tiêu điểm, ta kiểm tra tính hợp lệ của dữ liệu
    _emailFocusNode.addListener(() => _onFocusLost(_emailFocusNode, _validateEmail));
    _passwordFocusNode.addListener(() => _onFocusLost(_passwordFocusNode, _validatePassword));
    _confirmPasswordFocusNode.addListener(() => _onFocusLost(_confirmPasswordFocusNode, _validateConfirmPassword));
    _nameFocusNode.addListener(() => _onFocusLost(_nameFocusNode, _validateName));
    _phoneFocusNode.addListener(() => _onFocusLost(_phoneFocusNode, _validatePhone));
  }

  // Hàm xử lý khi mất tiêu điểm (Focus) và gọi hàm validate tương ứng để kiểm tra tính hợp lệ của dữ liệu
  void _onFocusLost(FocusNode focusNode, void Function() validate) {
    if (!focusNode.hasFocus) validate(); // Nếu trường không còn focus thì tiến hành validate
  }

  // Hàm validate email, kiểm tra xem email có hợp lệ hay không
  void _validateEmail() {
    final email = _emailController.text.trim(); // Lấy giá trị email nhập vào từ TextField
    setState(() {
      // Kiểm tra tính hợp lệ của email
      _emailError = email.isEmpty
          ? 'Email cannot be empty' // Nếu email trống
          : !Helpers.isValidEmail(email)
          ? 'Invalid email address' // Nếu email không hợp lệ (dùng helper để kiểm tra)
          : null; // Không có lỗi nếu email hợp lệ
    });
  }

  // Hàm validate mật khẩu, kiểm tra xem mật khẩu có hợp lệ hay không
  void _validatePassword() {
    final password = _passwordController.text.trim(); // Lấy giá trị mật khẩu
    setState(() {
      // Kiểm tra tính hợp lệ của mật khẩu
      _passwordError = password.isEmpty
          ? 'Password cannot be empty' // Nếu mật khẩu trống
          : password.length < 8 || !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(password)
          ? 'Password must be at least 8 characters and include letters and numbers' // Mật khẩu phải có ít nhất 8 ký tự và chứa chữ và số
          : null; // Không có lỗi nếu mật khẩu hợp lệ
    });
  }

  // Hàm validate xác nhận mật khẩu, kiểm tra xem mật khẩu và xác nhận mật khẩu có khớp không
  void _validateConfirmPassword() {
    final password = _passwordController.text.trim(); // Lấy mật khẩu
    final confirmPassword = _confirmPasswordController.text.trim(); // Lấy xác nhận mật khẩu
    setState(() {
      // Kiểm tra tính hợp lệ của xác nhận mật khẩu
      _confirmPasswordError = confirmPassword.isEmpty
          ? 'Please confirm your password' // Nếu trường xác nhận mật khẩu trống
          : confirmPassword != password
          ? 'Passwords do not match' // Nếu mật khẩu và xác nhận mật khẩu không khớp
          : null; // Không có lỗi nếu mật khẩu và xác nhận mật khẩu khớp
    });
  }

  // Hàm validate tên người dùng
  void _validateName() {
    final name = _nameController.text.trim(); // Lấy giá trị tên
    setState(() {
      // Kiểm tra xem tên có trống không
      _nameError = name.isEmpty ? 'Name cannot be empty' : null; // Nếu tên trống thì báo lỗi
    });
  }

  // Hàm validate số điện thoại
  void _validatePhone() {
    final phone = _phoneController.text.trim(); // Lấy giá trị số điện thoại
    setState(() {
      // Kiểm tra xem số điện thoại có trống không
      _phoneError = phone.isEmpty ? 'Phone number cannot be empty' : null; // Nếu số điện thoại trống thì báo lỗi
    });
  }

  // Xử lý đăng ký người dùng
  Future<void> _signup(BuildContext context) async {
    // Kiểm tra tất cả các trường nhập liệu
    _validateEmail();
    _validatePassword();
    _validateConfirmPassword();
    _validateName();
    _validatePhone();

    // Nếu có bất kỳ trường nào không hợp lệ thì dừng lại và không thực hiện đăng ký
    if ([_emailError, _passwordError, _confirmPasswordError, _nameError, _phoneError].any((e) => e != null)) {
      return;
    }

    setState(() => _isLoading = true); // Bật trạng thái loading khi bắt đầu đăng ký

    try {
      final userFactory = UserFactory(); // Tạo đối tượng UserFactory để tạo người dùng mới
      final newUser = userFactory.create({
        'name': _nameController.text.trim(), // Tên người dùng
        'email': _emailController.text.trim(), // Email người dùng
        'password': _passwordController.text.trim(), // Mật khẩu người dùng
        'phone': Formatter.formatPhoneNumber(_phoneController.text.trim()), // Định dạng lại số điện thoại
        'role': 'user', // Gán vai trò mặc định là "user"
      });

      // Thêm người dùng mới vào danh sách người dùng trong provider
      await Provider.of<UserProvider>(context, listen: false).addUser(newUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up successful!')), // Hiển thị thông báo đăng ký thành công
      );
      Navigator.pushReplacementNamed(context, '/login'); // Chuyển đến màn hình đăng nhập
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')), // Hiển thị thông báo lỗi nếu có
      );
    } finally {
      setState(() => _isLoading = false); // Tắt trạng thái loading khi kết thúc đăng ký
    }
  }

  @override
  void dispose() {
    // Giải phóng tài nguyên khi không còn sử dụng (giải phóng các controller và focus node)
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  // Xây dựng trường nhập liệu
  Widget _buildTextField({
    required TextEditingController controller, // Controller để điều khiển trường nhập liệu
    required String label, // Nhãn cho trường nhập liệu
    required TextInputType keyboardType, // Kiểu bàn phím (email, mật khẩu, số điện thoại...)
    FocusNode? focusNode, // FocusNode để theo dõi trạng thái tiêu điểm
    String? errorText, // Lỗi hiển thị nếu có
    bool obscureText = false, // Nếu là trường mật khẩu thì ẩn ký tự
    TextInputAction? textInputAction, // Thực hiện hành động tiếp theo khi người dùng nhấn phím
  }) {
    return TextField(
      controller: controller, // Gắn controller cho trường nhập liệu
      focusNode: focusNode, // Gắn focusNode
      decoration: InputDecoration(
        labelText: label, // Gắn nhãn cho trường nhập liệu
        border: const OutlineInputBorder(), // Viền của trường nhập liệu
        errorText: errorText, // Hiển thị lỗi nếu có
      ),
      keyboardType: keyboardType, // Kiểu bàn phím
      obscureText: obscureText, // Mật khẩu ẩn đi nếu cần
      textInputAction: textInputAction, // Hành động tiếp theo khi nhấn phím
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')), // Tiêu đề màn hình
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Các trường nhập liệu cho tên, email, số điện thoại, mật khẩu, xác nhận mật khẩu
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              keyboardType: TextInputType.text,
              focusNode: _nameFocusNode,
              errorText: _nameError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocusNode,
              errorText: _emailError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
              focusNode: _phoneFocusNode,
              errorText: _phoneError,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _passwordController,
              label: 'Password',
              keyboardType: TextInputType.text,
              focusNode: _passwordFocusNode,
              errorText: _passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              keyboardType: TextInputType.text,
              focusNode: _confirmPasswordFocusNode,
              errorText: _confirmPasswordError,
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _signup(context), // Nếu đang loading thì không cho nhấn
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 18.0)),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white) // Hiển thị loading nếu đang đăng ký
                    : const Text('Sign Up', style: TextStyle(fontSize: 16)), // Hiển thị chữ "Sign Up"
              ),
            ),
            const SizedBox(height: 20),
            _buildTermsAndPolicy(), // Điều khoản và chính sách
            const SizedBox(height: 20),
            _buildLoginLink(), // Liên kết tới màn hình đăng nhập
          ],
        ),
      ),
    );
  }

  // Điều khoản và Chính sách
  Widget _buildTermsAndPolicy() {
    return Column(
      children: const [
        Text(
          'By signing up, you agree to receive updates and special offers. You can unsubscribe at any time.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: null, child: Text('Terms of Service')), // Nút điều khoản dịch vụ
            Text('|'),
            TextButton(onPressed: null, child: Text('Privacy Policy')), // Nút chính sách bảo mật
          ],
        ),
      ],
    );
  }

  // Liên kết chuyển đến Đăng nhập
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? '), // Thông báo đã có tài khoản
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/login'), // Chuyển tới màn hình đăng nhập
          child: const Text('Log in'), // Nút đăng nhập
        ),
      ],
    );
  }
}
