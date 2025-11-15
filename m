Return-Path: <linux-arch+bounces-14802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB74C60212
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 10:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34E93359C7A
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ADC262D0B;
	Sat, 15 Nov 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/YUuAH3"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E319DF66;
	Sat, 15 Nov 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197792; cv=none; b=Hdfb8oyIxtMVP2oxj8RomDrSqJwHFUN5WoEUIy0r6YUA/65p1jVP4zqhXiVMKr177tBEVheBJwkG/I248QztpGMn7F8AuZ4DT9g+51ASyW+AbcyV7V06X9JudbAuc7SaSADyTzOGHj55++vO+jz7r/jqfHV3Mz+3lI/aNR5LVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197792; c=relaxed/simple;
	bh=/pf5mybSf+DizIxpgDclOi0C+qK6dhrOakTgpHQTQsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1W5GO1uahqKWPqPG8/jhbfUEeCLCH0zU6WU4yhXYW4MUQAM9EBYwZU+aAsCfkXti0ZHmrJhE3N2AHf0LHPcmWdsHksq4+kJn/tI+jYUMCGiJjxvvjNDtkUU55+uaqw6yXAuNN7c/IwAiI5X/PTm0JPBe1w0r7CHg8hqaXcXigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/YUuAH3; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7bd2dc1-e7a5-4e80-9cad-2acac8065876@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763197777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfm+MQXULvTpw1aaUw2GJFWd+i9+TwJ4lZKozAzdhws=;
	b=M/YUuAH3IyWhHYn5ZNYhvN1s6M7xHKp63PCRpmUrEKXu53qQ1HuLBjIKdBsHH7i0tHGrO2
	MjXPtZjS13xHfyK5QioHDDtwAUCXkyGqTgTAJkTaZnWGxD0YWfwq7kF4quaoj4fCBUjoDA
	i6LWMMM3rWw68vjk72a2dDN7mW73xXw=
Date: Sat, 15 Nov 2025 17:08:35 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] arc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Vineet Gupta <vgupta@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, david@redhat.com,
 ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
 <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
 <4e120357-6fa3-436a-8474-b07b473381b6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <4e120357-6fa3-436a-8474-b07b473381b6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/15/25 7:10 AM, Vineet Gupta wrote:
> On 11/14/25 03:20, Qi Zheng wrote:
>> Strangely, it seems that only ARC does not define CONFIG_64BIT?
>>
>> Does the ARC architecture support 64-bit? Did I miss something?
> 
> ARC is 32-bit only !

Got it! Will drop this patch in the next version.

Thanks!

> 
> -Vineet


