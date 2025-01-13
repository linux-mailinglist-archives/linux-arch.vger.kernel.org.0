Return-Path: <linux-arch+bounces-9725-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC174A0BD91
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 17:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2491881D48
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298282297E9;
	Mon, 13 Jan 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPMzoMzo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6220F08B;
	Mon, 13 Jan 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785783; cv=none; b=X+G5Z/mnoStQSRA6fuKDukkAT9eev3ZJx4Z7KFGczdc3m737MWXUsIVaUOLIu30Js05BneA9WSXXo8x3/gxPTvy6PpAy6PFm0Srdo0CMNeeI43eMKwtXntH/l5C9wujcZ0WUTnd/LEY4Ejef+KLbIKXE61EbcOB1tWv6hFwWck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785783; c=relaxed/simple;
	bh=G/WL7za6/FhMEJQUPPYaVa5AR3im6p6zdx508VpTd8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR0BnG/mcyS73nePx9IQKlqeeCUwEE9vfCB511T7DMmUnTkRYCCz1EpBvPx9wREqZBTJlz3Gut1g/g38hHqNPsaw8tE7MklW5ubjE9H3vBeeJ8trqt/0/EJuaXHdw51r2uK7JFvjd5I2o+2Rpvi9LWsHjrjTCiSW640H5RcDnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPMzoMzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DDC4CED6;
	Mon, 13 Jan 2025 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736785782;
	bh=G/WL7za6/FhMEJQUPPYaVa5AR3im6p6zdx508VpTd8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPMzoMzonmm2uaOFLfrdzxlqYEZB9gyC4UNDIA7tmVyD1CdeiDw/0q7HTvvJaEdU9
	 O8zfvzFkV7uaD3Eeih9wt9NYEMgB9jFV0IHWkVr1H3T/eBEPpuOfFcMO/Ou4iLVDWQ
	 Hml2UsTpltlAGqg8dCV2vjov8Jfdy8hAWDfRY3MLkqHK6jF+OtTwqCUS2Mr7UtQJAG
	 LdHkSaSmCjlHGRuBlI0oL1FiCdYRvc0JfAH5RdDfH6z1lRwE3aqHCLNuC9IujuiGvW
	 +MOXpYRLwV7Hg46tyDx5cj6hTBCHBY3taAzyPWeFgdxktJaT7Of+Zg4hhGTcDn07vF
	 bC7Um3/mpT7aQ==
Date: Mon, 13 Jan 2025 16:29:32 +0000
From: Will Deacon <will@kernel.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
	alex@ghiti.fr, andreas@gaisler.com, palmer@dabbelt.com,
	tglx@linutronix.de, david@redhat.com, jannh@google.com,
	hughd@google.com, yuzhao@google.com, willy@infradead.org,
	muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
	aneesh.kumar@kernel.org, npiggin@gmail.com,
	dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v5 09/17] arm64: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
Message-ID: <20250113162931.GB14101@willie-the-truck>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <cf4b847caf390f96a3e3d534dacb2c174e16c154.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4b847caf390f96a3e3d534dacb2c174e16c154.1736317725.git.zhengqi.arch@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 08, 2025 at 02:57:25PM +0800, Qi Zheng wrote:
> Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
> table pages can be freed together (regardless of whether RCU is used).
> This prevents the use-after-free problem where the ptlock is freed
> immediately but the page table pages is freed later via RCU.
> 
> Page tables shouldn't have swap cache, so use pagetable_free() instead of
> free_page_and_swap_cache() to free page table pages.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/tlb.h | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

