Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30824A35EE
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 12:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354640AbiA3Lcy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 06:32:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344102AbiA3Lcu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jan 2022 06:32:50 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MCayD-1n51Vk460h-009cnm; Sun, 30 Jan 2022 12:32:48 +0100
Received: by mail-ot1-f49.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso10267743otj.2;
        Sun, 30 Jan 2022 03:32:47 -0800 (PST)
X-Gm-Message-State: AOAM532cCbxEelwRHlt25HUiGSKF8InPnYi6gUnC3N0/EyVNse6eycj+
        uxkeTKq8fqFIxlBHl5EH7e1nAU80CZOsusUscHU=
X-Google-Smtp-Source: ABdhPJwfE8JwIPR39kNR+t9u+MXKrX+M/IvR4BevQAZ6Ex6kYRsjbH69gpBCBcpvwPyYexj/E8Z2vleiIWqqwcDE0P4=
X-Received: by 2002:a05:6830:33c2:: with SMTP id q2mr8818491ott.368.1643542365934;
 Sun, 30 Jan 2022 03:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-9-guoren@kernel.org>
 <CAK8P3a3JGP6fLVOyLgdNw2YpRSmArbEX8orUhRrN=GHmcdk=1g@mail.gmail.com> <CAJF2gTQQnrUFNQ85vvoMkpxnCWuMw8iXtPZOJwWGaEA9f+rTwA@mail.gmail.com>
In-Reply-To: <CAJF2gTQQnrUFNQ85vvoMkpxnCWuMw8iXtPZOJwWGaEA9f+rTwA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 30 Jan 2022 12:32:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a12CygLFT7qoQ9K=sowvTgNpeRej6Zh6Pv2PL_e2zMhMQ@mail.gmail.com>
Message-ID: <CAK8P3a12CygLFT7qoQ9K=sowvTgNpeRej6Zh6Pv2PL_e2zMhMQ@mail.gmail.com>
Subject: Re: [PATCH V4 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
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
X-Provags-ID: V03:K1:s+QB4RyZjKJhrb5eRJs6jI0hTwFihOqehJSH7HnwKR1Mql0VAi5
 u21yO7l5oALaUX9DERN/QeXkP7eAmS8jZkHjs92PN+IZeirfgR7Ql/uPJCei9wC4ZRIypm5
 r02VfVWq/0hbyNZz07lCwmHnZCErMtNQopjlguoZ1YQJG1n2sNki3rK3oZ5qldawNE2phqf
 D8fgClrXLWJy3LNJnloBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZWoipqB24Tg=:ye1vFxvIQLsaCuYBZZ9XbO
 a5hEFioB7YtytOQdB2A9Lr4tONnTXpusBSARti+KoGWyMNuvruKoWQMH0ETnu05bdc/HKjPT7
 huwalokfHNDc63FEXrFXpwh9ahn77VTnh1vr0fixjqcvGIi8P9Q3OHJamxg9DMV0cabwBpt2u
 iZW77e6dvvwoyG0zry9bzPvql7k49w0KWcZwEUypw3vMu5L7qV4im1FDBFvC7zL9TjGvwkzld
 aRoVMl9OYf82TvxFFYLIa5kr8VBC33aTO6CdGQ5lTqrxl/8ZWSzYUOZP53uYLyq6D0jc9t3ZE
 om4QFNiUVrTKrr0kEyBdE5cKpx6OBQ6Qw5YGNpl0hAsHRXIy20WUKGC41EaiM1zqHLinnuQ/s
 biOTzn4ON0IoD3kMeWj6LRIqzbLZQjmTuWmfzdpVrru/IruZGZ2AFBJ1sHDZ9HuGWfyhXJbO1
 5I99qzRD//Z2BKgJD9oYJJhJDBlQTbcloJHLeit7kqBd/xPgsJETjJFYuvdvKN55BDc3M0TQk
 yf1rO1MQRBrugPYU+ZyvOHbNJdhqwLFeqMJxMm7pWfWiOKZUg5MH1XaZOOjmna3xnTXtnXAMi
 QNJRFKlNeXdTK3/dg75Vw2FJXqecEEby2sqiAH/pmjI33vnPUI8WTkst7/p0dV+Nplx1khLAo
 X+mvB2RkfYfj+YaHgeMAoHNE40AmA1FODQLiH5L1VXv8rqVWjZURt8jvAIN2bSFAtFcgZlfeP
 jCcgozgUX9axmoFCawmynVSNTbvPIwlP6+MYjGgAs43coiyEX0yO4jpf1sfgBCbhKoRQrjzdj
 9JC9xQcao/vy/Pp9rZkYbkjp60JeOvJd6qRTungoei5L6umgwY=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 6:54 AM Guo Ren <guoren@kernel.org> wrote:
> On Sun, Jan 30, 2022 at 6:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I would make these endian-specific, and reverse them on big-endian
> > architectures. That way it
> > should be possible to share them across all compat architectures
> > without needing the override
> > option.
> I hope it could be another patch. Because it's not clear to
> _LITTLE_ENDIAN definition in archs.
>
> eg: Names could be __ORDER_LITTLE_ENDIAN__ CPU_LITTLE_ENDIAN
> SYS_SUPPORTS_LITTLE_ENDIAN __LITTLE_ENDIAN
>
> riscv is little-endian, but no any LITTLE_ENDIAN definition.
>
> So let's keep them in the patch, first, Thx

The correct way to do it is to check for CONFIG_CPU_BIG_ENDIAN,
which works on all architectures. Since nothing else selects the
__ARCH_WANT_COMPAT_* symbols, there is also no risk for
regressions, so just use this and leave the #ifndef compat_arg_u64
check in place.

      Arnd
