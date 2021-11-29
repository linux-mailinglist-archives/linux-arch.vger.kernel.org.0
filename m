Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184F461BFA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Nov 2021 17:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345838AbhK2Qqh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Nov 2021 11:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbhK2Qoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2021 11:44:37 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B09C0AD152;
        Mon, 29 Nov 2021 06:27:49 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m5so17501779ilh.11;
        Mon, 29 Nov 2021 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmdX7iVA88wv2FQ0G9icVb8l+LFoewmSUQ3H2Hqr1hY=;
        b=aICLz5H2eaDTHAjyMX6zwpInhUjmtso2Mby1/mf7ZVAk5NHUvl81PfqUnEvvMTSGsJ
         atHaFiUQkJfbceXvoRFeqcw2Rv+t3UgA1jx9fPLtnXGxAFMxLmQoSLjMd99fRYHVtk1N
         kIi0RPnt/D4tB5bDrKrhLjdVBQkzPhacefs5SJvV1nvyXK+U2AkKzTjnQmP9FVzRSmst
         mQlcHZbOPC8L20Z6jrTIYiFQfWEM+YCdZYVKjGMyXXKaJcPA5ydpGjOmI2FMmPGLDJ3s
         qk/D1MQPQzKgnHIhUsoh08mT49vtX2xxAZYubuWXUs8TIkdJ5B/ErVwkK7FP1xuggHcE
         yXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmdX7iVA88wv2FQ0G9icVb8l+LFoewmSUQ3H2Hqr1hY=;
        b=Yy4F7h7MmwlALGVNKi//EldhFbToYFbfjge7LOgrDwsAI8s/y/6R8igDdAvZaimTWh
         TIAaC+XhnlRwA8M1bZrH62q66XoZHm1PRgUfBcxN/abmJdQTIqEVi71+K+IGFLEaWcoJ
         QkN4mldaWrdqRlV9PsPoowdyrFVgAWQxavdwP9xhZ/DODigk3hmiHwsCI9G2s3NZ1GJL
         qeCowXWGzZqCClWaAAW/BtlpcfEzOqDEmqikYLsSvgZHZ6grWp2W6yvTvoAo6avmR364
         /z8K8Vpclpt6cdKEfMY1bloT0wIZC6fI81Rcb2jm5c0GdSeWn2Yzj8zci0jhqnVBxGpU
         2/lw==
X-Gm-Message-State: AOAM532wv4RklCCk6niJE1BRi1r+SANToCRmRuGSd64hbnkiipjzkzUW
        L9f9SFWmhTmH/EpsIZqujxQ=
X-Google-Smtp-Source: ABdhPJyYdDkwGECXZ3EnuTu7M3T0UaxFiBNYjKBWQZcoLT1tC++Ij3DZmrvBsflI3jUl1N/BP1bzBg==
X-Received: by 2002:a05:6e02:12ad:: with SMTP id f13mr54480526ilr.33.1638196068554;
        Mon, 29 Nov 2021 06:27:48 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q1sm11659103ilu.51.2021.11.29.06.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:27:47 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 241A527C005B;
        Mon, 29 Nov 2021 09:27:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Nov 2021 09:27:46 -0500
X-ME-Sender: <xms:YOOkYbh7klpga0xeJMK_4SwVTmKU6LPR29j_DscfM78ixeu6h4PKrw>
    <xme:YOOkYYAZHBFmYZqgwHwh-j4odpu4RgGSdwI09kQi7U9MD5mj_JUoPnsRdpvg1nknW
    DIu9x_braHC8LsehQ>
X-ME-Received: <xmr:YOOkYbEzQAF2kC-5DkjjAU0obgUm-mCim6bxgBlOhvIPzgMlMIt1SKyaum9Erg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrheelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:YOOkYYR01qDBRr85CjtjOZrPpgJRViyenu70Wmprvco913N1CuwtGQ>
    <xmx:YOOkYYz48UXMSs2YbzHbPvJiXEtAnxd-5lQy9BmybCo-a4oDkKadNg>
    <xmx:YOOkYe43SzcRZ_fbVwcVjStgzmEh-C_0jdWa9ubanIbdHGKWUgLqbw>
    <xmx:YeOkYZrYWSDwVHvnUFjKja1KjCGpCtY0P9c-5rAScLj8JGF4XN2jaRlkXKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Nov 2021 09:27:44 -0500 (EST)
Date:   Mon, 29 Nov 2021 22:26:46 +0800
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
Message-ID: <YaTjJnl+Wc1qZbG/@boqun-archlinux>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-4-elver@google.com>
 <YaSTn3JbkHsiV5Tm@boqun-archlinux>
 <YaSyGr4vW3yifWWC@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaSyGr4vW3yifWWC@elver.google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 29, 2021 at 11:57:30AM +0100, Marco Elver wrote:
