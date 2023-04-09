Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DFC6DBE93
	for <lists+linux-arch@lfdr.de>; Sun,  9 Apr 2023 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDIE3V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Apr 2023 00:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIE3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Apr 2023 00:29:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE559ED
        for <linux-arch@vger.kernel.org>; Sat,  8 Apr 2023 21:29:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ek19so1556582qvb.9
        for <linux-arch@vger.kernel.org>; Sat, 08 Apr 2023 21:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681014558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDuFy9RPjn4n6kcj3GDtjcBDkENRtGj7xCf7X4HUB5g=;
        b=d4wiQoURlizx8dQxnBgls3y2Y3NLZxLGGqOlct0UigRk/Z8vXJFXimbhdqurCqikSs
         mbWNjv1P+vuVmWnxLCMNCX7hZUtgsERrY3g4rcYWYPBMi/IgpJFqvsHLNQNo81Lb0zG7
         9Mg8rq1krY1m1L0jFI2zjhI9pvWGQhuQh+SGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681014558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDuFy9RPjn4n6kcj3GDtjcBDkENRtGj7xCf7X4HUB5g=;
        b=E4xBAY9M7E4zN4OmY3FTOTEmMbR29D51ieODPqp2l2Jqesen/77pr5VK+IjUchkeyQ
         V5PMy9le70cFOdwUJwutuAK9QEu+hY0pGNsXDR97DKGEvb41Bqq41b6WKoZEa4EGc6x9
         ppBssSeXEIIhJaqWm/qSGV8Cxkc5UtIUtY9DIHMqOb15r6M44OhZTOGtdn4mnPLZ/jrk
         2vLDtyzbEBPtgysENdK9C8Apu5KEu/W0F/hTgckCDqSBvkBSzdMxBz0ErGHvYmrfRku/
         LlRAWTK4XuuZR+u2frNYzFUfCATtUL2h4XagXnQzaZo3ugG6XqLJKsYjJmDZ62VSvqqY
         itsw==
X-Gm-Message-State: AAQBX9ehyoI/cBA0gBFOrsVoR9q2nMazvllQr5unEtgky4RrVGamAquT
        lb4f78k4ppef2sgKb0dFwOPAOQ==
X-Google-Smtp-Source: AKy350bW8vfXUfpXHyTmbQKPZ9aG3HQ+NsZGV/I5W1on1KOny35YQuXbwp59dJlBC8HsOL7ySk8WmA==
X-Received: by 2002:a05:6214:62c:b0:56e:9f19:71f9 with SMTP id a12-20020a056214062c00b0056e9f1971f9mr17393007qvx.17.1681014557940;
        Sat, 08 Apr 2023 21:29:17 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s63-20020a37a942000000b00706b09b16fasm2433706qke.11.2023.04.08.21.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 21:29:17 -0700 (PDT)
Date:   Sun, 9 Apr 2023 04:29:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Re: Litmus test names
Message-ID: <20230409042916.GA768965@google.com>
References: <ea9376b4-4b3d-48ee-9c27-ad8de8a7b5cb@paulmck-laptop>
 <3908932E-17D4-4B87-AB0C-D10564F10623@joelfernandes.org>
 <159545c3-0093-3cbd-e822-7298ae764966@huaweicloud.com>
 <d32901a8-3a07-440c-9089-36b37c3f04e5@paulmck-laptop>
 <20230408164956.GA680332@google.com>
 <e4a2059d-8199-b74e-d776-116c99c73fe6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4a2059d-8199-b74e-d776-116c99c73fe6@huaweicloud.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 08, 2023 at 08:57:57PM +0200, Jonas Oberhauser wrote:
