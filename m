Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44C59CF3A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiHWDME (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 23:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiHWDLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 23:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF01C27E;
        Mon, 22 Aug 2022 20:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D692612B5;
        Tue, 23 Aug 2022 03:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F082AC43470;
        Tue, 23 Aug 2022 03:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661224290;
        bh=xWRgLQXm9q7CKzbsKFuDGBF+mqKoBiOjGcP+au+AxI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cqC+FgFfzi+hlqGtjVWRTRufP32Fi+D+TNJ64Yuk++Mzi2UJYdwINrEV5pxDwTVq9
         nHFEmRrK1dyftnuEK+pItaQHzzRrMzaFrzkXWqXlwq5k8gMytNUdvqEPN6Xzb2+0si
         tR8CiycLDRBQRahG8lFuRIoTWG1rHLoZZmpqCNrGWVxBmP91Y9On7JaC8wZqhfx9eN
         HDS/j1Jq/qxsa80xPepvCV7MnzUSBa77nVkSV7bWbZF5HlgGWbI1Tn05FaN1eZTtNr
         oG2UEEeXzBlEitJZ2EwZZmbpupisU5nOn3k+5J1S5HWyyS10WyJJGG7gXdFa+9X8EJ
         4tfEagMm1l4gw==
Received: by mail-vs1-f50.google.com with SMTP id n125so13197437vsc.5;
        Mon, 22 Aug 2022 20:11:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo1a3Lkge+iGyrZB3qRAtWywcPtewerH9G+np6xwDpd/dLFdf8ib
        Y+OFjgU5i59iAXOEWJQ6AuOzwSEbDwExMpGdGZU=
X-Google-Smtp-Source: AA6agR4155w4bgLqb/uPgLg8dgF39lNgqCTEW1XZRmRdgV/1qP2RJl192Aakwc9W3x4wFnfX4fSVfYuzwn4+7GiXoKo=
X-Received: by 2002:a05:6102:3a70:b0:390:81fc:3f39 with SMTP id
 bf16-20020a0561023a7000b0039081fc3f39mr214676vsb.84.1661224288952; Mon, 22
 Aug 2022 20:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <CAMj1kXGrWqaTeiSeK1vG=escABZg16cpekzzTTp5WaTwi3iUYg@mail.gmail.com> <CAMj1kXHec4pfkM6gGwpDPCRn-WbTQcpLam+MWpBph-1KAo1H4A@mail.gmail.com>
In-Reply-To: <CAMj1kXHec4pfkM6gGwpDPCRn-WbTQcpLam+MWpBph-1KAo1H4A@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 Aug 2022 11:11:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Wsjf9GAQVkBeu+PKbGOJ5nAxGY=E3zryu_8OK4qtnGA@mail.gmail.com>
Message-ID: <CAAhV-H7Wsjf9GAQVkBeu+PKbGOJ5nAxGY=E3zryu_8OK4qtnGA@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard,

On Tue, Aug 23, 2022 at 2:03 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 22 Aug 2022 at 12:44, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 19 Aug 2022 at 12:20, Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > This patch adds efistub booting support, which is the standard UEFI boot
> > > protocol for us to use.
> > >
> > > We use generic efistub, which means we can pass boot information (i.e.,
> > > system table, memory map, kernel command line, initrd) via a light FDT
> > > and drop a lot of non-standard code.
> > >
> > > We use a flat mapping to map the efi runtime in the kernel's address
> > > space. In efi, VA = PA; in kernel, VA = PA + PAGE_OFFSET. As a result,
> > > flat mapping is not identity mapping, SetVirtualAddressMap() is still
> > > needed for the efi runtime.
> > >
> > > Tested-by: Xi Ruoyao <xry111@xry111.site>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > V1 --> V2:
> > > 1, Call SetVirtualAddressMap() in stub;
> > > 2, Use core kernel data directly in alloc_screen_info();
> > > 3, Remove the magic number in MS-DOS header;
> > > 4, Disable EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER;
> > > 5, Some other small changes suggested by Ard Biesheuvel.
> > >
> > > V2 --> V3:
> > > 1, Adjust Makefile to adapt zboot;
> > > 2, Introduce EFI_RT_VIRTUAL_OFFSET instead of changing flat_va_mapping.
> > >
> >
> > Thanks for the update.
> >
> > I am going to queue this up in the efi/next tree. However, due to the
> > many changes to arch/loongarch in this patch, conflicts are not
> > unlikely, so I created a signed stable tag for the patch that you can
> > merge into the loongarch arch tree if you want.
> >
> > *However*, you must *not* rebase your tree after merging this tag.
> > Therefore, it is probably best that the merge of this tag appears as
> > the very first change on your PR to Linus for v6.1. Everything after
> > can be rebased at will (assuming there are no other impediments to
> > doing so)
> >
> > You can fetch it and merge it like so:
> >
> > git fetch -t git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> > git verify-tag efi-loongarch-for-v6.1 # if you like
> > git merge efi-loongarch-for-v6.1
> >
> > and all your other v6.1 changes can go on top.
> >
> > This way, you can resolve conflicts locally without affecting the EFI
> > changes going via the other tree. The EFI stub for LoongArch change
> > will arrive into Linus's tree via whichever tree he pulls first: the
> > LoongArch one or the EFI one.
> >
> > I will rebase my zboot decompressor changes on top of this - I will cc
> > you again, as the LoongArch builds ok but still does not boot.
> >
>
> I have pushed a branch here that includes EFI decompressor support for LoongArch
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
>
> You will need to enable CONFIG_EFI_ZBOOT and build the zImage.efi
> target. The resulting image should be bootable jus tlike the
> vmlinux.efi but for some reason, it produces the crash I reported
> earlier.
>
> Please give it a try, and if you manage to figure out what's wrong
> with my code, please let me know :-)
I will try zboot on my real machine. For the code, I prefer
vmlinuz.efi rather than zImage.efi for LoongArch since it keeps the
naming consistency.

Huacai
>
> Thanks,
> Ard.
