Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A9368833
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 22:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbhDVUsd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhDVUsd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 16:48:33 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3A0CC06174A;
        Thu, 22 Apr 2021 13:47:57 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CF57D92009D; Thu, 22 Apr 2021 22:47:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C959B92009B;
        Thu, 22 Apr 2021 22:47:56 +0200 (CEST)
Date:   Thu, 22 Apr 2021 22:47:56 +0200 (CEST)
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
In-Reply-To: <20210422110855.GA9564@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2104222244220.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk> <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com> <alpine.DEB.2.21.2104211810200.44318@angie.orcam.me.uk> <20210422075645.GA5996@alpha.franken.de>
 <alpine.DEB.2.21.2104221053500.44318@angie.orcam.me.uk> <20210422110855.GA9564@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021, Thomas Bogendoerfer wrote:

> >  Hmm, what about changes known to actually break something then?  Like 
> > with R6 here?  Those will undoubtedly cause someone a headache with 
> > bisection sometime in the future.  Are you sure your policy is the best 
> > possible?
> 
> This is my Linus pull tree, so I'm following 
> 
> Documentation/maintainer/rebasing-and-merging.rst

 Fair enough.

> >  Meanwhile I'll be able to give DECstation figures only.  I guess such 
> > limited results will suffice if I post the fix as an update rather than 
> > replacement.
> 
> thank you.

 I have requested 3/4 to be backported however, so I think in this case 
4/4 will have to follow as well as 2/2 of the fix series I have just 
posted.  Will you be able to resolve this somehow?

  Maciej
