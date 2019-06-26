Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A358F56DE1
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfFZPip (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 11:38:45 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:38774 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZPip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2019 11:38:45 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hgA05-0005dv-00; Wed, 26 Jun 2019 15:38:21 +0000
Date:   Wed, 26 Jun 2019 11:38:21 -0400
From:   Rich Felker <dalias@libc.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] remove arch/sh?
Message-ID: <20190626153820.GP1506@brightrain.aerifal.cx>
References: <20190625085616.GA32399@lst.de>
 <ccfa78f3-35c2-1d26-98b5-b21a76b90e1e@physik.fu-berlin.de>
 <20190625112146.GA9580@angband.pl>
 <401b12c0-d175-2720-d26c-b96ce3b28c71@physik.fu-berlin.de>
 <CAK8P3a3irwwwCQ_kPh5BTg-jGGbJOj=3fhVrTDBUZgH1V7bpFQ@mail.gmail.com>
 <20190625142832.GD1506@brightrain.aerifal.cx>
 <CAK8P3a0j_9fzZxhxqCMHfoJ5DdZpHFvANEPqs1pbP23TCei6ng@mail.gmail.com>
 <87tvccr3kv.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvccr3kv.wl-ysato@users.sourceforge.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 26, 2019 at 08:25:20PM +0900, Yoshinori Sato wrote:
> On Wed, 26 Jun 2019 00:48:09 +0900,
> Arnd Bergmann wrote:
> > 
> > On Tue, Jun 25, 2019 at 4:28 PM Rich Felker <dalias@libc.org> wrote:
> > > On Tue, Jun 25, 2019 at 02:50:01PM +0200, Arnd Bergmann wrote:
> > > > don't build, or are incomplete and not worked on for a long
> > > > time, compared to the bits that are known to work and that someone
> > > > is still using or at least playing with.
> > > > I guess a lot of the SoCs that have no board support other than
> > > > the Hitachi/Renesas reference platform can go away too, as any products
> > > > based on those boards have long stopped updating their kernels.
> > >
> > > My intent here was always, after getting device tree theoretically
> > > working for some reasonable subset of socs/boards, drop the rest and
> > > add them back as dts files (possibly plus some small drivers) only if
> > > there's demand/complaint about regression.
> > 
> > Do you still think that this is a likely scenario for the future though?
> > 
> > If nobody's actively working on the DT support for the old chips and
> > this is unlikely to change soon, removing the known-broken bits earlier
> > should at least make it easier to keep maintaining the working bits
> > afterwards.
> > 
> > FWIW, I went through the SH2, SH2A and SH3 based boards that
> > are supported in the kernel and found almost all of them to
> > be just reference platforms, with no actual product ever merged.
> > IIRC the idea back then was that users would supply their
> > own board files as an add-on patch, but I would consider all the
> > ones that did to be obsolete now.
> > 
> > HP Jornada 6xx is the main machine that was once supported, but
> > given that according to the defconfig file it only comes with 4MB
> > of RAM, it is unlikely to still boot any 5.x kernel, let alone user
> > space (wikipedia claims there were models with 16MB of RAM,
> > but that is still not a lot these days).
> > 
> > "Magicpanel" was another product that is supported in theory, but
> > the google search showed the 2007 patch for the required
> > flash storage driver that was never merged.
> > 
> > Maybe everything but J2 and SH4(a) can just get retired?
> > 
> >      Arnd
> 
> I also have some boards, so it's possible to rewrite more.
> I can not rewrite the target I do not have, so I think that
> there is nothing but to retire.

To clarify, are you agreeing with Arnd's suggestion to retire/remove
everything but jcore and sh4[a]?

Rich
