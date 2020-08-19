Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBE24A237
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgHSO6H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgHSO56 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 10:57:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6CC061342
        for <linux-arch@vger.kernel.org>; Wed, 19 Aug 2020 07:57:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so21863871wrl.4
        for <linux-arch@vger.kernel.org>; Wed, 19 Aug 2020 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gNx7n7webYaK+hMWxyNwV8aV+v87tKouMeg3PXkBAf4=;
        b=n8MmBW8b3ksN9T8Gafo3ZMOc4bhTXtjR+GeS0Rvibq/PzoG8Ye3N53BDrp8svnlv1n
         NCO6QXaVozSNJMjlnQ5OShKx2UtailwRjMYqmmmurY9gvYVamal0vEIVKsDhh8K+8W26
         WPEmayEJ3i7jIMuYtQRfCZ/+8a4/zcqFTDJpsQffHWVTTjOiGoLEoP2XGxgbqsgf/DDj
         g8kTBETSBr9PCC/YyD3BzuaZDEj4xbQidp8pcS2SN8qiHkb+Aa3m1UDHtXXnDy9A2zpf
         s+zE/8aI9eShP/kv/B+r9e3vocR244XTBvjbPCq4/aLjlqFZ6LbVgGFYOeq7pX62hhHU
         PKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNx7n7webYaK+hMWxyNwV8aV+v87tKouMeg3PXkBAf4=;
        b=CKva04UP0btjwxO+dE1eXr92QtrygUhQYPmvZHQdU5lA8w+Zf4Z6xKRmz1BjYBVw81
         qo5aCLSr42jBzOC8Yf7epP+l9BCB7lSGeekiwcr+Hl+CYPhe4FRgAao69olvWyrx5Z5L
         0Iw9VGvVBTzZzN7+uS+82VowumE61SODPdfV06PsqLJ02POERRKEZYGdEnl1AQ8mjTK+
         F3yejqvooRFsRAuiwHTmLw1qDLc3D2vY8mVkPaAKXirG2fmHSUI7nL/XgrcNXpPvn9mZ
         un6H1U2osa2lEl7qL7M6My1RlZ36inogU3SUl7cThz+HKHPj4FwXmQdq4nCH9t8y4PF8
         p04A==
X-Gm-Message-State: AOAM5313y3S5kO3FSAXg4PcjbyQAaWAmdOqjTCTgfJf4F4iyfKXkOIH9
        sFl2E9Vcf1nSs5QyqXu5N2R7cQ==
X-Google-Smtp-Source: ABdhPJzdW54EsERHAQyBaPPEEG3Xqf5CZuQ5mXiSSV+v29L8rIqau0aRKvT5VQZe07WUqRDjP2geRQ==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr27108964wrp.180.1597849074997;
        Wed, 19 Aug 2020 07:57:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h5sm44726104wrc.97.2020.08.19.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:57:53 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:57:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hewllig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH v2 09/11] kgdbts: switch to kernel_clone()
Message-ID: <20200819145751.uqblo3zh66nqnxmn@holly.lan>
References: <20200819104655.436656-1-christian.brauner@ubuntu.com>
 <20200819104655.436656-10-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819104655.436656-10-christian.brauner@ubuntu.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 12:46:53PM +0200, Christian Brauner wrote:
