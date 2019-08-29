Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C52A1C71
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfH2OKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 10:10:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38418 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfH2OKj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 10:10:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so1648301plp.5
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=oHiuqDc5byV42nC75JKsnZDI9kV2zYKc4gOzFLT9ZM8=;
        b=A62KVnHG27axRu5IWrUH/RBEliE9GokRyGw2eM8uznDtXJh4NU3Ifk5OixlYQGQsaN
         Ggw5Sm6LMKmHec8W/CdpQ0pRvagf4fnhjfuWj1gcmOxqkvNE+C8DpGKOmAgh5n4P2ApI
         6FmdxiGvvCa6CYmSkUCI3nU98XlXFlxIpwa8ab8a6P6GbeZy2OT5UL3Yk7UD2cfY7pA8
         xp2fBnbJTEeExznOjo0N4BrnlomV6J3zkjp8a1/hTXBrcDVuROQLVydYCZSU1w5CXxp9
         BGiduTobvPB4X9nayNUjv2fNVF/Fgrp1Qx2a77URaT84DX2oMv+zfekBPdAgAgFWt1XV
         kNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=oHiuqDc5byV42nC75JKsnZDI9kV2zYKc4gOzFLT9ZM8=;
        b=OiG1z2UCQBkCSaLqe0iC9ghReS1jZTTe2Re7bcF/hyhtNXyR6GJVJiY3IWCSnPyGmp
         +6Q3qcxGVtYi81DLAy77xj2p4su/X3dPpNac0s6/cAZZjqV4rgglxvnXJ5/PqKrMCK0Z
         aN3TbrXaji4dp6WTU7Wec5NIetaHmuNzo1KW/DDc0B1B22FDG6wnwFrOaaz6TKqmOwA5
         1Y6K+9Ukx9xiLGvnygDic4es8fBPdiHfqbKZpKxqPQfBo+sLkLgdwEXsXwxS7gv9zoVS
         NUNSOFc9ryOIu3MzzKnX+/9aBrq6nQvY0Go2mOhGjTzmCxE0zIBkBQS+ew8LBaJB35H3
         199A==
X-Gm-Message-State: APjAAAW6YUKkE5QP3/VpfqhN4hz+HLfybUx2jimJHUBK9k3d2KIvEXon
        2g7QPjJ8Vqi7Y40xG9uQbLg=
X-Google-Smtp-Source: APXvYqxOrP90DAJEm/aa6FQmcaWYwJnTobNSUHKB2eGATGeArTlhM/j50LslZ3c5piDJOK6SQfH1Xg==
X-Received: by 2002:a17:902:fe0f:: with SMTP id g15mr9809271plj.2.1567087838150;
        Thu, 29 Aug 2019 07:10:38 -0700 (PDT)
Received: from localhost ([61.68.162.209])
        by smtp.gmail.com with ESMTPSA id k64sm4696047pge.65.2019.08.29.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:10:37 -0700 (PDT)
Date:   Fri, 30 Aug 2019 00:08:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190827131818.14724-1-will@kernel.org>
        <1566947104.2uma6s0pl1.astroid@bobo.none>
        <20190828161256.uevoohval4sko24m@willie-the-truck>
In-Reply-To: <20190828161256.uevoohval4sko24m@willie-the-truck>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1567085427.12jzc6eq6j.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Will Deacon's on August 29, 2019 2:12 am:
> Hi Nick,
>=20
> On Wed, Aug 28, 2019 at 10:35:24AM +1000, Nicholas Piggin wrote:
>> Will Deacon's on August 27, 2019 11:18 pm:
>> > So far, so good, but the final piece of the puzzle isn't quite so rosy=
.
>> >=20
>> > *** Other architecture maintainers -- start here! ***
>> >=20
>> > In the case that one CPU maps a page and then sets a flag to tell anot=
her
>> > CPU:
>> >=20
>> > 	CPU 0
>> > 	-----
>> >=20
>> > 	MOV	X0, <valid pte>
>> > 	STR	X0, [Xptep]	// Store new PTE to page table
>> > 	DSB	ISHST
>> > 	ISB
>> > 	MOV	X1, #1
>> > 	STR	X1, [Xflag]	// Set the flag
>> >=20
>> > 	CPU 1
>> > 	-----
>> >=20
>> > loop:	LDAR	X0, [Xflag]	// Poll flag with Acquire semantics
>> > 	CBZ	X0, loop
>> > 	LDR	X1, [X2]	// Translates using the new PTE
>> >=20
>> > then the final load on CPU 1 can raise a translation fault for the sam=
e
>> > reasons as mentioned at the start of this description.
>>=20
>> powerpc's ptesync instruction is defined to order MMU memory accesses on
>> all other CPUs. ptesync does not go out to the fabric though. How does
>> it work then?
>>=20
>> Because the MMU coherency problem (at least we have) is not that the
>> load will begin to "partially" execute ahead of the store, enough to
>> kick off a table walk that goes ahead of the store, but not so much
>> that it violates the regular CPU barriers. It's just that the loads
>> from the MMU don't participate in the LSU pipeline, they don't snoop
>> the store queues aren't inserted into load queues so the regular
>> memory barrier instructions won't see stores from other threads cuasing
>> ordering violations.
>>=20
>> In your first example, if powerpc just has a normal memory barrier
>> there instead of a ptesync, it could all execute completely
>> non-speculatively and in-order but still cause a fault, because the
>> table walker's loads didn't see the store in the store queue.
>=20
> Ah, so I think this is where our DSB comes in, as opposed to our usual
> DMB. DMB provides ordering guarantees and is generally the only barrier
> instruction you need for shared memory communication. DSB, on the other
> hand, has additional properties such as making page-table updates visible
> to the table walker and completing pending TLB invalidation.
>=20
> So in practice, DSB is likely to drain the store buffer to ensure that
> pending page-table writes are visible at L1, which is coherent with all
> CPUs (and their page-table walkers).
>=20
>> From the other side of the fabric you have no such problem. The table
>> walker is cache coherent apart from the local stores, so we don't need a=
=20
>> special barrier on the other side. That's why ptesync doesn't broadcast.
>=20
> Curious: but do you need to do anything extra to take into account
> instruction fetch on remote CPUs if you're mapping an executable page?
> We added an IPI to flush_icache_range() in 3b8c9f1cdfc5 to handle this,
> because our broadcast I-cache maintenance doesn't force a pipeline flush
> for remote CPUs (and may even execute as a NOP on recent cores).

