Return-Path: <linux-arch+bounces-9934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D786A20736
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 10:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE9B3A2330
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731801DFD9A;
	Tue, 28 Jan 2025 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STYX81fj"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC1198831
	for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2025 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056095; cv=none; b=iAibpSke2+FWJbi4TPVzrBVXHM6SqFVo/glAa1fdjeQVpg4WNnX3TpGC23bdkywIx3RNaRlE2kC6otu2OW5Pg2/BhDYNBHdQkJ+BbwYS5M5clOnGHcVpDz5vRRZqhYNo9Ye+2mlvn9qrNfF+CEPoMx+pCQM0h9pCt7cXqItw3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056095; c=relaxed/simple;
	bh=mCmXjknTtIcjFJNty5WDJ3v8zj9pwJsL4dbbEBENa9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpSU9IDHMUgoYvfJPs771rV9N8Dute87POMPCM2nvfF3jN27CfLZcr3DRBz9V85sp+45bqavdcCduFti1DX3UB2oM2LRVcK+tOTe/6CnUxD9XJa/5MilRBf+Tj/EndkPX/CxcPlCvDSYign90NGuff0b7FDSgBHtF3RLqYTgpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STYX81fj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738056092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=76CON/o+ODpZ363mQWv962ci7akBJ4jlp9OpVn0R1FU=;
	b=STYX81fjg0DTH6g+VVyEHD8vKz+YGFpJkRG4jXEX5ph11QMnEn8liV4R4TolNCi8v0nx/U
	HoVhqmdGb681aCekZaPq13dKsnAwrFM/jtJABRIHzC54TAhAqCNm6ZnjazEnm4V6S2k44U
	QF4itQ56Nt/bIAnL/twFWy+lY5CDXNk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-3F28RNyyPYmG8pvZNhuRhQ-1; Tue, 28 Jan 2025 04:21:29 -0500
X-MC-Unique: 3F28RNyyPYmG8pvZNhuRhQ-1
X-Mimecast-MFC-AGG-ID: 3F28RNyyPYmG8pvZNhuRhQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so40985575e9.2
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2025 01:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738056088; x=1738660888;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=76CON/o+ODpZ363mQWv962ci7akBJ4jlp9OpVn0R1FU=;
        b=XypnHeczkUa1w9i9liDU1d3j17w3fFm0o+w5PPXtyPSkapctRphauSKLjOAqsXEH6G
         wMHC/gWuLG6Br2AMoe5WEXrTnfGpntbcfdoDzxUeDi1BXfvQ5yhlr/tHQ8U/+mNa+s8t
         dTGvyrwJZqX0/WMi+gG54C/ejnLfOU5XZ1S0yTFHoQJl40Erz3A7mzgZDdIyhImDyLI9
         cRdpddfCh9OzN6KVKHezHEU4xzmkil4Z/mCrW4dqkzpuzKQKwIoFESNo1q4eVPZuk3QX
         hOjboapYHk0OuqDEr8yRRNpAcX8URy4cB48nwesewGbnL9Znrwexn59+jphyfUJpkkt4
         GNtw==
X-Forwarded-Encrypted: i=1; AJvYcCXuFAD6BtHSESRQdbM7HysLAcTsZMQLiqBta1LW9PegsbU6UM64y+I43c4hywYl2dsefkFPY23VliPP@vger.kernel.org
X-Gm-Message-State: AOJu0YwCa5j8UNyvaqbXVSU5l8LLf/70+zlIsYBPc56n9pUFS8PQAKc0
	RFWjvCLYGN6LEcx0bfRaLjD+AcxpHXqsC//lyyero7j+Ax7tJ6w3rWKcKizo8N/I8Y2gleymJ/o
	5ISwJSvzb8TWYGljlxvlFIp4Q2pB8YRNoskAJjJF9vFRuV7UVp4sC7eolHWs=
X-Gm-Gg: ASbGncvP6yKF3rMOANZmhaC4agFYHDDLkrPBqsK/aDsVmznLH10QjWXx2tU4C5Um2kc
	hZLJojPa6VZgZ6IkyGNFSmeU9ukqjgwZ1aSmRyUtNdEV7/BW/Hj+bLGy8Hu1UTUUXkD2Vc6trt0
	9rimFzBJpz5aVCr4moGqOJIMKLeecdeBeotW5UTdABbFwaAyn4TG3YX8ogu2FgOi5Avf2fQW/Mb
	sISTAq4ragxymttwrDHbjK1eU3BAZJSLqCCR5AC+a4lRLRTEuX7p5CO0d2IilYXmaYGJ6bSecWi
	JklhzN2K3Ip8O7Ro1TDTsgj8BoO2BT344A==
