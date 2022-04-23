Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553250C636
	for <lists+linux-arch@lfdr.de>; Sat, 23 Apr 2022 03:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiDWBxp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Apr 2022 21:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDWBxp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2022 21:53:45 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2731002
        for <linux-arch@vger.kernel.org>; Fri, 22 Apr 2022 18:50:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id bo5so9573513pfb.4
        for <linux-arch@vger.kernel.org>; Fri, 22 Apr 2022 18:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iuHt4Iz4FeZBvfTekgoBxhqf7wWZiBSKlKE/b+2tuYo=;
        b=goIqv8VMZbjl/c21Jd/hdMFrKYsyG7ZmdvPyMP0a/LfpPFogQ2pz0rqGGlL/AbTqAs
         9pSaiVPXATwgYFD5N5J3yDUb/pSsg0GPEKelq16yimQnW972dgloHJe65mdFFqD9Do1K
         rfbVg7wta3owfIXNgtPf9exTJ5PLWsXRn7YHotwHXiR3Lkj659kCquaRDrj310oN7KKB
         jMZM6HpvA98IESGZVPUiQud4tbPccE2u3eNVzqTqrXy3s0yTKF6yVKnJ7iGeA60/fd96
         +GWnu5/SHFOm3yjfGlSdAu7G7dd4BdX/igL9srOjG3lvbYLAaHSMkweQg27Zn7pzyHq/
         VUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iuHt4Iz4FeZBvfTekgoBxhqf7wWZiBSKlKE/b+2tuYo=;
        b=fMvcYHd8POkoTvu9nrfbTRow3miOHFhRxTKKbGRu4ir4pZ0SwdS//fRkNhJZ+ycPoO
         b9ICLC57Uz2Lnu11TVAiNjrfoLjLLPJRdh7EZa78vdpbDfFxEJI2qCNxskS8lwfkXb+3
         fk+8daSKvJe1BwoNdFB2iRHlm9Eedpd0KbAqHmOXEHombZfT2tyk55Sg5v3D9p2bHxC2
         061kvJKZWu1+dgyjHcKcUdu8d3zdbSoaKpwSX7OKQl42cu0WmXjbl2nkgm9Yk3ZVSXE7
         SG1o4WhcwZTcFo+orNPS1PVN7Rs2dFEb4vwRZzEpZ/ttIYXbrMjKHx2+ExB8ah9mCvEe
         ZBUA==
X-Gm-Message-State: AOAM5339IZPSQmFBCeydPTqSk+F/7ClK2w5+WToeSWj9CMwX3yog/t7X
        WAA4wejeBKL0PQj/uaKZ9cLbAA==
X-Google-Smtp-Source: ABdhPJxJGqglrviMvw8Swe1RM63k2IYS5w00YAqVduQcH5u9WbhL2yia4TEU96zrIIxxdu1APdK0XA==
X-Received: by 2002:a63:c5:0:b0:3aa:9882:9f91 with SMTP id 188-20020a6300c5000000b003aa98829f91mr6164187pga.574.1650678648423;
        Fri, 22 Apr 2022 18:50:48 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm3684931pfg.133.2022.04.22.18.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 18:50:47 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:50:47 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Apr 2022 18:50:27 PDT (-0700)
Subject:     Re: [PATCH v3 00/13] Introduce sv48 support without relocatable kernel
In-Reply-To: <CA+zEjCuyEsB0cHoL=zepejcRbn9Rwg9nRXLMZCOXe_daSWbvig@mail.gmail.com>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, zong.li@sifive.com, anup@brainfault.org,
        Atish.Patra@rivosinc.com, Christoph Hellwig <hch@lst.de>,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, guoren@linux.alibaba.com,
        heinrich.schuchardt@canonical.com, mchitale@ventanamicro.com,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-f386a42e-77d9-4644-914f-552a8e721f5c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 01 Apr 2022 05:56:30 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> On Fri, Feb 18, 2022 at 11:45 AM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
