Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19993A4555
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2019 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfHaQ3r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 31 Aug 2019 12:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbfHaQ3q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 31 Aug 2019 12:29:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2253522D37;
        Sat, 31 Aug 2019 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567268985;
        bh=oCFqDXfnxrqpiBFRCwyD8nHXvoMvSjbxCsJhrxHTYqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vX6b95IdsVrDjTXh55KZNhoPNMKUITWlit4Ldb9kHZhxWpNoqZwiOB5EF5DJcLfuZ
         wmt8nfF1pggofVEAUJWY4K2cI3w83kg0ds8vBO0zGI/+b8iJT5NQEI4dH3G3L57NyD
         AwNlHxXQFvARoZXdkRSB9gHwMtmjWPnHQrjl8Gx4=
Date:   Sat, 31 Aug 2019 17:29:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] arm64: remove __iounmap
Message-ID: <20190831162937.5ybulvaa4eq7mybs@willie-the-truck>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-20-hch@lst.de>
 <20190819073601.4yxjvmyjtpi7tk56@willie-the-truck>
 <20190830160515.GC26887@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830160515.GC26887@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 06:05:15PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 19, 2019 at 08:36:02AM +0100, Will Deacon wrote:
> > On Sat, Aug 17, 2019 at 09:32:46AM +0200, Christoph Hellwig wrote:
> > > No need to indirect iounmap for arm64.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/arm64/include/asm/io.h | 3 +--
> > >  arch/arm64/mm/ioremap.c     | 4 ++--
> > >  2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > Not sure why we did it like this...
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> 
> Can you just pick this one up through the arm64 tree for 5.4?

Unfortunately, it doesn't apply because the tree you've based it on has
removed ioremap_wt(). If you send a version based on mainline, I can
queue it.

Cheers,

Will
