Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3705A1204DE
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 13:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLPMGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 07:06:44 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfLPMGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 07:06:43 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MSss2-1iGsog2KTe-00UJfA; Mon, 16 Dec 2019 13:06:40 +0100
Received: by mail-qk1-f179.google.com with SMTP id j9so4013766qkk.1;
        Mon, 16 Dec 2019 04:06:40 -0800 (PST)
X-Gm-Message-State: APjAAAW4VVQq/8xxHABqZCxIIyR96iUxnZ5sDDFMMsS37TtSJlOWMOXj
        kiu50pXVTDprT8tKFz88BDkvCUPSbxOHoI4Nsf8=
X-Google-Smtp-Source: APXvYqzaldzKvuGG0VSm+NPjH2zK7pPG6M4z5r7MC0BxVjXSzaHMKlB7/FcMflcuRR66LlFgIuTrrgyX4wxlYfFrPhU=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr5213363qkh.3.1576497999318;
 Mon, 16 Dec 2019 04:06:39 -0800 (PST)
MIME-Version: 1.0
References: <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com> <20191213144359.GA3826@willie-the-truck>
In-Reply-To: <20191213144359.GA3826@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 16 Dec 2019 13:06:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qgbqKTtRWTh6c0R2E93rehKbkBcB18TL3JX_RWHsTZA@mail.gmail.com>
Message-ID: <CAK8P3a0qgbqKTtRWTh6c0R2E93rehKbkBcB18TL3JX_RWHsTZA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UWsuMcFFlOevk/J313gB6VGz1OHSOZcuLzsKm2jktYu+Jb74c7v
 n49m3Y0KQsgo99+GYfL9sntR8UJzU4arEcDh5hioSmMMAIp/vdkFPGs7Up456RmIOQ//uw1
 BphOHIiIc16GAbnyE1VCu/zOyC8vcK9m8tezMoFcX8x3lPP2Cq0u+2b2TMFZ9jHwAuHkJjW
 PY8LdD75Nibt+cRAbxs8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sGYUQ7XKE8M=:PCf0CczXYZYmFeBmWDClUw
 u++4xVt/1nCcJT/59IukYBvqFnz1fPUtXT0YV4bZu1Xbqn43YcAyyxoyIGNi6p8x9H64iTAUQ
 kQArq0h7o6zMLmPuHv0sw6iT2moeTKTsX880oQd6hrp0E63lwPxngjl0rph/ZvVthq9lhQ3jv
 tQ238m6uLJBWhXBnOkRtS6Wlp3XcyqNTzlZ4f9AUSCEh/QKzwg8twmGmBWa+tPd6rqv3n8Avh
 nry587NTetViUPhKpu9NcQTscDwGJ83EHtLZqO6HTMPcAsl70VHsvOtUmv+vcDl/2EdkiPqkV
 XF6JlnkpzOmX6tfeSwxfRq0SbS437SBm/PTQVF48mds/AaWLrAFj1Ez5vaPFzpDJ4zV5xtdJ9
 j2oNst+diwEmL2/ry4tbarPY5xK5ubyppptyekYoUwu79jzUq5qfcWS1GCcXcXmBCEFioFnrS
 mkyOYA9cbd1FDtdEYLGKAVu/7p0J2LvIWNSs9Sf9N59jQKpYbW98q0hnBEMaepaMLr9EwxAAb
 M6PHcSE7XSip/CPoK97UJ/YnDYUhA5cfkNvTqpB6uPXZ5taktiz0huTKscMwUMqGX+X+ip2s9
 ksdxfNAxk4+LoIBgrXPlsLQg4Oqo8yVGeV2HMz//hTTSkCOqXatGpXbCj2843BFI3hKU8ybwC
 w9OkoxSI3JmXVkv4g+6KbNjZXDUFzcbVCG+uqvP09P/cXqaC8UTPmteGSRL6oQ/5d2xbDMRG0
 HucIL6JCt8wgPR5c1h/dDBJjXNOhdqy/lBgtlfedDrVLjqSNXrkIXdHPekTKwSZ5/fESBcMNe
 ekvNwnxip4bAzGnjFWyvhUXemHpvojYdvqSxKyvyEIkwhxEFRjDVHGofFbondDYP0kBAIhkqD
 jgR5RUxFg+LwOhnkOjvQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 11:28 AM Will Deacon <will@kernel.org> wrote:
> On Fri, Dec 13, 2019 at 02:17:08PM +0100, Arnd Bergmann wrote:
> > On Thu, Dec 12, 2019 at 9:50 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> > > > The root of my concern in all of this, and what started me looking at it in
> > > > the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> > > > for a pointer means that local variables in macros declared using typeof()
> > > > suddenly start generating *hideous* code, particularly when pointless stack
> > > > spills get stackprotector all excited.
> > >
> > > Yeah, removing volatile can be a bit annoying.
> > >
> > > For the particular case of the bitops, though, it's not an issue.
> > > Since you know the type there, you can just cast it.
> > >
> > > And if we had the rule that READ_ONCE() was an arithmetic type, you could do
> > >
> > >     typeof(0+(*p)) __var;
> > >
> > > since you might as well get the integer promotion anyway (on the
> > > non-volatile result).
> > >
> > > But that doesn't work with structures or unions, of course.
> > >
> > > I'm not entirely sure we have READ_ONCE() with a struct. I do know we
> > > have it with 64-bit entities on 32-bit machines, but that's ok with
> > > the "0+" trick.
> >
> > I'll have my randconfig builder look for instances, so far I found one,
> > see below. My feeling is that it would be better to enforce at least
> > the size being a 1/2/4/8, to avoid cases where someone thinks
> > the access is atomic, but it falls back on a memcpy.
>
> I've been using something similar built on compiletime_assert_atomic_type()
> and I spotted another instance in the xdp code (xskq_validate_desc()) which
> tries to READ_ONCE() on a 128-bit descriptor, although a /very/ quick read
> of the code suggests that this probably can't be concurrently modified if
> the ring indexes are synchronised properly.

That's the only other one I found. I have not checked how many are structs
that are the size of a normal u8/u16/u32/u64, or if there are types that
have a lower alignment than there size, such as a __u16[2] that might
span a page boundary.

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

Would it help if 32-bit architectures use atomic64_read() and atomic64_set()
to implement a 64-bit READ_ONCE()/WRITE_ONCE(), or would that make it
worse in other ways?

On mips32, riscv32 and some minor 32-bit architectures with SMP support
(xtensa,  csky, hexagon, openrisc, parisc32, sparc32 and ppc32 AFAICT) this
ends up using a spinlock for GENERIC_ATOMIC64, but at least ARMv6+,
i586+ and most ARC should be fine.

(Side note: the ARMv7 implementation is suboptimimal for ARMv7VE+
if LPAE is disabled, I think we need to really add Kconfig options for
ARMv7VE and 32-bit ARMv8 improve this and things like integer divide).

      Arnd
