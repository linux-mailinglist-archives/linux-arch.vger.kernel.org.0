Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3933259BDBB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiHVKob (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 06:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiHVKoa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 06:44:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87F2B24F;
        Mon, 22 Aug 2022 03:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C9FB81032;
        Mon, 22 Aug 2022 10:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84508C43140;
        Mon, 22 Aug 2022 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165066;
        bh=4YMvU65qQ04IqowCEYwWIpKFExLC5MhJHQddN3xHoAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j9x05gbKjQGZwc9HIR8I6+4rCHw6QZjD13AXAE14TUDj9/3wNRRZQsk5D/WFWX93d
         xxK4I6f35LPIo2MIYhnxX7HcUznCJwfWbm5tOu7hER5qGXRGpES7Qdgn8Qr20qn3hE
         hyplEFM2Mrlk10qnr9jujsskZTPDUTHPIBvyCSOm3oIwkWPGc/mU6nKinbheVsVJwZ
         7pP4kzrtNx3ObiIs9tcLsDlW00ILojgOPutyWxEZP61GhPB2VGfJE6BFUdOAMHZ8IM
         ILsV+8MyxElWQICm9lUakq9UBUjO7OC2iRc0E22Zdb8bqTqdv8dGBgZkuhekQNAv9E
         iVE58sR4PusRw==
Received: by mail-wr1-f42.google.com with SMTP id a4so12685563wrq.1;
        Mon, 22 Aug 2022 03:44:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo2gtOf3Ykh7XM8eL36656CRoRsq3iENn9Hi7M6uJRjEdMhOD1UX
        hCjMf1j1HnLdvakhM/zv/OeE8s7llL+6ykT5BB0=
X-Google-Smtp-Source: AA6agR7v7Mp58YHOkO732SK4/Pq7RrQpteuOLrPjH9cUZiBZhtGMxZHqliDfwKD5dM4EKTcpS7qhMvvT5kym/ds7XMY=
X-Received: by 2002:adf:ebd2:0:b0:222:cd3f:cf9 with SMTP id
 v18-20020adfebd2000000b00222cd3f0cf9mr10524954wrn.598.1661165064692; Mon, 22
 Aug 2022 03:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
In-Reply-To: <20220819102037.2697798-1-chenhuacai@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 Aug 2022 12:44:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrWqaTeiSeK1vG=escABZg16cpekzzTTp5WaTwi3iUYg@mail.gmail.com>
Message-ID: <CAMj1kXGrWqaTeiSeK1vG=escABZg16cpekzzTTp5WaTwi3iUYg@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, 19 Aug 2022 at 12:20, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds efistub booting support, which is the standard UEFI boot
> protocol for us to use.
>
> We use generic efistub, which means we can pass boot information (i.e.,
> system table, memory map, kernel command line, initrd) via a light FDT
> and drop a lot of non-standard code.
>
> We use a flat mapping to map the efi runtime in the kernel's address
> space. In efi, VA = PA; in kernel, VA = PA + PAGE_OFFSET. As a result,
> flat mapping is not identity mapping, SetVirtualAddressMap() is still
> needed for the efi runtime.
>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V1 --> V2:
> 1, Call SetVirtualAddressMap() in stub;
> 2, Use core kernel data directly in alloc_screen_info();
> 3, Remove the magic number in MS-DOS header;
> 4, Disable EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER;
> 5, Some other small changes suggested by Ard Biesheuvel.
>
> V2 --> V3:
> 1, Adjust Makefile to adapt zboot;
> 2, Introduce EFI_RT_VIRTUAL_OFFSET instead of changing flat_va_mapping.
>

Thanks for the update.

I am going to queue this up in the efi/next tree. However, due to the
many changes to arch/loongarch in this patch, conflicts are not
unlikely, so I created a signed stable tag for the patch that you can
merge into the loongarch arch tree if you want.

*However*, you must *not* rebase your tree after merging this tag.
Therefore, it is probably best that the merge of this tag appears as
the very first change on your PR to Linus for v6.1. Everything after
can be rebased at will (assuming there are no other impediments to
doing so)

You can fetch it and merge it like so:

git fetch -t git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
git verify-tag efi-loongarch-for-v6.1 # if you like
git merge efi-loongarch-for-v6.1

and all your other v6.1 changes can go on top.

This way, you can resolve conflicts locally without affecting the EFI
changes going via the other tree. The EFI stub for LoongArch change
will arrive into Linus's tree via whichever tree he pulls first: the
LoongArch one or the EFI one.

I will rebase my zboot decompressor changes on top of this - I will cc
you again, as the LoongArch builds ok but still does not boot.

Thanks,
Ard.
