Return-Path: <linux-arch+bounces-15726-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B39D0AFC4
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D8503019496
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E750094C;
	Fri,  9 Jan 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xOPnIlh5"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AA126ED41
	for <linux-arch@vger.kernel.org>; Fri,  9 Jan 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972674; cv=none; b=F6gybx2ZfPpZ3kWHefg0Vhb+14/Oo4HWyw4HD28uNoqyTY+atfG9t+gjtSW24Xv4T41h+VSzl4qozzWqe4yJux0DCPKozl/ugBb9pe4zolVi3GrhhK8ZOFUy2WSnWokWgsunh3L4zwK7EPYiBKfFeyr0mGasmbWQZXZDSSEQBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972674; c=relaxed/simple;
	bh=27j3KTMjIrvUYknQmCp2x40gZBrYwJ1ntB6W4hJffi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrBJcfGCjhnCiPxOFkV86XEBxXexhzHUBS0m14ff0w68g6eiRhCp5cxCXpM+RC9NictOt8+aCqcp2Q8he625tJq0nvoZepRgstk38qyRWlgNW17GrEw/wvL8I3XAb97yzv2MhXKLnR8xlDkbu0PG2+3ScNClsYbA/L28DFupPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xOPnIlh5; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f45a1760-7fa6-4e2c-ba5a-90e250a5792a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767972669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FEO03nU3lunGBMTB9f9/hv+IjcT/lwasWMosM27ke0=;
	b=xOPnIlh5FqZsn91jKIxYC3Z9+oplXNrgqQGMxNCC3FOU27HuGA1Z2ZkeHqpwes8Ix0X83b
	1Cc8jM7UiW2qVphjJvQ/sLfoFRJuCx8uRcnzejAuOkdZkfP00BzrlsMX/fY4ropVVhslz+
	E7HqBxXQUW6higVM/BLRB9wyeIn1DY0=
Date: Fri, 9 Jan 2026 23:30:51 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v3 1/2] mm/tlb: skip redundant IPI when TLB flush
 already synchronized
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, dave.hansen@intel.com
Cc: dave.hansen@linux.intel.com, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-2-lance.yang@linux.dev>
 <da1e8a00-99fe-46d9-b425-c307ea933036@kernel.org>
 <7472056a-3919-429a-845d-c2076496d537@linux.dev>
 <4d94363b-5b3b-4401-a9d8-da136d71f8c3@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <4d94363b-5b3b-4401-a9d8-da136d71f8c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/9 22:13, David Hildenbrand (Red Hat) wrote:
> 
>>> What could work is tracking "tlb_table_flush_sent_ipi" really when we
>>> are flushing the TLB for removed/unshared tables, and maybe resetting
>>> it ... I don't know when from the top of my head.
>>
>> Not sure what's the best way forward here :(
>>
>>>
>>> v2 was simpler IMHO.
>>
>> The main concern Dave raised was that with PV hypercalls or when
>> INVLPGB is available, we can't tell from a static check whether IPIs
>> were actually sent.
> 
> Why can't we set the boolean at runtime when initializing the pv_ops 
> structure, when we are sure that it is allowed?

Yes, thanks, that sounds like a reasonable trade-off :)

As you mentioned:

"this lifetime stuff in core-mm ends up getting more complicated than
v2 without a clear benefit".

I totally agree that v3 is too complicated :(

But Dave's concern about v2 was that we can't accurately tell whether
IPIs were actually sent in PV environments or with INVLPGB, which
misses optimization opportunities. The INVLPGB+no_global_asid case
also sends IPIs during TLB flush.

Anyway, yeah, I'd rather start with a simple approach, even if it's
not perfect. We can always improve it later ;)

Any ideas on how to move forward?

