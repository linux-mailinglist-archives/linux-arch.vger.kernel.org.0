Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36139D3DC
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 06:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGEYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 00:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhFGEYT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 00:24:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B1ED61244;
        Mon,  7 Jun 2021 04:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623039749;
        bh=w0Tct7TLCCrzZsCnmVFxhk0rgBdL5pL2Hl2bNoy6Qgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UnDSNxeoqcv0/hsx2aLzTIffPPPMYcv/RSUG6CD6/DYKriUJjsZbA/q+tP77DudTo
         VBEEcZGNgqspbxVFL8+mq490Y4jZQ0tKGYeny+JLjCVIq1PL26kppi4ZAbLpU7Ageq
         VhKgzEKGPYD+xZ/vdL0rhZDN7tMCxluXMp0A8TSq1+td8teklCqRXxzfofsKpX5fJW
         RIZvxIjwTPWfy/IUOcqQBlFc3+bTB7h5VPUtfGIliq2MhrbQjdu38vIXwSV7vJVAA8
         VWjJMOOLzHAyVtKLVdeiLBPbmCq7mRhvKyF6glZ4yXfwkKtuA6/u0p52vTjeXB4Ekn
         Zua28LPdIao5A==
Received: by mail-lj1-f178.google.com with SMTP id n17so3144553ljg.2;
        Sun, 06 Jun 2021 21:22:29 -0700 (PDT)
X-Gm-Message-State: AOAM532Z+I4r4QwGt1WYR3cbkq9ocltTHI8upFqhEzbImWcElLE9nlbZ
        ZG/XPvLzBFrrIjVFPaF5TB/C43PSEfwIXyxPoyI=
X-Google-Smtp-Source: ABdhPJywQZATuh7ciiYZKICWSotgwqD/5go8Iab8LOhQTYgbCBGnhM+s1JtxSRM/NSUBRAltU7qg73APnt7ziEs5S50=
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr13391275ljn.115.1623039747520;
 Sun, 06 Jun 2021 21:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-a5f8374f-350b-4c13-86e8-c6aa5e697454@palmerdabbelt-glaptop>
 <mhng-c0406cea-776b-49d2-a223-13a83d3a7433@palmerdabbelt-glaptop>
 <CO6PR04MB7812D8905C6EEBDE8513866F8D3C9@CO6PR04MB7812.namprd04.prod.outlook.com>
 <CAJF2gTRH6OVB1RrOyp88LDvX3fV0doJxNTM61trWxJsLaX0X0g@mail.gmail.com> <CO6PR04MB7812614750AE3CA78D49C0AD8D389@CO6PR04MB7812.namprd04.prod.outlook.com>
In-Reply-To: <CO6PR04MB7812614750AE3CA78D49C0AD8D389@CO6PR04MB7812.namprd04.prod.outlook.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 7 Jun 2021 12:22:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSgC2+ULpfSQKvan7phPf8VT+nxUiekfpHELNjsQYo=CA@mail.gmail.com>
Message-ID: <CAJF2gTSgC2+ULpfSQKvan7phPf8VT+nxUiekfpHELNjsQYo=CA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>,
        "wefu@redhat.com" <wefu@redhat.com>,
        "lazyparser@gmail.com" <lazyparser@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anup,

