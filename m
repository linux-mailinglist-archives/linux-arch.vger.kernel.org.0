Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1B552B05
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbiFUGgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbiFUGgA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 02:36:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67D15FFF
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 23:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06017B8169A
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 06:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5ABC341CA
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 06:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655793355;
        bh=JMKqhOBxXrawPUykfqx8Oj6WlbWJ2UBiXKkbqFUY/2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YNZ1BvzH/JV3KRB/pcCYfdia99mSD8myaVMIPanEMRhUV+uCAA3jD6BAw1J0x6sRE
         QUADNPx1WTiCErefSzEhpZtMw4iEawWbQXV8deeBrHqtJvLkUumD1S1sNb6Ikb5b3L
         O/QEimttGnmv/SS4XetUp8zCr41zfyrY3XqFSyh1wPUg+cOnd/EaG+609hKm0uD5D+
         MK7EHQ2FDTEV4mYbvoGfbgk+ljN+sZ4G3kUdjKny0HZ4ABkVB+N53Fe3RR1H0VCXkZ
         WfZep/HnUrP/AsPfv+cgCwlbTjAs7juqH3QBiYSYXy9GZDdn+Ape+zXWG3kxK85Edu
         re262lm7BG22g==
Received: by mail-lj1-f181.google.com with SMTP id a11so5470026ljb.5
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 23:35:55 -0700 (PDT)
X-Gm-Message-State: AJIora9u5vwfiwXdTT3tRZk9Hu2Alg386bQp6E8f1Ncu2WRi3CAekZzg
        zWhAcx1bndmaednI4qW8HWEvyCIq1VlZndf2XnU=
X-Google-Smtp-Source: AGRyM1u8F7ekZm6P3bDtbQ3fBC4j9z9rBNp8ZDBt+lKEqlDTGIM4Z9uLIBnSKBHWFZROilPTeGS0oi70rueSET/SqB4=
X-Received: by 2002:a05:651c:506:b0:257:c12:b941 with SMTP id
 o6-20020a05651c050600b002570c12b941mr13701498ljp.429.1655793353606; Mon, 20
 Jun 2022 23:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145859.582176-1-chenhuacai@loongson.cn>
 <CAK8P3a1L40=P8GnuyK--K7URyrdAb4XcPJ-+HxwY4_+siA25oQ@mail.gmail.com>
 <CAAhV-H4AO3friSYrpAN_VM6aLO7yfV2svKg=7w_3F3HpV7Dq4Q@mail.gmail.com> <CAK8P3a3Wu7vCzxgjAWugiaBonARqU88NYuQj4JyqATmTDrPEaw@mail.gmail.com>
In-Reply-To: <CAK8P3a3Wu7vCzxgjAWugiaBonARqU88NYuQj4JyqATmTDrPEaw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 21 Jun 2022 14:35:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4YiixeMW=3Bi-nqhchp2cvQWWKkfADBrFCkVxpfqxocg@mail.gmail.com>
Message-ID: <CAAhV-H4YiixeMW=3Bi-nqhchp2cvQWWKkfADBrFCkVxpfqxocg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add sparse memory vmemmap support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Min Zhou <zhoumin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Jun 20, 2022 at 7:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jun 20, 2022 at 12:24 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Fri, Jun 17, 2022 at 11:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Fri, Jun 17, 2022 at 4:58 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
> > > > uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
> > > > operations. This is the most efficient option when sufficient kernel
> > > > resources are available.
> > >
> > > I have not looked at this in detail, but from a high-level perspective, it
> > > seems very similar to the corresponding code in arch/arm64 and arch/x86.
> > >
> > > Can you try to merge the three copies into a generic helper and add that
> > > to mm/sparse-vmemmap.c? If this does not work, can you describe in the
> > > changelog text why these have to be architecture specific?
> >
> > It is difficult to merge, because LoongArch needs to call pud_init(),
> > pmd_init() and other similar things which are unnecessary on ARM64 and
> > X86.
>
>  I can see that this part of the code is the same as mips. What is the
> initialization
>  for? Can it be encapsulated in an architecture specific inline
> function (for mips
> and loongarch), with a generic version like this?
>
> #ifndef pud_init_invalid
> static inline void pud_init_invalid(void *) {}
> #endif
OK, let's have a try.

Huacai
>
>        Arnd
