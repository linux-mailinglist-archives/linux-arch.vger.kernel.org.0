Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7628522C514
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGXMXl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMXk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 08:23:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A77C0619D3;
        Fri, 24 Jul 2020 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0xAtt8OdXDwTj0AGHmBvJe2bIWDAHdVfH+I971pKCts=; b=dWCoZstj6bW9VNbcVyaoonTtsh
        GtJrh8tIKIiQGqD15HbnXud8AO6HOgCtXDxOsH7vyrug5McH6tf0dpJQDYEwArCXDLODRtqmAqQiQ
        Cus2hBBz4MxrQ4q2lfxfWLi9v4mQxtOss9CP+t21orFMn5NJiqrNr0pPpQQL5jaeq9LM+utqELT5c
        7JYs6Vg3siXPoICKLHbI0DTllNhMwgN/ryklTgv1jArKVEGBaqa4Obhq0F2jqSLG6O66ZIdIpI0nj
        o/AwFN7OwH4173Dx2ulB2iYivxp0rvZ02EZ8d+mRt3bIo+K3579kpQF42OSm8L7wsR+oEwAVtoAM6
        jpEM5J8g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jywjh-000668-4R; Fri, 24 Jul 2020 12:23:37 +0000
Date:   Fri, 24 Jul 2020 13:23:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200724122337.GA23095@infradead.org>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
 <20200724121918.GL2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724121918.GL2786714@ZenIV.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 01:19:18PM +0100, Al Viro wrote:
> > net-next has a patch from me killing off csum_and_copy_from_user
> > already:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f1bfd71c8662f20d53e71ef4e18bfb0e5677c27f
> 
> Nothing in that patch of yours touches csum_and_copy_from_user(). what
> are you talking about?

Sorry, I meant csum_and_copy_from_nocheck, just as in this patch.

Merging your branch into the net-next tree thus will conflict in
the nios2 and asm-geneeric/checksum.h as well as lib/checksum.c.
