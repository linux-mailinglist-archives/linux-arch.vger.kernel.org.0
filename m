Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD42CF5BF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 21:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLDUkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 15:40:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:51794 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUkl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 15:40:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6DF372CE77F;
        Fri,  4 Dec 2020 15:39:59 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id laVxlc6mfNuf; Fri,  4 Dec 2020 15:39:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0A37F2CE55C;
        Fri,  4 Dec 2020 15:39:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0A37F2CE55C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1607114399;
        bh=dJI+/PpwD5jMrAfaBYwMPtjncMGVD0cTPqSq0jiEMqA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pOntHhXazoFXLq6hBllqIik4PkxFnty+9LIxg1VBWg4D7Ws3FLE0Mjm1rsUxsslhN
         96xSWYMV/RH//jyC1tHD7ZtkDY8WGMsa3hLeEKkhuMdRRFE/aGP+RnBPwCDj9Dx9ZF
         Ts4Maj7e2zg1jzqzpnLkj14ITc2W+f9NWSChLPKp33te6K+Bwi1j4nMvoP7zND/y4x
         VQK9uS1d6sar1+0Euk8kQMFJqjN40B3srLNnrN+EYvOIQbtm5cpo6ozi+Y+o7vX1UV
         yvnctVkuIK4FUKINdk18u+H/nUAixpE0LWs5zukQN3P8e6aZVr8VZXBxsgae1xn7fF
         6t0qpDtjmppRg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rT4kBItm-hx9; Fri,  4 Dec 2020 15:39:58 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EB57C2CE8D0;
        Fri,  4 Dec 2020 15:39:58 -0500 (EST)
Date:   Fri, 4 Dec 2020 15:39:58 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        riel <riel@surriel.com>, Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>
Message-ID: <77346515.6733.1607114398867.JavaMail.zimbra@efficios.com>
In-Reply-To: <A61977A7-F0B2-4492-AB6D-06E24417FA59@gmail.com>
References: <cover.1607059162.git.luto@kernel.org> <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org> <A61977A7-F0B2-4492-AB6D-06E24417FA59@gmail.com>
Subject: Re: [RFC v2 1/2] [NEEDS HELP] x86/mm: Handle unlazying membarrier
 core sync in the arch code
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: x86/mm: Handle unlazying membarrier core sync in the arch code
Thread-Index: xWV4rdMooMFTW/S/cTMIU6yzFuQjnA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Dec 4, 2020, at 3:17 AM, Nadav Amit nadav.amit@gmail.com wrote:

> I am not very familiar with membarrier, but here are my 2 cents while try=
ing
> to answer your questions.
>=20
>> On Dec 3, 2020, at 9:26 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> @@ -496,6 +497,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, stru=
ct
>> mm_struct *next,
>> =09=09 * from one thread in a process to another thread in the same
>> =09=09 * process. No TLB flush required.
>> =09=09 */
>> +
>> +=09=09// XXX: why is this okay wrt membarrier?
>> =09=09if (!was_lazy)
>> =09=09=09return;
>=20
> I am confused.
>=20
> On one hand, it seems that membarrier_private_expedited() would issue an =
IPI
> to that core, as it would find that this core=E2=80=99s cpu_rq(cpu)->curr=
->mm is the
> same as the one that the membarrier applies to.

If the scheduler switches from one thread to another which both have the sa=
me mm,
it means cpu_rq(cpu)->curr->mm is invariant, even though ->curr changes. So=
 there
is no need to issue a memory barrier or sync core for membarrier in this ca=
se,
because there is no way the IPI can be missed.

> But=E2=80=A6 (see below)
>=20
>=20
>> @@ -508,12 +511,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, st=
ruct
>> mm_struct *next,
>> =09=09smp_mb();
>> =09=09next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
>> =09=09if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) =3D=3D
>> -=09=09=09=09next_tlb_gen)
>> +=09=09    next_tlb_gen) {
>> +=09=09=09/*
>> +=09=09=09 * We're reactivating an mm, and membarrier might
>> +=09=09=09 * need to serialize.  Tell membarrier.
>> +=09=09=09 */
>> +
>> +=09=09=09// XXX: I can't understand the logic in
>> +=09=09=09// membarrier_mm_sync_core_before_usermode().  What's
>> +=09=09=09// the mm check for?
>> +=09=09=09membarrier_mm_sync_core_before_usermode(next);
>=20
> On the other hand the reason for this mm check that you mention contradic=
ts
> my previous understanding as the git log says:
>=20
> commit 2840cf02fae627860156737e83326df354ee4ec6
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu Sep 19 13:37:01 2019 -0400
>=20
>    sched/membarrier: Call sync_core only before usermode for same mm
>   =20
>    When the prev and next task's mm change, switch_mm() provides the core
>    serializing guarantees before returning to usermode. The only case
>    where an explicit core serialization is needed is when the scheduler
>    keeps the same mm for prev and next.

Hrm, so your point here is that if the scheduler keeps the same mm for
prev and next, it means membarrier will have observed the same rq->curr->mm=
,
and therefore the IPI won't be missed. I wonder if that
membarrier_mm_sync_core_before_usermode is needed at all then or if we
have just been too careful and did not consider that all the scenarios whic=
h
need to be core-sync'd are indeed taken care of ?

I see here that my prior commit message indeed discusses prev and next task=
's
mm, but in reality, we are comparing current->mm with rq->prev_mm. So from
a lazy TLB perspective, this probably matters, and we may still need a core=
 sync
in some lazy TLB scenarios.

>=20
>> =09/*
>> =09 * When switching through a kernel thread, the loop in
>> =09 * membarrier_{private,global}_expedited() may have observed that
>> =09 * kernel thread and not issued an IPI. It is therefore possible to
>> =09 * schedule between user->kernel->user threads without passing though
>> =09 * switch_mm(). Membarrier requires a barrier after storing to
>> -=09 * rq->curr, before returning to userspace, so provide them here:
>> +=09 * rq->curr, before returning to userspace, and mmdrop() provides
>> +=09 * this barrier.
>> =09 *
>> -=09 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitl=
y
>> -=09 *   provided by mmdrop(),
>> -=09 * - a sync_core for SYNC_CORE.
>> +=09 * XXX: I don't think mmdrop() actually does this.  There's no
>> +=09 * smp_mb__before/after_atomic() in there.
>=20
> I presume that since x86 is the only one that needs
> membarrier_mm_sync_core_before_usermode(), nobody noticed the missing
> smp_mb__before/after_atomic(). These are anyhow a compiler barrier in x86=
,
> and such a barrier would take place before the return to userspace.

mmdrop already provides the memory barriers for membarrer, as I documented =
within the
function.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
