Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E94CA013
	for <lists+linux-arch@lfdr.de>; Wed,  2 Mar 2022 09:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiCBI5f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Mar 2022 03:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbiCBI5f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Mar 2022 03:57:35 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBE15FF1E;
        Wed,  2 Mar 2022 00:56:51 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id g21so1081139vsp.6;
        Wed, 02 Mar 2022 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcoEJcECMe/jotZIINGybFP8QW9wjBMfp8v6i5TG95I=;
        b=JBlTwDnfrOHbBBo1U81GQiw+GgldS4rNbUVuCvR4Bume8CMcpp7dy2Z6y1HPBVQxx4
         fEkTD2Mf2dkkiAPwhi/6LRon4XKgub+wvS7UTjyz7usPC5nHOal2qiIf+1CuIBLxKpM1
         FnasKV74JGxVHGuNfW+gt3mqIn4ORlkBV3oNrhMPO6mvWQHjRgJ8uwQfsdFDTKlfiF5n
         0QiNc/Ybq5ifH7iq/lx7xbgSTPerbo9Eu+qqyLYEXqok3zlpO4Ov1rg9UvinUs3txdLP
         KVdN7dxSXweSIKX5bi9vflS4+LXhDKkci7kRx3F52qNOLNchw2mPrW3FoAHWVTAtDFsm
         1UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcoEJcECMe/jotZIINGybFP8QW9wjBMfp8v6i5TG95I=;
        b=e68aW3EGx3/XOIwf5zDIUketclI1o0AjHGv+GBEs0IF7o9yta0N1nkVmlddutfgGwM
         xOQVpyZHYCdVq5ZXEtv5Wna3sVCC0XxRFx8a8wRiYgItQA5k0M+55u2qOS0/8DoN2Rn2
         6q+kibrK95e1fvYDsFBvvR8FeC2L256zJWMjl/X57gGnGT354RK28qF+ddDFI1JSNvl5
         vsjC79nHHl74uHHZGe3KYHwStFvsNxPGGvNQbcJfryzPXrYGW0ov9IRihF18HMnoHoKK
         b3kJilDNCbcPyrxxOTGYTkBIhMwMkW+LV7+5x514Oq1ZhG1NwdzV9mE9YCr/ce34jCkj
         Nq3Q==
X-Gm-Message-State: AOAM5326w/dUS/YOEg68pjZwMXtCXDjwif0a3wboh1Nf4+yhJl406hUw
        Zaz1vwnImjOSaueD4jdrqScaEBVboAS/pzorRqRdzaBVGJE=
X-Google-Smtp-Source: ABdhPJyDDEvUmvEeK1dRwMKTOHXN/Nslw1Ti8bPg/TfWL4Xs69not8WaPnMybQMLO7Gx2wlKMblqH8P/5S/OqBjHR8c=
X-Received: by 2002:a05:6102:5589:b0:31b:dff9:3ddb with SMTP id
 dc9-20020a056102558900b0031bdff93ddbmr12089286vsb.62.1646211410984; Wed, 02
 Mar 2022 00:56:50 -0800 (PST)
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
 <CAAhV-H6dxkdmDizd+ZVhJ_zHZ9RK8QjKU-3U-CaovLiNbEVpbg@mail.gmail.com> <CAK8P3a2wF2XA8wCFtP9RNTNQf3W9D8fKOuQ704yE+dRSS5aCVw@mail.gmail.com>
In-Reply-To: <CAK8P3a2wF2XA8wCFtP9RNTNQf3W9D8fKOuQ704yE+dRSS5aCVw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 2 Mar 2022 16:56:39 +0800
Message-ID: <CAAhV-H65PeK8w0U2DSbQ0eSWzAR-zjhPz8swSgZhbtKKJAYAKg@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

Hi, Arnd & Ard,

On Tue, Mar 1, 2022 at 6:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 1, 2022 at 5:17 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Mon, Feb 28, 2022 at 7:35 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Mon, 28 Feb 2022 at 12:24, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > Can't you just use the UEFI protocol for kernel entry regardless
> > > > of the bootloader? It seems odd to use a different protocol for loading
> > > > grub and the kernel, especially if that means you end up having to
> > > > support both protocols inside of u-boot and grub, in order to chain-load
> > > > a uefi application like grub.
> > > >
> > >
> > > I think this would make sense. Now that the EFI stub has generic
> > > support for loading the initrd via a UEFI specific protocol (of which
> > > u-boot already carries an implementation), booting via UEFI only would
> > > mean that no Linux boot protocol would need to be defined outside of
> > > the kernel at all (i.e., where to load the kernel, where to put the
> > > command line, where to put the initrd, other arch specific rules etc
> > > etc) UEFI already supports both ACPI and DT boot
> >
> > After one night thinking, I agree with Ard that we can use RISCV-style
> > fdt to support the raw elf kernel at present, and add efistub support
> > after new UEFI SPEC released.
>
> I think that is the opposite of what Ard and I discussed above.
Hmm, I thought that new UEFI SPEC is a requirement of efistub, maybe I'm wrong?

>
> > If I'm right, it seems that RISC-V passes a0 (hartid) and a1 (fdt
> > pointer, which contains cmdline, initrd, etc.) to the raw elf kernel.
> > And in my opinion, the main drawback of current LoongArch method
> > (a0=argc a1=argv a2=bootparamsinterface pointer) is it uses a
> > non-standard method to pass kernel args and initrd. So, can the below
> > new solution be acceptable?
> >
> > a0=bootparamsinterface pointer (the same as a2 in current method)
> > a1=fdt pointer (contains cmdline, initrd, etc., like RISC-V, I think
> > this is the standard method)
>
> It would seem more logical to me to keep those details as part of the
> interface between the EFI stub and the kernel, rather than the
> documented boot interface.
>
> You said that there is already grub support using the UEFI
> loader, so I assume you have a working draft of the boot
> protocol. Are there still open questions about the interface
> definition for that preventing you from using it as the only
> way to enter the kernel from a bootloader?
Things become simple if we only consider efistub rather than raw elf.
But there are still some problems:
1, We want the first patch series as minimal as possible, efistub
support will add a lot of code.
2, EFISTUB hides the interface between bootloader and raw kernel, but
the interface does actually exist (efistub itself is also a
bootloader, though it binds with the raw kernel). In the current
implementation (a0=argc a1=argv a2=bootparaminterface), we should
select EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER which is marked as
deprecated. Is this acceptable? If not, we still need to change the
bootloader-kernel interface, maybe use the method in my previous
email?
3, I know things without upstream means "nothing" for the community,
but if we can provide raw elf kernel support to be compatible with
existing products (not just a working draft, they are widely used
now), it also seems reasonable.

Huacai

>
>         Arnd