> The old _do_fork() helper is removed in favor of the new kernel_clone() helper.
> The latter adheres to naming conventions for kernel internal syscall helpers.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
> /* v2 */
> unchanged
> ---
>  drivers/misc/kgdbts.c | 48 +++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index d5d2af4d10e6..945701bce553 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -33,16 +33,16 @@
>   * You can also specify optional tests:
>   * N## = Go to sleep with interrupts of for ## seconds
>   *       to test the HW NMI watchdog
> - * F## = Break at do_fork for ## iterations
> + * F## = Break at kernel_clone for ## iterations
>   * S## = Break at sys_open for ## iterations
>   * I## = Run the single step test ## iterations
>   *
> - * NOTE: that the do_fork and sys_open tests are mutually exclusive.
> + * NOTE: that the kernel_clone and sys_open tests are mutually exclusive.
>   *
>   * To invoke the kgdb test suite from boot you use a kernel start
>   * argument as follows:
>   * 	kgdbts=V1 kgdbwait
> - * Or if you wanted to perform the NMI test for 6 seconds and do_fork
> + * Or if you wanted to perform the NMI test for 6 seconds and kernel_clone
>   * test for 100 forks, you could use:
>   * 	kgdbts=V1N6F100 kgdbwait
>   *
> @@ -74,7 +74,7 @@
>   * echo kgdbts=V1S10000 > /sys/module/kgdbts/parameters/kgdbts
>   * fg # and hit control-c
>   * fg # and hit control-c
> - * ## This tests break points on do_fork
> + * ## This tests break points on kernel_clone
>   * while [ 1 ] ; do date > /dev/null ; done &
>   * while [ 1 ] ; do date > /dev/null ; done &
>   * echo kgdbts=V1F1000 > /sys/module/kgdbts/parameters/kgdbts
> @@ -209,8 +209,8 @@ static unsigned long lookup_addr(char *arg)
>  		addr = (unsigned long)kgdbts_break_test;
>  	else if (!strcmp(arg, "sys_open"))
>  		addr = (unsigned long)do_sys_open;
> -	else if (!strcmp(arg, "do_fork"))
> -		addr = (unsigned long)_do_fork;
> +	else if (!strcmp(arg, "kernel_clone"))
> +		addr = (unsigned long)kernel_clone;
>  	else if (!strcmp(arg, "hw_break_val"))
>  		addr = (unsigned long)&hw_break_val;
>  	addr = (unsigned long) dereference_function_descriptor((void *)addr);
> @@ -310,7 +310,7 @@ static int check_and_rewind_pc(char *put_str, char *arg)
>  
>  	if (arch_needs_sstep_emulation && sstep_addr &&
>  	    ip + offset == sstep_addr &&
> -	    ((!strcmp(arg, "sys_open") || !strcmp(arg, "do_fork")))) {
> +	    ((!strcmp(arg, "sys_open") || !strcmp(arg, "kernel_clone")))) {
>  		/* This is special case for emulated single step */
>  		v2printk("Emul: rewind hit single step bp\n");
>  		restart_from_top_after_write = 1;
> @@ -596,19 +596,19 @@ static struct test_struct singlestep_break_test[] = {
>  };
>  
>  /*
> - * Test for hitting a breakpoint at do_fork for what ever the number
> + * Test for hitting a breakpoint at kernel_clone for what ever the number
>   * of iterations required by the variable repeat_test.
>   */
> -static struct test_struct do_fork_test[] = {
> +static struct test_struct do_kernel_clone_test[] = {
>  	{ "?", "S0*" }, /* Clear break points */
> -	{ "do_fork", "OK", sw_break, }, /* set sw breakpoint */
> +	{ "kernel_clone", "OK", sw_break, }, /* set sw breakpoint */
>  	{ "c", "T0*", NULL, get_thread_id_continue }, /* Continue */
> -	{ "do_fork", "OK", sw_rem_break }, /*remove breakpoint */
> -	{ "g", "do_fork", NULL, check_and_rewind_pc }, /* check location */
> +	{ "kernel_clone", "OK", sw_rem_break }, /*remove breakpoint */
> +	{ "g", "kernel_clone", NULL, check_and_rewind_pc }, /* check location */
>  	{ "write", "OK", write_regs, emul_reset }, /* Write registers */
>  	{ "s", "T0*", emul_sstep_get, emul_sstep_put }, /* Single step */
> -	{ "g", "do_fork", NULL, check_single_step },
> -	{ "do_fork", "OK", sw_break, }, /* set sw breakpoint */
> +	{ "g", "kernel_clone", NULL, check_single_step },
> +	{ "kernel_clone", "OK", sw_break, }, /* set sw breakpoint */
>  	{ "7", "T0*", skip_back_repeat_test }, /* Loop based on repeat_test */
>  	{ "D", "OK", NULL, final_ack_set }, /* detach and unregister I/O */
>  	{ "", "", get_cont_catch, put_cont_catch },
> @@ -935,11 +935,11 @@ static void run_bad_read_test(void)
>  	kgdb_breakpoint();
>  }
>  
> -static void run_do_fork_test(void)
> +static void run_kernel_clone_test(void)
>  {
>  	init_simple_test();
> -	ts.tst = do_fork_test;
> -	ts.name = "do_fork_test";
> +	ts.tst = do_kernel_clone_test;
> +	ts.name = "do_kernel_clone_test";
>  	/* Activate test with initial breakpoint */
>  	kgdb_breakpoint();
>  }
> @@ -967,7 +967,7 @@ static void run_singlestep_break_test(void)
>  static void kgdbts_run_tests(void)
>  {
>  	char *ptr;
> -	int fork_test = 0;
> +	int clone_test = 0;
>  	int do_sys_open_test = 0;
>  	int sstep_test = 1000;
>  	int nmi_sleep = 0;
> @@ -981,7 +981,7 @@ static void kgdbts_run_tests(void)
>  
>  	ptr = strchr(config, 'F');
>  	if (ptr)
> -		fork_test = simple_strtol(ptr + 1, NULL, 10);
> +		clone_test = simple_strtol(ptr + 1, NULL, 10);
>  	ptr = strchr(config, 'S');
>  	if (ptr)
>  		do_sys_open_test = simple_strtol(ptr + 1, NULL, 10);
> @@ -1025,16 +1025,16 @@ static void kgdbts_run_tests(void)
>  		run_nmi_sleep_test(nmi_sleep);
>  	}
>  
> -	/* If the do_fork test is run it will be the last test that is
> +	/* If the kernel_clone test is run it will be the last test that is
>  	 * executed because a kernel thread will be spawned at the very
>  	 * end to unregister the debug hooks.
>  	 */
> -	if (fork_test) {
> -		repeat_test = fork_test;
> -		printk(KERN_INFO "kgdbts:RUN do_fork for %i breakpoints\n",
> +	if (clone_test) {
> +		repeat_test = clone_test;
> +		printk(KERN_INFO "kgdbts:RUN kernel_clone for %i breakpoints\n",
>  			repeat_test);
>  		kthread_run(kgdbts_unreg_thread, NULL, "kgdbts_unreg");
> -		run_do_fork_test();
> +		run_kernel_clone_test();
>  		return;
>  	}
>  
> -- 
> 2.28.0
> 
