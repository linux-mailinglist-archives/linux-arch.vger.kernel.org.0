Return-Path: <linux-arch+bounces-9596-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB45EA01E67
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 04:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8515B7A1D9A
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A9E146A6F;
	Mon,  6 Jan 2025 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XnIvtuOV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779E152E0C
	for <linux-arch@vger.kernel.org>; Mon,  6 Jan 2025 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736135633; cv=none; b=iQT8ppDLS9E/yIBbIWCjltaQ5w1HUDkbGMNSnP+nQz+VYeLEQgW2jnIG3DYRbWDxlWj93+pwHQvXIh9C62mEorIM2iVJXXoNn+Pm+X8DQiPi2zdjaKAfA7bdi0s43rex3+VltqV9qt0loBopKpGxlTFl90Hh8JA4bUkZ20qU6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736135633; c=relaxed/simple;
	bh=W5R5SVhoruE2dQ0Ov21TCrDEEfRfDgUrkE/35gJj4fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4//b6UkdO7X/luYezaRjb5i7bRu1g9ZGi2qmPoxNWR4Zv8b4wSw8TExbebKeNoLHcmw2dhQ6djRLl5rPgcY5GJYXJRvx7wOoZLDM3g6BmGCc/LAhn7LRu+rDAQRjdD20Glj4fZmsYADH9MfVIK1jVUcJfxKkSxEXA+p1/SvyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XnIvtuOV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f441904a42so20367439a91.1
        for <linux-arch@vger.kernel.org>; Sun, 05 Jan 2025 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736135630; x=1736740430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q466ctbH84kLf48L1cXJtHFTRzDl7be/n0cI3LGmOM=;
        b=XnIvtuOV81XcSbEOVEqkLIGy4oUE2RJyokQACtMv99teM4sXVRHd+9dQ2jHVTl/oPe
         5ggtpLIQ9WMmVdXtIn9UDEH5NWgL7MuSgNXoxOeYFny6E0z8tYaSIQkCitQql/fgDcu3
         4IxMqEubmtXrjfF5c42T6BOzsCKAsrOCOyP8bVmBBU3xhxEl5hSdzZFWBWivJehX/Mc+
         EFFXyRhbcAd4kbayug/30opeCkPEI5Jqc4Tv02v4QA3makjbveDX1AVkgOEqTWpTUsAL
         ImoyBAfSR+PldJu8Ds0TC7GffSCjtvCCBmYNQrXTJVFG418+lclj2fpI2adbQeqTi1OI
         19TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736135630; x=1736740430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q466ctbH84kLf48L1cXJtHFTRzDl7be/n0cI3LGmOM=;
        b=o2I0uuti63wLgCI7QwGO8OSi/9UGrGuFZn1XCiTwm1/ifFkHL+eix9O01ecl6Cyc/L
         eWXJre4BivSk7G2/Fe8M3j4/nZj3u6pGWYU6xaQYkryeUovy1QSZ/H8Wc2Of/ARgOihx
         LjtiDYWZaI1BjisFhNX88ZAClKGJRzIW8XcCpJ+icDBPW5zxumYfT1LigYym696BUIOy
         yQWCoZe4CSYx8AkM+gM5A7oe/Ug2JXlGdSf1cWF8Uu3743W3C6Dw8JrtzGq71yvkOLq2
         /fOl26jkRKaOoClIeycQ9QmjbuNTss0BSPgF/tzWlX2SBJuog5bTgtwC5iQPb3ya9rrf
         QSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq8WIV60YWPJ4wg8L+nGhyVsNsr0HmyrBjdsM+YqIxX0W0MM5ppS+6xmjlZ4+94vKZPoIsBMUwJcLi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KcunXL9Qh6VDMbCliJjEjmWz8+I9gKyORumt12JE/5M9JJSP
	8a5zt3FQtMW7dkmfzfpanztfpxfvrnzgACVT7zzVFUNBnRHOUbV5/JNKcpRsy18=
X-Gm-Gg: ASbGncsqHLYeddJ4hvpzQ7tAb/b2K5FdlMnp2TQaL0bmihqLLGv/3JiuiPhAYqqwbJr
	ARLzoeT0hZLV9sbbY7q1A0LzoAMaAgXou08KX8/OZye1y6qEgpivN1+xi0Yc5f2R9X0CnhzwSlG
	hCk4Ba+AlnGqXzHvazygJ+P964rT72uWCGseIRZtcuJObKuJPa6fSSZOyHtQDmEzdd0HwEX9cWQ
	uYVY6lnZU1VcFwSzVuZZ7jJK7iIkPfwXihtxANReWb/bPITRWGA2awgjiYyumuk/DXLofYNsnDM
	Psr0oA==
X-Google-Smtp-Source: AGHT+IE2eKUVGb+J7TSGZASTVnkByt6mt8YLIy++PUNY+VFfsnF7zlybMe8WL3Umwm8kwi4ry/BkkA==
X-Received: by 2002:a17:90b:54c3:b0:2ee:a127:ba8b with SMTP id 98e67ed59e1d1-2f452ee83d9mr71788615a91.36.1736135630440;
        Sun, 05 Jan 2025 19:53:50 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02f72sm283551435ad.249.2025.01.05.19.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 19:53:49 -0800 (PST)
Message-ID: <a84a7b0f-dad5-4100-9d0c-3b515e7fb71f@bytedance.com>
Date: Mon, 6 Jan 2025 11:53:36 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: agordeev@linux.ibm.com, kevin.brodsky@arm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
 <20250103111457.GC22934@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250103111457.GC22934@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/3 19:14, Peter Zijlstra wrote:
> On Sat, Dec 28, 2024 at 11:26:22AM +0200, Mike Rapoport wrote:
>> On Mon, Dec 23, 2024 at 05:41:01PM +0800, Qi Zheng wrote:
>>> Here we are explicitly dealing with struct page, and the following logic
>>> semms strange:
>>>
>>> tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
>>>
>>> tlb_remove_page_ptdesc
>>> --> tlb_remove_page(tlb, ptdesc_page(pt));
>>>
>>> So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
>>> directly.
>>
>> Please don't. The ptdesc wrappers are there as a part of reducing the size
>> of struct page project [1].
>>
>> For now struct ptdesc overlaps struct page, but the goal is to have them
>> separate and always operate on struct ptdesc when working with page tables.
> 
> I don't see how the current idiotic code helps with that at all.
> 
> Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
> there should not be a page-table anywhere near here *ever*.
> 
> Yes, some architectures use tlb_remove_page() for page-tables too, but
> that is more or less an implementation detail that can be fixed.
> 
> So no, please keep these patches and kill this utterly idiotic code.
> 
> The only thing that should eventually care about page-tables is
> tlb_remove_table(), and that takes a 'void *' and is expected to match
> whatever __tlb_remove_table() does.
> 
> Flipping those to pgdesc, once its actually a thing, should be fairly
> straight forward.

Well, since I've already sent v4, and that patch series is mainly for
bug fix, I'll send a separate patch series to do this.

Thanks!

