Return-Path: <linux-arch+bounces-1027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C48125B9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 04:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7321F21EAE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A4111D;
	Thu, 14 Dec 2023 03:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gmnv0pd9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAEAD0
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 19:05:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5526993db9fso4691a12.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702523105; x=1703127905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AlBYCAKg//O9sRwSjgPRa0vcB8InuKCTo3CwqlaDNP0=;
        b=Gmnv0pd93tH2Rsr0fHA9TcMbMYEEeDE55fOt90hM0v5TlmdaD3LG1sqbfcENi0tLd7
         bjfa1ONMZR384kOZe2mEJi/7prXV8VnCnH5pN4TE1eDQSuK7MgMdGbLrE9CgBuM6EWXN
         4vymlWwgboQZxm/liWV2ugzrqda5SDcZokrkIfqKDtNyPs3Y8fqW6xxkEYO/TVdfVpCC
         HCaLu9QGslk6zgkPkQ+Oq8g2KOkq6kRQXimsjgpaDeP9ptw9lfX3jGUHdIgJHmuwDnGt
         E+ai07sLOMNDOqmJPDFjrh2/K5F5s3dU3Pxzs/q8PBHvA743R6FAgE6N3F7sZZVImUF4
         daoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523105; x=1703127905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlBYCAKg//O9sRwSjgPRa0vcB8InuKCTo3CwqlaDNP0=;
        b=ocLaE/MWiAA036Gb8xyOgTbnMyhwNh7n/uOG7gA61rhLyUNzrpRzAwZpHL5UzqlMgV
         JvT8pnSlveCOeVYJTUVm1eIsLkV2NaI5B25CsE/RgArZfOIHTOHCdit4UXC5fEPJ8fc6
         +g1ODcURAXvaKkvM3Nyo4uSSfYjmJZe5mgwYprjTagjltUzp3ynCb1TIg/SjaeYd5/ZF
         DU21Kcv824ftVSAfCcW2RlmcIMm9wHQE3ksHe1E8RiFWsjX+j3H+lWi5Mo51S8Z41UYo
         CpUvB+gj00ZM+C7dTeqbkbLlTjdDKyAWOvLes4nD1eyRSkrloT3YbFKx72c005xx88Uh
         kV4w==
X-Gm-Message-State: AOJu0YynGgwp2wgLu43YqN6U29tNCvXLSbLMsXjEmovHm8wnLF6BQOw7
	MvLyLbEoSsTmQ7C29FMHJpjpmk3a+sSsbMri65Obdw==
X-Google-Smtp-Source: AGHT+IGppbMjJWraWWXBqhbwuXXQinv7RYjogPmOjSjNA7t8g6dLDmds5BnMlL8zw/Lhizsi1L+OWpnWzQ+NMt/rDuI=
X-Received: by 2002:a50:d08f:0:b0:552:365c:6960 with SMTP id
 v15-20020a50d08f000000b00552365c6960mr127029edd.2.1702523104665; Wed, 13 Dec
 2023 19:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com> <20231213194421.2031671-3-rmoar@google.com>
In-Reply-To: <20231213194421.2031671-3-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 14 Dec 2023 11:04:52 +0800
Message-ID: <CABVgOSk-6mmHTK4K1FfdEC8pG0HDPAttOxm-ziFJYspDwn_OPA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] kunit: add example suite to test init suites
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e74dcd060c6f8c3e"

--000000000000e74dcd060c6f8c3e
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 03:44, Rae Moar <rmoar@google.com> wrote:
>
> Add example_init_test_suite to allow for testing the feature of running
> test suites marked as init to indicate they use init data and/or
> functions.
>
> This suite should always pass and uses a simple init function.
>
> This suite can also be used to test the is_init attribute introduced in
> the next patch.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks -- this looks better to me.

Reviewed-by: David Gow <davidgow@google.com>

-- David

> Changes since v4:
> - Mark test as __init and then set cases as __refdata to supress modpost
>   warnings
>
>  lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 6bb5c2ef6696..d2f7a3c62c18 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -287,4 +287,41 @@ static struct kunit_suite example_test_suite = {
>   */
>  kunit_test_suites(&example_test_suite);
>
> +static int __init init_add(int x, int y)
> +{
> +       return (x + y);
> +}
> +
> +/*
> + * This test should always pass. Can be used to test init suites.
> + */
> +static void __init example_init_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
> +}
> +
> +/*
> + * The kunit_case struct cannot be marked as __initdata as this will be
> + * used in debugfs to retrieve results after test has run
> + */
> +static struct kunit_case __refdata example_init_test_cases[] = {
> +       KUNIT_CASE(example_init_test),
> +       {}
> +};
> +
> +/*
> + * The kunit_suite struct cannot be marked as __initdata as this will be
> + * used in debugfs to retrieve results after test has run
> + */
> +static struct kunit_suite example_init_test_suite = {
> +       .name = "example_init",
> +       .test_cases = example_init_test_cases,
> +};
> +
> +/*
> + * This registers the test suite and marks the suite as using init data
> + * and/or functions.
> + */
> +kunit_test_init_section_suites(&example_init_test_suite);
> +
>  MODULE_LICENSE("GPL v2");
> --
> 2.43.0.472.g3155946c3a-goog
>

--000000000000e74dcd060c6f8c3e
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6
Aa9GsMwGrFjWpbRbINppmiFGTkepZa4bgdiaVxmx5TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTQwMzA1MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAShnnuJuSnlbDxW8PWc3t
E8OgVWSlLQwDFDyC7Vxv3I0Wjij8GrmXyT1GayZgtifQjuv3uFVljzg57G0GbFGxLwrVHjMPzXb5
UtghR6WCe8KeHSi1me0SgimMMDrSav2qtYVvxS0ciKmG13owi7ZF80ZBbgRIphloCU8wSHsdA7O9
lVkWSbCWNJ6ywCYVxAIKS7DV2v1466Y4wghwhzXIYO6Cv1XzRh1bxwvId/EUTJq0GqW4mTWrl00v
hK8SWvcmUYgVnTTYud0lzWkWGEkutI5l2fsyDyT4+ZfhBb8THMTu3pDz3vFU2xP3+sig0AHYoGqu
SUvbCP5GAy82oFc6eA==
--000000000000e74dcd060c6f8c3e--

