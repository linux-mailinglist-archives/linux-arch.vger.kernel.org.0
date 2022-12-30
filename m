Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83177659AB3
	for <lists+linux-arch@lfdr.de>; Fri, 30 Dec 2022 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiL3QxT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Dec 2022 11:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3QxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2022 11:53:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC05D12742
        for <linux-arch@vger.kernel.org>; Fri, 30 Dec 2022 08:53:15 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j17so22899616lfr.3
        for <linux-arch@vger.kernel.org>; Fri, 30 Dec 2022 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc3eXkY1BvvJSTG9Q7S0zEm1+3fBAd7jgliK9/1XUZI=;
        b=pe2o52fWKEPSVsUSwCw+gp2T3f77YDaCru5x4bALvoqE7PPJnyCqFUKddrEOAtKmAm
         PjYn/ZVfKaZ52+xfXxYNzfAymg4rN39u+yyw1Z50YV0EE1n1T+jA/Nclhy5laQB2ePkB
         x4ClR6bxLDqlxhAus+w87W5otr6wyDvQlmdBRQumuerRg9m3dZzIxEqZhoUbjujl7pdn
         KvAtxGjCIInt5q1ouTQHIZD49UZYOaEEy2qJpdxd3P4sS7wALD4+H1vOysf+bZSElUyM
         xcHVTk4ZAbs/TnkhCZZykQJwZZ6HIjzzABQyJyQoo9pWDd8sheqnDQAAs5YCf25So4fz
         lPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc3eXkY1BvvJSTG9Q7S0zEm1+3fBAd7jgliK9/1XUZI=;
        b=HdWDvCyzvTWvs4XO2jipEZzaRRve8FkQ7vsaQY/JYMUDVNFazzNi4koo57LCNCTZaX
         IhyapwDXRkEwgua6PNoehEwBVMJv9nIznaB1Dj9REaRcqizrPk2zvBgeNKoQsMgHWg0Y
         1JSNxCTWSZ9zgUjuNKSxFhKItct9h4NcqynEpWPa//HCX3Gh+klxpCT+PBsOo3ygF6OO
         6HsOISDZ0v/2ecmKsSKEjIJoXHi0Rd176r2PGUiNytRfsP3dvHgPB8wcy1Brw6Hu7zLG
         O8ungaV4DB0CXOUnBeBGW2YuvcDEebqOFrhfwZWW4OrDq7Q19IABhCgDlX7Wu3pFSZA6
         OCvg==
X-Gm-Message-State: AFqh2kqlbaY1iaWyJ6dd6B6pg2Y71s24rwRXInS8Q6TMDHBkTxaXjzvg
        PHdZcIFRFW8V8U2TgektOBg=
X-Google-Smtp-Source: AMrXdXvN+b5UmT4Vnh6WucCug0ttxHGDYwYIxb7f7WjnEL45E6Iqr+Hpk0cuH1p53l4Rc9XgLtmc1w==
X-Received: by 2002:a05:6512:3d93:b0:4a4:68b8:c2df with SMTP id k19-20020a0565123d9300b004a468b8c2dfmr10114938lfv.54.1672419194041;
        Fri, 30 Dec 2022 08:53:14 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id t15-20020a056512208f00b004b5774726dcsm3522893lfr.236.2022.12.30.08.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:53:12 -0800 (PST)