On Mon, Jun 7, 2021 at 11:38 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Guo Ren <guoren@kernel.org>
> > Sent: 06 June 2021 22:42
> > To: Anup Patel <Anup.Patel@wdc.com>; Atish Patra <atishp@atishpatra.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>; anup@brainfault.org;
> > drew@beagleboard.org; Christoph Hellwig <hch@lst.de>; wefu@redhat.com;
> > lazyparser@gmail.com; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> > sunxi@lists.linux.dev; guoren@linux.alibaba.com; Paul Walmsley
> > <paul.walmsley@sifive.com>
> > Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
> >
> > Hi Anup and Atish,
> >
> > On Thu, Jun 3, 2021 at 2:00 PM Anup Patel <Anup.Patel@wdc.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Palmer Dabbelt <palmer@dabbelt.com>
> > > > Sent: 03 June 2021 09:43
> > > > To: guoren@kernel.org
> > > > Cc: anup@brainfault.org; drew@beagleboard.org; Christoph Hellwig
> > > > <hch@lst.de>; Anup Patel <Anup.Patel@wdc.com>; wefu@redhat.com;
> > > > lazyparser@gmail.com; linux-riscv@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> > > > sunxi@lists.linux.dev; guoren@linux.alibaba.com; Paul Walmsley
> > > > <paul.walmsley@sifive.com>
> > > > Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
> > > >
> > > > On Sat, 29 May 2021 17:30:18 PDT (-0700), Palmer Dabbelt wrote:
> > > > > On Fri, 21 May 2021 17:36:08 PDT (-0700), guoren@kernel.org wrote:
> > > > >> On Wed, May 19, 2021 at 3:15 PM Anup Patel <anup@brainfault.org>
> > > > wrote:
> > > > >>>
> > > > >>> On Wed, May 19, 2021 at 12:24 PM Drew Fustini
> > > > <drew@beagleboard.org> wrote:
> > > > >>> >
> > > > >>> > On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig
> > > > wrote:
> > > > >>> > > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> > > > >>> > > > Since the existing RISC-V ISA cannot solve this problem,
> > > > >>> > > > it is better to provide some configuration for the SOC
> > > > >>> > > > vendor to
> > > > customize.
> > > > >>> > >
> > > > >>> > > We've been talking about this problem for close to five years.
> > > > >>> > > So no, if you don't manage to get the feature into the ISA
> > > > >>> > > it can't be supported.
> > > > >>> >
> > > > >>> > Isn't it a good goal for Linux to support the capabilities
> > > > >>> > present in the SoC that a currently being fab'd?
> > > > >>> >
> > > > >>> > I believe the CMO group only started last year [1] so the
> > > > >>> > RV64GC SoCs that are going into mass production this year
> > > > >>> > would not have had the opporuntiy of utilizing any RISC-V ISA
> > > > >>> > extension for handling cache management.
> > > > >>>
> > > > >>> The current Linux RISC-V policy is to only accept patches for
> > > > >>> frozen or ratified ISA specs.
> > > > >>> (Refer, Documentation/riscv/patch-acceptance.rst)
> > > > >>>
> > > > >>> This means even if emulate CMO instructions in OpenSBI, the
> > > > >>> Linux patches won't be taken by Palmer because CMO specification
> > > > >>> is still in draft stage.
> > > > >> Before CMO specification release, could we use a sbi_ecall to
> > > > >> solve the current problem? This is not against the specification,
> > > > >> when CMO is ready we could let users choose to use the new CMO in
> > Linux.
> > > > >>
> > > > >> From a tech view, CMO trap emulation is the same as sbi_ecall.
> > > > >>
> > > > >>>
> > > > >>> Also, we all know how much time it takes for RISCV international
> > > > >>> to freeze some spec. Judging by that we are looking at another
> > > > >>> 3-4 years at minimum.
> > > > >
> > > > > Sorry for being slow here, this thread got buried.
> > > > >
> > > > > I've been trying to work with a handful of folks at the RISC-V
> > > > > foundation to try and get a subset of the various in-development
> > > > > specifications (some simple CMOs, something about non-caching in
> > > > > the page tables, and some way to prevent speculative accesse from
> > > > > generating coherence traffic that will break non-coherent systems).
> > > > > I'm not sure we can get this together quickly, but I'd prefer to
> > > > > at least try before we jump to taking vendor-specificed behavior here.
> > > > > It's obviously an up-hill battle to try and get specifications
> > > > > through the process and I'm certainly not going to promise it will
> > > > > work, but I'm hoping that the impending need to avoid forking the
> > > > > ISA will be sufficient to get people behind producing some
> > > > > specifications in a timely
> > > > fashion.
> > > > >
> > > > > I wasn't aware than this chip had non-coherent devices until I saw
> > > > > this thread, so we'd been mostly focused on the Beagle V chip.
> > > > > That was in a sense an easier problem because the SiFive IP in it
> > > > > was never designed to have non-coherent devices so we'd have to
> > > > > make anything work via a series of slow workarounds, which would
> > > > > make emulating the eventually standardized behavior reasonable in
> > > > > terms of performance (ie, everything would be super slow so who really
> > cares).
> > > > >
> > > > > I don't think relying on some sort of SBI call for the CMOs whould
> > > > > be such a performance hit that it would prevent these systems from
> > > > > being viable, but assuming you have reasonable performance on your
> > > > > non-cached accesses then that's probably not going to be viable to
> > > > > trap and emulate.  At that point it really just becomes silly to
> > > > > pretend that we're still making things work by emulating the
> > > > > eventually ratified behavior, as anyone who actually tries to use
> > > > > this thing to do IO would need out of tree patches.  I'm not sure
> > > > > exactly what the plan is for the page table bits in the
> > > > > specification right now, but if you can give me a pointer to some
> > > > > documentation then I'm happy to try and push for something
> > compatible.
> > > > >
> > > > > If we can't make the process work at the foundation then I'd be
> > > > > strongly in favor of just biting the bullet and starting to take
> > > > > vendor-specific code that's been implemented in hardware and is
> > > > > necessarry to make things work acceptably.  That's obviously a
> > > > > sub-optimal solution as it'll lead to a bunch of ISA
> > > > > fragmentation, but at least we'll be able to keep the software stack
> > together.
> > > > >
> > > > > Can you tell us when these will be in the hands of users?  That's
> > > > > pretty important here, as I don't want to be blocking real users
> > > > > from having their hardware work.  IIRC there were some plans to
> > > > > distribute early boards, but it looks like the foundation got
> > > > > involved and I guess I lost the thread at that point.
> > > > >
> > > > > Sorry this is all such a headache, but hopefully we can get things
> > > > > sorted out.
> > > >
> > > > I talked with some of the RISC-V foundation folks, we're not going
> > > > to have an ISA specification for the non-coherent stuff any time
> > > > soon.  I took a look at this code and I definately don't want to
> > > > take it as is, but I'm not opposed to taking something that makes the
> > hardware work as long as it's a lot cleaner.
> > > > We've already got two of these non-coherent chips, I'm sure more
> > > > will come, and I'd rather have the extra headaches than make
> > > > everyone fork the software stack.
> > >
> > > Thanks for confirming. The CMO extension is still in early stages so
> > > it will certainly take more time for them. After CMO extension is
> > > finalized, it will take some more time to have actual RISC-V platforms with
> > CMO implemented.
> > >
> > > >
> > > > After talking to Atish it looks like there's likely to be an SBI
> > > > extension to handle the CMOs, which should let us avoid the bulk of
> > > > the vendor-specific behavior in the kernel.  I know some people are
> > > > worried about adding to the SBI surface.  I'm worried about that
> > > > too, but that's way better than sticking a bunch of vendor-specific
> > > > instructions into the kernel.  The SBI extension should make for a
> > > > straight-forward cache flush implementation in Linux, so let's just plan on
> > that getting through quickly (as has been done before).
> > >
> > > Yes, I agree. We can have just a single SBI call which is meant for
> > > DMA sync purpose only which means it will flush/invalidate pages from
> > > all cache levels irrespective of the cache hierarchy (i.e.
> > > flush/invalidate to RAM). The CMO extension might more generic cache
> > > operations which can target any cache level.
> > >
> > > I am already preparing a write-up for SBI DMA sync call in SBI spec. I
> > > will share it with you separately as well.
> > >
> > > >
> > > > Unfortunately we've yet to come up with a way to handle the
> > > > non-cacheable mappings without introducing a degree of
> > > > vendor-specific behavior or seriously impacting performance (mark
> > > > them as not valid and deal with them in the trap handler).  I'm not
> > > > really sure it counts as supporting the hardware if it's massively
> > > > slow, so that really leaves us with vendor-specific mappings as the only
> > option to make these chips work.
> > >
> > > A RISC-V platform can have non-cacheable mappings is following
> > > possible
> > > ways:
> > > 1) Fixed physical address range as non-cacheable using PMAs
> > > 2) Custom page table attributes
> > > 3) Svpmbt extension being defined by RVI
> > >
> > > Atish and me both think it is possible to have RISC-V specific DMA ops
> > > implementation which can handle all above case. Atish is already
> > > working on DMA ops implementation for RISC-V.
> > Not only DMA ops, but also icache_sync & __vdso_icache_sync. Please have a
> > look at:
> > https://lore.kernel.org/linux-riscv/1622970249-50770-12-git-send-email-
> > guoren@kernel.org/T/#u
>
> The icache_sync and __vdso_icache_sync will have to be addressed
> differently. The SBI DMA sync extension cannot address this.
Agree

