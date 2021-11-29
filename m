Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF74610BA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Nov 2021 10:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhK2JEt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Nov 2021 04:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbhK2JCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2021 04:02:47 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25536C061374;
        Mon, 29 Nov 2021 00:48:29 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id n15so15888418qta.0;
        Mon, 29 Nov 2021 00:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ItEAYKU3F6ZMzjeJrS4XI6sKMzUfcWZjmcqkDWVUXwI=;
        b=a+k8hqQ/8UPeA66xzAZg70hsiPM+lJH0YLsAf1TmCYq18DQttu2qSDU9hqgnuUpxLT
         NVfE+/e0vG5dSjsS7dE+3yEy6nCFH6RxV3UbdlcJ5w2La17HvkYCe4m74huwMGxm2S3H
         lSwHgqDUGF+BVCsH+oZp2l0Jt5GX0WKqXjiZqYr9MYidYDlGaK4XdhsO9OHI6URXgYu8
         DDJSk/u6oK+NpEg3mqjAyXOJw68AgOrvfgGn8r9Aa7YJwL5zOJfSzBkMTII876Jyh9vE
         Id8HqQPy/DHx6/PS4JXxtQR+cC+ZP5ykUdfsBnGfgAtVvBQeABDeEuVVuXnFGII3mx5p
         CssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItEAYKU3F6ZMzjeJrS4XI6sKMzUfcWZjmcqkDWVUXwI=;
        b=eae6w522RMo4cd48VqdRGBZ7GyMSh7am0JUBA0Nw0/N3SbysLlfBbaqjrRnr3GFlcY
         dIRAwCCwVz0RSLrh09Tc7II/f5WOc90n88rgPb94MmT8F83kMiIxltUavcDXBb2aftPx
         vQL/+OXq+rRhkhzdf1Yv5evib7IMlQhy8u3EIylD25gl5xc7pdIiRTYCVTPw6dXfuLPS
         SzX+24qkfV68haHOdj4+c5ABBIVFuPKECidWtr66QNuaMLCkVNB7rjrVG1HQu1kXmsG4
         97ucJa7BPOJuUjYHjSQra6UMskURil/WxncMlx/uotKU0FdIDsIB6VZBprQYkLALBeSe
         YeXw==
X-Gm-Message-State: AOAM5310bNykzpzMWS5Veqc+kJvz/rSI3agN8sDl5VYHn1bWAOK1Fm4w
        nbM85mUJ+igMQFVZhSUezzM=
X-Google-Smtp-Source: ABdhPJwvG2HvAGdJeeRHSwZnojeN/R3RienXKSIOM/skzSEjxmAlX/J6WUpt0SLTOq5x8wuBbiB0xQ==
X-Received: by 2002:a05:622a:1d3:: with SMTP id t19mr42663143qtw.181.1638175708233;
        Mon, 29 Nov 2021 00:48:28 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h13sm8516048qtk.25.2021.11.29.00.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 00:48:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 734BF27C0054;
        Mon, 29 Nov 2021 03:48:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Nov 2021 03:48:26 -0500
X-ME-Sender: <xms:2ZOkYcXcFR3zFG3N3VRUYdkpBLbLU6SuJePcJgbyoBS1n1NZHSiMuA>
    <xme:2ZOkYQkaOqq71jAoqNsV-ffkXYxpxTGQmPpbdHVUxegXXAMmjheBW77Tc_ejqdQXJ
    NlYKmLMP4aNqE3uRw>
X-ME-Received: <xmr:2ZOkYQaEzXMQzcbb-LlKh9UkRB4Xuoz1iztbgMlLSUyIV-wnFJFTzVI4lla6_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheekgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:2ZOkYbUGiiHKxVw0d_kOMFcc5xoyA-BUG5FXzWEirhaf1JJDRarCOQ>
    <xmx:2ZOkYWk966q9m-wb3GwPVBb5upZvHKgIu4-0G4wcFm90nKHvzkikXw>
    <xmx:2ZOkYQcYCEskBVC8WBN_uPPhFMtY26S20P3wAgL3GNr8SONNhNb70w>
    <xmx:2ZOkYVfVJQi6ugUp1EpMKu9YEEGtLuyQuIFZTOwSc61Y6e5-nDmRfOtEuqE>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Nov 2021 03:48:24 -0500 (EST)
