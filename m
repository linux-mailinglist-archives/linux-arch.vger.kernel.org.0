Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873535DA20
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 03:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGCBB4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jul 2019 21:01:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:53004 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfGCBB4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jul 2019 21:01:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x630GoNZ006339;
        Tue, 2 Jul 2019 19:16:51 -0500
Message-ID: <eaea693094caecf291e2a40a7ed88cd9fb273ab8.camel@kernel.crashing.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Date:   Wed, 03 Jul 2019 10:16:49 +1000
In-Reply-To: <20190702201914.GD128603@google.com>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
         <20190702201914.GD128603@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-07-02 at 15:19 -0500, Bjorn Helgaas wrote:
> On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt
> wrote:
> > Hi !
> > 
> > As part of my cleanup and consolidation of the PCI resource
> > assignment
> > policies, I need to clarify something.
> > 
> > At the moment, unless PCI_PROBE_ONLY is set, a number of
> > platforms/archs expect Linux to reassign everything rather than
> > honor
> > what has setup, then (re)assign what's left or broken.
> 
> I don't think "reassign everything" is any different from "honor what
> has been setup and (re)assign what's left or broken".

No it actually is. The policy on these is to rather explicitely ignore
what was set. If you just switch to honoring it, a good number of those
platforms will break. (We know that happens on arm64 as we are trying
to do just that).

Part of the problem is it's not always easy to figure out whether the
existing setup is "broken". It could just be "very suboptimal" for
example. Or broken in ways we don't detect early enough to do a good
job about it.

I really wouldn't try to change that at this point. Those platforms are
happy with Linux doing the complete setup the way it does, I don't see
areason to change it. In fact, in some cases we can do even better (see
below).

> "Reassign everything" is clearly allowed to produce the exact same
> result as "honor what has been setup and (re)assign what's left or
> broken".

Provided we have some IA that can figure out what "broken" means :)

> I claim any difference between the two is actually a fragile
> dependency on the Linux assignment algorithm that is likely to break
> as that algorithm changes.
> 
> Or am I missing something?

Well, reassign-everything isn't that likely to break when Linux changes
as long as linux doesn't change in ways that are completely busted
anyway. It's a pretty simple process really. And that would be caught
quickly since a LOT of platforms use that method.

As for the reasons, well, this tends to be embedded platforms where the
firmware may have left crap behind that we really don't want to honor
and can't really detect as "broken".

For example, switches sized incorrectly, or too big, sub optimal
placement with everything in 32-bit space and no room left for SR-IOV,
etc...

In fact, I'm thinking that on these platforms (which are basically
*all* arm32, all embedded ppc, and pretty much all other non-
server/desktop archs that aren't x86), we could in fact go one step
further and improve the default algorithm by applying the "distribute
available space" method at the top level (we currently only do it for
hotplug bridges below that, so the top level bridges will get the
default which, for hotplug, isn't likely to be enough).

I plan to toy around once I'm done with the first stage of
consolidation (which I put on the backburner for a little bit as I have
to deal with something else first, but I'll get back to it soon).

Cheers,
Ben.