>>
>> Hi Palmer,
>>
>> On Thu, Jan 20, 2022 at 11:05 AM Alexandre Ghiti
>> <alexandre.ghiti@canonical.com> wrote:
>> >
>> > On Thu, Jan 20, 2022 at 8:30 AM Alexandre Ghiti
>> > <alexandre.ghiti@canonical.com> wrote:
>> > >
>> > > On Thu, Jan 20, 2022 at 5:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > > >
>> > > > On Mon, 06 Dec 2021 02:46:44 PST (-0800), alexandre.ghiti@canonical.com wrote:
>> > > > > * Please note notable changes in memory layouts and kasan population *
>> > > > >
>> > > > > This patchset allows to have a single kernel for sv39 and sv48 without
>> > > > > being relocatable.
>> > > > >
>> > > > > The idea comes from Arnd Bergmann who suggested to do the same as x86,
>> > > > > that is mapping the kernel to the end of the address space, which allows
>> > > > > the kernel to be linked at the same address for both sv39 and sv48 and
>> > > > > then does not require to be relocated at runtime.
>> > > > >
>> > > > > This implements sv48 support at runtime. The kernel will try to
>> > > > > boot with 4-level page table and will fallback to 3-level if the HW does not
>> > > > > support it. Folding the 4th level into a 3-level page table has almost no
>> > > > > cost at runtime.
>> > > > >
>> > > > > Note that kasan region had to be moved to the end of the address space
>> > > > > since its location must be known at compile-time and then be valid for
>> > > > > both sv39 and sv48 (and sv57 that is coming).
>> > > > >
>> > > > > Tested on:
>> > > > >   - qemu rv64 sv39: OK
>> > > > >   - qemu rv64 sv48: OK
>> > > > >   - qemu rv64 sv39 + kasan: OK
>> > > > >   - qemu rv64 sv48 + kasan: OK
>> > > > >   - qemu rv32: OK
>> > > > >
>> > > > > Changes in v3:
>> > > > >   - Fix SZ_1T, thanks to Atish
>> > > > >   - Fix warning create_pud_mapping, thanks to Atish
>> > > > >   - Fix k210 nommu build, thanks to Atish
>> > > > >   - Fix wrong rebase as noted by Samuel
>> > > > >   - * Downgrade to sv39 is only possible if !KASAN (see commit changelog) *
>> > > > >   - * Move KASAN next to the kernel: virtual layouts changed and kasan population *
>> > > > >
>> > > > > Changes in v2:
>> > > > >   - Rebase onto for-next
>> > > > >   - Fix KASAN
>> > > > >   - Fix stack canary
>> > > > >   - Get completely rid of MAXPHYSMEM configs
>> > > > >   - Add documentation
>> > > > >
>> > > > > Alexandre Ghiti (13):
>> > > > >   riscv: Move KASAN mapping next to the kernel mapping
>> > > > >   riscv: Split early kasan mapping to prepare sv48 introduction
>> > > > >   riscv: Introduce functions to switch pt_ops
>> > > > >   riscv: Allow to dynamically define VA_BITS
>> > > > >   riscv: Get rid of MAXPHYSMEM configs
>> > > > >   asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
>> > > > >   riscv: Implement sv48 support
>> > > > >   riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
>> > > > >   riscv: Explicit comment about user virtual address space size
>> > > > >   riscv: Improve virtual kernel memory layout dump
>> > > > >   Documentation: riscv: Add sv48 description to VM layout
>> > > > >   riscv: Initialize thread pointer before calling C functions
>> > > > >   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
>> > > > >
>> > > > >  Documentation/riscv/vm-layout.rst             |  48 ++-
>> > > > >  arch/riscv/Kconfig                            |  37 +-
>> > > > >  arch/riscv/configs/nommu_k210_defconfig       |   1 -
>> > > > >  .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
>> > > > >  arch/riscv/configs/nommu_virt_defconfig       |   1 -
>> > > > >  arch/riscv/include/asm/csr.h                  |   3 +-
>> > > > >  arch/riscv/include/asm/fixmap.h               |   1
>> > > > >  arch/riscv/include/asm/kasan.h                |  11 +-
>> > > > >  arch/riscv/include/asm/page.h                 |  20 +-
>> > > > >  arch/riscv/include/asm/pgalloc.h              |  40 ++
>> > > > >  arch/riscv/include/asm/pgtable-64.h           | 108 ++++-
>> > > > >  arch/riscv/include/asm/pgtable.h              |  47 +-
>> > > > >  arch/riscv/include/asm/sparsemem.h            |   6 +-
>> > > > >  arch/riscv/kernel/cpu.c                       |  23 +-
>> > > > >  arch/riscv/kernel/head.S                      |   4 +-
>> > > > >  arch/riscv/mm/context.c                       |   4 +-
>> > > > >  arch/riscv/mm/init.c                          | 408 ++++++++++++++----
>> > > > >  arch/riscv/mm/kasan_init.c                    | 250 ++++++++---
>> > > > >  drivers/firmware/efi/libstub/efi-stub.c       |   2
>> > > > >  drivers/pci/controller/pci-xgene.c            |   2 +-
>> > > > >  include/asm-generic/pgalloc.h                 |  24 +-
>> > > > >  include/linux/sizes.h                         |   1
>> > > > >  22 files changed, 833 insertions(+), 209 deletions(-)
>> > > >
>> > > > Sorry this took a while.  This is on for-next, with a bit of juggling: a
>> > > > handful of trivial fixes for configs that were failing to build/boot and
>> > > > some merge issues.  I also pulled out that MAXPHYSMEM fix to the top, so
>> > > > it'd be easier to backport.  This is bigger than something I'd normally like to
>> > > > take late in the cycle, but given there's a lot of cleanups, likely some fixes,
>> > > > and it looks like folks have been testing this I'm just going to go with it.
>> > > >
>> > >
>> > > Yes yes yes! That's fantastic news :)
>> > >
>> > > > Let me know if there's any issues with the merge, it was a bit hairy.
>> > > > Probably best to just send along a fixup patch at this point.
>> > >
>> > > I'm going to take a look at that now, and I'll fix anything that comes
>> > > up quickly :)
>> >
>> > I see in for-next that you did not take the following patches:
>> >
>> >   riscv: Improve virtual kernel memory layout dump
>> >   Documentation: riscv: Add sv48 description to VM layout
>> >   riscv: Initialize thread pointer before calling C functions
>> >   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
>> >
>> > I'm not sure this was your intention. If it was, I believe that at
>> > least the first 2 patches are needed in this series, the 3rd one is a
>> > useful fix and we can discuss the 4th if that's an issue for you.
>>
>> Can you confirm that this was intentional and maybe explain the
>> motivation behind it? Because I see value in those patches.
>
> Palmer,
>
> I read that you were still taking patches for 5.18, so I confirm again
> that the patches above are needed IMO.

