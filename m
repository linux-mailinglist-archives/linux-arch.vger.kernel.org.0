Return-Path: <linux-arch+bounces-15594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646FCE7268
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AE5030036EA
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616EF1DDA18;
	Mon, 29 Dec 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HEt/wjs1"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66B1E9B1C
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767020463; cv=none; b=QaHxQIgMepSYkJYwwQiAZJpmkVkJc5tqrRKdEu9bmpt1nAuWqJC02t6cuTJoX7qSi9+tSM5YJILhj7QY+AD7cHVtQ3QnScula+jaGUh8YYEC+recn75XKpzveZMkkRgkiqyG1c+Ni4H7G2zDhdFbZn5E2aw44pDiGyGK4xruMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767020463; c=relaxed/simple;
	bh=PPBVcYcgdOP0Js4PkjcKCsAb8PlbkiKIG7/mKprLRtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnYy1IxIUfXXsNJKYMYJmTv3y+LyWaf6yGzBLx8VW5cyfzgq4lhqCwCXb/z1OM4DLf1caLTm0fRPND1nR6ERkFuyG1GUgEFgGVeKgNKZgCAHBJc8F7PZmCdzKJNmrnstGj2jv9LKsqMp9uGolXGAdKy+T5yHOlWFmxyCoiPLo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HEt/wjs1; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <17a56acb-4e2c-4b14-bdb7-f64b105a3b4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767020448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPBVcYcgdOP0Js4PkjcKCsAb8PlbkiKIG7/mKprLRtI=;
	b=HEt/wjs1YBKqKSus5tbBwvjX5/EHdRZRtrWNmZLJtPQPKYh8VxQxwyZKjxk/IiPk+IiQfR
	0R/8Z0NMLDbV0LUfV73yZjG+6z8CBV/X6O8CLPV1lRHweDi2MpuzlmBauHs738b+JQswrm
	Y0+EAtI1oN6mMB13vLOWvOc1fE7nht8=
Date: Mon, 29 Dec 2025 23:00:34 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] mm/tlb: allow architectures to skip redundant TLB
 sync IPIs
Content-Language: en-US
To: akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, shy828301@gmail.com, riel@surriel.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251229145245.85452-1-lance.yang@linux.dev>
 <20251229145245.85452-2-lance.yang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251229145245.85452-2-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Confusingly, I'm still unable to send the cover letter, but there's no
error message. I'll post it here instead ...

