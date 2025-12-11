Return-Path: <linux-arch+bounces-15332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B02CB45F5
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00F9A3011EF9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4621D599;
	Thu, 11 Dec 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiwoWh4c"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA0946C;
	Thu, 11 Dec 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765414537; cv=none; b=SJOIteA5e/yiZ20tMAbtTjwtjUyo19Y6LL7JkdV9nVESrqOlhMVR/Pl7FiP/pAdORN4KoCBF9SV5M7MlnxTUbdsVEzA2ajfdjqnEHRY6z1R5YGaKuzA6PZ5GXdzEEh5/mw2syZLkW4uibwztvMirJnfb0tRASHdQr5PUFWlkAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765414537; c=relaxed/simple;
	bh=mmnJHids8+nSkIZq85Pu+urD+05j91c4LH2HRhu2rmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/mk8ww86sYgVBHmSxlzdfZVOw+rxPWMLdl/ig8YCRq2J8hHCSamcXZyAZqzo/W5JJKt63s5O8RsXJkSOCXUJT6gD+1CPo5MBjNpJgrgJo8roPjWs8wXASXnB39K19b7k/gewIIzknX/VZdlE+AwVGfM7O4R1q75DTGBHaxK8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiwoWh4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3A6C4CEF1;
	Thu, 11 Dec 2025 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765414537;
	bh=mmnJHids8+nSkIZq85Pu+urD+05j91c4LH2HRhu2rmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kiwoWh4cp6k9wawe4ePdjIv69qdCmGmNg8BibmXSqvQeFYCUTdpMfqP/lzIQZjOyj
	 XipqZU0q/YY8IES8WnOjX2pppqJfN6OjsvEViMvidylU/6azM7ySr6baLBlD+1Txxf
	 Y4SYh1eE95mjIkL1WRNw17BMrThDZfxGofi0g8mRQp46MTXHhVlwPNu/kk1dNh5MyX
	 TJTuDADHfTuvUhAaAYch1h+r/Zph6YzaZot7SMoG+w8bsvWXn31KjlvoCjgMR0gedV
	 i/9F9qzEtpztZjwywrO4Dg2vDMp/qLkL6VRVr2aK6c7VjSqbvn1KavnNx4RRZQu46w
	 JPI+I6PQtZi/Q==
Message-ID: <83c42274-4c26-4a9e-8199-190336c18d79@kernel.org>
Date: Thu, 11 Dec 2025 01:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm/hugetlb] 0e1ad0324a:
 WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, suschako@amazon.de,
 Laurence Oberman <loberman@redhat.com>, aneesh.kumar@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Liam Howlett <liam.howlett@oracle.com>, Liu Shixin <liushixin2@huawei.com>,
 Muchun Song <muchun.song@linux.dev>, Nadav Amit <nadav.amit@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <202512102246.ee3d6d07-lkp@intel.com>
 <3966c02a-ec07-43c4-a230-8453f000a8c4@lucifer.local>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <3966c02a-ec07-43c4-a230-8453f000a8c4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/25 16:02, Lorenzo Stoakes wrote:
> On Wed, Dec 10, 2025 at 10:55:40PM +0800, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "WARNING:at_mm/mmu_gather.c:#tlb_finish_mmu" on:
>>
>> commit: 0e1ad0324aabb5aef3ef409de9a395cda7ee6098 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> This is the:
> 
> 	VM_WARN_ON_ONCE(tlb->fully_unshared_tables);
> 
> test case, so is likely the issue that Nadav raised where this isn't being
> initialised properly so is just spuriously firing off.
> 

Yes, I assume so. Surprised that this series is in -next already, so I 
didn't send a fixup out yet.

Let me try doing that later today.

-- 
Cheers

David

