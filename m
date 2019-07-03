Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F705E522
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 15:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCNRE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 09:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfGCNRE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jul 2019 09:17:04 -0400
Received: from localhost (84.sub-174-234-39.myvzw.com [174.234.39.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B73218A0;
        Wed,  3 Jul 2019 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562159822;
        bh=BQWh2gky1OFcj/S72HsWkahDJvcrNpCTWiuEr8aLsyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQI84JVhSS3kNk9Wk1vJRVBfl0emlNeoSM1UOVfWFiyLehF+72Qgh73aDaWwFutPl
         JilSujhjGc2AyGjyHWJO7/UWO/0RuLitQ4GA2z85GdBsvOmPfqLVf9HO2fKXGehHlC
         7j4WjoiBBhUdvGzENtIb/xcMqGvEWu21Ns+B1qAc=
Date:   Wed, 3 Jul 2019 08:17:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
Message-ID: <20190703131700.GJ128603@google.com>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
 <20190702201914.GD128603@google.com>
 <eaea693094caecf291e2a40a7ed88cd9fb273ab8.camel@kernel.crashing.org>
 <20190703030855.GI128603@google.com>
 <75cae9fa146ec7b28d9da7deaf339e95f77e0efd.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75cae9fa146ec7b28d9da7deaf339e95f77e0efd.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 03, 2019 at 03:31:30PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-07-02 at 22:08 -0500, Bjorn Helgaas wrote:
> > 
> > > No it actually is. The policy on these is to rather explicitely ignore
> > > what was set. If you just switch to honoring it, a good number of those
> > > platforms will break. (We know that happens on arm64 as we are trying
> > > to do just that).
> > 
> > It's only different if you're assuming something about how Linux
> > allocates things.  That assumption is implicit, which makes this
> > fragile.
> 
> I don't understand your argument.
> 
> Linux has *always* been responsible for the full assignment on these,
> there is no UEFI/ACPI, no runtime firmware involved, I don't see the
> point in trying to change that policy. The owners of these platforms
> chose to do things that way, effectively assuming that Linux will do a
> better job than whatever firmware (if any) did.
> 
> I remember cases for example where the firmware would just hard wire a
> BAR for a boot device to some random value right in the middle of the
> address space. If we started honoring this,  it would effectively have
> split the already small available memory space for PCI on that card, it
> made no sense to try to keep that setup. This was a case of some
> obscure ppc embedded board, but that doesn't matter, I dont' see why we
> should even consider changing the policy on these things. It's not like
> we have to maintain two different algorithms anyway, we're just
> skipping the claim pass, At least with my initial patch series it will
> be obvious and done in a single place.
> 
> > You could make this concrete by supplying an example of the actual
> > firmware assignments that are broken, and the better ones that Linux
> > produces.  I'm talking about window and BAR values, not all the
> > needless differences in how the resource tree is managed.
> 
> Why would I waste time chasing the hundreds of random embedded boards
> around to do that ?

All I asked for was a single example so we could talk about something
specific instead of handwaving, and your example of a device in the
middle of the address space was a good one.

That could happen just as easily on a "reassign if broken" platform
like x86 as on a "reassign everything" platform, so I would rather
make the generic code smart enough to deal with it than have the
platform or driver set a "reassign everything" flag.

But I think we're really talking past each other, and we're not
talking about an actual patch, so I don't think we need to come to any
conclusions yet.

Bjorn
