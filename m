Return-Path: <linux-arch+bounces-15694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4245CD0031F
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 22:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 078013007932
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 21:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC12E764B;
	Wed,  7 Jan 2026 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1cutN57"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264C2DF719;
	Wed,  7 Jan 2026 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821439; cv=none; b=bhDHxtZW5ID8eMY9Jvnhvi3nPuohad9cfF141hnO49hj5do9UHdVWOq5EHoz2xIRwzvRZfVo5JGBPYuyFPGSOQZ/RERjemLN23+ZaQK+bUOEFz8Uz5lu8qsjKGiGn3iPfCjLrZRh8lT9zQFDnRCQRGIMVIwHnrtlrcqDOd2heRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821439; c=relaxed/simple;
	bh=FFWQa2LcrHTSBnqZDDDWTX3L98Pi6EsBlHPLyGqAVZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8rWGBhXxmso6T59NQC2MclPTZGKG9onbnXwv/XJzqrfbVsE1BmLw7cHFWgYCe0ldeqjNY9T1yQUOb+EB25zAZWv/tdlO2Qy2A4YyQkZvE1pnDKJvvGYlb/6SNWeDp5PeeSBRZdngXXwhWV2bWUpWy7tmFZ6dPeN1jwfvJGP5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1cutN57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D15EC19423;
	Wed,  7 Jan 2026 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767821439;
	bh=FFWQa2LcrHTSBnqZDDDWTX3L98Pi6EsBlHPLyGqAVZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1cutN5774l/i6VO06Cm6RgMyY0ZBloUGp+vUZeYRcQ7s0hozsw0D2ZxzN7z/AjaF
	 C/cKv2nvlGtySI61wwT+MHVNR02xCzPnbwIa498UgguWOGUaaMcS9VuORG8G+LtTbL
	 jj7L4GMNKZHwztql++qSkaaMRYPAoy0nqp6EdTowwwfbJCANzn7EjyL1iNU8331eef
	 mk/ILH2wnz9SesYAu5iRljZXGS1BI1BeM6eSDbyohPWwkqYEEbim3D8GNw4avWKGdE
	 qs5Scd+uDIbKQwXDbJcKVdl8tVqnMZomYBLHBIqrqY4rXLAhpCOt2sy7GXEPFkaOCF
	 fH987XZrxdvAw==
Date: Wed, 7 Jan 2026 21:30:33 +0000
From: Will Deacon <will@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: aneesh.kumar@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
	peterz@infradead.org, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH] mm/mmu_gather: remove @delay_remap of
 __tlb_remove_page_size()
Message-ID: <aV7QefpA5aYIfUGT@willie-the-truck>
References: <20251231030026.15938-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231030026.15938-1-richard.weiyang@gmail.com>

On Wed, Dec 31, 2025 at 03:00:26AM +0000, Wei Yang wrote:
> Functioin __tlb_remove_page_size() is only used in
> tlb_remove_page_size() with @delay_remap set to false and it is passed
> directly to __tlb_remove_folio_pages_size().
> 
> Remove @delay_remap of __tlb_remove_page_size() and call
> __tlb_remove_folio_pages_size() with false @delay_remap.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> ---
>  arch/s390/include/asm/tlb.h | 6 ++----
>  include/asm-generic/tlb.h   | 5 ++---
>  mm/mmu_gather.c             | 5 ++---
>  3 files changed, 6 insertions(+), 10 deletions(-)

Makes sense to me:

Acked-by: Will Deacon <will@kernel.org>

Will

