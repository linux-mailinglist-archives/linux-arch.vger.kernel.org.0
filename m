Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D34559BD
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 12:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbhKRLOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 06:14:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343765AbhKRLMh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 06:12:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAB671FB;
        Thu, 18 Nov 2021 03:09:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2123F5A1;
        Thu, 18 Nov 2021 03:09:33 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:09:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 02/23] kcsan: Remove redundant zero-initialization of
 globals
Message-ID: <20211118110931.GB5233@lakrids.cambridge.arm.com>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118081027.3175699-3-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 18, 2021 at 09:10:06AM +0100, Marco Elver wrote:
> They are implicitly zero-initialized, remove explicit initialization.
> It keeps the upcoming additions to kcsan_ctx consistent with the rest.
> 
> No functional change intended.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  init/init_task.c    | 9 +--------
>  kernel/kcsan/core.c | 5 -----
>  2 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 2d024066e27b..61700365ce58 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -181,14 +181,7 @@ struct task_struct init_task
>  	.kasan_depth	= 1,
>  #endif
>  #ifdef CONFIG_KCSAN
> -	.kcsan_ctx = {
> -		.disable_count		= 0,
> -		.atomic_next		= 0,
> -		.atomic_nest_count	= 0,
> -		.in_flat_atomic		= false,
> -		.access_mask		= 0,
> -		.scoped_accesses	= {LIST_POISON1, NULL},
> -	},
> +	.kcsan_ctx = { .scoped_accesses = {LIST_POISON1, NULL} },

I'd recommend leaving this as:

	.kcsan_ctx = {
		.scoped_accesses = {LIST_POISON1, NULL},
	},

... which'd be consistent with the DEFINE_PER_CPU() usage below, and
makes it easier to add fields to in future without needing structural
changes.

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

>  #endif
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	.softirqs_enabled = 1,
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 6bfd3040f46b..e34a1710b7bc 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -44,11 +44,6 @@ bool kcsan_enabled;
>  
>  /* Per-CPU kcsan_ctx for interrupts */
>  static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
> -	.disable_count		= 0,
> -	.atomic_next		= 0,
> -	.atomic_nest_count	= 0,
> -	.in_flat_atomic		= false,
> -	.access_mask		= 0,
>  	.scoped_accesses	= {LIST_POISON1, NULL},
>  };
>  
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 
