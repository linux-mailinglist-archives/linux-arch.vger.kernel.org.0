Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB08539A4CB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFCPkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFCPkr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2021 11:40:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D28C06174A
        for <linux-arch@vger.kernel.org>; Thu,  3 Jun 2021 08:39:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e7so3077078plj.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Jun 2021 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xiSNoTsQAWFB9DVX3RD/cDXCI3SDa7h02xABzqIqJJ4=;
        b=WRx+02TnyU9B+J6Bx5LcciqVLSJgdpGAxTnH+jm10R1cMtfbG4GXGkTtx+7IB21AXt
         yQjPHKTTVCH79rlaXsvWBhesONX8S8ZfvqUKnjq8EduouYjEXgxVWaQAPgQTOnldsSxq
         T8a6ORlPrOsLRO3/vuumDa3cM0EoVxQ6t49k1j1QAWhjPbAijrJHop93H/0mYsV3pnUs
         0Mbkq2F/P5oMs6BBPtTPdZuQ0DKNLbD5Yew3DZrELC21l4AsHzy6+tijUQAMmsfDFhYq
         Rr/tr7TPMVvSaLkhKDB+YLTdqWbgMJsdxt523Juw4PP2V05QfnBs4SneDRJ3xD4ClYVB
         PnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xiSNoTsQAWFB9DVX3RD/cDXCI3SDa7h02xABzqIqJJ4=;
        b=feIsB242JsBHQbUT70AZ8lICm+seBikGoQBDOsZyD1iALgC38ASMZNPbeXeq9Kz1yd
         K9vcVWyr5KU1zRBZ2ctIeyWeFpex/KvW/5dn/W4Dtpx79/aNcIjQv4PSFrKNhRXZ4yFt
         WtY4uSMfIBV2QkFdPen1dDXKZCIcFVKfwxbt89nolEfo1Y95HRRHagSiQSyJMSUghIsc
         0RxPdBPieF+dpHkOci/9+9omlj3dU/5FQVCfEmTRP9kD3P8+kmbnBvOBuBlzaAZsPjt1
         NZagX2JeJ4Hy2pfNhD9mLd/0SPVu8nTMXNhv4hXz8ctaCoMAXkj2uGcTpcPQmMNYChrC
         hl1w==
X-Gm-Message-State: AOAM53248v4pdEIbXHuB2t9o+2DK/Mh8WBC/+SyKub0ReGcyml6D49aX
        LiT7Pm4JqLcJ5y7BO6iknU+7Wg==
X-Google-Smtp-Source: ABdhPJxDHapyTneuf10BOIYnHCD/30vlCMwfZHqN9aC4Dfoefbey30fBxmi4a504pBs7/DIEYY0ihA==
X-Received: by 2002:a17:902:bc81:b029:ef:3f99:9f76 with SMTP id bb1-20020a170902bc81b02900ef3f999f76mr97314plb.33.1622734742010;
        Thu, 03 Jun 2021 08:39:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r28sm2993442pgm.53.2021.06.03.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 08:39:01 -0700 (PDT)
Date:   Thu, 03 Jun 2021 08:39:01 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Jun 2021 08:38:58 PDT (-0700)
Subject:     RE: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
In-Reply-To: <CO6PR04MB7812D8905C6EEBDE8513866F8D3C9@CO6PR04MB7812.namprd04.prod.outlook.com>
CC:     guoren@kernel.org, anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, wefu@redhat.com,
        lazyparser@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, guoren@linux.alibaba.com,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-3875d1bc-74dd-4dc8-b71d-18a8f004039a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 02 Jun 2021 23:00:29 PDT (-0700), Anup Patel wrote:
