Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C3AF721D
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKKb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:31:27 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfKKKb0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 05:31:26 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M1YxX-1iSBIl08Wh-00394l; Mon, 11 Nov 2019 11:31:24 +0100
Received: by mail-qv1-f46.google.com with SMTP id y18so4653500qve.2;
        Mon, 11 Nov 2019 02:31:22 -0800 (PST)
X-Gm-Message-State: APjAAAUxlJXW97+1cBVSkWYmUR6nUAyzY7pFnWR1j64svdk137UqnkjB
        L3rL1AV0PwZOn0xobSNrp1i1ToAK7xZJ7ywQxfA=
X-Google-Smtp-Source: APXvYqxD4F/fwy7LIVnyFzyiMun+f+kScDaMuxMbPMHFdHwTAmNy4Oax48ObAzH1ZmZyCVG2W0sxl5/9Apu79krhc7g=
X-Received: by 2002:a0c:a9cc:: with SMTP id c12mr4561842qvb.222.1573468282069;
 Mon, 11 Nov 2019 02:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-12-hch@lst.de> <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
 <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
In-Reply-To: <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:31:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2a7jwmAKhh3WsowCmvdQpsde5A5nz+3NXRn7amhwUxQg@mail.gmail.com>
Message-ID: <CAK8P3a2a7jwmAKhh3WsowCmvdQpsde5A5nz+3NXRn7amhwUxQg@mail.gmail.com>
Subject: Re: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Vincent Chen <deanbo422@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-mips@vger.kernel.org, alpha <linux-alpha@vger.kernel.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GhVqUNVJ6NcFflSOEwN3xNZ+WDbcZEBsdfOJy5lHGcUzStPON3S
 sdvrlkVnzJ4K/x3cf5tYPugN5XhSBeh1PoZWPALuD9vHbiqs7LkvRtku4dgNCYPfg2hTWD3
 aVB9H4AYQg+3P/o5HUXDoffXlGofXmGsR9gAnSPoqG/6NQQYwaLa49lQwiosiJF/NEYAPps
 lqR0sQiFoqXofI25s5XJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:URlU+6+rc6w=:y5PGJEge8OBUWHMAmN3LJO
 jIxpuP7dwcb+ik9HrK0VliiW2etopAEFn7uaY69aK9jGrqr7zmd1UGZJRBqB6CpVskEG/zCmk
 BUxZlaXSP2HfoBeDI1gCu7bYcY4fzXvLBrG9aPN+zildJOs7QeBcOfLC01M7htudy1pUPdFtA
 dR7SDHkntfBffPPssOnu6ozRPDnU6vL2KUZ/ZH/UXiHM1JH0SCQi3S+xNy26Z9u7aOGtjVuuO
 PboGcUnXnq3UHc+4dGBkWnBZqMiP3HYXGf5s9IXYstXi/3xPJcP434DY79oHGBb5Q5QCS7pK3
 Uh0sK/c6JlDeEuv/gL/RRCD0bvXv2SlkehmX2f9FT7bNgJYnNvApyh/P0EK+ylKyicCH785sG
 xC8SI2udds3P3++DOPOSazbC3AFpHQUODsb9TOd8/7q76Uvk2Q8Cx7y4Bpi6wlIxtGNHhFxG+
 GrbYr9XnYxkfFIfbc09D32LUFSRMlQbiKhK+f9ulUq1+DzdAaz5KJQCOdG8j5T2PMF+tZQKOX
 fxrqTQQnVV5QO3UZ9eprc58Gh9+a+JmAzuRVILazR9h+Q4YMNvlH6mMi2Y6SEyIlDBf75q2Kb
 ssAh+zE1KqjhRdsofdjkMYHkRgsTuR/y6OSetAY5mWDaBpp0F/+tlvsTaWXWGYx9ipHHQyRQe
 h1E8Nf2100ZVK2stQXODwrwsTyFzK6/Jxt9vt/fi8F6opD9MMsohnz1+WQLVVQfS0XnJiJhtc
 LNLskA15FjzURVAbK5EZaI1b5UJGTHvdRXycVdprQUsFnJ7JZaPMWksiXLm9r+Ndyaeklwakd
 OhiMwOoJE6qrOjB9QpYGAepCg/KlNGFz3AaQBpWbKb0wXzSS4NfVpn80UjiPCOnoHPmJ6ogZ8
 Hg9JY1zIFq3kTEw9eITg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 6, 2019 at 7:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Palmer,
>
> On Wed, Nov 6, 2019 at 7:11 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > It looks like the difference in prototype between the architectures is between
> >
> >     void __iomem *ioremap(resource_size_t, size_t)
> >     void __iomem *ioremap(phys_addr_t, size_t)
> >     void __iomem *ioremap(phys_addr_t, unsigned long)
> >     void __iomem *ioremap(unsigned long, unsigned long)
> >
> > shouldn't they all just be that first one?  In other words, wouldn't it be
> > better to always provide the generic ioremap prototype and unify the ports
> > instead?
>
> Agreed. But I'd go for the second one.

Right, phys_addr_t is the correct type here, resource_size_t is just a generic
type that is at least as long as any resource, and usually the same as
phys_addr_t, which is supposed to be used for physical addresses.

      Arnd
