Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF616268DE
	for <lists+linux-arch@lfdr.de>; Sat, 12 Nov 2022 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiKLK1C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Nov 2022 05:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKLK06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Nov 2022 05:26:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488A17E3D;
        Sat, 12 Nov 2022 02:26:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4201D60B91;
        Sat, 12 Nov 2022 10:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE5BC43145;
        Sat, 12 Nov 2022 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668248816;
        bh=xrGRndr6af8EK9Jo3B73sSAZkJjBqo9SLyX5L2AsDXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wk/IDTu67XbsB1Zbtg3RTLNHbPhF27kjVlysCqZeGC4WuW3iQUtT7jFcM1CgHCvG3
         SGfTvvNi0CEVZGwHrjUpHouXi8cW0zI0iM5gs+YgsxNAoy2DTWeYpoWLxPn6cBWCNl
         tzqCwtF3ch49/2VHJCUQBOnawM/HqS9fCGp9A0j+NGGhcndbhiVGP1HETT0r+OSM+N
         y4d7fs0HBI1Z23KjIUoLyXao5XwEPhYrKyHB8pPZdieoz7gLtwCLBbNFpobHZ77gCq
         FCEBJcW/tNwrPv4y2uiOqx/cDrX9zAGbiMkF6Ua3TP6o2wqBffsMYTiesJNu6foPVD
         1YsL2di8hreTg==
Received: by mail-ed1-f51.google.com with SMTP id s12so10795945edd.5;
        Sat, 12 Nov 2022 02:26:56 -0800 (PST)
X-Gm-Message-State: ANoB5pnnRve+/nUgJM1xe1+iRJ7EbtXf+MzGwRDKSBdTDu5XJBMhtIfa
        wrXr64oky7inj0podGSpTb94f7IzK4Qtiub7/TY=
X-Google-Smtp-Source: AA0mqf4cCb/rBaVNeOC4vccC3RXsFwpK0pA9R6rHmaDD09Q9QUoNwZ5iv4azux4dqBqbCV7wDGqTqPL3IdDKeOA1YDw=
X-Received: by 2002:aa7:db85:0:b0:463:f3a:32ce with SMTP id
 u5-20020aa7db85000000b004630f3a32cemr4917828edt.366.1668248814780; Sat, 12
 Nov 2022 02:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20221027125253.3458989-1-chenhuacai@loongson.cn>
In-Reply-To: <20221027125253.3458989-1-chenhuacai@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 12 Nov 2022 18:26:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Y5qHSXr2uHvMYpXMgvm5fU7WQmcALB+86OYkgM1XbOg@mail.gmail.com>
Message-ID: <CAAhV-H4Y5qHSXr2uHvMYpXMgvm5fU7WQmcALB+86OYkgM1XbOg@mail.gmail.com>
Subject: Re: [PATCH V14 0/4] mm/sparse-vmemmap: Generalise helpers and enable
 for LoongArch
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

Just a gentle ping, is this series good enough now? I think the last
problem (static-key.h inclusion) has also been solved.


Huacai

On Thu, Oct 27, 2022 at 8:54 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This series is in order to enable sparse-vmemmap for LoongArch. But
> LoongArch cannot use generic helpers directly because MIPS&LoongArch
> need to call pgd_init()/pud_init()/pmd_init() when populating page
> tables. So we adjust the prototypes of p?d_init() to make generic
> helpers can call them, then enable sparse-vmemmap with generic helpers,
> and to be further, generalise vmemmap_populate_hugepages() for ARM64,
> X86 and LoongArch.
>
> V1 -> V2:
> Split ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP to a separate patch.
>
> V2 -> V3:
> 1, Change the Signed-off-by order of author and committer;
> 2, Update commit message about the build error on LoongArch.
>
> V3 -> V4:
> Change pmd to pmdp for ARM64 for consistency.
>
> V4 -> V5:
> Add a detailed comment for no-fallback in the altmap case.
>
> V5 -> V6:
> 1, Fix build error for NIOS2;
> 2, Fix build error for allnoconfig;
> 3, Update comment for no-fallback in the altmap case.
>
> V6 -> V7:
> Fix build warnings of "no previous prototype".
>
> V7 -> V8:
> Fix build error for MIPS pud_init().
>
> V8 -> V9:
> Remove redundant #include to avoid build error with latest upstream
> kernel.
>
> V9 -> V10:
> Fix build error due to VMEMMAP changes in 6.0-rc1.
>
> V10 -> V11:
> Adjust context due to ARM64 changes in 6.1-rc1.
>
> V11 -> V12:
> 1, Fix build error for !SPARSEMEM;
> 2, Simplify pagetable_init() for MIPS32.
>
> V12 -> V13:
> 1, Add Acked-by and Reviewed-by tags;
> 2, Update commit message for the 4th patch.
>
> V13 -> V14:
> Remove the static_key.h inclusion in the 4th patch.
>
> Huacai Chen and Feiyang Chen(4):
>  MIPS&LoongArch&NIOS2: Adjust prototypes of p?d_init().
>  LoongArch: Add sparse memory vmemmap support.
>  mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages().
>  LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  arch/arm64/mm/mmu.c                    | 53 ++++++--------------
>  arch/loongarch/Kconfig                 |  2 +
>  arch/loongarch/include/asm/pgalloc.h   | 13 +----
>  arch/loongarch/include/asm/pgtable.h   | 13 +++--
>  arch/loongarch/include/asm/sparsemem.h |  8 +++
>  arch/loongarch/kernel/numa.c           |  4 +-
>  arch/loongarch/mm/init.c               | 44 +++++++++++++++-
>  arch/loongarch/mm/pgtable.c            | 23 +++++----
>  arch/mips/include/asm/pgalloc.h        |  8 +--
>  arch/mips/include/asm/pgtable-64.h     |  8 +--
>  arch/mips/kvm/mmu.c                    |  3 +-
>  arch/mips/mm/pgtable-32.c              | 10 ++--
>  arch/mips/mm/pgtable-64.c              | 18 ++++---
>  arch/mips/mm/pgtable.c                 |  2 +-
>  arch/x86/mm/init_64.c                  | 92 ++++++++++++----------------------
>  include/linux/mm.h                     |  8 +++
>  include/linux/page-flags.h             |  1 +
>  mm/sparse-vmemmap.c                    | 64 +++++++++++++++++++++++
>  18 files changed, 222 insertions(+), 152 deletions(-)
> --
> 2.27.0
>
