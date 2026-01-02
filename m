Return-Path: <linux-arch+bounces-15636-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E490CEEFF3
	for <lists+linux-arch@lfdr.de>; Fri, 02 Jan 2026 17:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995C630080D0
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jan 2026 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214912C0F79;
	Fri,  2 Jan 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr+AoPa/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F83291C33;
	Fri,  2 Jan 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767372116; cv=none; b=c+j42hPvT7KSWT64T3LgXrImMDw+srVOaDcsR1/9JV7M+XD+gLpOQjKvEzkbT8nOikqKND0kC7zeEvYpcfdNajOxIc+++ocuXJMe46lrdHBAsj5uxL+NLj2rwaxxiReHYtG0n88DLB3O/mNs7bNsfyKq98MrIa8FPi0NdKI/aQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767372116; c=relaxed/simple;
	bh=KFOnUBOvFoPFL+L9c4KvjfxAUSn8fz9Ic3nFbWuYMi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG+bSmRaoHIH3M1abRJC0kRdgyEqhcRsxfPrppMWEJ1D1Sp5TMHEoScK0S4tqXEb84JxQEHcbNyDdJIGaQg/bF822luHDR3tcs2yvwSdl6tsdV6NUjd0NlvpQ2AtCAvLVpeAhXXT6Vs622PV0CRUfBPfaWP/hKYTPXQkeiovehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr+AoPa/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767372114; x=1798908114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KFOnUBOvFoPFL+L9c4KvjfxAUSn8fz9Ic3nFbWuYMi0=;
  b=lr+AoPa/A9DGOH03tGMl5ExYKVipaOx9H3V30Kztm2T6BiTL7YB8TLvV
   Pk4IiWosqQs2Q0JR336BNOG0lLTu1acv7yw5fN0xNHOcZ9jTDAJPVDdT1
   tLc5FeUK0wH+EqLLkgV0r6RIZGxH9G3CZMvKk+QU84fIBjvr8diMLIw80
   eVWpOFWmQG9XK080koMIWICme9mDQxqugKsu3TZGQZ2lVDikVYlRtZ36Z
   v7wc5LuqgApWL/L/aRxAn4kWYauY2y6TH/BjLiGSfI4nmxJvAYgVxzxF8
   ZCNsilh8ZDnK0uwgYN4mYptL7UVrxLJiPRXZIpR7C9W+IpGlykBlR6xUf
   w==;
X-CSE-ConnectionGUID: LnWys7YmSBmWNbWJqXi8xw==
X-CSE-MsgGUID: yUP+kRfyTledJAv2FWs+AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="79495501"
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="79495501"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 08:41:53 -0800
X-CSE-ConnectionGUID: 9EUcYzkgRXu5VQKNCnjmbw==
X-CSE-MsgGUID: LWD3MAqzQ7+7gAGN2e+05g==
X-ExtLoop1: 1
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.222]) ([10.125.108.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 08:41:51 -0800
Message-ID: <cea71c01-68e7-4f7f-9931-017109d95ef0@intel.com>
Date: Fri, 2 Jan 2026 08:41:50 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] skip redundant TLB sync IPIs
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251229145245.85452-1-lance.yang@linux.dev>
 <f81b98e5-87c0-4c21-9a75-ad5f9b6af6aa@intel.com>
 <1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <1b27a3fa-359a-43d0-bdeb-c31341749367@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 04:33, David Hildenbrand (Red Hat) wrote:
> On 12/31/25 05:26, Dave Hansen wrote:
>> On 12/29/25 06:52, Lance Yang wrote:
>> ...
>>> This series introduces a way for architectures to indicate their TLB
>>> flush
>>> already provides full synchronization, allowing the redundant IPI to be
>>> skipped. For now, the optimization is implemented for x86 first and
>>> applied
>>> to all page table operations that free or unshare tables.
>>
>> I really don't like all the complexity here. Even on x86, there are
>> three or more ways of deriving this. Having the pv_ops check the value
>> of another pv op is also a bit unsettling.
> 
> Right. What I actually meant is that we simply have a property "bool
> flush_tlb_multi_implies_ipi_broadcast" that we set only to true from the
> initialization code.
> 
> Without comparing the pv_ops.
> 
> That should reduce the complexity quite a bit IMHO.

Yeah, that sounds promising.

> But maybe you have an even better way on how to indicate support, in a
> very simple way.

Rather than having some kind of explicit support enumeration, the other
idea I had would be to actually track the state about what needs to get
flushed somewhere. For instance, even CPUs with enabled INVLPGB support
still use IPIs sometimes. That makes the
tlb_table_flush_implies_ipi_broadcast() check a bit imperfect as is
because it will for the extra sync IPI even when INVLPGB isn't being
used for an mm.

First, we already save some semblance of support for doing different
flushes when freeing page tables mmu_gather->freed_tables. But, the call
sites in question here are for a single flush and don't use mmu_gathers.

The other pretty straightforward thing to do would be to add something
to mm->context that indicates that page tables need to be freed but
there might still be wild gup walkers out there that need an IPI. It
would get set when the page tables are modified and cleared at all the
sites where an IPIs are sent.


>> That said, complexity can be worth it with sufficient demonstrated
>> gains. But:
>>
>>> When unsharing hugetlb PMD page tables or collapsing pages in
>>> khugepaged,
>>> we send two IPIs: one for TLB invalidation, and another to synchronize
>>> with concurrent GUP-fast walkers.
>>
>> Those aren't exactly hot paths. khugepaged is fundamentally rate
>> limited. I don't think unsharing hugetlb PMD page tables just is all
>> that common either.
> 
> Given that the added IPIs during unsharing broke Oracle DBs rather badly
> [1], I think this is actually a case worth optimizing.
...
> [1] https://lkml.kernel.org/r/20251223214037.580860-1-david@kernel.org

Gah, that's good context, thanks.

Are there any tests out there that might catch these this case better?
It might be something good to have 0day watch for.

