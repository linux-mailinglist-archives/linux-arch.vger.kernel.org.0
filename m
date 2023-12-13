Return-Path: <linux-arch+bounces-965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50646810B37
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DDAB21191
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E6182AF;
	Wed, 13 Dec 2023 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmSn69fX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72AD11A
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-551d5cd1c42so8696a12.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702451627; x=1703056427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iUue6YNBQOXUYoa1LCRV4yEKDTNBr+pgLw1FEW28smM=;
        b=gmSn69fXejh4u4/SvnZ09MVi5FTYr/lwXWaNpbR14C5Wa0+0BkUdp5zYmCx6MKBsxU
         dSiJAFVYOrbZku9Pge29i/e4TFjrYNg13j+uP9kC8NIDKx+ukCf+YQlGeVHsqpSu2Wq+
         bvk9n8NERgZgiy1zyss4VVR8fsAw2bXkwCwjLgqoFNY/pBn2r5CcDXJ7wBRd2ZC3C47J
         txsMt1e4IkVJ526lkkH62G0HcnONxx1789AsbtnAHEs+q+p4OsdQJNowAmTDwKbVtmxE
         34DGPecELuYDqO7oLtMnw6pdjiCEww534Okyp5XJxPrPFmJilhWqqEbOn3Ysc/yX1Xs0
         uR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451627; x=1703056427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUue6YNBQOXUYoa1LCRV4yEKDTNBr+pgLw1FEW28smM=;
        b=aptVUVCM+tx52KNOuT5fheVzLNdMcBPxqVxrk396Nx1Z9upY+qIUW7Y75jSFo3lZBs
         H+hyRLxQFLv/Mfaqqj5TJeF/C25tHhWa0qI9P9BfZq2OvbMX9rdsKtnl3tZmJOlAXUmn
         Vh0Hqy36o6m6Zf38lB1Bkmtui5AXT3oXAs6mgG33aXEHOprXKHGULFB8yO9H6hZcszqu
         PW2sPZ0br5lXvp7Z13oY+pZm+lB6TzjrWz6CXluY75rpFNM67NNCSF8/RQ6ffE6bPPjr
         L+pw7r0YHWxI3ZAW1SR1QPB2KNWhEsDv4zbuzidJTY3RqdXWJS2hs6f2l+amXxBOFfhs
         JnSQ==
X-Gm-Message-State: AOJu0YyX0xf8yFOnOgdAber1NoNaFAl3W+Z2IMQ7/91+3pz4ghD4pPFv
	6Yh/K/wREGW+76qfysJFhXbtQbbMIoxPDfueJKFjSg==
X-Google-Smtp-Source: AGHT+IEFaZ0qHoom+HM+E0woEYOJYz22khOAe/sgkZjS6y2gXHTQknIH42LzGWy5AHp3YfUi6mz7x/RkQ5J7hFPu1e4=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr447876edj.0.1702451626993; Tue, 12 Dec
 2023 23:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com> <20231213010201.1802507-6-rmoar@google.com>
In-Reply-To: <20231213010201.1802507-6-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Dec 2023 15:13:35 +0800
Message-ID: <CABVgOS=HsVKyjQYouv8Y8vABQCsZe-+24qZbAaHMYCfzBADrmQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Documentation: Add debugfs docs with run after boot
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007df768060c5ee857"

--0000000000007df768060c5ee857
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 09:02, Rae Moar <rmoar@google.com> wrote:
>
> Expand the documentation on the KUnit debugfs filesystem on the
> run_manual.rst page.
>
> Add section describing how to access results using debugfs.
>
> Add section describing how to run tests after boot using debugfs.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Looks good!

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


> Changes since v3:
> - Change the introduction of the debugfs section
> - Add detail to not being able to run concurrently or run with init data
>
>  Documentation/dev-tools/kunit/run_manual.rst | 51 ++++++++++++++++++--
>  1 file changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
> index e7b46421f247..699d92885075 100644
> --- a/Documentation/dev-tools/kunit/run_manual.rst
> +++ b/Documentation/dev-tools/kunit/run_manual.rst
> @@ -49,9 +49,52 @@ loaded.
>
>  The results will appear in TAP format in ``dmesg``.
>
> +debugfs
> +=======
> +
> +KUnit can be accessed from userspace via the debugfs filesystem (See more
> +information about debugfs at Documentation/filesystems/debugfs.rst).
> +
> +If ``CONFIG_KUNIT_DEBUGFS`` is enabled, the KUnit debugfs filesystem is
> +mounted at /sys/kernel/debug/kunit. You can use this filesystem to perform
> +the following actions.
> +
> +Retrieve Test Results
> +=====================
> +
> +You can use debugfs to retrieve KUnit test results. The test results are
> +accessible from the debugfs filesystem in the following read-only file:
> +
> +.. code-block :: bash
> +
> +       /sys/kernel/debug/kunit/<test_suite>/results
> +
> +The test results are printed in a KTAP document. Note this document is separate
> +to the kernel log and thus, may have different test suite numbering.
> +
> +Run Tests After Kernel Has Booted
> +=================================
> +
> +You can use the debugfs filesystem to trigger built-in tests to run after
> +boot. To run the test suite, you can use the following command to write to
> +the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
> +
> +.. code-block :: bash
> +
> +       echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
> +
> +As a result, the test suite runs and the results are printed to the kernel
> +log.
> +
> +However, this feature is not available with KUnit suites that use init data,
> +because init data may have been discarded after the kernel boots. KUnit
> +suites that use init data should be defined using the
> +kunit_test_init_section_suites() macro.
> +
> +Also, you cannot use this feature to run tests concurrently. Instead a test
> +will wait to run until other tests have completed or failed.
> +
>  .. note ::
>
> -       If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
> -       be accessible from the ``debugfs`` filesystem (if mounted).
> -       They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
> -       TAP format.
> +       For test authors, to use this feature, tests will need to correctly initialise
> +       and/or clean up any data, so the test runs correctly a second time.
> --
> 2.43.0.472.g3155946c3a-goog
>

--0000000000007df768060c5ee857
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAy
FfSSbjrNAzwWwPrVZE6PjSTBMbr1KwB1ZReT3w6LyTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTMwNzEzNDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAM5IYKhUPOe9am8sS5R5i
06Q8rSuhNv+FZ5FzipTBVTjAgJoRPDsAiR9fPcGeGBzAj/0iIssJJ5iD2PEmqCPivcga+AxAXFtP
KPDEhh5YluhYoskbvXBEKtaLeJHKS+2LlNvKWwflShfXUHFplK5mA+USppAgv/alJ0VoZAaSn7iT
6lTmb7NYmK6OO4ktmFM6VQMvfCNST29gBOj+fMloeAnvyGkgp5WE9SX1CkDTj39YjqsWCBXk99zo
hx9KZ3DOlyBk90Nfdj00T0iEHleKIMm7Ndm52HZljzf2h4SgBs+Xn6R6Vt1VT/MV/ymtv966z37c
2B/o6Up9fxzhtScmeQ==
--0000000000007df768060c5ee857--

