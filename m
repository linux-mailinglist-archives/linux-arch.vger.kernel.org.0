Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7B04C6A98
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiB1Lfx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 06:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiB1Lfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 06:35:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2671170F50;
        Mon, 28 Feb 2022 03:35:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A0060FE9;
        Mon, 28 Feb 2022 11:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213E3C340EE;
        Mon, 28 Feb 2022 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646048112;
        bh=VpTjIs0hzrsh4I+aITjeOAjdM8laTn+iFKqS4LFINDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mqgIqLbwn4DE7AUflvIxC2VCB0cBn04sKV3turceRE7FJxkvalo/Ps8mQOvPkaIPi
         onbBtSjuukfUeezamG9+N3d2q31NSR0OIcGmIIgooQPqALYvdNwZdYS4QNprwy0f1P
         dqvW19r2tUVjJozQc2aQpbthWqbrUeV0X/9cdI2J5gZwCfqrMKZiUmBxrp7VD/xwq8
         r37BFg1rfm/7mOxfT5QeX7dRCm9epHLXYbVGnE3MmxsbFVC6KmL/P2L2wUqmC2l950
         NQGqk6f2NtJtpYOby2B5XjRqBmkIh/5ckagRgTorRyHWt0708tI+QrD8+6BR2lyXWr
         1sfra8hptDKrA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2d6923bca1aso104357787b3.9;
        Mon, 28 Feb 2022 03:35:12 -0800 (PST)
X-Gm-Message-State: AOAM53132M4C3SyRs58icHc/oH631bzuitDzcW06idzgYOJL7lCSGwF9
        ZcdeQomRHuxKtpPrrrLdY/w6cSBo3Dg/zUJYoAc=
X-Google-Smtp-Source: ABdhPJzeZBINIQtry8Kod9X4OGCGJqVlzDuJJm+hJ2c9FJIoJY+hDBsmwi5R/tmFrZAY7e1rGzq6goH4on8pCVQlJTk=
X-Received: by 2002:a0d:d482:0:b0:2d8:1555:e21d with SMTP id
 w124-20020a0dd482000000b002d81555e21dmr17717213ywd.272.1646048111201; Mon, 28
 Feb 2022 03:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
 <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
 <CAAhV-H7X+Txq4HaaF49QZ9deD=Dwx_GX-2E9q_nA8P76ZRDeXg@mail.gmail.com>
 <CAMj1kXGH1AtL8_KbFkK+FRgWQPzPm1dCdvEF0A2KksREGTSeCg@mail.gmail.com>
 <CAAhV-H6fdJwbVG_m0ZL_JGROKCrCbc-fKpj3dnOowaEUA+3ujQ@mail.gmail.com> <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com>
In-Reply-To: <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 12:35:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHGG80LdNUUA+Ug1VBXWuvtPxKpqnuChg2N=6Hf2EhY7g@mail.gmail.com>
Message-ID: <CAMj1kXHGG80LdNUUA+Ug1VBXWuvtPxKpqnuChg2N=6Hf2EhY7g@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
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
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Feb 2022 at 12:24, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Mon, Feb 28, 2022 at 4:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Mon, 28 Feb 2022 at 09:38, Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > >
> > > > > RISC-V is a useful reference for the changes needed - this is the most
> > > > > recent addition to the EFI stub, and avoids some legacy stuff that new
> > > > > architectures have no need for.
> > > > We still want to support the raw elf kernel (RISC-V also does),
> > > > because LoongArch also has MCU and SoC and we want to support FDT (I
> > > > think this is reasonable, because RISC-V also supports raw elf).
> > > >
> > >
> > > That is fine. So perhaps the best course of action is to omit the
> > > UEFI/ACPI parts entirely for now, and focus on the DT/embedded use
> > > case. Once all the spec pieces are in place, the UEFI + ACPI changes
> > > can be presented as a single coherent set.
> > It seems that I made you confusing. :)
> > There are big CPUs and small CPUs (MCU and SoC), big CPUs use
> > UEFI+ACPI, while small CPUs use FDT.
> > At present, the only matured LoongArch CPU is Loongson-3A5000 (big
> > CPU) which uses UEFI+ACPI.
> > We want to support raw elf because it can run on both ACPI firmware
> > and FDT firmware, but at present we only have ACPI firmware.
>
> Can't you just use the UEFI protocol for kernel entry regardless
> of the bootloader? It seems odd to use a different protocol for loading
> grub and the kernel, especially if that means you end up having to
> support both protocols inside of u-boot and grub, in order to chain-load
> a uefi application like grub.
>

I think this would make sense. Now that the EFI stub has generic
support for loading the initrd via a UEFI specific protocol (of which
u-boot already carries an implementation), booting via UEFI only would
mean that no Linux boot protocol would need to be defined outside of
the kernel at all (i.e., where to load the kernel, where to put the
command line, where to put the initrd, other arch specific rules etc
etc) UEFI already supports both ACPI and DT boot
