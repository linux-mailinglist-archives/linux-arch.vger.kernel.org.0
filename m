Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F491DDAB1
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 01:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgEUXCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 19:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbgEUXCy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2020 19:02:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2BAC05BD43
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2020 16:02:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e11so3281068pfn.3
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2020 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8nwjEFXdL/qUT1MJlEJzZkoOSwVlfdmOoeCx+p6vxrE=;
        b=RgU4WO+iyUMpoS5Z7G1UNPucVaogpfMoCFArK4kvdZ8ETrqoN6g1IZhOT4XI8XYda2
         vxCk9HIYJbL0RbCUUEYZbH2OS7nN/P9wvYFbXpogvFKXCyBtqf2Mm/xghKi7KpRNaPXO
         evXz+sLd+jp/Adz7MOToQ4EBb0yBVjkCoYDio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8nwjEFXdL/qUT1MJlEJzZkoOSwVlfdmOoeCx+p6vxrE=;
        b=ILc34zWRP4i/fePre6CpM9ishsEWc0o+Ljek92jXXxTfQRKaU4yv6JEEVdi+njxSzU
         1oU+aB3nwzklJ0crQaGOr0utCCRAfmk7l64usy6AXlQUTKhuwso+sIE+crY1xmYuiRPS
         8sUJHbiUOB1j/nL9AeUaBWQS/dD3QYrsuRiT97LnKlm/7S1bEZ1NEIGKg6A7DUGh8rvk
         1W89zwZbSoO5oU+FXpEZywssd5JVzHepunF0asg2OLLLQPNjChYfTHRN9K9mSsQ8AH9m
         qoQjo5QfYGdM/JehVAKDcNkhBXbbdBTdbS5u0lkVgGfEwSK5/uFLpPo8gRkNBbzVZULg
         oIxQ==
X-Gm-Message-State: AOAM532Zl1PjvhjGY2hCQTSw5iOzpaq4s69yu2FP58YsHAcOBMtybKiy
        HD9Nn9AViH3C5RtQZhxCnJrxYg==
X-Google-Smtp-Source: ABdhPJxoV6c5OWcfIIC3DzUQxrFj4PClfBbCCV1XGCZnTmTBfeU4oyT29bAmI6AQQZD/aNP0zoxYYA==
X-Received: by 2002:aa7:9251:: with SMTP id 17mr919104pfp.315.1590102173085;
        Thu, 21 May 2020 16:02:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i98sm5471997pje.37.2020.05.21.16.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 16:02:52 -0700 (PDT)
Date:   Thu, 21 May 2020 16:02:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Message-ID: <202005211550.AF0E83BB@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-6-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:
> Introduce a quick test to verify shadow stack and IBT are working.

Cool! :)

I'd love to see either more of a commit log or more comments in the test
code itself. I had to spend a bit of time trying to understand how the
test was working. (i.e. using ucontext to "reset", using segv handler to
catch some of them, etc.) I have not yet figured out why you need to
send USR1/USR2 for two of them instead of direct calls?

More notes below...

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  tools/testing/selftests/x86/Makefile         |   2 +-
>  tools/testing/selftests/x86/cet_quick_test.c | 128 +++++++++++++++++++
>  2 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/cet_quick_test.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index f1bf5ab87160..26e68272117a 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -14,7 +14,7 @@ CAN_BUILD_CET := $(shell ./check_cc.sh $(CC) trivial_program.c -fcf-protection)
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl ioperm \
>  			protection_keys test_vdso test_vsyscall mov_ss_trap \
> -			syscall_arg_fault
> +			syscall_arg_fault cet_quick_test
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
> diff --git a/tools/testing/selftests/x86/cet_quick_test.c b/tools/testing/selftests/x86/cet_quick_test.c
> new file mode 100644
> index 000000000000..e84bbbcfd26f
> --- /dev/null
> +++ b/tools/testing/selftests/x86/cet_quick_test.c
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Quick tests to verify Shadow Stack and IBT are working */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <string.h>
> +#include <ucontext.h>
> +
> +ucontext_t ucp;
> +int result[4] = {-1, -1, -1, -1};

