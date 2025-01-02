Return-Path: <linux-arch+bounces-9554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C29FFC5E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 17:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C71619C5
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC31684AC;
	Thu,  2 Jan 2025 16:54:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334BA79E1;
	Thu,  2 Jan 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836854; cv=none; b=jGsMU2YwDDOea0oiojUtp28l2KiC69GOwzhlXMMDP4dPDDf/DoRbtuwNGoMCzLu8Dd3/6k3ib0w8FRUfgIMRVCnzgnyGCx1ZESn25sQO9uGkoU0hevRQcIE99u93UKO8G03UxkZ4y3m/MGxqAj/d1TSxBEG6Y+w0+rWSnPYLcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836854; c=relaxed/simple;
	bh=IgkU4g40LO32Daf8xBlY3M/4jRo5sGPLtixNjoSZkZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubwlbEGEtKoXTldMNkqd3KaKnitQm1+sYDHZlrFDtYeB6DLyOx8z17mDY2RGPwPbncob9uOKz3uUp2mvhPTbkDxD/o7YQ1DiqLUCp6ILH4tBtp0l8cU6smLd0LT6eXW4atjsy4RffXD+JB1wokit/Ot79QouEUM+Zu4v3v4Pl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA569153B;
	Thu,  2 Jan 2025 08:54:39 -0800 (PST)
Received: from [10.57.91.208] (unknown [10.57.91.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C923F673;
	Thu,  2 Jan 2025 08:54:02 -0800 (PST)
Message-ID: <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
Date: Thu, 2 Jan 2025 17:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
 agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/12/2024 10:07, Qi Zheng wrote:
>  static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>  {
> -	if (riscv_use_sbi_for_rfence())
> +	if (riscv_use_sbi_for_rfence()) {
>  		tlb_remove_ptdesc(tlb, pt);
> -	else
> +	} else {
> +		pagetable_dtor(pt);
>  		tlb_remove_page_ptdesc(tlb, pt);

I find the imbalance pretty confusing: pagetable_dtor() is called
explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
Could we not call pagetable_dtor() from __tlb_batch_free_encoded_pages()
to ensure that the dtor is always called just before freeing, and remove
the extra handling from arch code? I may well be missing something, I'm
not super familiar with the tlb handling code.

- Kevin

