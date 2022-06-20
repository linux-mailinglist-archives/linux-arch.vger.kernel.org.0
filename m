Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307715515B8
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiFTKZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiFTKZQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 06:25:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E313E8B
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 03:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC510CE116E
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 10:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0AAC341C4
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655720712;
        bh=N19vMaifx2Cx25OIpEGDNkuy/pFDFa7xiOg2ncfsnuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QA9u39/LmLLdrfK7xTlg5R7Jdp/SdqqOqfjiEErOhOk8d6XH7OVB9Hhu97ozOJgVv
         gvcIqc6AZP7wFaJM1aFfIfnja1W+ZyitABLJM+/mnTSarwZeqO8nl0SC9rsSv/ZzT6
         yKuINWP0nyHTzVz0Et6suKyAFmlqwbazxrRLnGmj5WWahaB3WmC+l10XkEKClhybGv
         ed2onwn7HYFkwsreAkFz025YXuWX+SUXbTo3q1weC4Daa/+9zxC3Qj0GE7iWrbTntI
         g2PNjqIBaEDj5eppfOfapDBECebjLkjwWeIxoU7Ea6G23Ebm+BLrcUG6Xacds5WJet
         uBBwE1BEP6fdQ==
Received: by mail-lj1-f172.google.com with SMTP id o23so4242640ljg.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 03:25:11 -0700 (PDT)
X-Gm-Message-State: AJIora98bX0oT9VNKYxI/bMgb5FvWBpbcKM6LcicxL0MIU1HKXNR6PQm
        kpgw74dc0cxH8bK8Dcanf/siign1pwPBy8q09vI=
X-Google-Smtp-Source: AGRyM1sXsuRv6jWKN7rLyi3u2sdEL6N9Z8dSCWko9wHPJ5B4Vut6/qbcY3PvEaHtIEqGwmVbYEiVgfPn4C94j2F9EKQ=
X-Received: by 2002:a2e:95c8:0:b0:255:abb5:d0e7 with SMTP id
 y8-20020a2e95c8000000b00255abb5d0e7mr11071552ljh.23.1655720710073; Mon, 20
 Jun 2022 03:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145859.582176-1-chenhuacai@loongson.cn> <CAK8P3a1L40=P8GnuyK--K7URyrdAb4XcPJ-+HxwY4_+siA25oQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1L40=P8GnuyK--K7URyrdAb4XcPJ-+HxwY4_+siA25oQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 20 Jun 2022 18:24:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AO3friSYrpAN_VM6aLO7yfV2svKg=7w_3F3HpV7Dq4Q@mail.gmail.com>
Message-ID: <CAAhV-H4AO3friSYrpAN_VM6aLO7yfV2svKg=7w_3F3HpV7Dq4Q@mail.gmail.com>
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

On Fri, Jun 17, 2022 at 11:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jun 17, 2022 at 4:58 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Add sparse memory vmemmap support for LoongArch. SPARSEMEM_VMEMMAP
> > uses a virtually mapped memmap to optimise pfn_to_page and page_to_pfn
> > operations. This is the most efficient option when sufficient kernel
> > resources are available.
>
> I have not looked at this in detail, but from a high-level perspective, it
> seems very similar to the corresponding code in arch/arm64 and arch/x86.
>
> Can you try to merge the three copies into a generic helper and add that
> to mm/sparse-vmemmap.c? If this does not work, can you describe in the
> changelog text why these have to be architecture specific?
It is difficult to merge, because LoongArch needs to call pud_init(),
pmd_init() and other similar things which are unnecessary on ARM64 and
X86.

Huacai

>
>        Arnd
