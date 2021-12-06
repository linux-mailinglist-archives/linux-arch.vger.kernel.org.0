Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40C346A298
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhLFRVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 12:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhLFRVQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 12:21:16 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C5C061746;
        Mon,  6 Dec 2021 09:17:48 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x6so13684611iol.13;
        Mon, 06 Dec 2021 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNz3Q2mlKF711FA8wRX14koPJl39WuNweWYokTQs3qU=;
        b=AwTjbe4JskmjdVEHzHOR1FdY/bm5eSzHzio26QFOYCc4QTlRRzGcpZNWTOmwvHCWUv
         DiqrMq/laf0baqEnExZnhGWJKVAglgQlB5NsUUWLKUwqb2iV/QKTGcmMGoD9vU/9feFA
         quH5Q1HK3vDzFEBvRHE/9Eivv+9WOGhA8iHL3DvHJ9lDL8Jos11pIxhEIxw6WdgW0Yqg
         QkFnXjVRfF7DHU4l7BLLaLBGCLmt4SfnIAXjFGMxZaXGDMH3CWALYiBYrk5Z64efPGYB
         vFzg5dlqju1UrQ0pHToAb5NTDBE+tw9NU3sswbWCeRDeiQYpFCJz7YLYwDCnqA+0uVyA
         xu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNz3Q2mlKF711FA8wRX14koPJl39WuNweWYokTQs3qU=;
        b=PxA9jgZkpAOfz9/NCAXAmWxjwx2AYyVifF3vHUJZowrtqGgEneSDortWD1VHaAeiF7
         NhKhuyRm+kmrkn1EpUAeryKueArtAedEM6M59SPB6Nrqu1q9RZ2B9Znk51DL20Fk2BZO
         dmFwW3NmR4tc4iN4E8vsdY0xLK2sadQpyJpwzJXj0tM0o+3f6VLfIpZck9fot6WB6l4L
         fCK1u/jNIOqe7k4EHcE26/pVinnQV9jpwuQoq1Ezha/ueZQ12Jl2Fw4fJASj6sqynMGy
         3Tflvt8Nc71vdbOdkIPFL6/bFYxhxBoT4eGCz4A+y2OgtXPqGs084ONdeVuP0wfwT21J
         /miQ==
X-Gm-Message-State: AOAM530Ql49uDBeNvq1W8KflA/axEW2akoo1SxKooavuacUXAO3N0dKx
        mFmIoXJwWHA90XWmXwBlDEg=
X-Google-Smtp-Source: ABdhPJyv3jGlqSSJnIRJD424hIOvjpgEoXREUM7M0+VcqmqFV24bQgbl0uhMJAoKJXaUpVwvcHznpA==
X-Received: by 2002:a05:6602:1609:: with SMTP id x9mr34726304iow.6.1638811067376;
        Mon, 06 Dec 2021 09:17:47 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r3sm7030982iob.0.2021.12.06.09.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:17:46 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 25CDA27C0064;
        Mon,  6 Dec 2021 12:17:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Dec 2021 12:17:45 -0500
X-ME-Sender: <xms:uEWuYRL6RqCVh9V3LkBudn5KYREbsDRCjuiN-cl8F70X7lyS0mr_rg>
    <xme:uEWuYdLBcm8HMsTIZHEtW3eC5SLqY5ZixKc0iNd6yNf7oDRyfKBxpvc6_IQmuznM9
    lK2wG3c54QHTKjPPg>
X-ME-Received: <xmr:uEWuYZuK907atpfMNOGoJQhb2DJdLvggEQr5O0xJcD-wP4az-iZ1jntpGAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeefgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:uEWuYSaytHv6obCwpvVYsaka6TAVJfASY-_U-6UHW7fT8npY7zLJgw>
    <xmx:uEWuYYbCSW8fc1jNaUS3QD9CpdcyfsjkGo05j9PrYu_W-wiiEgY8VQ>
    <xmx:uEWuYWDTmq8SilnEKWAlXn5qYibumEtJumw0ZCN9X2wrVA_EuUkn5w>
    <xmx:uEWuYVRqeVwd13UKriZ4Y4jbXM16FeexZmySUNfPq7czO1EXmpb6_uWshfo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Dec 2021 12:17:44 -0500 (EST)
