Return-Path: <linux-arch+bounces-963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB0810B2F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE2B211CD
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8117742;
	Wed, 13 Dec 2023 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDvBbcCw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE1BD
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so28915e9.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702451620; x=1703056420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzzHrEMhtT2RZd2aM/KwJ5VtUMWOUKsF7i25T23WYFs=;
        b=iDvBbcCwaDpBI0LIFprKfj6KcqInTXiPwxyvV+44UVjbbOuqDeTlSBAXCtskQwSWOA
         P+wg4BuXBz6oc8k9lel96UFNytJ/+mEJ6bdlO/3c/D+uJQrNPcI1I/is09bUXKajV1nO
         DT4XNZNbdoFVxGBlxR8dohVo9KiAbG1MyFFDdqOHR7/AfFxDtZKS/74wKol+w/Scc7NN
         iO16M/VWxntaL2w+pvdQKvKk8ZdmOigCApOToQp61zIhSLE5Ewu/3S9DzqvzSNS40PvO
         ENJgovE9s6YcAS/Byn9kiJKBVGyXc9Qh8cA4+MDZ9B4sw4PA3cBlKHBR2nvMHQR5xn4x
         levQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451620; x=1703056420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzzHrEMhtT2RZd2aM/KwJ5VtUMWOUKsF7i25T23WYFs=;
        b=iI+thktralEQ8njHuGQhgC5ByQ+hXYs+WvRsFWeYAu9zP4GWkJgD1P6Y4mfI4/inQX
         6Zfb0Rn0JorW/GPG0UCP2Vo3stDlE5hJRWBlK/IoGAJGn/0b0W18ASACgwdrRRVXLMlg
         N7QcVJSA4j7ylMKS4GH9QT/AsMPB4h+wblPDsYKbFSjNR7gCVmeHquQGQkLE6Note3i6
         +tda1CPR7MO8VgwsX0XM9VTCl8UbLkn/O4e3jO/02218j9tD7lYY1JGVd/8cgMRozdEz
         sRYf//u2a6VltTeUFZ7EvpzSR10pq8zEoThymXV7xyS1mDPGalFWl1ftyRE+GQ14hfgl
         tYyQ==
X-Gm-Message-State: AOJu0YyNL+oGMLPJNIG0ilPzmSbxikOs8PjMFyLiJ9NX0uL067hNj1Te
	iplhG8CZ8kamsnvA7/YAJX7lh9vhPmkH4y1N/4RwFQ==
X-Google-Smtp-Source: AGHT+IH6cU5yT26gEL4w70saIePwUBz+6dg6SpOhlVQVZUMH76+ZwhwaEdN1X6LuGQCHhTjRLohRAHouh26eGjRXkYk=
X-Received: by 2002:a05:600c:3b20:b0:40c:1e46:508e with SMTP id
 m32-20020a05600c3b2000b0040c1e46508emr399018wms.0.1702451620401; Tue, 12 Dec
 2023 23:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com> <20231213010201.1802507-4-rmoar@google.com>
In-Reply-To: <20231213010201.1802507-4-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Dec 2023 15:13:29 +0800
Message-ID: <CABVgOS=7cGp6M1dwPFPk8TYFj3=teFhVc55dKQMED2rNmO3Rfw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] kunit: add is_init test attribute
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000019a161060c5ee8b2"

--00000000000019a161060c5ee8b2
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 09:02, Rae Moar <rmoar@google.com> wrote:
>
> Add is_init test attribute of type bool. Add to_string, get, and filter
> methods to lib/kunit/attributes.c.
>
> Mark each of the tests in the init section with the is_init=true attribute.
>
> Add is_init to the attributes documentation.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This looks much better, thanks.

