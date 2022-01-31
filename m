Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168184A4782
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiAaMtV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:49:21 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:41787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbiAaMtT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:49:19 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MzQc2-1mJ6320Q5o-00vQEz; Mon, 31 Jan 2022 13:49:16 +0100
Received: by mail-oi1-f176.google.com with SMTP id v67so26377549oie.9;
        Mon, 31 Jan 2022 04:49:15 -0800 (PST)
X-Gm-Message-State: AOAM530MUhJjxHs4lN8uEOaSb8M+hbaDjaI0XH9LOJMiEFS5TJs59mvW
        WWl2KRm09sLPH3x0egJ0DrXHFNU9MZs6JEah+R0=
X-Google-Smtp-Source: ABdhPJy98n+kDWK/9SbbjWdkcIPv//3sxAoIsXTByqyfuSFCJCabGM0ZH14kpP64umFfYvpncQnk8rPRUpmA1wB2kjw=
X-Received: by 2002:aca:2b16:: with SMTP id i22mr15607147oik.128.1643633354113;
 Mon, 31 Jan 2022 04:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-6-guoren@kernel.org>
 <YffUqErSVDgbGLTu@infradead.org>
In-Reply-To: <YffUqErSVDgbGLTu@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 13:48:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1jZyVBW70K6_u3mvXYNowV4DTBxivKc2L=HbRK8SgRXg@mail.gmail.com>
Message-ID: <CAK8P3a1jZyVBW70K6_u3mvXYNowV4DTBxivKc2L=HbRK8SgRXg@mail.gmail.com>
Subject: Re: [PATCH V4 05/17] riscv: Fixup difference with defconfig
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:djGQj121T/Up79PV9vFe3c3xFVYWtTtn038P31Wi6YWVhZsb7CH
 EWUc8VlWcickQHCTaodxi2PwS/49NtPQkRJKgVjui3yT2gl4ORQlI1/MiZXJMdpsdD1aZSh
 j5i7ILCBXXo9S6BeA8TxrAWH0lSCHoAJ1aoJOV69A1zT/H8uT9VxlxySVe4GNFkBrMXjAwW
 wzeiuGQ17BqnsLNJLNKtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZH5LM8F2Bio=:iB3XsXNdUOq9ydk/56//Ap
 ygzKiwd747DPcnWv4JephLLgjcJN/oPQ/nOfySsB/xbDPlB3cme3km4ROyqlWL0CAVzcs01gs
 RhEc5wZoQCuocaDBY/qh20LWX2XgmGzstKMoAdLEJpwDT53xv8/RZzSW1GOS5Ugq/im3mCvEP
 t4j5XvKwXkMuCt0yyWB4fzMIHX/fnyXoT+dt+B7l+hhIw/oFU/O9gV61t0DKpi/9smj22Y0d1
 v1oPXyfkmDoaIclTGygnc9Iu5AcT89Qf7PttG5zsjj6vua8yFCX9thdOTVDI+19rYkmfPD+IN
 CI4fCNvJqDHpArJ9q+d2w6qas4y9eYU9m2jSZu8pheXxCXJBoVhr0op0VwZJ2P8PNYGaYTPW+
 W5W0FzRhsp45xn9G9MVN6/oYQqpV6x8bv8Fi5tTJJ2g4HGsrOc+Md3MvCq88yJiu3uJyYAvsP
 uj1k70QZ4sl7dZpP0p98gD4i9GdncRnk96Mb7jvwt7yt+C05GKbz2rIpxoahiYoStdl0KPenj
 ucYkY65kz7E9mad2H20UiA6Z0348ukzyAmSTaHzS+Mbi8en47i8/WPi3NYlm2duFIsOK2eX2f
 luBlpwT9r5ZQXCXE9s1U7Y8NpBQ79ly7U58oJrc/yU7qmgZtlHLPeRZzObbFxQeWXk/hBBSjF
 iF4lRgIU1qcoUDvnIBgDGwlnfObta2XyKhMT+GSJCXhTEHcoTIpfMR9aPYWV9B7+vvgxkbt9a
 PDLwoWE+daaBhoHuyu7RQcNCXR8OxUI6Zldek/DhFHJjlXS3IGAEOfj+FUryc+sQks/wVfX5L
 3swFfq8Q/1DJJigRwhmxaY/F702+y0FrL+2b4Ijbzh0YjQOMco=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 1:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jan 29, 2022 at 08:17:16PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Let's follow the origin patch's spirit:
> >
> > The only difference between rv32_defconfig and defconfig is that
> > rv32_defconfig has  CONFIG_ARCH_RV32I=y.
> >
> > This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.
> >
> > Fixes: 1b937e8faa87ccfb ("RISC-V: Add separate defconfig for 32bit systems")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
>
> Wouldn't a common.config that generats both the 32-bit and 64-bit
> configs a better idea?

I thought that is what the patch does, there is already the normal 64-bit
defconfig, and the new makefile target makes this shared with 32-bit
to prevent them from diverging again.

        Arnd
