Return-Path: <linux-arch+bounces-6207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A909520C9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B5F280F01
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70251B9B48;
	Wed, 14 Aug 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jMSBkpkE"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FD1D52D;
	Wed, 14 Aug 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655626; cv=none; b=BfruozZkw3iblIew3Kt2GUPW5srJD7CIKeY973KIvI0/SLlxD729N2XJCVac2tyGy/2rgQh/ao2PgPoVN2pefBa9un3zS8TEdq1yAMt0zdc5HxuJXN/yE8BiIBGwDNQbPdan4AFwWnRnIMTGmbAJsTNzvfkKgR5ZYmHudl8xR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655626; c=relaxed/simple;
	bh=HRDljkfdCjtP0Jhr6VA2fjJ8DjprBgLSgLylCdl2uJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feXFgHyIj6N2KRo1obsRWqHbW+c0cndT2xdoVSfQVPU1hrNd1q2sBo0gelbGOXnq/D0DCWrohZiamnFYAgSAWBhwl2U57mJUTao4Yo1kSOAxGgY3i0TyxQ0qTflgID0Urg0q3a25qqbJRIbx7FDD7HMgm8Mw2WXKcVCLZ6lFfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jMSBkpkE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CccF10Y1UVzqVdXNkHG0Q64NFYze/yEsWDqzDzqW7vg=; b=jMSBkpkEqt8WS+F2dp4Vv9k29E
	uvhexiSRt/j6BZcXWYWhwFZRtiXP6U1lvw1czQiH+KNd72I56m4MYPtsT6fjoLpt5zpYQLn1KJR7V
	//A13nNRvQuOdUlfQX0zKb1mA9sweTFZhxmoVhdvrLHTy4dtQW1xOoMzDLcm5vc6LlWHvvPRpRVtm
	kpRvLb8GIfoprE7rCO712liHkEn9FPsoT6qeRz1f+cqBU8GROFhO5kmGFUkcteUQNB60I3VJDJjnc
	LQoQoyMzpWy5r6yPbdhByxjE2+SCeJzLB2IP5fuzMH37JuKus6pSF5G5VNezNRjd+F8nW5QOzBbuD
	qVDSrCYg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seHYS-00000000ndL-2y8J;
	Wed, 14 Aug 2024 17:13:00 +0000
Date: Wed, 14 Aug 2024 18:13:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Brian Cain <bcain@quicinc.com>, WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,
	Barry Song <baohua@kernel.org>, linux-s390@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t
Message-ID: <ZrzlnIWrnaUx66rY@casper.infradead.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730064712.3714387-1-alexs@kernel.org>

On Tue, Jul 30, 2024 at 02:46:54PM +0800, alexs@kernel.org wrote:
> We have struct ptdesc for page table descriptor a year ago, but it
> has no much usages in kernel, while pgtable_t is used widely.

Hum, I thought I responded to this to point out the problem, but
I don't see the response anywhere, so I'll try again.

> The pgtable_t is typedefed as 'pte_t *' in sparc, s390, powerpc and m68k
> except SUN3, others archs are all same as 'struct page *'.

And there's a very good reason for that.  On s390 and powerpc (I cannot
speak to the sparc/m68k), each page table is (potentially) smaller
than PAGE_SIZE.  So we cannot do what your patch purports to do, as
we would not know whether we're referring to the first or subsequent
page tables contained within a page.

Maybe at some point in the distant future we'll be able to allocate
a ptdesc per page table instead of per page allocated for use by page
tables.  But we cannot do that yet.

