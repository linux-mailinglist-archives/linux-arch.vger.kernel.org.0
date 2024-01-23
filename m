Return-Path: <linux-arch+bounces-1491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF09839AD3
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C44F28C1D2
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333F1A27C;
	Tue, 23 Jan 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fooOJ8Om"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E472C1B7;
	Tue, 23 Jan 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043955; cv=none; b=PZGgKQfIcpLItRIESsVFLtkqYg1Lwmphhj2HIWvAJoDe1kKGhi+AfeOLGbge0zM+S6UuoQH85IEUXXZqvZ1EvADRJ95h5Kng8h7H5btNL0v2oUtcx1kkR+9MMMdUtgguXQ/0YswmKCIroBkSVUkjr8Aqux21B6b30+4UoKSDGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043955; c=relaxed/simple;
	bh=m2HBN4VZRC/C+9nNuZ2wRcZhlWr2WEDdSTFp4kKy/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nt5Xsf00D9gnfkhfNqvVT7kQxyEuNOPx8B3RlcLG6KamIWvfq3WEZDDDuFaAWs/rZ+mzI1zThJL2mObQTweLD/wuHNkKBnE1PzRoqzlrKXc03fVTAyMDFOSYiA9QqlZiO7D9XA4oU6vezyim+S4yIaC2zOeQcX/KrFk3PCGLm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fooOJ8Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7367C433C7;
	Tue, 23 Jan 2024 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706043955;
	bh=m2HBN4VZRC/C+9nNuZ2wRcZhlWr2WEDdSTFp4kKy/w0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fooOJ8OmjLLi2sPby3Nl9MIdlHEvrfpFAihuYVxQo7hw3kXFFU5BBhxtw9Es1zdAj
	 uoOB0eSr5ODQnl0ytYcy3OkfxpRzQjFJnBKHZ+fDCK4snp9/hH0t4zU8HwzlbMDR3/
	 6Tehk2Yr5ZO4dq1HTqpQ6d5YAaspS+XcH8hzvVwTpn0ASuhQKN1mQ0SmO1glocZcQh
	 F9OwjtAM5s13GqLhpK3eXiVzhE8v353r8oXsa0D6rKk/mOrD4YWC4g6FNOARHFrJgH
	 slQkXMU46b2Z4Y1akcI+nN92cTY2qvr2mqsrUq7FPm2h/3xD6dzXXXdBBeHkAQn8DD
	 i3/gzB5+uueSg==
Date: Tue, 23 Jan 2024 15:05:53 -0600
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
Message-ID: <20240123210553.GA326783@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111085540.7740-6-pstanner@redhat.com>

On Thu, Jan 11, 2024 at 09:55:40AM +0100, Philipp Stanner wrote:
> The implementation of pci_iounmap() is currently scattered over two
> files, drivers/pci/iomap.c and lib/iomap.c. Additionally,
> architectures can define their own version.
> 
> To have only one version, it's necessary to create a helper function,
> iomem_is_ioport(), that tells pci_iounmap() whether the passed address
> points to an ioport or normal memory.
> 
> iomem_is_ioport() can be provided through two different ways:
>   1. The architecture itself provides it. As of today, the version
>      coming from lib/iomap.c de facto is the x86-specific version and
>      comes into play when CONFIG_GENERIC_IOMAP is selected. This rather
>      confusing naming is an artifact left by the removal of IA64.
>   2. As a default version in include/asm-generic/io.h for those
>      architectures that don't use CONFIG_GENERIC_IOMAP, but also don't
>      provide their own version of iomem_is_ioport().
> 
> Once all architectures that support ports provide iomem_is_ioport(), the
> arch-specific definitions for pci_iounmap() can be removed and the archs
> can use the generic implementation, instead.
> 
> Create a unified version of pci_iounmap() in drivers/pci/iomap.c.
> Provide the function iomem_is_ioport() in include/asm-generic/io.h
> (generic) and lib/iomap.c ("pseudo-generic" for x86).
> 
> Remove the CONFIG_GENERIC_IOMAP guard around
> ARCH_WANTS_GENERIC_PCI_IOUNMAP so that configs that set
> CONFIG_GENERIC_PCI_IOMAP without CONFIG_GENERIC_IOMAP still get the
> function.
> 
> Add TODOs for follow-up work on the "generic is not generic but
> x86-specific"-Problem.
> ...

