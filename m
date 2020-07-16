Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21712222716
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 17:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgGPPey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 11:34:54 -0400
Received: from mail.efficios.com ([167.114.26.124]:37668 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPPex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 11:34:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C021D295A82;
        Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PgTosnGDK1sK; Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5B51329547E;
        Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5B51329547E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594913692;
        bh=L9rT0fzuMGMghk/dEAcEzzkVjyKyZYNObrqiQ0DoanQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RgaNfAf/qoYxhHgbRYFkX7WlrrMStDTGaEU8qr/CVA7cq3dKzJPZp1ls9bOuEFOay
         713X1tULNXG0XScInlJLS3gVB5DhgcTf/33UG8lAhqwz0cW80lP3OGch5BZRRscWkQ
         oJjBBhbUW7lZr7hF1UJsCnzhyEtuchi0saqFa97K+NQyihrBZk0dYi1+Gh+v+qprR7
         1hPRkBcgiJIgBDsNsL6YTPt6YAuhZ84BiMgu/j2Hr9a0wNhfKNs6NqmtFu3x/Tbw3S
         MtlD4wlJ9l3TRACzBEGOWf8J7rHyrPo25GYaeAOdDgFhrDNnIn9o3RzBU4ewFK68X3
         NgoxFHyBSun8Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DMMJqRBwC3nh; Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4B494295833;
        Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
Date:   Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Message-ID: <47821133.15875.1594913692220.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200716110038.GA119549@hirez.programming.kicks-ass.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net> <20200716085032.GO10769@hirez.programming.kicks-ass.net> <1594892300.mxnq3b9a77.astroid@bobo.none> <20200716110038.GA119549@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: iW27IjJDBx/ElQOPTNbM0E0vDOu3JA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 16, 2020, at 7:00 AM, Peter Zijlstra peterz@infradead.org wrot=
e:

> On Thu, Jul 16, 2020 at 08:03:36PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 16, 2020 6:50 pm:
>> > On Wed, Jul 15, 2020 at 10:18:20PM -0700, Andy Lutomirski wrote:
>> >> > On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> >> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. I=
n the
>> >> brave new world of io_uring and such, perhaps kernel access matter
>> >> too.  Heck, even:
>> >=20
>> > IIRC the membarrier SYNC_CORE use-case is about user-space
>> > self-modifying code.
>> >=20
>> > Userspace re-uses a text address and needs to SYNC_CORE before it can =
be
>> > sure the old text is forgotten. Nothing the kernel does matters there.
>> >=20
>> > I suppose the manpage could be more clear there.
>>=20
>> True, but memory ordering of kernel stores from kernel threads for
>> regular mem barrier is the concern here.
>>=20
>> Does io_uring update completion queue from kernel thread or interrupt,
>> for example? If it does, then membarrier will not order such stores
>> with user memory accesses.
>=20
> So we're talking about regular membarrier() then? Not the SYNC_CORE
> variant per-se.
>=20
> Even there, I'll argue we don't care, but perhaps Mathieu has a
> different opinion.

I agree with Peter that we don't care about accesses to user-space
memory performed concurrently with membarrier.

What we'd care about in terms of accesses to user-space memory from the
kernel is something that would be clearly ordered as happening before
or after the membarrier call, for instance a read(2) followed by
membarrier(2) after the read returns, or a read(2) issued after return
from membarrier(2). The other scenario we'd care about is with the compiler
barrier paired with membarrier: e.g. read(2) returns, compiler barrier,
followed by a store. Or load, compiler barrier, followed by write(2).

All those scenarios imply before/after ordering wrt either membarrier or
the compiler barrier. I notice that io_uring has a "completion" queue.
Let's try to come up with realistic usage scenarios.

So the dependency chain would be provided by e.g.:

* Infrequent read / Frequent write, communicating read completion through v=
ariable X

wait for io_uring read request completion -> membarrier -> store X=3D1

with matching

load from X (waiting for X=3D=3D1) -> asm volatile (::: "memory") -> submit=
 io_uring write request

or this other scenario:

* Frequent read / Infrequent write, communicating read completion through v=
ariable X

load from X (waiting for X=3D=3D1) -> membarrier -> submit io_uring write r=
equest

with matching

wait for io_uring read request completion -> asm volatile (::: "memory") ->=
 store X=3D1

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
