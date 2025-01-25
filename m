Return-Path: <linux-arch+bounces-9905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D04AA1C09A
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 04:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D60188ACF5
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B214A62B;
	Sat, 25 Jan 2025 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BSDs6y9v"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FE41C6A;
	Sat, 25 Jan 2025 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737774863; cv=none; b=oZk7BVnXeg8Qt9hZCfQGhlC0Qmq1VfvYvwOsvsQenvt9rVNFzfi+1t3K746HkG4buSrkVNpJeStRZGBWPmA1vUF8zMmsnQ2Ujmcyno2BtRVrNUX7QYmrC9rNt0tbD/LFBtRxG+Xs/O88JbRVNuEuAn2sP1ZTtskW63wivtV/feM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737774863; c=relaxed/simple;
	bh=hXv4kAp4YbqFGX21eGRaMVPOd3yJyfAsnlnOx/Q1xwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0jx7UfV/ptk+RMokPe9EDmRLZH2uZzO5vZhtme+KWQCzMiaxDNSu57hckHhm7/F/I2xi9P9Yyl2XH1RCXASP9rwZvC36/x54cLTffN5R0KVrqflSURCacKYtFSDyUhNi+LlEBc1FYS5ukCi4Scne43JCR4QakiOiwx5dw3MNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BSDs6y9v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=LKGqliAQYfe3AJnaCi04iReaMdS/Hf0gmqHVuNgKRts=; b=BSDs6y9v4I5bElN06szPO6e4AQ
	+V8dfXBZNRoJKzzHiP/XNBVUYCE546jZV9BfNxQOht4XhOo5dUvS4nXiHynotOubYBQgz0oIPeupA
	V1KhCJMILZZdX4kFLHbSqWFdSTjwjrL0RzNwCk+3DgkBdH7qIYnNj+wbcD8VxiLBNrHDguW8YAqmB
	N+rKf4CuMI13E06lIq1/bL7JVK32/sARSxKcjVZXyF3PyGBoTMNVBGFOI6G7FFiUM4lMPGTJ+URXQ
	eW0xUlTVNZaW+e6N1MMpBtQiyljQGbv5tzp8eRj9uQTHU1x6fKjwmQ1MKsDK+EPWRKfBvMfmBKUf8
	n/tNQLmg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbWcP-00000002qPI-0MmA;
	Sat, 25 Jan 2025 03:13:57 +0000
Message-ID: <879e64a0-f097-4bde-ae31-25a1adc30d5f@infradead.org>
Date: Fri, 24 Jan 2025 19:13:45 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: Add msharefs filesystem
To: Anthony Yznaga <anthony.yznaga@oracle.com>, akpm@linux-foundation.org,
 willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 david@redhat.com, khalid@kernel.org
Cc: jthoughton@google.com, corbet@lwn.net, dave.hansen@intel.com,
 kirill@shutemov.name, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
 ebiederm@xmission.com, catalin.marinas@arm.com, mingo@redhat.com,
 peterz@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tglx@linutronix.de, cgroups@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250124235454.84587-2-anthony.yznaga@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250124235454.84587-2-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Just nits:


On 1/24/25 3:54 PM, Anthony Yznaga wrote:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db06417..ba3dbe31f86a 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1358,6 +1358,15 @@ config PT_RECLAIM
>  
>  	  Note: now only empty user PTE page table pages will be reclaimed.
>  
> +config MSHARE
> +	bool "Mshare"
> +	depends on MMU
> +	help
> +	  Enable msharefs: A ram-based filesystem that allows multiple

	                     RAM-based

> +	  processes to share page table entries for shared pages. A file
> +	  created on msharefs represents a shared region where all processes
> +	  mapping that region will map objects within it with shared PTEs.
> +	  Ioctls are used to configure and map objects into the shared region

End the sentence above with a period.

>  
>  source "mm/damon/Kconfig"

-- 
~Randy


