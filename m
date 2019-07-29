Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7007778358
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 04:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfG2C2K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Jul 2019 22:28:10 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:46479 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2C2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Jul 2019 22:28:10 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6T2RvWA017712;
        Mon, 29 Jul 2019 11:27:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6T2RvWA017712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564367278;
        bh=fuZnDsZpEjCp0F5PNZMcUKY5REV4m18B0lrZlOvAENw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vsUZVzRXAnGOJXyG6FvMBKTegKUZilyCP9sDOxJzbUlCUMKwl8aWmKG32OqWEHkWx
         Hy4JlKv7FEfsnoB1xZiypCxZK9Ge38s2v74tDlkAJlIrpR7r7c1NIjZED3n8+4Uw4E
         ipuRBmaQys67OgDpP7YipMVvktuSxdfIFrtVk/0ornkNux5le1yqbbSRQzyVy6LauS
         T1sDhvTOi9oeLHwSsSnVxsOozf43oDqV2vb+ej9iWIuvhfb1WF3hDg/5qsAQjwxnXQ
         4k504SAAFYq03KSVoBK/vIO9uPi41tCJDixaN8vv2DTkcPEGHqzN2JHgbYKceh3XZL
         N9pRIBiBAJk6g==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id a186so38168529vsd.7;
        Sun, 28 Jul 2019 19:27:57 -0700 (PDT)
X-Gm-Message-State: APjAAAVxRRDhVu/ZFnm+xM6+FL9iwvoPVR/iWKN0V/ys5BizT6WZek7A
        sA15JcPEWwflJkHuRFjcEf//1oaI9SqJQrgkTPY=
X-Google-Smtp-Source: APXvYqzxpkojkQEpX7swU62BBxk4pqBB3bItrBsJECsncJjK9lP6nEWHSj07bRXwqpxupvKDkuycdvonNU518J3dcrU=
X-Received: by 2002:a67:d46:: with SMTP id 67mr66750201vsn.181.1564367276406;
 Sun, 28 Jul 2019 19:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
 <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
 <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
 <CAK7LNATJGbSYyuxV7npC_bQiXQShb=7J7dcQcOaupnL5-GhADg@mail.gmail.com>
 <alpine.DEB.2.21.1907230837400.1659@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907231013340.1659@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907231013340.1659@nanos.tec.linutronix.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Jul 2019 11:27:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATg38uFeY8JKnNPXudv8y4O1g=TPtvEbcBjrqFXSaKgdQ@mail.gmail.com>
Message-ID: <CAK7LNATg38uFeY8JKnNPXudv8y4O1g=TPtvEbcBjrqFXSaKgdQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mike Lothian <mike@fireburn.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 23, 2019 at 5:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 23 Jul 2019, Thomas Gleixner wrote:
> > On Tue, 23 Jul 2019, Masahiro Yamada wrote:
> > > Right.
> > > I was able to build with ld.gold
> > >
> > > So, we can use gold, depending on the kernel configuration.
> >
> > That's exactly the problem. It breaks with random kernel configurations
> > which is not acceptable except for people who know what they are doing.
> >
> > I'm tired of dealing with half baken fixes and 'regression' reports. Either
> > there is an effort to fix the issues with gold like the clang people fix
> > their issues or it needs to be disabled. We have a clear statement that
> > gold developers have other priorities.
>
> That said, I'm perfectly happy to move this to x86 and leave it alone for
> other architectures, but it does not make sense to me.


I did not see opposition from other arch maintainers.


> If the gold fans care enough, then we can add something like
> CONFIG_I_WANT_TO_USE_GOLD_AND_DEAL_WITH_THE_FALLOUT_MYSELF.

Let's apply this and see.

If somebody really wants to use gold by his risk,
I will consider such a config option.


Applied to linux-kbuild.
Thanks.


-- 
Best Regards
Masahiro Yamada
