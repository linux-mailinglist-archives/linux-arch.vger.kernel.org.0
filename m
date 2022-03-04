Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24CF4CD253
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiCDKYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Mar 2022 05:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCDKYu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2022 05:24:50 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F14EA21;
        Fri,  4 Mar 2022 02:24:01 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id d11so8548656vsm.5;
        Fri, 04 Mar 2022 02:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwCgFrKVYtlfIz8CnnCvaOjD8UASRKkBxkcuQcJ6l6A=;
        b=Y9ZO8AtQhlGhlG5+TkZj1HExcNwp0f+E3W8wnWfIr4KqgBPS/5xha/nzqSzOI3zEJZ
         UjJpihIQgM2LlKg7Z34ZqN4eZAJUIIxth9d1cGuUY8aWp6JU1GyoVbK5LCxpxOi6XQ7S
         vgE69sJ8/qUPLWVVla3cbDWlG1v0LDZ1gdLky3Dyj+YjfZ/0eWjUukSgy7smOIoRdFXz
         h8AcwYHbPD0Ci1h9YpAWfxGIiyi3w+0bCPn0w0V8QSw3USqvlfBO5KyUWn+l6WtJQBAT
         7PnjX9LjGoEJ+pn2X84Ifk9IsswPhyNO8ANgBc5htWze+QvGJYtzS8Qxhf7QZ2REgyVy
         aRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwCgFrKVYtlfIz8CnnCvaOjD8UASRKkBxkcuQcJ6l6A=;
        b=tysw6Ca0OodzcMuqDeHGaEIimmcZvPDSTuPH4TiffL36x6fnrr2LGPWfjRDNNP7h1P
         qAWLWE2GR6wAvuJ4ZfxH2D8BLUSaDjJQYX0uRk7XmTrKdb07s+VPdmOGUiKT5teytrsI
         3kFcUmcShqPz4ShDI1ID8f9fRwO0cWu4zzov+afHScIKIU8mAGDruWjHfDT3XtUE23OA
         HMPFDpjvLPsRhaitsN69fBOyzOAYfovOmYXW8vnkcp/NbUybA3JLqnBIHJ9fM7giPeWG
         5Sq9MYMNlvh9kdCJNj3lqZHINRArSlrhRr+/NYQ9Ffd8QveoJAlG3O6vI+H7xtomvC1k
         XU4w==
X-Gm-Message-State: AOAM532jhVcpwxOlrnQtGGA8OP8oJVucyXjmxUYf/SHy2E5bJCecNClv
        hTvv+mOR3Jf1A3PcvYlug6xOcEwIkVe64SWPpOo=
X-Google-Smtp-Source: ABdhPJwjLuVqoDFgtAh/T7A5IBTy0nkEOc4EOhnDv7STkYQqXNkZdWeRJ0Ugd32BXSmAqMJolhIwuxlpx2XCHBkAixk=
X-Received: by 2002:a05:6102:5589:b0:31b:dff9:3ddb with SMTP id
 dc9-20020a056102558900b0031bdff93ddbmr16907830vsb.62.1646389440179; Fri, 04
 Mar 2022 02:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
 <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
 <CAAhV-H7X+Txq4HaaF49QZ9deD=Dwx_GX-2E9q_nA8P76ZRDeXg@mail.gmail.com>
 <CAMj1kXGH1AtL8_KbFkK+FRgWQPzPm1dCdvEF0A2KksREGTSeCg@mail.gmail.com>
 <CAAhV-H6fdJwbVG_m0ZL_JGROKCrCbc-fKpj3dnOowaEUA+3ujQ@mail.gmail.com>
 <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com>
 <CAMj1kXHGG80LdNUUA+Ug1VBXWuvtPxKpqnuChg2N=6Hf2EhY7g@mail.gmail.com>
 <CAAhV-H6dxkdmDizd+ZVhJ_zHZ9RK8QjKU-3U-CaovLiNbEVpbg@mail.gmail.com>
 <CAK8P3a2wF2XA8wCFtP9RNTNQf3W9D8fKOuQ704yE+dRSS5aCVw@mail.gmail.com>
 <CAAhV-H65PeK8w0U2DSbQ0eSWzAR-zjhPz8swSgZhbtKKJAYAKg@mail.gmail.com>
 <CAMj1kXFgCu659zGuZPpRLYPzFemtBv0jsOt1Yz0U0-R4DucqTw@mail.gmail.com>
 <CAAhV-H6GrAH_HGehqernowaTyZjQRNOyp=O8QNE3_7RHfarUFQ@mail.gmail.com>
 <CAAhV-H7B0xxNeTLd5n1cqPbF_hCp2N1KTbnNMAXFGxfZDzMcpw@mail.gmail.com> <CAMj1kXHc-Mpt_NTyR1CVzttV3ORtPerj23BBGNf=g7WmDu7BhA@mail.gmail.com>
In-Reply-To: <CAMj1kXHc-Mpt_NTyR1CVzttV3ORtPerj23BBGNf=g7WmDu7BhA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 4 Mar 2022 18:23:47 +0800
Message-ID: <CAAhV-H5WS18XNaXVZUUKfL9BrVgb+xjH7vTsdyG7sJn0Pk0GEg@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ard & Arnd,

