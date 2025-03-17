Return-Path: <linux-arch+bounces-10916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B061A655BD
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B9A175CC9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1224A053;
	Mon, 17 Mar 2025 15:30:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453D248891;
	Mon, 17 Mar 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225457; cv=none; b=RSluNHWAN5B3ldHr9fs7Yia75knZS+HgT3mJT6WoqqNAnFmiAe2Bfv3/TZz1awk4+p08T+A1QAhY+N7kMoQ+QUOYRNIfV2aqmg3DzyOoBPUOUuUPc4xxP94lILMB0Uie2dhq9IAHRB0BeeH6R09qvRbbBIkW4V1+ovnOAiAXI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225457; c=relaxed/simple;
	bh=E28zglszNSgNs5nxBqGH9ihoTQywx6FCChBvwXjU3Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOwm+cxmKHCETxq0o2YSE43fAPGwjQ+vMU6UQi9hWTbol23Vc1Svr+EfzC3qW7IdmbjyccELFbScEbXjTNPJvgL6vzU/cPNxCLxJTfeS4s3L8H3HT8S4xf4+aiHPYSQzKAvNYkcTLidb8ODpZClS4/hJISQOHnZHjdlRFr9gF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3164013D5;
	Mon, 17 Mar 2025 08:31:03 -0700 (PDT)
Received: from [10.57.84.137] (unknown [10.57.84.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 421503F694;
	Mon, 17 Mar 2025 08:30:49 -0700 (PDT)
Message-ID: <70349335-84ee-4bca-a3d6-d7cf3c05b92b@arm.com>
Date: Mon, 17 Mar 2025 15:30:47 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Always call constructor for kernel page tables
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250317141700.3701581-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 14:16, Kevin Brodsky wrote:
> The complications in those special pgtable allocators beg the question:
> does it really make sense to treat efi_mm and init_mm differently in
> e.g. apply_to_pte_range()? Maybe what we really need is a way to tell if
> an mm corresponds to user memory or not, and never use split locks for
> non-user mm's. Feedback and suggestions welcome!

The difference in treatment is whether or not the ptl is taken, right? So the
real question is when calling apply_to_pte_range() for efi_mm, is there already
a higher level serialization mechanism that prevents racy accesses? For init_mm,
I think this is handled implicitly because there is no way for user space to
cause apply_to_pte_range() for an arbitrary piece of kernel memory. Although I
can't even see where apply_to_page_range() is called for efi_mm.

FWIW, contpte.c has mm_is_user() which is used by arm64.

Thanks,
Ryan