Date:   Tue, 7 Dec 2021 01:16:25 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v3 08/25] kcsan: Show location access was reordered to
Message-ID: <Ya5FaU9e6XY8vHJR@boqun-archlinux>
References: <20211130114433.2580590-1-elver@google.com>
 <20211130114433.2580590-9-elver@google.com>
 <Ya2Zpf8qpgDYiGqM@boqun-archlinux>
 <CANpmjNMirKGSBW2m+bWRM9_FnjK3_HjnJC=dhyMktx50mwh1GQ@mail.gmail.com>
 <Ya4evHE7uQ9eXpax@boqun-archlinux>
 <Ya40hEQv5SEu7ZeL@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya40hEQv5SEu7ZeL@elver.google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 06, 2021 at 05:04:20PM +0100, Marco Elver wrote:
> On Mon, Dec 06, 2021 at 10:31PM +0800, Boqun Feng wrote:
> [...]
> > Thanks for the explanation, I was missing the swap here. However...
> > 
> > > So in your above example you need to swap "reordered to" and the top
> > > frame of the stack trace.
> > > 
> 
> Apologies, I wasn't entirely precise ... what you say below is correct.
> 
> > IIUC, the report for my above example will be:
> > 
> >          | write (reordered) to 0xaaaa of ...:
> >          | foo+0x... // address of the write to A
> >          | ...
> >          |  |
> >          |  +-> reordered to: foo+0x... // address of the callsite to bar() in foo()
> > 
> > , right? Because in replace_stack_entry(), it's not the top frame where
> > the race occurred that gets swapped, it's the frame which belongs to the
> > same function as the original access that gets swapped. In other words,
> > when KCSAN finds the problem, top entries of the calling stack are:
> > 
> > 	[0] bar+0x.. // address of the write to B
> > 	[1] foo+0x.. // address of the callsite to bar() in foo()
> > 
> > after replace_stack_entry(), they changes to:
> > 
> > 	[0] bar+0x.. // address of the write to B
> > skip  ->[1] foo+0x.. // address of the write to A
> > 
> > , as a result the report won't mention bar() at all.
> 
> Correct.
> 
> > And I think a better report will be:
> > 
> >          | write (reordered) to 0xaaaa of ...:
> >          | foo+0x... // address of the write to A
> >          | ...
> >          |  |
> >          |  +-> reordered to: bar+0x... // address of the write to B in bar()
> > 
> > because it tells users the exact place the accesses get reordered. That
> > means maybe we want something as below? Not completely tested, but I
> > play with scope checking a bit, seems it gives what I want. Thoughts?
> 
> This is problematic because it makes it much harder to actually figure
> out what's going on, given "reordered to" isn't a full stack trace. So
> if you're deep in some call hierarchy, seeing a random "reordered to"
> line is quite useless. What I want to see, at the very least, is the ip
> to the same function where the original access happened.
> 
> We could of course try and generate a full stack trace at "reordered
> to", but this would entail
> 
> 	a) allocating 2x unsigned long[64] on the stack (or moving to
> 	   static storage),
> 	b) further increasing the report length,
> 	c) an even larger number of possibly distinct reports for the
> 	   same issue; this makes deduplication even harder.
> 
> The reason I couldn't justify all that is that when I looked through
> several dozen "reordered to" reports, I never found anything other than
> the ip in the function frame of the original access useful. That, and in
> most cases the "reordered to" location was in the same function or in an
> inlined function.
> 
> The below patch would do what you'd want I think.
> 
> My opinion is to err on the side of simplicity until there is evidence
> we need it. Of course, if you have a compelling reason that we need it
> from the beginning, happy to send it as a separate patch on top.
> 
> What do you think?
> 

Totally agreed. It's better to keep it simple until people report that
they want to see more information to resolve the issues. And thanks for
looking into the "double stack traces", that looks good to me too.