> On Mon, Nov 29, 2021 at 04:47PM +0800, Boqun Feng wrote:
> > Hi Marco,
> > 
> > On Thu, Nov 18, 2021 at 09:10:07AM +0100, Marco Elver wrote:
> > > Avoid checking scoped accesses from nested contexts (such as nested
> > > interrupts or in scheduler code) which share the same kcsan_ctx.
> > > 
> > > This is to avoid detecting false positive races of accesses in the same
> > 
> > Could you provide an example for a false positive?
> > 
> > I think we do want to detect the following race:
> > 
> > 	static int v = SOME_VALUE; // a percpu variable.
> > 	static int other_v = ... ;
> > 
> > 	void foo(..)
> > 	{
> > 		int tmp;
> > 		int other_tmp;
> > 
> > 		preempt_disable();
> > 		{
> > 			ASSERT_EXCLUSIVE_ACCESSS_SCOPED(v);
> > 			tmp = v;
> > 			
> > 			other_tmp = other_v; // int_handler() may run here
> > 			
> > 			v = tmp + 2;
> > 		}
> > 		preempt_enabled();
> > 	}
> > 
> > 	void int_handler() // an interrupt handler
> > 	{
> > 		v++;
> > 	}
> > 
> > , if I understand correctly, we can detect this currently, but with this
> > patch, we cannot detect this if the interrupt happens while we're doing
> > the check for "other_tmp = other_v;", right? Of course, running tests
> > multiple times may eventually catch this, but I just want to understand
> > what's this patch for, thanks!
> 
> The above will still be detected. Task and interrupt contexts in this
> case are distinct, i.e. kcsan_ctx differ (see get_ctx()).
> 

Ok, I was missing that.

> But there are rare cases where kcsan_ctx is shared, such as nested
> interrupts (NMI?), or when entering scheduler code -- which currently
> has a KCSAN_SANITIZE := n, but I occasionally test it, which is how I
> found this problem. The problem occurs frequently when enabling KCSAN in
> kernel/sched and placing a random ASSERT_EXCLUSIVE_ACCESS_SCOPED() in
> task context, or just enable "weak memory modeling" without this fix.
> You also need CONFIG_PREEMPT=y + CONFIG_KCSAN_INTERRUPT_WATCHER=y.
> 

Thanks for the background, it's now more clear that the problem is
triggered ;-)

> The emphasis here really is on _shared kcsan_ctx_, which is not too
> common. As noted in the commit description, we need to "[...] setting up
> a watchpoint for a non-scoped (normal) access that also "conflicts" with
> a current scoped access."
> 
> Consider this:
> 
> 	static int v;
> 	int foo(..)
> 	{
> 		ASSERT_EXCLUSIVE_ACCESS_SCOPED(v);
> 		v++; // preempted during watchpoint for 'v++'
> 	}
> 
> Here we set up a scoped_access to be checked for v. Then on v++, a
> watchpoint is set up for the normal access. While the watchpoint is set
> up, the task is preempted and upon entering scheduler code, we're still
> in_task() and 'current' is still the same, thus get_ctx() returns a
> kcsan_ctx where the scoped_accesses list is non-empty containing the
> scoped access for foo()'s ASSERT_EXCLUSIVE.
> 
> That means, when instrumenting scheduler code or any other code called
> by scheduler code or nested interrupts (anything where get_ctx() still
> returns the same as parent context), it'd now perform checks based on
> the parent context's scoped access, and because the parent context also
> has a watchpoint set up on the variable that conflicts with the scoped
> access we'd report a nonsensical race.
> 

Agreed.

> This case is also possible:
> 
> 	static int v;
> 	static int x;
> 	int foo(..)
> 	{
> 		ASSERT_EXCLUSIVE_ACCESS_SCOPED(v);
> 		x++; // preempted during watchpoint for 'v' after checking x++
> 	}
> 
> Here, all we need is for the scoped access to be checked after x++, end
> up with a watchpoint for it, then enter scheduler code, which then
> checked 'v', sees the conflicting watchpoint, and reports a nonsensical
> race again.
> 

Just to be clear, in both examples, the assumption is that 'v' is a
variable that scheduler code doesn't access, right? Because if scheduler
code does access 'v', then it's a problem that KCSAN should report. Yes,
I don't know any variable that scheduler exports, just to make sure
here.

> By disallowing scoped access checking for a kcsan_ctx, we simply make
> sure that in such nested contexts where kcsan_ctx is shared, none of
> these nonsensical races would be detected nor reported.
> 
> Hopefully that clarifies what this is about.
> 

Make sense to me, thanks.

Regards,
Boqun

> Thanks,
> -- Marco
