Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F77609C06
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 10:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJXIE1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 04:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJXIE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 04:04:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809A72663;
        Mon, 24 Oct 2022 01:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A550B80E76;
        Mon, 24 Oct 2022 08:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A10C433D6;
        Mon, 24 Oct 2022 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666598660;
        bh=zMRCR9aO2hv7wIrVCElL/LTJoQUq5XjLprILNRp63eY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q39Z0Jl1UbJQ+ydOt0a6xHmvicc/CX107NlZd3AVvTnKjNVdSgR0yjGIvpQIeKoF4
         x8ScpUmx4bU5yFkA8Q2mPwRADEbzogttzxfhc5qzex2wOgJXhACgAce/zDCqs9i3XG
         NaMEfTGrBDIjxA/FxD4lj8kEquBpzogImnn96Af3ycNgLiTD5C4072MGl1jtDduFrQ
         tEbxO3hNlFVws9P3RAaG8UOjIIJzc0l2hiDgGRKKUWZdqrdXkg4p94POm7JdNESXoI
         +p02DGC+oLj+KXmw39glLG3xh67JSd9QYCbOAceb1shPxLGQ3MUWshAft+HLP28MCi
         gpswHMEoSy9uQ==
Received: by mail-ot1-f49.google.com with SMTP id w6-20020a056830110600b00665bf86f012so325628otq.0;
        Mon, 24 Oct 2022 01:04:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf0JrIaprp3Su8qQ5QyS/NmMvUx1c3sU3810OFtsdtrzrcJnRWz1
        QMn8JibpqzfFtjES4w6reVMPDvaXh4zZ5v33ajc=
X-Google-Smtp-Source: AMsMyM5Cx/80n+ESwscTL8gLYrU0vtuSa4ffmqiRXpnSWEObRQEOy2bsVIlgF7y6VDAQAMzssohT33tmfwmul1u3/3E=
X-Received: by 2002:a9d:58c6:0:b0:663:c327:8bb with SMTP id
 s6-20020a9d58c6000000b00663c32708bbmr4290089oth.308.1666598659933; Mon, 24
 Oct 2022 01:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221024070105.306280-1-chenhuacai@loongson.cn> <20221024070105.306280-5-chenhuacai@loongson.cn>
In-Reply-To: <20221024070105.306280-5-chenhuacai@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 Oct 2022 16:04:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSN3zzvgAdiM8rYc3EGFxR4JJnHSh12mvsfUOQsqRRvkg@mail.gmail.com>
Message-ID: <CAJF2gTSN3zzvgAdiM8rYc3EGFxR4JJnHSh12mvsfUOQsqRRvkg@mail.gmail.com>
Subject: Re: [PATCH V13 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
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

On Mon, Oct 24, 2022 at 3:05 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> From: Feiyang Chen <chenfeiyang@loongson.cn>
>
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page is implemented on x86_64. However, the infrastructure of
> this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
> OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.
>
> To avoid the following build error on LoongArch we should include linux/
> static_key.h in page-flags.h. This is straightforward but the build
> error is implicitly a LoongArch-specific problem, because ARM64 and X86
> have already include static_key.h from their arch-specific core headers.
>
> In file included from ./include/linux/mmzone.h:22,
> from ./include/linux/gfp.h:6,
> from ./include/linux/mm.h:7,
> from arch/loongarch/kernel/asm-offsets.c:9:
> ./include/linux/page-flags.h:208:1: warning: data definition has no
> type or storage class
> 208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAU=
LT_ON,
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
> declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=3Dimplicit-int]
> ./include/linux/page-flags.h:209:26: warning: parameter names (without
> types) in function declaration
> 209 | hugetlb_optimize_vmemmap_key);
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h: In function 'hugetlb_optimize_vmemmap_enabl=
ed':
> ./include/linux/page-flags.h:213:16: error: implicit declaration of
> function 'static_branch_maybe' [-Werror=3Dimplicit-function-declaration]
> 213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEF=
AULT_ON,
> | ^~~~~~~~~~~~~~~~~~~
> ./include/linux/page-flags.h:213:36: error:
> 'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON' undeclared (first
> use in this function); did you mean
> 'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP'?
> 213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEF=
AULT_ON,
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> ./include/linux/page-flags.h:213:36: note: each undeclared identifier
> is reported only once for each function it appears in
> ./include/linux/page-flags.h:214:37: error:
> 'hugetlb_optimize_vmemmap_key' undeclared (first use in this
> function); did you mean 'hugetlb_optimize_vmemmap_enabled'?
> 214 | &hugetlb_optimize_vmemmap_key);
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> | hugetlb_optimize_vmemmap_enabled
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/Kconfig     | 1 +
>  include/linux/page-flags.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 6f7fa0c0ca08..0a6ef613124c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -52,6 +52,7 @@ config LOONGARCH
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USE_QUEUED_SPINLOCKS
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> +       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>         select ARCH_WANT_LD_ORPHAN_WARN
>         select ARCH_WANTS_NO_INSTR
>         select BUILDTIME_TABLE_SORT
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0ae5084e60..1aafdc73e399 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/bug.h>
>  #include <linux/mmdebug.h>
> +#include <linux/static_key.h>
Em... riscv needn't this.

>  #ifndef __GENERATING_BOUNDS_H
>  #include <linux/mm_types.h>
>  #include <generated/bounds.h>
> --
> 2.31.1
>


--=20
Best Regards
 Guo Ren