X-Received: by 2002:a05:6000:4011:b0:38a:4184:152a with SMTP id ffacd0b85a97d-38bf5669eb5mr44324575f8f.28.1738056087971;
        Tue, 28 Jan 2025 01:21:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvImmYvqk0afzoCeet3qVIqUfCCKPU1AYvRvME2bm0F6aJ80CkP/sZ5UP4Ft2i7kCCjB+S0Q==
X-Received: by 2002:a05:6000:4011:b0:38a:4184:152a with SMTP id ffacd0b85a97d-38bf5669eb5mr44324508f8f.28.1738056087489;
        Tue, 28 Jan 2025 01:21:27 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6662.dip0.t-ipconnect.de. [91.12.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4006sm13707156f8f.94.2025.01.28.01.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 01:21:26 -0800 (PST)
Message-ID: <c8e2e374-3ce9-45c9-8ae8-7e31fd084e57@redhat.com>
Date: Tue, 28 Jan 2025 10:21:23 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
To: Andrew Morton <akpm@linux-foundation.org>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
 khalid@kernel.org, jthoughton@google.com, corbet@lwn.net,
 dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
 brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
 catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
 liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 tglx@linutronix.de, cgroups@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250127143339.b1f6b6d5586f319762c5e516@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250127143339.b1f6b6d5586f319762c5e516@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.01.25 23:33, Andrew Morton wrote:
> On Fri, 24 Jan 2025 15:54:34 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
> 
>> Memory pages shared between processes require page table entries
>> (PTEs) for each process. Each of these PTEs consume some of
>> the memory and as long as the number of mappings being maintained
>> is small enough, this space consumed by page tables is not
>> objectionable. When very few memory pages are shared between
>> processes, the number of PTEs to maintain is mostly constrained by
>> the number of pages of memory on the system. As the number of shared
>> pages and the number of times pages are shared goes up, amount of
>> memory consumed by page tables starts to become significant. This
>> issue does not apply to threads. Any number of threads can share the
>> same pages inside a process while sharing the same PTEs. Extending
>> this same model to sharing pages across processes can eliminate this
>> issue for sharing across processes as well.
>>
>> ...
>>
>> API
>> ===
>>
>> mshare does not introduce a new API. It instead uses existing APIs
>> to implement page table sharing. The steps to use this feature are:
>>
>> 1. Mount msharefs on /sys/fs/mshare -
>>          mount -t msharefs msharefs /sys/fs/mshare
>>
>> 2. mshare regions have alignment and size requirements. Start
>>     address for the region must be aligned to an address boundary and
>>     be a multiple of fixed size. This alignment and size requirement
>>     can be obtained by reading the file /sys/fs/mshare/mshare_info
>>     which returns a number in text format. mshare regions must be
>>     aligned to this boundary and be a multiple of this size.
>>
>> 3. For the process creating an mshare region:
>>          a. Create a file on /sys/fs/mshare, for example -
>>                  fd = open("/sys/fs/mshare/shareme",
>>                                  O_RDWR|O_CREAT|O_EXCL, 0600);
>>
>>          b. Establish the starting address and size of the region
>>                  struct mshare_info minfo;
>>
>>                  minfo.start = TB(2);
>>                  minfo.size = BUFFER_SIZE;
>>                  ioctl(fd, MSHAREFS_SET_SIZE, &minfo)
 >>>>          c. Map some memory in the region
>>                  struct mshare_create mcreate;
>>
>>                  mcreate.addr = TB(2);
 >>                  mcreate.size = BUFFER_SIZE;>> 
mcreate.offset = 0;
>>                  mcreate.prot = PROT_READ | PROT_WRITE;
>>                  mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>>                  mcreate.fd = -1;
>>
>>                  ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)
> 
> I'm not really understanding why step a exists.  It's basically an
> mmap() so why can't this be done within step d?

Conceptually, it's defining the content of the virtual file: by creating 
mappings/unmapping mappings/changing mappings. Some applications will 
require multiple different mappings in such a virtual file.

Processes mmap the resulting virtual file.

-- 
Cheers,

David / dhildenb


