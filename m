Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C776222C52F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgGXMao (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXMan (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 08:30:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEBEC0619E4;
        Fri, 24 Jul 2020 05:30:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jywqW-001cTd-PB; Fri, 24 Jul 2020 12:30:40 +0000
Date:   Fri, 24 Jul 2020 13:30:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200724123040.GM2786714@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
 <20200724121918.GL2786714@ZenIV.linux.org.uk>
 <20200724122337.GA23095@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724122337.GA23095@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 01:23:37PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 01:19:18PM +0100, Al Viro wrote:
> > > net-next has a patch from me killing off csum_and_copy_from_user
> > > already:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f1bfd71c8662f20d53e71ef4e18bfb0e5677c27f
> > 
> > Nothing in that patch of yours touches csum_and_copy_from_user(). what
> > are you talking about?
> 
> Sorry, I meant csum_and_copy_from_nocheck, just as in this patch.
> 
> Merging your branch into the net-next tree thus will conflict in
> the nios2 and asm-geneeric/checksum.h as well as lib/checksum.c.

Noted, but that asm-generic/checksum.h conflict will be "massage
in net-next/outright removal in this branch"; the same goes for
lib/checksum.c and nios2.  It's c6x that is unpleasant in that respect...
