Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD152CFA64
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 09:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgLEIAt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 03:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgLEIAt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 03:00:49 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05770C061A51;
        Sat,  5 Dec 2020 00:00:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t37so5006666pga.7;
        Sat, 05 Dec 2020 00:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=0masjBUaEdT8yhWPTiGZKXmGUQ0WDl0QMJjmOmFRbgI=;
        b=Gc/gJZMQJsaxJezPjoIJ+l5Klj3CzVb5UfjGmnUDQ+DMJR1ckzh7xASLtrBAkakChE
         Grl/mbVH7ZhodnKKNM2V9SyaZmqJG37yL3RpwHLG4q20CIoG0WuD8qDvAO8cK0/5pOI0
         XLsxT4WCK17cUlrgT8NKnQ5XHp4ZttYAJyAOErwofFJmxZrdS7k60N/YEMuAPFjj724x
         6Y3lOmK1Fa/4/jUmD8oygPoU6iU8yiVqkQIaS7YpdjpykZeVq+kx+BCFkvagYRVtu/LW
         nNkXd6MTx3rnKjDArqwSiQDF0G/uOxtru2icj5A/knbFbSw4HW25IWRF8hP5S0xki7Ot
         QuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=0masjBUaEdT8yhWPTiGZKXmGUQ0WDl0QMJjmOmFRbgI=;
        b=VWg8uF5/Fhn8LpoJ/DED4ob4PzrRb6ybqQNoTX6y1QUBPoxhYbBTQezJezl6IJ2j8R
         YtTgQy8PbYX5Afm6brJsKjlHIXSaRSQ3ox08xHPUE3djiCFsRx9c5eB6ZOfm4M7hDAZ8
         yasRjpCT2xskjyBZmB7+4MSf/Qy1XJNX0QMKwADPXqjmUabBkVxpvb3/dA4Pbe33oRI8
         87XAqjDJUreM/fjNjHnOjSOD+GGj6fA9xRrwPo6yT434ZA20A0MxXY/hDbkdEVvZdKwT
         Zat7C7KMvI7EuSPLqC86xUibTbuyQ5B/qFkVFBOXW/LTZzDcbx9ExUHVkqQW6yzy7NMS
         yRjQ==
X-Gm-Message-State: AOAM531yg5P9wVBv31sSa+eu54on1hNeS8k7O8NS6gPKm0KumUR7wOQl
        csOkJDBZwhs5DtyqKBMskHw=
X-Google-Smtp-Source: ABdhPJxxq5hhiaL6DPOoOhrdsC1HhF8QISir8hTk4ZBkYS67jaUKjbr7sa21l559bUoRv8iVAoVSKg==
X-Received: by 2002:a63:a55d:: with SMTP id r29mr10713433pgu.289.1607155208529;
        Sat, 05 Dec 2020 00:00:08 -0800 (PST)
Received: from localhost ([1.129.168.124])
        by smtp.gmail.com with ESMTPSA id n5sm6278072pgm.29.2020.12.05.00.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 00:00:07 -0800 (PST)
Date:   Sat, 05 Dec 2020 18:00:00 +1000
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
References: <20201128160141.1003903-1-npiggin@gmail.com>
        <20201128160141.1003903-3-npiggin@gmail.com>
        <CALCETrXYkbuJJnDv9ijfT+5tLQ2FOvvN1Ugoh5NwOy+zHp9HXA@mail.gmail.com>
        <1606876327.dyrhkih2kh.astroid@bobo.none>
        <CALCETrV8Z5JdsP-Qa8B6y01LmXnSruOEWVt9_Un1RX1+nZuhxw@mail.gmail.com>
