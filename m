Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96659516329
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiEAIu1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiEAIu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 04:50:26 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2A1E21;
        Sun,  1 May 2022 01:47:01 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id z144so11244346vsz.13;
        Sun, 01 May 2022 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeMrQTzuf2gRQtezWWafNVYSaUpuhBePEKDtQvKbaWw=;
        b=nWh9yV+kO8Q7Dem2PHaKx8kspjOWTvEYLzCFQFjnTu9qQQZQQqV7uGUKn2xK8RCOYV
         d29tKQlPggdptI+tPVWVkzfGVc6V5kujnWIFhshwWyTcSz1yCQQBQHznRNadgkgEK0Zn
         D8vgLMcPz5JIWDfHoJ7z5xaL8L2WVzlV9m56y/JLyPI0PjUBWD3YArgx2hQ6bmr8KL8x
         +uMkSzcr4RYR6554+4w5GjQHnZGzWWDBloOWQLCA30h9Nec7T+WotqVGq/5yZmNdrFHo
         URtDSAZR7mq702SxWU4FCHnTJ50bbyjW0Cc8u1e3GRSepWLfipSkHFaZ1Z4O3HaMt/2/
         znwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeMrQTzuf2gRQtezWWafNVYSaUpuhBePEKDtQvKbaWw=;
        b=Njuzf94AhD0aFKOulVhpdy111O+AYNpF8cUIzvB/jdaaihpGbttOtrDvYbMPVTyVIC
         fJlObXCa8QvjZJ5/oiuEForvhyUVsmvFM0uKCBPfwp5BZCw3pi4GDtNvu5U5ayf+jA0x
         fvHK37KghfmoKXPtYvh4juuADPo6BYMnbFMSja6wk5UfVPy2hGQ/pz0r+5GLNI/Tw2VS
         hGrufX/YZ4+qEBmwl/40o2kqMrbzxofICE/Q11pGq1PTRNDHjFJC9uuKV+a3jB5QJsZY
         ei8+UpnEbwInCLUNc1anAllzNT6i+KZZN8eflNfNlK/zIj33sCZWwoN3+QkcSKGWXuWW
         mE9Q==
X-Gm-Message-State: AOAM530c25VtSKliUbUYvEIJGg/4yAdeNoaIS+Z9gE8VtyNqTV9ycacW
        kqSa6AHItWxS/hWOzJ8ht6XizmV/8dRVUlaoD2c=
X-Google-Smtp-Source: ABdhPJx9y9y0akz5HssQ3SXny9Vs4F60zx3/tiArR/BWCv18jYhs2liGZ4RSuGtueeNr/xqIkWAfYTXzJMlwfI//47k=
X-Received: by 2002:a67:b142:0:b0:32c:e806:a0b0 with SMTP id
 z2-20020a67b142000000b0032ce806a0b0mr1758746vsl.71.1651394821045; Sun, 01 May
 2022 01:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-22-chenhuacai@loongson.cn> <CAK8P3a0LwJ3mMQMFkxGxr+umCMM3dKGRnLF+dMCmD5j43hq2sA@mail.gmail.com>
 <CAAhV-H6vPdLeup38YTj64Xxxk+PTact=DMJTs9efsa1b3t-y2A@mail.gmail.com> <Ym4qNILcz+W7dC9i@shell.armlinux.org.uk>
In-Reply-To: <Ym4qNILcz+W7dC9i@shell.armlinux.org.uk>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 1 May 2022 16:46:50 +0800
Message-ID: <CAAhV-H58HXicH7jj88BFUH8P9cGwXFGjgOoLvZubQsBst+zheQ@mail.gmail.com>
Subject: Re: [PATCH V9 21/24] LoongArch: Add zboot (compressed kernel) support
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
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

Hi, Russell,

On Sun, May 1, 2022 at 2:35 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Sun, May 01, 2022 at 01:22:25PM +0800, Huacai Chen wrote:
> > Hi, Arnd,
> >
> > On Sat, Apr 30, 2022 at 7:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > This patch adds zboot (self-extracting compressed kernel) support, all
> > > > existing in-kernel compressing algorithm and efistub are supported.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >
> > > I have no objections to adding a decompressor in principle, and
> > > the implementation seems reasonable. However, I think we should try to
> > > be consistent between architectures. On both arm64 and riscv, the
> > > maintainers decided to not include a decompressor and instead leave
> > > it up to the boot loader to decompress the kernel and enter it from there.
> > X86, ARM32 and MIPS already support self-extracting kernel, and in
> > 5.17 we even support self-extracting modules. So I think a
> > self-extracting kernel is better than a pure compressed kernel.
>
> FYI, kernel modules are not self-extracting. They don't contain the code
> to do the decompression - that is contained within the kernel, and it is
> the kernel that does the decompression. The userspace tooling tells the
> kernel that the module is compressed.
I call "self-extracting" here means we don't need out-of-kernel help:
kernel decompress doesn't need the bootloader, module decompress
doesn't need kmod.

Huacai
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
