Return-Path: <linux-arch+bounces-12719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F40B0328C
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jul 2025 19:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E6B1895D98
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jul 2025 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A346278E6A;
	Sun, 13 Jul 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRL5197n"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131B2581;
	Sun, 13 Jul 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752429384; cv=none; b=H4iF+z0TNLNULaqSqkhDWff1eU5fvaq4lcHeGDLEXv7XchpUgAGS5eMiOlAJRNFNdfZZmQjqxxvfhWx4rp7tp3Te228qPaIXLSQdN+z3KW9s/MMjPf8FxwDrGQVgnU9iLABAxSOD5LbfhcMiARPwDVQ4pPsPj1z0DKHr97q1O5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752429384; c=relaxed/simple;
	bh=P+ZGpMquPfCHNe224IKptMJLR+y5tQ5d/vbWwHQvmck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmTM12wQPWXUwWAzpuPkbVxwrpUy6r4cBFhcEl7scm97hmLMeTLhwupU0xlw39vOuhs9fBnX3Q/6qPTBcy4eOY8odcenk+uHyt38CTJICCuVSKwA48cipvXobCnb5SQrdlz1ww+J+ehKnOwAz6yisKF+cxzvn8ZyZDh8QllmkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRL5197n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C3AC4CEE3;
	Sun, 13 Jul 2025 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752429384;
	bh=P+ZGpMquPfCHNe224IKptMJLR+y5tQ5d/vbWwHQvmck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRL5197nqMjr05xGN5g0zw/NpBK9l35yCYREJWMyObTAyxvoeKkdbRkguviRQyWru
	 qvE1QRGmzQ1VaF8essjumL49HXZ7Jd3v8OF7zwINCkQ0AgrJc92KRSxrY1o9bOCdLL
	 VkLp9+/x/hMoTGF6Xcj6jz2F6PJI7OgL1JNmnF0LPTBCwnsqgNAoNNRulmzs7a2JMo
	 L7jw0iwn/wt5L0JQLgnojswEXOudNgPt+3uOhusGR+3FkW1by9lkMz0SRd9MNYAhli
	 G/gcpZCx+VIYKjHzKwbrv4cM0UBdtktAmhnQPB8FX/GQ6gE2tIKfgSrJy6SmVJJu0v
	 /JXT21VQ3POhw==
Date: Sun, 13 Jul 2025 20:56:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Juergen Gross <jgross@suse.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Joao Martins <joao.m.martins@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 1/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aHPzOrS7ZfO-3Wf6@kernel.org>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-2-harry.yoo@oracle.com>
 <02146c79-a4de-430f-8357-0608e796fa60@redhat.com>
 <aHObCemGNrGakq_b@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHObCemGNrGakq_b@hyeyoo>

On Sun, Jul 13, 2025 at 08:39:53PM +0900, Harry Yoo wrote:
> On Fri, Jul 11, 2025 at 06:18:44PM +0200, David Hildenbrand wrote:
> > On 09.07.25 15:16, Harry Yoo wrote:
> > > Intrdocue and use {pgd,p4d}_pouplate_kernel() in core MM code when
> > > populating PGD and P4D entries corresponding to the kernel address
> > > space. The main purpose of these helpers is to ensure synchronization of
> > > the kernel portion of the top-level page tables whenever such an entry
> > > is populated.
> > > 
> > > Until now, the kernel has relied on each architecture to handle
> > > synchronization of top-level page tables in an ad-hoc manner.
> > > For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> > > direct mapping and vmemmap mapping changes").
> > > 
> > > However, this approach has proven fragile, as it's easy to forget to
> > > perform the necessary synchronization when introducing new changes.
> > > 
> > > To address this, introduce _kernel() varients of the page table
> > 
> > s/varients/variants/
> 
> Will fix. Thanks.
> 
> > > population helpers that invoke architecture-specific hooks to properly
> > > synchronize the page tables.
> > 
> > I was expecting to see the sync be done in common code -- such that it
> > cannot be missed :)
> 
> You mean something like an arch-independent implementation of
> sync_global_pgds()?
>
> That would be a "much more robust" approach ;)
> 
> To do that, the kernel would need to maintain a list of page tables that
> have kernel portion mapped and perform the sync in the common code.
> 
> But determining which page tables to add to the list would be highly
> architecture-specific. For example, I think some architectures use separate
> page tables for kernel space, unlike x86 (e.g., arm64 TTBR1, SPARC) and
> user page tables should not be affected.

sync_global_pgds() can be still implemented per architecture, but it can be
called from the common code.
We already have something like that for vmalloc that calls
arch_sync_kernel_mappings(). It's implemented only by x86-32 and arm, other
architectures do not define it.

> While doing the sync in common code might be a more robust option
> in the long term, I'm afraid that making it work correctly across
> all architectures would be challenging, due to differences in how each
> architecture manages the kernel address space.
> 
> > But it's really just rerouting to the arch code where the sync can be done,
> > correct?
> 
> Yes, that's correct.
> 
> Thanks for taking a look!
> 
> -- 
> Cheers,
> Harry / Hyeonggon

-- 
Sincerely yours,
Mike.

