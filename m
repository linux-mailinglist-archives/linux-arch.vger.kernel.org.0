Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0FC20BB90
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jun 2020 23:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgFZV3Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Jun 2020 17:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgFZV3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:29:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1BC03E97E
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:29:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u9so1114845pls.13
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Ga8k3mofod9gwPX4Z/kRgYwjmzbSSQT5mPWQ+iRr00=;
        b=ZHuV3n4N2UyL/uEYmg3j+3S3u+0QqpFCQhDYVKkZw9LuOjYP1YSNslr8dnNrsBn9Dh
         We7UamS+FEowQ2lOAMqm20z8L9ypztLNs429NEWOoxO6J0/qlK/WaTSFp6sTA+5zXJXt
         QK39ZARTjmUwV0eEr/JQyzmixIHGUEqhvzyh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Ga8k3mofod9gwPX4Z/kRgYwjmzbSSQT5mPWQ+iRr00=;
        b=SE52dkyMbR5hq0aWYSiXdK9vLemMZCx6T9R2jD/mbl6RdbEnD66urFa4El8zwsDkTj
         u0U36ATZ0QtjTtbsvCLVXqEbSNilNRrUK21ccO4P9ZkM4aOsxHoTvFvDCcIMBKJ7rZpN
         eq/YuiN7CC9+4lqSWsXGRWLK4SoFsfa1t+4qMCL2pSv3qr+BlnfUpGQSQtpxEBuopHI0
         yiTCC50IsiECaSzEUqe8bvkJAnJbJTB5gEW1/NcjuUc725d0NoG6z1h2LuUZp2kxHync
         RNYTOzPtURE07dISF+3zJSM710UertXGpZNElRu1nqNSKIdbXhxRmRnLg1Zyz5dmlXPb
         eHhw==
X-Gm-Message-State: AOAM531gAEgf0Y0/eLCDUjOusO23BMhruzt0uKpbnaKojlq91CSFCw5h
        IfKMmhvuG9tCF0idWTM0h50KxQ==
X-Google-Smtp-Source: ABdhPJwxwunBg3ErYOqng8+maceCSdLikNLQ8Egfp/C6bLTULFH4Wp7/OynACw0oVHkVmKrSUGo10g==
X-Received: by 2002:a17:90a:4a6:: with SMTP id g35mr5538400pjg.155.1593206964538;
        Fri, 26 Jun 2020 14:29:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm5623223pjy.40.2020.06.26.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:29:23 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:29:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 07/12] kunit: test: create a single centralized
 executor for all tests
Message-ID: <202006261423.0BC9D830@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-8-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-8-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:12PM -0700, Brendan Higgins wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
> 
> Add a centralized executor to dispatch tests rather than relying on
> late_initcall to schedule each test suite separately. Centralized
> execution is for built-in tests only; modules will execute tests when
> loaded.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/kunit/test.h | 67 +++++++++++++++++++++++++++++---------------
>  lib/kunit/Makefile   |  3 +-
>  lib/kunit/executor.c | 28 ++++++++++++++++++
>  lib/kunit/test.c     |  2 +-
>  4 files changed, 76 insertions(+), 24 deletions(-)
>  create mode 100644 lib/kunit/executor.c
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 47e61e1d53370..f3e86c3953a2b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -224,7 +224,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
>  				 struct kunit_case *test_case);
>  
> -int __kunit_test_suites_init(struct kunit_suite **suites);
> +int __kunit_test_suites_init(struct kunit_suite * const * const suites);
>  
>  void __kunit_test_suites_exit(struct kunit_suite **suites);
>  
> @@ -237,34 +237,57 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
>   * Registers @suites_list with the test framework. See &struct kunit_suite for
>   * more information.
>   *
> - * When builtin, KUnit tests are all run as late_initcalls; this means
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
> + * If a test suite is built-in, module_init() gets translated into
> + * an initcall which we don't want as the idea is that for builtins
> + * the executor will manage execution.  So ensure we do not define
> + * module_{init|exit} functions for the builtin case when registering
> + * suites via kunit_test_suites() below.
>   */
> -#define kunit_test_suites(suites_list...)				\
> -	static struct kunit_suite *suites[] = {suites_list, NULL};	\
> -	static int kunit_test_suites_init(void)				\
> +#ifdef MODULE
> +#define kunit_test_suites_for_module(__suites)				\
> +	static int __init kunit_test_suites_init(void)			\
>  	{								\
> -		return __kunit_test_suites_init(suites);		\
> +		return __kunit_test_suites_init(__suites);		\
>  	}								\
> -	late_initcall(kunit_test_suites_init);				\
> +	module_init(kunit_test_suites_init);				\
> +									\
>  	static void __exit kunit_test_suites_exit(void)			\
>  	{								\
> -		return __kunit_test_suites_exit(suites);		\
> +		return __kunit_test_suites_exit(__suites);		\
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
> +	__used __section(.kunit_test_suites) = unique_array
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
> index 724b94311ca36..c49f4ffb6273a 100644
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
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=				debugfs.o
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> new file mode 100644
> index 0000000000000..7015e7328dce7
> --- /dev/null
> +++ b/lib/kunit/executor.c
> @@ -0,0 +1,28 @@
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

I would expect these to be in include/asm-generic/sections.h but I guess
it's not required.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
