Return-Path: <linux-arch+bounces-10926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2388A6738D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF2F17B199
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1720B7E9;
	Tue, 18 Mar 2025 12:14:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF9207A2A;
	Tue, 18 Mar 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300073; cv=none; b=kBpIEWGjSdIkvYRQZ46U/b//DpKHXPUPr6sY11l6+2tARXnpnOKpj2OQDItps4RnkMceiGLfi8XV71E2Y2L5JeZCMFTeCGNrXMc9r7km3J4gsAlAlOHsGULaK7L/p+SUcoaxUJtF6HtLNeR9Ubw+pJ26YpjYhPthrZwsFvJzekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300073; c=relaxed/simple;
	bh=64IIiCxSmb90ZQ6fmueb4xJ3WQaFIC2OATzJjR0a98k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb4bg8Lxm72ZgZtTw1mAFX4wKq72MKdllVCyRi7AmvchSybPt4cmKJ4nOWyn0aLFzFfxwcrQzSsPrTI6/8fBSUVVrgeNDoBAWEaLupA7aaqf8QJMFRhzFoQujRU1VRtJLTdfwIRriEl4n/7+r9g5pcWt7HAzIaVdrq550gRlJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E278013D5;
	Tue, 18 Mar 2025 05:14:38 -0700 (PDT)
Received: from [10.57.85.104] (unknown [10.57.85.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF4D3F673;
	Tue, 18 Mar 2025 05:14:22 -0700 (PDT)
Message-ID: <e79f9aa9-ce1b-4d42-8a61-aebaae1744fc@arm.com>
Date: Tue, 18 Mar 2025 13:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Always call constructor for kernel page tables
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org
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
 <zhengqi.arch@bytedance.com>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20250317141700.3701581-1-kevin.brodsky@arm.com>
 <70349335-84ee-4bca-a3d6-d7cf3c05b92b@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <70349335-84ee-4bca-a3d6-d7cf3c05b92b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 16:30, Ryan Roberts wrote:
> On 17/03/2025 14:16, Kevin Brodsky wrote:
>> The complications in those special pgtable allocators beg the question:
>> does it really make sense to treat efi_mm and init_mm differently in
>> e.g. apply_to_pte_range()? Maybe what we really need is a way to tell if
>> an mm corresponds to user memory or not, and never use split locks for
>> non-user mm's. Feedback and suggestions welcome!
> The difference in treatment is whether or not the ptl is taken, right? So the
> real question is when calling apply_to_pte_range() for efi_mm, is there already
> a higher level serialization mechanism that prevents racy accesses? For init_mm,
> I think this is handled implicitly because there is no way for user space to
> cause apply_to_pte_range() for an arbitrary piece of kernel memory. Although I
> can't even see where apply_to_page_range() is called for efi_mm.

The commit I mentioned above, 61444cde9170 ("ARM: 8591/1: mm: use fully
constructed struct pages for EFI pgd allocations"), shows that
apply_to_page_range() is called from efi_set_mapping_permissions(), and
this indeed hasn't changed. It is itself called from efi_virtmap_init().
I would expect that no locking at all is necessary here, since the
mapping has just been created and surely isn't used yet. Now the
question is where exactly init_mm is special-cased in this manner. I can
see that walk_page_range() does something similar, there may be more
cases. And the other question is whether those functions are ever used
on special mm's, aside from efi_set_mapping_permissions().
> FWIW, contpte.c has mm_is_user() which is used by arm64.

Interesting! But not pretty, that's basically checking that the mm is
not &init_mm or &efi_mm... which wouldn't work for a generic
implementation. It feels like adding some attribute to mm_struct
wouldn't hurt. It looks like we've run out of MMF_* flags though :/

- Kevin