> +++ b/drivers/pci/iomap.c
> @@ -135,44 +135,30 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
>  EXPORT_SYMBOL_GPL(pci_iomap_wc);
>  
>  /*
> - * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
> - * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
> - * the different IOMAP ranges.
> + * This check is still necessary due to legacy reasons.
>   *
> - * But if the architecture does not use the generic iomap code, and if
> - * it has _not_ defined it's own private pci_iounmap function, we define
> - * it here.
> - *
> - * NOTE! This default implementation assumes that if the architecture
> - * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
> - * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
> - * and does not need unmapping with 'ioport_unmap()'.
> - *
> - * If you have different rules for your architecture, you need to
> - * implement your own pci_iounmap() that knows the rules for where
> - * and how IO vs MEM get mapped.
> - *
> - * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
> - * from legacy <asm-generic/io.h> header file behavior. In particular,
> - * it would seem to make sense to do the iounmap(p) for the non-IO-space
> - * case here regardless, but that's not what the old header file code
> - * did. Probably incorrectly, but this is meant to be bug-for-bug
> - * compatible.

Moving this comment update to the patch that adds the ioport_unmap()
call would make that patch more consistent and simplify this patch.

> + * TODO: Have all architectures that provide their own pci_iounmap() provide
> + * iomem_is_ioport() instead. Remove this #if afterwards.
>   */
>  #if defined(ARCH_WANTS_GENERIC_PCI_IOUNMAP)
>  
> -void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> +/**
> + * pci_iounmap - Unmapp a mapping
> + * @dev: PCI device the mapping belongs to
> + * @addr: start address of the mapping
> + *
> + * Unmapp a PIO or MMIO mapping.

s/Unmapp/Unmap/ (twice)

> + */
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)

Maybe move the "p" to "addr" rename to the patch that fixes the
pci_iounmap() #ifdef problem, since that's a trivial change that
already has to do with handling both PIO and MMIO?  Then this patch
would be a little more focused.

The kernel-doc addition could possibly also move there since it isn't
related to the unification.

>  {
> -#ifdef ARCH_HAS_GENERIC_IOPORT_MAP
> -	uintptr_t start = (uintptr_t) PCI_IOBASE;
> -	uintptr_t addr = (uintptr_t) p;
> -
> -	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
> -		ioport_unmap(p);
> +#ifdef CONFIG_HAS_IOPORT_MAP
> +	if (iomem_is_ioport(addr)) {
> +		ioport_unmap(addr);
>  		return;
>  	}
>  #endif
> -	iounmap(p);
> +
> +	iounmap(addr);
>  }

> + * If CONFIG_GENERIC_IOMAP is selected and the architecture does NOT provide its
> + * own version, ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT makes sure that the generic
> + * version from asm-generic/io.h is NOT used and instead the second "generic"
> + * version from this file here is used.
> + *
> + * There are currently two generic versions because of a difficult cleanup
> + * process. Namely, the version in lib/iomap.c once was really generic when IA64
> + * still existed. Today, it's only really used by x86.
> + *
> + * TODO: Move this function to x86-specific code.

Some of these TODOs look fairly simple.  Are they actually hard, or
could they just be done now?

It seems like implementing iomem_is_ioport() for the other arches
would be straightforward and if done first, could make this patch look
tidier.

Or if the TODOs can't be done now, maybe the iomem_is_ioport()
addition could be done as a separate patch to make the unification
more obvious.

> + */
> +#if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> +bool iomem_is_ioport(void __iomem *addr)
>  {
> -	IO_COND(addr, /* nothing */, iounmap(addr));
> +	unsigned long port = (unsigned long __force)addr;
> +
> +	if (port > PIO_OFFSET && port < PIO_RESERVED)
> +		return true;
> +
> +	return false;
>  }
> -EXPORT_SYMBOL(pci_iounmap);
> -#endif /* CONFIG_PCI */
> +#endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
> -- 
> 2.43.0
> 