I think you likely want three states: no signal, failed, and okay.
Perhaps -1 for "no signal" like you have above, zero for failed, and 1
for okay.

> +int test_id;
> +
> +void stack_hacked(unsigned long x)
> +{
> +	result[test_id] = -1;

So this is set to 0: "I absolutely bypassed the protection".

> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +#pragma GCC push_options
> +#pragma GCC optimize ("O0")

Can you avoid compiler-specific pragmas? (Or verify that Clang also
behaves correctly here?) Maybe it's better to just build the entire file
with -O0 in the Makefile?

> +void ibt_violation(void)
> +{
> +#ifdef __i386__
> +	asm volatile("lea 1f, %eax");
> +	asm volatile("jmp *%eax");
> +#else
> +	asm volatile("lea 1f, %rax");
> +	asm volatile("jmp *%rax");
> +#endif
> +	asm volatile("1:");
> +	result[test_id] = -1;

Set to 0, and if the segv doesn't see it, we know for sure it failed.

> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +void shstk_violation(void)
> +{
> +#ifdef __i386__
> +	unsigned long x = 0;
> +
> +	((unsigned long *)&x)[2] = (unsigned long)stack_hacked;
> +#else
> +	unsigned long long x = 0;
> +
> +	((unsigned long long *)&x)[2] = (unsigned long)stack_hacked;
> +#endif
> +}
> +#pragma GCC pop_options
> +
> +void segv_handler(int signum, siginfo_t *si, void *uc)
> +{

Does anything in siginfo_t indicate which kind of failure you're
detecting? It'd be nice to verify test_id matches the failure mode being
tested.

> +	result[test_id] = 0;
> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +void user1_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	shstk_violation();
> +}
> +
> +void user2_handler(int signum, siginfo_t *si, void *uc)
> +{
> +	ibt_violation();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct sigaction sa;
> +	int r;
> +
> +	r = sigemptyset(&sa.sa_mask);
> +	if (r)
> +		return -1;
> +
> +	sa.sa_flags = SA_SIGINFO;
> +
> +	/*
> +	 * Control protection fault handler
> +	 */
> +	sa.sa_sigaction = segv_handler;
> +	r = sigaction(SIGSEGV, &sa, NULL);
> +	if (r)
> +		return -1;
> +
> +	/*
> +	 * Handler to test Shadow stack
> +	 */
> +	sa.sa_sigaction = user1_handler;
> +	r = sigaction(SIGUSR1, &sa, NULL);
> +	if (r)
> +		return -1;
> +
> +	/*
> +	 * Handler to test IBT
> +	 */
> +	sa.sa_sigaction = user2_handler;
> +	r = sigaction(SIGUSR2, &sa, NULL);
> +	if (r)
> +		return -1;
> +
> +	test_id = 0;
> +	r = getcontext(&ucp);
> +	if (r)
> +		return -1;
> +
> +	if (test_id == 0)
> +		shstk_violation();
> +	else if (test_id == 1)
> +		ibt_violation();
> +	else if (test_id == 2)
> +		raise(SIGUSR1);
> +	else if (test_id == 3)
> +		raise(SIGUSR2);
> +
> +	r = 0;
> +	printf("[%s]\tShadow stack\n", result[0] ? "FAIL":"OK");

Then these are result[0] == -1 ? "untested" : (result[0] ? "OK" : "FAIL"))

> +	r += result[0];
> +	printf("[%s]\tIBT\n", result[1] ? "FAIL":"OK");
> +	r += result[1];
> +	printf("[%s]\tShadow stack in signal\n", result[2] ? "FAIL":"OK");
> +	r += result[2];
> +	printf("[%s]\tIBT in signal\n", result[3] ? "FAIL":"OK");
> +	r += result[3];
> +	return r;
> +}
> -- 
> 2.21.0
> 

-- 
Kees Cook
