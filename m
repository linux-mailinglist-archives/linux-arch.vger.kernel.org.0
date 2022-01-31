Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D604A47E9
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 14:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348950AbiAaNTz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 08:19:55 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiAaNTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 08:19:54 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MtwQm-1mOdMa1Vca-00uIbx; Mon, 31 Jan 2022 14:19:53 +0100
Received: by mail-oi1-f179.google.com with SMTP id e81so26570484oia.6;
        Mon, 31 Jan 2022 05:19:51 -0800 (PST)
X-Gm-Message-State: AOAM531TMJcHq3ZMBa7gZw9OiN9iytCABMsc/ciOfYqpXGY0FwHPxVb1
        PFfg4OQA9Ec/xbsBLR0GUy0ys/ZE4TfuOfLgqAs=
X-Google-Smtp-Source: ABdhPJxqzdad29yoPfVQVqkeuINyquIZpxlEvxSx06sdTnz4rryvUZKfSJUaDKGmBUmu6Be3uaLlJuvMhrTHZxz8Zkc=
X-Received: by 2002:aca:f03:: with SMTP id 3mr13235991oip.102.1643635190773;
 Mon, 31 Jan 2022 05:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-6-guoren@kernel.org>
 <YffUqErSVDgbGLTu@infradead.org> <CAK8P3a1jZyVBW70K6_u3mvXYNowV4DTBxivKc2L=HbRK8SgRXg@mail.gmail.com>
 <YffdbErmAjAWYuD9@infradead.org>
In-Reply-To: <YffdbErmAjAWYuD9@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 14:19:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0VZt8PF1C4W0X4+SNhP=NbHAigq3N6fEawNpPd-RZDjw@mail.gmail.com>
Message-ID: <CAK8P3a0VZt8PF1C4W0X4+SNhP=NbHAigq3N6fEawNpPd-RZDjw@mail.gmail.com>
Subject: Re: [PATCH V4 05/17] riscv: Fixup difference with defconfig
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
X-Provags-ID: V03:K1:/teNtPv3Zma4puWXNydHU77NSq0sZXheT0NtF2H3rBDI56fUqI0
 H33ZJhLCPLPPkel5kWc1gvUWSYwj7wXTLlXmXElUga3IRqancvA+7hyFs7qQd7Pwbs77Iin
 BXK4DsuWRNIwWg5+WRjR6msMHJlk8NkJwmpjBc6MIvm19M4pa6zVZvOSspBbiUU+B2nXv1V
 EHAkxtn/6k7z43W8Z7Rhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LLetFV+FXxQ=:tXmru9TQIjnt1fw4mW3KTD
 12BYjw5OHwWwVoNG05xJGTKZBsmisxgg+oE6tsuows2j49RBbmeMVslu8zIk6gqz4886GTvMQ
 eZN6XZL+l3CC4HedEV0pNbBNMcWWHo3WpOWeBekadn/bE3T1WbgmzWXNV4cxMbr6+6tZGjWV7
 VbX6dbR2tKqsMW5Xju5690MQB2JYK8PNwZCnYs0Lp1HU7Gv//9Urq7/YgawbGrYWksPa1YuUQ
 ZhPp2bY+d5gZ1iyuTXfaKlsiAjC2LRh17L4/v99TJFDQdjd5euu2i/PRvX0dI817e4vxg2ySh
 0gII/NcedhDSJl8ZWXHtCnA6gAUrO6t6isSIvTG8ehm6GoVkXYQlSjwbvj3MHchWOZ0tnpDHp
 RYxaEvA+v2aOBIqdSOSCi04aEXuo2OzE4IBYv7OvaRsLWXP0qdM+R9prMuHRQYHDTHoF7N0sQ
 X+hXKrec5zTqJ6OiNVewh6N9TJMXFeK4o+z675jKZXC3+DBRGv+Q9Rs73URuKujK4H6rrd5nf
 Xi+Uc8aMk9JdoezKxeKN6E1WAn3iWbQre+mj6yVKNOoyaH9xUaF0B5+xfSc+gYe3wO79Q2pSD
 5MmdkMkVZjkOJeXwDpYZ3qVoiZitaBn5Ed22H4ZeylHahI+uuNrTgOqwiGjLMC5aGjrnXLm5U
 F3tpaTtsmETMOHX8RpMPpgz9GIR+qgu6AskKa2b9sgmPe9/l5nYj1gPLlck8Qgs5rLBVMBF4q
 aEsEAr54VvUYD2qfse0WSqFOtAP4NuVpf/gTfqVy9HBXafAQKT6liIHDU2+9WTAkeAk7LdfCx
 akWJ9ywZiGeJ4TXFGeiKfXiJsAgwlWXVCvtyZe6cxOaRCY/294=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 31, 2022 at 2:00 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 31, 2022 at 01:48:58PM +0100, Arnd Bergmann wrote:
> > I thought that is what the patch does, there is already the normal 64-bit
> > defconfig, and the new makefile target makes this shared with 32-bit
> > to prevent them from diverging again.
>
> I ment using a common fragment and the deriving both 32-bit and 64-bit
> configs from it. The 64-bit specific fragment will be empty for now,
> but we will sooner or later have an option that can only go into the
> 64-bit defconfig.

Ah right, that should work as well, not sure if it makes much of a difference.

I suggested this method because it is the same thing we do on powerpc.

        Arnd
