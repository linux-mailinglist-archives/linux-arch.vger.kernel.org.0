Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E955748D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 09:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiFWHxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFWHxw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 03:53:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECE46C96
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 00:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C8161B6F
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 07:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161E7C385A5
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655970830;
        bh=apjnh+0pCbHi6gRi/NAEisw4oJ6epO+CwITV7bYs9ww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDocxEpUrBlQpqjaBBjGVlahulSDf5p0JMI4odX1fM4Aj+lenGfSsln9aVyUYn9kZ
         hSz3dkAnrADAYoPGU8SAHh3odT860C32Gj1LvYr3rGTEaE+Gdq4bzkhPPvf0xkSot8
         WAhPxdR17lFcMzkeAPDhjOM64Hn+T6gwpnUnfjJhdzwZ6GjxiZ/7EhQzPDDv8cdbHS
         8XkvDF4VgO3+SFWxAN4UzFfE8XqjAweSgbgu+HiMRDobdjrsq0QimIZW+buqaMSkRe
         ZU8lEsOXSCSFvJKn0qBi5DFya+CezRbG/zEMxIKYTXfWu0VjvDQAqzKn6qpMDbkAJ1
         omegdpOTwULFA==
Received: by mail-lj1-f174.google.com with SMTP id g12so16214386ljk.11
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 00:53:49 -0700 (PDT)
X-Gm-Message-State: AJIora9HTlyKlekxTTEI8Wya6vV5BN1BBJk2dFn2Yow7Kq0nLHbooHC7
        tBbY7h78/EqiOpwlCcaNvCi09jGKXBesumwJYpE=
X-Google-Smtp-Source: AGRyM1tNDOfDkXykQwx4grGFQQk5//AcyMfrth8IkEVWsRYFn9FfHBXSp8if0GcxoT1aoji1SXgEQ9KiWZyLqS/x8V8=
X-Received: by 2002:a2e:95c8:0:b0:255:abb5:d0e7 with SMTP id
 y8-20020a2e95c8000000b00255abb5d0e7mr3919800ljh.23.1655970828124; Thu, 23 Jun
 2022 00:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220623025200.1824399-1-chenhuacai@loongson.cn> <CAK8P3a0hf8sSXqu14WkYO0yy7hSOn3y6FaE3vqDW7J1JPVcZWA@mail.gmail.com>
In-Reply-To: <CAK8P3a0hf8sSXqu14WkYO0yy7hSOn3y6FaE3vqDW7J1JPVcZWA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Jun 2022 15:53:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4CUiw3hpQ=WwZCuCRNEEBpwVJYSKUgA-WHmDgjh=XsYA@mail.gmail.com>
Message-ID: <CAAhV-H4CUiw3hpQ=WwZCuCRNEEBpwVJYSKUgA-WHmDgjh=XsYA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix the !THP build
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, Jun 23, 2022 at 3:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 23, 2022 at 4:52 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Fix the !THP build by making pmd_pfn() available in all configurations.
> > Because pmd_pfn() is used in mm/page_vma_mapped.c whether or not THP is
> > configured.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Both bugfix patches look good to me. I assume you'll just send a pull request
> to Linus from your kernel.org account, rather than going through the asm-generic
> tree for follow-up patches. Let me know if you need me to put it into my tree
> instead.
OK, I'll send PR to Linus by myself. Thanks.

Huacai
>
>          Arnd
