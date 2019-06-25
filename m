Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B14551C9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 16:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfFYOfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 10:35:42 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:38728 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfFYOfm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 10:35:42 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hfmKO-0007B3-00; Tue, 25 Jun 2019 14:21:44 +0000
Date:   Tue, 25 Jun 2019 10:21:44 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove arch/sh?
Message-ID: <20190625142144.GC1506@brightrain.aerifal.cx>
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 11:02:36AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Christoph!
> 
> On 6/25/19 10:56 AM, Christoph Hellwig wrote:
> > arch/sh seems pretty much unmaintained these days.  The last time I got
> > any reply to sh patches from the list maintainers, and the last maintainer
> > pull request was over a year ago, and even that has been rather sporadic.
> > 
> > In the meantime we've not really seen any updates for new kernel features
> > and code seems to be bitrotting.
> 
> We're still using sh4 in Debian and most of the stuff works fine. There is
> one patch by Michael Karcher that fixes a bug in the kprobes code that someone
> should pull in as it unbreaks the kernel with kprobes enabled [1].
> 
> Yoshinori Sato is still active sporadically and has a kernel tree here
> where he collects patches for -next [2].
> 
> Otherwise, the kernel works fine.

Seconded. I apologize that I haven't been active in maintaining the
tree as well; funding for time working on it dried up quite a while
back and I'm stretched rather thin.

I'm generally okay with all proposed non-functional changes that come
up that are just eliminating arch-specific cruft to use new shared
kernel infrastructure. I recall replying to a few indicating this, but
I missed a lot more. If it would be helpful I think I can commit to
doing at least this more consistently, but I'm happy to have other
maintainers make that call too.

I do still have WIP forward-ports of Yoshinori Sato's device tree
patches from attempts to get them working on Landisk; they're sitting
in my working tree, but the PCI stuff isn't working, probably due to
changes out from under it. I'd like to work together on getting that
fixed to unblock me on something I'm interested in getting working on
my own time, but we've never managed to sync up on it.

As Adrian probably remembers, there's also the forked-tree, bitrotted
STlinux stuff I want to get merged back into mainline based on device
tree once it's there (doing it now doesn't make sense, as it would
just add a ton more board-file cruft where it's slated for removal).
This would improve the future viability of the arch/platform since,
currently, I think ST's chips are the main SH ones you can find/get --
for example in the nextvod devices.

Rich
