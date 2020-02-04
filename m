Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C88152253
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2020 23:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBDW1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Feb 2020 17:27:15 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34880 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBDW1P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 17:27:15 -0500
Received: by mail-yw1-f65.google.com with SMTP id i190so482584ywc.2;
        Tue, 04 Feb 2020 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qlf9lXYabruIPe7BY1Co9J9v9aB5hsqm1QaXhz8x6vk=;
        b=RbyTv0k8Xr6WorAmAQb7L4q5vAOsjMKznfV4looZQtyEYh+Xjq11BOSdKOb5WmkqDO
         3UhtcKI0E5BFzKihuM9Llq4+WFgCxWThReDL+xHqRHdiIqAXfeDGdZ0meeMRBM67BMfV
         UmIgyVIyE0YwQahyKHog1Lo024gUnsINmg6ksAdp2RwBkrkyIge/zUE6et1FidvzfN5P
         33h0PB1jafaOImbRfp2cl/d8NWGqB0PQtcABk3AH/Edxw9IM6Hw6dQLxmFjj0pzp2xya
         y+Y9NJnMHATepZJ6O2H/tW+50oIACCO3GSirZCf/yQRk8HMq/beTA3g7B96PfZMVDedc
         pU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qlf9lXYabruIPe7BY1Co9J9v9aB5hsqm1QaXhz8x6vk=;
        b=OR0Wtst+KGPWF0hKjOTBoui+11KkKFpOmslXmxzFYGvYLO+Q9EcACvGRIwfxiSMPDv
         CTgtINcZUlAXAwPC2mC6gCklKokdfqiSIfK0fVtwojfJenCWLHjP9nqsBFBW0dmGxV+0
         MPfLrDcEb68FBTVAGlcoKGeTAHEniO44gr4pDSXQ52yafTDkGm0AAMxR8xjnOm76FYjT
         5HT5QGVkbPtK0IMhYvgaMedWZox4ECp2r2ey4yLpx6AIpl2I57MMZLqzt1CdL4rn7210
         3JjIQMgyPOIZPC0REbTlqm1pt8YuBeD1HowlVA3Ez5YAXLTylPbNwyKZGJm7+Vj/CmuN
         x/tw==
X-Gm-Message-State: APjAAAUY/cMQQ4KWDH2X9Z0xLeudylVHtEaKK2KOtXIRVg9uUTL6SRL2
        lPCxb+B8gYmyG1i9GGd1V5Y=
X-Google-Smtp-Source: APXvYqzGEhXv6s8sZbVFoRron3hfRXsajLyg8uOv83wej5gSwevGY+lcpfFTiN6S+fqhvz+EA2LNqQ==
X-Received: by 2002:a25:97c7:: with SMTP id j7mr25391925ybo.209.1580855233547;
        Tue, 04 Feb 2020 14:27:13 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id 144sm10038637ywy.20.2020.02.04.14.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 14:27:13 -0800 (PST)
Subject: Re: [PATCH v2 3/7] kunit: test: create a single centralized executor
 for all tests
To:     Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de,
        keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-4-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <11977708-bb18-e322-db7a-9f21d7cdec54@gmail.com>
Date:   Tue, 4 Feb 2020 16:27:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-4-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
> 
> Add a centralized executor to dispatch tests rather than relying on
> late_initcall to schedule each test suite separately.  Centralized
> execution is for built-in tests only; modules will execute tests
> when loaded.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/kunit/test.h | 73 +++++++++++++++++++++++++++-----------------
>  lib/kunit/Makefile   |  3 +-
>  lib/kunit/executor.c | 36 ++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 29 deletions(-)
>  create mode 100644 lib/kunit/executor.c
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 2dfb550c6723a..8a02f93a6b505 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h

The following fragment does not match the test.h in Linux 5.5 or 5.4-rc1 (as one
possible earlier version).  And we are not to Linux 5.5-rc1 yet.  (Simple way
to check for the mis-match - 5.5 has kunit_test_suite() instead of
kunit_test_suites().)

I know that there is an alternate tree where some of the development occurs.
Can you please add a link in MAINTAINERS?  And please note (at least in
patch 0) what tree the series is developed against?

-Frank