Ah, I think the tlbie does not force re-fetch indeed. We may need
something like that as well.

What do you do on the user side? Require threads to ISB themselves?

>> I would be surprised if ARM's issue is different, but interested to=20
>> hear if it is.
>=20
> If you take the four scenarios of Map/Unmap for the UP/SMP cases:
>=20
> 	Map+UP		// Some sort of fence instruction (DSB;ISB/ptesync)
> 	Map+SMP		// Same as above
> 	Unmap+UP	// Local TLB invalidation
> 	Unmap+SMP	// Broadcast TLB invalidation
>=20
> then the most interesting case is Map+SMP, where one CPU transitions a PT=
E
> from invalid to valid and executes its DSB;ISB/PTESYNC sequence without
> affecting the remote CPU. That's what I'm trying to get at in my example
> below:
>=20
>> > 	CPU 0				CPU 1
>> > 	-----				-----
>> > 	spin_lock(&lock);		spin_lock(&lock);
>> > 	set_fixmap(0, paddr, prot);	if (mapped)
>> > 	mapped =3D true;				foo =3D *fix_to_virt(0);
>> > 	spin_unlock(&lock);		spin_unlock(&lock);
>> >=20
>> > could fault.
>>=20
>> This is kind of a different issue, or part of a wider one at least.
>> Consider speculative execution more generally, any branch mispredict can=
=20
>> send us off to crazy town executing instructions using nonsense register
>> values. CPU0 does not have to be in the picture, or any kernel page=20
>> table modification at all, CPU1 alone will be doing speculative loads=20
>> wildly all over the kernel address space and trying to access pages with
>> no pte.
>>=20
>> Yet we don't have to flush TLB when creating a new kernel mapping, and
>> we don't get spurious kernel faults. The page table walker won't
>> install negative entries, at least not "architectural" i.e., that cause
>> faults and require flushing. My guess is ARM is similar, or you would=20
>> have seen bigger problems by now?
>=20
> Right, we don't allow negative (invalid) entries to be cached in the TLB,
> but CPUs can effectively cache the result of a translation for a load/sto=
re
> instruction whilst that instruction flows down the pipe after its virtual
> address is known. /That/ caching is not restricted to valid translations.

Ah, I misunderstood you sorry. Yeah that is interesting, I don't think
that is explicitly prohibited in the power ISA either. I believe CPU1
would have to do a ptesync to avoid the fault there.

> For example, if we just take a simple message passing example where we ha=
ve
> two global variables: a 'mapped' flag (initialised to zero) and a pointer
> (initialised to point at a page that is not yet mapped):
>=20
> [please excuse the mess I've made of your assembly language]
>=20
> 	CPU 0
>=20
> 	// Set PTE which maps the page pointed to by pointer
> 	stw	r5, 0(r4)
> 	ptesync
> 	lwsync
>=20
> 	// Set 'mapped' flag to 1
> 	li	r9, 1
> 	stb	r9, 0(r3)
>=20
>=20
> 	CPU 1
>=20
> 	// Poll for 'mapped' flag to be set
> loop:	lbz	r9, 0(r3)
> 	lwsync
> 	cmpdi	cr7, r0, 0
> 	beq	cr7, loop
>=20
> 	// Dereference pointer
> 	lwz	r4, 0(r5)
>=20
>=20
> So in this example, I think it's surprising that CPU 1's dereference of
> 'pointer' can fault. The way this happens on arm64 is that CPU 1 can
> translate the 'pointer' dereference before the load of the 'mapped' flag =
has
> returned its data. The walker may come back with a fault, but then if the
> flag data later comes back as 1, the fault will be taken when the lwz
> commits. In other words, translation table walks can occur out-of-order
> with respect to the accesses they are translating for, even in the presen=
ce
> of memory barriers.
>=20
> In practice, I think this kind of code sequence is unusual and triggering
> the problem relies on CPU 1 knowing the virtual address it's going to
> dereference before it's actually mapped. However, this could conceivably
> happen with the fixmap and possibly also if the page-table itself was
> being written concurrently using cmpxchg(), in which case you might use
> the actual pte value in the same way as the 'mapped' flag above.
>=20
> But yes, adding the spurious fault handler is belt and braces, which is
> why I've kept a WARN_RATELIMIT() in there if it ever triggers.

This could be a theoretical problem for powerpc too, I think. Maybe.
I'll ask around, I might not be understanding the architecture or Linux
code properly.

Thanks,
Nick
=
