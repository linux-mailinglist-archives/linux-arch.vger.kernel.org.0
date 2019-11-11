Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6EF801F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfKKTdk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 14:33:40 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:39367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfKKTdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 14:33:39 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N3bCH-1hmQ3w3kY7-010fCN; Mon, 11 Nov 2019 20:33:36 +0100
Received: by mail-qk1-f179.google.com with SMTP id h15so12180561qka.13;
        Mon, 11 Nov 2019 11:33:34 -0800 (PST)
X-Gm-Message-State: APjAAAXXUehROR4hg16SrGsmLkhlWeNJFltpGV8/mDO3s1mh8skoqwjh
        tY/46NCrVFjCjJg/qAPgy/4Ru1VJxk+kMV3sub8=
X-Google-Smtp-Source: APXvYqzRT3LvGe5JvZLYKm1upZpHxk2xc9ns43ZUwTpi/JlFXD7dYhA8+4Mt4XVDG2f3/qLjEL/Ms2I9EThmbgvV8Jg=
X-Received: by 2002:a37:58d:: with SMTP id 135mr2321779qkf.394.1573500813881;
 Mon, 11 Nov 2019 11:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-11-hch@lst.de>
 <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
 <20191111101531.GA12294@lst.de> <CAK8P3a0rTvfPP2LUMw8EC0xz5gfZP5+NUkoaZBJrtYYfr6YRig@mail.gmail.com>
 <20191111102923.GA12974@lst.de>
In-Reply-To: <20191111102923.GA12974@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 20:33:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b=td4JhYOcK1jUshh8Mp-5_w4v+dAr_JjnH783=ptBQ@mail.gmail.com>
Message-ID: <CAK8P3a2b=td4JhYOcK1jUshh8Mp-5_w4v+dAr_JjnH783=ptBQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] asm-generic: ioremap_uc should behave the same with
 and without MMU
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
X-Provags-ID: V03:K1:VkzlYprmjLZkUUcNJ+eTrkc1uyTcHlM+BFAEE68s21ucomSZQaJ
 Mq1HsbOKR10W9ktsWQqC2d+1fxNFc++gSh355I/Sm9Nt0OELiCU5GE/ejcbxdc0XoKGFGOR
 lJT0aj3OKGGsrqrwmqhZcVjRTdGYhtUjAmaLqUrUWTfS9gPcJXopxjb/cHOb3V99Jjg8KyM
 BDe7AsIZLiGgQ+SW18UXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hdS04Xdlzj8=:M/ucaK4r3dinqbK80C41xd
 FMDjqQL3YWPxy6jHWBpvqKj9qZWP8X6dfE8RQCodF9mGe6XJZOKEt4p5phfvsuDjwfDAuR77q
 5sbXk3f1gGuA3fUl2kc50FhfPxqpKsTvCyJ9PMoA1vJWANud2ysKvaSTXrsxfuBDYbDYflWwD
 FkAIhnavF1mnucw3hAUZbu/DkQc78rhm6yA66+iyf0ibiFIB1fiFKcy3QWM1WJMSymvmz+Cik
 0TMLecIni73LtmjHaEJqdQ07OpzRu6o2+nc6q2bAY8v58NfnuF4PC+RAMX5jsCwhiMQuTAAzH
 d9cCFvrdweO5pjBwUMsl1fDngiL0PhMkFoHuG2mp6WTu+9yigHaCDYkLBnzqo3wCtFy+yT589
 vZ/FGbV4Lx/67Cyy8ORfHd/Q4I+ytFVw6wwtG0/mHwHZbYfS5buusBz3lQKNPLkaAr33vhbEI
 HXyb+ZMaKffgQFt++5lnGgDgUJQspoUegjhdEeGEI5XiZQJLi3elBg+C5Gkccpc1LDKrpW2ka
 YjGgj5260Lt3d8KDG/qdbMttJAKgU/xdQzH2MW0jtDV/+7cUj/sApumoILyv1cXORKI+bqwSx
 ogfAEpKRHtcZ3qEtQueZhW8Xu+2e019UPGPVU0qRA4v2G6oIRAzpinHe15u698zmzbDymL58Y
 lwxjoo4VbkwFV/6Hr98ctBchu4Q9vloUQ/pqLZpaLK1ga8iZgXmf+PzlaojeIr0ObdDBvevEx
 7OZcdxrTy7Y1NqggNs6PW94MGROjlUKfXkY5V9wZiL5kUIPMuEbzKs1fxUg2d59L21Tn3fP6m
 i7fEXDMKusM1lgLeJl9N0qIk4SBBs+5bFUkc1R6uO78ROGzNzWdO/juF7AjegP2MSh3mgCkLn
 JUwmUH8sWRrwHApJ0rkA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 11, 2019 at 11:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 11, 2019 at 11:27:27AM +0100, Arnd Bergmann wrote:
> > Ok, fair enough. Let's just go with your version for now, if only to not
> > hold your series up more. I'd still suggest we change atyfb to only
> > use ioremap_uc() on i386 and maybe ia64. I can send a patch for that.
>
> I don't think we even need it on ia64.  But lets kick off a dicussion
> with the atyfb, x86 and ia64 maintainers after this series is in.
> Which was kinda my plan anyway.

I missed your reply and already sent my patch now. I guess it doesn't
hurt to discuss that in parallel. Anyway I think that this patch is the
last one you want an Ack from me for (let me know if I missed one), so

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
