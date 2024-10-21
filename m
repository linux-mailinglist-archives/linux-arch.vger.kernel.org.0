Return-Path: <linux-arch+bounces-8368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41899A6FF4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A411C221B6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6B1E7C18;
	Mon, 21 Oct 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9Iom4vS"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AD1E4919
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529053; cv=none; b=svEhfit4oDbPBHRiJgq1XlbluekpDFcJvQV9y7ZAaL+MVGUVTJzNBi6wndavF5V+WRXAdutCTPVODny1BQvr3aubkUNK1XKjrcW/tpaBrpFoowHeEZL/R4VFWynFweqnn/wBudPyE/u0BZwNRUVrV5B94Xy7B2xMuB/5iwIrcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529053; c=relaxed/simple;
	bh=90WzKZzAZAmAVCyRIe7kK7DX/+sIoDuVHi8ZMPTCuuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtPhr02yBjvZhEmBYIefWc9LWNlIRNmf7OPMI7NrEDQ2cwbDdZ08ln5OyIa//b5m5mQl5Md9DJFf5gq+UfbRQeSe4QDhd0xH989cisSy6oSAHyQ5IWNbz0aiX1OU25QThIYwagSlm2mUD5UE/6vN6HswoZV6eZABN998mHP78t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9Iom4vS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729529050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZX/Ilyoxcq0UVbahtd/J3opNKl8Rn4eQwpxqo4bqGEg=;
	b=Q9Iom4vS9Iwopaiq0rIFIjssNP6pfQHJew1TZLa3WzarYqDpNbbf9bFucvjQt4fn9Fl7DM
	A2OQvXFLIns23ogtwh/QLiNZR+blDljaBVym9pRIVR7pad8qAtXFjWIhXlk5Z4Hc/RWLRR
	O5QKAa8lgeZJ1k+TVJbcyVK9SPr8knw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-3GCYHAUZPEm5FkNYCnIHaw-1; Mon, 21 Oct 2024 12:44:09 -0400
X-MC-Unique: 3GCYHAUZPEm5FkNYCnIHaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso38446565e9.3
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 09:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529048; x=1730133848;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZX/Ilyoxcq0UVbahtd/J3opNKl8Rn4eQwpxqo4bqGEg=;
        b=DoJUcW8pdpButr/qn9i0DTnYCn92J4KE+MYoi/43gJKDYqzEmcxpBG9jTvu5b08rzf
         vepjw8QzxeX9ug9tfQL77eCXoGGeDFoU9vwLgRfDCNv4/PsNj/WzplnKdWuYgkGyh360
         7gRTUCXqxQjPEFXJLj15aVMCcOER0mi8YPBG38SwNud/FUUt3WCQBbjY6fqna1fJLScH
         gdshp+syzebskfkZzT9D8vDMrV20uXJMGP7cIBRnxhIkkLrOlY2axOHTXjLbTkXFlUJO
         DJiJ6hOVR2y4XtLcpgcLhvMj4ay+Cv6Kifs7HhVNMcNbtY2xAUk+0oF5NfznpavCMygy
         SLzA==
X-Forwarded-Encrypted: i=1; AJvYcCVKeOLNRtM19U4pFH+O+XsArdhXRU8fACRjI57Oc/ltAB1fDz4p3Cmv8rP69z2SJNFzKexGGKu7Wk4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yzotx5c+YIEgW7ncpwGgaST8rVFk9yNS1Sx3DN/9c7n3MVcgdhu
	0xEyoDuoED6o+a86zIjTPBdxu9MPdF3QH67jtLLTLqA45adCLUvQvVFEeQaCqgS3Q8keHnISahS
	3cc65RYm+yqzy8YUl9HZ4bo650ia2jb+F3OjUyabhxS08Lba01KW29nGFLWE=
X-Received: by 2002:a7b:c2aa:0:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-43161627e30mr128257605e9.10.1729529047765;
        Mon, 21 Oct 2024 09:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5GC3sMvDU9EM77w02UBxgdwq7oI8saD249CUHCeGMLn1ysjfgnLo9K0fi+joG4IN/csYJDQ==
X-Received: by 2002:a7b:c2aa:0:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-43161627e30mr128257295e9.10.1729529047326;
        Mon, 21 Oct 2024 09:44:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:1600:e899:f836:758b:6fef? (p200300cbc7281600e899f836758b6fef.dip0.t-ipconnect.de. [2003:cb:c728:1600:e899:f836:758b:6fef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431605f81a2sm125944225e9.0.2024.10.21.09.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:44:06 -0700 (PDT)
Message-ID: <49afa956-21e1-4b3d-9dde-82a6891f2902@redhat.com>
Date: Mon, 21 Oct 2024 18:44:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
 <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
 <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 18:23, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 06:00:20PM +0200, David Hildenbrand wrote:
> [snip]
>>>
>>> To summarise for on-list:
>>>
>>> * MADV_FREE, while ostensibly being a 'lazy free' mechanism, has the
>>>     ability to be 'cancelled' if you write to the memory. Also, after the
>>>     freeing is complete, you can write to the memory to reuse it, the mapping
>>>     is still there.
>>>
>>> * For hardware poison markers it makes sense to drop them as you're
>>>     effectively saying 'I am done with this range that is now unbacked and
>>>     expect to get an empty page should I use it now'. UFFD WP I am not sure
>>>     about but presumably also fine.
>>>
>>> * However, guard pages are different - if you 'cancel' and you are left
>>>     with a block of memory allocated to you by a pthread or userland
>>>     allocator implementation, you don't want to then no longer be protected
>>>     from overrunning into other thread memory.
>>
>> Agreed. What happens on MADV_DONTNEED/MADV_FREE on guard pages? Ignored or
>> error? It sounds like a usage "error" to me (in contrast to munmap()).
> 
> It's ignored, no errror. On MADV_DONTNEED we already left the guard pages in
> place, from v3 we will do the same for MADV_FREE.
> 
> I'm not sure I'd say it's an error per se, as somebody might have a use case
> where they want to zap over a range but keep guard pages, perhaps an allocator
> or something?

Hm, not sure I see use for that.

Staring at madvise_walk_vmas(), we return ENOMEM on VMA holes, but would 
process PROT_NONE. So current behavior is at least consistent with 
PROT_NONE handling (where something could be mapped, though).

No strong opinion.

> 
> Also the existing logic is that existing markers (HW poison, uffd-simulated HW
> poison, uffd wp marker) are retained and no error raised on MADV_DONTNEED, and
> no error on MADV_FREE either, so it'd be consistent with existing behaviour.


HW poison / uffd-simulated HW poison are expected to be zapped: it's 
just like a mapped page with HWPOISON. So that is correct.
	
UFFD-WP behavior is ... weird. Would not expect MADV_DONTNEED to zap 
uffd-wp entries.

> 
> Also semantically you are achieving what the calls expect you are freeing the
> ranges since the guard page regions are unbacked so are already freed... so yeah
> I don't think an error really makes sense here.

I you compare it to a VMA hole, it make sense to fail. If we treat it 
like PROT_NONE, it make sense to skip them.

> 
> We might also be limiting use cases by assuming they might _only_ be used for
> allocators and such.

I don't buy that as an argument, sorry :)

"Let's map the kernel writable into all user space because otherwise we 
might be limiting use cases"


:P

-- 
Cheers,

David / dhildenb


