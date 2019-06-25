Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9675B551AD
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfFYO26 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 10:28:58 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:38712 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbfFYO26 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 10:28:58 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 10:28:58 EDT
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hfmQy-0007BU-00; Tue, 25 Jun 2019 14:28:32 +0000
Date:   Tue, 25 Jun 2019 10:28:32 -0400
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] remove arch/sh?
Message-ID: <20190625142832.GD1506@brightrain.aerifal.cx>
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625112146.GA9580@angband.pl>
 <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
 <CAK8P3a3irwwwCQ_kPh5BTg-jGGbJOj=3fhVrTDBUZgH1V7bpFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3irwwwCQ_kPh5BTg-jGGbJOj=3fhVrTDBUZgH1V7bpFQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 25, 2019 at 02:50:01PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 25, 2019 at 2:02 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >
> > Adam,
> >
> > On 6/25/19 1:21 PM, Adam Borowski wrote:
> > >> We're still using sh4 in Debian
> > >
> > > I wouldn't call it "used": it has popcon of 1, and despite watching many
> > > Debian channels, I don't recall hearing a word about sh4 in quite a while.
> >
> > So, according to your logic, Debian should drop the mips64el (popcon 1)
> > and riscv64 ports (popcon 2) [1]?
> >
> > > Hardware development is dead: we were promised modern silicon by j-core
> > > after original patents expired, but after J2 nothing happened, there was
> > > silence from their side, and now https://j-core.org is down.
> >
> > It's not dead. You can still run it on an FPGA, the code is freely available.
> > Plus, the architecture seems to be still in use in the industry [2].
> 
> It would be nice if one of the maintainers or the remaining users could go
> through the code though and figure out which bits are definitely dead
> (e.g. sh5),

I'm in favor of removing sh5 (64-bit). It's already been removed from
GCC and as I understand there was never any hardware really available.
There's also a lot of NUMA-type infrastructure in arch/sh that looks
like YAGNI violations -- no clear indication that there is or ever was
any hardware it made sense on. That could probably be removed too.

> don't build, or are incomplete and not worked on for a long
> time, compared to the bits that are known to work and that someone
> is still using or at least playing with.
> I guess a lot of the SoCs that have no board support other than
> the Hitachi/Renesas reference platform can go away too, as any products
> based on those boards have long stopped updating their kernels.

My intent here was always, after getting device tree theoretically
working for some reasonable subset of socs/boards, drop the rest and
add them back as dts files (possibly plus some small drivers) only if
there's demand/complaint about regression.

Rich