Date:   Mon, 29 Nov 2021 16:47:27 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 03/23] kcsan: Avoid checking scoped accesses from
 nested contexts
Message-ID: <YaSTn3JbkHsiV5Tm@boqun-archlinux>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118081027.3175699-4-elver@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marco,

On Thu, Nov 18, 2021 at 09:10:07AM +0100, Marco Elver wrote:
> Avoid checking scoped accesses from nested contexts (such as nested
> interrupts or in scheduler code) which share the same kcsan_ctx.
> 
> This is to avoid detecting false positive races of accesses in the same

Could you provide an example for a false positive?

I think we do want to detect the following race:

	static int v = SOME_VALUE; // a percpu variable.
	static int other_v = ... ;

	void foo(..)
	{
		int tmp;
		int other_tmp;

		preempt_disable();
		{
			ASSERT_EXCLUSIVE_ACCESSS_SCOPED(v);
			tmp = v;
			
			other_tmp = other_v; // int_handler() may run here
			
			v = tmp + 2;
		}
		preempt_enabled();
	}

	void int_handler() // an interrupt handler
	{
		v++;
	}

, if I understand correctly, we can detect this currently, but with this
patch, we cannot detect this if the interrupt happens while we're doing
the check for "other_tmp = other_v;", right? Of course, running tests
multiple times may eventually catch this, but I just want to understand
what's this patch for, thanks!

Regards,
Boqun

> thread with currently scoped accesses: consider setting up a watchpoint
> for a non-scoped (normal) access that also "conflicts" with a current
> scoped access. In a nested interrupt (or in the scheduler), which shares
> the same kcsan_ctx, we cannot check scoped accesses set up in the parent
> context -- simply ignore them in this case.
> 
> With the introduction of kcsan_ctx::disable_scoped, we can also clean up
> kcsan_check_scoped_accesses()'s recursion guard, and do not need to
> modify the list's prev pointer.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kcsan.h |  1 +
>  kernel/kcsan/core.c   | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> index fc266ecb2a4d..13cef3458fed 100644
> --- a/include/linux/kcsan.h
> +++ b/include/linux/kcsan.h
> @@ -21,6 +21,7 @@
>   */
>  struct kcsan_ctx {
>  	int disable_count; /* disable counter */
> +	int disable_scoped; /* disable scoped access counter */
>  	int atomic_next; /* number of following atomic ops */
>  
>  	/*
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index e34a1710b7bc..bd359f8ee63a 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -204,15 +204,17 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip);
>  static noinline void kcsan_check_scoped_accesses(void)
>  {
>  	struct kcsan_ctx *ctx = get_ctx();
> -	struct list_head *prev_save = ctx->scoped_accesses.prev;
>  	struct kcsan_scoped_access *scoped_access;
>  
> -	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
> +	if (ctx->disable_scoped)
> +		return;
> +
> +	ctx->disable_scoped++;
>  	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list) {
>  		check_access(scoped_access->ptr, scoped_access->size,
>  			     scoped_access->type, scoped_access->ip);
>  	}
> -	ctx->scoped_accesses.prev = prev_save;
> +	ctx->disable_scoped--;
>  }
>  
>  /* Rules for generic atomic accesses. Called from fast-path. */
> @@ -465,6 +467,15 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  		goto out;
>  	}
>  
> +	/*
> +	 * Avoid races of scoped accesses from nested interrupts (or scheduler).
> +	 * Assume setting up a watchpoint for a non-scoped (normal) access that
> +	 * also conflicts with a current scoped access. In a nested interrupt,
> +	 * which shares the context, it would check a conflicting scoped access.
> +	 * To avoid, disable scoped access checking.
> +	 */
> +	ctx->disable_scoped++;
> +
>  	/*
>  	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
>  	 * runtime is entered for every memory access, and potentially useful
> @@ -578,6 +589,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
>  	if (!kcsan_interrupt_watcher)
>  		local_irq_restore(irq_flags);
>  	kcsan_restore_irqtrace(current);
> +	ctx->disable_scoped--;
>  out:
>  	user_access_restore(ua_flags);
>  }
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 
