Return-Path: <linux-arch+bounces-7952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2C997EBD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4808CB226CE
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E621BC094;
	Thu, 10 Oct 2024 07:03:49 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5641B652C;
	Thu, 10 Oct 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543829; cv=none; b=HZ9Lm7hOM3v2yQRoaV3rKXisXwUbXZV4F4O+YjMhDJBMVmICdW9+HcnNdqEPRf7dQV6YNdM/Bf8o2ybg8wK8FITz5VUgXncC8CPMEmMLEpSHzClO5Xa8/z74rwnloG4nXIqKozlYWpcQsw7c1xUWcULI269PvVOg/x+xOuVw9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543829; c=relaxed/simple;
	bh=pbSr/1Shdew0RS88jV/eYuiU8d/MNAZikWOcMgX/xoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRytG90IJuqMbeq6AuXoeNaqLiHSLTm3Fxl0SCP++1RhifFZ8+pqiOCDAy/cR30w+EQBsnKmaUbsfsWz5adps69WMQU4iKbEors6gfrM/asv9RWsJTzqPKQV7bg1txjxrRLbeARwunT6EL8fSv4AMnbdwZLEiw/Hf3BwDx11q5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F3E4227A8E; Thu, 10 Oct 2024 09:03:43 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:03:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
Message-ID: <20241010070342.GB6674@lst.de>
References: <20241009114334.558004-1-hch@lst.de> <20241009114334.558004-2-hch@lst.de> <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 09, 2024 at 02:06:27PM +0000, Arnd Bergmann wrote:
> This is clearly a good idea, and I'm happy to take that through
> the asm-generic tree if there are no complaints.
> 
> Do you have any other patches that depend on it?

Well, I have new code that would benefit from these helpers, but just
open coding it for now and then doing a swipe to clean that up later
together with the existing open coded versions is easy enough.

> > -/*
> > - * Change "struct page" to physical address.
> > - */
> > -static inline phys_addr_t page_to_phys(struct page *page)
> > -{
> > -	unsigned long pfn = page_to_pfn(page);
> > -
> > -	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !pfn_valid(pfn));
> > -
> > -	return PFN_PHYS(pfn);
> > -}
> 
> This part is technically a change in behavior, not sure how
> much anyone cares.

Well, the only other comment to the patch so far mentioned it.
It also feels like a useful check, but I'm a bit worried about
it triggering in various new places.  Although that's just with
CONFIG_DEBUG_VIRTUAL and probably points to real bugs, so maybe
adding it everywhere is a good idea.

> > +#define page_to_phys(page)	__pfn_to_phys(page_to_pfn(page))
> > +#define phys_to_page(phys)	pfn_to_page(__phys_to_pfn(phys))
> 
> I think we should try to have a little fewer nested macros
> to evaluate here, right now this ends up expanding
> __pfn_to_phys, PFN_PHYS, PAGE_SHIFT, CONFIG_PAGE_SHIFT,
> page_to_pfn and __page_to_pfn. While the behavior is fine,
> modern gcc versions list all of those in an warning message
> if someone passes the wrong arguments.
> 
> Changing the two macros above into inline functions
> would help as well, but may cause other problems.

Doing them as inlines seems useful to me, let me throw that at
the buildbot and see if anything explodes.

> On a related note, it would be even better if we could come
> up with a generic definition for either __pa/__va or
> virt_to_phys/phys_to_virt. Most architectures define one
> of the two pairs in terms of the other, which leads to
> confusion with header include order.

Agreed, but that's a separate project.


