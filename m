Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1DB6C3F63
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 01:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCVA7G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 20:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCVA7G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 20:59:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C357D1E;
        Tue, 21 Mar 2023 17:59:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so66753508edc.3;
        Tue, 21 Mar 2023 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679446743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8yKs2Hu30YhP0Me3c6fPX37b/EvrU0cmnZmogWkvQI=;
        b=ntDGzzUmt8XqElY0V5I9cixjIB2WrKcr3ak2vVl7vsITkOG+z3cazrd9YBYBMyGwbm
         DZpU8sS6yt71vnB1sgHGSjDULOEC+v24D/wFxmBrF9tqyEmtI6ZYFrs/czRWqpn739e+
         Nvxd0phI8I6kzhBlF/FcWWkYAGS066dfM8Ry3Z19FfFJuEwdjXP6tY8b6U05j1Tzy6nP
         R/pZrCMekQf7POi4E1vjLFJhXqv2iL4ruKmFTt1nVwSsO0ba5L1PVucyCPsI4xsfRGXN
         zoOGgjXNrU9VtsjBcufiYl3vcNqj2Bds5mP+EyMFSbT4vKILLbb13UW0T90McISReYle
         eQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679446743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8yKs2Hu30YhP0Me3c6fPX37b/EvrU0cmnZmogWkvQI=;
        b=VhtMEIQ1bUW/x5yJd4rHCMxyJUqWcxFfg9lv7+ugkxlaKXGebafZl46cQNQsz35LAu
         FAXoeFBmEch+K9FeAJ1h8tlottZO/7Iq7mjAU6TH11P/vRjIYiUn/zXjuT6PIZJqFji5
         Ohqc9KiTxLW2dnGDn9bxk9VZy8tURRsluenb6ZLbVNs8VD7FGk+XPtogshzFBotMYlZx
         smZX5itXitMZeBNcDCa2+LCNsbfa98BY36uYXUnE6Dgu5pgG+fcxLir/SbGBghJvldPm
         wk7JuodCPpBVg1wtQ9rb5z2mj99lxg4Qbf1o8GLRHhVZSXqZPXJCzTFPU7QZ5tUd0yRn
         blzg==
X-Gm-Message-State: AO0yUKXNZMiuREgffHRQbasXgB+BsVz5QqAO8FLybINjlt/w8CvPN4Lv
        HYXjrv7d4owFSgiXmldEkwA=
X-Google-Smtp-Source: AK7set/UAKhbBJvj5SSE7BVnmbEYv9k8efLVjCNR2SsU6FMwTFEyOwvRGQozQVLxn+RfaFG85qqQNw==
X-Received: by 2002:a17:906:c04c:b0:92b:5c67:c660 with SMTP id bm12-20020a170906c04c00b0092b5c67c660mr4995293ejb.69.1679446743071;
        Tue, 21 Mar 2023 17:59:03 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090627c800b008d1693c212csm6384115ejc.8.2023.03.21.17.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 17:59:02 -0700 (PDT)
Date:   Wed, 22 Mar 2023 01:59:00 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 2/8] tools/memory-model: Unify UNLOCK+LOCK
 pairings to po-unlock-lock-po
Message-ID: <ZBpS1H2rufhVoCid@andrea>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321010246.50960-2-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 20, 2023 at 06:02:40PM -0700, Paul E. McKenney wrote:
> From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> 
> LKMM uses two relations for talking about UNLOCK+LOCK pairings:
> 
> 	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
> 	   on the same CPU or immediate lock handovers on the same
> 	   lock variable
> 
> 	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
> 	   literally as described in rcupdate.h#L1002, i.e., even
> 	   after a sequence of handovers on the same lock variable.
> 
> The latter relation is used only once, to provide the guarantee
> defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
> makes any UNLOCK+LOCK pair followed by the fence behave like a full
> barrier.
> 
> This patch drops this use in favor of using po-unlock-lock-po
> everywhere, which unifies the way the model talks about UNLOCK+LOCK
> pairings.  At first glance this seems to weaken the guarantee given
> by LKMM: When considering a long sequence of lock handovers
> such as below, where P0 hands the lock to P1, which hands it to P2,
> which finally executes such an after_unlock_lock fence, the mb
> relation currently links any stores in the critical section of P0
> to instructions P2 executes after its fence, but not so after the
> patch.
> 
> P0(int *x, int *y, spinlock_t *mylock)
> {
>         spin_lock(mylock);
>         WRITE_ONCE(*x, 2);
>         spin_unlock(mylock);
>         WRITE_ONCE(*y, 1);
> }
> 
> P1(int *y, int *z, spinlock_t *mylock)
> {
>         int r0 = READ_ONCE(*y); // reads 1
>         spin_lock(mylock);
>         spin_unlock(mylock);
>         WRITE_ONCE(*z,1);
> }
> 
> P2(int *z, int *d, spinlock_t *mylock)
> {
>         int r1 = READ_ONCE(*z); // reads 1
>         spin_lock(mylock);
>         spin_unlock(mylock);
>         smp_mb__after_unlock_lock();
>         WRITE_ONCE(*d,1);
> }
> 
> P3(int *x, int *d)
> {
>         WRITE_ONCE(*d,2);
>         smp_mb();
>         WRITE_ONCE(*x,1);
> }
> 
> exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)
> 
> Nevertheless, the ordering guarantee given in rcupdate.h is actually
> not weakened.  This is because the unlock operations along the
> sequence of handovers are A-cumulative fences.  They ensure that any
> stores that propagate to the CPU performing the first unlock
> operation in the sequence must also propagate to every CPU that
> performs a subsequent lock operation in the sequence.  Therefore any
> such stores will also be ordered correctly by the fence even if only
> the final handover is considered a full barrier.
> 
> Indeed this patch does not affect the behaviors allowed by LKMM at
> all.  The mb relation is used to define ordering through:
> 1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
>    lock-release, rfe, and unlock-acquire orderings each provide hb
> 2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
>    lock-release orderings simply add more fine-grained cumul-fence
>    edges to substitute a single strong-fence edge provided by a long
>    lock handover sequence
> 3) mb/strong-fence/pb and various similar uses in the definition of
>    data races, where as discussed above any long handover sequence
>    can be turned into a sequence of cumul-fence edges that provide
>    the same ordering.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Looks like after-unlock-lock has just won the single fattest inline comment
in linux-kernel.cat.  :-)

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  tools/memory-model/linux-kernel.cat | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 07f884f9b2bf..6e531457bb73 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -37,8 +37,19 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>  	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> -		fencerel(After-unlock-lock) ; [M])
> +(*
> + * Note: The po-unlock-lock-po relation only passes the lock to the direct
> + * successor, perhaps giving the impression that the ordering of the
> + * smp_mb__after_unlock_lock() fence only affects a single lock handover.
> + * However, in a longer sequence of lock handovers, the implicit
> + * A-cumulative release fences of lock-release ensure that any stores that
> + * propagate to one of the involved CPUs before it hands over the lock to
> + * the next CPU will also propagate to the final CPU handing over the lock
> + * to the CPU that executes the fence.  Therefore, all those stores are
> + * also affected by the fence.
> + *)
> +	([M] ; po-unlock-lock-po ;
> +		[After-unlock-lock] ; po ; [M])
>  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>  let strong-fence = mb | gp
>  
> -- 
> 2.40.0.rc2
> 
