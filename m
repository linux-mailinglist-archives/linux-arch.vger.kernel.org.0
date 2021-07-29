Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8C3DA367
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhG2MyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 08:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237422AbhG2Mx3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jul 2021 08:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 135CA60524;
        Thu, 29 Jul 2021 12:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627563180;
        bh=EBPVJJdd9xALLAy/0l0GOskPXiTVkDK/C8C184dXf90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jC6MBh+wkm2PdMpa8nHxiOCMNVIhNQRTQr3fdp608hCQ+vhcHoAhKMLw65LS/o2IF
         pa8Dw+gEe8HMDoYCCOI+4npXUK0jTv2E4weowLc44NZ0xTBDn8oFq0sa+NwAiaeHoV
         y+YsD6cd/WCygpOjLAaesl1HJWvVIJ96XDJvj8FYBZ5ZAyOf0n4/Xvp8cfqYPEF18L
         4j0IzEI/ta7OY9UOXVDliMSMPeGxWu6NTssWN6bg1GLYRxlPTwWC4UvdkPDf/bWTXZ
         QEUNhCzdr//+Gy4gb6M9F0Py1isNfCjOZcEynzAT1U4lefgGNVJUQDvRTEwNwvI7QV
         XtsE1duSgYuIA==
Date:   Thu, 29 Jul 2021 13:52:54 +0100
From:   Will Deacon <will@kernel.org>
To:     hev <r@hev.cc>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <20210729125254.GC21766@willie-the-truck>
References: <20210728114822.1243-1-wangrui@loongson.cn>
 <20210729093923.GD21151@willie-the-truck>
 <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHirt9hNxsHPVWPa+RpUC6av0tcHPESb4Pr20ovAixwNEh4hrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 29, 2021 at 06:18:28PM +0800, hev wrote:
> On Thu, Jul 29, 2021 at 5:39 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
> > > From: wangrui <wangrui@loongson.cn>
> > >
> > > This patch introduce a new atomic primitive 'and_or', It may be have three
> > > types of implemeations:
> > >
> > >  * The generic implementation is based on arch_cmpxchg.
> > >  * The hardware supports atomic 'and_or' of single instruction.
> >
> > Do any architectures actually support this instruction?
> No, I'm not sure now.
> 
> >
> > On arm64, we can clear arbitrary bits and we can set arbitrary bits, but we
> > can't combine the two in a fashion which provides atomicity and
> > forward-progress guarantees.
> >
> > Please can you explain how this new primitive will be used, in case there's
> > an alternative way of doing it which maps better to what CPUs can actually
> > do?
> I think we can easily exchange arbitrary bits of a machine word with atomic
> andnot_or/and_or. Otherwise, we can only use xchg8/16 to do it. It depends on
> hardware support, and the key point is that the bits to be exchanged
> must be in the
> same sub-word. qspinlock adjusted memory layout for this reason, and waste some
> bits(_Q_PENDING_BITS == 8).

No, it's not about wasting bits -- short xchg() is exactly what you want to
do here, it's just that when you get more than 13 bits of CPU number (which
is, err, unusual) then we need more space in the lockword to track the tail,
and so the other fields end up sharing bytes.

> In the case of qspinlock xchg_tail, I think there is no change in the
> assembly code
> after switching to atomic andnot_or, for the architecture that
> supports CAS instructions.
> But for LL/SC style architectures, We can implement xchg for sub-word
> better with new
> primitive and clear[1]. And in fact, it reduces the number of retries
> when the two memory
> load values are not equal.

The only system using LL/SC with this many CPUs is probably Power, and their
atomics are dirt slow anyway.

> If the hardware supports this atomic semantics, we will get better
> performance and flexibility.
> I think the hardware is easy to support.

The issue I have is exposing these new functions as first-class members of
the atomics API. On architectures with AMO instructions, falling back to
cmpxchg() will have a radically different performance profile when compared
to many of the other atomics operations and so I don't think we should add
them without very good justification.

At the very least, we could update the atomics documentation to call out
unconditional functions which are likely to loop around cmpxchg()
internally. We already have things like atomic_add_unless() and
atomic_dec_if_positive() but their conditional nature makes it much less
surprising than something like atomic_and_or() imo.

Will
