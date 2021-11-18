Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FA4559AA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Nov 2021 12:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbhKRLLn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Nov 2021 06:11:43 -0500
Received: from foss.arm.com ([217.140.110.172]:39486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343604AbhKRLLW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Nov 2021 06:11:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE881FB;
        Thu, 18 Nov 2021 03:08:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26D7E3F5A1;
        Thu, 18 Nov 2021 03:08:19 -0800 (PST)
Date:   Thu, 18 Nov 2021 11:08:14 +0000
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
Subject: Re: [PATCH v2 01/23] kcsan: Refactor reading of instrumented memory
Message-ID: <20211118110813.GA5233@lakrids.cambridge.arm.com>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118081027.3175699-2-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 18, 2021 at 09:10:05AM +0100, Marco Elver wrote:
> Factor out the switch statement reading instrumented memory into a
> helper read_instrumented_memory().
> 
> No functional change.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Nice cleanup!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/kcsan/core.c | 51 +++++++++++++++------------------------------
>  1 file changed, 17 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 4b84c8e7884b..6bfd3040f46b 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -325,6 +325,21 @@ static void delay_access(int type)
>  	udelay(delay);
>  }
>  
> +/*
> + * Reads the instrumented memory for value change detection; value change
> + * detection is currently done for accesses up to a size of 8 bytes.
> + */
> +static __always_inline u64 read_instrumented_memory(const volatile void *ptr, size_t size)
> +{
> +	switch (size) {
> +	case 1:  return READ_ONCE(*(const u8 *)ptr);
> +	case 2:  return READ_ONCE(*(const u16 *)ptr);
> +	case 4:  return READ_ONCE(*(const u32 *)ptr);
> +	case 8:  return READ_ONCE(*(const u64 *)ptr);
> +	default: return 0; /* Ignore; we do not diff the values. */
> +	}
> +}
> +
>  void kcsan_save_irqtrace(struct task_struct *task)
>  {
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -482,23 +497,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	 * Read the current value, to later check and infer a race if the data
>  	 * was modified via a non-instrumented access, e.g. from a device.
>  	 */
> -	old = 0;
> -	switch (size) {
> -	case 1:
> -		old = READ_ONCE(*(const u8 *)ptr);
> -		break;
> -	case 2:
> -		old = READ_ONCE(*(const u16 *)ptr);
> -		break;
> -	case 4:
> -		old = READ_ONCE(*(const u32 *)ptr);
> -		break;
> -	case 8:
> -		old = READ_ONCE(*(const u64 *)ptr);
> -		break;
> -	default:
> -		break; /* ignore; we do not diff the values */
> -	}
> +	old = read_instrumented_memory(ptr, size);
>  
>  	/*
>  	 * Delay this thread, to increase probability of observing a racy
> @@ -511,23 +510,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	 * racy access.
>  	 */
>  	access_mask = ctx->access_mask;
> -	new = 0;
> -	switch (size) {
> -	case 1:
> -		new = READ_ONCE(*(const u8 *)ptr);
> -		break;
> -	case 2:
> -		new = READ_ONCE(*(const u16 *)ptr);
> -		break;
> -	case 4:
> -		new = READ_ONCE(*(const u32 *)ptr);
> -		break;
> -	case 8:
> -		new = READ_ONCE(*(const u64 *)ptr);
> -		break;
> -	default:
> -		break; /* ignore; we do not diff the values */
> -	}
> +	new = read_instrumented_memory(ptr, size);
>  
>  	diff = old ^ new;
>  	if (access_mask)
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 