>
>
>> -----Original Message-----
>> From: Palmer Dabbelt <palmer@dabbelt.com>
>> Sent: 03 June 2021 09:43
>> To: guoren@kernel.org
>> Cc: anup@brainfault.org; drew@beagleboard.org; Christoph Hellwig
>> <hch@lst.de>; Anup Patel <Anup.Patel@wdc.com>; wefu@redhat.com;
>> lazyparser@gmail.com; linux-riscv@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-arch@vger.kernel.org; linux-
>> sunxi@lists.linux.dev; guoren@linux.alibaba.com; Paul Walmsley
>> <paul.walmsley@sifive.com>
>> Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
>> 
>> On Sat, 29 May 2021 17:30:18 PDT (-0700), Palmer Dabbelt wrote:
>> > On Fri, 21 May 2021 17:36:08 PDT (-0700), guoren@kernel.org wrote:
>> >> On Wed, May 19, 2021 at 3:15 PM Anup Patel <anup@brainfault.org>
>> wrote:
>> >>>
>> >>> On Wed, May 19, 2021 at 12:24 PM Drew Fustini
>> <drew@beagleboard.org> wrote:
>> >>> >
>> >>> > On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig
>> wrote:
>> >>> > > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
>> >>> > > > Since the existing RISC-V ISA cannot solve this problem, it is
>> >>> > > > better to provide some configuration for the SOC vendor to
>> customize.
>> >>> > >
>> >>> > > We've been talking about this problem for close to five years.
>> >>> > > So no, if you don't manage to get the feature into the ISA it
>> >>> > > can't be supported.
>> >>> >
>> >>> > Isn't it a good goal for Linux to support the capabilities present
>> >>> > in the SoC that a currently being fab'd?
>> >>> >
>> >>> > I believe the CMO group only started last year [1] so the RV64GC
>> >>> > SoCs that are going into mass production this year would not have
>> >>> > had the opporuntiy of utilizing any RISC-V ISA extension for
>> >>> > handling cache management.
>> >>>
>> >>> The current Linux RISC-V policy is to only accept patches for frozen
>> >>> or ratified ISA specs.
>> >>> (Refer, Documentation/riscv/patch-acceptance.rst)
>> >>>
>> >>> This means even if emulate CMO instructions in OpenSBI, the Linux
>> >>> patches won't be taken by Palmer because CMO specification is still
>> >>> in draft stage.
>> >> Before CMO specification release, could we use a sbi_ecall to solve
>> >> the current problem? This is not against the specification, when CMO
>> >> is ready we could let users choose to use the new CMO in Linux.
>> >>
>> >> From a tech view, CMO trap emulation is the same as sbi_ecall.
>> >>
>> >>>
>> >>> Also, we all know how much time it takes for RISCV international to
>> >>> freeze some spec. Judging by that we are looking at another
>> >>> 3-4 years at minimum.
>> >
>> > Sorry for being slow here, this thread got buried.
>> >
>> > I've been trying to work with a handful of folks at the RISC-V
>> > foundation to try and get a subset of the various in-development
>> > specifications (some simple CMOs, something about non-caching in the
>> > page tables, and some way to prevent speculative accesse from
>> > generating coherence traffic that will break non-coherent systems).
>> > I'm not sure we can get this together quickly, but I'd prefer to at
>> > least try before we jump to taking vendor-specificed behavior here.
>> > It's obviously an up-hill battle to try and get specifications through
>> > the process and I'm certainly not going to promise it will work, but
>> > I'm hoping that the impending need to avoid forking the ISA will be
>> > sufficient to get people behind producing some specifications in a timely
>> fashion.
>> >
>> > I wasn't aware than this chip had non-coherent devices until I saw
>> > this thread, so we'd been mostly focused on the Beagle V chip.  That
>> > was in a sense an easier problem because the SiFive IP in it was never
>> > designed to have non-coherent devices so we'd have to make anything
>> > work via a series of slow workarounds, which would make emulating the
>> > eventually standardized behavior reasonable in terms of performance
>> > (ie, everything would be super slow so who really cares).
>> >
>> > I don't think relying on some sort of SBI call for the CMOs whould be
>> > such a performance hit that it would prevent these systems from being
>> > viable, but assuming you have reasonable performance on your
>> > non-cached accesses then that's probably not going to be viable to
>> > trap and emulate.  At that point it really just becomes silly to
>> > pretend that we're still making things work by emulating the
>> > eventually ratified behavior, as anyone who actually tries to use this
>> > thing to do IO would need out of tree patches.  I'm not sure exactly
>> > what the plan is for the page table bits in the specification right
>> > now, but if you can give me a pointer to some documentation then I'm
>> > happy to try and push for something compatible.
>> >
>> > If we can't make the process work at the foundation then I'd be
>> > strongly in favor of just biting the bullet and starting to take
>> > vendor-specific code that's been implemented in hardware and is
>> > necessarry to make things work acceptably.  That's obviously a
>> > sub-optimal solution as it'll lead to a bunch of ISA fragmentation,
>> > but at least we'll be able to keep the software stack together.
>> >
>> > Can you tell us when these will be in the hands of users?  That's
>> > pretty important here, as I don't want to be blocking real users from
>> > having their hardware work.  IIRC there were some plans to distribute
>> > early boards, but it looks like the foundation got involved and I
>> > guess I lost the thread at that point.
>> >
>> > Sorry this is all such a headache, but hopefully we can get things
>> > sorted out.
>> 
>> I talked with some of the RISC-V foundation folks, we're not going to have an
>> ISA specification for the non-coherent stuff any time soon.  I took a look at
>> this code and I definately don't want to take it as is, but I'm not opposed to
>> taking something that makes the hardware work as long as it's a lot cleaner.
>> We've already got two of these non-coherent chips, I'm sure more will come,
>> and I'd rather have the extra headaches than make everyone fork the software
>> stack.
>
> Thanks for confirming. The CMO extension is still in early stages so it will
> certainly take more time for them. After CMO extension is finalized, it will
> take some more time to have actual RISC-V platforms with CMO implemented.

