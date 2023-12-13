Return-Path: <linux-arch+bounces-964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE842810B35
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4021F21556
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D81803D;
	Wed, 13 Dec 2023 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QaU+RcJE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7BF5
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso5694a12.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 23:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702451624; x=1703056424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBfa9Z8H7nKDvL+Q/cmkmfpi5oxWSsNkSfVGi6ziUaw=;
        b=QaU+RcJExGYDLaGIUykgsvKkXotZih47Op1GiwdDcWozMdeIJVJAombpHpeCqcQd5S
         fwYPSkjp79nJEcQdA4N4JtcW76zfaZJhfM6cn7vwjImv+2QTOKyPOX47h0C/buIp3MGk
         soskq22+DmVBwkOyZVzJlc947xMGSCuxWyzrPj3616dUqMOiX788qfHbnP4yJmKzjC0/
         3kgLO0bRVYTKQOsQoCjv7Wh1xaf3UkAAb9A8PP+hHememm2EgzdYh8eZkNALA5CBGNhU
         +ouWkyVqqYx74Wm6QuKjnxJIx11SJlMzGg/zPk3QqvRdX3dS06QXYsgNhhVnWdJHYXCd
         CgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451624; x=1703056424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBfa9Z8H7nKDvL+Q/cmkmfpi5oxWSsNkSfVGi6ziUaw=;
        b=TOOopqr2+XyzIy8q+X7lBs/R0g/gy15c3zB+XpX1edTBYTjsMCfpt56pmhyySNzMw6
         XOjHxYaTLQ0M/FnUcB91xTJ2AASwtF1uKD6snq7sZ6Obcv7SLyx/7tBStvEeX3qyJpBm
         tXZ6zBfftEZxVvhpb6aor8blUZkS7qev8oqMeZNmLfOlXGwfFB1YVQeIJFuqUtCU+reV
         kuREXfnLPcszhhMnWE0ABk7YAKKtE/Suzh/r1dza+at6VmE7y6IL/ujKJLbpYwcAukTE
         sh3qX9EyVs+ctlmD1yTX1T+WiVwyzkc8mSGP5mEsW+5qF044sIKI2RSrBDPA4d+Vcris
         XlQg==
X-Gm-Message-State: AOJu0Yy4SpK/MeWm8tbyi6/2PbUWATBKO/ZW7PZa+yR7m7yNdSrnfSvf
	zEfSdZ1AK0T+AbY52qGgcWJUcd9gX426hJMHW6EK6/cu8CKjphcu/3Q=
X-Google-Smtp-Source: AGHT+IHxpTwQpG3HgdXAIhBDyVbzzp8i+mKxp6Pu6W2BugqmRWi/TnNMe9nTqqu7mi06fny29LpHh5sx8+BUxysVv1c=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr447875edj.0.1702451623564; Tue, 12 Dec
 2023 23:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com> <20231213010201.1802507-5-rmoar@google.com>
In-Reply-To: <20231213010201.1802507-5-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Dec 2023 15:13:32 +0800
Message-ID: <CABVgOSkRJaK9m4hiLC_BN00r73vPGmsVvjnKvk_RqMTBkrF0mQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] kunit: add ability to run tests after boot using debugfs
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004bf80c060c5ee860"

--0000000000004bf80c060c5ee860
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 09:02, Rae Moar <rmoar@google.com> wrote:
>
> Add functionality to run built-in tests after boot by writing to a
> debugfs file.
>
> Add a new debugfs file labeled "run" for each test suite to use for
> this purpose.
>
> As an example, write to the file using the following:
>
> echo "any string" > /sys/kernel/debugfs/kunit/<testsuite>/run
>
> This will trigger the test suite to run and will print results to the
> kernel log.
>
> To guard against running tests concurrently with this feature, add a
> mutex lock around running kunit. This supports the current practice of
> not allowing tests to be run concurrently on the same kernel.
>
> This new functionality could be used to design a parameter
> injection feature in the future.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Excellent! Thanks for rebasing it!

