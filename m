Return-Path: <linux-arch+bounces-12554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC639AF5AD6
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 16:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CAF487857
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90E2C3757;
	Wed,  2 Jul 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE77afpI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B302C178E;
	Wed,  2 Jul 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465708; cv=none; b=UiombGsVTMQkUsqSSn80tO1I/dx29oSK8tOQn1jKtOguY7LRgP7PAIyKehoPLByUvbGs7zUTEE+c5th8Lhxl/zqiFtmG5PdBI7ETFoO0Qbll/ewMiSG2oqkz9MhqjpxAW7d+dIdsiZcsMXomrToU9zSzxcz1xZVtchrd9la/lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465708; c=relaxed/simple;
	bh=d5uoh19yxFqx6sK5ttcyq10lXnHTCWAggukYDRXajT0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XzfhhMgKUD7znr5D3MwQ9Z4MNfuAi0mt5kBBd6In5UVPMoYpcPz6KgUEqk6MVOdODpK63fDsgcdJ3jb8EVF7DhHYRmds32AVbNj+hxUsUp+fxYvcw9x0jCNEhw4UbWL5iOOlBdQogyeuEDIPcDjb7KcDeo93P3qPhlO9lSG5O0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE77afpI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so7089460a12.0;
        Wed, 02 Jul 2025 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751465705; x=1752070505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ge8cq6uMbt9t+bUAaC+G6fQUxnqQJz/zQaWC4Noi8MI=;
        b=RE77afpI//crx9yjNRjqNIkVzlnQQWL1pOdrZ8FRK04AJqZYDRiaprgHZPAsp3tqqm
         3AaaJ0hjQ3x7bHzUpgPtyT7WzHkpv+Lo14/P+cmWNs4US6pXYN75jdvg1JogEnQB42/1
         Lz604AEw75amqTU1bEFzLxnZt4XZmzSwp7DlYsYE8Gs9ge8SyWe9vAQTEY28qHddR/vo
         ucVqlaXavNtYVBcYhduLUggc2NJwyet53fZNpfFEOG/e/4Xd/+ij01wbnPfqUk+WFq92
         /MMiFqHyzCTnOxgVGNJI6kfqnelxSJmFHhqDOZ72THl0xkkk+AhTZpuIIh2752pLCw8l
         0STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465705; x=1752070505;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge8cq6uMbt9t+bUAaC+G6fQUxnqQJz/zQaWC4Noi8MI=;
        b=mqhCWeIFgmb9T3PX31sNiFY/OQJpmeKf43Gf6R0WTyYYqQ4/62q1w9Fcwtfu4IIgtI
         dXNx238g0dg/DCN0Ao+R+9exOmcxv2wEzQZQd0wrP/5YFlmrKHhhIDAgWPs7dP1LEx6a
         giSXQqGaEAAJLi58fYEyA93ZVIGiR/7MVQr00uAnV0HQBqApgMS2Yby9znci2WttB+8t
         tF4U7y403U4EIgjj7cQX03v24/8sucx8aFFHkQwC3Kl0OXR8sY2b4Hp2vUV6w5H96MfC
         5li3YrZp8OLty7WzLvj51oUm+uQGRGGkNm0Fw4+QTeOt1maTT7Mhojr+pz6U8PXLfp7a
         IY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKHJQvqJL4vck/ls0lok0lX1bEYmwTs7fSYSrgFLcDnlvaEaXhJ0vhW9YGP+4VGEn3BXlN5FdGAQJXhnEY@vger.kernel.org, AJvYcCWQpFPWHqUIHAnf63NS+9ZZb5VHE/nNzHfHXoLYTyZVCMrZruDhDRhqcFoC+K+63CSJYkOwi1yZehI=@vger.kernel.org, AJvYcCXID5xQVm2FpPbuBkPRhdXp1nmoly6JdU4m/T9HSFisoYjNqY8KOlYk7Kg9G+OsxOE3oX67rAmTOOwfIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN18teKZ6OS/+gxwODxPYoZ4Jb8DcbuA2wFh9NriEMQ4M0SHw7
	22ZPofPx6MxJ4sd0xbrvBMUODJ4HfCMCv2a8M8sMRUXeI7gQObD/sHEN
X-Gm-Gg: ASbGnctyBBZlqAsn5EZWnfCiVQ7Gp1teDBKsuyGwNDe9nzk83PAXlVnJUe7QfS/PQmq
	42VNzbuSh4ZeCPEvjBiBBEDRyZorfHttRYcK0y25Rv409PyC3jQ7gC0gpBaUvq4WdKezLRpWXPe
	YGx6yByK8yJWz8VUyWI3o9sJTVdGLz/DW2xXs+gKwQVT4MO9AWusJJ2aEj8f3weJP9XI9uINVWh
	9btROQd8xro8HT37o9GmiNJQZLc1pt5rb2+nN+WaFr+aljNTKrKy5eTWZYNXPXN2O4w2HH1/PV5
	iJF4QVPuuaZFEjDWldOK0F9kTJKyKZmuExVUovy57ciryQyFjaLaUKyMAEnFBH2+oMr2SNMPh/y
	WKONRP4mcxYLkJVRYl888cvLGhz8XYzK6
