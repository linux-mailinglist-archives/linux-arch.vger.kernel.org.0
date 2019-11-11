Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF8F7177
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKKKK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:10:29 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKKKK3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:10:29 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N9d91-1hrUX90ShR-015dsV; Mon, 11 Nov 2019 11:10:26 +0100
Received: by mail-qt1-f171.google.com with SMTP id r20so986965qtp.13;
        Mon, 11 Nov 2019 02:10:25 -0800 (PST)
X-Gm-Message-State: APjAAAWp5mGPBDRxjUb8bwZW7YbOkDgA+TyCfkBGKpjv6I7pRTPXR3/j
        Kh4e/mRyKtOkUzL4PHkZFeBwf2mZZFOa0iIQi10=
X-Google-Smtp-Source: APXvYqyqP0GEnKlLDcc3YXGxYPpIsc43oy+/l9orRIfJHYpq8HDGEADC0l7WhZk0kMzg516CeAScWIBjk4MnQDDCwV4=
X-Received: by 2002:ac8:1908:: with SMTP id t8mr24584774qtj.18.1573467024165;
 Mon, 11 Nov 2019 02:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-13-hch@lst.de>
In-Reply-To: <20191029064834.23438-13-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:10:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a28UDPEP7Bqu_wEXsfwSpT-5i30STB2iX3RfxdvbfzrNQ@mail.gmail.com>
Message-ID: <CAK8P3a28UDPEP7Bqu_wEXsfwSpT-5i30STB2iX3RfxdvbfzrNQ@mail.gmail.com>
Subject: Re: [PATCH 12/21] arch: rely on asm-generic/io.h for default
 ioremap_* definitions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ry3F/dh+b1z3bnsQ+UBRP9D/K3Mz/7Ju4+2xCL86KzNyw2dTCJf
 e9poGQj3rifB+4n2zHUDJR2bT4YBOZ99Ww6lJ803taaMFYDciQmV7FBTtmlnWKZqiBGj5at
 xlipTkzdIa6iP21zusJMcEKnGQf9+zy8gzfdg+2sjrbPSEMbDVj19UGoKuTfSje6z8ZYhnD
 ztTAx0Fuyk4d5lLeNPgSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uDzvIBywqVo=:3NpQWLViLFRhGeSVNjkbVY
 Bwz6nPtittmtPBWklwQCfn5DpZ1HcX98NVE3Fn1q2B2RD4WAkJnlaiA3JHdhIzauhME8vle9G
 33Ay/bZbzOJJEKTyGZrZ9W6ajRHTwpyq0XZV00s4O31g09K4JSX5sXn1563Zz93AFYvazL6GV
 Vv2ICs6jv/cng1C0JHN9DTj3z7bPgkPs75LD9UXqdymZiYp1+pujYFFAjPdDxFzC76KPfcUak
 xne2EaAtgIdTVQFNpaEPZt57Yv28urArJyhIkWs2BSoa77QBEqgFg7ufYyNHeG7LEu2RKJ4fW
 6xEUwWzi/eWOD9g1M50df33LH7f0YLK/BttLQGj1qVrWHexRf/vCBKFQq04KzPraSoC8AF95x
 NWR+Wg1P1YjimlNUBgtcL76eyxjpx88jTKMpXnGY5ErgfUruZdb7J+5hfGwUNPBJwZ7Y40oxy
 wCYU3cziQehzifLVXSFDk/ZjJD1qHXMlhu5zqUUT6QPjWLYhcLXA43bemDyJYSk3ESr3PKqkC
 GkFCWrY7fG06OtF+5sDLpodKZ9RKp2yrF4GeMYfcjn1WFNenNOIu6AhF+HMUhYXS/KJwkjOtc
 H6IAQenCm1dMZMCdiAZcWCSETV/UwPa0Y+Wx7HIcdP9aX/l0dbdvEwVXbT7hhXvDaZHJvBgm3
 cGh/KwAHc9HoQezFUqzo/vDPun0t3sVSib0KWzgAFE/VgOR7Qb1FBPvQdssc22H3pr5eKDUAl
 E83zpJ+wouG9+G4GHJMlZB+sII/FSGh8HFAvEQRvZnacNwx2QfEENwQTJxdwoMzZ7xBLzlg2w
 j8QbhO3/ij/s9reO7VdEGCb17ZSrquutOrhUYwe0r5ac/LBgmzRFRND12wjrbDUM6SNrsmotw
 FhTjtkwvwKbFmDXOEGUA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Various architectures that use asm-generic/io.h still defined their
> own default versions of ioremap_nocache, ioremap_wt and ioremap_wc
> that point back to plain ioremap directly or indirectly.  Remove these
> definitions and rely on asm-generic/io.h instead.  For this to work
> the backup ioremap_* defintions needs to be changed to purely cpp
> macros instea of inlines to cover for architectures like openrisc
> that only define ioremap after including <asm-generic/io.h>.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
