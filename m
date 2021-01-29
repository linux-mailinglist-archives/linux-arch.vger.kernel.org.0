Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9148C308F84
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhA2VeV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:34:21 -0500
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:51628 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232906AbhA2VeV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 16:34:21 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2021 16:34:20 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 748C01801BD8D;
        Fri, 29 Jan 2021 21:24:55 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 940ED127C;
        Fri, 29 Jan 2021 21:24:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3872:3876:4321:4605:5007:6742:7514:7652:10004:10400:10848:11026:11232:11473:11658:11783:11914:12043:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: scent97_621144b275ab
X-Filterd-Recvd-Size: 2133
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 Jan 2021 21:24:10 +0000 (UTC)
Message-ID: <f9dba4c16fb49e0ce19a8152dd1416f8d4056680.camel@perches.com>
Subject: Re: [PATCH 2/5] bits_per_long.h: introduce SMALL_CONST() macro
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date:   Fri, 29 Jan 2021 13:24:09 -0800
In-Reply-To: <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
References: <20210129204528.2118168-1-yury.norov@gmail.com>
         <20210129204528.2118168-4-yury.norov@gmail.com>
         <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2021-01-29 at 23:10 +0200, Andy Shevchenko wrote:
> On Fri, Jan 29, 2021 at 10:49 PM Yury Norov <yury.norov@gmail.com> wrote:
[]
> > @@ -37,7 +37,7 @@
> >  #define GENMASK(h, l) \
> >         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > 
> > -#define BITS_FIRST(nr)         GENMASK(nr), 0)
> > +#define BITS_FIRST(nr)         GENMASK((nr), 0)
> 
> How come?!

It's broken otherwise with unbalanced parentheses...


