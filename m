Return-Path: <linux-arch+bounces-11056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B1A6D65E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 09:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2038716AF17
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8931F3D5D;
	Mon, 24 Mar 2025 08:39:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F9EFC1D;
	Mon, 24 Mar 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805542; cv=none; b=s7tvfm7FLLq+WALDee5jsSTDbSxkBiCegreD77eTJs/MxmtAUxdWQ7juc+isBxHPu7QhLcfnAMb2RMUyYhzerfpDxC8Ba99M8vOaoALcDjEhHvESwv0vJ5xt6s+UEbnmieMuQ6MvkBDjJUNIFUsFQ6e6UM9j7g2lqeEBJJd6wBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805542; c=relaxed/simple;
	bh=WFJMT0e0Wx2d4fqga/UUx/kJofGh0hGb/MxIjebVoZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/jU+AWxxZ+3XQeo8tCdm4EUyLnXBlsPAvDKDrjQWuRv/ofPpKDz785i5pjVvY5Uz0d7zXZORwc+RXcLXFb/a8AdMJG6jOCwzmAftgV7Iwo4hO6aT4AGxI2RVTUODHqlRRm2ZkK1mHnlcU7EF4fBuO+Flk44DRJoqwv1y1LF5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A3C51A2D;
	Mon, 24 Mar 2025 01:39:05 -0700 (PDT)
Received: from [10.57.41.67] (unknown [10.57.41.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A833F58B;
	Mon, 24 Mar 2025 01:38:53 -0700 (PDT)
Message-ID: <efc72f28-0dcb-4811-a20c-73bcdbdf28fb@arm.com>
Date: Mon, 24 Mar 2025 09:37:56 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] mm: Call ctor/dtor for kernel PTEs
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org
References: <20250317141700.3701581-1-kevin.brodsky@arm.com>
 <20250317141700.3701581-3-kevin.brodsky@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250317141700.3701581-3-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 15:16, Kevin Brodsky wrote:
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index e164ca66f0f6..3c8ec3bfea44 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -23,6 +23,11 @@ static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  
>  	if (!ptdesc)
>  		return NULL;
> +	if (!pagetable_pte_ctor(mm, ptdesc)) {

As reported by the CI [1], this can cause trouble on x86 because dtor
calls are missing in pud_free_pmd_page() and pmd_free_pte_page(). Will
fix in the next version.

- Kevin

[1] https://lore.kernel.org/oe-lkp/202503211612.e11bd73f-lkp@intel.com/

