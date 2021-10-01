Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA00841E5B2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 03:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351119AbhJABV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351058AbhJABV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 21:21:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BACC06176A;
        Thu, 30 Sep 2021 18:20:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e144so9855750iof.3;
        Thu, 30 Sep 2021 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hVWDhmIP1pz2733bKRI2khM7ndzrEGs5aTcw9T8Uk1Q=;
        b=V/DlQbkf91y3opUGrM9Xm6VB2hWr3LFx8m8GZx6gK8llt1yBFYX7+rm58xHeIvZIuF
         0PWi54IobRm1RuyLbKWPtYfMXEduh3rwbOevMH9o6jmlwp//zVKdodKYZGM2bsLQjfyS
         ZhmIDK2qb3s6J0CJN7e2Lih+1drl6ZKECNHUilEzXcYJmfv8pM65GikpDm6Dj2ujY2jV
         /HHReHs2sLlnfp5cMP1tBSGaVkKp3rxUZsbK3GC0iZ2WspXCAfHN2VeNRsMt0UkVZANy
         dexJKMxIFd+iE6fYxHBhljeWPpuW1WxxBvE2aCQq7J4CiWil1c9M1ypWwhgooc/Sl6eq
         0mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hVWDhmIP1pz2733bKRI2khM7ndzrEGs5aTcw9T8Uk1Q=;
        b=Y1Un4vRruUEGg2EivwSi7ktkx2wPaIcpgI/j1NtnSCPbJojSuuehl/RQs5NzlsaKq8
         fUsaNM/0dyL4U1p89Rdh93M8KvAdLr1Xfl+KZ4KiaCY3e3cSMBK38h/Rm/O4MYjGZFe7
         OHx7s2tyQPgmCXc+MP99TXBpvDNIG62xCXydlvxfuTku6JX1zeAw/o4i9u2LMJ8+dylt
         XY73atrm0PJGusbCN6gyDNY+gl69PukCO1O0DY1myPP+U6vR/pD473Js5TGcPbDGgU/d
         aiw1X5DnJAqrbEHtMYEmASTvYSBST7SeFrMVyDFj2L9r/4FGYSPF3AA7Etb2/vBW6bt6
         21XQ==
X-Gm-Message-State: AOAM533U2Frt5VpfhGCUFZLWiME9iTAnLhzrQRjS5dUJfDRKMNUi/dkZ
        uvQLr16+oO9ANG0QAhtf9t8=
X-Google-Smtp-Source: ABdhPJyLQ+VRCeUb0kynXfokUHp9f1gPKBQnpNOqhkGb35f57yu5hVB89Dmb2+kcWIFkxqVaJTH5yA==
X-Received: by 2002:a05:6602:55:: with SMTP id z21mr6078608ioz.205.1633051214097;
        Thu, 30 Sep 2021 18:20:14 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a4sm693574ild.52.2021.09.30.18.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 18:20:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5026727C005B;
        Thu, 30 Sep 2021 21:20:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 30 Sep 2021 21:20:11 -0400
X-ME-Sender: <xms:SWJWYQcsfxS0hTpq-2woDN3tWVabrHeP5wnzpHF8joOsQ3MdGMC9Pw>
    <xme:SWJWYSMlHuyuv19sCbW7o2o6j-gVqpq4mfH2c4Z1gAEEodpOUGJmuDX50tCj99x68
    jNHG42ZSuejWY-KPg>
X-ME-Received: <xmr:SWJWYRia1yuf_HpLoXJgn_xyrOKnTxUCxdXcuBoxFD3km6jYNcFi2ROBwtRCzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:SWJWYV-YQYLpSjeNcXb5IfCjCCLtLcDL1OX0mJao0FjlmgtA6Py2Ww>
    <xmx:SWJWYcv-qnp34kxwZEYj9qMdx9hZDXFkLwNBDpMFawEZ_ycgMmrO8w>
    <xmx:SWJWYcF6w0lX8xMAVOxI-h5lVxkqssXNrLRSw1zqq8bI_EsZbIprdw>
    <xmx:S2JWYURoMI_DqeMuxW1kUM1qCc9gyrKE8OalC48I9xf7NsgGSi4DXk5ZJj8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Sep 2021 21:20:08 -0400 (EDT)
Date:   Fri, 1 Oct 2021 09:19:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "Paul E . McKenney " <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Alan Stern <stern@rowland.harvard.edu>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Provide extra ordering for
 unlock+lock pair on the same CPU