On Thu, Mar 3, 2022 at 5:54 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 3 Mar 2022 at 07:26, Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Ard & Arnd,
> >
> > On Wed, Mar 2, 2022 at 5:20 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > >
> > > Hi, Ard,
> > >
> > > On Wed, Mar 2, 2022 at 4:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 2 Mar 2022 at 09:56, Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > >
> > > > > Hi, Arnd & Ard,
> > > > >
> > > > > On Tue, Mar 1, 2022 at 6:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > >
> > > > > > On Tue, Mar 1, 2022 at 5:17 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > > > On Mon, Feb 28, 2022 at 7:35 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > > On Mon, 28 Feb 2022 at 12:24, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > > > > > Can't you just use the UEFI protocol for kernel entry regardless
> > > > > > > > > of the bootloader? It seems odd to use a different protocol for loading
> > > > > > > > > grub and the kernel, especially if that means you end up having to
> > > > > > > > > support both protocols inside of u-boot and grub, in order to chain-load
> > > > > > > > > a uefi application like grub.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I think this would make sense. Now that the EFI stub has generic
> > > > > > > > support for loading the initrd via a UEFI specific protocol (of which
> > > > > > > > u-boot already carries an implementation), booting via UEFI only would
> > > > > > > > mean that no Linux boot protocol would need to be defined outside of
> > > > > > > > the kernel at all (i.e., where to load the kernel, where to put the
> > > > > > > > command line, where to put the initrd, other arch specific rules etc
> > > > > > > > etc) UEFI already supports both ACPI and DT boot
> > > > > > >
> > > > > > > After one night thinking, I agree with Ard that we can use RISCV-style
> > > > > > > fdt to support the raw elf kernel at present, and add efistub support
> > > > > > > after new UEFI SPEC released.
> > > > > >
> > > > > > I think that is the opposite of what Ard and I discussed above.
> > > > > Hmm, I thought that new UEFI SPEC is a requirement of efistub, maybe I'm wrong?
> > > > >
> > > > > >
> > > > > > > If I'm right, it seems that RISC-V passes a0 (hartid) and a1 (fdt
> > > > > > > pointer, which contains cmdline, initrd, etc.) to the raw elf kernel.
> > > > > > > And in my opinion, the main drawback of current LoongArch method
> > > > > > > (a0=argc a1=argv a2=bootparamsinterface pointer) is it uses a
> > > > > > > non-standard method to pass kernel args and initrd. So, can the below
> > > > > > > new solution be acceptable?
> > > > > > >
> > > > > > > a0=bootparamsinterface pointer (the same as a2 in current method)
> > > > > > > a1=fdt pointer (contains cmdline, initrd, etc., like RISC-V, I think
> > > > > > > this is the standard method)
> > > > > >
> > > > > > It would seem more logical to me to keep those details as part of the
> > > > > > interface between the EFI stub and the kernel, rather than the
> > > > > > documented boot interface.
> > > > > >
> > > > > > You said that there is already grub support using the UEFI
> > > > > > loader, so I assume you have a working draft of the boot
> > > > > > protocol. Are there still open questions about the interface
> > > > > > definition for that preventing you from using it as the only
> > > > > > way to enter the kernel from a bootloader?
> > > > > Things become simple if we only consider efistub rather than raw elf.
> > > > > But there are still some problems:
> > > > > 1, We want the first patch series as minimal as possible, efistub
> > > > > support will add a lot of code.
> > > > > 2, EFISTUB hides the interface between bootloader and raw kernel, but
> > > > > the interface does actually exist (efistub itself is also a
> > > > > bootloader, though it binds with the raw kernel). In the current
> > > > > implementation (a0=argc a1=argv a2=bootparaminterface), we should
> > > > > select EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER which is marked as
> > > > > deprecated. Is this acceptable? If not, we still need to change the
> > > > > bootloader-kernel interface, maybe use the method in my previous
> > > > > email?
> > > >
> > > > Why do you need this?
> > > Because in the current implementation (a0=argc a1=argv
> > > a2=bootparaminterface), initrd should be passed by cmdline
> > > (initrd=xxxx). If without that option, efi_load_initrd_cmdline() will
> > > not call handle_cmdline_files().
> > It seems I'm wrong. EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER controls
> > "initrd=xxxx" from BIOS to EFISTUB, but has nothing to do with
> > a0/a1/a2 usage (which controls the "initrd=xxxx" from efistub to raw
> > kernel). The real reason is our UEFI BIOS has an old codebase without
> > LoadFile2 support.
> >
>
> The problem with initrd= is that it can only load the initrd from the
> same EFI block device that the kernel was loaded from, which is highly
> restrictive, and doesn't work with bootloaders that call LoadImage()
> on a kernel image loaded into memory. This is why x86 supports passing
> the initrd in memory, and provide the base/size via struct bootparams,
> and arm64 supports the same using DT.
>
> The LoadImage2 protocol based method intends to provide a generic
> alternative to this, as it uses a pure EFI abstraction, and therefore
> does not rely on struct bootparams or DT at all.
>
> So the LoadImage2() based method is preferred, but if your
> architecture implements DT support already, there is nothing
> preventing you from passing initrd information directly to the kernel
> via the /chosen node.
>
> > Then, my new questions are:
> > 1, Is EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER an unacceptable option
> > for a new Arch? If yes, we should backport LoadFile2 support to our
> > BIOS.
>
> See above.
>
> > 2, We now all agree that EFISTUB is the standard and maybe the only
> > way in future. But, can we do the efistub work in the second series,
> > in order to make the first series as minimal as possible? (I will
> > update the commit message to make it clear that a0/a1/a2 usage is only
> > an internal interface between efistub and raw kernel).
> >
>
> I think it would be better to drop the UEFI and ACPI pieces for now,
> and resubmit it once the dust has settled around this.
FDT support is our future goal, at present we only have ACPI firmware
and kernel. I mentioned FDT just wants to replace a0/a1 to pass
cmdline, not means we already have FDT support.

So, let's keep the existing a0/a1/a2 usage as an internal interface
for now, then backport LoadFile2 and add efistub support.

Huacai
