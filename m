Return-Path: <linux-arch+bounces-1741-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3383F0F5
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4701F214A8
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jan 2024 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71C1D6B8;
	Sat, 27 Jan 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEnq8nG6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE515AF9;
	Sat, 27 Jan 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395169; cv=none; b=FH9vfSoe2rPApoyBjlIgNaKRuXKHhejzf3ZcgSjM5xf1juAfpkhjU1dR4v4tiHYwHI0e35rUEVTBGNhAbRtm3MsEklZRPbMnmAAz0FnbVl1YYUbwkxEty7CCp8vS2BGUNyjEYVIpi1nfUEFY8oG3mXQsiFHfyyKD9qOD/kuIHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395169; c=relaxed/simple;
	bh=KILTeulNNllPlgSx8Rimk1bazTt4jJRe8N47roW2STk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tNIiW3em4CF3mqStbA6ZNDEm3UAwBQRwrfz8HMzcjQrok+8VnSBtt268vyIFVbytWFw2h2MeMceMGfLsXchiMS/Q5OcKRr93026LTAzaZz3Kq+lRxWYTBBIDbucZDgFGFhXEETN8DWukE7tJetId3OYjeqcSDdoxMoPo+Obk6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEnq8nG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66009C433F1;
	Sat, 27 Jan 2024 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706395168;
	bh=KILTeulNNllPlgSx8Rimk1bazTt4jJRe8N47roW2STk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IEnq8nG6w8KAzYK9CYm5TyiDZpEF4UOBcq38OH/kDHd6DgpysPY4scZ00FAkKcup3
	 HX09PCGMGQB84qgsiBJHIlrsYnASDHcdc4GXWzW77g2SvcboqNypn71najuV6HsVwd
	 UcafB9IfC9RD6H76trkDG7SdxAcmhTjyx7YF7RJ6aeix88X3x999ojFH4NrCom+z67
	 Q8rXaGTpKBVcq5NKC1Y08novzvGaiOT1rWnySkkB8ubGJ/5PQOmwZuiNRpO1XlRO+t
	 lUsrH5LX1A0OGxDBxhH8/UBOY1H7afzXxugYqmy22awjLHYpj8fB2wXVNcFWJ8G+SB
	 9S81rtqRHx6iw==
Date: Sat, 27 Jan 2024 16:39:26 -0600
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
Message-ID: <20240127223926.GA461814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70b8db3ec0f8730fdd23dae21edc1a93d274b048.camel@redhat.com>

On Fri, Jan 26, 2024 at 02:59:20PM +0100, Philipp Stanner wrote:
> On Tue, 2024-01-23 at 15:05 -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 11, 2024 at 09:55:40AM +0100, Philipp Stanner wrote:
> ...

> > > -void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> > > +/**
> > > + * pci_iounmap - Unmapp a mapping
> > > + * @dev: PCI device the mapping belongs to
> > > + * @addr: start address of the mapping
> > > + *
> > > + * Unmapp a PIO or MMIO mapping.
> > > + */
> > > +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> > 
> > Maybe move the "p" to "addr" rename to the patch that fixes the
> > pci_iounmap() #ifdef problem, since that's a trivial change that
> > already has to do with handling both PIO and MMIO?  Then this patch
> > would be a little more focused.
> > 
> > The kernel-doc addition could possibly also move there since it isn't
> > related to the unification.
> 
> You mean the one from my devres-patch-series? Or documentation
> specifically about pci_iounmap()?

I had in mind the patch that fixes the pci_iounmap() #ifdef problem,
which (if you split it out from 1/5) would be a relatively trivial
patch.  Or the kernel-doc addition could be its own separate patch.
The point is that this unification patch is fairly complicated, so
anything we can do to move things unrelated to unification elsewhere
makes this one easier to review.

> > It seems like implementing iomem_is_ioport() for the other arches
> > would be straightforward and if done first, could make this patch
> > look
> > tidier.
> 
> That would be the cleanest solution. But the cleaner you want to be,
> the more time you have to spend ;)
> I can take another look and see if I could do that with reasonable
> effort.
> Otherwise I'd go for:
> 
> > Or if the TODOs can't be done now, maybe the iomem_is_ioport()
> > addition could be done as a separate patch to make the unification
> > more obvious.

It looks like iomem_is_ioport() is basically the guards in
pci_iounmap() implementations that, if true, prevent calling
iounmap(), so it it seems like they should be trivial, e.g.,

  return !__is_mmio(addr); # alpha

  return (addr < VMALLOC_START || addr >= VMALLOC_END); # arm

  return isa_vaddr_is_ioport(addr) || pcibios_vaddr_is_ioport(addr); # microblaze

Unless they're significantly more complicated than that, I don't see
the point of deferring them.

> > > + */
> > > +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> > > +bool iomem_is_ioport(void __iomem *addr)
> > >  {
> > > -       IO_COND(addr, /* nothing */, iounmap(addr));
> > > +       unsigned long port = (unsigned long __force)addr;
> > > +
> > > +       if (port > PIO_OFFSET && port < PIO_RESERVED)
> > > +               return true;
> > > +
> > > +       return false;
> > >  }
> > > -EXPORT_SYMBOL(pci_iounmap);
> > > -#endif /* CONFIG_PCI */
> > > +#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

