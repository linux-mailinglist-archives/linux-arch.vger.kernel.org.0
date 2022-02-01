Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106154A5B7C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiBALsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 06:48:38 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:37357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiBALsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 06:48:37 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDhpZ-1n7T8P3yYJ-00AlK4; Tue, 01 Feb 2022 12:48:35 +0100
Received: by mail-wr1-f48.google.com with SMTP id l25so31377552wrb.13;
        Tue, 01 Feb 2022 03:48:34 -0800 (PST)
X-Gm-Message-State: AOAM5337alSkHOso8ztb04LTIOhfOC1iQM7mobRii/cqdBpOli0/c8A3
        GaGePdroAOl43B6NTbk4+LBSmelS/noDGQCsHWo=
X-Google-Smtp-Source: ABdhPJxO+OGO5lnSmsts+k8ffbEmh9/UtuFXn1dLVr5xpmsd+BH7cbCu5DpyTRvWDXlXMwgE6rWgsvPUd5Lt6roAGEM=
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr20737860wrg.317.1643716114442;
 Tue, 01 Feb 2022 03:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org>
 <YffVZZg9GNcjgVdm@infradead.org> <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
 <20220201074457.GC29119@lst.de> <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
 <CAK8P3a2C7nDGQvopYzi1fe_LWyosp8t9dcBsduYK5k_s_OrCaA@mail.gmail.com> <CAJF2gTTgTzvGfa3nGzVo4C=fe+ZCGBWp=VhTMRt1vF1O1bnS5g@mail.gmail.com>
In-Reply-To: <CAJF2gTTgTzvGfa3nGzVo4C=fe+ZCGBWp=VhTMRt1vF1O1bnS5g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Feb 2022 12:48:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3u8zo+MOOpDXaX8PY2ukN3J2VHnV8uDXQwc=0WgV6qFw@mail.gmail.com>
Message-ID: <CAK8P3a3u8zo+MOOpDXaX8PY2ukN3J2VHnV8uDXQwc=0WgV6qFw@mail.gmail.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UHJ91nYLgPvR3a1MTHODyCBRwHF+deKXorwP1xEbisGwDO0n+Qb
 iTyqI5iseg8msHay8+QxiRnmyagqpN7ZkkkKtvPxw1rCw0HADq0vjhWZ+bP2DoYqTgL/MUH
 0HCSWDUn+UqcdaZUCBURIhhkeSyTorJ0HyNtf15/sTfSovq76hlantcKsoDKuSYI6U1vQ0O
 OkRAIr8H0kFsGUBy15Psg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2q7iO32AAxM=:pbXre7T28QFWAizJwLyszf
 7xM+xQFpAnph5GWOxrBqbA9OKjamzUbluXgESzxds1fXOf5TcPRaTis2jiiR86DAt5FONkho2
 xfTUfD+dkWxbvHUUsnu1jaGEWVx9pGLnl57V+Qz6DraHtSfZR4hv7ij5tF4HoFe2DHvYLYtqs
 3kI26JDNoRHqHJdVJGcBjDjUPmRtv9jMcTu3E9JgyJiFd+ROWziGO7S62cNOKPYxWycUGdTGt
 +b9Stszi6ArRQNohK8TURusOBGJusX8gFlF+lUUG6fdokLgGdGAYy8oba3pIO/32+dTygTWDL
 yppQ6lyHaNRv8p/51O8ZIVIOSh4XALNa+15Og7cOd5042c1j1mBjdnaMfg7l9yceBGb1kqJ/M
 zl2NkQWCpmINIdLaZVpR0GckoH0+MFbwg3vyB59YMGZFc5gndtMFsVF4dnkeX2e5Nr1I83uzq
 8DNrEjICPzyQSgppxJTnNQF17QOmXWlW976mNYc53GVz3aETC2riMTGHtP4RU6RRc59g1sTJN
 LeGGDL+bV6jlkrlmqPRGOxqn+YTRr7Vrb4SGuR3nevIIb3Ro/bGCauoGGJ59N4DF6hUaKRbR8
 1+T03MZ6hdekdbvMmMRiieaFyo29JLy9yjV79VeYrqJgWAW3YI9/g2RXr5e99POm+VP/jxxUD
 iN7VTKPFuH44OG1BeY3GRRbTJFBaO38nVcZD3pKrC77jF1ymZfxsPRV0wQv5OozO5fa+wONje
 xESluvKC2E4jyrV4Hom6cp57FmkUbjdVI1wszq5z4XK7fdYPdsgjN9aOaOYJ8ma2hyX/OhLYG
 wE0heEFMTKjA6ml6NZeQnAFs9byV9eUs/iqrw8Gd9J1sk2Bsvg=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 1, 2022 at 11:26 AM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Arnd & Christoph,
>
> The UXL field controls the value of XLEN for U-mode, termed UXLEN,
> which may differ from the
> value of XLEN for S-mode, termed SXLEN. The encoding of UXL is the
> same as that of the MXL
> field of misa, shown in Table 3.1.
>
> Here is the patch. (We needn't exception helper, because we are in
> S-mode and UXL wouldn't affect.)

Looks good to me, just a few details that could be improved

> -#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
> +#ifdef CONFIG_COMPAT
> +#define compat_elf_check_arch compat_elf_check_arch
> +extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
> +#endif

No need for the #ifdef
> +}

> +void compat_mode_detect(void)

__init

> +{
> + unsigned long tmp = csr_read(CSR_STATUS);
> + csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
> +
> + if ((csr_read(CSR_STATUS) & SR_UXL) != SR_UXL_32) {
> + csr_write(CSR_STATUS, tmp);
> + return;
> + }
> +
> + csr_write(CSR_STATUS, tmp);
> + compat_mode_support = true;
> +
> + pr_info("riscv: compat: 32bit U-mode applications support\n");
> +}

I think an entry in /proc/cpuinfo would be more helpful than the pr_info at
boot time. Maybe a follow-up patch though, as there is no obvious place
to put it. On other architectures, you typically have a set of space
separated feature names, but riscv has a single string that describes
the ISA, and this feature is technically the support for a second ISA.

         Arnd
