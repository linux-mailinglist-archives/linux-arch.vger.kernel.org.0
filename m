Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286582D006B
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 05:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgLFEKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 23:10:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38689 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgLFEHs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 23:07:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id i38so6148723pgb.5;
        Sat, 05 Dec 2020 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=FptgIr82FqTx3PHqnbjpte09oCnyjLLgrpPMpwFz88M=;
        b=Q6EsRabrUE2RTMBsAqNxGvg6ogWN1/xjOSQDh/Zno6SCU1/zkEOeCBt2J1JIiu8Csl
         JFIHJYoUEseptJ+tkOyw3DeWvATYFrTGkMfaptz1QM5DIs6LPM02O8Cq/i6MLK0u1HuL
         OF4oHjgSqgYKQ+WP7tckuYLM8pu5RbookG6eXTJCC/wlQKJAERsunG8bUXLeZEi6LvA4
         MCChAW5kqSadLPQZKrIVG/tnW2jbOlk/sLLXRPly4jeZGgSNEMrsrGw+J2AYZJKVSZ8Y
         acisYoev2jsJDa4pfUpqI0mqMxCoWEjFPh98GdiICLQ//BK83VcahSq9GeJekNc58o78
         ipBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=FptgIr82FqTx3PHqnbjpte09oCnyjLLgrpPMpwFz88M=;
        b=eeKoot3FnJxFxGR2yqw5ipsH3h9LM4+tJPmCcKnmRQ18B5KqD+CHDFbFvGPf6/hE+L
         T+LF9+ZbuHWNYALpdmhN7MNlXqdNoXnIDnLJKxTpNSDobT4TsbDzCCuQ2YB60mVo2X/c
         5+POVo3oLlIqzOcSuCm7+oMGKTe1FNpdvAluV7qGrVtJ7v0FzUkv6L4O635JshpwN/ZK
         EgZmtA/nDsL+B+8husFR4C55Rwyzh7snuE9+ruO3tRVFII3PL9VB4ta83RgBRoNDZVHO
         nkbWsUCp8wuGStR5zeFDVT9ZvBQ5LoRmJV/yr0WhczbRFcBsXb3BDOe6ZDXRTpeolmqD
         u+eA==
X-Gm-Message-State: AOAM533XdCkffhFmSP6tZ8sKELbrtzEUOmVbUIet5ExEymmW5vnPrABC
        O28G0kTJ8WFysSmdJ3ETT1F/uBCyOYFrdg==
X-Google-Smtp-Source: ABdhPJzvDyvnLw4jfZJLoSS9UTDSAnw3moePqpodQUp3PeTMl/gPGntdvFiBGx1lbBhbyo+yiEOzZw==
X-Received: by 2002:a05:6a00:148d:b029:19d:9622:bf7 with SMTP id v13-20020a056a00148db029019d96220bf7mr10801096pfu.11.1607227150468;
        Sat, 05 Dec 2020 19:59:10 -0800 (PST)
Received: from localhost ([1.129.153.198])
        by smtp.gmail.com with ESMTPSA id 21sm1593688pfx.84.2020.12.05.19.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 19:59:09 -0800 (PST)
Date:   Sun, 06 Dec 2020 13:59:02 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <1607152918.fkgmomgfw9.astroid@bobo.none>
        <116A6B40-C77B-4B6A-897B-18342CD62CEC@amacapital.net>
        <1607209402.fogfsh8ov4.astroid@bobo.none>
        <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
In-Reply-To: <CALCETrWFjOXAd5=ctX3tzgUbyfwM+bT-f8WY_QWOeuDdFxhWbg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1607224014.8xeujbleij.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 6, 2020 10:36 am:
> On Sat, Dec 5, 2020 at 3:15 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Excerpts from Andy Lutomirski's message of December 6, 2020 2:11 am:
>> >
>=20
>> If an mm was lazy tlb for a kernel thread and then it becomes unlazy,
>> and if switch_mm is serialising but return to user is not, then you
>> need a serialising instruction somewhere before return to user. unlazy
>> is the logical place to add that, because the lazy tlb mm (i.e.,
>> switching to a kernel thread and back without switching mm) is what
>> opens the hole.
>=20
> The issue here is that unlazying on x86 sometimes serializes and
> sometimes doesn't.