Message-ID: <YVZiGdWXfbsHs2xa@boqun-archlinux>
References: <20210930130823.2103688-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930130823.2103688-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(Add linux-arch in Cc list)

Architecture maintainers, this patch is about strengthening our memory
model a little bit, your inputs (confirmation, ack/nack, etc.) are
appreciated.

Regards,
Boqun

On Thu, Sep 30, 2021 at 09:08:23PM +0800, Boqun Feng wrote:
> A recent discussion[1] shows that we are in favor of strengthening the
> ordering of unlock + lock on the same CPU: a unlock and a po-after lock
> should provide the so-called RCtso ordering, that is a memory access S
> po-before the unlock should be ordered against a memory access R
> po-after the lock, unless S is a store and R is a load.
> 
> The strengthening meets programmers' expection that "sequence of two
> locked regions to be ordered wrt each other" (from Linus), and can
> reduce the mental burden when using locks. Therefore add it in LKMM.
> 
> [1]: https://lore.kernel.org/lkml/20210909185937.GA12379@rowland.harvard.edu/
> 
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Alan,
> 
> I added the "Co-developed-by" and "Signed-off-by" tags since most of the
> work is done by you. Feel free to let me know if you want to change
> anything.
> 
> Regards,
> Boqun
> 
> 
>  .../Documentation/explanation.txt             | 44 +++++++++++--------
>  tools/memory-model/linux-kernel.cat           |  6 +--
>  ...LB+unlocklockonceonce+poacquireonce.litmus | 33 ++++++++++++++
>  ...unlocklockonceonce+fencermbonceonce.litmus | 33 ++++++++++++++
>  tools/memory-model/litmus-tests/README        |  8 ++++
>  5 files changed, 102 insertions(+), 22 deletions(-)
>  create mode 100644 tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
>  create mode 100644 tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index 5d72f3112e56..394ee57d58f2 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -1813,15 +1813,16 @@ spin_trylock() -- we can call these things lock-releases and
>  lock-acquires -- have two properties beyond those of ordinary releases
>  and acquires.
>  
> -First, when a lock-acquire reads from a lock-release, the LKMM
> -requires that every instruction po-before the lock-release must
> -execute before any instruction po-after the lock-acquire.  This would
> -naturally hold if the release and acquire operations were on different
> -CPUs, but the LKMM says it holds even when they are on the same CPU.
> -For example:
> +First, when a lock-acquire reads from or is po-after a lock-release,
> +the LKMM requires that every instruction po-before the lock-release
> +must execute before any instruction po-after the lock-acquire.  This
> +would naturally hold if the release and acquire operations were on
> +different CPUs and accessed the same lock variable, but the LKMM says
> +it also holds when they are on the same CPU, even if they access
> +different lock variables.  For example:
>  
>  	int x, y;
> -	spinlock_t s;
> +	spinlock_t s, t;
>  
>  	P0()
>  	{
> @@ -1830,9 +1831,9 @@ For example:
>  		spin_lock(&s);
>  		r1 = READ_ONCE(x);
>  		spin_unlock(&s);
> -		spin_lock(&s);
> +		spin_lock(&t);
>  		r2 = READ_ONCE(y);
> -		spin_unlock(&s);
> +		spin_unlock(&t);
>  	}
>  
>  	P1()
> @@ -1842,10 +1843,10 @@ For example:
>  		WRITE_ONCE(x, 1);
>  	}
>  
> -Here the second spin_lock() reads from the first spin_unlock(), and
> -therefore the load of x must execute before the load of y.  Thus we
> -cannot have r1 = 1 and r2 = 0 at the end (this is an instance of the
> -MP pattern).
> +Here the second spin_lock() is po-after the first spin_unlock(), and
> +therefore the load of x must execute before the load of y, even though
> +the two locking operations use different locks.  Thus we cannot have
> +r1 = 1 and r2 = 0 at the end (this is an instance of the MP pattern).
>  
>  This requirement does not apply to ordinary release and acquire
>  fences, only to lock-related operations.  For instance, suppose P0()
> @@ -1872,13 +1873,13 @@ instructions in the following order:
>  
>  and thus it could load y before x, obtaining r2 = 0 and r1 = 1.
>  
> -Second, when a lock-acquire reads from a lock-release, and some other
> -stores W and W' occur po-before the lock-release and po-after the
> -lock-acquire respectively, the LKMM requires that W must propagate to
> -each CPU before W' does.  For example, consider:
> +Second, when a lock-acquire reads from or is po-after a lock-release,
> +and some other stores W and W' occur po-before the lock-release and
> +po-after the lock-acquire respectively, the LKMM requires that W must
> +propagate to each CPU before W' does.  For example, consider:
>  
>  	int x, y;
> -	spinlock_t x;
> +	spinlock_t s;
>  
>  	P0()
>  	{
> @@ -1908,7 +1909,12 @@ each CPU before W' does.  For example, consider:
>  
>  If r1 = 1 at the end then the spin_lock() in P1 must have read from
>  the spin_unlock() in P0.  Hence the store to x must propagate to P2
> -before the store to y does, so we cannot have r2 = 1 and r3 = 0.
> +before the store to y does, so we cannot have r2 = 1 and r3 = 0.  But
> +if P1 had used a lock variable different from s, the writes could have
> +propagated in either order.  (On the other hand, if the code in P0 and
> +P1 had all executed on a single CPU, as in the example before this
> +one, then the writes would have propagated in order even if the two
> +critical sections used different lock variables.)
>  
>  These two special requirements for lock-release and lock-acquire do
>  not arise from the operational model.  Nevertheless, kernel developers
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 2a9b4fe4a84e..d70315fddef6 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -27,7 +27,7 @@ include "lock.cat"
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> +let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
>  
>  (* Fences *)
>  let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
> @@ -70,12 +70,12 @@ let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
>  let to-r = addr | (dep ; [Marked] ; rfi)
> -let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
> +let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = (rfe ; [Marked])? ; r
>  let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> -	po-unlock-rf-lock-po) ; [Marked]
> +	po-unlock-lock-po) ; [Marked]
>  let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
>  	[Marked] ; rfe? ; [Marked]
>  
> diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> new file mode 100644
> index 000000000000..955b9c7cdc7f
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> @@ -0,0 +1,33 @@
> +C LB+unlocklockonceonce+poacquireonce
> +
> +(*
> + * Result: Never
> + *
> + * If two locked critical sections execute on the same CPU, all accesses
> + * in the first must execute before any accesses in the second, even if
> + * the critical sections are protected by different locks.
> + *)
> +
> +{}
> +
> +P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
> +{
> +	int r1;
> +
> +	spin_lock(s);
> +	r1 = READ_ONCE(*x);
> +	spin_unlock(s);
> +	spin_lock(t);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(t);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r2;
> +
> +	r2 = smp_load_acquire(y);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r1=1 /\ 1:r2=1)
> diff --git a/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
> new file mode 100644
> index 000000000000..2feb1398be71
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+unlocklockonceonce+fencermbonceonce.litmus
> @@ -0,0 +1,33 @@
> +C MP+unlocklockonceonce+fencermbonceonce
> +
> +(*
> + * Result: Never
> + *
> + * If two locked critical sections execute on the same CPU, stores in the
> + * first must propagate to each CPU before stores in the second do, even if
> + * the critical sections are protected by different locks.
> + *)
> +
> +{}
> +
> +P0(spinlock_t *s, spinlock_t *t, int *x, int *y)
> +{
> +	spin_lock(s);
> +	WRITE_ONCE(*x, 1);
> +	spin_unlock(s);
> +	spin_lock(t);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(t);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r1;
> +	int r2;
> +
> +	r1 = READ_ONCE(*y);
> +	smp_rmb();
> +	r2 = READ_ONCE(*x);
> +}
> +
> +exists (1:r1=1 /\ 1:r2=0)
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 681f9067fa9e..d311a0ff1ae6 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -63,6 +63,10 @@ LB+poonceonces.litmus
>  	As above, but with store-release replaced with WRITE_ONCE()
>  	and load-acquire replaced with READ_ONCE().
>  
> +LB+unlocklockonceonce+poacquireonce.litmus
> +	Does a unlock+lock pair provides ordering guarantee between a
> +	load and a store?
> +
>  MP+onceassign+derefonce.litmus
>  	As below, but with rcu_assign_pointer() and an rcu_dereference().
>  
> @@ -90,6 +94,10 @@ MP+porevlocks.litmus
>  	As below, but with the first access of the writer process
>  	and the second access of reader process protected by a lock.
>  
> +MP+unlocklockonceonce+fencermbonceonce.litmus
> +	Does a unlock+lock pair provides ordering guarantee between a
> +	store and another store?
> +
>  MP+fencewmbonceonce+fencermbonceonce.litmus
>  	Does a smp_wmb() (between the stores) and an smp_rmb() (between
>  	the loads) suffice for the message-passing litmus test, where one
> -- 
> 2.32.0
> 
