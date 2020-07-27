Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2502F22E493
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgG0D6S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 23:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgG0D6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 23:58:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3362C0619D2;
        Sun, 26 Jul 2020 20:58:17 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzuHG-003PCx-LN; Mon, 27 Jul 2020 03:58:14 +0000
Date:   Mon, 27 Jul 2020 04:58:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200727035814.GA794331@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
 <20200724121918.GL2786714@ZenIV.linux.org.uk>
 <20200724122337.GA23095@infradead.org>
 <20200724123040.GM2786714@ZenIV.linux.org.uk>
 <20200726071132.GA8862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726071132.GA8862@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 26, 2020 at 08:11:32AM +0100, Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 01:30:40PM +0100, Al Viro wrote:
> > > Sorry, I meant csum_and_copy_from_nocheck, just as in this patch.
> > > 
> > > Merging your branch into the net-next tree thus will conflict in
> > > the nios2 and asm-geneeric/checksum.h as well as lib/checksum.c.
> > 
> > Noted, but that asm-generic/checksum.h conflict will be "massage
> > in net-next/outright removal in this branch"; the same goes for
> > lib/checksum.c and nios2.  It's c6x that is unpleasant in that respect...
> 
> What about just rebasing your branch on the net-next tree?

For now I've just cherry-picked your commit in there.  net-next interaction
there is minimal; most of the PITA (and potential breakage) is in arch/*...
