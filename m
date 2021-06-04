Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0ED39BCCD
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFDQPv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:15:51 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:40627 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFDQPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 12:15:51 -0400
Received: by mail-pf1-f177.google.com with SMTP id q25so7793758pfh.7
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/q3MBx+6Si2z8z81f51L5G5EqJzwiuIPzSDP8QDFjX4=;
        b=sIps/G3Klf14VD9kxfiTsSc2bDcZF5rw83WsoK4GAQb4Hhu2F74e1kgReIABEFQX15
         1qDvUeuTAAbwQ+hqi8kwJFOtyN8lk4BOSqSKX2lXUjpI+NpsHKFktV4jHSUUg04/PmtH
         UdZrSYWk4EuasTEMDRBp3ByPqDbNBTmU/e9e/vBTQJ86HchXIvOL+rm3o8S6yyWtMOL/
         qkjWScOfPMtqdy8F4OmbRDfHmMqxQAi6z7Nm9Eu8X1MbZ9QgbFyRn2SGS+LRzNLGONbi
         G2QsRvZ+hDJXaM/MPTZfKoSBVTQypsnSs/dlx/19/JjrntPhoEQrG4s3Ceq0bspydnAK
         UO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/q3MBx+6Si2z8z81f51L5G5EqJzwiuIPzSDP8QDFjX4=;
        b=KgdFZUCVZPfod5aUWT2ectV4k3ALwOavMbYOoDjkAgRi8sDHbBGnjYDB549xuOc+ki
         WMOyMuCG30nBs/KPQui4+yA7hnudZ3v9qblBbBwJj5Eq3Yak/n8mrfV9Byz8/axIwdx9
         GHFxdhulV65CIp95AMmWcWIYPINmdZqMKIlxWXWi8mz5zaEcfIvoG5gR82O0hoFRohdl
         3xWLL48v0B2BRM2YLan+sfcmZVg/jOMi/BVtqKQaZ1lBMwN3pXBFKL9KpvfmwjdfQm+p
         T7sPeuNETSnlCkc+/vXCchD77lovgXzstzEiRyt1oy3yy3Bax2V3UxXnI6RmKZMyTJWx
         Nz2w==
X-Gm-Message-State: AOAM532Ovn19LH3OetnG6YW5LNzwqI/LkqJ9ZCsG6IEW/5nsfsSgIz8p
        5aKiUa8obUlXnD3Fe5wZMlyrqg==
X-Google-Smtp-Source: ABdhPJwlQOA+jncSuauOHnh3xuA/3TSgkm/iQ5D1gagvY80N/621swqHch9Sxbj2S1L/UybcQ5rq2g==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr5640283pgb.110.1622823172084;
        Fri, 04 Jun 2021 09:12:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n37sm2146246pfv.47.2021.06.04.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:12:51 -0700 (PDT)
Date:   Fri, 04 Jun 2021 09:12:51 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Jun 2021 09:12:49 PDT (-0700)
Subject:     Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
In-Reply-To: <CAJF2gTTpurWpPUcA2JkF0rOFztKQgFBhOF9zQyuyi_-sxszhRQ@mail.gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Anup Patel <Anup.Patel@wdc.com>,
        anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, wefu@redhat.com,
        lazyparser@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, guoren@linux.alibaba.com,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-423aeaad-9339-4695-9a85-f947dd6135ac@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 04 Jun 2021 07:47:22 PDT (-0700), guoren@kernel.org wrote:
> Hi Arnd & Palmer,
>
> Sorry for the delayed reply, I'm working on the next version of the patch.
>
> On Fri, Jun 4, 2021 at 5:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Jun 3, 2021 at 5:39 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > On Wed, 02 Jun 2021 23:00:29 PDT (-0700), Anup Patel wrote:
>> > >> This implementation, which adds some Kconfig entries that control page table
>> > >> bits, definately isn't suitable for upstream.  Allowing users to set arbitrary
>> > >> page table bits will eventually conflict with the standard, and is just going to
>> > >> be a mess.  It'll also lead to kernels that are only compatible with specific
>> > >> designs, which we're trying very hard to avoid.  At a bare minimum we'll need
>> > >> some way to detect systems with these page table bits before setting them,
>> > >> and some description of what the bits actually do so we can reason about
>> > >> them.
>> > >
>> > > Yes, vendor specific Kconfig options are strict NO NO. We can't give-up the
>> > > goal of unified kernel image for all platforms.
> Okay,  Agree. Please help review the next version of the patch.
>
>> >
>> > I think this is just a phrasing issue, but just to be sure:
>> >
>> > IMO it's not that they're vendor-specific Kconfig options, it's that
>> > turning them on will conflict with standard systems (and other vendors).
>> > We've already got the ability to select sets of Kconfig settings that
>> > will only boot on one vendor's system, which is fine, as long as there
>> > remains a set of Kconfig settings that will boot on all systems.
>> >
>> > An example here would be the errata: every system has errata of some
>> > sort, so if we start flipping off various vendor's errata Kconfigs
>> > you'll end up with kernels that only function properly on some systems.
>> > That's fine with me, as long as it's possible to turn on all vendor's
>> > errata Kconfigs at the same time and the resulting kernel functions
>> > correctly on all systems.
>>
>> Yes, this is generally the goal, and it would be great to have that
>> working in a way where a 'defconfig' build just turns on all the options
>> that are needed to use any SoC specific features and drivers while
>> still working on all hardware. There are however limits you may run
>> into at some point, and other architectures usually only manage to span
>> some 10 to 15 years of hardware implementations with a single
>> kernel before it get really hard.
> I could follow the goal in the next version of the patchset. Please
> help review, thx.

