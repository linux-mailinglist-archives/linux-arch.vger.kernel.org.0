Return-Path: <linux-arch+bounces-11339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2EA813D8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E623189B42F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Apr 2025 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA8B23C361;
	Tue,  8 Apr 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOx/f5Uy"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAE22DFA4;
	Tue,  8 Apr 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134018; cv=none; b=OJqMvpF+9R/W93RWHHyXjWIL01L2tzFyiLqui4E9Q2f7BHCS9yp5GxGN6Y4qeFw9t86V6sD8fIm8e0Gi8axRpuKh6SEy86ME2Awe9UFkiVesna31HP3Wrb67TCukZn+WeBFXNtGZ0eJoFgNiwCeNXet4UJio+88/2dB/lmbsZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134018; c=relaxed/simple;
	bh=ZoBMwdYlPj8YLGM8IDapyHFDVDxXMdmPb7Zir1vyW34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiRquIEYePD3f0Y3FGltuZcSkvXTipImNl3HOtCt1nJfSZYdvqB65/5PWiYlEe4zOgpTFcbzvk4pzprPQNw7BZSQf5dq5sGRyR19oc6V3FPLNii9tltvKPiTmUGPWO5h4bBG9AHssaoCRjjfGEC9REInFiKY/EI/7WWFL5JaZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KOx/f5Uy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5tE/97qDLNInhrSv41O24hz6k5it7lrWx1B8nzMlNNY=; b=KOx/f5UyipuUZDxVD5jHE+qtD2
	eu74DLpYFMC1h+xs/K+Yc3/IGk3Plq8aRYPYtEobrVYMeFJvoXpTOtoRRqrUJBUPtc/oY9cvtp/lD
	gKRIIV5K3Ay5rO73pxFfgDEaeM4l+kvMJBV/UxCy4LKTUvAXPVBmtE0chmbr9c2fpSmrm4V1I0bvt
	qVHlSwz6Tx3BeDuT4Zh7G7fi3wuMGEI1XTtoz+ESpsT2mM38529r1gpY1IKCfBTHF7RDItD5mxBJ7
	Wah2MxhHtGeY0sW+tFM+xPtnysJSl7HjGpXBzLxKQwN1mbRbcboMHLNFuI3tvLHMlCUzQg23htLGm
	jl0FA5PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2Cvg-00000000Iq7-25G6;
	Tue, 08 Apr 2025 17:40:08 +0000
Date: Tue, 8 Apr 2025 18:40:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 02/12] x86: pgtable: Always use pte_free_kernel()
Message-ID: <Z_VfeFgrj23Oa0fX@casper.infradead.org>
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
 <20250408095222.860601-3-kevin.brodsky@arm.com>
 <409d2019-a409-4e97-a16f-6b345b0f5a38@intel.com>
 <Z_VQxyqkU8DV7QGy@casper.infradead.org>
 <9247436d-ae01-4eb8-bd5d-370b2fb2eebc@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9247436d-ae01-4eb8-bd5d-370b2fb2eebc@intel.com>

On Tue, Apr 08, 2025 at 09:54:42AM -0700, Dave Hansen wrote:
> On 4/8/25 09:37, Matthew Wilcox wrote:
> > On Tue, Apr 08, 2025 at 08:22:47AM -0700, Dave Hansen wrote:
> >> Are there any tests for folio_test_pgtable() at free_page() time? If we
> >> had that, it would make it less likely that another free_page() user
> >> could sneak in without calling the destructor.
> > It's hidden, but yes:
> > 
> > static inline bool page_expected_state(struct page *page,
> >                                         unsigned long check_flags)
> > {
> >         if (unlikely(atomic_read(&page->_mapcount) != -1))
> >                 return false;
> > 
> > PageTable uses page_type which aliases with mapcount, so this check
> > covers "PageTable is still set when the last refcount to it is put".
> 
> Huh, so shouldn't we have ended up in bad_page() for these, other than:
> 
>         pagetable_dtor(virt_to_ptdesc(pmd));
>         free_page((unsigned long)pmd);

I think at this point in Kevin's series, we don't call the ctor for
these pages, so we never set PageTable() on them.  I could be wrong;
as Kevin says, this is all very twisty and confusing with exceptions and
exceptions to exceptions.  This series should reduce the confusion.

