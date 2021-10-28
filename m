Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5188343F39F
	for <lists+linux-arch@lfdr.de>; Fri, 29 Oct 2021 01:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhJ1XzY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Oct 2021 19:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhJ1XzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Oct 2021 19:55:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C203C061745;
        Thu, 28 Oct 2021 16:52:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id n2so7522018qta.2;
        Thu, 28 Oct 2021 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NnQOX+vJ/hz7aU5gFRyXr2o8xbDUVOD1eunK5mgwKTw=;
        b=oPXMfKDcVrBcZSI+56TY2EqBQjiD+IhZ3pIjQPx3nCCny+NEKewbWkB1LLUU3wpYX7
         T+kv05jIRq6idredz67ydYKNIiJVv9WrIKlG0tZnN95veJ4nFHs1OriJKnB+ASDsIOGK
         UlLGVkqydm0dLvVvaN9WEc3TnkBb2wpYoV0JxY9xhXwOaIrmQ9Aq4k613eZaRqTNeeBQ
         f3BmafosYSlLHPPj1ceZYETzC3AxZp07cXfYsvrTgVAJRKm1nwZnn0jic/xrGCaIxt9W
         Vgb93xZg3qTQgibWq0v6VICRXei1jOXOnEfCctg/cS/+2lqJEqbohvzAS9O1likoFoEm
         KvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NnQOX+vJ/hz7aU5gFRyXr2o8xbDUVOD1eunK5mgwKTw=;
        b=KAWOgzJsoPZRMaP+U9VsNaQr0RL7rDUq6jAqmRaMV2aVZQ74kj0tkDdO/R6p5NnlS0
         0Q6dl/S8doZzfI2UcBfpRvzsiNpGzu0hVVLkR4A7R4svcqFT8doV2PAqfl/ki7FzhFCA
         4WPMaKdceHGB90NRvMUArRKmSxOxl+iqDrhcFtJiRyYWRHllBBqtEZWPXM2ovng9sgVk
         KkEfUW3FE81fJUiM4hu06/SvT7L7OJKRBeAtMBPxM+HDeFx6ANAYANjllXTvuHjbXbD0
         rH2vf3cDo9PzptJCO9xCyn9bgG0ZMONJlLKUme3Xt2lXq9axd87DSFSg/iJVip/K4krw
         bjhA==
X-Gm-Message-State: AOAM531jmNhKS5S5UH/ghPG8NrRYz+/AJMMoexOlf80PFlLqwlSLZsZC
        UU1OCFTzdnGYlfs05RLGeZM=
X-Google-Smtp-Source: ABdhPJwKfB7BymxsZPOKR8rKtkU8yKoriuhXHlE1GcbNagl/BJUD4qQF3xnCF4lr+XxlI4Ta/erpzA==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr8206131qta.256.1635465151697;
        Thu, 28 Oct 2021 16:52:31 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o11sm3191122qkp.77.2021.10.28.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 16:52:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7EF6727C005B;
        Thu, 28 Oct 2021 19:52:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Oct 2021 19:52:28 -0400
X-ME-Sender: <xms:ujd7YewAar1tiIshr0M11t08Jlrf1CUkQOoNGBwIugFMyqNXcpG7Pw>
    <xme:ujd7YaSIfKzvaZZlsxKrJ5477O2A3DklLjhqxxHUNr_tiMFm5JjK-Iy8cNrLDlJD2
    8FT4i3rVPiBKteW2A>
X-ME-Received: <xmr:ujd7YQXeWXok1zsRs_DevKasa1ihR9c37HYpdXrr-TNFqtPd9i0z171apeWIBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeggedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ujd7YUhyOx3uAw959fn21MFMC0gqc0y14rfnX21T1owQdm9OcHJAnQ>
    <xmx:ujd7YQAdoOH4WtVBsiTdx6--DMho-XGM4RE2cRXyZ3ekj1s-Ijhl_Q>
    <xmx:ujd7YVL1ICi33_IDGrp6wDUDQlXakypXRRTa_jTS8YN00ZCr4YtsSQ>
    <xmx:vDd7YS6fGhlTizoyoW8tCLVMzUWn_V8bHIKO3p4sqcd1gWMY-bnt79pnFr0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Oct 2021 19:52:25 -0400 (EDT)
