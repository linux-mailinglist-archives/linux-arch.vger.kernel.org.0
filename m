Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06365DCC1
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 05:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGCDJA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jul 2019 23:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfGCDI7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jul 2019 23:08:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFD120B1F;
        Wed,  3 Jul 2019 03:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562123338;
        bh=JvebqGXjIhB7fNybQT6wMPhqRJca1ZKx17UJUVSVgko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccUa2jMd2QJ3d500DW1jo4JOMFvcxRLOnOMtIm8N7bvWrF1ITXNvt3YFkgwxhlT7E
         KJFqEx6CyEp8t5ggZuDv5DJu6B6n1gmdIsAFgY1SaqMnZsJzWXuXOWA9tivb1JmsWN
         7OsMqxowx4+nHZg73IEj6b/PA3FOP+yylVsKpeKI=
Date:   Tue, 2 Jul 2019 22:08:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
Message-ID: <20190703030855.GI128603@google.com>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
 <20190702201914.GD128603@google.com>
 <eaea693094caecf291e2a40a7ed88cd9fb273ab8.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaea693094caecf291e2a40a7ed88cd9fb273ab8.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 03, 2019 at 10:16:49AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-07-02 at 15:19 -0500, Bjorn Helgaas wrote:
> > On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt
> > wrote:
> > > Hi !
> > > 
> > > As part of my cleanup and consolidation of the PCI resource
> > > assignment
> > > policies, I need to clarify something.
> > > 
> > > At the moment, unless PCI_PROBE_ONLY is set, a number of
> > > platforms/archs expect Linux to reassign everything rather than
> > > honor
> > > what has setup, then (re)assign what's left or broken.
> > 
> > I don't think "reassign everything" is any different from "honor what
> > has been setup and (re)assign what's left or broken".
> 
> No it actually is. The policy on these is to rather explicitely ignore
> what was set. If you just switch to honoring it, a good number of those
> platforms will break. (We know that happens on arm64 as we are trying
> to do just that).

It's only different if you're assuming something about how Linux
allocates things.  That assumption is implicit, which makes this
fragile.

You could make this concrete by supplying an example of the actual
firmware assignments that are broken, and the better ones that Linux
produces.  I'm talking about window and BAR values, not all the
needless differences in how the resource tree is managed.

> Part of the problem is it's not always easy to figure out whether the
> existing setup is "broken". It could just be "very suboptimal" for
> example. Or broken in ways we don't detect early enough to do a good
> job about it.
> 
> I really wouldn't try to change that at this point. Those platforms are
> happy with Linux doing the complete setup the way it does, I don't see
> areason to change it. In fact, in some cases we can do even better (see
> below).
> 
> > "Reassign everything" is clearly allowed to produce the exact same
> > result as "honor what has been setup and (re)assign what's left or
> > broken".
> 
> Provided we have some IA that can figure out what "broken" means :)
>
> > I claim any difference between the two is actually a fragile
> > dependency on the Linux assignment algorithm that is likely to break
> > as that algorithm changes.
> > 
> > Or am I missing something?
> 
> Well, reassign-everything isn't that likely to break when Linux changes
> as long as linux doesn't change in ways that are completely busted
> anyway. It's a pretty simple process really. And that would be caught
> quickly since a LOT of platforms use that method.
> 
> As for the reasons, well, this tends to be embedded platforms where the
> firmware may have left crap behind that we really don't want to honor
> and can't really detect as "broken".
> 
> For example, switches sized incorrectly, or too big, sub optimal
> placement with everything in 32-bit space and no room left for SR-IOV,
> etc...

These are things we should fix by improving the generic assignment
code (this might be what you're alluding to below).  I do not want a
"reassign everything" mode that does things differently than the
"change what's broken" mode.

I know we sort of have that today, but if we're reworking this code, I
don't want to perpetuate that kind of black magic.  If we can make the
difference between "reassign everything" and "change what's broken"
explicit, then we can make progress.

> In fact, I'm thinking that on these platforms (which are basically
> *all* arm32, all embedded ppc, and pretty much all other non-
> server/desktop archs that aren't x86), we could in fact go one step
> further and improve the default algorithm by applying the "distribute
> available space" method at the top level (we currently only do it for
> hotplug bridges below that, so the top level bridges will get the
> default which, for hotplug, isn't likely to be enough).
