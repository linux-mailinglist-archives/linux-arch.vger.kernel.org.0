Return-Path: <linux-arch+bounces-13446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35846B4A441
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 09:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF47188AA43
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93E236435;
	Tue,  9 Sep 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0cqtYfn"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FAD23CF12
	for <linux-arch@vger.kernel.org>; Tue,  9 Sep 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404425; cv=none; b=shLYhvLHkTdoDhGfaISKfAAHMGtPbQGCqTVkMJ6BuWBkb/IRSCFSxYmN3/w+GoH7u6GcDPVYJzbWeNYcGuOgsE5TD6z2sgd0hdFzMTl5zLA3ZH/zfL4WQ/MPO9My9i8BCBrfnhbz68Gm1/PJuESgD+2Wr8KutiQ/FNu2edEDJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404425; c=relaxed/simple;
	bh=DrTJEmL6DrGOsHsvh3FQzphkk5kTj81FonJsolMZfr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6Nq/fXJJ5nxUBek3JIT4HlIAtEuOq4H929QiInctS6MbGQQwS88gypP4XDRxeW5U8DskcV2Ix2zZDzBxdE0SfeYFb1JdSpnyjgI9A6cz0BeVvwzONOwnZk55nmrXxcLwGyNjpTl3fkgNnBuN4uxVdz8+5x+GVeMflGWai9BcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0cqtYfn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757404422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZEmBeYvm+QHo4HcVfrljhh+DxHJQ+lr1tf/W4Tmx/TQ=;
	b=V0cqtYfn0E2HKQHd4chJZnbS5IKuwz+m2sgslRJTN4qqHg6V49NQCS/gfkM24Z93eP7wZ+
	n9FN6L4DBIXbRNjnlHVoypuUKEAYzeEfFZ2D6lZQaLGXfn/Yz+CC07hauFtOHzsOfMVcG/
	3Dve64aS3lWdAbIwVmeLZNld+n9wwIA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-uPUahlJJN9eHYH44vV26uQ-1; Tue, 09 Sep 2025 03:53:41 -0400
X-MC-Unique: uPUahlJJN9eHYH44vV26uQ-1
X-Mimecast-MFC-AGG-ID: uPUahlJJN9eHYH44vV26uQ_1757404420
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so29787705e9.0
        for <linux-arch@vger.kernel.org>; Tue, 09 Sep 2025 00:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404420; x=1758009220;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEmBeYvm+QHo4HcVfrljhh+DxHJQ+lr1tf/W4Tmx/TQ=;
        b=oQcvG9A9fZbMKT19Nn03oEF/CXQfQP5GZ6jqih0y4Uq2kor9q1G5a9dQur4JDiOLaB
         ZZ+OjiMxPLV5WZXleJHUzXLps4EiWtU1Kx2G5g2dyQU9iKHbQY9UnXXCXyY5fm6y3LA+
         rj0xatPWvI+OtQmXX3MPNXTJ1hnNLV0Hj4MtGRnCRJKG1dDd8tyrZEiAS0gpoGxSah+a
         BhagNNt4KY4qrw6w515bYKqtR4Rjy673oEDnFF5db9CNnkQGIMb4GiskzYnFSUU+chFs
         Y22y1spkRksIBHsDaxKP2KWEfvr/JyhsVXumvMmxh1ZYAWL9Dk1YGLbQJ5B1SRev494E
         MQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIOD6IxkBPPYft+KsJ9RatENxGmtfKPPeyZe2MhKo+sM89t3xBlvg2ML5tuD9tE0+MHEKw8MMGIf0q@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMxy6LOORUMWOy2pSrqxlLz5z8T6oyN5FJ1G05nAogZkkEzFI
	yDkUncPbUH9F550Bkgp4WsgNwOVXp/kBWdAJEMkhG3W3L61g05btlCyoPkYfoWxYPDd/+Ev1bMR
	vxIhQ3Q6wgZhNsklp98j1Oottspr7j9Ri9PYvMuMdkSyXXIELxJS5Tw9VlvgA1h4=
