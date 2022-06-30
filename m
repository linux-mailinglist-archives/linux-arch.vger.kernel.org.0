Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEB561234
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiF3GF2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 02:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3GF1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 02:05:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F3E9C;
        Wed, 29 Jun 2022 23:05:25 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDykM-1nwr8Z15L2-009u4R; Thu, 30 Jun 2022 08:05:23 +0200
Received: by mail-yb1-f180.google.com with SMTP id v38so21245765ybi.3;
        Wed, 29 Jun 2022 23:05:22 -0700 (PDT)
X-Gm-Message-State: AJIora9mLhIkWMU2pw0+qpEOolnlhrptNeZMdvQLOvLxTO90T/tXSL5O
        zFetecC19nQkamKR5oVGPtfJuS7QEDEtWLhuApw=
X-Google-Smtp-Source: AGRyM1vtT3pzk3IDIUdnI7V5TjBcb4k7QQp50McXs21ca3emcSDlR6eKLW5igXc4ObexSkfmEIzbtJFUPtpYReNpT5o=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr7959756ybu.134.1656569121704; Wed, 29
 Jun 2022 23:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220630043237.2059576-1-chenhuacai@loongson.cn> <20220630043237.2059576-4-chenhuacai@loongson.cn>
In-Reply-To: <20220630043237.2059576-4-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Jun 2022 08:05:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1f94z4oSnMr73PuiXkMR7uGhthzY_EWVniB+G4KXBcBQ@mail.gmail.com>
Message-ID: <CAK8P3a1f94z4oSnMr73PuiXkMR7uGhthzY_EWVniB+G4KXBcBQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages()
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:isWkHM0zBfXkwCpnGWGutHkS/c7PTfYL+kPwzmCZnPTaur1N43j
 trEAds4ISXh8H43i7dfbkWSQ4tq8gEWi9JKyY4iCJb/J4SD5dAW9u4Qx4iGNM7YwKyKMbuL
 edDZoYeSJyIN+4bVRBDeeiiE2nDFLNfA/uaQ4aVs590jrjV1km5pJEbwcYcCL8jzX0/xM/1
 mMSS5KFxjXx25Cx8ptu9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K/dru+AXhPE=:25UZ8NKGZcBrkp36/wp5Gn
 0GqcT8r3sqJsAykWyp2uHh4zhJ0NgQQFNNldEGODKTiGV1wnvD3CULKr10UmH1OwtBlJcEoNg
 pXTa1PyWq9+nTiK9JnSh/+zWV3UmpkaQtnoFuzV9UvbsPaZw12uotwhR+zGqbs4oMuaBpPqdd
 eSkWZiPn5yT12e+1++b7pwmHdPhMjHizyTefRfKfx+5BVva82sfqZp0ksS2jqU4wcXx5fiGb7
 MSMMiUQy6hDUdIySZZIG3NfBLXSZzvoJFxcwp+9picXPP0RdYVSeCqNfBbp9EC6cHSqGANztP
 oUypRoKgLbGZiEgpLGUu1k7l+bz2vU+RbR2kNkZ+V137r30NXpN1VDQmXdToQxUNXNN1DKImz
 EpOnGE8mqN0Yyk6xCTtofapJ+ytJyOGT2mCHeNTpzZV9sZvUkiq+377Bh3LUNLbHoUPi25rE2
 0A0Ul+KtW71sOhOtTQiZxjJa+nXe+dV9QXUI58YVVjE2yRIpHebVmxPk3lPStnFzoK1zU+KJx
 F840O+8k7kQqeL3p+B1W0n1RnLARAgN2VbSapitu43we4+FkpcQg9+7J2TobO2UTq3yBSDrcl
 R5bXusXaKOIRMkA8kkdUplPn/3SA4LalgAQLFQcWoNLN43FYrcfbfDc8YNFpp8IbdTzYxvObt
 QswESTXgyebxy22XJI9SJ7zQYSMgr36k15TrPEAL+dUqPP2RaZ6lU0Pu+fLNCg/GcVJj2szbD
 tJybH4N+QGrusm9GOU6xKSpwGYv8lMNsoDBvZV9r9DyCLYkgHVXZb9M0dycDkyfhLbmyY7YPI
 YEgfnDZFdyOJnvycE4OxQJ32FpQViCqt3oYEZ4DTjw5CKfmZozsekrwz31uSHYLDm3TCE2KQE
 jAma2Qnb4k9xIC6ZY+DQTFlC4nxLJMVyBclhq11Bc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 30, 2022 at 6:32 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> From: Feiyang Chen <chenfeiyang@loongson.cn>
>
> Generalise vmemmap_populate_hugepages() so ARM64 & X86 & LoongArch can
> share its implementation.

Sharing this function is good, thanks for consolidating this

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>

The Signed-off-by lines are in the wrong order, it should start with the author
and end with the final submitter.

> index 33e2a1ceee72..6f2e40bb695d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -686,6 +686,60 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>         return vmemmap_populate_range(start, end, node, altmap, NULL);
>  }
>
> +void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> +                                     unsigned long addr, unsigned long next)
> +{
> +}
> +
> +int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
> +                                      unsigned long next)
> +{
> +       return 0;
> +}
> +

I think inline functions would be better here, both for compiler optimization
and to make it easier to track the code flow. The normal way we do these
in architecture specific headers is to override the functions by defining a
macro of the same name.


        Arnd
