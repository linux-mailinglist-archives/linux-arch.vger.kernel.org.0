Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D822DC88
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jul 2020 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGZHLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGZHLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 03:11:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB917C0619D2;
        Sun, 26 Jul 2020 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pw0rH8PZFrh8zTY8f/e+9jq1eWJ4CWGY/Ca+PBCOU7M=; b=rfAVBDiieeMPvUj8omY43mEDIw
        0d9MebIoAviXkbqBHteWezmwnNTUIG6NFYrIqzHYJG7PYmOfbf5bOomWIfPq3VeuvYoqRUOs1eFTd
        h8HuPL017QiCIKQs9k1Y8mVYf/kMRrU6QU9VR9OrAl+QnU6LiH9B++wYho13BzswEEbeHhsTzEgzh
        v6wzlg/bPh9hmIO6WYAwv0Yi1KqwO6PX5ZQbKYALiC7VUw/NXX0hPeBiRnyxJAEptjoGOKi8KGE0D
        Sz5rxOD9+pAvsYzxZ9m8C3nvQERKWOfVoDg/b6s02OgxY5wXrd9PY7WDHWgtt/lsBSBCR6a7pfxr/
        DCQM9/KQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzaom-0002Ka-JP; Sun, 26 Jul 2020 07:11:32 +0000
Date:   Sun, 26 Jul 2020 08:11:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200726071132.GA8862@infradead.org>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
 <20200724121918.GL2786714@ZenIV.linux.org.uk>
 <20200724122337.GA23095@infradead.org>
 <20200724123040.GM2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724123040.GM2786714@ZenIV.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 01:30:40PM +0100, Al Viro wrote:
> > Sorry, I meant csum_and_copy_from_nocheck, just as in this patch.
> > 
> > Merging your branch into the net-next tree thus will conflict in
> > the nios2 and asm-geneeric/checksum.h as well as lib/checksum.c.
> 
> Noted, but that asm-generic/checksum.h conflict will be "massage
> in net-next/outright removal in this branch"; the same goes for
> lib/checksum.c and nios2.  It's c6x that is unpleasant in that respect...

What about just rebasing your branch on the net-next tree?