>
> It seems Allwinner D1 have more non-standard stuff:
> 1) Custom PTE bits for IO-coherent access
> 2) Custom data cache flush/invalidate for DMA sync
> 3) Custom icache flush/invalidate
Yes, but 3) is a performance optimization, not critical for running.

>
> Other hand, BeagleV has only two problems:
> 1) Custom physical address range for IO-coherent access
> 2) Custom L2 cache flush/invalidate for DMA sync
https://github.com/starfive-tech/linux/commit/d4c4044c08134dca8e5eaaeb6d3faf97dc453b6d

Currently, they still use DMA sync with DMA descriptor, are you sure
they have minor memory physical address.

>
> From above #2, can be solved by SBI DMA sync call and
> Linux DMA ops for both BeagleV and Allwinner D1
>
> On BeagleV, issue #1 can be solved using "dma-ranges".
>
> On Allwinner D1, issues #1 and #3 need to be addressed
> separately.
>
> I think supporting BeagleV in upstream Linux is relatively
> easy compared to Allwinner D1.
>
> @Guo, please check if you can reserve dedicated
> physical address range for IO-coherent access (just like
> BeagleV). If yes, then we can tackle issue #1 for Allwinner
> D1 using "dma-ranges" DT property.
There is no dedicated physical address range for IO-coherent access in
D1. But the solution you mentioned couldn't solve all requirements.
Only one mirror physical address range is not enough, we need at least
three (Normal, DMA desc, frame buffer).
And that will triple the memory physical address which can't be
accepted by our users from the hardware design cost view.

 "dma-ranges" DT property is a big early MIPS smell. ARM SOC users
