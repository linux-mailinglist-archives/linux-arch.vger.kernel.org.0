Return-Path: <linux-arch+bounces-12984-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36981B161E2
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F8E565A68
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541E2D948A;
	Wed, 30 Jul 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3sbqBzb"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7F2D839E
	for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883573; cv=none; b=t2r3vgsrW/QWKmiEKqNxTZX6x6faU6lrEMAcjuKxu+qrArZuWR6UxhK1KWYQsOMGFoQxx7XgZ1GGtILW02c6bMf28i8WG5DNH6k7C996exPVxnrp89cTSSJXwBFkwrAlhkjZeIWdZCSoCGzrPup7UjsfoUSFqSRogSQb8BBx7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883573; c=relaxed/simple;
	bh=+fhqt74zbGwFmAVFYzLM/I7yTITHbGkLqM+wqDzwR5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBf5sPTdVc4/lxCvoqkaR0a328GzMGtN2yLlSGDJZ1JO6AK0UfhzkpxhnB3WaPnU10mjgA1HVLAuf7iIf/X8f/zXyAlKo1V1jJjoEk9kJDtwwhPas9VrRVt6fgyGzz93E6MoFxKJhtHQSbT302BUtxRfYRpY5lxpEscwwRpIlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3sbqBzb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753883571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=INvhw9PaQlqHnlfqMb8yKpdneujvD9kPiqSCHTmOp+c=;
	b=a3sbqBzbE5T5QvDDYrA/MqigLJ5S4bqkyN2SsagB0qmfScXhLIVnmL9tNJ6vnGwMZ0Ei0E
	QSsNSFpbsmUStyKSZREAPwG+1bIkUO9UJxmMMvRDTnpjZlBizy+wC8H31k/BYucBXdo4HO
	RzIqPzh+7R/sNC8h5mpTxcGKcHu5018=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-aQKXpcjcM5uishzHChtk0A-1; Wed, 30 Jul 2025 09:52:49 -0400
X-MC-Unique: aQKXpcjcM5uishzHChtk0A-1
X-Mimecast-MFC-AGG-ID: aQKXpcjcM5uishzHChtk0A_1753883568
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae6d551ef64so79227566b.2
        for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 06:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883568; x=1754488368;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INvhw9PaQlqHnlfqMb8yKpdneujvD9kPiqSCHTmOp+c=;
        b=iFki4oz5MaQSgADD2OMG6fCklSPs1qCCt8SexjOLUipK+wiYefer9zCn+KHIXyJGAj
         iaznRnXn3d+9Pif/HGzQTTpgItE/r81ejMDgUjClWU92j8KuU2C7DTQJtnVGCoU0xDJ3
         EoJcJBzWB9Jto8nAK5x20dhlaHRc6iSetGwQXCmFUS9zc0fryWJsmVOYOpjxCLXutwrJ
         2EdjEJCwyG7OPq3DF1Ha83aOifCDs6o7XzupnEf6Wyo4iLxY+SX7bQCRgFigCLx9jMD7
         dPUc8W1TMicFL4rrOBYDG+FMO5Wjesm7AQJmnUY6GigD3EsXBMtOLYtukRGxSKtAWrNV
         aHDw==
X-Forwarded-Encrypted: i=1; AJvYcCWutdQbvQiifBavlYxY5Cg7eRknoN/GW+Cr+3wqyXLddlJ8shir+dIgA2Q2Ur7OScELIvNW64l2DbjB@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBqj95emuaywO4ytjJEDwtiupnRXGJB4rXzmt/pgj542ZvF0p
	mSvx4V53me6MBYy4AiePjLY+yKyZYkcPFtbfpzdK+N6Ao0TgkINBLon2ekMDs5Bi2nu711VrQcW
	0UgZ70SGcM/WCyPvmmIryziBgZXLuB+QOyOSUXFeKbCo47Zg1v1/iiq7L2ZxUsf4=
X-Gm-Gg: ASbGncuhIb2+irrkTV3hVpAJIGfWJCoCBvsaNAFzzeIyYMDtM33759YuIn31RDUGzzK
	jt+ChPMc2AmrzPH1wZCly7xInS/Jbdf5i3fw5vPXshVHJLZiTZTORxvOGqRbPYD1t7kT3EtiP3F
	wEJ6Wx0KgD3L6Q0bnFc5DcyqzrfhFFfDtT41jIlbahKCQNCCq4QPCZ9l19FYxuWgkCB/2w0N8n1
	f+rodsojfBaDa4vJL1aeMxJBiDgio++LrrLcCv/35joFIJoOnFtEpoGaylWdT0aVolGWdZvPhdI
	lQx/R9tKkK1Q7iFz7fxq41sqJrRcPCrQp+DYLVqK2zodgoWL+Kv+N0V30zalug==
X-Received: by 2002:a17:907:7252:b0:ae6:e25b:2413 with SMTP id a640c23a62f3a-af8fda42a6emr459884966b.44.1753883567606;
        Wed, 30 Jul 2025 06:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2KhtHgQZ228r5yO4JfetEAu342+CZE6Zr5/g2fkWHPp7n9P5vjQqg7A7lY87sHfovdnuCuA==
X-Received: by 2002:a17:907:7252:b0:ae6:e25b:2413 with SMTP id a640c23a62f3a-af8fda42a6emr459879766b.44.1753883567129;
        Wed, 30 Jul 2025 06:52:47 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af8f1b172f2sm210258566b.80.2025.07.30.06.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:52:46 -0700 (PDT)
Message-ID: <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
Date: Wed, 30 Jul 2025 15:52:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724135512.518487-23-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 15:55, Eugen Hristev wrote:
> Annotate vital static information into kmemdump:
>   - node_data
> 
> Information on these variables is stored into dedicated kmemdump section.
> 
> Register dynamic information into kmemdump:
>   - dynamic node data for each node
> 
> This information is being allocated for each node, as physical address,
> so call kmemdump_phys_alloc_size that will allocate an unique kmemdump
> uid, and register the virtual address.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>   mm/numa.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/numa.c b/mm/numa.c
> index 7d5e06fe5bd4..88cada571171 100644
> --- a/mm/numa.c
> +++ b/mm/numa.c
> @@ -4,9 +4,11 @@
>   #include <linux/printk.h>
>   #include <linux/numa.h>
>   #include <linux/numa_memblks.h>
> +#include <linux/kmemdump.h>
>   
>   struct pglist_data *node_data[MAX_NUMNODES];
>   EXPORT_SYMBOL(node_data);
> +KMEMDUMP_VAR_CORE(node_data, MAX_NUMNODES * sizeof(struct pglist_data));
>   
>   /* Allocate NODE_DATA for a node on the local memory */
>   void __init alloc_node_data(int nid)
> @@ -16,7 +18,8 @@ void __init alloc_node_data(int nid)
>   	int tnid;
>   
>   	/* Allocate node data.  Try node-local memory and then any node. */
> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	nd_pa = kmemdump_phys_alloc_size(nd_size, memblock_phys_alloc_try_nid,
> +					 nd_size, SMP_CACHE_BYTES, nid);

Do we really want to wrap memblock allocations in such a way? :/

Gah, no, no no.

Can't we pass that as some magical flag, or just ... register *after* 
allocating?

-- 
Cheers,

David / dhildenb


