Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4B234DC0
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 00:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGaWrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 18:47:11 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:35817 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWrK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 18:47:10 -0400
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DC195100003;
        Fri, 31 Jul 2020 22:47:06 +0000 (UTC)
Date:   Fri, 31 Jul 2020 15:47:04 -0700
From:   "josh@joshtriplett.org" <josh@joshtriplett.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Message-ID: <20200731224704.GF32670@localhost>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200731212721.GC32670@localhost>
 <CY4PR13MB1175A3B5D9DE33D3A1E045A6FD4E0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175A3B5D9DE33D3A1E045A6FD4E0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 09:57:41PM +0000, Bird, Tim wrote:
> > -----Original Message-----
> > From: josh@joshtriplett.org
> > 
> > On Fri, Jul 31, 2020 at 05:00:12PM +0200, Arnd Bergmann wrote:
> > > The majority of the code in the kernel deals with hardware that was made
> > > a long time ago, and we are regularly discussing which of those bits are
> > > still needed. In some cases (e.g. 20+ year old RISC workstation support),
> > > there are hobbyists that take care of maintainership despite there being
> > > no commercial interest. In other cases (e.g. x.25 networking) it turned
> > > out that there are very long-lived products that are actively supported
> > > on new kernels.
> > >
> > > When I removed support for eight instruction set architectures in 2018,
> > > those were the ones that no longer had any users of mainline kernels,
> > > and removing them allowed later cleanup of cross-architecture code that
> > > would have been much harder before.
> > >
> > > I propose adding a Documentation file that keeps track of any notable
> > > kernel feature that could be classified as "obsolete", and listing
> > > e.g. following properties:
> > >
> > > * Kconfig symbol controlling the feature
> > >
> > > * How long we expect to keep it as a minimum
> > >
> > > * Known use cases, or other reasons this needs to stay
> > >
> > > * Latest kernel in which it was known to have worked
> > >
> > > * Contact information for known users (mailing list, personal email)
> > >
> > > * Other features that may depend on this
> > >
> > > * Possible benefits of eventually removing it
> > 
> > We had this once, in the form of feature-removal-schedule.txt. It was,
> > itself, removed in commit 9c0ece069b32e8e122aea71aa47181c10eb85ba7.
> > 
> > I *do* think there'd be value in having policies and processes for "how
> > do we carefully remove a driver/architecture/etc we think nobody cares
> > about". That's separate from having an actual in-kernel list of "things
> > we think we can remove".
> 
> I'm not sure the documents are the same.  I think what Arnd is proposing
> is more of a "why is this thing still here?" document.  When someone does
> research into who's still using a feature and why, that can be valuable information
> to share so that future maintenance or removal decisions can be better informed.
> 
> Maybe e-mails are sufficient for this, but they'd be harder to find than something in
> the kernel source. But that supposes that people would look at the file, which 
> appears didn't happen with feature-removal-schedule.txt.

Ah, I see. So this *isn't* about "features we want to remove", this is
"features people might think we should remove, but here's the
documentation for why we aren't"? More of an
obscure-but-still-wanted-features.txt?
