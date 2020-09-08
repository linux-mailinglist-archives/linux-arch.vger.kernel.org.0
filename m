Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871E5260B76
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgIHHAa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 03:00:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38496 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgIHHAA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 03:00:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id y6so15523657oie.5;
        Mon, 07 Sep 2020 23:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80BY8rNg7RfD6oxznXYOKPcFZuo8wajfOpZ0OBeC/wY=;
        b=RqGXWXZ9/kAxQAFSyuC5kqinD3ki4bRUdQCvuUBMdUD+NSJ4wf//toLW3N6/2xpWSI
         4xYPmSVXo1d4QZZk7IbFC372rxSH8PBVawRiRmYmwmipDSgE19hyBXsbXcUclHUI7zhl
         baOaiGDUTAQSKJepnGQgdAa71SHWFs5ktn6Owkl/dVgnAwDE0Yz16m3t3Otw8iiLvA7r
         CxoqGaf4XmBlVdiZIWvC/J3/bykpfrW+9BIwzaOWT9jAjEWmqwcneAleIhN/4ca92NUu
         mF/SikMkKKHBiGthrYmeN29uidszA6oEUywvueO8kr6U+rF9Nfnl7SC9t9AToy4lr9RO
         qjcw==
X-Gm-Message-State: AOAM531m5uxK5E5rDhrG78duUtGRrc4iSEER4Gv4Q5UXuKJPX0Br0eRo
        eu2XDYFr4nVHkqJ/t1i+cPoDfVotTwO2ijrL7sI=
X-Google-Smtp-Source: ABdhPJw+Sdn/Kf/NbESMrEGT3ykKzS7L5e1uWHMt5PE98XyXUrM0snkLRMMoZ/Q/NW5lb7vt9j4vz11Ltnr3Qr8PC/E=
X-Received: by 2002:aca:b742:: with SMTP id h63mr1711017oif.148.1599548399253;
 Mon, 07 Sep 2020 23:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200908042708.2511528-1-masahiroy@kernel.org>
In-Reply-To: <20200908042708.2511528-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Sep 2020 08:59:48 +0200
Message-ID: <CAMuHMdVobzKWKnN0ScqSY+Jv3N1ri8=mWEd-SZfH5+je+CVVcQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: preprocess module linker script
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        Jessica Yu <jeyu@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 8, 2020 at 6:29 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> There was a request to preprocess the module linker script like we
> do for the vmlinux one. (https://lkml.org/lkml/2020/8/21/512)
>
> The difference between vmlinux.lds and module.lds is that the latter
> is needed for external module builds, thus must be cleaned up by
> 'make mrproper' instead of 'make clean'. Also, it must be created
> by 'make modules_prepare'.
>
> You cannot put it in arch/$(SRCARCH)/kernel/, which is cleaned up by
> 'make clean'. I moved arch/$(SRCARCH)/kernel/module.lds to
> arch/$(SRCARCH)/include/asm/module.lds.h, which is included from
> scripts/module.lds.S.
>
> scripts/module.lds is fine because 'make clean' keeps all the
> build artifacts under scripts/.
>
> You can add arch-specific sections in <asm/module.lds.h>.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Jessica Yu <jeyu@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>

>  arch/m68k/Makefile                                     |  1 -
>  .../{kernel/module.lds => include/asm/module.lds.h}    |  0

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
