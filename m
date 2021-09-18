Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C8B4104D2
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 09:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhIRHia (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIRHi2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 03:38:28 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20894C061574;
        Sat, 18 Sep 2021 00:37:05 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id v9so7572570uak.1;
        Sat, 18 Sep 2021 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzhfRJtsewrJy9gvg3PVALM7qiexBjbh/6ESbF9yAmQ=;
        b=i1MTcAD9UnYWPlpu2z9dz7O9pjlQi/vuAb8G6J7B83k+RiE8sojZ6LvZ09CgoUK9n4
         LczbRL08HgiCe6YvEYzMEkXDh1Q0J6Jk4GWLqVgxj1Zsl2mmDINOHcH8tljgjekYyuja
         wbCP62A2N6pG33G7GTvW5WMKXBJcNSykuLc68szTgl3hBj0vHo3E9/Zrank8lIIdBfjG
         oq7az9SaGonnHEdklABpvcpHh9cJebxCySh26hjrimvfq6LvmneliPGe0KzLyvCsp6eT
         j/JPRVOpE7YO6zUAsiaElas3DlU350eVSGokG8rpu5d8vz5qH8YDH2eKKlIpOecW7U60
         H3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzhfRJtsewrJy9gvg3PVALM7qiexBjbh/6ESbF9yAmQ=;
        b=UaFj+DX7cbkzfu3IVa6RUpB2tvWMzJTrkTAmI+nZ8Wg6zPISx/+jDXpZf6gHfEZhEy
         +Fdl/TtptrfqdAHQ+q8dtog9n22yzOLutBpADpWwU1ZuaVmlAzRvUcjbrCwVl63892AX
         B4VpZ6aBTVvkkpDDRy87U5zAIw3dn83A23PUvSCteT3Fvx/VvwPdjqkt008VD/XKJxsI
         pEVXhqB02VmHC5eKcoVEmuVN1RrI2y+iemTWdFVGG/UT74ju36SRvzXVSs6mpsU+Un4U
         IZxHHugNSK6xMlldo7xJS99Nn/nTHRNe5lQrokhyMz/4Pa2yPqTcRtyp+eDVeucmAIZl
         s5Ew==
X-Gm-Message-State: AOAM531zpCIcGDoGMcljRfa5sNikGEf2Ca3sOomKnEFz8v+evbEOn+41
        ZaW3deQSf12M64HhZI1nk73pupKF715JcxQqHjs=
X-Google-Smtp-Source: ABdhPJwi5zes5aLNI68EPqG8s32AnHOL7SpWjSiidkZRKZ44MpDEG9d4/Z3v+a0xOXreS8EF7zbs/z9Lh4RJ9M+id+w=
X-Received: by 2002:ab0:31c1:: with SMTP id e1mr7426551uan.132.1631950623485;
 Sat, 18 Sep 2021 00:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-19-chenhuacai@loongson.cn> <CAK8P3a26CGyiZ9y7KxHGu6eHXZJ08X4mospr+3CL8g_qi=ACpg@mail.gmail.com>
In-Reply-To: <CAK8P3a26CGyiZ9y7KxHGu6eHXZJ08X4mospr+3CL8g_qi=ACpg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 18 Sep 2021 15:36:52 +0800
Message-ID: <CAAhV-H5=Ut+rymv1RH+1GVS2oVZogtuwY_Sk-dDosJh6=USr0Q@mail.gmail.com>
Subject: Re: [PATCH V3 18/22] LoongArch: Add PCI controller support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Sep 17, 2021 at 5:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> > I/O bus, This patch adds the PCI host controller support for LoongArch.
> >
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> As discussed before, I think the PCI support should not be part of the
> architecture code or this patch series. The headers are ok, but the pci.c
> and acpi.c files have nothing loongarch specific in them, and you clearly
> just copied most of this from arm64 or x86.
In V2 part of the PCI code (pci-loongson.c) has moved to
drivers/pci/controllers. For pci.c and acpi.c, I agree that "the thing
should be like that", but have some different ideas about "the way to
arrive at that". In my opinion, we can let this series be merged at
first, and then do another series to "restructure the files and move
common parts to the drivers directory". That way looks more natural to
me (doing the other series at first may block the whole thing).

>
> What I would suggest you do instead is:
>
> - start a separate patch series, addressed to the ACPI, PCI host driver
>   and ARM64 maintainers.
>
> - Move all the bits you need from arch/{arm64,ia64,x86} into
>   drivers/acpi/pci/pci_root.c, duplicating them with #if/#elif/#else
>   where they are too different, making the #else path the
>   default that can be shared with loongarch.
>
> - Move the bits from pci_root_info/acpi_pci_root_info that are
>   always needed into struct pci_host_bridge, with an
>   #ifdef CONFIG_ACPI where appropriate.
>
> - Simplify as much as you can easily do.
>
>         Arnd
