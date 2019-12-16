Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABBE120454
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 12:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLPLr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 06:47:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLPLr5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 06:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LwcWvPUPdHgv2odYtZcSMNnsgALZyJIt29Wbmp4VgB8=; b=NIKIK/cZilp7O4WY5tTPGdJ71
        0bSlzirEsG8ICgflK8h81fjEYBOzirr95k2osGKphsDK4HWCEJok7EWXmBJyqpIcHKgyCKXS2WcSi
        +X8yRLNm2YDi41R98ppiuSE8qrqlPRD/uOpsmzodOLqDFsZDqrrFYRVT/IKOO8GQb2lrrY7LKi1d+
        Esy0g5T8tmr0jCUwWNXLRdaVxRedn/nRTNc7vfLYhetZeE+mPdLLm4axpNRPOSIcFVh4KID6EDquB
        OxeWbfbldP7mSASAmxCSUP8gm7qmRhxNPtrypeCpUi/1bpzi2hcUu7jJ2MNrbVz3S+wCrTWLh9fYP
        0kj67N7cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igoqW-0005HZ-2d; Mon, 16 Dec 2019 11:47:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96FFC3035D4;
        Mon, 16 Dec 2019 12:46:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D3422B1A6BF1; Mon, 16 Dec 2019 12:47:24 +0100 (CET)
Date:   Mon, 16 Dec 2019 12:47:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191216114724.GL2844@hirez.programming.kicks-ass.net>
References: <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
 <20191213144359.GA3826@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213144359.GA3826@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 10:28:06AM +0000, Will Deacon wrote:
> However, enabling this for 32-bit ARM is total carnage; as Linus mentioned,
> a whole bunch of code appears to be relying on atomic 64-bit access of
> READ_ONCE(); the perf ring buffer, io_uring, the scheduler, pm_runtime,
> cpuidle, ... :(
> 
> Unfortunately, at least some of these *do* look like bugs, but I can't see
> how we can fix them, not least because the first two are user ABI afaict. It
> may also be that in practice we get 2x32-bit stores, and that works out fine
> when storing a 32-bit virtual address. I'm not sure what (if anything) the
> compiler guarantees in these cases.

Perf does indeed have a (known) problem here for the head/tail values.
Last time we looked at that nobody could really come up with a sane
solution that wouldn't break something.

I'll try and dig out that thread. Perhaps casting the value to 'unsigned
long' internally might work, I forgot the details.