X-Google-Smtp-Source: AGHT+IHd8th8DxuBlZIOOIpxG5BirHhAP4zcid9RIJhvhiltbyTblS1FYKs0knm08Gq5EYUrkam3vw==
X-Received: by 2002:a05:6402:2748:b0:60b:9f77:e514 with SMTP id 4fb4d7f45d1cf-60e52cc6896mr2681925a12.10.1751465704824;
        Wed, 02 Jul 2025 07:15:04 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:7e:645c:aa81:5180? ([2620:10d:c092:500::7:3d29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60e5818db90sm895836a12.56.2025.07.02.07.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:15:04 -0700 (PDT)
Message-ID: <6d8832bb-b5a7-4cd9-b92c-c93f2c1fe182@gmail.com>
Date: Wed, 2 Jul 2025 15:15:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Usama Arif <usamaarif642@gmail.com>
Subject: Re: [DISCUSSION] proposed mctl() API
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 SeongJae Park <sj@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>,
 Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
 <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
 <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
Content-Language: en-US
In-Reply-To: <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> As I replied to Matthew in [1], it would be amazing if it was not needed, but thats not
> how it works in the medium term and I dont think it will work even in the long term.
> I will paste my answer from [1] below as well:
> 
> If we have 2 workloads on the same server, For e.g. one is database where THPs 
> just dont do well, but the other one is AI where THPs do really well. How
> will the kernel monitor that the database workload is performing worse
> and the AI one isnt?
> 
> I added THP shrinker to hopefully try and do this automatically, and it does
> really help. But unfortunately it is not a complete solution.
> There are severely memory bound workloads where even a tiny increase
> in memory will lead to an OOM. And if you colocate the container thats running
> that workload with one in which we will benefit with THPs, we unfortunately
> can't just rely on the system doing the right thing.
> 
> It would be awesome if THPs are truly transparent and don't require
> any input, but unfortunately I don't think that there is a solution
> for this with just kernel monitoring.
> 
> This is just a big hint from the user. If the global system policy is madvise
> and the workload owner has done their own benchmarks and see benefits
> with always, they set DEFAULT_MADV_HUGEPAGE for the process to optin as "always".
> If the global system policy is always and the workload owner has done their own 
> benchmarks and see worse results with always, they set DEFAULT_MADV_NOHUGEPAGE for 
> the process to optin as "madvise". 
> 
> [1] https://lore.kernel.org/all/162c14e6-0b16-4698-bd76-735037ea0d73@gmail.com/
> 
> 
> I havent seen activity on this thread over the past week, but I was hoping
> we can reach a consensus on which approach to use, prctl or mctl.
> If its mctl and if you don't think this should be done, please let me know
> if you would like me to work on this instead. This is a valid big realworld
> usecase that is a real blocker for deploying THPs in workloads in servers.
> 

Hi!

Just wanted to check if anyone has any thoughts on this?

I think we are all in agreement for the long term eventual goal, have THP just work
and be default enabled. From our perspective, we (meta) have spent a significant
amount of time and effort over the last 18 months trying to make changes/optimizations
where we could actually have it so and can transparently and reliably get hugepages.
This includes the THP shrinker [1], changes to allocator and reclaim/compaction code
to reduce fragmentation [2] and reducing type mixing [3].
We want to continue spending more time and resources in trying to achieve this.

But in the current state, not being able to selectively enable THPs always for certain
workloads is a significant blocker in trying to roll it out at hyperscaler levels, and
from the attempts made by others, I do believe its a problem others are facing as well.
Our long term aim is to have transparent_hugepage/enabled set to always across the fleet.
But for that we need to have the ability to enable it selectively for workloads that
show benefit, try and solve problems that come up in production when it is enabled,
and see why for those that regress. This can not be done with just transparent_hugepage/enabled
for hyperscalers which run vastly different types of containerized workloads on the same
machine.

There have been multiple efforts from different people on trying to address similar
problems (including via cgroup[4] and bpf[5]). IMHO, its quite clear that unfortunately
just having a system wide setting for THP is not enough at the moment or in the near future,
especially when running workloads that have completely different characteristic on the same server.


In terms of the approach of doing this, IMHO, I dont think the way to do this
is controversial. After the great feedback from Lorenzo on the prctl series, the
approach would be for userpsace to make a call that just does for_each_vma of the process,
madvises the VMAs, and changes the mm->def_flags for the process. We are not making changes
to the pagefaulting path (thp_vma_allowable_orders has no code change which is awesome).
In terms of what the call is going to be, there has been a lot of debate (and my preference
of prctl is clear), I am ok with either with prctl or mctl, as it should not change
the actual implementation. If there is consensus, I would love to send a RFC for how the
prctl or mctl solution would look like.


[1] https://lore.kernel.org/all/20240830100438.3623486-1-usamaarif642@gmail.com/
[2] https://lore.kernel.org/all/20250313210647.1314586-1-hannes@cmpxchg.org/
[3] https://lore.kernel.org/all/20240320180429.678181-1-hannes@cmpxchg.org/
[4] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/
[5] https://lore.kernel.org/all/20250520060504.20251-1-laoar.shao@gmail.com/

Thanks,
Usama

