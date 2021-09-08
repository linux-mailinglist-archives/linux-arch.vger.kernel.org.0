Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8520D403DB1
	for <lists+linux-arch@lfdr.de>; Wed,  8 Sep 2021 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbhIHQlC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Sep 2021 12:41:02 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhIHQlB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2021 12:41:01 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3KY0-1n6JVi0rT8-010J9B; Wed, 08 Sep 2021 18:39:52 +0200
Received: by mail-wm1-f50.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso2039588wmc.1;
        Wed, 08 Sep 2021 09:39:52 -0700 (PDT)
X-Gm-Message-State: AOAM532lY59uhw2CD4YrYHCju6NaEhgPtFdARG3F+Ogw7TU/xiVihlCy
        NhdZY40C3jHgrpz9fdX4+yekrS3RS4TubYLCIh0=
X-Google-Smtp-Source: ABdhPJygLbAV1O++eZTy9bBrdpRiAiZXAExciyZLR3foDhTt5ltA83GvOutTXtyrXYqqnj2WlhKJXnpq38G+Hy/AAr4=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr4649512wmc.98.1631119191859;
 Wed, 08 Sep 2021 09:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-19-chenhuacai@loongson.cn> <YTjbaz7iea1kwGYb@robh.at.kernel.org>
In-Reply-To: <YTjbaz7iea1kwGYb@robh.at.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Sep 2021 18:39:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3sY63WN6Mn6_xNqDYmdhv1PN6CFRfQGNDRO4dHtSjE7Q@mail.gmail.com>
Message-ID: <CAK8P3a3sY63WN6Mn6_xNqDYmdhv1PN6CFRfQGNDRO4dHtSjE7Q@mail.gmail.com>
Subject: Re: [PATCH V2 18/22] LoongArch: Add PCI controller support
To:     Rob Herring <robh@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D4ML/KuEqRIMH2+RWywi41BulaoidEQOnG2/RPY3e2Zf3BL4s3D
 MK+V9AVzBM9IosDnJa5YonYBsbRgon6zLA15o+su/qP3P6trQeuj1Jc2ECvLrWCjJ23D0g0
 KVDxCM/OOS3tf1F64lkCh1GQiCS/+acWShfJ34NIdmFsmty1lep24YG4Wczm/Ph+1znqf+i
 Md6QUM+YBPBGLLsUMjCcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8FB2gObK8JI=:PsQ0UzgrbS/SznN0Wv6IPu
 giH3ftEOIV+JEXcARCkVpxWXkGgQHQis5eT/fPRzl11wz6eQBdFJRbkxrbFer1V6ldyVkEmBT
 D4RzjfBsDyp14mb4+ElSNlTUO0LDRwXaOdxOVHHVyPGIpWlZDHECyvtXBJyitGiX+EomdP7FI
 /kMfpn+rZO81+EJGcUxhsOwh5fYRGXwkEc2ANR30irMwwIIX93tnWm5pQm9olRf/NUTrgg29N
 Zk35MU8VBqB0cx537RpX72YufKV0R62d+Dht4ApZ5YGrg70r6f2rMbsOBfFfHTTXHNMHjijoi
 CA+12Wws5h2Rbkm7U95vcgP/aGffnLMebGSBh8go4IyvUPw7NheCGvkdA2x4ihdAOjSiO72Az
 e234gYyYnhrUu2T5EGN7d3jAyrmUkaxx8oXz0U8wMSXUi4uPn84X8C5Xd03dlbEqDRZPLRUFL
 L64iH1s8v3pMOqIO4ha9HuAUb4iKq8GtjfZ8H6FShRF+n2dI91LP03fl+WDM/4IMb85sKmpKW
 58/j8ddnwTAfZjMhTotwdbycNv0thGh5WS1/cunKb/4oAMz+rqVmBU0Up9rH5IsnK6VXn2swR
 C2b3pFZEk3jVMAYzsZSplFwH/cP1uOwgSmy3oP2LwnCXVsYf+s94AIxU0H5yNmdc411ZZMXz5
 fFKZT37egj28eGZvZ5SI0XukIZ2R8vbBKea9unq/gxYFFGn50P2bgUEKO/6VtqGjjHfLXpVf+
 ci1MaZuxHFOouWjkpCgmPi+SX+hqmGjP+JXGlQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 8, 2021 at 5:48 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 03, 2021 at 05:52:09PM +0800, Huacai Chen wrote:

> > diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
> > new file mode 100644
> > index 000000000000..d6e2f69b9503
> > --- /dev/null
> > +++ b/arch/loongarch/pci/acpi.c
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0

A lot of this file appears to duplicate what we already have on other
architectures.
I would suggest moving the other architecture specific code into
drivers/acpi/pci*.c and share as much as possible to make it easier to
make modifications in the future.

> It might be time for default implementations here that can be shared
> with arm64. The functions look the same or similar to the arm64
> version in many cases and why they are different isn't that clear to me
> not being all that familar with the ACPI code.

I think it can be simplified quite a bit if we restructure the acpi pci
code to behave like a normal pci host bridge driver.

> > +
> > +/*
> > + * We need to avoid collisions with `mirrored' VGA ports
> > + * and other strange ISA hardware, so we always want the
> > + * addresses to be allocated in the 0x000-0x0ff region
> > + * modulo 0x400.
> > + *
> > + * Why? Because some silly external IO cards only decode
> > + * the low 10 bits of the IO address. The 0x00-0xff region
> > + * is reserved for motherboard devices that decode all 16
> > + * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
> > + * but we want to try to avoid allocating at 0x2900-0x2bff
> > + * which might have be mirrored at 0x0100-0x03ff..
>
> Is this something you need to worry about on this h/w? arm64 and riscv
> don't seem to need this. If you do need this, then shouldn't everyone?
>
> Don't blindly copy code unless you know you need it. If multiple arches
> have the same code, then that's a sign of blindly copying stuff or a
> need to refactor into common code. It looks like some things are just
> copied from MIPS. The MIPS arch code is a mess and not a good choice to
> draw inspiration from (aka blindly copy). Pick more recently added
> architectures given they will more closely follow current rules as to
> what maintainers want.

It's certainly not architecture specific at all. Maybe what we can do here
is to have the most common implementations provided in drivers/pci/
and then have the host bridge driver pick one of them to match either
the current behavior or whatever we decide is a good default.

Ideally we'd want only one implementation, but some of the older
host bridge implementations may need to be more careful around
ISA bridges than the newer ones. Making it depend on CONFIG_ISA
might work.

> > + */
> > +resource_size_t
> > +pcibios_align_resource(void *data, const struct resource *res,
> > +                    resource_size_t size, resource_size_t align)
> > +{
> > +     resource_size_t start = res->start;
> > +
> > +     if (res->flags & IORESOURCE_IO) {
> > +             /*
> > +              * Put everything into 0x00-0xff region modulo 0x400
> > +              */
> > +             if (start & 0x300)
> > +                     start = (start + 0x3ff) & ~0x3ff;
> > +     } else if (res->flags & IORESOURCE_MEM) {
> > +             /* Make sure we start at our min on all hoses */
> > +             if (start < PCIBIOS_MIN_MEM)
> > +                     start = PCIBIOS_MIN_MEM;
> > +     }
> > +
> > +     return start;
> > +}

Same here.

        Arnd