Date:   Fri, 30 Dec 2022 19:53:12 +0300
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
Message-ID: <Y68XeN4zJdmMP8NC@curiosity>
References: <Y6S1/kROC0p5CboA@curiosity>
 <CA+V-a8u0qUF81RUTF9+4T4F1GxW3=4P7RMTTjjsaMq4MiiQSMQ@mail.gmail.com>
 <Y6TIywUWZ3nrPeon@curiosity>
 <CA+V-a8tMQ-RaaXD5209HxT77VoiOanvjdbFCPsdWpDYswuY+ZQ@mail.gmail.com>
 <Y6TYNBgqgWuxhhHJ@curiosity>
 <CA+V-a8tDi79M8cS7rVoby3sopQ4AwXXcNggfHYXW-W2wtEgQ4g@mail.gmail.com>
 <Y6Xjwg1dDYnwRbni@curiosity>
 <CA+V-a8uwmwriyoSZ1ftVQ1L1_uTL3k=VSs7Cid7++XEshq1RsQ@mail.gmail.com>
 <Y6bm8KIsHhFq1RFR@curiosity>
 <CA+V-a8scDWmqqAXp1hOUYFcn-4Zaj3MBqeQs7QZy5WBwyXPjxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8scDWmqqAXp1hOUYFcn-4Zaj3MBqeQs7QZy5WBwyXPjxQ@mail.gmail.com>
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