That's additional state that x86 keeps around though, which is
fine. It can optimise that case if it knows it's already
serialised.

> It's straightforward to add logic to the x86 code
> to serialize specifically in the case where membarrier core sync is
> registered and unlazying would otherwise not serialize, but trying to
> define sensible semantics for this in a call to core code seems
> complicated.

It's not though, it's a call from core code (to arch code).

> (Specifically, the x86 code only sometimes sends IPIs to
> lazy CPUs for TLB flushes.  If an IPI is skipped, then unlazying will
> flush the TLB, and that operation is serializing.
>=20
> The whole lazy thing is IMO a red herring for membarrier().  The
> membarrier() logic requires that switching *logical* mms
> (rq->curr->mm) serializes before user mode if the new mm is registered
> for core sync.

It's not a red herring, the reason the IPI gets skipped is because
we go to a kernel thread -- that's all core code and core lazy tlb
handling.

That x86 might do some additional ops serialise during un-lazy in
some cases doesn't make that a red herring, it just means that you
can take advantage of it and avoid doing an extra serialising op.

> AFAICT the only architecture on which this isn't
> automatic is x86, and somehow the logic turned into "actually changing
> rq->curr->mm serializes, but unlazying only sometimes serializes, so
> we need to do an extra serialization step on unlazying operations"
> instead of "tell x86 to make sure it always serializes when it
> switches logical mms".  The latter is easy to specify and easy to
> implement.
>=20
>>
>> How do you mean? exit_lazy_tlb is the opposite, core scheduler notifying
>> arch code about when an mm becomes not-lazy, and nothing to do with
>> membarrier at all even. It's a convenient hook to do your un-lazying.
>> I guess you can do it also checking things in switch_mm and keeping stat=
e
>> in arch code, I don't think that's necessarily the best place to put it.
>=20
> I'm confused.  I just re-read your patches, and it looks like you have
> arch code calling exit_lazy_tlb().

More for code-comment / consistency than anything else. They are
entirely arch hooks.

> On x86, if we do a TLB shootdown
> IPI to a lazy CPU, the IPI handler will unlazy that CPU (by switching
> to init_mm for real), and we have no way to notify the core scheduler
> about this, so we don't.  The result is that the core scheduler state
> and the x86 state gets out of sync.  If the core scheduler
> subsequently switches us back to the mm that it thinks we were still
> using lazily them, from the x86 code's perspective, we're not
> unlazying -- we're just doing a regular switch from init_mm to some
> other mm.  This is why x86's switch_mm_irqs_off() totally ignores its
> 'prev' argument.

You actually do now have such a way to do that now that we've
(hopefully) closed races, and I think should use it, which might make=20
things simpler for you. See patch 6 do_shoot_lazy_tlb().

> I'm honestly a bit surprised that other architectures don't do the
> same thing.  I suppose that some architectures don't use shootdown
> IPIs at all, in which case there doesn't seem to be any good reason to
> aggressively unlazy.

powerpc/radix does (in some cases) since a few years ago. It just=20
doesn't fully exploit that for the final TLB shootdown to always clean=20
them all up and avoid the subsequent shoot-lazies IPI, but it could be=20
more aggressive there.

The powerpc virtualised hash architecture is the traditional one and=20
isn't conducive to this (translation management is done via hcalls, and
the hypervisor maintains the TLB) so I suspect that's why it wasn't
done earlier there. That will continue to rely on shoot-lazies.

> (Oddly, despite the fact that, since Ivy Bridge, x86 has a "just flush
> the TLB" instruction, that instruction is considerably slower than the
> old "switch mm and flush" operation.  So the operation "switch to
> init_mm" is only ever any slower than "flush and stay lazy" if we get
> lucky and unlazy to the same mm before we get a second TLB shootdown
> *and* if unlazying to the same mm would not have needed to flush.  I
> spend quite a bit of time tuning this stuff and being quite surprised
> at the bizarre performance properties of Intel's TLB management
> instructions.)

Well, you also casue an extra mm switch in case you returned to the
same mm. Which probably isn't uncommon (app<->idle).

