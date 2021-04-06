Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929CB355A42
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbhDFRZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhDFRZf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 13:25:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A429C06174A;
        Tue,  6 Apr 2021 10:25:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id fn8so2709266qvb.5;
        Tue, 06 Apr 2021 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HjIY6aWZ/uvHhM5BKnP3jscK0FBNItngTC5eimC1oFI=;
        b=V+JG4luCR0b56/p+Hv4EgOuljif4M7BrF1R+nfoI5OsEwCVXQqTm/WwMZ681EicIT+
         jf1Uwmh7DH9rA54IBEqp/nq7K6NXga/xs1A+ItmZm9vokyJcjNPKYj7O5qcA53sA/Twp
         2o8bvMag0JtT8juqcTglS+J12WkTotgnB/WApgui2mLBFslT1KL/GQ6e+qHE8b9eravs
         GdiEE9jfH5w/LeYxWmNa5+3jLpkvlMXRlL5RYS0sYuwKUTcVktfyuynNAASH3pallAwB
         wq2kdPf+QEEK58vg9OfEGamcBLde0344bTdvxQutG8G6qYTURwgul5zLA6SXB1tqWxa/
         8Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HjIY6aWZ/uvHhM5BKnP3jscK0FBNItngTC5eimC1oFI=;
        b=SsnW7AMJlmBZ45JfFWikH6O/K0TuRalBy98amYpwsFHg6/vrYxwqfvYVSWRIjGWwqt
         OiPDM5eBnab6/rw90dOpFi3Cb7q6xGA+T/8MxIynkAiS/nU1BPNDIphEzng6wrkNX3oo
         5w5xZCS0tjyva9MwM3hjROkVbHRfhTe5N3R38YMqVA1aAkAMvairyUzumaRI7iLQVWE+
         MkBjsc/pSySUtct3Hjsnox9RUG2hxjEms/eLbKP48Uo1k2aBEyDzgcHmvVHKp016kzxY
         eO3usm8VnjGT3keW2/4jN4vAog+sERXaETzXX5/la63+kuX3En1fSIOiL/zs38AKs2kQ
         u5SQ==
X-Gm-Message-State: AOAM530ARfPsK5AUDnFDVmLsZHTWMLbWMwj0MiIfYBzmifyLzLGTa3bH
        1z/zsQUe0egXbL38wS/VlcfE1TYpeJw=
X-Google-Smtp-Source: ABdhPJxCnqpDDoiwmSWHUEP6xAQGZGQrKRlH4kuk7ohk/vvF7w4FMdf+MUERXRCuXqWJW7LJHmQ98Q==
X-Received: by 2002:ad4:4cca:: with SMTP id i10mr29832924qvz.49.1617729926315;
        Tue, 06 Apr 2021 10:25:26 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x14sm16025449qkx.112.2021.04.06.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 10:25:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2BABF27C0054;
        Tue,  6 Apr 2021 13:25:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Apr 2021 13:25:25 -0400
X-ME-Sender: <xms:g5lsYIxIxkxRsm1u6D9obZmveykknLjLNrx5HhDgTnZymPCGIb97rQ>
    <xme:g5lsYMTHoGaNMpVBsIRTBuuyOp4jEgOQapucYXhNADKna11cwzYvMxOaIhrMgOmw0
    NBEFE7HOzpWeoRaZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejhedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnheptdevvdfhkeevuedtueetgeefvdeuveehteelfeehfeelteetuefffeelleel
    ueevnecuffhomhgrihhnpehrihhstghvrdhorhhgpdhkvghrnhgvlhdrohhrghenucfkph
    epudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:g5lsYKV-_z2SguaFtbhfCJ_73Ja-6OesVU2kkZ2n8RTMu-IurrW8VA>
    <xmx:g5lsYGiWkAz5xAFkJkGL0tkmjZUfpf4A8CQ4JDWNJfV1vd8d1jRdGA>
    <xmx:g5lsYKA-1VQnwa1SqZrZgp5GROmrPdFSt59yP5dm2J2RQhrMXae4mg>
    <xmx:hZlsYO64iCXqEXTU581wijEu5WviGywcF7AjNoRq6Y12ZTfFP3TWmhnPzEUafgz4>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9C6FD1080063;
        Tue,  6 Apr 2021 13:25:23 -0400 (EDT)
Date:   Wed, 7 Apr 2021 01:24:12 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGyZPCxJYGOvqYZQ@boqun-archlinux>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 11:22:35PM +0800, Guo Ren wrote:
> On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> > > u32 a = 0x55aa66bb;
> > > u16 *ptr = &a;
> > >
> > > CPU0                       CPU1
> > > =========             =========
> > > xchg16(ptr, new)     while(1)
> > >                                     WRITE_ONCE(*(ptr + 1), x);
> > >
> > > When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
> >
> > Then I think your LL/SC is broken.
> No, it's not broken LR.W/SC.W. Quote <8.3 Eventual Success of
> Store-Conditional Instructions>:
> 
> "As a consequence of the eventuality guarantee, if some harts in an
> execution environment are
> executing constrained LR/SC loops, and no other harts or devices in
> the execution environment
> execute an unconditional store or AMO to that reservation set, then at
> least one hart will
> eventually exit its constrained LR/SC loop. By contrast, if other
> harts or devices continue to
> write to that reservation set, it is not guaranteed that any hart will
> exit its LR/SC loop."
> 
> So I think it's a feature of LR/SC. How does the above code (also use
> ll.w/sc.w to implement xchg16) running on arm64?
> 
> 1: ldxr
>     eor
>     cbnz ... 2f
>     stxr
>     cbnz ... 1b   // I think it would deadlock for arm64.
> 
> "LL/SC fwd progress" which you have mentioned could guarantee stxr
> success? How hardware could do that?
> 

Actually, "old" riscv standard does provide fwd progress ;-) In

	https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf

Section "7.2 Load-Reserved/Store-Conditional Instructions":

"""
One advantage of CAS is that it guarantees that some hart eventually
makes progress, whereas an LR/SC atomic sequence could livelock
indefinitely on some systems. To avoid this concern, we added an
architectural guarantee of forward progress to LR/SC atomic sequences.
The restrictions on LR/SC sequence contents allows an implementation to
**capture a cache line on the LR and complete the LR/SC sequence by
holding off remote cache interventions for a bounded short time**.
"""

The guarantee is removed later due to "Earlier versions of this
specification imposed a stronger starvation-freedom guarantee. However,
the weaker livelock-freedom guarantee is sufficient to implement the C11
and C++11 languages, and is substantially easier to provide in some
microarchitectural styles."

But I take it as an example that hardware can guarantee this.

Regards,
Boqun

> >
> > That also means you really don't want to build super complex locking
> > primitives on top, because that live-lock will percolate through.
> >
> > Step 1 would be to get your architecute fixed such that it can provide
> > fwd progress guarantees for LL/SC. Otherwise there's absolutely no point
> > in building complex systems with it.
> --
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
