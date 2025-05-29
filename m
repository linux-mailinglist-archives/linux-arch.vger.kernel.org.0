Return-Path: <linux-arch+bounces-12138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4BBAC8230
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 20:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD0B7B1F2A
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B52230BD6;
	Thu, 29 May 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQAfaKrX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBA21B184;
	Thu, 29 May 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543539; cv=none; b=hLiWmkQKpOAjfDd75/7ISgj0ZAMAigI3Htc6Uct3OENWt0ISGzHtVAE9Jl9im+0fmWax6G+6IiwlB335ToHENzvczpvWXvO1n3yh26UbU1NG3MigqIHFKAaV2tVORh7n76xsApVbWIa/hos1ZLPHD8s0eqdEAcZyGWg68H8ioNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543539; c=relaxed/simple;
	bh=izhbGzD/gIasApbaGAVduWJRDRGKZ0Ha7wcSglXyLpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRJKWEix+VpXGkxhKk8oxPCKM6kggQi1PItKhDfK3FPaDpJ4iAFfJBgmT8qdfxkrlETH6Dnc2DUrxXIxOXM3RXUE+hT1qRq+7ZDqFNR8f3eD0ijNX5mIzFUnJewnMVBR0IzfCjna1rNo4ulWXI+qkV1S9ZgtXyrp2LSThG86BkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQAfaKrX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad5273c1fd7so252761766b.1;
        Thu, 29 May 2025 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748543534; x=1749148334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LGWBvQI1vDUtAHOCvyOaAxPV1uBhtbnvWvq9BppvFw=;
        b=GQAfaKrXGYDw7cmbID8ZPxh+WYGr2BDPq3eQJbPZibrrSMd0OyaRtijGB/VFaoQAY3
         8utTN+E3wRTgceJgwRsIr36ZKIXmNZQgAmXPJCiYWBHHa27NACP0Bgo4x2mfxiulN9Vw
         1Mrjs0qAmlmXO67Hp5G371aLDtoOTbSazHBUSAYC72zbazgWhZqGOSTooNoMT2nZoxzq
         tj6Nd2yIo3on+TbGwegpx0NZPr9x3q0h/yt/LqZ/jFMvlriqihuI6KOwEE2ozyATBsnB
         sUxyvuv0ZLlcH1HJUyTuBjueXeb+Ox4wiS3m3fzeQVOHEPHPiMxDhbCmNRfy8UOSpikn
         rYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748543534; x=1749148334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LGWBvQI1vDUtAHOCvyOaAxPV1uBhtbnvWvq9BppvFw=;
        b=h66zVSIQv0EBLhhVJiJLTjqE5DQN6QLiqc4qnmpNtYU8BNRDzbraz004+4nGzr8eWC
         6dtyELsZGC7rlRa9V1FJlUaWLXmZTuzzlf4l17IaKwWbCGmEwbb4TkBt2ubvhc9eb7aP
         0cWXFILx2TCsgiPF83Z0VFtYDL4MFwGxYurr8DrCUZbzIH0MdRylMel9zw2ZgAcxIJop
         I3hrb7bwVj9WcetjG9z79+az3M3ahU4Wh9WEXRKiVQ2RGxm+Rf26/J74poT2/XclAPef
         eSe3gLo5a2glOPKXK3IgMNBNpqE8MkBLeyLdaWBELrlnnyCXYIEhbaE0h6VQYBPi24HY
         kPuA==
X-Forwarded-Encrypted: i=1; AJvYcCU+HGIKTPJa75n/9OIEhYTDHEBRWBM+L0lTtCfk+VhHJUXXERyu7r0/wcYoH4j3xKj4M9YfDxcuNDkj0x6f@vger.kernel.org, AJvYcCUAo/LBk4fFc+y8WdE4C6RexuIAqQqV5rjE7v49TNUetJPd1gGsXWVqwjdVzSyO8tj7uIyVV3Vc8eU=@vger.kernel.org, AJvYcCXxDLV/tZ0ny2G64AO21rD7axozhmZfVpmugDP9+tR3zO1+5qOMs8Q+j/2oxKczS4uowVcoM3AWsk1y7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUSsKIxabanKPrt+5+1jvdpg3k0N7FCUh7hgSlFGY8G8uO13I
	FcYPIXfv56c/WfsR2cEaPFKI5yQpUdCQKRPq+TE5mi8LxkV1iq/Xbkfg
