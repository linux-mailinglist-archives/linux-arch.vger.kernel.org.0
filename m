Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77695551767
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiFTL07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 07:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiFTL07 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 07:26:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C115FE3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 04:26:58 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnaTt-1nMno51CUv-00jd0u for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022
 13:26:56 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3176d94c236so97013447b3.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 04:26:56 -0700 (PDT)
X-Gm-Message-State: AJIora+jqwnE7uYWEkOS59AfyOkk7q3CN6NTEwz6UbDiJVob1MVKBAFy
        kjFidB0sOz5eOx+TUSwek/UiYzIzrbsCd8r+XsU=
X-Google-Smtp-Source: AGRyM1u96dMc7NQSr64fMvJHkkfPwQF10BArwoGPZrI0++jMEyDVdKrxQlsin6cZpuKPKbHfsaERKjvgbnrA7J4ywnc=
X-Received: by 2002:a0d:ca0f:0:b0:317:a2cc:aa2 with SMTP id
 m15-20020a0dca0f000000b00317a2cc0aa2mr11456604ywd.347.1655724415136; Mon, 20
 Jun 2022 04:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145859.582176-1-chenhuacai@loongson.cn>
 <CAK8P3a1L40=P8GnuyK--K7URyrdAb4XcPJ-+HxwY4_+siA25oQ@mail.gmail.com> <CAAhV-H4AO3friSYrpAN_VM6aLO7yfV2svKg=7w_3F3HpV7Dq4Q@mail.gmail.com>
In-Reply-To: <CAAhV-H4AO3friSYrpAN_VM6aLO7yfV2svKg=7w_3F3HpV7Dq4Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jun 2022 13:26:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Wu7vCzxgjAWugiaBonARqU88NYuQj4JyqATmTDrPEaw@mail.gmail.com>
Message-ID: <CAK8P3a3Wu7vCzxgjAWugiaBonARqU88NYuQj4JyqATmTDrPEaw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add sparse memory vmemmap support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Min Zhou <zhoumin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:d0u+gkYa25FUzDLEU1ui8qxTK6XAiUhKmvcdRoZWlj/I9OAuAAS
 nsLFTiJwOui7AtwbuiILlFh2LHx9wzfWQlgWfIUzqYyMg/nbWpqhzG3mTvdXNJRsKxPIe5x
 yInClzBAqvbuOj8Q0NhsCiXEtQ2iVM+XUShal3glAW27McKM8+bl5cBzx83JfxH5mOIgJ85
 wd0KrBgKhy+M5iSHTYZSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9SCn2YBi2qc=:f/j8EBnMnacwN1px1GEofH
 zu9UWlobkOH6e+8qEmpymUUBKwX93XhR1sYrPGBQNqsrEQ4O4oqlPxdfn7BAuIxLPB3UBih0T
 0ScbO85y1yd1n/DUXDmUvBgqOjEnSPMurF9FsNQvpMpy0LapycbLPkPi1HXUjVR92cjgUJoTc
 G0e0DkbaZXmMrAD96So0DfKmN7zQ4GSXsUpu4ROYoZbKImqObZdy0XY6Wgk5naydqg58vNb7e
 YXE8FXFerFbL4ddhKlor3JweHg/p97A2FrsbkSLKRAq/0Vxj3KZsLEm/HYyej4G6Jz1Gy8ntK
 9CiZkGLUX9wVSz6Bg0j/kDyfb17YwlbUwsYPsyIAMTLWcFSCg3QoyDzyNK2PnPMk/4/DIZ8l5
 QitHV/7COfZnexRJ4r3FMxTVDhpUoDnjpjmHIfGsArWSNHT45eP5Gihwm+w71yyo/BACmWtT9
 HjYF3lLVmzBSjGykKCBgXnHSvEkwkYWiRnONxgNoGPffmf2Mhwmw9OVzkntNLg4Bb/zIf4wwQ
 XQ+ARI/PnVfn7qwN6wG6ZdIUwj7jd29bKJ3X/3MrkXmrzMrWRvdMjYIm7HriwV40JFz8pmmZ5
 9kzWEuULovKsOohErvN+RISfiPW5gF3QXmBylU/ro1D7H3ZS1iSg/rvi2zyo+XSHkVJyZJk0G
 82pFJHz45rqVyp8M/MJEetlSFqL6KhuMn8a6m7dO+M0xhhZsHOTIz7vFmioFa4AzXDhssEoXX
 fXkZM+g/CuMXgT0ApccWMzqlJwKZy/1fqLEU9A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 20, 2022 at 12:24 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Fri, Jun 17, 2022 at 11:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Jun 17, 2022 at 4:58 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
> > > uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
> > > operations. This is the most efficient option when sufficient kernel
> > > resources are available.
> >
> > I have not looked at this in detail, but from a high-level perspective, it
> > seems very similar to the corresponding code in arch/arm64 and arch/x86.
> >
> > Can you try to merge the three copies into a generic helper and add that
> > to mm/sparse-vmemmap.c? If this does not work, can you describe in the
> > changelog text why these have to be architecture specific?
>
> It is difficult to merge, because LoongArch needs to call pud_init(),
> pmd_init() and other similar things which are unnecessary on ARM64 and
> X86.

 I can see that this part of the code is the same as mips. What is the
initialization
 for? Can it be encapsulated in an architecture specific inline
function (for mips
and loongarch), with a generic version like this?

#ifndef pud_init_invalid
static inline void pud_init_invalid(void *) {}
#endif

       Arnd
