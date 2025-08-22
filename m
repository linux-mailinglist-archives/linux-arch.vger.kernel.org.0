Return-Path: <linux-arch+bounces-13254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC11B32134
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 19:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50006B205B6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D1231771E;
	Fri, 22 Aug 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdisCh3a"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE65313558;
	Fri, 22 Aug 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882515; cv=none; b=mAh0qXW2Q+FbYqLbmVA0r06iohBpNGZEZ4PdQyV0qQc5YK1V2lDu40OO9C0BihFlHwUGDffTrJGkG+U92l3nmy35ookmdZ1m4lwpdgFNa6ljcw5CwfdH0yuxefwpxiLQ+lzfiGJY05mC0VnD2GnJliHp7oYb0sX04bmac9EFdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882515; c=relaxed/simple;
	bh=3YE+ZQ5vrX6aLU86H7BJlfzyReIaU+5+8eV+03TzXIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvKSY7eOCePdIViuD5e7ccsVIx4og45Les/fASzb05d7agk1xppGs5LgEakc+myDIkbKf2EwAKAqjykvCWTl7FwfzHHc9apnU2tOl+nxNxSPnkr7Xp4pXStcEHTtxB0zf2oJZR7Fq+nD490hsZcSHA5lEGzb/XNNIQyhudgL+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdisCh3a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755882514; x=1787418514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3YE+ZQ5vrX6aLU86H7BJlfzyReIaU+5+8eV+03TzXIE=;
  b=UdisCh3aO1k4opOUZ2oyZsUiursTw0kvOVJk3awJnEBVj7mrjPgxrllr
   DqOZ4d840wLVxG+jmuZHSrYBgJPIC1xIbA8g2cH5bUwKYTh/GTB1H9Gux
   OR4DYYPqTWyKwWtz2z2wXYtWvqy/GEPnfCJxNgbTG08ybM4aBamNyYFZ0
   jfptxmTsA5oJLMiOWlEKHGhE4CV0KJfghWkg5/mB/YwRNzjmGs5klqkVY
   hDnXVP/orq1pHT3Yh/9ORguz5wtWALqM17HTwDZHFaWvsc1eArTy3R5eV
   D955f2YU8ABbpTqXvPdoNgpxQ/cKybEOc0pRzLp1CD5fjyTuwS487+Puw
   A==;
X-CSE-ConnectionGUID: mx6iYmbhQoG0FLrcuu1qkw==
X-CSE-MsgGUID: Bj47Yn0DTVGZ+oCpjiqJCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61840234"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61840234"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 10:08:32 -0700
X-CSE-ConnectionGUID: 5Nu5hnUPTz+8m2WU1ivarg==
X-CSE-MsgGUID: YdsZ6B6rSVa6oYkMnHlSKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="174065694"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.108.168]) ([10.125.108.168])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 10:08:31 -0700
Message-ID: <79027c6f-f2f3-41b2-9ff3-c5576fc06c5c@intel.com>
Date: Fri, 22 Aug 2025 10:08:30 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
 aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 ardb@kernel.org, arnd@arndb.de, bp@alien8.de, cl@gentwo.org,
 dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
 dev.jain@arm.com, dvyukov@google.com, glider@google.com,
 gwan-gyeong.mun@intel.com, hpa@zyccr.com, jane.chu@oracle.com,
 jgross@suse.de, jhubbard@nvidia.com, joao.m.martins@oracle.com,
 joro@8bytes.org, kas@kernel.org, kevin.brodsky@arm.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, luto@kernel.org,
 maobibo@loongson.cn, mhocko@suse.com, mingo@redhat.com, osalvador@suse.de,
 peterx@redhat.com, peterz@infradead.org, rppt@kernel.org,
 ryabinin.a.a@gmail.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 surenb@google.com, tglx@linutronix.de, thuth@redhat.com, tj@kernel.org,
 urezki@gmail.com, vbabka@suse.cz, vincenzo.frascino@arm.com, x86@kernel.org,
 zhengqi.arch@bytedance.com
References: <20250821093542.37844-1-harry.yoo@oracle.com>
 <20250821115731.137284-1-harry.yoo@oracle.com>
 <3976ef5d-a959-408a-b538-7feba1f0ab7a@intel.com> <aKfDrKBaMc24cNgC@hyeyoo>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <aKfDrKBaMc24cNgC@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 18:11, Harry Yoo wrote:
> On Thu, Aug 21, 2025 at 10:36:12AM -0700, Dave Hansen wrote:
>> On 8/21/25 04:57, Harry Yoo wrote:
>>> However, {pgd,p4d}_populate_kernel() is defined as a function regardless
>>> of the number of page table levels, so the compiler may not optimize
>>> them away. In this case, the following linker error occurs:
> 
> Hi, thanks for taking a look, Dave!
> 
> First of all, this is a fix-up patch of a mm-hotfixes patch series that
> fixes a bug (I should have explained that in the changelog) [1].
> 
> [1] https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.com
> 
> I think we can continue discussing it and perhaps do that as part of
> a follow-up series, because the current patch series need to be backported
> to -stable and your suggestion to improve existing code doesn't require
> -stable backports.
> 
> Does that sound fine?
> 
>> This part of the changelog confused me. I think it's focusing on the
>> wrong thing.
>>
>> The code that's triggering this is literally:
>>
>>>                         pgd_populate(&init_mm, pgd,
>>>                                         lm_alias(kasan_early_shadow_p4d));
>>
>> It sure _looks_ like it's unconditionally referencing the
>> 'kasan_early_shadow_p4d' symbol. I think it's wrong to hide that with
>> macro magic and just assume that the macros won't reference it.
>>
>> If a symbol isn't being defined, it shouldn't be referenced in C code.:q
> 
> A fair point, and that's what KASAN code has been doing for years.
> 
>> The right way to do it is to have an #ifdef in a header that avoids
>> compiling in the reference to the symbol.
> 
> You mean defining some wrapper functions for p*d_populate_kernel() in
> KASAN with different implementations based on ifdeffery?

That would work.

So would something like:

#if CONFIG_PGTABLE_LEVELS >= 4
extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
#else
#define kasan_early_shadow_p4d NULL
#endif

> Just to clarify, what should be the exact ifdeffery to cover these cases?
> #if CONFIG_PGTABLE_LEVELS == 4 and 5, or
> #ifdef __PAGETABLE_P4D_FOLDED and __PAGETABLE_PUD_FOLDED ?
> 
> I have no strong opinion on this, let's hear what KASAN folks think.

I think CONFIG_PGTABLE_LEVELS works, but in the end I'm not picky about
the specific #ifdefs that work.



