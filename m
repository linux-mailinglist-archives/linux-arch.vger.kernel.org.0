Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2324367D77
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhDVJNV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 05:13:21 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:39418 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVJNQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 05:13:16 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9A17392009C; Thu, 22 Apr 2021 11:12:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 956CA92009B;
        Thu, 22 Apr 2021 11:12:40 +0200 (CEST)
Date:   Thu, 22 Apr 2021 11:12:40 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be
 zero
In-Reply-To: <20210422075645.GA5996@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2104221053500.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk> <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com> <alpine.DEB.2.21.2104211810200.44318@angie.orcam.me.uk>
 <20210422075645.GA5996@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021, Thomas Bogendoerfer wrote:

> >  Thomas, as this mistake has spread across three out of these patches,
> > both in change descriptions and actual code, would you mind dropping the 
> > series from mips-next altogether and I'll respin the series with all 
> > these issues corrected?
> 
> I'm sorry, but I don't rebase mips-next and the patches have been pushed
> out before I received this mail.

 Hmm, what about changes known to actually break something then?  Like 
with R6 here?  Those will undoubtedly cause someone a headache with 
bisection sometime in the future.  Are you sure your policy is the best 
possible?

 NB, I have benchmarked the update with my DECstation, however my Malta 
has not come up after a reboot last evening and neither it has after a few 
remote power cycles.  I have planned a visit in my lab next week anyway, 
so I'll see what has happened there; hopefully I'm able to bring the board 
back to life as I find it valuable for my purposes.  I had to replace the 
PSU it came with already a couple years back and the new one is supposedly 
high-quality, so I fear it's the board itself.

 Meanwhile I'll be able to give DECstation figures only.  I guess such 
limited results will suffice if I post the fix as an update rather than 
replacement.

  Maciej
