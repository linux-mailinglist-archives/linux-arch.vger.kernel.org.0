Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB30E488691
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 23:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiAHWEk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 17:04:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56866 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiAHWEj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 17:04:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA7D60E8A
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 22:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCB4C36AE3;
        Sat,  8 Jan 2022 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641679478;
        bh=YCkcNIFoSnQTOpI44hdO2U+NzN6m2dKXS4DTiEKgJpY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=b2kT3brG2TYG8+XnNKzCWzIgj9tCYKhpW68fKwPvC6Zjr7R9OFM5obLsZ3+MAaeXG
         IXS+327Txxq0sp7OKJZwkd2/Qm4+LHctoAflIMiDBmJalv8JYhdTJsz/hwH0K+QFcj
         t2IwpmqabVvMzSyNIRbGz1ZrwvNVrmcaSm3wPoFF/zLBHkYkuArmUSOKEl6XEVeNwB
         g/jim2CHvXnn35BshiToJ4hALP5nIVDweUTu6DTEu3X4CTEqrWQywx9MDkcRUmV0EC
         RYnHJ4UOMudp6x6Up6Zgbe3bvho0n22bJhySwHVxnuVhq9RCVKDLGpdObf0k8ALXcw
         Uh9rQqQIB2QKg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9375027C0054;
        Sat,  8 Jan 2022 17:04:36 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sat, 08 Jan 2022 17:04:36 -0500
X-ME-Sender: <xms:cwraYZVBgDv1p5GDf7OimZBBO7-D9mCD77SJW90lOgXMQoIZVFCPpQ>
    <xme:cwraYZnm2YNc2E646GDoyPOk6ek4KGLfeqn3Zl3D-Pxlalm5Q94lA307Bah7AwJWY
    -36V6yuGWwprLhpA9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeghedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:cwraYVb9YCOo29BfeOsxd2ABVY1cu4Kinb3L1CZE__dVpvQCuMWbAA>
    <xmx:cwraYcWNEpjDE5nzgLeb_WBjvoJh9F04s_CaWRFF7zfNyustDcO2dg>
    <xmx:cwraYTkfJS8w99tyDX6EltFtZPCcGLmX0gx8zPVvBzCgQZc1KZ-u5Q>
    <xmx:dAraYW-rKANRAzT9XofrxTN8ebY4Zp7H7IVnneG1j52Obu5VPTaeG0yyPllxHzz2>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 751B321E006E; Sat,  8 Jan 2022 17:04:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
In-Reply-To: <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
Date:   Sat, 08 Jan 2022 15:04:14 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Anton Blanchard" <anton@ozlabs.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sat, Jan 8, 2022, at 12:22 PM, Linus Torvalds wrote:
> On Sat, Jan 8, 2022 at 8:44 AM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> To improve scalability, this patch adds a percpu hazard pointer schem=
e to
>> keep lazily-used mms alive.  Each CPU has a single pointer to an mm t=
hat
>> must not be freed, and __mmput() checks the pointers belonging to all=
 CPUs
>> that might be lazily using the mm in question.
>
> Ugh. This feels horribly fragile to me, and also looks like it makes
> some common cases potentially quite expensive for machines with large
> CPU counts if they don't do that mm_cpumask optimization - which in
> turn feels quite fragile as well.
>
> IOW, this just feels *complicated*.
>
> And I think it's overly so. I get the strong feeling that we could
> make the rules much simpler and more straightforward.
>
> For example, how about we make the rules be

There there, Linus, not everything is as simple^Wincapable as x86 bare m=
etal, and mm_cpumask does not have useful cross-arch semantics.  Is that=
 good?

>
>  - a lazy TLB mm reference requires that there's an actual active user
> of that mm (ie "mm_users > 0")
>
>  - the last mm_users decrement (ie __mmput) forces a TLB flush, and
> that TLB flush must make sure that no lazy users exist (which I think
> it does already anyway).

It does, on x86 bare metal, in exit_mmap().  It=E2=80=99s implicit, but =
it could be made explicit, as below.

>
> Doesn't that seem like a really simple set of rules?
>
> And the nice thing about it is that we *already* do that required TLB
> flush in all normal circumstances. __mmput() already calls
> exit_mmap(), and exit_mm() already forces that TLB flush in every
> normal situation.

Exactly. On x86 bare metal and similar architectures, this flush is done=
 by IPI, which involves a loop over all CPUs that might be using the mm.=
  And other patches in this series add the core ability for x86 to shoot=
 down the lazy TLB cleanly so the core drops its reference and wires it =
up for x86.

>
> So we might have to make sure that every architecture really does that
> "drop lazy mms on TLB flush", and maybe add a flag to the existing
> 'struct mmu_gather tlb' to make sure that flush actually always
> happens (even if the process somehow managed to unmap all vma's even
> before exiting).

So this requires that all architectures actually walk all relevant CPUs =
to see if an IPI is needed and send that IPI.  On architectures that act=
ually need an IPI anyway (x86 bare metal, powerpc (I think) and others, =
fine. But on architectures with a broadcast-to-all-CPUs flush (ARM64 IIU=
C), then the extra IPI will be much much slower than a simple load-acqui=
re in a loop.

In fact, arm64 doesn=E2=80=99t even track mm_cpumask at all last time I =
checked, so even an IPI lazy shoot down would require looping *all* CPUs=
, doing a load-acquire, and possibly doing an IPI. I much prefer doing a=
 load-acquire and possibly a cmpxchg.

(And x86 PV can do hypercall flushes.  If a bunch of vCPUs are not runni=
ng, an IPI shootdown will end up sleeping until they run, whereas this p=
atch will allow the hypervisor to leave them asleep and thus to finish _=
_mmput without waking them. This only matters on a CPU-oversubscribed ho=
st, but still.  And it kind of looks like hardware remote flushes are co=
ming in AMD land eventually.)

But yes, I fully agree that this patch is complicated and subtle.

>
> Is there something silly I'm missing? Somebody pat me on the head, and
> say "There, there, Linus, don't try to get involved with things you
> don't understand.." and explain to me in small words.
>
>                   Linus
