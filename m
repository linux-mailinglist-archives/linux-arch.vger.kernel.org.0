Return-Path: <linux-arch+bounces-9935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239EA20764
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A893A3FA5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8A199385;
	Tue, 28 Jan 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF7mAiDr"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D411148314
	for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057028; cv=none; b=Q4AXSjB++ZzfuWd646wCSHgzpeNIF9l2AteFMdyfPsWKkzAv1zdkkD3w1YUQ4rrzwFWoqNdvfiyI0q3mwjrGhlJgk2pT9DXsjGy4xbr4NYAtJ4iooe5seXqKXDQjbZxS6SjaIbnjnEM9YQocGdNW7fnL1fK4ZTwM39hM6UkPTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057028; c=relaxed/simple;
	bh=uy/ODYMoI/6Ndd4T/4RpDF1O+qMkosDwU+nvXDqFSm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRPRHcc+3vQzxHxp2F5enFcP3PVKDH2OUSnW9STNrBzDj+TdQYPieohSC1Ho8w861Zn0aUXyTjAg8+SP2J52AmKeUHCTxUSDkbw9ENaU9HGF94H/PVFLOlptAf6gZk81njIYIiYHt0wvXFxNcH6Xdiq28GMkbFjlhpSTu8QyrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LF7mAiDr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738057026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kAwdFO2bf4WpnGkRmuAl6Musz+Y82R50ExvkyEscsL4=;
	b=LF7mAiDrb2eOLCM/DZ+HDhwFyQxtbALYvLRzZIM/7E4TaxRbql38ygaAscGWniqA2cVqhi
	ioKBnD7od3RaH4Lwy60KydKqWnYSwLhIGfMpCSUQgC9kK0VoLtTVqdHxcuqeLdj7F8Auvn
	+EbMkZnmW46A9kv3TsQiq7l6KSN9UGU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-ChAnR6AgP0OQNkbxQI7iew-1; Tue, 28 Jan 2025 04:37:03 -0500
X-MC-Unique: ChAnR6AgP0OQNkbxQI7iew-1
X-Mimecast-MFC-AGG-ID: ChAnR6AgP0OQNkbxQI7iew
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e03f54d0so2140105f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2025 01:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738057022; x=1738661822;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAwdFO2bf4WpnGkRmuAl6Musz+Y82R50ExvkyEscsL4=;
        b=NL5FBFklFamT2maxHA03Ml0lZWTbTj0bEd5Pb7VXeFbL1eYPU6Rxqtsk8WkL6eecPj
         PKAPMcYHrNxobYMkrHOEQjgKkocc5XHfQhopP/qdtvfktKSTRxL2+iCNJ00T6wmhivl2
         UFKXW9nFRp2xBcPh1+BRC8is07tmiVIBSHyu6b579RW/3LAnDTopG5c5Qc4SRymPh5/4
         Zaw3HkEpFFhDoQz5LzawjGrCheeYhRaR+vCWnPRfsZat2+8yB3n0a90PQ23LUdo7EdEu
         lTWj1uDSJ556TqwdTlpPVG1v1i4rdzjm28iCzIYyNQQ15SXlzCw0QusDaWg23HmurwM3
         qvDg==
X-Forwarded-Encrypted: i=1; AJvYcCV7We+veFaF9quDCczzUt1rLVQO/fNb892efkIFsDIed0NvOoG8NtxODR8km0vLlt5fUMeG2RKEU5Rb@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHI6VbPn/ZDNvc+8LKz10BCrAnhfa6UIOJOGirEk5sIYbzq3z
	watsOjDX7J54xY/9+a+dxep7aIxRVailPfURthhgTVXovbDNy8MeMlYnsP59Tjd8Q58OK65drb9
	ejlLpvTaEkzU/zTfvoW8+gc0aKvT6i13C7Z2dAqlBlqhBio4jjm8xi1Xg/Os=
X-Gm-Gg: ASbGncvV70u0V8TYZEex11GdjKL8S1Ev7N3UEWbEIMoBg/DJkHX7NeOWKR4w8zlx5vH
	ayP6BP6WoicrV84k4djMWmeMjIEYittCnXJcs60yToYvnzb0bx0bgBIly1DzxH5XnjIOS5W//i1
	2eU599+D7zReAA17T0UvM9v4h95i0alSXMlZpNlgIE4jaYHe7sduuJdIbZKL8wthSfNwuWKYiks
	18WjM9zWJUIvcbB/qEa7R9GdGgvbkAgxPbl5HUK5l4Nwy4GGDEnVTJDnSZHS8YX/NwMnEmYCsWt
	6mvkktHGVqxA2kqFqeFcxYUCTCsVZxm4WiQiKNHj8iYPzJl73WO9aFXHF9/79TlJ7nrV5911EyQ
	2FqJ47Xham29hunfr+4uCfMq006dGK2N1