> @@ -197,46 +197,63 @@ void kunit_init_test(struct kunit *test, const char *name);
>  
>  int kunit_run_tests(struct kunit_suite *suite);
>  
> -/**
> - * kunit_test_suites() - used to register one or more &struct kunit_suite
> - *			 with KUnit.
> - *
> - * @suites: a statically allocated list of &struct kunit_suite.
> - *
> - * Registers @suites with the test framework. See &struct kunit_suite for
> - * more information.
> - *
> - * When builtin,  KUnit tests are all run as late_initcalls; this means
> - * that they cannot test anything where tests must run at a different init
> - * phase. One significant restriction resulting from this is that KUnit
> - * cannot reliably test anything that is initialize in the late_init phase;
> - * another is that KUnit is useless to test things that need to be run in
> - * an earlier init phase.
> - *
> - * An alternative is to build the tests as a module.  Because modules
> - * do not support multiple late_initcall()s, we need to initialize an
> - * array of suites for a module.
> - *
> - * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
> - * late_initcalls.  I have some future work planned to dispatch all KUnit
> - * tests from the same place, and at the very least to do so after
> - * everything else is definitely initialized.
> +/*
> + * If a test suite is built-in, module_init() gets translated into
> + * an initcall which we don't want as the idea is that for builtins
> + * the executor will manage execution.  So ensure we do not define
> + * module_{init|exit} functions for the builtin case when registering
> + * suites via kunit_test_suites() below.
>   */
> -#define kunit_test_suites(...)						\
> -	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
> -	static int kunit_test_suites_init(void)				\
> +#ifdef MODULE
> +#define kunit_test_suites_for_module(__suites)				\
> +	static int __init kunit_test_suites_init(void)			\
>  	{								\
> +		struct kunit_suite *suites[] = (__suites);		\
>  		unsigned int i;						\
> +									\
>  		for (i = 0; suites[i] != NULL; i++)			\
>  			kunit_run_tests(suites[i]);			\
>  		return 0;						\
>  	}								\
> -	late_initcall(kunit_test_suites_init);				\
> +	module_init(kunit_test_suites_init);				\
> +									\
>  	static void __exit kunit_test_suites_exit(void)			\
>  	{								\
>  		return;							\
>  	}								\
>  	module_exit(kunit_test_suites_exit)
> +#else
> +#define kunit_test_suites_for_module(__suites)
> +#endif /* MODULE */
> +
> +#define __kunit_test_suites(unique_array, unique_suites, ...)		       \
> +	static struct kunit_suite *unique_array[] = { __VA_ARGS__, NULL };     \
> +	kunit_test_suites_for_module(unique_array);			       \
> +	static struct kunit_suite **unique_suites			       \
> +	__used __aligned(8) __section(.kunit_test_suites) = unique_array
> +
> +/**
> + * kunit_test_suites() - used to register one or more &struct kunit_suite
> + *			 with KUnit.
> + *
> + * @suites: a statically allocated list of &struct kunit_suite.
> + *
> + * Registers @suites with the test framework. See &struct kunit_suite for
> + * more information.
> + *
> + * When builtin,  KUnit tests are all run via executor; this is done
> + * by placing the array of struct kunit_suite * in the .kunit_test_suites
> + * ELF section.
> + *
> + * An alternative is to build the tests as a module.  Because modules do not
> + * support multiple initcall()s, we need to initialize an array of suites for a
> + * module.
> + *
> + */
> +#define kunit_test_suites(...)						\
> +	__kunit_test_suites(__UNIQUE_ID(array),				\
> +			    __UNIQUE_ID(suites),			\
> +			    __VA_ARGS__)
>  
>  #define kunit_test_suite(suite)	kunit_test_suites(&suite)
>  
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index fab55649b69a5..c282f02ca066b 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
>  kunit-objs +=				test.o \
>  					string-stream.o \
>  					assert.o \
> -					try-catch.o
> +					try-catch.o \
> +					executor.o
>  
>  obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
>  
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> new file mode 100644
> index 0000000000000..6429927d598a5
> --- /dev/null
> +++ b/lib/kunit/executor.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test.h>
> +
> +/*
> + * These symbols point to the .kunit_test_suites section and are defined in
> + * include/asm-generic/vmlinux.lds.h, and consequently must be extern.
> + */
> +extern struct kunit_suite * const * const __kunit_suites_start[];
> +extern struct kunit_suite * const * const __kunit_suites_end[];
> +
> +#if IS_BUILTIN(CONFIG_KUNIT)
> +
> +static int kunit_run_all_tests(void)
> +{
> +	struct kunit_suite * const * const *suites, * const *subsuite;
> +	bool has_test_failed = false;
> +
> +	for (suites = __kunit_suites_start;
> +	     suites < __kunit_suites_end;
> +	     suites++) {
> +		for (subsuite = *suites; *subsuite != NULL; subsuite++) {
> +			if (kunit_run_tests(*subsuite))
> +				has_test_failed = true;
> +		}
> +	}
> +
> +	if (has_test_failed)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +late_initcall(kunit_run_all_tests);
> +
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> 