Maybe in the future, we'll want to collate several suite-level
attributes (in a suite_attributes struct or a bitfield), but I think
that should wait until after we have more examples.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Changes since v3:
> - Move the attribute from kunit_attributes to a suite field.
>
>  .../dev-tools/kunit/running_tips.rst          |  7 +++
>  include/kunit/test.h                          |  1 +
>  lib/kunit/attributes.c                        | 60 +++++++++++++++++++
>  lib/kunit/executor.c                          |  6 +-
>  4 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 766f9cdea0fa..024e9ad1d1e9 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -428,3 +428,10 @@ This attribute indicates the name of the module associated with the test.
>
>  This attribute is automatically saved as a string and is printed for each suite.
>  Tests can also be filtered using this attribute.
> +
> +``is_init``
> +
> +This attribute indicates whether the test uses init data or functions.
> +
> +This attribute is automatically saved as a boolean and tests can also be
> +filtered using this attribute.
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index fe79cd736e94..b163b9984b33 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -253,6 +253,7 @@ struct kunit_suite {
>         struct dentry *debugfs;
>         struct string_stream *log;
>         int suite_init_err;
> +       bool is_init;
>  };
>
>  /* Stores an array of suites, end points one past the end */
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index 1b512f7e1838..2cf04cc09372 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -58,6 +58,16 @@ static const char *attr_enum_to_string(void *attr, const char * const str_list[]
>         return str_list[val];
>  }
>
> +static const char *attr_bool_to_string(void *attr, bool *to_free)
> +{
> +       bool val = (bool)attr;
> +
> +       *to_free = false;
> +       if (val)
> +               return "true";
> +       return "false";
> +}
> +
>  static const char *attr_speed_to_string(void *attr, bool *to_free)
>  {
>         return attr_enum_to_string(attr, speed_str_list, to_free);
> @@ -166,6 +176,37 @@ static int attr_string_filter(void *attr, const char *input, int *err)
>         return false;
>  }
>
> +static int attr_bool_filter(void *attr, const char *input, int *err)
> +{
> +       int i, input_int = -1;
> +       long val = (long)attr;
> +       const char *input_str = NULL;
> +
> +       for (i = 0; input[i]; i++) {
> +               if (!strchr(op_list, input[i])) {
> +                       input_str = input + i;
> +                       break;
> +               }
> +       }
> +
> +       if (!input_str) {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: filter value not found: %s\n", input);
> +               return false;
> +       }
> +
> +       if (!strcmp(input_str, "true"))
> +               input_int = (int)true;
> +       else if (!strcmp(input_str, "false"))
> +               input_int = (int)false;
> +       else {
> +               *err = -EINVAL;
> +               pr_err("kunit executor: invalid filter input: %s\n", input);
> +               return false;
> +       }
> +
> +       return int_filter(val, input, input_int, err);
> +}
>
>  /* Get Attribute Methods */
>
> @@ -194,6 +235,17 @@ static void *attr_module_get(void *test_or_suite, bool is_test)
>                 return (void *) "";
>  }
>
> +static void *attr_is_init_get(void *test_or_suite, bool is_test)
> +{
> +       struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> +       struct kunit_case *test = is_test ? test_or_suite : NULL;
> +
> +       if (test)
> +               return ((void *) NULL);
> +       else
> +               return ((void *) suite->is_init);
> +}
> +
>  /* List of all Test Attributes */
>
>  static struct kunit_attr kunit_attr_list[] = {
> @@ -212,6 +264,14 @@ static struct kunit_attr kunit_attr_list[] = {
>                 .filter = attr_string_filter,
>                 .attr_default = (void *)"",
>                 .print = PRINT_SUITE,
> +       },
> +       {
> +               .name = "is_init",
> +               .get_attr = attr_is_init_get,
> +               .to_string = attr_bool_to_string,
> +               .filter = attr_bool_filter,
> +               .attr_default = (void *)false,
> +               .print = PRINT_SUITE,
>         }
>  };
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 847329c51e91..717b9599036b 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -300,6 +300,7 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
>         struct kunit_suite_set total_suite_set = {NULL, NULL};
>         struct kunit_suite **total_suite_start = NULL;
>         size_t init_num_suites, num_suites, suite_size;
> +       int i = 0;
>
>         init_num_suites = init_suite_set.end - init_suite_set.start;
>         num_suites = suite_set.end - suite_set.start;
> @@ -310,8 +311,11 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
>         if (!total_suite_start)
>                 return total_suite_set;
>
> -       /* Append init suites and then all other kunit suites */
> +       /* Append and mark init suites and then append all other kunit suites */
>         memcpy(total_suite_start, init_suite_set.start, init_num_suites * suite_size);
> +       for (i = 0; i < init_num_suites; i++)
> +               total_suite_start[i]->is_init = true;
> +
>         memcpy(total_suite_start + init_num_suites, suite_set.start, num_suites * suite_size);
>
>         /* Set kunit suite set start and end */
> --
> 2.43.0.472.g3155946c3a-goog
>

--00000000000019a161060c5ee8b2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDg
tlnHncXMImskPFESUda26iwnUkiq4M9XHSUd95bwZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTMwNzEzNDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANMPkzxQqBN/vpJc/m361
WIJSIuorH6+XtbcWQqgJEnZ3YCD1ACy35PttmId1wmzcqzDjkpCIUDPHFUi6Azedoi38Hh35JAcM
TJXwgUK1yg55ki8Ch19dkmWiS4rvrhp4N9mMNsJALlGs2pm3NdjRSnbu+eJCDnSyPQSd8lfkLjxw
wrR700u0dWBwb69zd2CaerSBKvfCHqL9VRhnOoIIXrMSqcYBqNheq8j27AikJFSF6F5jaBWe/Ir5
StiUMSFH7/iA92kr80iyG1CgLVxjrerb6oTBz0MG6is564u3GuYHbayQT9R8YYMxYO1VzueIr5Zj
DvqoRc97EJGwx6JSqA==
--00000000000019a161060c5ee8b2--