can't accept it. (They just say replace the CPU, but don't touch
anything other.)

PTE attributes are the non-coherent solution for many years. MIPS also
follows that now:
ref arch/mips/include/asm/pgtable-bits.h & arch/mips/include/asm/pgtable.h

#ifndef _CACHE_CACHABLE_NO_WA
#define _CACHE_CACHABLE_NO_WA           (0<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_CACHABLE_WA
#define _CACHE_CACHABLE_WA              (1<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_UNCACHED
#define _CACHE_UNCACHED                 (2<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_CACHABLE_NONCOHERENT
#define _CACHE_CACHABLE_NONCOHERENT     (3<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_CACHABLE_CE
#define _CACHE_CACHABLE_CE              (4<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_CACHABLE_COW
#define _CACHE_CACHABLE_COW             (5<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_CACHABLE_CUW
#define _CACHE_CACHABLE_CUW             (6<<_CACHE_SHIFT)
#endif
#ifndef _CACHE_UNCACHED_ACCELERATED
#define _CACHE_UNCACHED_ACCELERATED     (7<<_CACHE_SHIFT)

We can't force our users to double/triplicate their physical memory regions.

>
> Regards,
> Anup
>
> >
> >
> > >
> > > >
> > > > This implementation, which adds some Kconfig entries that control
> > > > page table bits, definately isn't suitable for upstream.  Allowing
> > > > users to set arbitrary page table bits will eventually conflict with
> > > > the standard, and is just going to be a mess.  It'll also lead to
> > > > kernels that are only compatible with specific designs, which we're
> > > > trying very hard to avoid.  At a bare minimum we'll need some way to
> > > > detect systems with these page table bits before setting them, and
> > > > some description of what the bits actually do so we can reason about
> > them.
> > >
> > > Yes, vendor specific Kconfig options are strict NO NO. We can't
> > > give-up the goal of unified kernel image for all platforms.
> > >
> > > Regards,
> > > Anup
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
