Return-Path: <linux-arch+bounces-8931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8A69C22F9
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524C7282A19
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3361991D7;
	Fri,  8 Nov 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdQ1Ap0w"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DE191F8E
	for <linux-arch@vger.kernel.org>; Fri,  8 Nov 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087115; cv=none; b=RSZKkOSGn1GDTAFJhyK5ALPnMaNNj8I0HVYA4cIc3DS8zl1a3PGUXuy1AvmbNoKJXGSDrEIT+lOi1mAY5DpjNKVq1DxbYPXs7MOL+B1aVhLTEJB6Xhw57jNZ5iN/DGShvfmK82WrSdSu/FRDFrKN4w3nhEp7LiyhGg3uoREo6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087115; c=relaxed/simple;
	bh=NJuiGu3PlwZ+2Oktvoo+Y3RvZx0dhbgHrcUsyVpM6Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDNwcwNDt9VtnOMt+5vZ+S8ALMOMlIQMr97tEcqof51/YCbITejzcNx2MFaXNNHXzJTn40jzJ661XCkL79+1u4bdXoR6F1c3+u7x2RN+q4KX+ghXhLuvzphjZOsgJrVeeoczM8uKfU5QRROoAeTACN4ihGictVUL+4bAiEAuv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdQ1Ap0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yd4O8mZKu4eBAZvLdoHZhgPng6vXj2+Z+n0AqkWNQHs=;
	b=KdQ1Ap0wTZDuHmfnqJGuyvyWt6zYMYFX0jTMSkINJTOcG0hu34e75yXVHMk/YViyxVp6zQ
	HBnJ7nFy2x66VoexUy0SEbpVyiAwqd7ww0qa30abkJ1Jghm9XikXJIKWaSD7RlYwQr03mH
	NxJfKfOE4N2h3oRg+Cs+TYCnSVh/TMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-HlFA4uSDPBuLFtA4huXC_w-1; Fri, 08 Nov 2024 12:31:52 -0500
X-MC-Unique: HlFA4uSDPBuLFtA4huXC_w-1
X-Mimecast-MFC-AGG-ID: HlFA4uSDPBuLFtA4huXC_w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d45f1e935so1308374f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 08 Nov 2024 09:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087111; x=1731691911;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yd4O8mZKu4eBAZvLdoHZhgPng6vXj2+Z+n0AqkWNQHs=;
        b=XHGaGD1FsnJ6rU11ly39CfmHiZ6C+7/wCZuP1Gbkygfz1KvdctBG/fWwN8LIEk2Fy2
         zgVxZ8cA+jndermjQVOgTkVbIdxpEr15tmvYHfsXBEn74v0fp546dEVG7XXQNe5IpLfL
         50kBbcBb1xcdYooB4V78BZedg2Rltkg3g8/gtxLC1CMAMJxahphZeU1lOtwz7nlCNuag
         rlcFZTJGmFfB1wPiZ5MeN8CUZav8o7S14FBVuzgJDJ5CUl6x2aEPyl6nz1R6O07O0CzZ
         mk7os/w17H1WmeFfNRrm8O/WBn4oZQ0sVlD/A5IzvWWYjbGkNRhJ9gCyS16FIHaZKAx3
         L+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZIBiDj1SuZti7tdWSADAFct7P4I7qNrLZLBmxRvcCTA9qiyAJLWrf43kILAfMI9kRGwbC37ScICPh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+CyDD3cE99f183+/QpnKbmp5TA6m4G4hcRCRs/VAv+04YE21S
	i5YD5xfrL/HztncpyGu2uBd7gZigPWnIcLjPZkKOmfci3JIF3wZmy7rm23CnJJ7PfvQK1Ri9P8D
	TKnT1nc9vEyt23U6B5zL1Ahh3ZAcEXvB7ZuiW7iO2+Tt2I0IOI/MGfQaY28U=
X-Received: by 2002:a5d:6d8a:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-381f186d184mr3065610f8f.34.1731087110724;
        Fri, 08 Nov 2024 09:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3QWFDdRozO+PK2MbzpOgYsv6Dill3GhRB3QqEZymzjtGl7Y3z7IR1KySm+lULn51+VPdYsA==
X-Received: by 2002:a5d:6d8a:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-381f186d184mr3065582f8f.34.1731087110333;
        Fri, 08 Nov 2024 09:31:50 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed998e6esm5551930f8f.55.2024.11.08.09.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 09:31:49 -0800 (PST)
Message-ID: <10ffac79-0dba-4c30-991e-f3ca2b5ff639@redhat.com>
Date: Fri, 8 Nov 2024 18:31:47 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
To: Matthew Wilcox <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 chao.gao@intel.com, pgonda@google.com, thomas.lendacky@amd.com,
 seanjc@google.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, arnd@arndb.de, kees@kernel.org,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, linux-coco@lists.linux.dev,
 Linux API <linux-api@vger.kernel.org>
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
 <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
 <ZyzYUOX_r3uWin5f@casper.infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZyzYUOX_r3uWin5f@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 16:10, Matthew Wilcox wrote:
> On Thu, Nov 07, 2024 at 02:24:20PM +0530, Shivank Garg wrote:
>> The folio allocation path from guest_memfd typically looks like this...
>>
>> kvm_gmem_get_folio
>>    filemap_grab_folio
>>      __filemap_get_folio
>>        filemap_alloc_folio
>>          __folio_alloc_node_noprof
>>            -> goes to the buddy allocator
>>
>> Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.
> 
> It only takes that path if cpuset_do_page_mem_spread() is true.  Is the
> real problem that you're trying to solve that cpusets are being used
> incorrectly?

If it's false it's not very different, it goes to alloc_pages_noprof(). 
Then it respects the process's policy, but the policy is not 
customizable without mucking with state that is global to the process.

Taking a step back: the problem is that a VM can be configured to have 
multiple guest-side NUMA nodes, each of which will pick memory from the 
right NUMA node in the host.  Without a per-file operation it's not 
possible to do this on guest_memfd.  The discussion was whether to use 
ioctl() or a new system call.  The discussion ended with the idea of 
posting a *proposal* asking for *comments* as to whether the system call 
would be useful in general beyond KVM.

Commenting on the system call itself I am not sure I like the 
file_operations entry, though I understand that it's the simplest way to 
implement this in an RFC series.  It's a bit surprising that fbind() is 
a total no-op for everything except KVM's guest_memfd.

Maybe whatever you pass to fbind() could be stored in the struct file *, 
and used as the default when creating VMAs; as if every mmap() was 
followed by an mbind(), except that it also does the right thing with 
MAP_POPULATE for example.  Or maybe that's a horrible idea?

Adding linux-api to get input; original thread is at
https://lore.kernel.org/kvm/20241105164549.154700-1-shivankg@amd.com/.

Paolo

> Backing up, it seems like you want to make a change to the page cache,
> you've had a long discussion with people who aren't the page cache
> maintainer, and you all understand the pros and cons of everything,
> and here you are dumping a solution on me without talking to me, even
> though I was at Plumbers, you didn't find me to tell me I needed to go
> to your talk.
> 
> So you haven't explained a damned thing to me, and I'm annoyed at you.
> Do better.  Starting with your cover letter.
> 