IMO we're essentially here now with the RISC-V stuff: defconfig flips on 
everything necesasry to boot normal-smelling SOCs, with everything being 
detected as the system boots.  We have some wacky configurations like 
!MMU and XIP that are coupled to the hardware, but (and sorry for 
crossing the other threads, I missed your pointer as it's early here) as 
I said in the other thread it might be time to make it explicit that 
those things are non-portable.

The hope here has always been that we'd have enough in the standards 
that we could avoid a proliferation of vendor-specific code.  We've 
always put a strong "things keep working forever" stake in the ground in 
RISC-V land, but that's largely been because we were counting on the 
standards existing that make support easy.  In practice we don't have 
those standards so we're ending up with a fairly large software base 
that is required to support everything.  We don't have all that much 
hardware right now so we'll have to see how it goes, but for now I'm in 
favor of keeping defconfig as a "boots on everything" sort of setup -- 
both because it makes life easier for users, and because it makes issues 
like the non-portable Kconfigs that showed up here quite explicit.

If we get to 10/15 years of hardware then I'm sure we'll be removing old 
systems from defconfig (or maybe even the kernel entirely, a lot of this 
stuff isn't in production).  I'm just hoping we make it that far ;)

>> To give some common examples that make it break down:
>>
>> - 32-bit vs 64-bit already violates that rule on risc-v (as it does on
>>   most other architectures)

Yes, and there's no way around that on RISC-V.  They're different base 
ISAs therefor re-define the same instructions, so we're essentially at 
two kernel binaries by that point.  The platform spec says rv64gc, so we 
can kind of punt on this one for now.  If rv32 hardware shows up 
we'll probably want a standard system there too, which is why we've 
avoided coupling kernel portability to XLEN.

>> - architectures that support both big-endian and little-endian kernels
>>   tend to have platforms that require one or the other (e.g. mips,
>>   though not arm). Not an issue for you.

It is now!  We've added big-endian to RISC-V.  There's no hardware yet 
and very little software support.  IMO the right answer is to ban that 
from the platform spec, but again it'll depnd on what vendors want to 
build (though anyone is listening, please don't make my life miserable 
;)).

>> - page table formats are the main cause of incompatibility: arm32
>>   and x86-32 require three-level tables for certain features, but those
>>   are incompatible with older cores, arm64 supports three different
>>   page sizes, but none of them works on all cores (4KB almost works
>>   everywhere).

We actually have some support on the works for multiple page table 
levels in a single binary, which should help with a lot of that 
incompatibility.  I don't know of any plans to couple other page table 
features to the number of levels, though.

>> - SMP-enabled ARMv7 kernels can be configured to run on either
>>   ARMv6 or ARMv8, but not both, in this case because of incompatible
>>   barrier instructions.

Our barriers aren't quite split the same way, but we do have two memory 
models (RVWMO and TSO).  IIUC we should be able to support both in the 
same kernels with some patching, but the resulting kernels would be 
biased towards one memory models over the other WRT performance.  Again, 
we'll have to see what the vendors do and I'm hoping we don't end up 
with too many headaches.

>> - 32-bit Arm has a couple more remaining features that require building
>>   a machine specific kernel if enabled because they hardcode physical
>>   addresses: early printk (debug_ll, not the normal earlycon), NOMMU,
>>   and XIP.

We've got NOMMU and XIP as well, but we have some SBI support for early 
printk.  IMO we're not really sure if we've decoupled all the PA layout 
dependencies yet from Linux, as we really only support one vendor's 
systems, but we've had a lot of work lately on beefing up our memory 
layout so with any luck we'll be able to quickly sort out anything that 
comes up.
