Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD35551B2
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfFYO3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 10:29:41 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:38724 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfFYO3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 10:29:40 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hfmRr-0007Bc-00; Tue, 25 Jun 2019 14:29:27 +0000
Date:   Tue, 25 Jun 2019 10:29:27 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove arch/sh?
Message-ID: <20190625142927.GE1506@brightrain.aerifal.cx>
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625142144.GC1506@brightrain.aerifal.cx>
 <20190625142341.GA6948@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625142341.GA6948@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 04:23:41PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 10:21:44AM -0400, Rich Felker wrote:
> > I'm generally okay with all proposed non-functional changes that come
> > up that are just eliminating arch-specific cruft to use new shared
> > kernel infrastructure. I recall replying to a few indicating this, but
> > I missed a lot more. If it would be helpful I think I can commit to
> > doing at least this more consistently, but I'm happy to have other
> > maintainers make that call too.
> 
> It woud be great if you could at least apply with a tentative ack.
> At least for some trees we try very hard to get a maintainer ack,
> so silence is holding things back to some extent.

OK.

> I'd also like to second Arnds request to figure out if any bits
> are truely dead.  E.g. 64-bit sh5 support very much appears so.

I agree, and just replied there.

Rich
