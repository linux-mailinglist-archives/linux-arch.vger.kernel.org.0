Return-Path: <linux-arch+bounces-9646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D81A0555D
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23F818868FE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500661E1A2B;
	Wed,  8 Jan 2025 08:31:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACD1ACECE;
	Wed,  8 Jan 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325080; cv=none; b=lKqeMyu9bBkdqQQTMvuo8UIpVNP4U9u5Xh1lk0ye/6BDuOckzjJOrc0kyBm3zUcyuPBMhtx+7/faidlNvNxf8ToGOTrxRDezCtWB6uQqV4vo9I182t8o4BUt2J5FoXEvhxazNZIJ3Ed9sDfFviHs3z7otFECV9dJBCJvps78lq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325080; c=relaxed/simple;
	bh=lom+i4v3PxfHxmognsFk46EQaMmrjYMhI/xbLHGccvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xixq8mCxUXtDLaQIM+7EgqGa2ZOtQMacW4rxjWSTfRTuKYHGahW/ikhzhnhUiFSjAnlKgthD0UepIclJqUwuYoWXHJB2ZunjxHV3A7mGuvfO8Yt9w0zqsJqLE0vSpGQCwt6EFujpfUjTDc51cYGLvU6CpPrMtzaVIUYxdLg2wRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A875312FC;
	Wed,  8 Jan 2025 00:31:45 -0800 (PST)
Received: from [10.57.94.52] (unknown [10.57.94.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28A753F59E;
	Wed,  8 Jan 2025 00:31:08 -0800 (PST)
Message-ID: <7cf8fa3b-799f-415a-82a1-eee6b7b2e0f5@arm.com>
Date: Wed, 8 Jan 2025 09:31:06 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] x86: pgtable: convert __tlb_remove_table() to
 use struct ptdesc
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
 agordeev@linux.ibm.com, alex@ghiti.fr, andreas@gaisler.com,
 palmer@dabbelt.com, tglx@linutronix.de, david@redhat.com, jannh@google.com,
 hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <39f60f93143ff77cf5d6b3c3e75af0ffc1480adb.1736317725.git.zhengqi.arch@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <39f60f93143ff77cf5d6b3c3e75af0ffc1480adb.1736317725.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2025 07:57, Qi Zheng wrote:
> Convert __tlb_remove_table() to use struct ptdesc, which will help to move
> pagetable_dtor() to __tlb_remove_table().
>
> And page tables shouldn't have swap cache, so use pagetable_free() instead
> of free_page_and_swap_cache() to free page table pages.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Definitely a good idea to have split patch 11 from v4.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

