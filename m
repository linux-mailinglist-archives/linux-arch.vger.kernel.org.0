Return-Path: <linux-arch+bounces-2544-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6B85CFE2
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 06:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75FD1F2235F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 05:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410D39AF3;
	Wed, 21 Feb 2024 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2fExemH9"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18139FE5;
	Wed, 21 Feb 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494194; cv=none; b=swyPSw7GBn7y3Wc2mkSaSElqVknkSSFmVWHP4ClS5268ce6feE1BhBMjdwTUzV19rMXqQOBenkr6PRWAPXBhdDOCyekw9ngOZ+RHYWeilxjTNAWTW5yoqfi4bXtRqF+4uKcYuj67FKaCZZGGTAhY/qRdtfmNWuJrFTOyRl+TO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494194; c=relaxed/simple;
	bh=8QWm8nSYrYgN5nzL9HZLCGbm1whZTwAknh4xx2cF9wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbhW5t9z5n9L2oRws+DxmdXWaW8lnQdRBs3K1tddVdWRX/gy6I768H0nKldwBCkLv1P/3BTOY7tWuzZoKcjlpYi9eUUXpaBIxcjSTRvcQ+rsGeAjaP8LKeDkPXP2ILmfoEkObCRrfRNaNOSZ3ShE8faT2C5TWUVPnmcEjM9G2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2fExemH9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vQxW7nd7WTaydKIv2J5Y5kbM61+Nggklag6qseDgVeA=; b=2fExemH9AAagfWsJpScQi4fgIL
	MiKDwwjqp+cfhpZ6P1ExyRC9YDKwblxKGnzWf25kmk4iYzoHAKSK1L8x77dZx1ueTo7fuv4EgIuTq
	SUgOzZkc98ORksYE7NcjzjsOrYtGdByWAKx/QmYpiKeRiebJMoeELiG9gX6eQ3eHrY9NrKVap/RO2
	XITlMawFAnTSkVjjtmvRXRNBAmU5GjUwX4XiYYqTXHHoLa9FufhVf/YrnCKka1h9hK6A6NCBYDCY8
	tC1pRusLCBXO2ndInBKT6qapW1Yi2srX9qrkVpXjIkXQ/xZ8H8DVKz5nsS6fAuWcQOkGiHoIwUgjh
	NEmwwwZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfNq-0000000HEmM-23vn;
	Wed, 21 Feb 2024 05:43:06 +0000
Date: Tue, 20 Feb 2024 21:43:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	agordeev@linux.ibm.com, akpm@linux-foundation.org,
	andreyknvl@gmail.com, andrii@kernel.org, aneesh.kumar@kernel.org,
	aou@eecs.berkeley.edu, ardb@kernel.org, arnd@arndb.de,
	ast@kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org,
	brauner@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, cl@linux.com, daniel@iogearbox.net,
	dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
	dvyukov@google.com, glider@google.com, gor@linux.ibm.com,
	guoren@kernel.org, haoluo@google.com, hca@linux.ibm.com,
	hch@infradead.org, john.fastabend@gmail.com, jolsa@kernel.org,
	kasan-dev@googlegroups.com, kpsingh@kernel.org,
	linux-arch@vger.kernel.org, linux@armlinux.org.uk,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	lstoakes@gmail.com, mark.rutland@arm.com, martin.lau@linux.dev,
	meted@linux.ibm.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mpe@ellerman.id.au, mst@redhat.com, muchun.song@linux.dev,
	naveen.n.rao@linux.ibm.com, npiggin@gmail.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, quic_nprakash@quicinc.com,
	quic_pkondeti@quicinc.com, rick.p.edgecombe@intel.com,
	ryabinin.a.a@gmail.com, ryan.roberts@arm.com,
	samitolvanen@google.com, sdf@google.com, song@kernel.org,
	surenb@google.com, svens@linux.ibm.com, tj@kernel.org,
	urezki@gmail.com, vincenzo.frascino@arm.com, will@kernel.org,
	wuqiang.matt@bytedance.com, yonghong.song@linux.dev,
	zlim.lnx@gmail.com, awheeler@motorola.com
Subject: Re: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node
 overrides
Message-ID: <ZdWNalbmABYDuFHE@infradead.org>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240220203256.31153-2-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220203256.31153-2-mbland@motorola.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 20, 2024 at 02:32:53PM -0600, Maxwell Bland wrote:
> Present non-uniform use of __vmalloc_node and __vmalloc_node_range makes
> enforcing appropriate code and data seperation untenable on certain
> microarchitectures, as VMALLOC_START and VMALLOC_END are monolithic
> while the use of the vmalloc interface is non-monolithic: in particular,
> appropriate randomness in ASLR makes it such that code regions must fall
> in some region between VMALLOC_START and VMALLOC_end, but this
> necessitates that code pages are intermingled with data pages, meaning
> code-specific protections, such as arm64's PXNTable, cannot be
> performantly runtime enforced.

That's not actually true.  We have MODULE_START/END to separate them,
which is used by mips only for now.

> 
> The solution to this problem allows architectures to override the
> vmalloc wrapper functions by enforcing that the rest of the kernel does
> not reimplement __vmalloc_node by using __vmalloc_node_range with the
> same parameters as __vmalloc_node or provides a __weak tag to those
> functions using __vmalloc_node_range with parameters repeating those of
> __vmalloc_node.

I'm really not too happy about overriding the functions.  Especially
as the separation is a generally good idea and it would be good to
move everyone (or at least all modern architectures) over to a scheme
like this.

