Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A038607939
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiJUOIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJUOIq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 10:08:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0817284E;
        Fri, 21 Oct 2022 07:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 717D6B82C13;
        Fri, 21 Oct 2022 14:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203AEC43146;
        Fri, 21 Oct 2022 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666361323;
        bh=Xo9JwJY/XMU3fy2R/321Jyhdz5lA7kxLyPv0VQaYCmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wwaa/+fZi02vh1Dn21QNaUJd4JP907px6Nm2UnMwpekf2npzFOwFvhPioALc1UONJ
         8ofPTUVMkQw1G3VveiPd76Sos1nwVY2/heVdF4oWu/3qV/74un5rqmkowQV31T7UQw
         t7ZNkB5TYOYj7abhCh2mSD7ofTrM63eidIF0dcEFUbCSKTFEfV23jErCMz0lyDrXtN
         Pq8LYbHWAwUzAEd7hdrnsobs3zH6s5vlf62R8Rsl7pR/SBDWUOd9X2KrvYay9ZZVwI
         N0MUMXqs3GsFnFvE/N8tXfXWWOuc1msGmZOhYsyr2bMyxB0ssBXFGLlxFhLJndP1Vo
         b1rQ4qAJLUjbg==
Received: by mail-ed1-f52.google.com with SMTP id w8so3982657edc.1;
        Fri, 21 Oct 2022 07:08:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf01+uJx5KFCxnQpol9auhN3l1IJoRwwcLYwLinE3pFm/2eHEEtu
        zDvLqADrm2h4e1FuBifXsWUi77bXoI593W3ZLmI=
X-Google-Smtp-Source: AMsMyM56nUz8sGkCeqBVJoK6oDcAc8hZNHP1QjobCqaJwAuRDswWz3ulV0+QMeIS7x6P23jddz9EQQp/xYKEHom6WFA=
X-Received: by 2002:aa7:d4d9:0:b0:45c:7eae:d8d8 with SMTP id
 t25-20020aa7d4d9000000b0045c7eaed8d8mr17594307edr.254.1666361321203; Fri, 21
 Oct 2022 07:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221020072317.492906-1-chenhuacai@loongson.cn>
 <20221020072317.492906-5-chenhuacai@loongson.cn> <1ca11693-17c2-7260-b642-70b033c64b30@linaro.org>
In-Reply-To: <1ca11693-17c2-7260-b642-70b033c64b30@linaro.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 21 Oct 2022 22:08:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ZtbPZE3edWmQJEmhBsg0QSfKjnCDrfSj2E4sZ12m5zg@mail.gmail.com>
Message-ID: <CAAhV-H4ZtbPZE3edWmQJEmhBsg0QSfKjnCDrfSj2E4sZ12m5zg@mail.gmail.com>
Subject: Re: [PATCH V12 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Philippe,

On Fri, Oct 21, 2022 at 6:16 PM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 20/10/22 09:23, Huacai Chen wrote:
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > The feature of minimizing overhead of struct page associated with each
> > HugeTLB page is implemented on x86_64. However, the infrastructure of
> > this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
> > OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.
> >
> > To avoid the following build error on LoongArch we should include linux=
/
>
> s/should/have to/
Thanks, I will change it.

>
> > static_key.h in page-flags.h.
>
> This looks like 2 different changes in a single patch.. The first is a
> generic "fix missing include" and the second is LoongArch specific.
The static_key.h inclusion is also LoongArch-specific, implicitly. X86
and ARM64 have no build errors without this inclusion, because they
include static_key.h from their arch-specific core headers. Once
before I have sent a separate patch to "fix missing include", but Greg
said that "don't fix unless you have a real problem". :)

Huacai

>
> Splitting in 2 would ease backport cherry-picks.
>
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
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/Kconfig     | 1 +
> >   include/linux/page-flags.h | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 6f7fa0c0ca08..0a6ef613124c 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -52,6 +52,7 @@ config LOONGARCH
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select ARCH_USE_QUEUED_SPINLOCKS
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > +     select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >       select ARCH_WANT_LD_ORPHAN_WARN
> >       select ARCH_WANTS_NO_INSTR
> >       select BUILDTIME_TABLE_SORT
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 0b0ae5084e60..1aafdc73e399 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -9,6 +9,7 @@
> >   #include <linux/types.h>
> >   #include <linux/bug.h>
> >   #include <linux/mmdebug.h>
> > +#include <linux/static_key.h>
> >   #ifndef __GENERATING_BOUNDS_H
> >   #include <linux/mm_types.h>
> >   #include <generated/bounds.h>
>
> Preferably splitting in 2 distinct patches (for each):
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