Date:   Fri, 29 Oct 2021 07:51:39 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Dan Lustig <dlustig@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC v2 3/3] tools/memory-model: litmus: Add two tests for
 unlock(A)+lock(B) ordering
Message-ID: <YXs3i8g+GHYbRCRQ@boqun-archlinux>
References: <20211025145416.698183-1-boqun.feng@gmail.com>
 <20211025145416.698183-4-boqun.feng@gmail.com>
 <YXenrNeS+IaSDwvU@hirez.programming.kicks-ass.net>
 <20211028191129.GJ880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028191129.GJ880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 28, 2021 at 12:11:29PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 26, 2021 at 09:01:00AM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 25, 2021 at 10:54:16PM +0800, Boqun Feng wrote:
> > > diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> > > new file mode 100644
> > > index 000000000000..955b9c7cdc7f
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> > > @@ -0,0 +1,33 @@
> > > +C LB+unlocklockonceonce+poacquireonce
> > > +
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * If two locked critical sections execute on the same CPU, all accesses
> > > + * in the first must execute before any accesses in the second, even if
> > > + * the critical sections are protected by different locks.
> > 
> > One small nit; the above "all accesses" reads as if:
> > 
> > 	spin_lock(s);
> > 	WRITE_ONCE(*x, 1);
> > 	spin_unlock(s);
> > 	spin_lock(t);
> > 	r1 = READ_ONCE(*y);
> > 	spin_unlock(t);
> > 
> > would also work, except of course that's the one reorder allowed by TSO.
> 
> I applied this series with Peter's Acked-by, and with the above comment

Thanks!

> reading as follows:
> 
> +(*
> + * Result: Never
> + *
> + * If two locked critical sections execute on the same CPU, all accesses
> + * in the first must execute before any accesses in the second, even if the
> + * critical sections are protected by different locks.  The one exception
> + * to this rule is that (consistent with TSO) a prior write can be reordered
> + * with a later read from the viewpoint of a process not holding both locks.

Just want to be accurate, in our memory model "execute" means a CPU
commit an memory access instruction to the Memory Subsystem, so if we
have a store W and a load R, where W executes before R, it doesn't mean
the memory effect of W is observed before the memory effect of R by
other CPUs, consider the following case


	CPU0			Memory Subsystem		CPU1
	====							====
	WRITE_ONCE(*x,1); // W ---------->|
	spin_unlock(s);                   |
	spin_lock(t);                     |
	r1 = READ_ONCE(*y); // R -------->|
	// R reads 0                      |
					  |<----------------WRITR_ONCE(*y, 1); // W'
		 W' propagates to CPU0    |
		<-------------------------|
					  |                 smp_mb();
					  |<----------------r1 = READ_ONCE(*x); // R' reads 0
					  |
					  | W progrates to CPU 1
		                          |----------------->

The "->" from CPU0 to the Memory Subsystem shows that W executes before
R, however the memory effect of a store can be observed only after the
Memory Subsystem propagates it to another CPU, as a result CPU1 doesn't
observe W before R is executed. So the original version of the comments
is correct in our memory model terminology, at least that's how I
understand it, Alan can correct me if I'm wrong.

Maybe it's better to replace the sentence starting with "The one
exception..." into:

One thing to notice is that even though a write executes by a read, the
memory effects can still be reordered from the viewpoint of a process
not holding both locks, similar to TSO ordering.

Thoughts?

Apologies for responsing late...

("Memory Subsystem" is an abstraction in our memory model, which doesn't
mean hardware implements things in the same way.).

Regards,
Boqun

> + *)
> 
> Thank you all!
> 
> 							Thanx, Paul
