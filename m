Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F266550A7
	for <lists+linux-arch@lfdr.de>; Fri, 23 Dec 2022 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLWNCk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Dec 2022 08:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiLWNCj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Dec 2022 08:02:39 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62111C1D
        for <linux-arch@vger.kernel.org>; Fri, 23 Dec 2022 05:02:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e141so5230093ybh.3
        for <linux-arch@vger.kernel.org>; Fri, 23 Dec 2022 05:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FgGdDK2lz6RD6lHxgpy8IA0EMFwDimB1CVAciou4PrA=;
        b=oTH4Pnq/W2nLZO77k8pog9TAxJBEpRvEMJtoC3fGyzsw/J558C2lOKy/v3kw8nOwHl
         HDpJ1OLlSr4Uva0yLTG7ffyPbRR2HwOvCYFbWecyxHjBe22zgNOhoGMMbtYYm76LYmvK
         g9DZ/rhkq0WBR2a29z3ptQCXs7rMHf0JebtOssHGgtS5mQP7YBeCbthLj7X7W+NLnlEs
         zsaDt0RAchYS9NpsKc1/JvXH3tZzunvbWO07q8rjoHXooEr7GAHEnI4NHTP1xPyqWpPc
         OnGIhA06NQlliAnDTnb/29eE9ylHQbClGrBLy/Z4bA3ZHePEWIzYOutK5VUORfwuBHpZ
         H0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgGdDK2lz6RD6lHxgpy8IA0EMFwDimB1CVAciou4PrA=;
        b=Z5MyBAYOu876chOmka3B/zVgVWS7jKYOCUhuAOzNrjl2nuJEWRm3AzN2E+yT2wj2yr
         iHSod0XqWv3MYMqB3owp/WMHs47ZD1vNz2jySikghG6/YduCNfEr/Q1UTGPxG/7PMjSE
         0KVTPvvhkY+S17pkBVSiAehtRSlZnAXHL5rtQ+AqpE2D54/PimXxyP9akCd+DufoYqOn
         y2+zwwZ/5WFCWBBst+jZizQwea2dy9ZdEFQJQ41uonBjZCGK850qBzhFlxpjYF5jEY6l
         gioRGWQY9BPjyiwKzcgXx4q1KiN4gKcCwqpr3T/I8PmpGope31zadH7191/MyC7c0upX
         CQgQ==
X-Gm-Message-State: AFqh2koawtNxaz8fIhwkq1/dBVSFtlj+ug1z606FGEb+VDFyhgwyOpEe
        u8RgJ/8FuOzdktZ6g2t9G0PHXx6RLko+aU33U5Y=
X-Google-Smtp-Source: AMrXdXvXC8OHBwH1Xsd6UcBj7Z+CDB9gdjQwmVPQGEiKa4NVWsHAPIcb5I2Xdq846MbGQRt6Y7gdtRe/Lf+4zg2gX8w=
X-Received: by 2002:a25:7650:0:b0:74a:79e2:3ab with SMTP id
 r77-20020a257650000000b0074a79e203abmr1022064ybc.119.1671800556006; Fri, 23
 Dec 2022 05:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20220829205219.283543-1-geomatsi@gmail.com> <CA+V-a8uLmp33PSYGmJjf9FupJ0M8Hf7ef7A1G4va8GDL_61Qyw@mail.gmail.com>
 <Y6S1/kROC0p5CboA@curiosity> <CA+V-a8u0qUF81RUTF9+4T4F1GxW3=4P7RMTTjjsaMq4MiiQSMQ@mail.gmail.com>
 <Y6TIywUWZ3nrPeon@curiosity> <CA+V-a8tMQ-RaaXD5209HxT77VoiOanvjdbFCPsdWpDYswuY+ZQ@mail.gmail.com>
 <Y6TYNBgqgWuxhhHJ@curiosity>
In-Reply-To: <Y6TYNBgqgWuxhhHJ@curiosity>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 23 Dec 2022 13:02:10 +0000
Message-ID: <CA+V-a8tDi79M8cS7rVoby3sopQ4AwXXcNggfHYXW-W2wtEgQ4g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv: mm: notify remote harts about mmu cache updates
To:     Sergey Matyukevich <geomatsi@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sergey,