In-Reply-To: <CALCETrV8Z5JdsP-Qa8B6y01LmXnSruOEWVt9_Un1RX1+nZuhxw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1607152918.fkgmomgfw9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 3, 2020 3:09 pm:
> On Tue, Dec 1, 2020 at 6:50 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Excerpts from Andy Lutomirski's message of November 29, 2020 3:55 am:
>> > On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>> >>
>> >> And get rid of the generic sync_core_before_usermode facility. This i=
s
>> >> functionally a no-op in the core scheduler code, but it also catches
>> >>
>> >> This helper is the wrong way around I think. The idea that membarrier
>> >> state requires a core sync before returning to user is the easy one
>> >> that does not need hiding behind membarrier calls. The gap in core
>> >> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
>> >> tricky detail that is better put in x86 lazy tlb code.
>> >>
>> >> Consider if an arch did not synchronize core in switch_mm either, the=
n
>> >> membarrier_mm_sync_core_before_usermode would be in the wrong place
>> >> but arch specific mmu context functions would still be the right plac=
e.
>> >> There is also a exit_lazy_tlb case that is not covered by this call, =
which
>> >> could be a bugs (kthread use mm the membarrier process's mm then cont=
ext
>> >> switch back to the process without switching mm or lazy mm switch).
>> >>
>> >> This makes lazy tlb code a bit more modular.
>> >
>> > I have a couple of membarrier fixes that I want to send out today or
>> > tomorrow, and they might eliminate the need for this patch.  Let me
>> > think about this a little bit.  I'll cc you.  The existing code is way
>> > to subtle and the comments are far too confusing for me to be quickly
>> > confident about any of my conclusions :)
>> >
>>
>> Thanks for the head's up. I'll have to have a better look through them
>> but I don't know that it eliminates the need for this entirely although
>> it might close some gaps and make this not a bug fix. The problem here
>> is x86 code wanted something to be called when a lazy mm is unlazied,
>> but it missed some spots and also the core scheduler doesn't need to
>> know about those x86 details if it has this generic call that annotates
>> the lazy handling better.
>=20
> I'll send v3 tomorrow.  They add more sync_core_before_usermode() callers=
.
>=20
> Having looked at your patches a bunch and the membarrier code a bunch,
> I don't think I like the approach of pushing this logic out into new
> core functions called by arch code.  Right now, even with my
> membarrier patches applied, understanding how (for example) the x86
> switch_mm_irqs_off() plus the scheduler code provides the barriers
> that membarrier needs is quite complicated, and it's not clear to me
> that the code is even correct.  At the very least I'm pretty sure that
> the x86 comments are misleading.
>
> With your patches, someone trying to
> audit the code would have to follow core code calling into arch code
> and back out into core code to figure out what's going on.  I think
> the result is worse.

Sorry I missed this and rather than reply to the later version you
have a bigger comment here.

I disagree. Until now nobody following it noticed that the mm gets
un-lazied in other cases, because that was not too clear from the
code (only indirectly using non-standard terminology in the arch
support document).

In other words, membarrier needs a special sync to deal with the case=20
when a kthread takes the mm. exit_lazy_tlb gives membarrier code that=20
exact hook that it wants from the core scheduler code.

>=20
> I wrote this incomplete patch which takes the opposite approach (sorry
> for whitespace damage):

That said, if you want to move the code entirely in the x86 arch from
exit_lazy_tlb to switch_mm_irqs_off, it's trivial and touches no core
code after my series :) and I would have no problem with doing that.

I suspect it might actually be more readable to go the other way and
pull most of the real_prev =3D=3D next membarrier code into exit_lazy_tlb
instead, but I could be wrong I don't know exactly how the x86 lazy
state correlates with core lazy tlb state.

Thanks,
Nick

>=20
> commit 928b5c60e93f475934892d6e0b357ebf0a2bf87d
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Wed Dec 2 17:24:02 2020 -0800
>=20
>     [WIP] x86/mm: Handle unlazying membarrier core sync in the arch code
>=20
>     The core scheduler isn't a great place for
>     membarrier_mm_sync_core_before_usermode() -- the core scheduler
>     doesn't actually know whether we are lazy.  With the old code, if a
>     CPU is running a membarrier-registered task, goes idle, gets unlazied
>     via a TLB shootdown IPI, and switches back to the
>     membarrier-registered task, it will do an unnecessary core sync.
>=20
>     Conveniently, x86 is the only architecture that does anything in this
>     hook, so we can just move the code.
>=20
>     XXX: actually delete the old code.
>=20
>     Signed-off-by: Andy Lutomirski <luto@kernel.org>
>=20
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 3338a1feccf9..e27300fc865b 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -496,6 +496,8 @@ void switch_mm_irqs_off(struct mm_struct *prev,
> struct mm_struct *next,
>           * from one thread in a process to another thread in the same
>           * process. No TLB flush required.
>           */
> +
> +        // XXX: why is this okay wrt membarrier?
>          if (!was_lazy)
>              return;
>=20
> @@ -508,12 +510,24 @@ void switch_mm_irqs_off(struct mm_struct *prev,
> struct mm_struct *next,
>          smp_mb();
>          next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
>          if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) =3D=3D
> -                next_tlb_gen)
> +            next_tlb_gen) {
> +            /*
> +             * We're reactivating an mm, and membarrier might
> +             * need to serialize.  Tell membarrier.
> +             */
> +
> +            // XXX: I can't understand the logic in
> +            // membarrier_mm_sync_core_before_usermode().  What's
> +            // the mm check for?
> +            membarrier_mm_sync_core_before_usermode(next);
>              return;
> +        }
>=20
>          /*
>           * TLB contents went out of date while we were in lazy
>           * mode. Fall through to the TLB switching code below.
> +         * No need for an explicit membarrier invocation -- the CR3
> +         * write will serialize.
>           */
>          new_asid =3D prev_asid;
>          need_flush =3D true;
>=20