It was too late for this when it was sent (I saw it then, but just got 
around to actually doing the work to sort it out).

It took me a while to figure out exactly what was going on here, but I 
think I remember now: that downgrade patch (and the follow-on I just 
sent) is broken for medlow, because mm/init.c must be built medany 
(which we're using for the mostly-PIC qualities).  I remember being in 
the middle of rebasing/debugging this a while ago, I must have forgotten 
I was in the middle of that and accidentally merged the branch as-is.  
Certainly wasn't trying to silently take half the patch set and leave 
the rest in limbo, that's the wrong way to do things. 

I'm not sure what the right answer is here, but I just sent a patch to 
drop support for medlow.  We'll have to talk about that, for now I 
cleaned up some other minor issues, rearranged that docs and fix to come 
first, and put this at palmer/riscv-sv48.  I think that fix is 
reasonable to take the doc and fix into fixes, then the dump improvement 
on for-next.  We'll have to see what folks think about the medany-only 
kernels, the other option would be to build FDT as medany which seems a 
bit awkward.  

> Maybe even the relocatable series?

Do you mind giving me a pointer?  I'm not sure why I'm so drop-prone 
with your patches, I promise I'm not doing it on purpose.

>
> Thanks,
>
> Alex
>
>>
>> Thanks,
>>
>> Alex
>>
>> >
>> > I tested for-next on both sv39 and sv48 successfully, I took a glance
>> > at the code and noticed you fixed the PTRS_PER_PGD error, thanks for
>> > that. Otherwise nothing obvious has popped.
>> >
>> > Thanks again,
>> >
>> > Alex
>> >
>> > >
>> > > Thanks!
>> > >
>> > > Alex
>> > >
>> > > >
>> > > > Thanks!