X-Gm-Gg: ASbGncuQU05OOh6UGFRA+hDiMNz7sYtbfIweE1pCWqDDz4jzdhbQyfvYFtN8ixQ4j4Z
	6CK783ViS8cVPnLpt5+LlO5ue6zA5vRPpQo94iTau7lUEZsAvlNyR63ZzfrYDkUdTU2Q1aII1xh
	WZbiBZQBgQZuqfDN8UshY0EsK5DzwdMhgVWYwqSNf9eGjjbDg3kLVC44+Uy4Jn2cpwyZXWTaHXF
	AjiFWAHlT8S+lbfQS4xqfIyMDipDOLKT50h1y462+zufk568toGW1Q1l2J1D5lKUpFkgW2ItQ3T
	zByZYyUirqMDKQXYP9XX48t8ktRDCY4fgvMEL5E6KrsheC7lnFXeVA6+8ipEWbxHr9HhBjrr4lK
	grcDRl3aVa8vvf/mqWcpKivPs
X-Google-Smtp-Source: AGHT+IH3jMaZbwa3JBJe8orI1Uw0kXh5RxmFXNau0vVoGSKJtJHkYT5j19OFg78Tkin/EtohP0YEWw==
X-Received: by 2002:a17:907:3f29:b0:ad2:40a1:7894 with SMTP id a640c23a62f3a-adb32582f61mr52689966b.41.1748543534216;
        Thu, 29 May 2025 11:32:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:18cd:67ac:6946:5beb? ([2620:10d:c092:500::6:9f6d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60567169d14sm329705a12.74.2025.05.29.11.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 11:32:13 -0700 (PDT)
Message-ID: <162c14e6-0b16-4698-bd76-735037ea0d73@gmail.com>
Date: Thu, 29 May 2025 19:32:10 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <c7fqqny5yv7smhxnxe5o4rc2wepmc6uei76teymfhxoana34nk@sfqnc2qclf23>
 <aDij5brAsGJVHCFK@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aDij5brAsGJVHCFK@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/05/2025 19:13, Matthew Wilcox wrote:
> On Thu, May 29, 2025 at 10:54:34AM -0700, Shakeel Butt wrote:
>> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
>>> People should put more effort into allocating THPs automatically and
>>> monitoring where they're helping performance and where they're hurting
>>> performance,
>>
>> Can you please expand on people putting more effort? Is it about
>> workloads or maybe malloc implementations (tcmalloc, jemalloc) being
>> more intelligent in managing their allocations/frees to keep more used
>> memory in hugepage aligned regions? And conveying to kernel which
>> regions they prefer hugepage backed and which they do not? Or something
>> else?
> 
> We need infrastructure inside the kernel to monitor whether a task is
> making effective use of the THPs that it has, and if it's not then move
> those THPs over to where they will be better used.
> 

I think this is the really difficult part.

If we have 2 workloads on the same server, For e.g. one is database where THPs 
just dont do well, but the other one is AI where THPs do really well. How
will the kernel monitor that the database workload is performing worse
and the AI one isnt?

I added THP shrinker to hopefully try and do this automatically, and it does
really help. But unfortunately it is not a complete solution.
There are severely memory bound workloads where even a tiny increase
in memory will lead to an OOM. And if you colocate the container thats running
that workload with one in which we will benefit with THPs, we unfortunately
can't just rely on the system doing the right thing.

It would be awesome if THPs are truly transparent and don't require
any input, but unfortunately I don't think that there is a solution
for this with just kernel monitoring.

This is just a big hint from the user. If the global system policy is madvise
and the workload owner has done their own benchmarks and see benefits
with always, they set DEFAULT_MADV_HUGEPAGE for the process to optin as "always".
If the global system policy is always and the workload owner has done their own 
benchmarks and see worse results with always, they set DEFAULT_MADV_NOHUGEPAGE for 
the process to optin as "madvise". 



> I don't necessarily object to userspace giving hints like "I think I'm
> going to use all of this 20MB region quite heavily", but the kernel should
> treat those hints with the appropriate skepticism, otherwise it's just
> a turbo button that nobody would ever _not_ press.
> 
>>> instead of coming up with these baroque reasons to blame
>>> the sysadmin for not having tweaked some magic knob.
>>
>> To me this is not about blaming sysadmin but more about sysadmin wanting
>> more fine grained control on THP allocation policies for different
>> workloads running in a multi-tenant environment.
> 
> That's the same thing.  Linux should be auto-tuning, not relying on some
> omniscient sysadmin to fix it up.