> Hi Sergey,
> 
> On Sat, Dec 24, 2022 at 11:48 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> >
> > Hi Prabhakar,
> >
> > > > > > > > > > > > Current implementation of update_mmu_cache function performs local TLB
> > > > > > > > > > > > flush. It does not take into account ASID information. Besides, it does
> > > > > > > > > > > > not take into account other harts currently running the same mm context
> > > > > > > > > > > > or possible migration of the running context to other harts. Meanwhile
> > > > > > > > > > > > TLB flush is not performed for every context switch if ASID support
> > > > > > > > > > > > is enabled.
> > > > > > > > > > > >
> > > > > > > > > > > > Patch [1] proposed to add ASID support to update_mmu_cache to avoid
> > > > > > > > > > > > flushing local TLB entirely. This patch takes into account other
> > > > > > > > > > > > harts currently running the same mm context as well as possible
> > > > > > > > > > > > migration of this context to other harts.
> > > > > > > > > > > >
> > > > > > > > > > > > For this purpose the approach from flush_icache_mm is reused. Remote
> > > > > > > > > > > > harts currently running the same mm context are informed via SBI calls
> > > > > > > > > > > > that they need to flush their local TLBs. All the other harts are marked
> > > > > > > > > > > > as needing a deferred TLB flush when this mm context runs on them.
> > > > > > > > > > > >
> > > > > > > > > > > > [1] https://lore.kernel.org/linux-riscv/20220821013926.8968-1-tjytimi@163.com/
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  arch/riscv/include/asm/mmu.h      |  2 ++
> > > > > > > > > > > >  arch/riscv/include/asm/pgtable.h  |  2 +-
> > > > > > > > > > > >  arch/riscv/include/asm/tlbflush.h | 18 ++++++++++++++++++
> > > > > > > > > > > >  arch/riscv/mm/context.c           | 10 ++++++++++
> > > > > > > > > > > >  arch/riscv/mm/tlbflush.c          | 28 +++++++++++-----------------
> > > > > > > > > > > >  5 files changed, 42 insertions(+), 18 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > <snip>
> > > > > > > > > > > [  133.008752] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> > > > > > > > > > > [  133.015338] Call Trace:
> > > > > > > > > > > [  133.017778] [<ffffffff800055cc>] dump_backtrace+0x1c/0x24
> > > > > > > > > > > [  133.023174] [<ffffffff80776836>] show_stack+0x2c/0x38
> > > > > > > > > > > [  133.028214] [<ffffffff80780244>] dump_stack_lvl+0x3c/0x54
> > > > > > > > > > > [  133.033597] [<ffffffff80780270>] dump_stack+0x14/0x1c
> > > > > > > > > > > [  133.038633] [<ffffffff80776c00>] panic+0x102/0x29a
> > > > > > > > > > > [  133.043409] [<ffffffff800137ba>] do_exit+0x704/0x70a
> > > > > > > > > > > [  133.048362] [<ffffffff8001390e>] do_group_exit+0x24/0x70
> > > > > > > > > > > [  133.053659] [<ffffffff8001de54>] get_signal+0x68a/0x6dc
> > > > > > > > > > > [  133.058874] [<ffffffff8000494e>] do_work_pending+0xd6/0x44e
> > > > > > > > > > > [  133.064427] [<ffffffff800036c2>] resume_userspace_slow+0x8/0xa
> > > > > > > > > > > [  133.070249] ---[ end Kernel panic - not syncing: Attempted to kill
> > > > > > > > > > > init! exitcode=0x0000000b ]---
> > > > > > > > > > >
> > > > > > > > > > > If I revert this patch [0] bonnie++ works as expected.
> > > > > > > > > > >
> > > > > > > > > > > Any pointers on what could be the issue here?
> > > > > > > > > > >
> > > > > > > > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=4bd1d80efb5af640f99157f39b50fb11326ce641
> > > > > > > > > > >
> > > > > > > > > > > Cheers,
> > > > > > > > > > > Prabhakar
> > > > > > > > > >
> > > > > > > > > > Good catch. Thanks for reporting ! Discussion around the issue and
> > > > > > > > > > possible ways to fix it can be found in the following email thread:
> > > > > > > > > >
> > > > > > > > > > https://lore.kernel.org/linux-riscv/20221111075902.798571-1-guoren@kernel.org/
> > > > > > > > > >
> > > > > > > > > > Could you please apply the patch from Guo Ren instead of [0] and check
> > > > > > > > > > if you have any issues with your test ? Besides, could you please share
> > > > > > > > > > your kernel configuration and the actual bonnie++ params from emmc_t_002.sh script ?
> > > > > > > > > >
> > > > > > > > > Thanks for the pointer, I'll undo my changes and test Guo's patch.
> > > > > > > > >
> > > > > > > > > I have pasted the script here [0] and attached config.
> > > > > > > > >
> > > > > > > > > [0] https://paste.debian.net/hidden/a7a769b5/
> > > > > > > >
> > > > > > > > Thanks for the script and config. Could you please also share the
> > > > > > > > following information:
> > > > > > > > - how many cores your system has
> > > > > > > The Renesas RZ/Five SoC has a single Andes AX45MP core.
> > > > > > >
> > > > > > > > - does your system support ASID
> > > > > > > >
> > > > > > > With a quick look at [0] It does support ASID, unless there is a way
> > > > > > > to disable it.
> > > > > > >
> > > > > > > [0] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > > > >
> > > > > > So you have a single-core system, but your kernel configuration enables
> > > > > > CONFIG_SMP. Additional 'deferred TLB flush' logic is dropped at build
> > > > > > time if CONFIG_SMP is disabled. On the other hand, system should not
> > > > > > fail that way even if SMP is enabled.
> > > > > >
> > > > > I enabled CONFIG_SMP while doing some testing of PMA code and indeed
> > > > > enabling this config should not introduce a failure.
> > > > >
> > > > > > Let me double-check if anything can go wrong if cpumasks may have only
> > > > > > a single cpu. Another suspect is a change in update_mmu_cache: probably
> > > > > > making it asid-specific (and thus more granular) was a bad idea.
> > > > > >
> > > > > Thanks.
> > > > >
> > > > > BTW I tested the patch [0] which you pointed out and that fixes the
> > > > > issues seen earlier.
> > > > >
> > > > > [0] https://patchwork.kernel.org/project/linux-riscv/patch/20221111075902.798571-1-guoren@kernel.org/
> > > >
> > > > All looks good with cpumasks in the single-core case. So deferred TLB
> > > > flush logic is not even executed in your case. So the root cause
> > > > should be in update_mmu_cache change.
> > > >
> > > > May I ask you to repeat the original emmc test on your platform from
> > > > for-next (i.e. with [0] and without [1]) with the following partial revert:
> > > >
> > > > : diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > > : index ec6fb83349ce..92ec2d9d7273 100644
> > > > : --- a/arch/riscv/include/asm/pgtable.h
> > > > : +++ b/arch/riscv/include/asm/pgtable.h
> > > > : @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> > > > :        * Relying on flush_tlb_fix_spurious_fault would suffice, but
> > > > :        * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
> > > > :        */
> > > > : -     flush_tlb_page(vma, address);
> > > > : +     local_flush_tlb_page(address);
> > > > :  }
> > > > :
> > > > :  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> > > >
> > > I tested your above proposed changes and I am no longer seeing an
> > > issue on my platform.
> >
> > Great. I will send a fixup after I double-check on several other
> > hardware platforms. Thanks for testing !
> >
> Actuall, I did hit an issue now with your proposed changes with bonnie++ again!
> 
> [ 1873.355279] EXT4-fs (sda1): mounted filesystem
> 050ad3b9-b571-4b4c-9500-db56feed01ab with ordered data mode. Quota
> mode: disabled.
> Using uid:0, gid:0.
> Writing with putc()...done
> Writing intelligently...done
> Rewriting...done
> Reading with getc()...[ 2682.180114] sd-resolve[126]: unhandled signal
> 11 code 0x1 at 0x0000000000000000 in libc-2.28.so[3fbe503000+ff000]
> [ 2682.190552] CPU: 0 PID: 126 Comm: sd-resolve Not tainted
> 6.2.0-rc1-00111-g7bcd7d932cf6 #189
> [ 2682.198917] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> [ 2682.205536] epc : 0000003fbe568004 ra : 0000003fbe569440 sp :
> 0000003fbe417b10
> [ 2682.212770]  gp : 0000002ab8d18b88 tp : 0000003fbe41e810 t0 :
> 0000000000000022
> [ 2682.219987]  t1 : 0000003fbdbf1e4c t2 : 0000003fbe417290 s0 :
> 00000000000000e0
> [ 2682.227219]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
> 8080808080808080
> [ 2682.234433]  a2 : 0000003fb80019f0 a3 : 0000003fbe41e8f0 a4 :
> 0000000000000008
> [ 2682.241648]  a5 : 0000000000000000 a6 : fefefefefefefeff a7 :
> 0000000000000039
> [ 2682.248863]  s2 : 0000003fbe417b37 s3 : 0000003fbe417e48 s4 :
> 0000000000000001
> [ 2682.256082]  s5 : 0000003fbe417eb0 s6 : 00000000000000e0 s7 :
> 0000003fbdbf2f2a
> [ 2682.263297]  s8 : ffffffffffffffff s9 : fffffffffffffffd s10:
> ffffffffffffffff
> [ 2682.270511]  s11: fffffffffffffffe t3 : 0000000000000000 t4 :
> 000000077ce2ea37
> [ 2682.277733]  t5 : 000000000000003f t6 : 0000000000000000
> [ 2682.283046] status: 0000000200004020 badaddr: 0000000000000000
> cause: 000000000000000d
> [ 2682.441183] audit: type=1701 audit(1671222620.403:17):
> auid=4294967295 uid=995 gid=994 ses=4294967295 pid=124
> comm="sd-resolve" exe="/lib/systemd/systemd-timesyncd" sig=11 res=1
> done
> Reading intelligently...done
> 
> Let me know if you want me to share my branch.

Hmmm... I assume you hit the issue after you applied suggested partial
revert for the update_mmu_cache function. If so, then your issue is not
related to the the remaining part (deferred local_flush_tlb_all_asid)
of the commit 4bd1d80efb5a. This is because that flush is not executed
on a single-core system, even if CONFIG_SMP is enabled.

Could you please run your tests for a while on your branch with reverted
commit 4bd1d80efb5a ("riscv: mm: notify remote harts about mmu cache
updates"). It looks like the change in the function update_mmu_cache
from the commit 4bd1d80efb5a increases the probability of crash, but
there is also something else in the new kernel that bites your system.

Yes, could you please share your branch. I will take a look and run
some tests on different boards that I have at hand.

Regards,
Sergey
