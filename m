Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8663CA28A
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhGOQmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhGOQmF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 12:42:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED322C06175F;
        Thu, 15 Jul 2021 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GONFLvjn1kaw34J5mSHeswmWq/SXe8ghaN0abjeSa1w=; b=mPxCcStATplxsZkA4vAguYOsTM
        kfxGVnXvkz4Wrg1FqTqW/SwEU1gDT5uJ6W7hdcSZnKnfAsTfTmCTXljcucMR7GQFYxcCi22LoDGOR
        L2EdLIU/I6D8t3dWGpRxQoE27CHnvTP1f7DitubzR9kVfayOe5FFr7EnbSrFzA4st1NDbS07grhif
        r2A8FQApkVst50ytPIasqv/vM2g42xMyMJnOErv0XNYbhKN2Ml2Yn45Cqd3OGE5pEU1KgO5SUAa7X
        qN17fPkG4CncTGbO0dXTrr8b2adjtDdMwfHPQSqqkeYq8clKGlWuUIl290VkcAZRjdO0omlBM0k/s
        xVd5pNYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m44NB-003Wev-JS; Thu, 15 Jul 2021 16:38:13 +0000
Date:   Thu, 15 Jul 2021 17:38:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Make PMD_ORDER generically available
Message-ID: <YPBkbcmNzFKipXfC@casper.infradead.org>
References: <20210715134612.809280-1-willy@infradead.org>
 <a79b8c48-fd45-01c5-e43d-66077c495941@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79b8c48-fd45-01c5-e43d-66077c495941@gmx.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 15, 2021 at 06:28:42PM +0200, Helge Deller wrote:
> On 7/15/21 3:46 PM, Matthew Wilcox (Oracle) wrote:
> > These three architectures each define PMD_ORDER to mean "the order of
> > an allocation for a PMD table", but logically PMD_ORDER should be the
> > order of a PMD allocation, ie (PMD_SHIFT - PAGE_SHIFT) as DAX defines it.
> 
> Some architectures do have PGD_ORDER, PUD_ORDER and PTE_ORDER as well.
> If you rename PMD_ORDER, IMHO the others should be renamed too.
> 
> Why not simply rename "PMD_ORDER" in fs/dax.c to e.g.
> #define DAX_PMD_SHIFT   (PMD_SHIFT - PAGE_SHIFT)
> and use that inside the dax filesystem code?

Because that's wrong.  PMD order is clearly the order of a PMD page,
not the order of a PMD table.

I'm sure the others should also be renamed, but this is the one which
is causing me pain today.
