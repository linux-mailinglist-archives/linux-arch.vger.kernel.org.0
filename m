Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CAB4C8217
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 05:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiCAER5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 23:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiCAER4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 23:17:56 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1BC473A9;
        Mon, 28 Feb 2022 20:17:15 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id e5so15214432vsg.12;
        Mon, 28 Feb 2022 20:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XX+IWGQPoFeh97VSAKm6031fD11VKSEYMPq0/2cLTeY=;
        b=JFOATMfyEe+q2YvZrNExXmlIiIjnIwcxdvHk/WzuC0p/XbwABgHaZFREv0E2vYcOCh
         44pY9ThY1M5Y7nwfcQWLFmDp6IMbLLs3M/oeUuISm7mV189rZoSNx2aws5ZDt5Cgr7+K
         t/QIzoA5kzWRBKBOhtDlw5oKY4auHKRoUizfIFNWNqPsTLw4LI0UI2WeuiEvOmD8Ka5J
         dkuGJ2gRwfEwNpgli04YlIxiKa6c9U+NnrXu2mnyW0pKYXc3r1XFqU7bmXJGn6MvEILs
         WLNyII5lJ6h4OQg2CsqcsBMIO0N1d+mzet+gJwMUbuvzxfU4CYZO025TqeAxzilU4b/e
         LDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XX+IWGQPoFeh97VSAKm6031fD11VKSEYMPq0/2cLTeY=;
        b=7VQxrg83EMfy5ULK7+5mPBvOVztxegDnAH3wlZrH2xpVijd1bcFdGHFb3gdoLUHuzD
         4XNEcAMCoKAzo/PsBrigIrLBUGAEBRgdBfWeXA5w/ua3fwxJ4wzZXGSjlPvsslVdGL5U
         jLCw8SEpIZ4XpjM0px/wn7GNw1aQzTRlq/c2k1OgK5WjSj78y9X4j7dm+QPiLwMhIPNm
         gmgoHjw+R34EoD0ICqOM0dYwB4rDCZcSY2PtG05yVUCRDpJ/QFETqZmBjMqo5ba+qFdZ
         Ml7qxQmZqpuJuEPuUnaa68/afn8zkAbD2PKQyn0Vw0jvO2w3oeVG/5j9arwnUkiFKv02
         j41A==
X-Gm-Message-State: AOAM533yHptaWTlztSmqDBxb/EhE+hzdWJdUmvtML5KOnQRFV+E+Nk5h
        IH2w8CP+q1/r4+Sa6QypK0eKCzfEbfJeagOPRqrG2ecZ3S/Q+w==
X-Google-Smtp-Source: ABdhPJwsPqTLqByAywbPvHbUlZ0RmBQQuT3nqAGrXPiTyDCpCNQ4pE+4K+lDpxX3ZVso8ruv7YjBCeaONpdv8zk6tdU=
X-Received: by 2002:a67:c10e:0:b0:31b:7197:5751 with SMTP id
 d14-20020a67c10e000000b0031b71975751mr9775554vsj.43.1646108235078; Mon, 28
 Feb 2022 20:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
 <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
 <CAAhV-H7X+Txq4HaaF49QZ9deD=Dwx_GX-2E9q_nA8P76ZRDeXg@mail.gmail.com>
 <CAMj1kXGH1AtL8_KbFkK+FRgWQPzPm1dCdvEF0A2KksREGTSeCg@mail.gmail.com>
 <CAAhV-H6fdJwbVG_m0ZL_JGROKCrCbc-fKpj3dnOowaEUA+3ujQ@mail.gmail.com>
 <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com> <CAMj1kXHGG80LdNUUA+Ug1VBXWuvtPxKpqnuChg2N=6Hf2EhY7g@mail.gmail.com>
In-Reply-To: <CAMj1kXHGG80LdNUUA+Ug1VBXWuvtPxKpqnuChg2N=6Hf2EhY7g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 1 Mar 2022 12:17:03 +0800
Message-ID: <CAAhV-H6dxkdmDizd+ZVhJ_zHZ9RK8QjKU-3U-CaovLiNbEVpbg@mail.gmail.com>
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

On Mon, Feb 28, 2022 at 7:35 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 28 Feb 2022 at 12:24, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > On Mon, Feb 28, 2022 at 4:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > On Mon, 28 Feb 2022 at 09:38, Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > >
> > > > > > RISC-V is a useful reference for the changes needed - this is the most
> > > > > > recent addition to the EFI stub, and avoids some legacy stuff that new
> > > > > > architectures have no need for.
> > > > > We still want to support the raw elf kernel (RISC-V also does),
> > > > > because LoongArch also has MCU and SoC and we want to support FDT (I
> > > > > think this is reasonable, because RISC-V also supports raw elf).
> > > > >
> > > >
> > > > That is fine. So perhaps the best course of action is to omit the
> > > > UEFI/ACPI parts entirely for now, and focus on the DT/embedded use
> > > > case. Once all the spec pieces are in place, the UEFI + ACPI changes
> > > > can be presented as a single coherent set.
> > > It seems that I made you confusing. :)
> > > There are big CPUs and small CPUs (MCU and SoC), big CPUs use
> > > UEFI+ACPI, while small CPUs use FDT.
> > > At present, the only matured LoongArch CPU is Loongson-3A5000 (big
> > > CPU) which uses UEFI+ACPI.
> > > We want to support raw elf because it can run on both ACPI firmware
> > > and FDT firmware, but at present we only have ACPI firmware.
> >
> > Can't you just use the UEFI protocol for kernel entry regardless
> > of the bootloader? It seems odd to use a different protocol for loading
> > grub and the kernel, especially if that means you end up having to
> > support both protocols inside of u-boot and grub, in order to chain-load
> > a uefi application like grub.
> >
>
> I think this would make sense. Now that the EFI stub has generic
> support for loading the initrd via a UEFI specific protocol (of which
> u-boot already carries an implementation), booting via UEFI only would
> mean that no Linux boot protocol would need to be defined outside of
> the kernel at all (i.e., where to load the kernel, where to put the
> command line, where to put the initrd, other arch specific rules etc
> etc) UEFI already supports both ACPI and DT boot

After one night thinking, I agree with Ard that we can use RISCV-style
fdt to support the raw elf kernel at present, and add efistub support
after new UEFI SPEC released.

If I'm right, it seems that RISC-V passes a0 (hartid) and a1 (fdt
pointer, which contains cmdline, initrd, etc.) to the raw elf kernel.
And in my opinion, the main drawback of current LoongArch method
(a0=argc a1=argv a2=bootparamsinterface pointer) is it uses a
non-standard method to pass kernel args and initrd. So, can the below
new solution be acceptable?

a0=bootparamsinterface pointer (the same as a2 in current method)
a1=fdt pointer (contains cmdline, initrd, etc., like RISC-V, I think
this is the standard method)

Huacai