> 
> On 4/8/2023 6:49 PM, Joel Fernandes wrote:
> > On Fri, Apr 07, 2023 at 05:49:02PM -0700, Paul E. McKenney wrote:
> > > On Fri, Apr 07, 2023 at 03:05:01PM +0200, Jonas Oberhauser wrote:
> > > > 
> > > > On 4/7/2023 2:12 AM, Joel Fernandes wrote:
> > > > > 
> > > > > > On Apr 6, 2023, at 6:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > ﻿On Thu, Apr 06, 2023 at 05:36:13PM -0400, Alan Stern wrote:
> > > > > > > Paul:
> > > > > > > 
> > > > > > > I just saw that two of the files in
> > > > > > > tools/memory-model/litmus-tests have
> > > > > > > almost identical names:
> > > > > > > 
> > > > > > >   Z6.0+pooncelock+pooncelock+pombonce.litmus
> > > > > > >   Z6.0+pooncelock+poonceLock+pombonce.litmus
> > > > > > > 
> > > > > > > They differ only by a lower-case 'l' vs. a capital 'L'.  It's
> > > > > > > not at all
> > > > > > > easy to see, and won't play well in case-insensitive filesystems.
> > > > > > > 
> > > > > > > Should one of them be renamed?
> > > > > > 
> > FWIW, if I move that smp_mb_after..() a step lower, that also makes the test
> > work (see below).
> > 
> > If you may look over quickly my analysis of why this smp_mb_after..() is
> > needed, it is because what I marked as a and d below don't have an hb
> > relation right?
> 
> I think a and d have an hb relation due to the
> a ->po-rel X ->rfe Y ->acq-po d
> edges (where X and Y are the unlock/lock events I annotated in your example
> below).

I kind of disagree with that, because if I understand correctly, a ->hb d
means ALL CPUs agree as a universal fact that a happened before d.

Clearly, without the smp_mb(), CPU P2 disagrees that a happened before d.

So the po-rel acq-po doesn't imply a->hb d, IMHO. Correct me if I'm wrong
though with any counter example. ;-)

> 
> Generally, an mb_unlock_lock isn't used to give you hb, but to turn some
> (coe/fre) ; hb* edges into pb edges
> 
> In this case, that would probably be
> f ->fre a ->hb* f   (where a ->hb* f comes from a ->hb* d ->hb e ->hb f)
> By adding the mb_unlock_lock_po in one of the right places, this becomes f
> ->pb f,
> thus forbidden.

This I fully agree with. I observed this litmus is actually the R-pattern
with P0 split into 2 CPUs by spltting the thread of execution using a lock
and ordering them with an ->rfe and the exists() clause.

Otherwise it is identical.

In the R-pattern also, you need an smp_mb() between the pair of accesses.

Using the same annotations but instead applying them to the R-pattern, it
looks like:

 P0(int *x, int *y)
 {
 	WRITE_ONCE(*x, 1); // a
	// Here we need an smp_mb() to order the stores to x and z.
 	WRITE_ONCE(*z, 1);  // d
 }

 P2(int *x, int *z)
 {
 	int r1;
 
 	WRITE_ONCE(*z, 2);  // e
 	smp_mb();
 	r1 = READ_ONCE(*x); // f

exists (z=2 /\ 2:r1=0)


thanks,

 - Joel


> 
> Have fun,
> jonas
> 
> 
> > 
> > (*
> >    b ->rf c
> > 
> >    d ->co e
> > 
> >    e ->hb f
> > 
> >    basically the issue is a ->po b ->rf c ->po d    does not imply a ->hb d
> > *)
> > 
> > P0(int *x, int *y, spinlock_t *mylock)
> > {
> > 	spin_lock(mylock);
> > 	WRITE_ONCE(*x, 1); // a
> > 	WRITE_ONCE(*y, 1); // b
> > 	spin_unlock(mylock); // X
> > }
> > 
> > P1(int *y, int *z, spinlock_t *mylock)
> > {
> > 	int r0;
> > 
> > 	spin_lock(mylock); // Y
> > 	r0 = READ_ONCE(*y); // c
> > 	smp_mb__after_spinlock(); // moving this a bit lower also works fwiw.
> > 	WRITE_ONCE(*z, 1);  // d
> > 	spin_unlock(mylock);
> > }
> > 
> > P2(int *x, int *z)
> > {
> > 	int r1;
> > 
> > 	WRITE_ONCE(*z, 2);  // e
> > 	smp_mb();
> > 	r1 = READ_ONCE(*x); // f
> > }
> > 
> > exists (1:r0=1 /\ z=2 /\ 2:r1=0)
> > 
> > 
> > > Would someone like to to a "git mv" send the resulting patch?
> > Yes I can do that in return as I am thankful in advance for the above
> > discussion. ;)
> > 
> > thanks,
> > 
> >   - Joel
> > 
> 
