Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EDF35C352
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhDLKGY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 06:06:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbhDLKER (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 06:04:17 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MuVOM-1loFLz01qc-00rWKb; Mon, 12 Apr 2021 12:03:57 +0200
Received: by mail-wm1-f44.google.com with SMTP id k128so6440219wmk.4;
        Mon, 12 Apr 2021 03:03:56 -0700 (PDT)
X-Gm-Message-State: AOAM531QjEsrwvzo/ViQ7GZGLyabLL5Js0s9lXjecqMatmBYUrfhHuFF
        SzbAsw1huoXQb1ksna+WznNd6KJvx3GhtZTGezI=
X-Google-Smtp-Source: ABdhPJz1GJVeZO+sIN2KpJ8Wn8donSpdvAqFqtcymRYAYBYot2xnOavBT3UwXj8nuP92Z994bQxnP3scv1qVkv9AVF0=
X-Received: by 2002:a7b:c245:: with SMTP id b5mr25489890wmj.120.1618221836576;
 Mon, 12 Apr 2021 03:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085545.2595431-1-hch@lst.de>
In-Reply-To: <20210412085545.2595431-1-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Apr 2021 12:03:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a38qgkjkh4+fDKp4TufL+2_W-quZBFK9pJFf7wXP=84xQ@mail.gmail.com>
Message-ID: <CAK8P3a38qgkjkh4+fDKp4TufL+2_W-quZBFK9pJFf7wXP=84xQ@mail.gmail.com>
Subject: Re: consolidate the flock uapi definitions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Dps70YksbRgOOYYzitLBwIiCvjUaqq0PzQS+9jryUR6sjkSkzVi
 Z5OdoVhP6elJGW3hcIXNuO1pVfwf0DY2PQq2XGmGGpGQf0h3WYfeQNSzz4RyoAzn2nLUdi3
 HLXh4VNf//zZZY+ByCodtcDxii+Ub+aXpmA1MEz/PcbTvEmqetuufSlyyeC9Nx+tG2meNjd
 8OfTdzjQDEOdC3hGC8npA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JhsavkM/5Ss=:zkobLlRXkmjwTPYUdZkJDb
 mSXH7ktDlvbeTu7s4XAi+ZEsVEIGoyifakHVvcjbyMDUUyK2xA9M02Pl/BwMO3V2HaNxWHt7z
 8U9qseI2Klq3RHfhWG26prOb4sr4W6389IdnAsBejgdHDXQD/PRwrfXTEYKKz/Z2E7zWmCu4c
 sHcOwsuK/eiePNjk0Qxa97bMfRVKxBXL0L/OkzTiZoclCu6nIeVtrHUGh3liWhJKEVDOBxd1M
 BA+MiE61AYUn/GGSVqEPHlYOtF4nl0q6Mau9R715BKfSmZG5RnX7eu2BODFsAp57J4ishaFu7
 viaB4JWPJuaCQWIGkYV9i3HkWX5N3mc9oZS8hFuRTx7INh3piBzlbT0S7Z9P9vHSwd6lb/Lhn
 r960oHG3wwPcZ/ZNyc5kq684fblqsxyHkdstht2U3CAiMesJCap/F7Cu8GraDA3H3Qs7Ocwnz
 ibs7wtfqsiy+31P1CJM+UBD38kMz1JKVfDn2e9vTtXKaDGkIdG3pxYe98rvuujxFgRWYSJItU
 Fc+5ChUDNRSqhhYtXNWsbcxlstvJKRF/iTkjJuyqHn+wlhvUnhLxMk1hqcWAtgRwu8zL+nDJr
 lOnhA2dVZfA5LQTR6ITJLp2MA17khRjqCA
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 12, 2021 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currently we deal with the slight differents in the various architecture
> variants of the flock and flock64 stuctures in a very cruft way.  This
> series switches to just use small arch hooks and define the rest in
> asm-generic and linux/compat.h instead.

Nice cleanup. I can merge it through the asm-generic tree if you like,
though it's a little late just ahead of the merge window.

I would not want to change the compat_loff_t definition to compat_s64
to avoid the padding at this time, though that might be a useful cleanup
for a future cycle.

        Arnd
