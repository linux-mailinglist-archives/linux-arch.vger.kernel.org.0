Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17928CC43
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 13:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgJMLJt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 07:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbgJMLJs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 07:09:48 -0400
Received: from coco.lan (unknown [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C746520659;
        Tue, 13 Oct 2020 11:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602587387;
        bh=rtkVLlfLr6PN9eUQhxVzbDDGszd1byyijI9PT2xKGqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nZQe+kbSoOC+QbX5z+Oo7NTk9qhgO9eT7IxPVkhteoXz9VuS/foh48IK7+12oW4c9
         GYj30PuLutNXc7Ff1M5RYkzWQbd3do+gxcnCNAnWA0mIkcSNlQpEgpiZMLHBhikYmj
         J8xJ4eSU4G8gm4Qa/HoL/IcWSnSyQWjnAjhrC+pI=
Date:   Tue, 13 Oct 2020 13:09:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/5] kunit: test: create a single centralized
 executor for all tests
Message-ID: <20201013130936.708562f6@coco.lan>
In-Reply-To: <20200804204745.987648-3-brendanhiggins@google.com>
References: <20200804204745.987648-1-brendanhiggins@google.com>
        <20200804204745.987648-3-brendanhiggins@google.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Tue,  4 Aug 2020 13:47:42 -0700
Brendan Higgins <brendanhiggins@google.com> escreveu:

> From: Alan Maguire <alan.maguire@oracle.com>
> 
> Add a centralized executor to dispatch tests rather than relying on
> late_initcall to schedule each test suite separately. Centralized
> execution is for built-in tests only; modules will execute tests when
> loaded.

This patch adds 3 new warnings when doing "make htmldocs".
Those two are trivial to fix:

	../include/kunit/test.h:282: warning: Function parameter or member '__suites' not described in 'kunit_test_suites_for_module'
	../include/kunit/test.h:282: warning: Excess function parameter 'suites_list' description in 'kunit_test_suites_for_module'

<patch>
diff --git a/include/kunit/test.h b/include/kunit/test.h
index a423fffefea0..f2c387c60fac 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -256,9 +256,9 @@ static inline int kunit_run_all_tests(void)
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites_list...: a statically allocated list of &struct kunit_suite.
+ * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites_list with the test framework. See &struct kunit_suite for
+ * Registers @__suites with the test framework. See &struct kunit_suite for
  * more information.
  *
  * If a test suite is built-in, module_init() gets translated into
</patch>

> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
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

But the third warning:

	../include/kunit/test.h:314: warning: Excess function parameter 'suites' description in 'kunit_test_suites'

is more problematic.

At least for me, it sounds a **very bad** idea to not pass "array"
and "suites" to this macro, but, instead, to rely that some
previous code would have added such vars with those specific
names.

Also, you can't document a parameter "suites" that it is not a
parameter.

IMO, the right fix would be to define the macro as:

	#define kunit_test_suites(array, suites, arg...)			\
		__kunit_test_suites(__UNIQUE_ID(array),			\
				    __UNIQUE_ID(suites),		\
				    ## arg)

and then document "array", "suites" and "arg" using kernel-doc
markups.

Thanks,
Mauro
