Return-Path: <linux-arch+bounces-14839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E74C654FA
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 18:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF775358A6E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1B304985;
	Mon, 17 Nov 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auYCSxxE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C754301484;
	Mon, 17 Nov 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398429; cv=none; b=mPlrr1G5uk85u4uplxmdrsmBqBhSt1+u05nA2kZtkx9gfYTNzIeStzBmglscUPQXIk0Su/wxAwVjrBfejCT1cbPubwzp1cxNALuMxK3CxvIlrutEKEAt++/zGHBx98PPmSsLAhOj0gkVf+OIVtnoOmEkzszFmBYorADKjoqUgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398429; c=relaxed/simple;
	bh=xcaskcSeK6dNzaCv0moe8ATxJ9XohqfqvmJEObNmum4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9lcjouSkt73qgdkw4oAnq++uRmGQWZAj5u34sr5yQo9d+XhiQPRZojHbjNnZM+TjeSsl8j5LrdkllrPoXsiaCelg3HFNN3oT3cD2ggeZfsMJfOBz0gBv/eecmlxL7cgarF9KmrfWUaBgzOPAWyTTWnYfeFRKfQMp0ORmHKlAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auYCSxxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD96C4CEF1;
	Mon, 17 Nov 2025 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398429;
	bh=xcaskcSeK6dNzaCv0moe8ATxJ9XohqfqvmJEObNmum4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auYCSxxEolEdVdPP5hVqXRlt7AuV/UT6WrPa29QCtPBvB6LhWtxK/veNm59+tg6iq
	 rWqGh7NFp27ucHsHpE+PxOZC6j5PxVDjo5pOnD0QHkrYbGowV5ij7ERUBYhkkveU8s
	 Qzg6TBFQc+DUeNZ14jTGRDww4CnIYZTFis12VZGpJEwzucgudCK3WO/qGAhAPMC7y/
	 uuneSx1mR/5L0/EYwLyIp6CPdn57YNuXiEoHNjZnllcUZGQFacQDKvwPIybR0ThFFp
	 q5NSzE8k0Nzvt6Mn+oVgHtGvj1wYQsVXpn4r7yvTJbgDFs0FNmoLC3DfEgh3t0L6cE
	 NX3xoTtWTQtMg==
Message-ID: <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
Date: Mon, 17 Nov 2025 17:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] enable PT_RECLAIM on all 64-bit architectures
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1763117269.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.25 12:11, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Hi all,
> 
> This series aims to enable PT_RECLAIM on all 64-bit architectures.
> 
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of empty PTE
> page table pages (such as 100GB+). To resolve this problem, we need to enable
> PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.
> 

Makes sense!

> Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all 64-bit
> architectures, and finally makes PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE
> && 64BIT. This way, PT_RECLAIM can be enabled by default on all 64-bit
> architectures.

Could we then even go ahead and stop making PT_RECLAIM user-selectable?

-- 
Cheers

David