X-Received: by 2002:a5d:4243:0:b0:386:2a3b:8aa with SMTP id ffacd0b85a97d-38bf57b3f56mr27286047f8f.37.1738057022519;
        Tue, 28 Jan 2025 01:37:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRbY/8dA2OVgaLcPdTrF4WjHj0tODpFOjXegLLTi7SabhIcsFMtsDARIuViWuL9zRaarVyuw==
X-Received: by 2002:a5d:4243:0:b0:386:2a3b:8aa with SMTP id ffacd0b85a97d-38bf57b3f56mr27286001f8f.37.1738057022128;
        Tue, 28 Jan 2025 01:37:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d? (p200300cbc73fce001be76d7f3cc3563d.dip0.t-ipconnect.de. [2003:cb:c73f:ce00:1be7:6d7f:3cc3:563d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4161sm13337357f8f.88.2025.01.28.01.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 01:37:01 -0800 (PST)
Message-ID: <404b500a-4a28-4a8a-a0f5-3c96c397be0b@redhat.com>
Date: Tue, 28 Jan 2025 10:36:58 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>, akpm@linux-foundation.org,
 willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 khalid@kernel.org
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250124235454.84587-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> API
> ===
> 
> mshare does not introduce a new API. It instead uses existing APIs
> to implement page table sharing. The steps to use this feature are:
> 
> 1. Mount msharefs on /sys/fs/mshare -
>          mount -t msharefs msharefs /sys/fs/mshare
> 
> 2. mshare regions have alignment and size requirements. Start
>     address for the region must be aligned to an address boundary and
>     be a multiple of fixed size. This alignment and size requirement
>     can be obtained by reading the file /sys/fs/mshare/mshare_info
>     which returns a number in text format. mshare regions must be
>     aligned to this boundary and be a multiple of this size.
> 
> 3. For the process creating an mshare region:
>          a. Create a file on /sys/fs/mshare, for example -
>                  fd = open("/sys/fs/mshare/shareme",
>                                  O_RDWR|O_CREAT|O_EXCL, 0600);
> 
>          b. Establish the starting address and size of the region
>                  struct mshare_info minfo;
> 
>                  minfo.start = TB(2);
>                  minfo.size = BUFFER_SIZE;
>                  ioctl(fd, MSHAREFS_SET_SIZE, &minfo)

We could set the size using ftruncate, just like for any other file. It 
would have to be the first thing after creating the file, and before we 
allow any other modifications.

Idealy, we'd be able to get rid of the "start", use something resaonable 
(e.g., TB(2)) internally, and allow processes to mmap() it at different 
(suitably-aligned) addresses.

I recall we discussed that in the past. Did you stumble over real 
blockers such that we really must mmap() the file at the same address in 
all processes? I recall some things around TLB flushing, but not sure. 
So we might have to stick to an mmap address for now.

When using fallocate/stat to set/query the file size, we could end up with:

/*
  * Set the address where this file can be mapped into processes. Other
  * addresses are not supported for now, and mmap will fail. Changing the
  * mmap address after mappings were already created is not supported.
  */
MSHAREFS_SET_MMAP_ADDRESS
MSHAREFS_GET_MMAP_ADDRESS


> 
>          c. Map some memory in the region
>                  struct mshare_create mcreate;
> 
>                  mcreate.addr = TB(2);

Can we use the offset into the virtual file instead? We should be able 
to perform that translation internally fairly easily I assume.

>                  mcreate.size = BUFFER_SIZE;
>                  mcreate.offset = 0;
>                  mcreate.prot = PROT_READ | PROT_WRITE;
>                  mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>                  mcreate.fd = -1;
> 
>                  ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)

Would examples with multiple mappings work already in this version?

Did you experiment with other mappings (e.g., ordinary shared file 
mappings), and what are the blockers to make that fly?

> 
>          d. Map the mshare region into the process
>                  mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>                          MAP_SHARED, fd, 0);
> 
>          e. Write and read to mshared region normally.
> 
> 4. For processes attaching an mshare region:
>          a. Open the file on msharefs, for example -
>                  fd = open("/sys/fs/mshare/shareme", O_RDWR);
> 
>          b. Get information about mshare'd region from the file:
>                  struct mshare_info minfo;
> 
>                  ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
> 
>          c. Map the mshare'd region into the process
>                  mmap(minfo.start, minfo.size,
>                          PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> 5. To delete the mshare region -
>                  unlink("/sys/fs/mshare/shareme");
> 

I recall discussions around cgroup accounting, OOM handling etc. I 
thought the conclusion was that we need an "mshare process" where the 
memory is accounted to, and once that process is killed (e.g., OOM), it 
must tear down all mappings/pages etc.

How does your design currently look like in that regard? E.g., how can 
OOM handling make progress, how is cgroup accounting handled?

-- 
Cheers,

David / dhildenb


