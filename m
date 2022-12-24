Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F41655A08
	for <lists+linux-arch@lfdr.de>; Sat, 24 Dec 2022 12:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLXLsH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Dec 2022 06:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXLsG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Dec 2022 06:48:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DDDB4D
        for <linux-arch@vger.kernel.org>; Sat, 24 Dec 2022 03:48:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bq39so2398378lfb.0
        for <linux-arch@vger.kernel.org>; Sat, 24 Dec 2022 03:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukiode13upAuOopb72PAs48UojpAkxLKmmquZz2y5sU=;
        b=CCmZ/IJwI00Ym6/4vaJUdJDAH0NB+u9O43/CiR++W3apCv55texUvwzGDjh2fykdeG
         Sg0+JrLbfmsCFceBLS1Emxu4whItx54t2ZyloSSdXlRDxr0eocdGlbNqim/1f64NArAL
         q2F2K0CZLplMEWyMEpj4c3vFy4n5NYTBafQWcjJ66kH0NOsK7Wt0HkRQrMRFq6rSbybf
         ijRCKojxsv9Bvao81xzrf78HOW3hqVCfd+DeF/ZoH+9oSOMVb9Hly5OOEcP0jLRUs/sh
         u+tS2WdrBu19axEku0ZyFrcxAsQLFBQ9+e8lb5U1oJRs9M8BuLPANy0iJ5/Axgkm9iOH
         de2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukiode13upAuOopb72PAs48UojpAkxLKmmquZz2y5sU=;
        b=hOVWqocShZTcVy2X2XPGuZjjwi6ZCnBy7dDoRV3oaV9XU4XLaf2Zv1XnFDobHHA55d
         bxxo6ZIo9pH0NOZZBjiWDo56bgqEypRq7UbFCuZMAW33tuxcWJMnlQxINX357FBqbBR9
         IsvrBXAEB+yj/Agb7CcIEirr0BTarkJJpyswQ6ZP8ZmyKlFpt752ONeIsn8001yiQZEn
         uAuLAh5VonuDmFDssaPYZjAT9utfTHZBVDZFHNRuic8iCPy0JxlNgTHS/DE3uyIIy8Z6
         oEFR2T9uNy2u5Lu6YaaQzx4Z3yWyhR7kE1YSL0EMsH13mMPdYrhZ6ECKml4DJO5CsCxM
         iWPQ==
X-Gm-Message-State: AFqh2kqabDDOWAZEfhqBUTVmJAkZ6YjUlDb0DVm7hqzc2u7iaODr7r1z
        C+4IroH1y0qB3IMdD5TS1E4=
X-Google-Smtp-Source: AMrXdXuC+k0Nq4Er3uwrWw4rCEfVQ5kJDFAocYYzKZlNczJGRIr6F3y8NkgjyPFxt/WC96NfWirxmA==
X-Received: by 2002:a05:6512:401f:b0:4ab:1cb7:473e with SMTP id br31-20020a056512401f00b004ab1cb7473emr4406661lfb.4.1671882482744;
        Sat, 24 Dec 2022 03:48:02 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id u20-20020a05651220d400b004949f7cbb6esm914420lfr.79.2022.12.24.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 03:48:01 -0800 (PST)
Date:   Sat, 24 Dec 2022 14:48:00 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>
Subject: Re: [RFC PATCH 1/1] riscv: mm: notify remote harts about mmu cache
 updates
Message-ID: <Y6bm8KIsHhFq1RFR@curiosity>
References: <20220829205219.283543-1-geomatsi@gmail.com>
 <CA+V-a8uLmp33PSYGmJjf9FupJ0M8Hf7ef7A1G4va8GDL_61Qyw@mail.gmail.com>
 <Y6S1/kROC0p5CboA@curiosity>
 <CA+V-a8u0qUF81RUTF9+4T4F1GxW3=4P7RMTTjjsaMq4MiiQSMQ@mail.gmail.com>
 <Y6TIywUWZ3nrPeon@curiosity>
 <CA+V-a8tMQ-RaaXD5209HxT77VoiOanvjdbFCPsdWpDYswuY+ZQ@mail.gmail.com>
 <Y6TYNBgqgWuxhhHJ@curiosity>
 <CA+V-a8tDi79M8cS7rVoby3sopQ4AwXXcNggfHYXW-W2wtEgQ4g@mail.gmail.com>
 <Y6Xjwg1dDYnwRbni@curiosity>
 <CA+V-a8uwmwriyoSZ1ftVQ1L1_uTL3k=VSs7Cid7++XEshq1RsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uwmwriyoSZ1ftVQ1L1_uTL3k=VSs7Cid7++XEshq1RsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Prabhakar,

