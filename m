Return-Path: <linux-arch+bounces-1797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CECF8411D7
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCACE289A69
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90FE3F9FF;
	Mon, 29 Jan 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXDLE8ku"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7F6F06A;
	Mon, 29 Jan 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552067; cv=none; b=KuKhZ70gmIADPOeFh8xOI6GA4Robvo6SrHZd+N6zrBJYjx04Wfk8w/xZcY0RGQ29cCwh3OfU/Eove6DYtVar0eV7BVv4MjOY2PVGBF/ZQZ1utGeHP1Nf6R+dMArt8PN0pWAcIuMmR+WEw7JMSRsUoUwp/10MKLooenMpL854vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552067; c=relaxed/simple;
	bh=OpaHHXwWGswZFGgb6hF5IDAZmEE7mu74bOfKnOSfzPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RGtRFNkDkLUr2CsPMdlzEEA+Iv0/XjqYJjujzFibk6XEpjR/H1qJUqQ61IU6Cjh5GEar3P24yWWW97jdcBwxL1QmNpYBzvhdaFBX4giiBDM8IBioLtAE9vSUBPb1kdJfoHP60QIjxgOnsrvhddioGNiQjchpNLQwjg/KhMxCQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXDLE8ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09AFC433F1;
	Mon, 29 Jan 2024 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706552067;
	bh=OpaHHXwWGswZFGgb6hF5IDAZmEE7mu74bOfKnOSfzPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NXDLE8kuzXd3yrrulQlwOwX6prTbYlVlaN/5nKI8326saPS5c5t5pMaevyjiE/7Ga
	 asEObt9UrGivLe/03HIquXhXALcI5iSHGjDdsezhEyLNLrAVQUGVyxwdFbiSzhoxnB
	 lKkQsSw/v8s+08VNSbUYYi9NFulNIjOUVK6B9IMCryJRkTyqmoBHmXL08sl/xYxBdn
	 oBjD/2gZCkopu8FEPCYda/NVnJd20YuVR5xcEExreQArVAv64wuohAI8ZIlh5sGVGc
	 2vSmZv26y319DnH4JUDeCDURSfUqwy10ElKWbduL0dnQYGCKbUIbn8gI5uoNAKkykk
	 eW1agFIi5COdA==
Date: Mon, 29 Jan 2024 12:14:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v5 RESEND 5/5] lib, pci: unify generic pci_iounmap()
Message-ID: <20240129181425.GA469470@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e655978d5f06ca58f36d531a9f789420fe959fd1.camel@redhat.com>

On Mon, Jan 29, 2024 at 11:43:34AM +0100, Philipp Stanner wrote:
> On Sat, 2024-01-27 at 16:39 -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 26, 2024 at 02:59:20PM +0100, Philipp Stanner wrote:
> > > On Tue, 2024-01-23 at 15:05 -0600, Bjorn Helgaas wrote:
> > > > On Thu, Jan 11, 2024 at 09:55:40AM +0100, Philipp Stanner wrote:
> > > ...
> > 
> > > > > -void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> > > > > +/**
> > > > > + * pci_iounmap - Unmapp a mapping
> > > > > + * @dev: PCI device the mapping belongs to
> > > > > + * @addr: start address of the mapping
> > > > > + *
> > > > > + * Unmapp a PIO or MMIO mapping.
> > > > > + */
> > > > > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> > > > 
> > > > Maybe move the "p" to "addr" rename to the patch that fixes the
> > > > pci_iounmap() #ifdef problem, since that's a trivial change that
> > > > already has to do with handling both PIO and MMIO?  Then this
> > > > patch
> > > > would be a little more focused.
> > > > 
> > > > The kernel-doc addition could possibly also move there since it
> > > > isn't
> > > > related to the unification.
> > > 
> > > You mean the one from my devres-patch-series? Or documentation
> > > specifically about pci_iounmap()?
> > 
> > I had in mind the patch that fixes the pci_iounmap() #ifdef problem,
> > which (if you split it out from 1/5) would be a relatively trivial
> > patch.  Or the kernel-doc addition could be its own separate patch.
> > The point is that this unification patch is fairly complicated, so
> > anything we can do to move things unrelated to unification elsewhere
> > makes this one easier to review.
> 
> I think it should be a separate patch, then, as it doesn't belong by
> 100% to any of the patches here. If I had to pick one, I'd have
> included the docu into patch #2 or #3.
> 
> Let's make it a separate one, following as a 6th patch in this series

Sounds good.

> > > > It seems like implementing iomem_is_ioport() for the other arches
> > > > would be straightforward and if done first, could make this patch
> > > > look
> > > > tidier.
> > > 
> > > That would be the cleanest solution. But the cleaner you want to
> > > be,
> > > the more time you have to spend ;)
> > > I can take another look and see if I could do that with reasonable
> > > effort.
> > > Otherwise I'd go for:
> > > 
> > > > Or if the TODOs can't be done now, maybe the iomem_is_ioport()
> > > > addition could be done as a separate patch to make the
> > > > unification
> > > > more obvious.
> > 
> > It looks like iomem_is_ioport() is basically the guards in
> > pci_iounmap() implementations that, if true, prevent calling
> > iounmap(), so it it seems like they should be trivial, e.g.,
> > 
> >   return !__is_mmio(addr); # alpha
> > 
> >   return (addr < VMALLOC_START || addr >= VMALLOC_END); # arm
> > 
> >   return isa_vaddr_is_ioport(addr) || pcibios_vaddr_is_ioport(addr);
> > # microblaze
> > 
> > Unless they're significantly more complicated than that, I don't see
> > the point of deferring them.

> ...
> This series' purpose actually always has been to move PCI functions to
> where they belong, i.e. from lib/ to drivers/pci.
> I originally didn't want to touch pci_iounmap(), since I deemed it too
> complicated. Arnd pushed for unifying it.
> 
> Anyways, investing much more time into this is beyond my time budget. I
> only started this series to have a cleaner basis to do the devres
> functions.
> 
> So my suggestions is that we either go with this cleanup here, which
> improves the situation at least somewhat, or we simply drop patch #5
> and leave pci_iounmap() as the last pci_ function in lib/

OK, let's drop #5 for now.  It definitely seems like where we should
go in the future, but I think it will make more sense when we can
include a few of the simple conversions that will show how it all fits
together.

Bjorn

