Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7D6A6C1C
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCAMJJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 07:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCAMJI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 07:09:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B777ABA;
        Wed,  1 Mar 2023 04:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48F736125E;
        Wed,  1 Mar 2023 12:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39CBC433A7;
        Wed,  1 Mar 2023 12:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677672545;
        bh=LyxjBmZE6k3cyXzfB6KJvDfOSHZHGuQ/9tS1lTapdM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kw6I4aeXa2+2Y9qw6IH8RV1FmZczVbWAApPipv9xqq49sVaMTtkhZ69LA+19PvKjl
         wf481hPIc084dwtXs2yol5ag7NvJkyUrLydoYaqmDJRykeSZS5HCE1X0wPKM2h6yD+
         cSKWvux4hGVNjgTPkLkVTvKVv4/hBYInXoe6ZjpfdMNU2dPV2QkHVlohwbCdi7ANxp
         kAw6U5AhwQAgjaq5cB9VGsyghxX+hVDp4+EcwP+1ccTnwF4OSluRRQmeWBtlK9Fr3E
         H9H95QhUWuIIZZvdFl5OAo5+mej4kkLSzWej9UdLO5gPaLL/XY8L0whXlaDE+eH2m5
         wMAthLqPnLjaQ==
Received: by mail-ed1-f49.google.com with SMTP id f13so52852331edz.6;
        Wed, 01 Mar 2023 04:09:05 -0800 (PST)
X-Gm-Message-State: AO0yUKVSbyftsh6/X2IThGo/rUX7bOV+skWwDbdZz/q+v5fMI9iQDAJh
        6L48zIVZxUVvmF5z9nozJIz0hab17biR/COml5Q=
X-Google-Smtp-Source: AK7set/92sOR99OrQQ2Hss1LQNZFBaeHDmMNJ4qKgQWrSzJZFRNFm2Q9MR3c57+mNT4iHuisVIzBzhjCrBlv8F27lnU=
X-Received: by 2002:a17:906:4f99:b0:8b0:e909:9136 with SMTP id
 o25-20020a1709064f9900b008b0e9099136mr3015106eju.1.1677672543889; Wed, 01 Mar
 2023 04:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20230301085109.2373524-1-chenhuacai@loongson.cn> <b22aa314-5804-ef10-7865-2445222e2f49@xen0n.name>
In-Reply-To: <b22aa314-5804-ef10-7865-2445222e2f49@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 1 Mar 2023 20:08:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H70DGG6z5NMDg7h0GN-v3HGqi4RGvNHMpmLQ-CC=WtCzA@mail.gmail.com>
Message-ID: <CAAhV-H70DGG6z5NMDg7h0GN-v3HGqi4RGvNHMpmLQ-CC=WtCzA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Export some symbols without GPL
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Wed, Mar 1, 2023 at 6:07=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wrot=
e:
>
> Hi,
>
> On 2023/3/1 16:51, Huacai Chen wrote:
> > Some symbols, i.e., vm_map_base, empty_zero_page and invalid_pmd_table,
> > could be accessed widely by some out-of-tree non-GPL but important file
> > systems or drivers (e.g., OpenZFS). Let's use EXPORT_SYMBOL() instead o=
f
> > EXPORT_SYMBOL_GPL() to export them, so as to avoid build errors.
>
> The commit title probably could become "Mark 3 symbol exports as non-GPL"=
.
>
> Also you could drop the "some symbols, i.e.," part and go straight to
> the 3 symbols. It sounds more natural to me at least (because I know the
> current wording is 1:1 perfectly idiomatic Chinese, so it is highly
> likely some adjustment would be needed: idiomatic English don't
> *perfectly* map to Chinese).
>
> In addition to this, I've did some archaeology:
>
> In the OpenZFS case, empty_zero_page and vm_map_base are affected.
> vm_map_base is arch/loongarch invention so we actually kind of have
> "authority" over it, but what follows is a little more background on why
> EXPORT_SYMBOL is arguably more appropriate for empty_zero_page.
>
> As it stands today, only 3 architectures export empty_zero_page as a GPL
> symbol: ia64, loongarch and mips. loongarch gets the GPL export by
> inheriting from mips, and the mips export was first introduced in commit
> 497d2adcbf50b ("[MIPS] Export empty_zero_page for sake of the ext4
> module."). The ia64 export was similar: commit a7d57ecf4216e ("[IA64]
> Export three symbols for module use") did so for kvm.
>
> In both ia64 and mips, the export of empty_zero_page was done for
> satisfying some in-kernel component built as module (kvm and ext4
> respectively), and given its reasonably low-level nature, GPL is a
> reasonable choice. But looking at the bigger picture it is evident most
> other architectures do not regard it as GPL, so in effect the symbol
> probably should not be treated as such, in favor of consistency.
>
> You could incorporate some or all of this into the commit message to
> give others some background on the justification. After all reverting
> symbols to non-GPL is relatively rare compared to all the GPL-marking
> actions.
Thank you very much for giving so many backgrounds, I will update the
commit message.

Huacai
>
> >
> > Details about vm_map_base: may be referenced through macros PCI_IOBASE,
> > VMALLOC_START and VMALLOC_END.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/kernel/cpu-probe.c | 2 +-
> >   arch/loongarch/mm/init.c          | 4 ++--
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/=
cpu-probe.c
> > index 008b0249905f..001e43dd94ca 100644
> > --- a/arch/loongarch/kernel/cpu-probe.c
> > +++ b/arch/loongarch/kernel/cpu-probe.c
> > @@ -60,7 +60,7 @@ static inline void set_elf_platform(int cpu, const ch=
ar *plat)
> >
> >   /* MAP BASE */
> >   unsigned long vm_map_base;
> > -EXPORT_SYMBOL_GPL(vm_map_base);
> > +EXPORT_SYMBOL(vm_map_base);
> >
> >   static void cpu_probe_addrbits(struct cpuinfo_loongarch *c)
> >   {
> > diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> > index e018aed34586..3b7d8129570b 100644
> > --- a/arch/loongarch/mm/init.c
> > +++ b/arch/loongarch/mm/init.c
> > @@ -41,7 +41,7 @@
> >    * don't have to care about aliases on other CPUs.
> >    */
> >   unsigned long empty_zero_page, zero_page_mask;
> > -EXPORT_SYMBOL_GPL(empty_zero_page);
> > +EXPORT_SYMBOL(empty_zero_page);
> >   EXPORT_SYMBOL(zero_page_mask);
> >
> >   void setup_zero_pages(void)
> > @@ -270,7 +270,7 @@ pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligne=
d_bss;
> >   #endif
> >   #ifndef __PAGETABLE_PMD_FOLDED
> >   pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
> > -EXPORT_SYMBOL_GPL(invalid_pmd_table);
> > +EXPORT_SYMBOL(invalid_pmd_table);
> >   #endif
> >   pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
> >   EXPORT_SYMBOL(invalid_pte_table);
>
> And in the latter two cases it seems we're actually fixing
> inconsistencies. Nice!
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
