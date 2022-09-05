Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5B5AC93D
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 05:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiIEDvy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 23:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiIEDvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 23:51:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A158E2F66E;
        Sun,  4 Sep 2022 20:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48A8FB80EA7;
        Mon,  5 Sep 2022 03:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0766C43470;
        Mon,  5 Sep 2022 03:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662349856;
        bh=FFIFXKojIan6aTT8m9sEDD6GLCh66+aG+1K1XpN+gFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ImVmfgx0eoogiDhG1UlcauHa9Miyzn9oijzfritB+8j9K82LFh5svLKJQMYpjNv/M
         DBzxO0IGOIhDzrvR9MH4fWip4VXYk5xl5Kr3Vuhx5aZmXp4t5FJ+3i2nXRcDlDuP/+
         WKsrhBoLJp3slm06IXdMysAL+/Pyn/NrIXm1DvvUEjAIFADd2IxzN08GJM3KpjviSL
         LCUvVeCgJenrERUufSHRLzkPUom85AuI72Qf2TJeZAmUWcilHIBQ/QLdYgRnOOimRU
         /kWTcTf6oVcYdqLL+6eU5KtuKU/M/odLJtt2R166r6RKRzNXfKrJ/wJXHzLNUf+1yj
         dKtBEE6q6i3VA==
Received: by mail-vs1-f49.google.com with SMTP id 67so7686540vsv.2;
        Sun, 04 Sep 2022 20:50:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo3HMZXOCyrRRlMF9lXBjxNiThsCvoyJwT8O/2lwFUSl0vkGRZeg
        fbHPbld6vZBLXQT/AsFAfunMt6dexn4Q3lSuctM=
X-Google-Smtp-Source: AA6agR5XncrweG+t391bUB1ly+B9VrfB6NbqI9jaTSE1sk7hSrSx+OY2fOEyga32rp6hoqvWxLI6T5lWjcsnxTvbhdM=
X-Received: by 2002:a67:d49e:0:b0:390:dccf:23c8 with SMTP id
 g30-20020a67d49e000000b00390dccf23c8mr11802078vsj.59.1662349855744; Sun, 04
 Sep 2022 20:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
 <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
 <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com> <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
In-Reply-To: <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 5 Sep 2022 11:50:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com>
Message-ID: <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
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

Hi, Ard,

On Mon, Sep 5, 2022 at 5:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 4 Sept 2022 at 15:24, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > On Thu, Sep 1, 2022 at 6:40 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Ard,
> > >
> > > On Sat, Aug 27, 2022 at 3:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
> > > > >
> > > > > Tested V3 with the magic number check manually removed in my GRUB build.
> > > > > The system boots successfully.  I've not tested Arnd's zBoot patch yet.
> > > >
> > > > I am Ard not Arnd :-)
> > > >
> > > > Please use this branch when testing the EFI decompressor:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
> > > The root cause of LoongArch zboot boot failure has been found, it is a
> > > binutils bug, latest toolchain with the below patch can solve the
> > > problem.
> > >
> > > diff --git a/bfd/elfnn-loongarch.c b/bfd/elfnn-loongarch.c
> > > index 5b44901b9e0..fafdc7c7458 100644
> > > --- a/bfd/elfnn-loongarch.c
> > > +++ b/bfd/elfnn-loongarch.c
> > > @@ -2341,9 +2341,10 @@ loongarch_elf_relocate_section (bfd
> > > *output_bfd, struct bfd_link_info *info,
> > >      case R_LARCH_SOP_PUSH_PLT_PCREL:
> > >        unresolved_reloc = false;
> > >
> > > -      if (resolved_to_const)
> > > +      if (!is_undefweak && resolved_to_const)
> > >          {
> > >            relocation += rel->r_addend;
> > > +          relocation -= pc;
> > >            break;
> > >          }
> > >        else if (is_undefweak)
> > >
> > >
> > > Huacai
> > Now the patch is submitted here:
> > https://sourceware.org/pipermail/binutils/2022-September/122713.html
> >
>
> Great. Given the severity of this bug, I imagine that building the
> LoongArch kernel will require a version of binutils that carries this
> fix.
>
> Therefore, i will revert back to the original approach for accessing
> uncompressed_size, using an extern declaration with an __aligned(1)
> attribute.
>
> > And I have some other questions about kexec: kexec should jump to the
> > elf entry or the pe entry? I think is the elf entry, because if we
> > jump to the pe entry, then SVAM will be executed twice (but it should
> > be executed only once). However, how can we jump to the elf entry if
> > we use zboot? Maybe it is kexec-tool's responsibility to decompress
> > the zboot kernel image?
> >
>
> Yes, very good point. Kexec kernels cannot boot via the EFI entry
> point, as the boot services will already be shutdown. So the kexec
> kernel needs to boot via the same entrypoint in the core kernel that
> the EFI stub calls when it hands over.
>
> For the EFI zboot image in particular, we will need to teach kexec how
> to decompress them. The zboot image has a header that
> a) describes it as a EFI linux zimg
> b) describes the start and end offset of the compressed payload
> c) describes which compression algorithm was used.
>
> This means that any non-EFI loader (including kexec) should be able to
> extract the inner PE/COFF image and decompress it. For arm64 and
> RISC-V, this is sufficient as the EFI and raw images are the same. For
> LoongArch, I suppose it means we need a way to enter the core kernel
> directly via the entrypoint that the EFI stub uses when handing over
> (and pass the original DT argument so the kexec kernel has access to
> the EFI and ACPI firmware tables)
OK, then is this implementation [1] acceptable? I remember that you
said the MS-DOS header shouldn't contain other information, so I guess
this is unacceptable?

[1] https://lore.kernel.org/loongarch/c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn/T/#mb8c1dc44f7fa2d3ef638877f0cd3f958f0be96ad

Huacai
