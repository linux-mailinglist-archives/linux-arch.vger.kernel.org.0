Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698612CFFF9
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 01:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLFAht (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 19:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgLFAht (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Dec 2020 19:37:49 -0500
X-Gm-Message-State: AOAM532Ra+2xopj2TgkIUvYRu83X5rKMETWNkNEx9X095IfV+ChcyQcV
        7HhKprwsmFONn8vdbRe2CjoB5VeekyxEXGw89pqR2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607215028;
        bh=O0M5uIlGjbfBke1AqBUbFQAkfbuLeuwhOy9pOLV1Cx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8YOCZnWAboKe7jWEvq8AoyWHLoTYuPmr8RvEJ8QgIk21jWP6xeSAEQWSY9h2cyLs
         s4iUiVEJGJ3qZYKVsPhwCMgIRCKyFoEWdXX+8bv7HwPl/9EBnyifMXQ5pC1W+QMqRq
         cgkg4FxWLQXUQ7dLrYk51C/JSr3NdhF25iUm1bbu1+SNufsP5nqB3uPQcTAmEkn46O
         zgiOgSeHDc4YyZXZCyf+S9PTolbg0wGeqx7HwLy80tI8MlDeEQmxUsXlPRHcBf4sP6
         yti5CJDI8+aj875mIVLieAb1YF++2RNhPsf1tLY5H/M7B7NBwiSlRbDHjrqyqCC7hG
         JI4NLpmqiZNOA==
X-Google-Smtp-Source: ABdhPJyY2Wy4UhhqQjSxtfTV/OtEe0TcnzVLr0IrCYKvwV1z0bld4uhdiQXiwt6Idq+h6hqK4xsmNsXkygqPWW2NVjY=
X-Received: by 2002:adf:e449:: with SMTP id t9mr12062248wrm.257.1607215026576;
 Sat, 05 Dec 2020 16:37:06 -0800 (PST)
MIME-Version: 1.0
References: <1607152918.fkgmomgfw9.astroid@bobo.none> <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
 <1607209402.fogfsh8ov4.astroid@bobo.none>
In-Reply-To: <1607209402.fogfsh8ov4.astroid@bobo.none>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 5 Dec 2020 16:36:53 -0800
X-Gmail-Original-Message-ID: <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
Message-ID: <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 5, 2020 at 3:15 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Andy Lutomirski's message of December 6, 2020 2:11 am:
> >

> If an mm was lazy tlb for a kernel thread and then it becomes unlazy,
> and if switch_mm is serialising but return to user is not, then you
> need a serialising instruction somewhere before return to user. unlazy
> is the logical place to add that, because the lazy tlb mm (i.e.,
> switching to a kernel thread and back without switching mm) is what
> opens the hole.

The issue here is that unlazying on x86 sometimes serializes and
sometimes doesn't.  It's straightforward to add logic to the x86 code
to serialize specifically in the case where membarrier core sync is
registered and unlazying would otherwise not serialize, but trying to
define sensible semantics for this in a call to core code seems
complicated.  (Specifically, the x86 code only sometimes sends IPIs to
lazy CPUs for TLB flushes.  If an IPI is skipped, then unlazying will
flush the TLB, and that operation is serializing.

The whole lazy thing is IMO a red herring for membarrier().  The
membarrier() logic requires that switching *logical* mms
(rq->curr->mm) serializes before user mode if the new mm is registered
for core sync.  AFAICT the only architecture on which this isn't
automatic is x86, and somehow the logic turned into "actually changing
rq->curr->mm serializes, but unlazying only sometimes serializes, so
we need to do an extra serialization step on unlazying operations"
instead of "tell x86 to make sure it always serializes when it
switches logical mms".  The latter is easy to specify and easy to
implement.

>
> How do you mean? exit_lazy_tlb is the opposite, core scheduler notifying
> arch code about when an mm becomes not-lazy, and nothing to do with
> membarrier at all even. It's a convenient hook to do your un-lazying.
> I guess you can do it also checking things in switch_mm and keeping state
> in arch code, I don't think that's necessarily the best place to put it.

I'm confused.  I just re-read your patches, and it looks like you have
arch code calling exit_lazy_tlb().  On x86, if we do a TLB shootdown
IPI to a lazy CPU, the IPI handler will unlazy that CPU (by switching
to init_mm for real), and we have no way to notify the core scheduler
about this, so we don't.  The result is that the core scheduler state
and the x86 state gets out of sync.  If the core scheduler
subsequently switches us back to the mm that it thinks we were still
using lazily them, from the x86 code's perspective, we're not
unlazying -- we're just doing a regular switch from init_mm to some
other mm.  This is why x86's switch_mm_irqs_off() totally ignores its
'prev' argument.

I'm honestly a bit surprised that other architectures don't do the
same thing.  I suppose that some architectures don't use shootdown
IPIs at all, in which case there doesn't seem to be any good reason to
aggressively unlazy.

(Oddly, despite the fact that, since Ivy Bridge, x86 has a "just flush
the TLB" instruction, that instruction is considerably slower than the
old "switch mm and flush" operation.  So the operation "switch to
init_mm" is only ever any slower than "flush and stay lazy" if we get
lucky and unlazy to the same mm before we get a second TLB shootdown
*and* if unlazying to the same mm would not have needed to flush.  I
spend quite a bit of time tuning this stuff and being quite surprised
at the bizarre performance properties of Intel's TLB management
instructions.)

>
> So membarrier code is unchanged (it cares that the serialise is done at
> un-lazy time), core code is simpler (no knowledge of this membarrier
> quirk and it already knows about lazy-tlb so the calls actually improve
> the documentation), and x86 code I would argue becomes nicer (or no real
> difference at worst) because you can move some exit lazy tlb handling to
> that specific call rather than decipher it from switch_mm.

As above, I can't move the exit-lazy handling because the scheduler
doesn't know when I'm unlazying.

>
> >
> > I=E2=80=99m currently trying to document how membarrier actually works,=
 and
> > hopefully this will result in untangling membarrier from mmdrop() and
> > such.
>
> That would be nice.

It's still a work in progress.  I haven't actually convinced myself
that the non-IPI case in membarrier() is correct, nor have I convinced
myself that it's incorrect.

Anyway, I think that my patch is a bit incorrect and I either need a
barrier somewhere (which may already exist) or a store-release to
lazy_mm to make sure that all accesses to the lazy mm are done before
lazy_mm is freed.  On x86, even aside from the fact that all stores
are releases, this isn't needed -- stopping using an mm is itself a
full barrier.  Will this be a performance issue on power?

>
> >
> > A silly part of this is that x86 already has a high quality
> > implementation of most of membarrier(): flush_tlb_mm().  If you flush
> > an mm=E2=80=99s TLB, we carefully propagate the flush to all threads, w=
ith
> > attention to memory ordering.  We can=E2=80=99t use this directly as an
> > arch-specific implementation of membarrier because it has the annoying
> > side affect of flushing the TLB and because upcoming hardware might be
> > able to flush without guaranteeing a core sync.  (Upcoming means Zen
> > 3, but the Zen 3 implementation is sadly not usable by Linux.)
> >
>
> A hardware broadcast TLB flush, you mean? What makes it unusable by
> Linux out of curiosity?

The new instruction is INVLPGB.  Unfortunately, x86's ASID field is
very narrow, and there's no way we can give each mm the same ASID
across all CPUs, which means we can't accurately target the flush at
the correct set of TLB entries.  I've asked engineers at both Intel
and AMD to widen the ASID field, but that will end up being
complicated -- x86 has run out of bits in its absurdly overloaded CR3
encoding, and widening the ASID to any reasonable size would require
adding a new way to switch mms.  There are lots of reasons that x86
should do that anyway [0], but it would be a big project and I'm not
sure that either company is interested in big projects like that.

[0] On x86, you can't switch between (64-bit execution, 48-bit virtual
address space) and (64-bit execution, 57-bit address space) without
exiting 64-bit mode in the middle.  This is because the way that the
addressing mode is split among multiple registers prevents a single
instruction from switching between the two states.  This is absolutely
delightful for anyone trying to boot an OS on a system with a very,
very large amount of memory.