This still works fine here, and looks good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> Changes since v4:
> - Rebased series causing a few small changes in debugfs.c in this patch
>
>  lib/kunit/debugfs.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c    | 10 +++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 382706dfb47d..d548750a325a 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -8,12 +8,14 @@
>  #include <linux/module.h>
>
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>
>  #include "string-stream.h"
>  #include "debugfs.h"
>
>  #define KUNIT_DEBUGFS_ROOT             "kunit"
>  #define KUNIT_DEBUGFS_RESULTS          "results"
> +#define KUNIT_DEBUGFS_RUN              "run"
>
>  /*
>   * Create a debugfs representation of test suites:
> @@ -21,6 +23,8 @@
>   * Path                                                Semantics
>   * /sys/kernel/debug/kunit/<testsuite>/results Show results of last run for
>   *                                             testsuite
> + * /sys/kernel/debug/kunit/<testsuite>/run     Write to this file to trigger
> + *                                             testsuite to run
>   *
>   */
>
> @@ -101,6 +105,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
>         return single_open(file, debugfs_print_results, suite);
>  }
>
> +/*
> + * Print a usage message to the debugfs "run" file
> + * (/sys/kernel/debug/kunit/<testsuite>/run) if opened.
> + */
> +static int debugfs_print_run(struct seq_file *seq, void *v)
> +{
> +       struct kunit_suite *suite = (struct kunit_suite *)seq->private;
> +
> +       seq_puts(seq, "Write to this file to trigger the test suite to run.\n");
> +       seq_printf(seq, "usage: echo \"any string\" > /sys/kernel/debugfs/kunit/%s/run\n",
> +                       suite->name);
> +       return 0;
> +}
> +
> +/*
> + * The debugfs "run" file (/sys/kernel/debug/kunit/<testsuite>/run)
> + * contains no information. Write to the file to trigger the test suite
> + * to run.
> + */
> +static int debugfs_run_open(struct inode *inode, struct file *file)
> +{
> +       struct kunit_suite *suite;
> +
> +       suite = (struct kunit_suite *)inode->i_private;
> +
> +       return single_open(file, debugfs_print_run, suite);
> +}
> +
> +/*
> + * Trigger a test suite to run by writing to the suite's "run" debugfs
> + * file found at: /sys/kernel/debug/kunit/<testsuite>/run
> + *
> + * Note: what is written to this file will not be saved.
> + */
> +static ssize_t debugfs_run(struct file *file,
> +               const char __user *buf, size_t count, loff_t *ppos)
> +{
> +       struct inode *f_inode = file->f_inode;
> +       struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
> +
> +       __kunit_test_suites_init(&suite, 1);
> +
> +       return count;
> +}
> +
>  static const struct file_operations debugfs_results_fops = {
>         .open = debugfs_results_open,
>         .read = seq_read,
> @@ -108,11 +157,23 @@ static const struct file_operations debugfs_results_fops = {
>         .release = debugfs_release,
>  };
>
> +static const struct file_operations debugfs_run_fops = {
> +       .open = debugfs_run_open,
> +       .read = seq_read,
> +       .write = debugfs_run,
> +       .llseek = seq_lseek,
> +       .release = debugfs_release,
> +};
> +
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>         struct kunit_case *test_case;
>         struct string_stream *stream;
>
> +       /* If suite log already allocated, do not create new debugfs files. */
> +       if (suite->log)
> +               return;
> +
>         /*
>          * Allocate logs before creating debugfs representation.
>          * The suite->log and test_case->log pointer are expected to be NULL
> @@ -140,6 +201,13 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
>         debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>                             suite->debugfs,
>                             suite, &debugfs_results_fops);
> +
> +       /* Do not create file to re-run test if test runs on init */
> +       if (!suite->is_init) {
> +               debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
> +                                   suite->debugfs,
> +                                   suite, &debugfs_run_fops);
> +       }
>         return;
>
>  err:
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 6c082911a85f..a52fcb9a4457 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>  #include <linux/panic.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> @@ -22,6 +23,8 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>
> +static DEFINE_MUTEX(kunit_run_lock);
> +
>  /*
>   * Hook to fail the current test and print an error message to the log.
>   */
> @@ -654,6 +657,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
>         kunit_debugfs_create_suite(suite);
>         suite->status_comment[0] = '\0';
>         suite->suite_init_err = 0;
> +       string_stream_clear(suite->log);
>  }
>
>  bool kunit_enabled(void)
> @@ -670,6 +674,11 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>                 return 0;
>         }
>
> +       /* Use mutex lock to guard against running tests concurrently. */
> +       if (mutex_lock_interruptible(&kunit_run_lock)) {
> +               pr_err("kunit: test interrupted\n");
> +               return -EINTR;
> +       }
>         static_branch_inc(&kunit_running);
>
>         for (i = 0; i < num_suites; i++) {
> @@ -678,6 +687,7 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>         }
>
>         static_branch_dec(&kunit_running);
> +       mutex_unlock(&kunit_run_lock);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
> --
> 2.43.0.472.g3155946c3a-goog
>

--0000000000004bf80c060c5ee860
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAa
KwW9B8mC1N0LR1H7r33xL0ebFJHYxck95D4oSm7RgjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTMwNzEzNDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALcx1FKNYR8sPdJkaWzy9
aOdI169denzwSWep7qEo6OTGEKWaqEvJUzSWa+CTApQ+SpkbMM42cHH1x75Uhqf/Y25Xm533r6B3
gpJ0+1tf9juOBnhfcV7tQzRggKZ6m1Cdx3hRO/ImdOj619xaHGezgq43qqDPFDIJRgBzxq1UfBGk
HmSIoHW2km5F1ev66oKfwWnKEQF795eQF4NM0bQrB6q9tQUNXrW5PgO1naCvOBufcfpyMzpxXgyd
CeaS3hKT9MbjWiCy7zTrhZO2PXpb662XjUvgG11J4H3f6fyuiiN66SWW++/waN8YK+l1vKpX6TSg
qUTxoigLg8JXaov/jA==
--0000000000004bf80c060c5ee860--

