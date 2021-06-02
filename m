Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D53985FF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhFBKL5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 06:11:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFBKL4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jun 2021 06:11:56 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N2Dks-1lOdY23GiU-013cUs for <linux-arch@vger.kernel.org>; Wed, 02 Jun 2021
 12:10:12 +0200
Received: by mail-wr1-f54.google.com with SMTP id l2so1696303wrw.6
        for <linux-arch@vger.kernel.org>; Wed, 02 Jun 2021 03:10:11 -0700 (PDT)
X-Gm-Message-State: AOAM533HKsMULQa9Br9h0+b8xxtyaH/FEJSFtZA9iMjJiOQepLrpnpHI
        uRVO47jf0uZ/4eSqq8yNTSjePAioQk21e8pDY64=
X-Google-Smtp-Source: ABdhPJwoA3PiZt2E7ctIEca12eOVYFadag6s8cXYgYkl0VBvQCgvgji6pQYpXwvfZIu2eEjVjiWC+qxzXQ119fy/z8c=
X-Received: by 2002:a5d:5084:: with SMTP id a4mr673366wrt.286.1622628611529;
 Wed, 02 Jun 2021 03:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <202106020243.YWyklbec-lkp@intel.com>
In-Reply-To: <202106020243.YWyklbec-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Jun 2021 12:08:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2EC5oWHufng-eHNwhpqzQGj8NS=OSR6H=WdYNwd3aP8w@mail.gmail.com>
Message-ID: <CAK8P3a2EC5oWHufng-eHNwhpqzQGj8NS=OSR6H=WdYNwd3aP8w@mail.gmail.com>
Subject: Re: [asm-generic:clkdev 5/7] arch/m68k/coldfire/m53xx.c:278:29:
 error: 'xC0000000' undeclared; did you mean 'B3000000'?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:I1mV5TBneHfk6PLjptXsl5YM0hld7z4W/DLdN6Ac3qtKqbLgsUY
 XjzzakL0x4nOCazRadkurVGzD+yOnzqGq8WDP6BB0lmIqMXhDoDjp740c8gEDJkh58DhmQo
 QXd/1Qj3Rxqwhb0cFpmrSv/nPFuNX0IPpYLjT1Aw6kZ+vwm3N+iLVVU9Nbjf6gErfDDxmvQ
 y1ITgFjoWCjYEPCo/sN2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KqwP+3sypPQ=:105Wiu2334ZCcHg6G4VF2U
 ExcrPF+7Ppa4tpjDpeTGSeEuJIFPv06rqXSFNyEVFjieSMwOgCpUnmDHqnWj9zM7u6KbfVGu5
 T9GLk1IVVkkvtv7TTI43Y/kIxGdpOuIpNy4RRtHNMxEW/A7K3HGjN8L3RY5iXeZO1/4S1yTPN
 mzTQFMqemOV4w6v/n7NPTWaomxbAAGyhL4lbm3Fcx5CRjn4kUqsw9LNEpEoeDxnegvjQBhvqy
 D1yKsBwb+38ZU9j6EiTa+RddTRqDdk6VAlDcL6DjaJ9UNZIeYYDEMqKQ35ItynsbnYxOdgJqj
 9W/n0B4OlRAeHOOMXYbcW0PN3ULJ5oA1FQGLAebfAHQb6eBRhitOU5ncEgD1yxTAmyMYWZ8/D
 4Ey+/p+fpY0sD8HaHSqtFjtZclV6DyXGJuRPpLLWNrx+/OZV+iT8pqAyGnsRoF/uB5fvRhUAJ
 Ol6gu4OrjE8gV2GRAA07esBkCVxEvgpir/o7TCdaYQo7OvQEJwhJD0pAtRK19N/krjAt4m4jR
 S1qAFqMwU6jMG6BRBiE5gg=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 1, 2021 at 8:40 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git clkdev
> head:   2c79796a923663135ddaf8e9ddca4b46ac8e0113
> commit: 5b2335ed6a67ea9f7894c2ffe27b2884ac46f39f [5/7] m68k: coldfire: remove private clk_get/clk_put
> config: m68k-randconfig-r006-20210601 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=5b2335ed6a67ea9f7894c2ffe27b2884ac46f39f
>         git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>         git fetch --no-tags asm-generic clkdev
>         git checkout 5b2335ed6a67ea9f7894c2ffe27b2884ac46f39f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/m68k/coldfire/m53xx.c:294:24: warning: no previous prototype for 'sysinit' [-Wmissing-prototypes]
>      294 | asmlinkage void __init sysinit(void)
>          |                        ^~~~~~~
>    In file included from arch/m68k/include/asm/io.h:6,
>                     from include/linux/io.h:13,
>                     from arch/m68k/coldfire/m53xx.c:20:
>    arch/m68k/coldfire/m53xx.c: In function 'fbcs_init':
> >> arch/m68k/coldfire/m53xx.c:278:29: error: 'xC0000000' undeclared (first use in this function); did you mean 'B3000000'?
>      278 | #define EXT_SRAM_ADDRESS (0,xC0000000)
>          |                             ^~~~~~~~~

Fixed now, sorry for the typo. I'm going back to my normal input devices now ;-)

        Arnd
