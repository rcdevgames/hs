import 'package:flutter/material.dart';
import 'package:housesolutions/view/auth/forgot_password_page.dart';
import 'package:housesolutions/view/auth/login_page.dart';
import 'package:housesolutions/view/auth/register_page.dart';
import 'package:housesolutions/view/auth/term_and_conditions_page.dart';
import 'package:housesolutions/view/complaints/complaint_detail_page.dart';
import 'package:housesolutions/view/complaints/complaint_form_page.dart';
import 'package:housesolutions/view/complaints/complaint_list_page.dart';
import 'package:housesolutions/view/home/layout.dart';
import 'package:housesolutions/view/job_inform/job_detail_page.dart';
import 'package:housesolutions/view/job_inform/job_form_page.dart';
import 'package:housesolutions/view/job_inform/job_list_page.dart';
import 'package:housesolutions/view/news/detail_news_page.dart';
import 'package:housesolutions/view/news/list_news_page.dart';
import 'package:housesolutions/view/order/order_preview_page.dart';
import 'package:housesolutions/view/order/order_status_midtrans.dart';
import 'package:housesolutions/view/product/detail/product_about_page.dart';
import 'package:housesolutions/view/product/detail/product_certified_page.dart';
import 'package:housesolutions/view/product/detail/product_more_page.dart';
import 'package:housesolutions/view/product/detail/product_other_page.dart';
import 'package:housesolutions/view/promote/detail_promote_page.dart';
import 'package:housesolutions/view/notifications/notifications_page.dart';
import 'package:housesolutions/view/order/invoice_page.dart';
import 'package:housesolutions/view/order/loading_payment_page.dart';
import 'package:housesolutions/view/order/order_confirmation_page.dart';
import 'package:housesolutions/view/order/order_detail_page.dart';
import 'package:housesolutions/view/order/payment_midtrans_page.dart';
import 'package:housesolutions/view/order/payment_transfer_page.dart';
import 'package:housesolutions/view/product/product_category_page.dart';
import 'package:housesolutions/view/product/product_filter_page.dart';
import 'package:housesolutions/view/promote/list_promote_page.dart';
import 'package:housesolutions/view/user/change_lang_page.dart';
import 'package:housesolutions/view/user/change_password_page.dart';
import 'package:housesolutions/view/user/contact_us_page.dart';
import 'package:housesolutions/view/user/user_agreement_page.dart';
import 'package:housesolutions/view/user/user_edit_page.dart';
import 'package:housesolutions/view/user/user_settings_page.dart';
import 'package:housesolutions/view/welcome/select_lang_page.dart';
import 'package:housesolutions/view/welcome/welcome_page.dart';
import 'package:housesolutions/view/worker/detail/worker_about_page.dart';
import 'package:housesolutions/view/worker/detail/worker_certified_page.dart';
import 'package:housesolutions/view/worker/detail/worker_more_page.dart';
import 'package:housesolutions/view/worker/detail/worker_other_page.dart';
import 'package:housesolutions/view/worker/detail_own_worker_page.dart';
import 'package:housesolutions/view/worker/request_change_worker_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Initialize Page
      case "/init-lang": return MaterialPageRoute(builder: (_) => SelectLangPage());
      case "/welcome": return MaterialPageRoute(builder: (_) => WelcomePage());
      
      // Auth Page
      case "/login": return MaterialPageRoute(builder: (_) => LoginPage());
      case "/register": return MaterialPageRoute(builder: (_) => RegisterPage());
      case "/tnc": return MaterialPageRoute(builder: (_) => TermsAndConditionPage());
      case "/forgot-password": return MaterialPageRoute(builder: (_) => ForgotPasswordPage());

      // Main Page
      case "/main": return MaterialPageRoute(builder: (_) => LayoutPage());

      // Promote Page
      case "/promote-list": return MaterialPageRoute(builder: (_) => PromoteListPage());
      case "/promote-detail": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PromoteDetailPage(args));

      // News Page
      case "/news-list": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ListNewsPage(args));
      case "/news-detail": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => NewsDetailPage(args));
      

      // Notification Page
      case "/notification": return MaterialPageRoute(builder: (_) => NotificationsPage());

      // Product Page
      case "/product-category":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductCategoryPage(args));
      case "/product-filter": return MaterialPageRoute(builder: (_) => ProductFilterPage());
      case "/product-more":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductMorePage(args));
      case "/product-about":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductAboutPage(args));
      case "/product-certified":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductCertifiedPage(args));
      case "/product-other":
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductOtherPage(args[0], args[1]));

      // Order Page
      case "/confirm-order": 
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ConfirmationOrder(args[0], args[1]));
      case "/process-payment": return MaterialPageRoute(builder: (_) => LoadingPayment());
      case "/preview": 
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PreviewImageApprovalPage(args[0], args[1]));
      case "/detail-order": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => OrderDetailPage(args));
      case "/dopay-manual": 
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PaymentManualPage(args[0], args[1]));
      case "/dopay-midtrans": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PaymentMidtransPage());
      case "/pay-midtrans-status": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => OrderStatusMidtransPage(args));
      case "/invoice": 
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => InvoicePDF(args[0], args[1]));

      // Worker
      case "/myworker-detail": 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => DetailOwnWorkerPage(args));
      case "/change-worker": return MaterialPageRoute(builder: (_) => RequestChangeWorkerPage());
      case "/worker-more":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => WorkerMorePage(args));
      case "/worker-about":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => WorkerAboutPage(args));
      case "/worker-certified":
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => WorkerCertifiedPage(args));
      case "/worker-other":
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => WorkerOtherPage(args[0], args[1]));


      // UserPage
      case "/user-edit": return MaterialPageRoute(builder: (_) => UpdateUserPage());
      case "/change-password": return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      case "/settings": return MaterialPageRoute(builder: (_) => UserSettingsPage());
      case "/contact-us": return MaterialPageRoute(builder: (_) => ContactUsPage());
      case "/change-lang": return MaterialPageRoute(builder: (_) => ChangeLanguagePage());
      case "/agreement-page": return MaterialPageRoute(builder: (_) => UserAgreementPage());

      // Complaint
      case '/complaint': return MaterialPageRoute(builder: (_) => new ComplaintListPage());
      case '/complaint-detail': 
        List args = settings.arguments;
        return MaterialPageRoute(builder: (_) => new ComplaintDetailPage(args[0], args[1]));
      case '/complaint-form': return MaterialPageRoute(builder: (_) => new ComplaintFormPage());

      // Job
      case '/job-list': return MaterialPageRoute(builder: (_) => new JobListPage());
      case '/job-form': return MaterialPageRoute(builder: (_) => new JobFormPage());
      case '/job-detail': 
        var args = settings.arguments;
        return MaterialPageRoute(builder: (_) => new JobDetailPage(args));

        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')
            )
          )
        );
    }
  }
}