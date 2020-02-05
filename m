Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F023E153607
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 18:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBERNK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 12:13:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBERNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 12:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C/hUyKsoS2OrZqy2yiZtLSvPSVnJ/5AlsVgRpHnfbjs=; b=qXgUGKSQLR9pN5lXdK0bSaBWJh
        RY3Ne79BLclbAxM+tsHCt5ud2AbkdoIcbtsdIX7TciHb/xGuezKdsieq70N0UWjizHg+BblL4lezb
        Dw1mOqT6vv43ckad1zeY59HuHgo835qrDTt1P+V/88fexJLaOZ3vxe4xdIK+CQKpWcWgJ41CMXZJR
        YlAN6P3qp8Rv4Z+GrnUojROQy6BOKO3u2SrFuZqKASFrLyNEV9okgkhlj+XZlg92+1IVuDGYaIoDc
        w9abbYVRQr9tRM0Cl8RX9OD2RxR8SCBzLF53uAhOchYexguB6BOSUPTS1C3ixAo6S7/e1JnI/VEfW
        4NXj73Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izOEe-0003MR-Lh; Wed, 05 Feb 2020 17:13:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9E7430257C;
        Wed,  5 Feb 2020 18:11:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADF5F2B78D5B6; Wed,  5 Feb 2020 18:13:06 +0100 (CET)
Date:   Wed, 5 Feb 2020 18:13:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Octavian Purdila <tavi.purdila@gmail.com>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Message-ID: <20200205171306.GP14879@hirez.programming.kicks-ass.net>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
 <20200205124908.GL14879@hirez.programming.kicks-ass.net>
 <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMoF9u12nko0rBGT_iOgXtapuRitS9jSMzAoo8tTykn2dZGK7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 04:00:41PM +0200, Octavian Purdila wrote:
> On Wed, Feb 5, 2020 at 2:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 05, 2020 at 02:24:38PM +0200, Octavian Purdila wrote:
> > > I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
> >
> > It might not have been, but presented with this patch, I feel like it
> > should've been :-)
> >
> > > understand your point that a 64 bit architecture that can't handle 64
> > > bit atomic operation is broken.
> >
> > (sadly they actually exist, I shall name no names)
> >
> > > One way to deal with this in LKL would be to use GCC atomic builtins
> > > or if that doesn't work expose them as host operations. This would
> > > keep LKL as a meta-arch that can run on multiple physical
> > > architectures. I'll give it a try.
> >
> > What is this LKL you speak of and how does it do the 32bit atomics?
> >
> 
> LKL is a build of the Linux kernel as a library that can run in many
> environments including multiple architectures and OSes [1]

Thanks, I'll put it on the to-read list.

> For 32bit atomics LKL also uses the asm-generic implementation. It is
> very similar with generic 64bit atomic implementation and it is used
> by multiple 32bit arches. I think this was my original reasoning for
> this patch and not going with C11 atomics.

Uh no, asm-generic/atomic.h is radically different from lib/atomic64.c.

asm-generic/atomic.h builds all required atomic operations from
cmpxchg() (loops), while lib/atomic64.c builds 64bit atomics by using a
hashed set of spinlocks.

The asm-generic stuff gives you real atomic ops, albeit sub-optimal,
lib/atomic64.c gives you a turd.
