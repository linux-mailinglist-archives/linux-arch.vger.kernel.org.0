Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDCD5DDC2
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 07:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfGCFbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 01:31:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:60527 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfGCFbi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jul 2019 01:31:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x635VVjM025266;
        Wed, 3 Jul 2019 00:31:32 -0500
Message-ID: <75cae9fa146ec7b28d9da7deaf339e95f77e0efd.camel@kernel.crashing.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Date:   Wed, 03 Jul 2019 15:31:30 +1000
In-Reply-To: <20190703030855.GI128603@google.com>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
         <20190702201914.GD128603@google.com>
         <eaea693094caecf291e2a40a7ed88cd9fb273ab8.camel@kernel.crashing.org>
         <20190703030855.GI128603@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-07-02 at 22:08 -0500, Bjorn Helgaas wrote:
> 
> > No it actually is. The policy on these is to rather explicitely ignore
> > what was set. If you just switch to honoring it, a good number of those
> > platforms will break. (We know that happens on arm64 as we are trying
> > to do just that).
> 
> It's only different if you're assuming something about how Linux
> allocates things.  That assumption is implicit, which makes this
> fragile.

I don't understand your argument.

Linux has *always* been responsible for the full assignment on these,
there is no UEFI/ACPI, no runtime firmware involved, I don't see the
point in trying to change that policy. The owners of these platforms
chose to do things that way, effectively assuming that Linux will do a
better job than whatever firmware (if any) did.

I remember cases for example where the firmware would just hard wire a
BAR for a boot device to some random value right in the middle of the
address space. If we started honoring this,  it would effectively have
split the already small available memory space for PCI on that card, it
made no sense to try to keep that setup. This was a case of some
obscure ppc embedded board, but that doesn't matter, I dont' see why we
should even consider changing the policy on these things. It's not like
we have to maintain two different algorithms anyway, we're just
skipping the claim pass, At least with my initial patch series it will
be obvious and done in a single place.

> You could make this concrete by supplying an example of the actual
> firmware assignments that are broken, and the better ones that Linux
> produces.  I'm talking about window and BAR values, not all the
> needless differences in how the resource tree is managed.

Why would I waste time chasing the hundreds of random embedded boards
around to do that ? I really completely fail to see your point and what
benefit we would have in trying to change this.

> > Part of the problem is it's not always easy to figure out whether the
> > existing setup is "broken". It could just be "very suboptimal" for
> > example. Or broken in ways we don't detect early enough to do a good
> > job about it.
> > 
> > I really wouldn't try to change that at this point. Those platforms are
> > happy with Linux doing the complete setup the way it does, I don't see
> > areason to change it. In fact, in some cases we can do even better (see
> > below).
> > 
> > > "Reassign everything" is clearly allowed to produce the exact same
> > > result as "honor what has been setup and (re)assign what's left or
> > > broken".
> > 
> > Provided we have some IA that can figure out what "broken" means :)
> > 
> > > I claim any difference between the two is actually a fragile
> > > dependency on the Linux assignment algorithm that is likely to break
> > > as that algorithm changes.
> > > 
> > > Or am I missing something?
> > 
> > Well, reassign-everything isn't that likely to break when Linux changes
> > as long as linux doesn't change in ways that are completely busted
> > anyway. It's a pretty simple process really. And that would be caught
> > quickly since a LOT of platforms use that method.
> > 
> > As for the reasons, well, this tends to be embedded platforms where the
> > firmware may have left crap behind that we really don't want to honor
> > and can't really detect as "broken".
> > 
> > For example, switches sized incorrectly, or too big, sub optimal
> > placement with everything in 32-bit space and no room left for SR-IOV,
> > etc...
> 
> These are things we should fix by improving the generic assignment
> code (this might be what you're alluding to below).  I do not want a
> "reassign everything" mode that does things differently than the
> "change what's broken" mode.

They don't fundamentally. With my patches, "reassign everything"
basically consists of calling pci_assign_unassigned_* without first
claiming existing resources. It's fundamentally the same algorithm.

The one thing I'm considering changing later is to use the "bridge"
variant instead so we get distribution of the available space, though
I'd have to make it work at the root. But that's separate and we can
discuss it later.

> I know we sort of have that today, but if we're reworking this code, I
> don't want to perpetuate that kind of black magic.  If we can make the
> difference between "reassign everything" and "change what's broken"
> explicit, then we can make progress.

I don't think it's black magic. As I said above, the definition of
"broken" in that context is almost impossible to get right. It could
just be massively sub-optimal. If we let Linux claim, it will and will
quickly run out of space if any hotplug or SR-IOV activity tries to
take place later.

Those platforms have historically chosen to ignore the FW allocation
for whatever reasons, changing that isn't something we should aim to
change, I don't see the point or benefit. And the testing burden would
be astronomical.

If anything, history has chown us that we are a lot better at assigning
resources that most embedded firmware out there.

> > In fact, I'm thinking that on these platforms (which are basically
> > *all* arm32, all embedded ppc, and pretty much all other non-
> > server/desktop archs that aren't x86), we could in fact go one step
> > further and improve the default algorithm by applying the "distribute
> > available space" method at the top level (we currently only do it for
> > hotplug bridges below that, so the top level bridges will get the
> > default which, for hotplug, isn't likely to be enough).

Cheers,
Ben.