> > > > > > > > > > Current implementation of update_mmu_cache function performs local TLB
> > > > > > > > > > flush. It does not take into account ASID information. Besides, it does
> > > > > > > > > > not take into account other harts currently running the same mm context
> > > > > > > > > > or possible migration of the running context to other harts. Meanwhile
> > > > > > > > > > TLB flush is not performed for every context switch if ASID support
> > > > > > > > > > is enabled.
> > > > > > > > > >
> > > > > > > > > > Patch [1] proposed to add ASID support to update_mmu_cache to avoid
> > > > > > > > > > flushing local TLB entirely. This patch takes into account other
> > > > > > > > > > harts currently running the same mm context as well as possible
> > > > > > > > > > migration of this context to other harts.
> > > > > > > > > >
> > > > > > > > > > For this purpose the approach from flush_icache_mm is reused. Remote
> > > > > > > > > > harts currently running the same mm context are informed via SBI calls
> > > > > > > > > > that they need to flush their local TLBs. All the other harts are marked
> > > > > > > > > > as needing a deferred TLB flush when this mm context runs on them.
> > > > > > > > > >
> > > > > > > > > > [1] https://lore.kernel.org/linux-riscv/20220821013926.8968-1-tjytimi@163.com/
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > > > > > > > > > ---
> > > > > > > > > >  arch/riscv/include/asm/mmu.h      |  2 ++
> > > > > > > > > >  arch/riscv/include/asm/pgtable.h  |  2 +-
> > > > > > > > > >  arch/riscv/include/asm/tlbflush.h | 18 ++++++++++++++++++
> > > > > > > > > >  arch/riscv/mm/context.c           | 10 ++++++++++
> > > > > > > > > >  arch/riscv/mm/tlbflush.c          | 28 +++++++++++-----------------
> > > > > > > > > >  5 files changed, 42 insertions(+), 18 deletions(-)
> > > > > > > > > >
> > > > > > > <snip>
> > > > > > > > > [  133.008752] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> > > > > > > > > [  133.015338] Call Trace:
> > > > > > > > > [  133.017778] [<ffffffff800055cc>] dump_backtrace+0x1c/0x24
> > > > > > > > > [  133.023174] [<ffffffff80776836>] show_stack+0x2c/0x38
> > > > > > > > > [  133.028214] [<ffffffff80780244>] dump_stack_lvl+0x3c/0x54
> > > > > > > > > [  133.033597] [<ffffffff80780270>] dump_stack+0x14/0x1c
> > > > > > > > > [  133.038633] [<ffffffff80776c00>] panic+0x102/0x29a
> > > > > > > > > [  133.043409] [<ffffffff800137ba>] do_exit+0x704/0x70a
> > > > > > > > > [  133.048362] [<ffffffff8001390e>] do_group_exit+0x24/0x70
> > > > > > > > > [  133.053659] [<ffffffff8001de54>] get_signal+0x68a/0x6dc
> > > > > > > > > [  133.058874] [<ffffffff8000494e>] do_work_pending+0xd6/0x44e
> > > > > > > > > [  133.064427] [<ffffffff800036c2>] resume_userspace_slow+0x8/0xa
> > > > > > > > > [  133.070249] ---[ end Kernel panic - not syncing: Attempted to kill
> > > > > > > > > init! exitcode=0x0000000b ]---
> > > > > > > > >
> > > > > > > > > If I revert this patch [0] bonnie++ works as expected.
> > > > > > > > >
> > > > > > > > > Any pointers on what could be the issue here?
> > > > > > > > >
> > > > > > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=4bd1d80efb5af640f99157f39b50fb11326ce641
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > Prabhakar
> > > > > > > >
> > > > > > > > Good catch. Thanks for reporting ! Discussion around the issue and
> > > > > > > > possible ways to fix it can be found in the following email thread:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/linux-riscv/20221111075902.798571-1-guoren@kernel.org/
> > > > > > > >
> > > > > > > > Could you please apply the patch from Guo Ren instead of [0] and check
> > > > > > > > if you have any issues with your test ? Besides, could you please share
> > > > > > > > your kernel configuration and the actual bonnie++ params from emmc_t_002.sh script ?
> > > > > > > >
> > > > > > > Thanks for the pointer, I'll undo my changes and test Guo's patch.
> > > > > > >
> > > > > > > I have pasted the script here [0] and attached config.
> > > > > > >
> > > > > > > [0] https://paste.debian.net/hidden/a7a769b5/
> > > > > >
> > > > > > Thanks for the script and config. Could you please also share the
> > > > > > following information:
> > > > > > - how many cores your system has
> > > > > The Renesas RZ/Five SoC has a single Andes AX45MP core.
> > > > >
> > > > > > - does your system support ASID
> > > > > >
> > > > > With a quick look at [0] It does support ASID, unless there is a way
> > > > > to disable it.
> > > > >
> > > > > [0] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > >
> > > > So you have a single-core system, but your kernel configuration enables
> > > > CONFIG_SMP. Additional 'deferred TLB flush' logic is dropped at build
> > > > time if CONFIG_SMP is disabled. On the other hand, system should not
> > > > fail that way even if SMP is enabled.
> > > >
> > > I enabled CONFIG_SMP while doing some testing of PMA code and indeed
> > > enabling this config should not introduce a failure.
> > >
> > > > Let me double-check if anything can go wrong if cpumasks may have only
> > > > a single cpu. Another suspect is a change in update_mmu_cache: probably
> > > > making it asid-specific (and thus more granular) was a bad idea.
> > > >
> > > Thanks.
> > >
> > > BTW I tested the patch [0] which you pointed out and that fixes the
> > > issues seen earlier.
> > >
> > > [0] https://patchwork.kernel.org/project/linux-riscv/patch/20221111075902.798571-1-guoren@kernel.org/
> >
> > All looks good with cpumasks in the single-core case. So deferred TLB
> > flush logic is not even executed in your case. So the root cause
> > should be in update_mmu_cache change.
> >
> > May I ask you to repeat the original emmc test on your platform from
> > for-next (i.e. with [0] and without [1]) with the following partial revert:
> >
> > : diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > : index ec6fb83349ce..92ec2d9d7273 100644
> > : --- a/arch/riscv/include/asm/pgtable.h
> > : +++ b/arch/riscv/include/asm/pgtable.h
> > : @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> > :        * Relying on flush_tlb_fix_spurious_fault would suffice, but
> > :        * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
> > :        */
> > : -     flush_tlb_page(vma, address);
> > : +     local_flush_tlb_page(address);
> > :  }
> > :
> > :  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> >
> I tested your above proposed changes and I am no longer seeing an
> issue on my platform.

Great. I will send a fixup after I double-check on several other
hardware platforms. Thanks for testing ! 

Regards,
Sergey
