Return-Path: <linux-arch+bounces-10199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C380A3A393
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C7163527
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15F26F46F;
	Tue, 18 Feb 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LWsZYxLw"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D926AABB;
	Tue, 18 Feb 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898409; cv=none; b=qGlfKbRLE/O4//rMM5XtGkNPzGvbfDPP0q9LauQg72QK6b/z1Vh+0eEblOhsyWh8SOgZlqnmtCUIzF2x0LzoUr2/ZG/7Ag7qrWifR/n+mBn+UI5Ww1NmF6kl/nggjhXs6uq6VISE73DZZEP3Pme4LW+KQqnO3Hn1wS/elRn0Qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898409; c=relaxed/simple;
	bh=Jj/Lm99sNr5qlEf9ineRkgBIvD/KNQKrlVfTr/mampc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7zPHBbePN9SFEbgHzqM+cZj3A86fkD5KTGlU+N1tmIEWUgvseii0OvlDuUbJCb351YNgGh3qEmqMB3HsVwaLu/vtvyqvUAbFHGOamAo+3P5qRzeymbSwLZLfp5U48i69gug7ebGTA17fX6oOiRUy4qLGzQLBDctEA/OSsx8rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LWsZYxLw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9hy7D4lXck0JMXuwDNv/ayTqn9sb236P26uPki4bGys=; b=LWsZYxLwr4+Ph4Uz9Qv2fQmhiU
	V8qiO7S3WT217jOSvW0lhI9LpXKrcwZOM06+tjwwMhOeoVpCoMdIQA9DO8c/ARLRFHdXwaCao64Gc
	0+OhNhlqNdt05UtXSKMz1nnQcYHQDuuGzpj+SRtsC+mdTJS4V/RuYZ0bRiLKTpDTQ3t7wqIyGYbux
	SGBbpBZ/PMwUanq05+noL/j2Ct5d1MALfYTOjTSse/wVbBRN4mRzwlyg9JcvWZXML99DW/xt/a2r7
	ZT5DkvhXhxhnRlJTMi/789+ogpaLyqSd/6bjyWwx8OVrpu2XyZlJlj4HbvWgFArqygd7YCL0kZHtG
	161YexWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkR3O-00000003MNz-3Cxq;
	Tue, 18 Feb 2025 17:06:38 +0000
Date: Tue, 18 Feb 2025 17:06:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7S-HgdXls65goJx@casper.infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
 <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Tue, Feb 18, 2025 at 05:20:28PM +0100, Alexander Gordeev wrote:
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
> >  
> >  static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> >  {
> > -	unsigned long physpage = page_to_phys(page);
> > -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> > -
> > -	if (pte_write(__pte) && PageDirty(page))
> > -		__pte = pte_mkdirty(__pte);
> > -	return __pte;
> > +	return mk_pte_phys(page_to_phys(page), pgprot);
> >  }
> 
> With the above the implicit dirtifying of hugetlb PTEs (as result of
> mk_huge_pte() -> mk_pte()) in make_huge_pte() is removed:
> 
> static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> 		bool try_mkwrite)
> {
> 	...
> 	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
> 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> 					 vma->vm_page_prot)));
> 	} else {
> 		entry = huge_pte_wrprotect(mk_huge_pte(page,
> 					   vma->vm_page_prot));
> 	}

Took me a moment to spot how this was getting invoked; for anyone else
playing along, it's mk_huge_pte() which calls mk_pte().

But I'm not sure how you lose out on the PTE being marked dirty.  In
the first arm that you've quoted, the pte is made dirty anyway.  In the
second arm, it's being writeprotected, so marking it dirty isn't a
helpful thing to do because writing to it will cause a fault anyway?

I know s390 is a little different, so there's probably something I'm
missing.