For the original patch, feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Date: Mon, 6 Dec 2021 16:35:02 +0100
> Subject: [PATCH] kcsan: Show full stack trace of reordered-to accesses
> 
> Change reports involving reordered accesses to show the full stack trace
> of "reordered to" accesses. For example:
> 
>  | ==================================================================
>  | BUG: KCSAN: data-race in test_kernel_wrong_memorder / test_kernel_wrong_memorder
>  |
>  | read-write to 0xffffffffc02d01e8 of 8 bytes by task 2481 on cpu 2:
>  |  test_kernel_wrong_memorder+0x57/0x90
>  |  access_thread+0xb7/0x100
>  |  kthread+0x2ed/0x320
>  |  ret_from_fork+0x22/0x30
>  |
>  | read-write (reordered) to 0xffffffffc02d01e8 of 8 bytes by task 2480 on cpu 0:
>  |  test_kernel_wrong_memorder+0x57/0x90
>  |  access_thread+0xb7/0x100
>  |  kthread+0x2ed/0x320
>  |  ret_from_fork+0x22/0x30
>  |   |
>  |   +-> reordered to: test_delay+0x31/0x110
>  |                     test_kernel_wrong_memorder+0x80/0x90
>  |
>  | Reported by Kernel Concurrency Sanitizer on:
>  | CPU: 0 PID: 2480 Comm: access_thread Not tainted 5.16.0-rc1+ #2
>  | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  | ==================================================================
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/kcsan/report.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 67794404042a..a8317d5f5123 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -317,22 +317,29 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
>  {
>  	unsigned long symbolsize, offset;
>  	unsigned long target_func;
> -	int skip;
> +	int skip, i;
>  
>  	if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
>  		target_func = ip - offset;
>  	else
>  		goto fallback;
>  
> -	for (skip = 0; skip < num_entries; ++skip) {
> +	skip = get_stack_skipnr(stack_entries, num_entries);
> +	for (i = 0; skip < num_entries; ++skip, ++i) {
>  		unsigned long func = stack_entries[skip];
>  
>  		if (!kallsyms_lookup_size_offset(func, &symbolsize, &offset))
>  			goto fallback;
>  		func -= offset;
>  
> +		replaced[i] = stack_entries[skip];
>  		if (func == target_func) {
> -			*replaced = stack_entries[skip];
> +			/*
> +			 * There must be at least 1 entry left in the original
> +			 * @stack_entries, so we know that we will never occupy
> +			 * more than @num_entries - 1 of @replaced.
> +			 */
> +			replaced[i + 1] = 0;
>  			stack_entries[skip] = ip;
>  			return skip;
>  		}
> @@ -341,6 +348,7 @@ replace_stack_entry(unsigned long stack_entries[], int num_entries, unsigned lon
>  fallback:
>  	/* Should not happen; the resulting stack trace is likely misleading. */
>  	WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void *)ip);
> +	replaced[0] = 0;
>  	return get_stack_skipnr(stack_entries, num_entries);
>  }
>  
> @@ -365,11 +373,16 @@ static int sym_strcmp(void *addr1, void *addr2)
>  }
>  
>  static void
> -print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long reordered_to)
> +print_stack_trace(unsigned long stack_entries[], int num_entries, unsigned long *reordered_to)
>  {
>  	stack_trace_print(stack_entries, num_entries, 0);
> -	if (reordered_to)
> -		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to);
> +	if (reordered_to[0]) {
> +		int i;
> +
> +		pr_err("  |\n  +-> reordered to: %pS\n", (void *)reordered_to[0]);
> +		for (i = 1; i < NUM_STACK_ENTRIES && reordered_to[i]; ++i)
> +			pr_err("                    %pS\n", (void *)reordered_to[i]);
> +	}
>  }
>  
>  static void print_verbose_info(struct task_struct *task)
> @@ -390,12 +403,12 @@ static void print_report(enum kcsan_value_change value_change,
>  			 struct other_info *other_info,
>  			 u64 old, u64 new, u64 mask)
>  {
> -	unsigned long reordered_to = 0;
> +	unsigned long reordered_to[NUM_STACK_ENTRIES] = { 0 };
>  	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
>  	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
> -	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip, &reordered_to);
> +	int skipnr = sanitize_stack_entries(stack_entries, num_stack_entries, ai->ip, reordered_to);
>  	unsigned long this_frame = stack_entries[skipnr];
> -	unsigned long other_reordered_to = 0;
> +	unsigned long other_reordered_to[NUM_STACK_ENTRIES] = { 0 };
>  	unsigned long other_frame = 0;
>  	int other_skipnr = 0; /* silence uninit warnings */
>  
> @@ -408,7 +421,7 @@ static void print_report(enum kcsan_value_change value_change,
>  	if (other_info) {
>  		other_skipnr = sanitize_stack_entries(other_info->stack_entries,
>  						      other_info->num_stack_entries,
> -						      other_info->ai.ip, &other_reordered_to);
> +						      other_info->ai.ip, other_reordered_to);
>  		other_frame = other_info->stack_entries[other_skipnr];
>  
>  		/* @value_change is only known for the other thread */
> -- 
> 2.34.1.400.ga245620fadb-goog
> 
