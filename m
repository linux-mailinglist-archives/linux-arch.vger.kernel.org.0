Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388A4CA082
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 10:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiCBJVt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Mar 2022 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiCBJVr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2022 04:21:47 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC007BB56E;
        Wed,  2 Mar 2022 01:21:04 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id l45so515556uad.1;
        Wed, 02 Mar 2022 01:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wS/4vUPXRYVqIGA3oZCkB12D/JLXUJDmy57hV8s4aLk=;
        b=jfxy4e3b7tvL4FubDYhKLeFBCXnNgn7ZkIvZ7G6Ju1whiXXeKffe9kqLGDhACXK8rd
         wmVresVL6k2wakjfk5MY0MUCwcilUrr3rppfSnjXIDcAU4ZQjTvXPCAkuGKo7vH8/pBR
         h1LDbG56PfkGM48Z8VvlzemcDciMYJ0pVCI4Z8SUbmuFrh0nfSEGROzepQPJBzEtJY99
         rnQyPAiufVJgxUffMXNqHfRNOhYuSv+xVPGZ6FgzhXfgMMsdpUKrE60wI44s35MyYbVr
         iym250wu1uxjesqc3Vc9ACnAEWu1weRPETdBzURsv9TD5N5BquiZZ4BP7hLKTpD5sNKD
         MMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wS/4vUPXRYVqIGA3oZCkB12D/JLXUJDmy57hV8s4aLk=;
        b=6UmJ1SMSbyIvLa8Y6uaSb3K7ftxMwUP41negb+m6x3etL9gPb4RhNHpp0vlg4oUxRO
         yNFECYRdVf3D9uTP2ADF3JuSemsptdUXk7z3c9R89xESmTkNjgoqs96jpAVOi+99m4V1
         RQIBXUMZX8ScrtllJqTOXLCBXdBhdn5m8PVBRYM6+FxnToTLnWlfghyGM15Gm6hw8elj
         Wxy1tK7m7+UZqsVugmHUJ3CR6tCbTfMwmSTF/BbB+9m7xqWK+dfooyo1B4p+XqSxgmBC
         fJcK0PknaRnq0+AOc6ct8cQO4abEYQIlN4zoTN5PRKuoSgj8jizEsxL6/6sXRFEOnHnH
         HSwA==
X-Gm-Message-State: AOAM533gRvFunJHdvQeyZ23A0s/rrblVVqa7cuZlP5TVagdifG+r3N5S
        pdYPb2xzL2ieytIg5zwLeDzvFuaaiJkALMvNdiBmDmG8xRw=
X-Google-Smtp-Source: ABdhPJxHP3Lkxre1yQfztsk1TwZkqkSIi0l0AWufxuHEMHFZtgfhdjTQwz5BrajdKfCpYGxjJm8xAiHds54zc6RLTGI=
X-Received: by 2002:ab0:654d:0:b0:347:27e5:cb4a with SMTP id
 x13-20020ab0654d000000b0034727e5cb4amr5995264uap.67.1646212863772; Wed, 02
 Mar 2022 01:21:03 -0800 (PST)
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
 <CAAhV-H65PeK8w0U2DSbQ0eSWzAR-zjhPz8swSgZhbtKKJAYAKg@mail.gmail.com> <CAMj1kXFgCu659zGuZPpRLYPzFemtBv0jsOt1Yz0U0-R4DucqTw@mail.gmail.com>
In-Reply-To: <CAMj1kXFgCu659zGuZPpRLYPzFemtBv0jsOt1Yz0U0-R4DucqTw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 2 Mar 2022 17:20:53 +0800
Message-ID: <CAAhV-H6GrAH_HGehqernowaTyZjQRNOyp=O8QNE3_7RHfarUFQ@mail.gmail.com>
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

Hi, Ard,

On Wed, Mar 2, 2022 at 4:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 2 Mar 2022 at 09:56, Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Arnd & Ard,
> >
> > On Tue, Mar 1, 2022 at 6:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Mar 1, 2022 at 5:17 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > On Mon, Feb 28, 2022 at 7:35 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > On Mon, 28 Feb 2022 at 12:24, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > > Can't you just use the UEFI protocol for kernel entry regardless
> > > > > > of the bootloader? It seems odd to use a different protocol for loading
> > > > > > grub and the kernel, especially if that means you end up having to
> > > > > > support both protocols inside of u-boot and grub, in order to chain-load
> > > > > > a uefi application like grub.
> > > > > >
> > > > >
> > > > > I think this would make sense. Now that the EFI stub has generic
> > > > > support for loading the initrd via a UEFI specific protocol (of which
> > > > > u-boot already carries an implementation), booting via UEFI only would
> > > > > mean that no Linux boot protocol would need to be defined outside of
> > > > > the kernel at all (i.e., where to load the kernel, where to put the
> > > > > command line, where to put the initrd, other arch specific rules etc
> > > > > etc) UEFI already supports both ACPI and DT boot
> > > >
> > > > After one night thinking, I agree with Ard that we can use RISCV-style
> > > > fdt to support the raw elf kernel at present, and add efistub support
> > > > after new UEFI SPEC released.
> > >
> > > I think that is the opposite of what Ard and I discussed above.
> > Hmm, I thought that new UEFI SPEC is a requirement of efistub, maybe I'm wrong?
> >
> > >
> > > > If I'm right, it seems that RISC-V passes a0 (hartid) and a1 (fdt
> > > > pointer, which contains cmdline, initrd, etc.) to the raw elf kernel.
> > > > And in my opinion, the main drawback of current LoongArch method
> > > > (a0=argc a1=argv a2=bootparamsinterface pointer) is it uses a
> > > > non-standard method to pass kernel args and initrd. So, can the below
> > > > new solution be acceptable?
> > > >
> > > > a0=bootparamsinterface pointer (the same as a2 in current method)
> > > > a1=fdt pointer (contains cmdline, initrd, etc., like RISC-V, I think
> > > > this is the standard method)
> > >
> > > It would seem more logical to me to keep those details as part of the
> > > interface between the EFI stub and the kernel, rather than the
> > > documented boot interface.
> > >
> > > You said that there is already grub support using the UEFI
> > > loader, so I assume you have a working draft of the boot
> > > protocol. Are there still open questions about the interface
> > > definition for that preventing you from using it as the only
> > > way to enter the kernel from a bootloader?
> > Things become simple if we only consider efistub rather than raw elf.
> > But there are still some problems:
> > 1, We want the first patch series as minimal as possible, efistub
> > support will add a lot of code.
> > 2, EFISTUB hides the interface between bootloader and raw kernel, but
> > the interface does actually exist (efistub itself is also a
> > bootloader, though it binds with the raw kernel). In the current
> > implementation (a0=argc a1=argv a2=bootparaminterface), we should
> > select EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER which is marked as
> > deprecated. Is this acceptable? If not, we still need to change the
> > bootloader-kernel interface, maybe use the method in my previous
> > email?
>
> Why do you need this?
Because in the current implementation (a0=argc a1=argv
a2=bootparaminterface), initrd should be passed by cmdline
(initrd=xxxx). If without that option, efi_load_initrd_cmdline() will
not call handle_cmdline_files().

Huacai
>
> > 3, I know things without upstream means "nothing" for the community,
> > but if we can provide raw elf kernel support to be compatible with
> > existing products (not just a working draft, they are widely used
> > now), it also seems reasonable.
> >
> > Huacai
> >
> > >
> > >         Arnd