Agreed.  It's going to take two or three years from the standard to get 
hardware to supporting it, so that means we're three or four years away 
(at least, there's not even any solid timeline for a spec a year from 
now) from having hardware.  There's just going to be too much 
non-standard hardware here to try to ignore it all.

>> After talking to Atish it looks like there's likely to be an SBI extension to
>> handle the CMOs, which should let us avoid the bulk of the vendor-specific
>> behavior in the kernel.  I know some people are worried about adding to the
>> SBI surface.  I'm worried about that too, but that's way better than sticking a
>> bunch of vendor-specific instructions into the kernel.  The SBI extension
>> should make for a straight-forward cache flush implementation in Linux, so
>> let's just plan on that getting through quickly (as has been done before).
>
> Yes, I agree. We can have just a single SBI call which is meant for DMA sync
> purpose only which means it will flush/invalidate pages from all cache
> levels irrespective of the cache hierarchy (i.e. flush/invalidate to RAM). The
> CMO extension might more generic cache operations which can target
> any cache level.
>
> I am already preparing a write-up for SBI DMA sync call in SBI spec. I will
> share it with you separately as well.

Great, thanks.  Atish sort of mentioned that, but I didn't want to put 
words in your mouth (and I assume you were aleep or something, due to 
time zones).

>> Unfortunately we've yet to come up with a way to handle the non-cacheable
>> mappings without introducing a degree of vendor-specific behavior or
>> seriously impacting performance (mark them as not valid and deal with them
>> in the trap handler).  I'm not really sure it counts as supporting the hardware
>> if it's massively slow, so that really leaves us with vendor-specific mappings as
>> the only option to make these chips work.
>
> A RISC-V platform can have non-cacheable mappings is following possible
> ways:
> 1) Fixed physical address range as non-cacheable using PMAs
> 2) Custom page table attributes
> 3) Svpmbt extension being defined by RVI
>
> Atish and me both think it is possible to have RISC-V specific DMA ops
> implementation which can handle all above case. Atish is already working
> on DMA ops implementation for RISC-V.

Great, thanks.  I haven't started writing any code, but I think we're 
going to be able to get a big chunk of #1 from the "dma-ranges" device 
tree stuff.  I think we still need some arch-specific allocation work to 
make sure we don't alias, though.

The page table attributes are definately going to need dma ops.  I'd 
been assuming we'd have multiple DMA op tables for the multiple flavors, 
but if they fit into a single op table cleanly that's fine -- that sort 
of stuff really needs the code here.

Since you guys have already started I'll just wait for patches.

Thanks!

>> This implementation, which adds some Kconfig entries that control page table
>> bits, definately isn't suitable for upstream.  Allowing users to set arbitrary
>> page table bits will eventually conflict with the standard, and is just going to
>> be a mess.  It'll also lead to kernels that are only compatible with specific
>> designs, which we're trying very hard to avoid.  At a bare minimum we'll need
>> some way to detect systems with these page table bits before setting them,
>> and some description of what the bits actually do so we can reason about
>> them.
>
> Yes, vendor specific Kconfig options are strict NO NO. We can't give-up the
> goal of unified kernel image for all platforms.

I think this is just a phrasing issue, but just to be sure:

IMO it's not that they're vendor-specific Kconfig options, it's that 
turning them on will conflict with standard systems (and other vendors).  
We've already got the ability to select sets of Kconfig settings that 
will only boot on one vendor's system, which is fine, as long as there 
remains a set of Kconfig settings that will boot on all systems.

An example here would be the errata: every system has errata of some 
sort, so if we start flipping off various vendor's errata Kconfigs 
you'll end up with kernels that only function properly on some systems.  
That's fine with me, as long as it's possible to turn on all vendor's 
errata Kconfigs at the same time and the resulting kernel functions 
correctly on all systems.

> Regards,
> Anup
