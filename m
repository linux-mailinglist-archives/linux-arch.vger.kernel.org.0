Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0925ACBE3
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiIEHDs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiIEHDk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 03:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2761D332;
        Mon,  5 Sep 2022 00:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB2D761135;
        Mon,  5 Sep 2022 07:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D109C43140;
        Mon,  5 Sep 2022 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662361418;
        bh=tS2jLsXDOH5Y6m6YaMp0XlHDEzuLEVmuD/Joh3MRIjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jHkqxRhSdaPnP04XVaUHXTSwW9THYR73QxAK4U2orxtgVu1Mi/+W6HuNldlTM1PbT
         mDVWFnB8TFp44hoJmLnO1PTyn9P2ysC1OyTQVJVN4cTFfk/FSDBVvrMky5GkkqjE5A
         ewQxr2Bt3nautQe/Ur9337koI0y3k3nHdmjFnyOxweSIlOwSWuwEXOb/ku7qOj64ND
         WvmgdATyOUdQLz5T86ozvDOxsjCMl1ihgKxxprXqqHaJrCC2RvQTNshWfdtsEcVWXT
         wCNebFSqrrFXG3IzBg+Qloc/x57C90xolfcSKWhppenB4uXa3KMqHfQ/YZD6Zwa7jk
         pIpj0kIBqD4Eg==
Received: by mail-lj1-f171.google.com with SMTP id s15so8252098ljp.5;
        Mon, 05 Sep 2022 00:03:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo0p8Nxm9oAmV8ChnfzJM6HvjWMbMWRW1ywcwK1b7seoZjKegQsT
        4XV4a6PYBGt0wYQ8Z+t14qigcgOOWbQMhn6iM/0=
X-Google-Smtp-Source: AA6agR7NL2En09uXlQi/jHAloXwDm/ZFgQyAjCszLhq0fcs+NpR82gexBV9m+65hnkG9PRK8FNrHnSzztWId5FX2DX8=
X-Received: by 2002:a2e:3006:0:b0:266:6677:5125 with SMTP id
 w6-20020a2e3006000000b0026666775125mr9966240ljw.352.1662361416307; Mon, 05
 Sep 2022 00:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
 <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
 <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
 <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
 <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com> <8319b9d4-960c-e706-468a-cb58bef6df8c@loongson.cn>
In-Reply-To: <8319b9d4-960c-e706-468a-cb58bef6df8c@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 09:03:25 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFymxcUbgBHq3CuzNJW-dfDc=5poT-616qeRs9Qp7Zj_w@mail.gmail.com>
Message-ID: <CAMj1kXFymxcUbgBHq3CuzNJW-dfDc=5poT-616qeRs9Qp7Zj_w@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
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

On Mon, 5 Sept 2022 at 06:34, Youling Tang <tangyouling@loongson.cn> wrote:
>
> Hi, Ard & Huacai
>
> On 09/05/2022 11:50 AM, Huacai Chen wrote:
> > Hi, Ard,
> >
> > On Mon, Sep 5, 2022 at 5:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Sun, 4 Sept 2022 at 15:24, Huacai Chen <chenhuacai@kernel.org> wrote:
> >>>
> >>> Hi, Ard,
> >>>
> >>> On Thu, Sep 1, 2022 at 6:40 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >>>>
> >>>> Hi, Ard,
> >>>>
> >>>> On Sat, Aug 27, 2022 at 3:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>>
> >>>>> On Sat, 27 Aug 2022 at 06:41, Xi Ruoyao <xry111@xry111.site> wrote:
> >>>>>>
> >>>>>> Tested V3 with the magic number check manually removed in my GRUB build.
> >>>>>> The system boots successfully.  I've not tested Arnd's zBoot patch yet.
> >>>>>
> >>>>> I am Ard not Arnd :-)
> >>>>>
> >>>>> Please use this branch when testing the EFI decompressor:
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-decompressor-v4
> >>>> The root cause of LoongArch zboot boot failure has been found, it is a
> >>>> binutils bug, latest toolchain with the below patch can solve the
> >>>> problem.
> >>>>
> >>>> diff --git a/bfd/elfnn-loongarch.c b/bfd/elfnn-loongarch.c
> >>>> index 5b44901b9e0..fafdc7c7458 100644
> >>>> --- a/bfd/elfnn-loongarch.c
> >>>> +++ b/bfd/elfnn-loongarch.c
> >>>> @@ -2341,9 +2341,10 @@ loongarch_elf_relocate_section (bfd
> >>>> *output_bfd, struct bfd_link_info *info,
> >>>>      case R_LARCH_SOP_PUSH_PLT_PCREL:
> >>>>        unresolved_reloc = false;
> >>>>
> >>>> -      if (resolved_to_const)
> >>>> +      if (!is_undefweak && resolved_to_const)
> >>>>          {
> >>>>            relocation += rel->r_addend;
> >>>> +          relocation -= pc;
> >>>>            break;
> >>>>          }
> >>>>        else if (is_undefweak)
> >>>>
> >>>>
> >>>> Huacai
> >>> Now the patch is submitted here:
> >>> https://sourceware.org/pipermail/binutils/2022-September/122713.html
> >>>
> >>
> >> Great. Given the severity of this bug, I imagine that building the
> >> LoongArch kernel will require a version of binutils that carries this
> >> fix.
> >>
> >> Therefore, i will revert back to the original approach for accessing
> >> uncompressed_size, using an extern declaration with an __aligned(1)
> >> attribute.
> >>
> >>> And I have some other questions about kexec: kexec should jump to the
> >>> elf entry or the pe entry? I think is the elf entry, because if we
> >>> jump to the pe entry, then SVAM will be executed twice (but it should
> >>> be executed only once). However, how can we jump to the elf entry if
> >>> we use zboot? Maybe it is kexec-tool's responsibility to decompress
> >>> the zboot kernel image?
> >>>
> >>
> >> Yes, very good point. Kexec kernels cannot boot via the EFI entry
> >> point, as the boot services will already be shutdown. So the kexec
> >> kernel needs to boot via the same entrypoint in the core kernel that
> >> the EFI stub calls when it hands over.
> >>
> >> For the EFI zboot image in particular, we will need to teach kexec how
> >> to decompress them. The zboot image has a header that
> >> a) describes it as a EFI linux zimg
> >> b) describes the start and end offset of the compressed payload
> >> c) describes which compression algorithm was used.
> >>
> >> This means that any non-EFI loader (including kexec) should be able to
> >> extract the inner PE/COFF image and decompress it. For arm64 and
> >> RISC-V, this is sufficient as the EFI and raw images are the same. For
> >> LoongArch, I suppose it means we need a way to enter the core kernel
> >> directly via the entrypoint that the EFI stub uses when handing over
> >> (and pass the original DT argument so the kexec kernel has access to
> >> the EFI and ACPI firmware tables)
> > OK, then is this implementation [1] acceptable? I remember that you
> > said the MS-DOS header shouldn't contain other information, so I guess
> > this is unacceptable?
> >
> > [1] https://lore.kernel.org/loongarch/c4dbb14a-5580-1e47-3d15-5d2079e88404@loongson.cn/T/#mb8c1dc44f7fa2d3ef638877f0cd3f958f0be96ad
>
> Modifications to the MS-DOS header refer to the arm64 and riscv
> implementations [1], and to provide the necessary information to
> kexec-tools[2] when loading uncompressed efi images.
>

Indeed. On top of the EFI zboot series, we need some [generic!] kexec
plumbing to identify such compressed images, and decompress the
payload before passing the contents to the arch specific probe/load
image hooks.
