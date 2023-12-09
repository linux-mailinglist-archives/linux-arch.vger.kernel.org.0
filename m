Return-Path: <linux-arch+bounces-857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AEF80B2EF
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 08:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973472810DF
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CE63C0;
	Sat,  9 Dec 2023 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykQF/Cjw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F81734
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 23:58:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5091a12.0
        for <linux-arch@vger.kernel.org>; Fri, 08 Dec 2023 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702108691; x=1702713491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYQiRxibmAisBQaHy2PamDGjYBQLtdyBlcWDWoiMlE0=;
        b=ykQF/CjwcprPzeph8CanTen7Jnlo+arlqsAWjGLkaXIidu5rTjRMJNZCbFB8qYvlaZ
         WFyGGHhZtd6A76J89hb4MmD8sHKo2ijYmxTopTiZbuskQ5oQJi2udmygM089oXhig4TG
         MLnDQ3G59/cIfS3hjQkQfylFq8ate3g0XYbIjPm1jxyZBJ6b64nC8lYUN5oFlaa50sRN
         kxgcf7et2CCzpw5QzFPdp3t6RiIuHO1e1DPfM19N8t63k/bd0APs+erY9u5JNColNXDg
         o7kmMO/jorwnUWKrthIIxY9FY9BkIHBAS+J4o5wEXPmKIqpObnU1M9JOq0xpbZTWy6je
         Qelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702108691; x=1702713491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYQiRxibmAisBQaHy2PamDGjYBQLtdyBlcWDWoiMlE0=;
        b=ZOSuHM8p2SNIDd63NDGSWdQ0buj26JO4sHqaTRgUcs4Jf298b7PU2Bn5KJDOkBB9F+
         O/tJfPSUO4YVDKdMzyF+2Vfs2XGi7OMLffKXfx7FkPCk2BYloX8Snn1n1j1rBPpHjz2d
         0WI+/FsmB5Lz4Dkwp9soXNktfs90fhkzwQ173gT2SPoDDqPGxe6kjX+fBgMG4orEsLDr
         hYMRZN8LNKRBB0e6KG5wOGf04kOb9OW4QPQBqeA4lARjgkccE1pX1zPTO1IDmJhChG5c
         kmN3zAhsYFDrG6Ssl8giM1j1J1xkHwlaCluwfi+ebl/TYE3YEYnP81JnxYCI1Rji7qAl
         ID4A==
X-Gm-Message-State: AOJu0Yx8CytCnxy5Lxfg+U1wXYlZLD/tGSpqI9pcXIsvMwkJptJ7pMXV
	pvgIkLAnzrCdw4HUj9Z+gVek2gyiujXuezQjusvlpw==
X-Google-Smtp-Source: AGHT+IEKL9zF5wm5Lj36ZP8WRGEwB9yTzC9WZsiOzbvKx5VdXcOOPKK5IveENjlsF9eq51RAbflRbWO4jJPvCT4kLyo=
X-Received: by 2002:a50:c101:0:b0:54b:bf08:a95f with SMTP id
 l1-20020a50c101000000b0054bbf08a95fmr117588edf.6.1702108690751; Fri, 08 Dec
 2023 23:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <20231204221932.1465004-6-rmoar@google.com>
In-Reply-To: <20231204221932.1465004-6-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 9 Dec 2023 15:57:59 +0800
Message-ID: <CABVgOS=JAn49ux6Cg2i1-V_2eNH4Utx_areqg4H1p5xwkT9FMA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] Documentation: Add debugfs docs with run after boot
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e7e475060c0f0f79"

--000000000000e7e475060c0f0f79
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
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

Looks good to me, some nitpicks below.

The other thing I'd really want to add is some documentation on
writing init-section suites, which covers the pitfalls better (as
mentioned in the previous emails). Though that could be a separate
patch if you want to keep this one debugfs-specific.

Otherwise,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes since v2:
> - Add info to documentation about cleaning up data, init tests, and
>   running tests concurrently
>
>  Documentation/dev-tools/kunit/run_manual.rst | 49 ++++++++++++++++++--
>  1 file changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
> index e7b46421f247..aebb52ba9605 100644
> --- a/Documentation/dev-tools/kunit/run_manual.rst
> +++ b/Documentation/dev-tools/kunit/run_manual.rst
> @@ -49,9 +49,50 @@ loaded.
>
>  The results will appear in TAP format in ``dmesg``.
>
> +debugfs
> +=======
> +
> +``debugfs`` is a file system that enables user interaction with the files to
> +make kernel information available to user space (See more information at
> +Documentation/filesystems/debugfs.html)

Nit: reference debugfs.rst here, not debugfs.html -- sphinx ought to
update the link automatically.

Also, maybe we can make this introduction a _little_ bit more
KUnit-specific. I'd personally start by saying that KUnit can be
accessed from userspace via the debugfs filesystem (link), usually
mounted in /sys/kernel/debug/kunit, etc, if CONFIG_KUNIT_DEBUGFS is
enabled.

> +
> +By default, only the root user has access to the debugfs directory.
> +
> +If ``CONFIG_KUNIT_DEBUGFS`` is enabled, you can use KUnit debugfs
> +filesystem to perform the following actions.
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
> +The test results are available in KTAP format.

Do we want to note that this is a separate KTAP document, and so may
have different suite numbering from the dmesg log?

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
> +However, this feature is not available with KUnit tests that use init data.

Let's expand this slightly, and mention that this is because the data
may have already been discarded, and that you can find such tests by
either looking for the kunit_test_init_section_suites() macro or the
is_init attribute.

> +
> +Also, you cannot use this feature to run tests concurrently as there is a
> +mutex lock around running KUnit tests at the same time.
> +

Instead of mentioning the mutex, which is an implementation detail,
just mention that tests will either wait for other tests to complete,
or fail having timed out.




>  .. note ::
>
> -       If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
> -       be accessible from the ``debugfs`` filesystem (if mounted).
> -       They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
> -       TAP format.
> +       For test authors, to use this feature, tests will need to correctly initialise
> +       and/or clean up any data, so the test runs correctly a second time.
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>

--000000000000e7e475060c0f0f79
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDY
P7j7XP7GGe7P/JwRPMWvisWdFIDy69FD9bWU/KXnGzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMDkwNzU4MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACk5Ke+9bL9o3dFFyOl/O
FGIERSqUWf/9gHtf1bWD9n/dsIH+ZR9WPcqtyxbsvZs2maISEEbKkr+2uweyTVyPT6Kz54xmRRL+
sIbJGZeH2BuScaheUlWVtx36rEkegEtqJscfCYJ0akoS+HskQ3KqYVSK5jZdmKZAyEm46UyZ1RrH
JarkI+LCHqsd9CECdjtZm7VZSVLkqm/4pJ+FYUS8QUYsg2Z4kCxgn3qmEY7z2NTLQt4AqBDaQPRT
Ct4Pm1VXRRib2UD6KIgpXHVky6rAWF4wg7fM3oFVJP5bT9uWTHqT46Y6lyoFAK9M4hCZ/ja9If5Y
QszkmaWc6a6uB2En7Q==
--000000000000e7e475060c0f0f79--

