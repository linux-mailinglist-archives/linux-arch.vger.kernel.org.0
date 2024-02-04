Return-Path: <linux-arch+bounces-2080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7708848F41
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129CE1C20DCE
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF422EEA;
	Sun,  4 Feb 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D9SAOIZL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34722EF2
	for <linux-arch@vger.kernel.org>; Sun,  4 Feb 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064010; cv=none; b=TZ0xK+f78pVz7V2fG9wVdOLRde1ZkxmBGr8vunt1A0o60FIgs4bYTekh2g7IULxSf6SlFCoe/6UiQsjIjsDqricRfWWaW8uKheMdk1N9T87LPLyyANKcTOOraUKUO1pXiqbAUpEPawImSV9diT/v+6LJKs6kSoroopq7UNUZTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064010; c=relaxed/simple;
	bh=YWptjRpXcGqKrXDeLb0WkkVr46kdOit9xa7JmKCgiVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qexGXVi6VJiLLg1qzLhDG+mECIyz9aC3lFWwrkGzsiKM/t2ecHNf2k19mXF5WFPGNbePdwQk0WDjvCeEsr02/SQ9vZQU0jXhq6Q1FhTw1lDEjp/S6f8bZMfE/mXNCm4XG4eOYN/C9k8drVnWym1e7o5xaDFBqyqoJDrVe/v8ycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D9SAOIZL; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1331635a12.0
        for <linux-arch@vger.kernel.org>; Sun, 04 Feb 2024 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707064008; x=1707668808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QsMafIxNnK2tT3E+d+X68HEoyZ0oqU7kYpJhvEviWU=;
        b=D9SAOIZLBnfzT+V42SiOJpeBJedg7s54vGo6VNBdLeKH+w74cVMQHHlp1bcsg3pL8Z
         7SBehekzqbrZ56dqUw/kYHwTBPH53ZuXPsUn/LmFhpOxfqLI/LctXa5b56QxFbfTCON8
         3p5bWDxCLkitkDEXth3xVg05o6SqgCHP0l3NhInLGvOe3D4IiwFIpSbB/2L/93ekY1M/
         xTET+NhyrdT5L3Hw1MiwelPd0YFqEwzMt6eE5YDgCBTuFrWB4+s+2gM7cZNJFaJ2VNQG
         u0XgILtVTOciWF4MdLW+IbskBOmkhYTjf7lbD5iMKIUBSXxuKxqYg8M4naLhVwOoAwqL
         4fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707064008; x=1707668808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QsMafIxNnK2tT3E+d+X68HEoyZ0oqU7kYpJhvEviWU=;
        b=utAbZAKEe8zqAYtNGvBdVxxb6pLKnE9phZ5ZrHeqL0cF6BQQycmhufagk+UrGt4t2Z
         7KDFD6x9GsQ0R4fd5SHRPkcaZXqBfBymiIulh6apo31jXbbNwaMk2oS427btsKeZvnMI
         m9JHzOZg0WN77pyrP9nTItdyv4aF/8AW2WUmfr5M/Tyyt8NwRLSr8GAnY1pg7YGjoh22
         SPp5rGzGB0jtx+P3/kOhAOO6B7EU26TUUAYzYsMLTRozycKEBLvZPEh6vRhmLnK+IWIe
         cBrn/fCRMB5YP95cwKbPhNJnW6wgEXvEJ2KvvzWAe/dL8FxkkakZn5srbqEQqvreB5uD
         j8kA==
X-Gm-Message-State: AOJu0YzEK8kAs5J3RDG/Dc+hhx89gX05nhVhJAyQMaBKnTpg1r5kFsru
	fEkHvwItwcyFFRB6YeRF47IZZRPMCJFl739WS0xDsCkARMQo11pG3Qe7csSR3vw=
X-Google-Smtp-Source: AGHT+IEdB6lRIkC8WPcW3s7wCnfJKQgWD9aaW6Yu/gYI+XGczVtWRxwYpKHIB5xk2H1n3y5Z+6xAqA==
X-Received: by 2002:a05:6a00:1c96:b0:6e0:4576:f7e0 with SMTP id y22-20020a056a001c9600b006e04576f7e0mr370773pfw.2.1707064007870;
        Sun, 04 Feb 2024 08:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU9qlQk1dly9VAoSOboZq8pD9fGdkndwUSu5KrIAO6PNtnP46oyJGHeHIyH+DvRKfTzIMJcU96Bx1CySYzoOBaXrFdAs2TALd7W+GPWDEbC489PvGofGEYv0UdJg8EEhDOQ9ncmUsiq2z+mwcxI/mOQ5qY24hPGhlBe31bPf1SlU2SNOZ05k+mzYfOHFZ+1TM56vqi3gYtxI05PClD7RAzdUXOl5gDx1pqzBgI9BpmiaE3GWerHCKo5mdp3d5u30tva/nghn9B92yuyZMdsQXfzLUQqiLo=
Received: from [10.254.132.93] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id le10-20020a056a004fca00b006e02f222c2esm2331289pfb.30.2024.02.04.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 08:26:47 -0800 (PST)
Message-ID: <9ef34638-a3e3-4e86-a96e-bc4694661adb@bytedance.com>
Date: Mon, 5 Feb 2024 00:26:37 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org
Cc: arnd@arndb.de, muchun.song@linux.dev, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb9t7WtFbZofN5WZ@kernel.org>
 <3b7e9435-d78e-4430-98d1-f4a839899425@bytedance.com>
 <Zb9_3K2Kp9d-dtcV@kernel.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Zb9_3K2Kp9d-dtcV@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/4 20:15, Mike Rapoport wrote:
> On Sun, Feb 04, 2024 at 07:39:38PM +0800, Qi Zheng wrote:
>> Hi Mike,
>>
>> On 2024/2/4 18:58, Mike Rapoport wrote:
>>> On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
>>>> For kernel PTE page, we do not need to allocate and initialize its split
>>>> ptlock, but as a page table page, it's still necessary to add PG_table
>>>> flag and NR_PAGETABLE statistics for it.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    include/asm-generic/pgalloc.h |  7 ++++++-
>>>>    include/linux/mm.h            | 21 ++++++++++++++++-----
>>>>    2 files changed, 22 insertions(+), 6 deletions(-)
>>>
>>> This should also update the architectures that define
>>> __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, otherwise NR_PAGETABLE counts will get
>>> wrong.
>>
>> Yes, this patchset only focuses on the generic implementation. For those
>> architectures that define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, some reuse
>> the generic __pte_alloc_one_kernel(), but some have their own customized
>> implementations, which indeed need to be fixed.
>>
>> I wasn't familiar with those architectures and didn't investigate why
>> they couldn't reuse the generic __pte_alloc_one_kernel(), so I didn't
>> fix them.
> 
> But with your patch NR_PAGETABLE will underflow e.g. on arm and it'd be a
> regression for no good reason.

Oh, I see. In some architectures, they implement their own
pte_alloc_one_kernel() and do not call generic __pte_alloc_one_kernel(),
but still reuse generic pte_free_kernel(). So it needs to be fixed
together.

I will try to fix them and send the v2. But since I'm on vacation
recently, updates may not be quick.

Hi Andrew, please help to temporarily remove this patchset from the
mm-unstable.

Thanks!

> 
>> It would be better if there are maintainers corresponding to
>> the architecture who can help fix it. After all, they have a better
>> understanding of the historical background and have a testing
>> environment. ;)
> 