>>
>> So membarrier code is unchanged (it cares that the serialise is done at
>> un-lazy time), core code is simpler (no knowledge of this membarrier
>> quirk and it already knows about lazy-tlb so the calls actually improve
>> the documentation), and x86 code I would argue becomes nicer (or no real
>> difference at worst) because you can move some exit lazy tlb handling to
>> that specific call rather than decipher it from switch_mm.
>=20
> As above, I can't move the exit-lazy handling because the scheduler
> doesn't know when I'm unlazying.

As above, you can actually tell it. But even if you don't do that, in
the current scheme it's still telling you a superset of what you need,=20
so you'd just put move your extra checks there.

>=20
>>
>> >
>> > I=E2=80=99m currently trying to document how membarrier actually works=
, and
>> > hopefully this will result in untangling membarrier from mmdrop() and
>> > such.
>>
>> That would be nice.
>=20
> It's still a work in progress.  I haven't actually convinced myself
> that the non-IPI case in membarrier() is correct, nor have I convinced
> myself that it's incorrect.
>=20
> Anyway, I think that my patch is a bit incorrect and I either need a
> barrier somewhere (which may already exist) or a store-release to
> lazy_mm to make sure that all accesses to the lazy mm are done before
> lazy_mm is freed.  On x86, even aside from the fact that all stores
> are releases, this isn't needed -- stopping using an mm is itself a
> full barrier.  Will this be a performance issue on power?

store-release is lwsync on power. Not so bad as a full barrier, but
probably not wonderful. The fast path would be worse than shoot-lazies
of course, but may not be prohibitive.

I'm still going to persue shoot-lazies for the merge window. As you
see it's about a dozen lines and a if (IS_ENABLED(... in core code.
Your change is common code, but a significant complexity (which
affects all archs) so needs a lot more review and testing at this
point.

If x86 is already shooting lazies in its final TLB flush, I don't
know why you're putting so much effort in though, surely it's more
complexity and (even slightly) more cost there too.

>=20
>>
>> >
>> > A silly part of this is that x86 already has a high quality
>> > implementation of most of membarrier(): flush_tlb_mm().  If you flush
>> > an mm=E2=80=99s TLB, we carefully propagate the flush to all threads, =
with
>> > attention to memory ordering.  We can=E2=80=99t use this directly as a=
n
>> > arch-specific implementation of membarrier because it has the annoying
>> > side affect of flushing the TLB and because upcoming hardware might be
>> > able to flush without guaranteeing a core sync.  (Upcoming means Zen
>> > 3, but the Zen 3 implementation is sadly not usable by Linux.)
>> >
>>
>> A hardware broadcast TLB flush, you mean? What makes it unusable by
>> Linux out of curiosity?
>=20
> The new instruction is INVLPGB.  Unfortunately, x86's ASID field is
> very narrow, and there's no way we can give each mm the same ASID
> across all CPUs, which means we can't accurately target the flush at
> the correct set of TLB entries.  I've asked engineers at both Intel
> and AMD to widen the ASID field, but that will end up being
> complicated -- x86 has run out of bits in its absurdly overloaded CR3
> encoding, and widening the ASID to any reasonable size would require
> adding a new way to switch mms.  There are lots of reasons that x86
> should do that anyway [0], but it would be a big project and I'm not
> sure that either company is interested in big projects like that.

Interesting, thanks. powerpc has a PID register for guest ASIDs that
implements about 20 bits.

The IPI is very flexible though, it allows more complex/fine grained
flushes and also software state to be updated, so we've started using
it a bit. I haven't seen much software where performance of IPIs is
prohibitive these days. Maybe improvements to threaded malloc, JVMs
databases etc reduce the amount of flushes.


> [0] On x86, you can't switch between (64-bit execution, 48-bit virtual
> address space) and (64-bit execution, 57-bit address space) without
> exiting 64-bit mode in the middle.  This is because the way that the
> addressing mode is split among multiple registers prevents a single
> instruction from switching between the two states.  This is absolutely
> delightful for anyone trying to boot an OS on a system with a very,
> very large amount of memory.
>=20

powerpc has some issues like that with context switching guest / host
state there are several MMU registers involved that can't be switched=20
with a single instruction. It doesn't require such a big hammer, but
a careful sequence to switch things.

Thanks,
Nick
