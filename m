Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D345AD918
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiIESgL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIESgK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 14:36:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A3240AD;
        Mon,  5 Sep 2022 11:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85749B8111C;
        Mon,  5 Sep 2022 18:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320D6C43142;
        Mon,  5 Sep 2022 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662402966;
        bh=EY3i109L8D7ZY/wVALZpXRFBXYpKOUy71zv3lzVqbK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NLnRWEb9qQtm2mVjNKQfRv5VzUr5TFKOHX9RTPWJiGObCuw9wAa6fsVJlcabTo8wb
         9Q+Qh/DqFzO5pkQ4vWAbclVgSofnqNOdo9Y6txMBoOOygv5uyojpQamGaPQuGXQw2R
         OT1VfYLnJoznDTSSqUcMV+MftXpoBM9k8/L+zLBjhBFat/P4D6C0UmG4u3Zcv9U90v
         5h8CmmH/o+55hUgyQqqxkTn1QsS41KwHHHJsKBA/X+Nrjfw3jLzJd53Sw2KZGvZj7I
         L0gGNsk8tOD1EdOalsDRmCi04zWFJyO/eOlBIP5LZoBTU43XUXs1uhy4d8amwPXhEq
         EySCgO57LGgLw==
Received: by mail-lj1-f171.google.com with SMTP id s15so10018859ljp.5;
        Mon, 05 Sep 2022 11:36:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo09tJ0yxsUFrWkTXtarXhb0v4k4UEcAIIgNEZ/VpVln94QZIvmQ
        DcwnPACTnL+AWlRD2Gq/8mw47pFDdCmFF4SK8zE=
X-Google-Smtp-Source: AA6agR6JxcKoDuVFPNtgr/wfIa7oHgH82k7YWuM+Aru7jvH0zsXih1cW6Q17t7JjVD8eW5SRJs+Pd7VCEnKh70IhOJI=
X-Received: by 2002:a05:651c:11c6:b0:265:d1cb:b7b4 with SMTP id
 z6-20020a05651c11c600b00265d1cbb7b4mr9493519ljo.69.1662402964104; Mon, 05 Sep
 2022 11:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
 <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
 <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
 <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
 <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com>
 <CAMj1kXFRsEJOS2Kim8T64rYF85_bmmZ5gW7kjb8eDXry5SA+cg@mail.gmail.com>
 <CAAhV-H4xDB6JPCEZqQ6+VadOPnzA3beguiuTRS-Ub=Ci5FgpPw@mail.gmail.com>
 <CAMj1kXEPpCPHe8ghOKcaGvuLjetP9WJbrMkLcqv_V+oRWeyLmw@mail.gmail.com> <3591e532-a6ed-01f1-88fc-77b8637abced@xen0n.name>
In-Reply-To: <3591e532-a6ed-01f1-88fc-77b8637abced@xen0n.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 20:35:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHu__5cVPm5n6zF5-nNus+O95ZQWiAuM787zyY_yUqmYg@mail.gmail.com>
Message-ID: <CAMj1kXHu__5cVPm5n6zF5-nNus+O95ZQWiAuM787zyY_yUqmYg@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, 5 Sept 2022 at 20:08, WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 9/5/22 15:28, Ard Biesheuvel wrote:
> > [snip]
> >>>>>> And I have some other questions about kexec: kexec should jump to the
> >>>>>> elf entry or the pe entry? I think is the elf entry, because if we
> >>>>>> jump to the pe entry, then SVAM will be executed twice (but it should
> >>>>>> be executed only once). However, how can we jump to the elf entry if
> >>>>>> we use zboot? Maybe it is kexec-tool's responsibility to decompress
> >>>>>> the zboot kernel image?
> >>>>>>
> >>>>> Yes, very good point. Kexec kernels cannot boot via the EFI entry
> >>>>> point, as the boot services will already be shutdown. So the kexec
> >>>>> kernel needs to boot via the same entrypoint in the core kernel that
> >>>>> the EFI stub calls when it hands over.
> >>>>>
> >>>>> For the EFI zboot image in particular, we will need to teach kexec how
> >>>>> to decompress them. The zboot image has a header that
> >>>>> a) describes it as a EFI linux zimg
> >>>>> b) describes the start and end offset of the compressed payload
> >>>>> c) describes which compression algorithm was used.
> >>>>>
> >>>>> This means that any non-EFI loader (including kexec) should be able to
> >>>>> extract the inner PE/COFF image and decompress it. For arm64 and
> >>>>> RISC-V, this is sufficient as the EFI and raw images are the same. For
> >>>>> LoongArch, I suppose it means we need a way to enter the core kernel
> >>>>> directly via the entrypoint that the EFI stub uses when handing over
> >>>>> (and pass the original DT argument so the kexec kernel has access to
> >>>>> the EFI and ACPI firmware tables)
> >>>> OK, then is this implementation [1] acceptable? I remember that you
> >>>> said the MS-DOS header shouldn't contain other information, so I guess
> >>>> this is unacceptable?
> >>>>
> >>> No, this looks reasonable to me. I objected to using magic numbers in
> >>> the 'pure PE' view of the image, as it does not make sense for a pure
> >>> PE loader such as GRUB to rely on such metadata.
> >>>
> >>> In this case (like on arm64), we are dealing with something else: we
> >>> need to identify the image to the kernel itself, and here, using the
> >>> unused space in the MS-DOS header is fine.
> >>>
> >>>> [1] https://lore.kernel.org/loongarch/c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn/T/#mb8c1dc44f7fa2d3ef638877f0cd3f958f0be96ad
> >> OK, then there is no big problem here. And I found that arm64/riscv
> >> don't need the kernel entry point in the header. I don't know why, but
> >> I think it implies that a unified layout across architectures is
> >> unnecessary, and I prefer to put the kernel entry point before
> >> effective kernel size. :)
> >>
> > It is fine to put the entry point offset in the header. arm64 and
> > RISC-V don't need this because the first instructions are a pseudo-NOP
> > (an instruction that does nothing but its binary encoding looks like
> > 'MZ..') and a jump to the actual entry point.
>
> FYI the same trick also works for LoongArch: the code "MZ\x00\x00" i.e.
> 00005a4d is in fact "ext.w.h $t1, $t6", which is going to simply trash
> one temporary register without any other effect, so a similar jump to
> the actual entrypoint could follow.
>
> This instruction is available for both LA32 and LA64. The only subset
> without it is the LA32 Primary, which is meant for university courses
> and probably would never run UEFI, so the instruction is safe to use.
>
> P.S. If we'd go the extra mile just for ensuring the instruction works
> on every possible LoongArch core, due to the prefix construction of
> LoongArch encoding, we could just change the bytes toward the MSB (so we
> keep the "MZ" with ease) and still only trash $t1. For example
> "MZ\x10\x00" or 00105a4d is "add.w $t1, $t6, $fp", which is similarly
> harmless, but this time it works on even coursework cores!
>

I don't think this is necessary. On arm64, the boot protocol was
already defined when the EFI stub requirements became apparent, and
RISC-V just copied arm64 for some reason.

There is no reason for the 'bare metal' image to be executable from
offset 0x0: in fact, it is better to restrict executable permissions
to code regions, and treat the header as a data region, which is what
it is fundamentally.

In fact, if there is a need to duplicate this information (given that
the PE/COFF header also carries the same information), I would
recommend describing the code (R-X) and data (RW-) regions, as well as
the entry point, and potentially permit the image to be booted with
memory protections enabled.
