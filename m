Return-Path: <linux-arch+bounces-2084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5784924C
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 03:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91724282A8E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6018484;
	Mon,  5 Feb 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R74ULAnN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB579D8
	for <linux-arch@vger.kernel.org>; Mon,  5 Feb 2024 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099276; cv=none; b=VnCQju7k/oysrWnU1gtE3cntiBXzumxDbRGOrZUExtIEI/gQi4F6OXX7Tj9iy4tEuuCY0ajYPGYH84kGqf5jtUvWT+5Thf9xKY2mdZyl6Wc4PCFOM0HqXhHph2YC0s/fqiZNmslVxVv+uGEERR2dveaeM/nUtv1ASlZ3luYuJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099276; c=relaxed/simple;
	bh=pvgV0YknqsQnvCyHtVH/GSHnUSA++yYfdumu8uYYEbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+fB0x3gH4ZbhmVe1KRbty6ChSgLtwkj4OM9+CPaLQDDNvxwDosWcVVFS1hBoPYwsubircVvKN2W+Mk/nxVMWhzJQ0JA7zaxXvDhUVuA1fqokNQC7L1xoZ0wcu1p1lO2nKhT2FFS7vV9BjGJfCAbY+CVmvMBGcc4DOly749mgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R74ULAnN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290c5c705d5so767885a91.0
        for <linux-arch@vger.kernel.org>; Sun, 04 Feb 2024 18:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707099274; x=1707704074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFyXg82UWmlPE+ig9jow6pwJAF00791AsGoKKK0IIVU=;
        b=R74ULAnNyRaspEwTcXk8u6zl1mJkUns22APMaSfjfQLXvpOn3ajo2nTylRiYakCvmk
         6IA8ngpaUQNnEiUTjtRKmbKktbK9VZvshDLLBfSTr7zOli0T72waXnIZuVDrBb+Hhv16
         lxP5ZpynbovyXm97ASMw6ugYYV98bnZwm4hqdy4seAJdpwzuO/5BLHpS3lZDLosu3+0V
         fKy6g60lxTnoyw7Zy15xDj8iuyy5+uORblYxQEiAfvdA3XCoQuVD+4fGc3UrVE7s7hzj
         QpvFtBlGC1+YXmiSkS/mP2tShjwAXPUegYgJH/WD23K8Dmk3G6C4bCOxqWjK5pejTpqE
         4KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099274; x=1707704074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFyXg82UWmlPE+ig9jow6pwJAF00791AsGoKKK0IIVU=;
        b=SxBaisadVAttiFA44tyRCaEjJdOw96UX9HJs+/yB7lHmu7WfQYIP0Zhmp4YJRJk5pC
         6OHJXElfU3/fBaM+OTVEdypIGkHm+Pm2ppZirq19UDLO8X6rQXDvZIzalt3WCcJYSymM
         f+MchMnfFnpjek74dRbQrMhMw++kW3pZITdf+Qt1Oaf5elTorXl3VL2tnV3FIbtOWa6J
         7AZH4O4ni7DGL9Lqbz0cRqqz4WyNLlKymMMLuE0gzcTxmVDd5hsri2E7Prjw5h2rwZxy
         4ngElvpJwXrojF2QiGiPyPDko7PRkK6tyhBXf4iW7D1w4ufNFK6OK9Dd69qo4x2UCmqA
         Xn0w==
X-Gm-Message-State: AOJu0Yxr07nS/gRjpkwnk6cT2ugsQVzWoXlmXJlDWvcw+OXdVLAoeHrx
	tr5gOVPf68cf+kFogr0r63UeejRG7Z+vNSj+X1SxoXggz0GWVMMIFa8cAercIe1CR0F8xsKwscA
	r
X-Google-Smtp-Source: AGHT+IEwQIC7jXtmYLSmgwxADVxy/6gqZeq63vbYZBJwSehUDq2LkFNeFIhCOM0IeNs5Pauzd+/fJA==
X-Received: by 2002:a17:902:ee85:b0:1d8:f06a:9b6f with SMTP id a5-20020a170902ee8500b001d8f06a9b6fmr13589434pld.1.1707099273829;
        Sun, 04 Feb 2024 18:14:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzaWXF1IGiLYQqU3QdZbMeWQAsPFYeTxr6WYf8piiX+Rb9cBUevGUYHNHanDzwgeBQAVOlflGkKjXDG1Qk9WzOYcCg8rxTD7t4AqTTUuvvvF5pPp3QE+heGBjMfpyObA62NSgQ63kf8omEk+qZAPuRwG+f2G8CtR9rq1vycChrW7KFlhIkQ0XqnBUC6wIQCaDNC09tMzQ3o6gfIWhpemvLBy7nvh69So3UtDe1jFBv6zH3Pxo=
Received: from [10.255.134.6] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001d9a422e0c0sm1602110plj.20.2024.02.04.18.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 18:14:33 -0800 (PST)
Message-ID: <d464ef84-fe06-4279-a7fb-5a0cadef4064@bytedance.com>
Date: Mon, 5 Feb 2024 10:14:28 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: pgtable: remove unnecessary split ptlock for
 kernel PMD page
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb_dT43-oPsRplhi@casper.infradead.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Zb_dT43-oPsRplhi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 2024/2/5 02:54, Matthew Wilcox wrote:
> On Thu, Feb 01, 2024 at 04:05:41PM +0800, Qi Zheng wrote:
>> For kernel PMD entry, we use init_mm.page_table_lock to protect it, so
>> there is no need to allocate and initialize the split ptlock for kernel
>> PMD page.
> 
> I don't think this is a great idea.  Maybe there's no need to initialise
> it, but keeping things the same between kernel & user page tables is a
> usually better.  We don't normally allocate memory for the spinlock,
> it's only in debugging scenarios like LOCKDEP.  I would drop this unless
> you have a really compelling argument to make.

The reason I first noticed this is that we didn't allocate and
initialize the ptlock in __pte_alloc_one_kernel(). So in at the PTE
level, the implementation of kernel & user page tables is already
different.

Thanks.

