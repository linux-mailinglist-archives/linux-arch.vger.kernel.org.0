Return-Path: <linux-arch+bounces-2083-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE4849244
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 03:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A0AB21FF7
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 02:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A78484;
	Mon,  5 Feb 2024 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DF8fvztd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DC79CF
	for <linux-arch@vger.kernel.org>; Mon,  5 Feb 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707098752; cv=none; b=EnGNC9YFBgpJMzFIo4H5fmbqpnrf8E4Yu98Eo8DLgFWhP6cq8Jp9YsNdDnWJZ4HX+BgMwBCJ/QSfjDE7NWCjhtEAYt5NQGy4bZf3SmR6RNiTmSukT64VpAfboYhbRDPQLNyHBj9nHOrrGJQMsWTYxRnu5NuqkvX7BF42+gEGhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707098752; c=relaxed/simple;
	bh=5XwGgmp3BPmDJ0fpZR5jpmy1vISiDiiwafuKouHj0Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxyQxnydvBewUBONIvN9CNZQiWTyW/1eWv3wpMWFasU7BiCArPBLXHunChzuhE1IbnmqdX1Mm5JWzhxjrSFJv+FyXBmBLNGlPn0g0SROBSZNfCODrFEWKoAfDWvbgsBEI939ka/1OQCF2bkMahX3DTANXPAJYwf994U8I/XnLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DF8fvztd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5a0dc313058so788811a12.0
        for <linux-arch@vger.kernel.org>; Sun, 04 Feb 2024 18:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707098749; x=1707703549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+8ijc4eH6dLtZNsmA9IMPtPI2LG666HTBs74Wzg/oA=;
        b=DF8fvztduKDHbwxVElTu+5bf3wh7r1kQ5rK5yvVhkjhMU66RwVhkIHLzFrz0fhnzdz
         UfAVI/q/J46tRSUr4g3A0roLFeP7ozbj3wdOBN1ZCVyGjp6b1+YsbOzmYbFTtU0eaVVC
         BNCpPyu7mEVdnJlNIgJSPgtNJOMKaHdRzTYMnw02h1lzBs25pg45+Dy7+Ak2fAHz7iu7
         QkkMZX2f4I+5Gy2T4rsDI2RBe2ZmtRUrrTZzQW/T5v9iRWZOJhiU7JL8DG5ceOH0Mj3q
         7LSvO8hoPR2Aybjhfsy9WcIPO0+O2emlpAyNIZgD0pF0ZQu7qu2RQeOOldoWkVt7cfqq
         +lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707098749; x=1707703549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+8ijc4eH6dLtZNsmA9IMPtPI2LG666HTBs74Wzg/oA=;
        b=rshaiHS+051SdkKxOLdqqhQE0NFu11gjfM9AUTPp98WptuskQQpl0ZblajjXI+pcer
         gWZ8gSLKtqs4RamU4dEuC2bmpA4cpPWbD9yrw6rupSnerKyDPJ5IG0FK+KAW2TzJqSxR
         9dtuXS3bzYpcLihRv0gqBC63Rz+17C/O9FjPt+9ps5gBYIFirbE1G0YzQqNI4/0bXRnO
         WAQHiCl0d6qCng1bDYhTR62sm7Ze/0UqcU1RnzA+IcYYcMwf22YVyhnAs3haxlPkd6Vj
         CcH4Ali+ERR0wONju6ircFjGC+2Cv3zT4+dKEadQXOvLd+c2JVMQG4oqImj1aI7HEvPO
         vx+A==
X-Gm-Message-State: AOJu0YygYw2OosJeA37oxnK+ppeHJzwLveKK0nYY7nNNofLfjdSQU6F1
	OQxAjOlkp5fCfTGAvJxPATrgGv77MgLCY5Wdf2y6/6FtTNF+b5v5tWRpJcTmo24=
X-Google-Smtp-Source: AGHT+IEzhehZjKAhlUs4m4DTV3eBklOKslGHGUkgNKCFL9+Cs4meD2BIvUUhLUS4TWm4vHr3yHWktg==
X-Received: by 2002:a05:6a20:1441:b0:19e:317c:b353 with SMTP id a1-20020a056a20144100b0019e317cb353mr15150270pzi.2.1707098749629;
        Sun, 04 Feb 2024 18:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVspSycYoIEXn4EgPZz7USoAoUFNLMU/8YDPVu6q/bF+OElJehghZkpfpgkoSsXTccwcG7aH9mG22TmU81aGJgC1CzbACMVutQROUUnzkgl+HummRTkXxn+DImzjz4YgmIJM6sT2hOuMKBNi9AxnraUSFPW4Gih3sg2+BZcDSHDqEEsrnbGVk/6EwO+So0Z9RpIi8o2ugDeLG/Kqum/1eTpZ+GYE6W1eRXia+S2qz9JZGCUsJ0=
Received: from [10.255.134.6] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id mn16-20020a17090b189000b0029696f7f443sm966122pjb.50.2024.02.04.18.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 18:05:49 -0800 (PST)
Message-ID: <7fad74d9-134e-4606-abf7-3969ca01acef@bytedance.com>
Date: Mon, 5 Feb 2024 10:05:42 +0800
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
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb_cmZByel4cULDP@casper.infradead.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Zb_cmZByel4cULDP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 2024/2/5 02:51, Matthew Wilcox wrote:
> On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
>> For kernel PTE page, we do not need to allocate and initialize its split
>> ptlock, but as a page table page, it's still necessary to add PG_table
>> flag and NR_PAGETABLE statistics for it.
> 
> No, this is wrong.
> 
> We do not account _kernel_ page tables to the _user_.  Just because
> the kernel, say, called vmalloc() doesn't mean we should charge the
> task for it.  Moreover, one task may call vmalloc() and a different task
> would then call vfree().
> 

Got it. Thanks for providing this information!

> This is a can of worms you don't want to open.  Why did you want to do
> this?

Ah, just because generic {pmd|pud}_alloc_one() has opened it. ;) And
When I looked through the commits (e.g. commit 1d40a5ea01d5), I couldn't
find the information you provided above. And that is why I CC'd you to
double check this, in case I might have overlooked some important
background information.

So we should actually fix generic {pmd|pud}_alloc_one() (and maybe some
implementation in the arch), right? And it would be better to add some
comments to clarify.

Thanks.

