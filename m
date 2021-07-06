Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3189B3BC967
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFKVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:21:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60523 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKVJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:21:09 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MSKq6-1lcXQk1LPE-00Sbul for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:18:30 +0200
Received: by mail-wr1-f43.google.com with SMTP id p8so25449083wrr.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:18:30 -0700 (PDT)
X-Gm-Message-State: AOAM530c8FDWZfwqI2lOPVPw6oYPZvDf2ppJiXp1dm3279C3kztvuY+h
        sNTRb/xu59MRXbZJAyjDj+m11UKm2zzE4YnqG3s=
X-Google-Smtp-Source: ABdhPJxNHkmLmXGOO/8FvJHNm4B4biB/wRRdj0bsldiZwekKlGulL4v8OhjBpjifcnRMdjB7Xn5RkQp0kEcRO4UmNQA=
X-Received: by 2002:adf:e107:: with SMTP id t7mr20931797wrz.165.1625566710070;
 Tue, 06 Jul 2021 03:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-20-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-20-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:18:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
Message-ID: <CAK8P3a2J+axpXoP_P+PApo90upUqn57=6_wY5RPZv6oNVV7oUA@mail.gmail.com>
Subject: Re: [PATCH 19/19] LoongArch: Add Loongson-3 default config file
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:llhN9c/mvVee+eym3wzyVdLjXAQlTk82topTE8saQlXPzx55UFt
 aC8wwl8TACUZWTG+wiHBrEYuaeOKI2wjgIvWD1Iq4+xrRLXkMDo9d0a+adjUriDKU3E2TWO
 2t/WdGLXwOQZUHya2tkSBH6RG85TwdZPc75HHloTqXdGRyGh0uFEUlriKOWdFCQUqbK5IWb
 7l+/WGhhUm4LFGPIICr3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EluYE6EqtS4=:KSOz4oyXPTCoJGziJbkQbc
 wEVZ1JFQIc4P7GWdepFejHxv1Q5tYLUkLqxSpjckPkDRQKLZbs7UnOclzuNhxpbzBI11F0NJ+
 bxnA/9NVP22U7p08qIPrKNmYk3jiT9aA/4PqCJzX5IUKlNqcCMfR2V2b8jY6yjoh0KZW9NsQM
 tLmKRxF5qy+zFO1PuHZ8PG22T8AtKHy3pMDKH8gTWJGdCqeukSptt0Ime330iIJHKC+R86P0W
 7g7TCC+VCr6lK48IJ0ObZ9EZw87UXrAQUeEInUbEZ9kCe2ag1sOxi9jBWuU075OQnXNaBfZQa
 Rcl8EnTp8tpssEAfeSqhFRrO3mhtPkdVK30Um1EtMa5/dlOTidSyhH/KrMYr211CKXuq2S4KF
 Y4ji1b9u19YWiEylbhpMxg85pwIwY267C6PQ+/7EmPYmaUMb1jScubodKFu+0mFXmbFVzVbeH
 HQhGw4NcudDKP2A7Hr6Lc6EAwIbZiSQUbq9CXJfPO7WK8X280W5r3Cd3yql/qaVDrI/UROINo
 LC2s2egDuMwYFm+NJ2SylT+ggUcx6xsumQUcbKtF7Z2t+Mj1k+9j/9vUjHMOhPgXtalR/bdoF
 b8/uTyu61B6vkPGWi93nUYwaT0KWDjN9HL12Hh17uv+o46r5ps3kr23KSy7YIdZD89A9aFR5h
 rMYQlaEye4tvX9TswS/xcoXHVeqmbnfn8FTpH1XK0Bc5Z/OvVnWE2XL1jO3MM9qY0/9g/CPUD
 CV4pDT6oICJH1d6W0dlz04DpY31EkZvfFyVJJndiWonhTp9Jk1q5XK8l07IgRvRfPLasmuAoH
 +J4s+5itU882AJhgexXuIUPw1uD7eSnaTI6anQs4af5CTL0TfzM7Pg9jNSyGq3lNQY+3P6WGo
 w3ObHE3TVQ+kDq9dfCntWrpXezI9v26XG62yEv9tgAn0CMt5deDJJ75lN3T1kpAviWBFpqIG7
 eO8hLPdoDeh8Zr6W2jAqrnTdzlNPN9A/tfuwyKkXS5beXpi4QZDS3
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +CONFIG_EMBEDDED=y

You probably should not set this one.

> +CONFIG_CAIF=y

And almost certainly not this one.

> +CONFIG_PCCARD=m
> +CONFIG_YENTA=m
> +CONFIG_RAPIDIO=y
> +CONFIG_RAPIDIO_TSI721=y

These seem unlikely as well. Can you confirm that you have both old-style
PC-Card support and RAPIDIO support on your most common hardware?

> +CONFIG_PARPORT=y
> +CONFIG_PARPORT_PC=y
> +CONFIG_PARPORT_SERIAL=y
> +CONFIG_PARPORT_PC_FIFO=y
> +CONFIG_PRINTER=m

Is this an on-board PCI device you actually have?
What do you connect to the PC parport? Most printers
in the past 15 years only have USB or network connections.

> +CONFIG_8139CP=m
> +CONFIG_8139TOO=m

Do you actually support legacy PCI slots?

> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_NR_UARTS=16
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=16
> +CONFIG_SERIAL_8250_EXTENDED=y
> +CONFIG_SERIAL_8250_MANY_PORTS=y
> +CONFIG_SERIAL_8250_SHARE_IRQ=y
> +CONFIG_SERIAL_8250_RSA=y
> +CONFIG_SERIAL_OF_PLATFORM=y

I don't see any device tree support in your patches, so I think the
SERIAL_OF_PLATFORM is not needed.

> +CONFIG_RAW_DRIVER=m

This is gone now.

> +CONFIG_INFINIBAND=m

You don't seem to enable any infiniband host drivers, so the core
layer can probably remain turned off

> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_EFI=y
> +CONFIG_UIO=m

same for UIO.

> +CONFIG_EXT2_FS=y
> +CONFIG_EXT2_FS_XATTR=y
> +CONFIG_EXT2_FS_POSIX_ACL=y
> +CONFIG_EXT2_FS_SECURITY=y
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_POSIX_ACL=y
> +CONFIG_EXT3_FS_SECURITY=y

I would generally recommend using EXT4 over EXT2 or EXT3

> +CONFIG_FRAME_WARN=1024

On 64-bit platforms, you probably want to increase this a bit,
otherwise you get extra warnings about code that works as
intended. The default is 2048, but you should be able to get by
with 1280, if that lets you build a defconfig kernel without warnings.


      Arnd