On Thu, Dec 22, 2022 at 10:20 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> On Thu, Dec 22, 2022 at 09:26:07PM +0000, Lad, Prabhakar wrote:
> > Hi Sergey,
> >
> > On Thu, Dec 22, 2022 at 9:14 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > > > > > From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > > > > > >
> > > > > > > Current implementation of update_mmu_cache function performs local TLB
> > > > > > > flush. It does not take into account ASID information. Besides, it does
> > > > > > > not take into account other harts currently running the same mm context
> > > > > > > or possible migration of the running context to other harts. Meanwhile
> > > > > > > TLB flush is not performed for every context switch if ASID support
> > > > > > > is enabled.
> > > > > > >
> > > > > > > Patch [1] proposed to add ASID support to update_mmu_cache to avoid
> > > > > > > flushing local TLB entirely. This patch takes into account other
> > > > > > > harts currently running the same mm context as well as possible
> > > > > > > migration of this context to other harts.
> > > > > > >
> > > > > > > For this purpose the approach from flush_icache_mm is reused. Remote
> > > > > > > harts currently running the same mm context are informed via SBI calls
> > > > > > > that they need to flush their local TLBs. All the other harts are marked
> > > > > > > as needing a deferred TLB flush when this mm context runs on them.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-riscv/20220821013926.8968-1-tjytimi@163.com/
> > > > > > >
> > > > > > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > > > > > > ---
> > > > > > >  arch/riscv/include/asm/mmu.h      |  2 ++
> > > > > > >  arch/riscv/include/asm/pgtable.h  |  2 +-
> > > > > > >  arch/riscv/include/asm/tlbflush.h | 18 ++++++++++++++++++
> > > > > > >  arch/riscv/mm/context.c           | 10 ++++++++++
> > > > > > >  arch/riscv/mm/tlbflush.c          | 28 +++++++++++-----------------
> > > > > > >  5 files changed, 42 insertions(+), 18 deletions(-)
> > > > > > >
> > > > <snip>
> > > > > > [  133.008752] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> > > > > > [  133.015338] Call Trace:
> > > > > > [  133.017778] [<ffffffff800055cc>] dump_backtrace+0x1c/0x24
> > > > > > [  133.023174] [<ffffffff80776836>] show_stack+0x2c/0x38
> > > > > > [  133.028214] [<ffffffff80780244>] dump_stack_lvl+0x3c/0x54
> > > > > > [  133.033597] [<ffffffff80780270>] dump_stack+0x14/0x1c
> > > > > > [  133.038633] [<ffffffff80776c00>] panic+0x102/0x29a
> > > > > > [  133.043409] [<ffffffff800137ba>] do_exit+0x704/0x70a
> > > > > > [  133.048362] [<ffffffff8001390e>] do_group_exit+0x24/0x70
> > > > > > [  133.053659] [<ffffffff8001de54>] get_signal+0x68a/0x6dc
> > > > > > [  133.058874] [<ffffffff8000494e>] do_work_pending+0xd6/0x44e
> > > > > > [  133.064427] [<ffffffff800036c2>] resume_userspace_slow+0x8/0xa
> > > > > > [  133.070249] ---[ end Kernel panic - not syncing: Attempted to kill
> > > > > > init! exitcode=0x0000000b ]---
> > > > > >
> > > > > > If I revert this patch [0] bonnie++ works as expected.
> > > > > >
> > > > > > Any pointers on what could be the issue here?
> > > > > >
> > > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=4bd1d80efb5af640f99157f39b50fb11326ce641
> > > > > >
> > > > > > Cheers,
> > > > > > Prabhakar
> > > > >
> > > > > Good catch. Thanks for reporting ! Discussion around the issue and
> > > > > possible ways to fix it can be found in the following email thread:
> > > > >
> > > > > https://lore.kernel.org/linux-riscv/20221111075902.798571-1-guoren@kernel.org/
> > > > >
> > > > > Could you please apply the patch from Guo Ren instead of [0] and check
> > > > > if you have any issues with your test ? Besides, could you please share
> > > > > your kernel configuration and the actual bonnie++ params from emmc_t_002.sh script ?
> > > > >
> > > > Thanks for the pointer, I'll undo my changes and test Guo's patch.
> > > >
> > > > I have pasted the script here [0] and attached config.
> > > >
> > > > [0] https://paste.debian.net/hidden/a7a769b5/
> > >
> > > Thanks for the script and config. Could you please also share the
> > > following information:
> > > - how many cores your system has
> > The Renesas RZ/Five SoC has a single Andes AX45MP core.
> >
> > > - does your system support ASID
> > >
> > With a quick look at [0] It does support ASID, unless there is a way
> > to disable it.
> >
> > [0] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
>
> So you have a single-core system, but your kernel configuration enables
> CONFIG_SMP. Additional 'deferred TLB flush' logic is dropped at build
> time if CONFIG_SMP is disabled. On the other hand, system should not
> fail that way even if SMP is enabled.
>
I enabled CONFIG_SMP while doing some testing of PMA code and indeed
enabling this config should not introduce a failure.

> Let me double-check if anything can go wrong if cpumasks may have only
> a single cpu. Another suspect is a change in update_mmu_cache: probably
> making it asid-specific (and thus more granular) was a bad idea.
>
Thanks.

BTW I tested the patch [0] which you pointed out and that fixes the
issues seen earlier.

[0] https://patchwork.kernel.org/project/linux-riscv/patch/20221111075902.798571-1-guoren@kernel.org/

Cheers,
Prabhakar
