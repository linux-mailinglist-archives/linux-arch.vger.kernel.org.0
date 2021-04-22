Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAF367F55
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhDVLNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 07:13:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:36676 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhDVLNX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 07:13:23 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lZXGJ-0005bu-00; Thu, 22 Apr 2021 13:12:47 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 626D5C095C; Thu, 22 Apr 2021 13:08:55 +0200 (CEST)
Date:   Thu, 22 Apr 2021 13:08:55 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be
 zero
Message-ID: <20210422110855.GA9564@alpha.franken.de>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk>
 <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk>
 <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com>
 <alpine.DEB.2.21.2104211810200.44318@angie.orcam.me.uk>
 <20210422075645.GA5996@alpha.franken.de>
 <alpine.DEB.2.21.2104221053500.44318@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2104221053500.44318@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 22, 2021 at 11:12:40AM +0200, Maciej W. Rozycki wrote:
> On Thu, 22 Apr 2021, Thomas Bogendoerfer wrote:
> 
> > >  Thomas, as this mistake has spread across three out of these patches,
> > > both in change descriptions and actual code, would you mind dropping the 
> > > series from mips-next altogether and I'll respin the series with all 
> > > these issues corrected?
> > 
> > I'm sorry, but I don't rebase mips-next and the patches have been pushed
> > out before I received this mail.
> 
>  Hmm, what about changes known to actually break something then?  Like 
> with R6 here?  Those will undoubtedly cause someone a headache with 
> bisection sometime in the future.  Are you sure your policy is the best 
> possible?

This is my Linus pull tree, so I'm following 

Documentation/maintainer/rebasing-and-merging.rst

>  Meanwhile I'll be able to give DECstation figures only.  I guess such 
> limited results will suffice if I post the fix as an update rather than 
> replacement.

thank you.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