X-Gm-Gg: ASbGnctiL5dMW/F3ZPJanG6v2n/6fqtbU9O/pYMwafKEWexVjB1g0yxKW/OVCqM2/15
	zJ4wdfTL1w0F5ncvM01c2IqV90ak3RhcOubBKwcM+fThCShkPrZgHW99yc2LKFdPHbC8XRRt/YO
	+l2ytJu8dcDMSTp4TXAH/N3EgdVL7OzOEmoLb3cjxIWP9+ufWxU16UiVvafWdOMyBbKPbViI72J
	bFvUkxPWvD22gfk7w60zAtPdqGiTDqhxyffNYX8316yBgZOkE3fZJFjd6pYnC6Sz3zIvn+wH6xW
	rcIqaty9sXjKKIoKm0L/H0fEkneqaxqNyWsQ1F2SkFFN3qKwLSH0VSYIeCb+v6OJ9YUStiAopbR
	WAqcMhAtF2D/uPCCg5F3hsAxEUxCrFOyJJaq/W2Txnt1FSHDtRVr6OhVyww+YbpBDSAE=
X-Received: by 2002:a05:600c:1912:b0:45d:e326:96e7 with SMTP id 5b1f17b1804b1-45de326996dmr71555755e9.29.1757404419843;
        Tue, 09 Sep 2025 00:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS4AFMGxOq5LNuJns+zgBlN8rwn2xGsseYDqK0Yl4p7XSEF2HDrrN0L0SRylb3Q3uPkkO5zg==
X-Received: by 2002:a05:600c:1912:b0:45d:e326:96e7 with SMTP id 5b1f17b1804b1-45de326996dmr71555455e9.29.1757404419328;
        Tue, 09 Sep 2025 00:53:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238910sm1462804f8f.41.2025.09.09.00.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 00:53:38 -0700 (PDT)
Message-ID: <3fb2b394-fa75-4576-ad8d-6480741f0c1b@redhat.com>
Date: Tue, 9 Sep 2025 09:53:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
 arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com,
 corbet@lwn.net, dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
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
 x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <5b7e71e8-4e31-4699-b656-c35dce678a80@redhat.com>
 <aL9DsGR8KimEQ44H@casper.infradead.org>
 <bff57a63-4383-4890-8c68-8778b3a75571@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bff57a63-4383-4890-8c68-8778b3a75571@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 23:14, Anthony Yznaga wrote:
> 
> 
> On 9/8/25 1:59 PM, Matthew Wilcox wrote:
>> On Mon, Sep 08, 2025 at 10:32:22PM +0200, David Hildenbrand wrote:
>>> In the context of this series, how do we handle VMA-modifying functions like
>>> mprotect/some madvise/mlock/mempolicy/...? Are they currently blocked when
>>> applied to a mshare VMA?
>>
>> I haven't been following this series recently, so I'm not sure what
>> Anthony will say.  My expectation is that the shared VMA is somewhat
>> transparent to these operations; that is they are faulty if they span
>> the boundary of the mshare VMA, but otherwise they pass through and
>> affect the shared VMAs.
>>
>> That does raise the interesting question of how mlockall() affects
>> an mshare VMA.  I'm tempted to say that it should affect the shared
>> VMA, but reasonable people might well disagree with me and have
>> excellent arguments.

Right, I think there are (at least) two possible models.

(A) It's just a special file mapping.

How that special file is orchestrated is not controlled through VMA 
change operations (mprotect etc) from one process but through dedicated 
ioctl.

(B) It's something different.

VMA change operations will affect how that file is orchestrated but not 
modify how the VMA in each process looks like.


I still believe that (A) is clean and (B) is asking for trouble. But in 
any case, this is one of the most vital parts of mshare integration and 
should be documented clearly.

>>
>>> And how are we handling other page table walkers that don't modify VMAs like
>>> MADV_DONTNEED, smaps, migrate_pages, ... etc?
>>
>> I'd expect those to walk into the shared region too.
> 
> I've received conflicting feedback in previous discussions that things
> like protection changes should be done via ioctl. I do thing somethings
> are appropriate for ioctl like map and unmap, but I also like the idea
> of the existing APIs being transparent to mshare so long as they are
> operating entirely with an mshare range and not crossing boundaries.

We have to be very careful here to not create a mess (this is all going 
to be unchangeable API later), and getting the opinion from other VMA 
handling folks (i.e., Lorenzo, Liam, Vlastimil, Pedro) will be crucial.

So if can you answer the questions I raised in more detail? In 
particular how it works with the current series or what the current 
long-term plans are?

Thanks!

-- 
Cheers

David / dhildenb


