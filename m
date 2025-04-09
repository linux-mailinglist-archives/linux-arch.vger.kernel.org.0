Return-Path: <linux-arch+bounces-11358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D4A82964
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807CF3AE725
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64256267701;
	Wed,  9 Apr 2025 14:50:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD452676F7;
	Wed,  9 Apr 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210216; cv=none; b=qTwplMtUnZLobha8kJ1PmVEzhPyepG158UQl/3Cf4ho7Gvs+iOgFNNCm+Dd+Ai6glvHThWRZspMBu06fs/96Pf92zXPB8kkEUBYEG4BIbVKaQpNqCToxBT74hkFQSEeK46yiAGjmNOmw/MblswHPVmjARybfipXj7gj5wyqBomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210216; c=relaxed/simple;
	bh=4pLTv0zekgYPNEgwM2RuMiOZmFr4+wJ4i/oOyh8hrvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzk/mwPJJT0jaK4hDCWlvWXwjlyO+eduEe8A0jVD9l+Gw1OQZ8Nw53l4L8W+cXME4lr7Bpj8Ls8iKGPNbBBM3ZAxKWBZPcotXqSgpQi0zSXLA7GM+gY1QnSv65Q8ILHd5GR2/r8JQa1HLCc+dxJK2chYOWccbUuDHEtviqjN3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52F3115A1;
	Wed,  9 Apr 2025 07:50:13 -0700 (PDT)
Received: from [10.57.67.254] (unknown [10.57.67.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A653F59E;
	Wed,  9 Apr 2025 07:50:07 -0700 (PDT)
Message-ID: <99771f33-8ad8-4ba5-9cf0-f504588d99a0@arm.com>
Date: Wed, 9 Apr 2025 16:50:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] x86: pgtable: Always use pte_free_kernel()
To: Matthew Wilcox <willy@infradead.org>, Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20250408095222.860601-1-kevin.brodsky@arm.com>
 <20250408095222.860601-3-kevin.brodsky@arm.com>
 <409d2019-a409-4e97-a16f-6b345b0f5a38@intel.com>
 <Z_VQxyqkU8DV7QGy@casper.infradead.org>
 <9247436d-ae01-4eb8-bd5d-370b2fb2eebc@intel.com>
 <Z_VfeFgrj23Oa0fX@casper.infradead.org>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Z_VfeFgrj23Oa0fX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2025 19:40, Matthew Wilcox wrote:
> On Tue, Apr 08, 2025 at 09:54:42AM -0700, Dave Hansen wrote:
>> On 4/8/25 09:37, Matthew Wilcox wrote:
>>> On Tue, Apr 08, 2025 at 08:22:47AM -0700, Dave Hansen wrote:
>>>> Are there any tests for folio_test_pgtable() at free_page() time? If we
>>>> had that, it would make it less likely that another free_page() user
>>>> could sneak in without calling the destructor.
>>> It's hidden, but yes:
>>>
>>> static inline bool page_expected_state(struct page *page,
>>>                                         unsigned long check_flags)
>>> {
>>>         if (unlikely(atomic_read(&page->_mapcount) != -1))
>>>                 return false;
>>>
>>> PageTable uses page_type which aliases with mapcount, so this check
>>> covers "PageTable is still set when the last refcount to it is put".
>> Huh, so shouldn't we have ended up in bad_page() for these, other than:
>>
>>         pagetable_dtor(virt_to_ptdesc(pmd));
>>         free_page((unsigned long)pmd);
> I think at this point in Kevin's series, we don't call the ctor for
> these pages, so we never set PageTable() on them. I could be wrong;

Correct, that's why I added this patch early in the series (the next
patch adds the ctor call in pte_alloc_one_kernel()).

The BUG() in v1 was indeed triggered by a page_expected_state() check [1].

> as Kevin says, this is all very twisty and confusing with exceptions and
> exceptions to exceptions.  This series should reduce the confusion.

I hope so!

- Kevin

[1] https://lore.kernel.org/oe-lkp/202503211612.e11bd73f-lkp@intel.com/

