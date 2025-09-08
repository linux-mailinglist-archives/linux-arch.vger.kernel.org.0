Return-Path: <linux-arch+bounces-13408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95FB4993A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 21:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66394E3A52
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E11E500C;
	Mon,  8 Sep 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbQtQnop"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445441DE881
	for <linux-arch@vger.kernel.org>; Mon,  8 Sep 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358132; cv=none; b=A7yqx4dM0yH8zklIzeEl9Vc3iT7UmDOQVr5xy70KFfB4yLgvwEOlvunJb1jmQBgalpv7zDN/e7STW1PFyynDdRvtpPp4mp7X2pVVUCGeDdeb5+QKnmZnyXQpInlrvpVXfd/IIjOf/sZYw5JK88aYfAWAI6SvEOVGUMGO9KBkxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358132; c=relaxed/simple;
	bh=ts5qeNugaWa6uGzCR+IjT2cVsvL8CbHutq8gZ75GqDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFImtUDh3DAkJV2+M15v+zT+WjtwQbS+WY74uB0JiQs/uKVo8W+T2lvZ65LZ4U6fmLpTJmyBpIdKBunpweZD6Ky5Q53jYKK7qjtmYmT4JOYE7q/0BBlv53FHa0RYe0x/R4VybXfLMSqVc9kzmtebrMAFdn/1EpC8qzzq1y+7YtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbQtQnop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757358130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gmtib10VgDsxeCsuKSbiFn6OKNGc3wSlE9js8H+6KJs=;
	b=JbQtQnopCKWElJwUHo4op/fQz3kelrxCiQ03ZN9c+msjDbOjE7gKT1nyHDqDyaJJFbCmPF
	3NVdyagGSib2Zi+NnsBwJAG4CmXEFVP9jVmmj5iMeyN3rq4Pvz6on7+wq2C9L/fPhZ+gt5
	nnX2SzLtWXxHv1JxspyJTr7JrFELTxM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ryH_nS_KNVKO_wPv49gGaA-1; Mon, 08 Sep 2025 15:02:08 -0400
X-MC-Unique: ryH_nS_KNVKO_wPv49gGaA-1
X-Mimecast-MFC-AGG-ID: ryH_nS_KNVKO_wPv49gGaA_1757358128
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so37331445e9.0
        for <linux-arch@vger.kernel.org>; Mon, 08 Sep 2025 12:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757358127; x=1757962927;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmtib10VgDsxeCsuKSbiFn6OKNGc3wSlE9js8H+6KJs=;
        b=R2ifm2zRGz/r9IIP4zc6IxA5LrtGTVmmgtzsoAh5eOEPCI2yp/AYFvRA06vMSXz1a7
         GRVjXmWD8h2Xzkzd36fEKqBqSRJdfH7JgvMPim96tLN0rGo7UHv/HTdQLFnkYoOY0SPR
         4FvhWvbRfdmgS7E2w5s8HzQNs0e1o/6QjkYm+CrmxefOdWiEF6CqQ5Ym+dirymIoMJiK
         AcVa7fiyhvtVTWsK1doKpKzXKV/7syEjmwcB431b+NCAARLtiMZ7wvOe9pz/VVrcTQpm
         lK2cEP9QYoIHc7t4RRjjRK0OgcMzHw6Vc9RKyNtRNJwtEb6cHa8ewp7XtaYDJurgBfz4
         Wopw==
X-Forwarded-Encrypted: i=1; AJvYcCU4OueHdL9cnQ9MyVoLkLxoGOV7976y/2wBUrVNn0M5wzIunsUjLFibYwUCX+6/pgDroE5gljflfWDT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aq3KlaRc7zNoE8Rufprwjo8Hm6HzFu7QbnxyGK1grL01yeJ7
	z636QWjH2gQhJlSwA3Lsn+kGATErWLaURZAI6SWneSfYijUdOKoBs5RZ/24NBNiLiPOnv++PW2N
	DFov92p72mRd17DoGChSfsRcevQZ1Fxl0UnPPwJzrgLDLokXnUs46X9MCfbqYddE=
X-Gm-Gg: ASbGncvDb4vMuuSlR2Lv/u31vCnxDKtJaIpc3NqnhA6x91Hki5XlfcmKWYVxSA6e4wF
	GCHLqzeJM6PyXme2oc1uEk/HHAIpgGSYAX1B6YHBZ0ECKGz3J+n8W4eAtbgXw1L2sCBjjd+tVa6
	s/p1vDvuIC4Ro1yfF/ycO021e+CrEyP1pUGUZKJtPwqs7d6jvE4lxV0LFW+5CNDCayyWtVxqFoa
	ZdHteClyzplAR/lSV62mVHlA6VHxU3+8UwzQmxfAWN1bSV82EWckbhrim+vWqiCr1El3i0uA72L
	TGX5/lM53pQ+fpDYqkb/7X7RKO2txrQDI7N9Ag9IIQ0QGKGGup60FKb5YXvbF3sEH5nZFtHlL3y
	H58/XL40zyUig3OXf5BdJ+mDZ1IwVxRctIAaKIRcMwFvNM/DelvBhreJ3i+027yD5
X-Received: by 2002:a05:600c:4694:b0:45d:d908:dc02 with SMTP id 5b1f17b1804b1-45ddded9c21mr75728775e9.31.1757358127424;
        Mon, 08 Sep 2025 12:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs8y1x+Exxj0+uBNj9bFOyP7D7vv4bDun2+4IppnvfFcz7vwjW0GdrRhrh+4rIlBPR8FzbqQ==
X-Received: by 2002:a05:600c:4694:b0:45d:d908:dc02 with SMTP id 5b1f17b1804b1-45ddded9c21mr75728125e9.31.1757358126762;
        Mon, 08 Sep 2025 12:02:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm449738625e9.19.2025.09.08.12.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 12:02:06 -0700 (PDT)
Message-ID: <fcaa9042-3e64-4719-a8ab-a08d10b6e1a1@redhat.com>
Date: Mon, 8 Sep 2025 21:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/22] mm/mshare: Add a vma flag to indicate an mshare
 region
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
 bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
 jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
 liam.howlett@oracle.com, linyongting@bytedance.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
 maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
 pcc@google.com, peterz@infradead.org, pfalcato@suse.de, rostedt@goodmis.org,
 rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
 tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz,
 vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com,
 willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-7-anthony.yznaga@oracle.com>
 <5c43116f-fef9-426d-8c90-1a3a129f3d20@redhat.com>
 <b99517e5-7b4b-494e-8ec6-918f933ddf50@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b99517e5-7b4b-494e-8ec6-918f933ddf50@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 20:56, Anthony Yznaga wrote:
> 
> 
> On 9/8/25 11:45 AM, David Hildenbrand wrote:
>> On 20.08.25 03:03, Anthony Yznaga wrote:
>>> From: Khalid Aziz <khalid@kernel.org>
>>>
>>> An mshare region contains zero or more actual vmas that map objects
>>> in the mshare range with shared page tables.
>>>
>>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>> ---
>>
>> Why can't we query the mapping instead?
>>
> 
> 
> The bit check is nice and zippy since vma_is_mshare() is called for
> every fault, but it's not required. The check could be made to be:
> 
> 	return vma->vm_ops == &msharefs_vm_ops;

Yes, like we do in secretmem_mapping(), for example.

(there, we also have a vma_is_secretmem()).

-- 
Cheers

David / dhildenb


