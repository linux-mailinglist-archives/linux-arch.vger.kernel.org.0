Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4BE60E15D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiJZNAY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiJZNAR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 09:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B76B64D;
        Wed, 26 Oct 2022 06:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18B461EC7;
        Wed, 26 Oct 2022 13:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E44C43147;
        Wed, 26 Oct 2022 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666789211;
        bh=RuIUY+rX8vQ87Hr5u8x9gIRK+2Qcc/QJ2fIL10pKenw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=drA0N835VJsELpOcnuwVqQJhcjL7Ile9eiojJT1XoCgMVFRyTJ0HbOfY1o4kTjkje
         2eSfk9DnWuskgMWrPumWxTfxy1waGb5Afe2p18BxAhZY/jCYEceVIuo2KjiWP/L27L
         cdgwUtscgCf41ggwglOp3A/enE3pcUDf+mz0AIZWDLvxTv761+HcgpoJQtwCiCUdcP
         0Z+8KuyVQ3DRbK2OxorgbavxwknDifDIWIOf/Jy8cdOEAdVckEWOMfldiVhzPfQEnU
         UpUbg3MMEpUY29QETfv9IoBSHx0InWn2m1pj9eTZ9+um09B7jPOmKtOjhTJ1r+HfOZ
         uWDQL4k3Kt/RQ==
Received: by mail-ej1-f50.google.com with SMTP id d26so20901751eje.10;
        Wed, 26 Oct 2022 06:00:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ncGIEzBSiix+XzfRfn7oQ8pvT/OzffrTqnGBiLqi8isLh6AiQ
        I/NOEmMU3F5sfRwsBG4txixsXIKv+NDPJRmejKQ=
X-Google-Smtp-Source: AMsMyM4BhqSlTpO8ibTrKQeHLQ4fCvgCJZu7h/bMiC5C1Sao3Cq8lb8MWz6w3OPaxPefOI2UKkBz797pHxL+UBvb+9M=
X-Received: by 2002:a17:906:9753:b0:791:9f71:a8e6 with SMTP id
 o19-20020a170906975300b007919f71a8e6mr36598179ejy.272.1666789209448; Wed, 26
 Oct 2022 06:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221024070105.306280-1-chenhuacai@loongson.cn>
 <20221024070105.306280-5-chenhuacai@loongson.cn> <CAJF2gTSN3zzvgAdiM8rYc3EGFxR4JJnHSh12mvsfUOQsqRRvkg@mail.gmail.com>
In-Reply-To: <CAJF2gTSN3zzvgAdiM8rYc3EGFxR4JJnHSh12mvsfUOQsqRRvkg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 26 Oct 2022 20:59:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H40fcUW3jwGZXpPNjbpizXb85zytCpKGHvEGwoRpG3c0Q@mail.gmail.com>
Message-ID: <CAAhV-H40fcUW3jwGZXpPNjbpizXb85zytCpKGHvEGwoRpG3c0Q@mail.gmail.com>
Subject: Re: [PATCH V13 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ren,

On Mon, Oct 24, 2022 at 4:04 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Oct 24, 2022 at 3:05 PM Huacai Chen <chenhuacai@loongson.cn> wrot=
e:
> >
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > The feature of minimizing overhead of struct page associated with each
> > HugeTLB page is implemented on x86_64. However, the infrastructure of
> > this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
> > OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.
> >
> > To avoid the following build error on LoongArch we should include linux=
/
> > static_key.h in page-flags.h. This is straightforward but the build
> > error is implicitly a LoongArch-specific problem, because ARM64 and X86
> > have already include static_key.h from their arch-specific core headers=
.
> >
> > In file included from ./include/linux/mmzone.h:22,
> > from ./include/linux/gfp.h:6,
> > from ./include/linux/mm.h:7,
> > from arch/loongarch/kernel/asm-offsets.c:9:
> > ./include/linux/page-flags.h:208:1: warning: data definition has no
> > type or storage class
> > 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEF=
AULT_ON,
> > | ^~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> > declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=3Dimplicit-int]
> > ./include/linux/page-flags.h:209:26: warning: parameter names (without
> > types) in function declaration
> > 209 | hugetlb_optimize_vmemmap_key);
> > | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/page-flags.h: In function 'hugetlb_optimize_vmemmap_ena=
bled':
> > ./include/linux/page-flags.h:213:16: error: implicit declaration of
> > function 'static_branch_maybe' [-Werror=3Dimplicit-function-declaration=
]
> > 213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_D=
EFAULT_ON,
> > | ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/page-flags.h:213:36: error:
> > 'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON' undeclared (first
> > use in this function); did you mean
> > 'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP'?
> > 213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_D=
EFAULT_ON,
> > | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > | CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> > ./include/linux/page-flags.h:213:36: note: each undeclared identifier
> > is reported only once for each function it appears in
> > ./include/linux/page-flags.h:214:37: error:
> > 'hugetlb_optimize_vmemmap_key' undeclared (first use in this
> > function); did you mean 'hugetlb_optimize_vmemmap_enabled'?
> > 214 | &hugetlb_optimize_vmemmap_key);
> > | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > | hugetlb_optimize_vmemmap_enabled
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/Kconfig     | 1 +
> >  include/linux/page-flags.h | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 6f7fa0c0ca08..0a6ef613124c 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -52,6 +52,7 @@ config LOONGARCH
> >         select ARCH_USE_QUEUED_RWLOCKS
> >         select ARCH_USE_QUEUED_SPINLOCKS
> >         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > +       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >         select ARCH_WANT_LD_ORPHAN_WARN
> >         select ARCH_WANTS_NO_INSTR
> >         select BUILDTIME_TABLE_SORT
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 0b0ae5084e60..1aafdc73e399 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/types.h>
> >  #include <linux/bug.h>
> >  #include <linux/mmdebug.h>
> > +#include <linux/static_key.h>
> Em... riscv needn't this.
I found that after 36d4b36b69590fed99356a4426c940a25 (" lib/nodemask:
inline next_node_in() and node_random()"), build errors have gone. But
I think this is just an accident. Because that commit adds random.h
inclusion in nodemask.h, then asm-offsets.c --> sched.h --> nodemask.h
--> random.h --> once.h --> jump_label.h. If one day this chain is
adjusted, then build errors come again.

On the other hand, page-flags.h is obviously using some static_key
macros, including static_key.h is straightforward for building.

Huacai



Huacai
>
> >  #ifndef __GENERATING_BOUNDS_H
> >  #include <linux/mm_types.h>
> >  #include <generated/bounds.h>
> > --
> > 2.31.1
> >
>
>
> --
> Best Regards
>  Guo Ren
>
