Return-Path: <linux-arch+bounces-13476-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB536B51732
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684B846463E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82663313E1F;
	Wed, 10 Sep 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6R8+lPQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94D311971
	for <linux-arch@vger.kernel.org>; Wed, 10 Sep 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508418; cv=none; b=iv8UbcuieHHTiQtUBRWeqf7r1wbE7TUSoW8DzOj/Qd0RbF9rkDR/5RgWkw4lku2opXJ4wj/vHWJUIXBI/QEX3oHnuDW+8RTz+xI9REsSHlEHhk3zMqmdtNkqfQZZhybqQsBZsra185xnS61mG/JUqXADdItuy6jbsi656173dPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508418; c=relaxed/simple;
	bh=0GHdQsV5OQQFFrYKWvrl8Xw1vd0f7htYXuF8tFtfSZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oouy43InhUij4gs0feFB/TdYWC1AhlX9zOZjct68tOyOTriJj7PKfJRxL5a5FA0usUVNeKNR2oqvNgc6SmGBEcAhb8KTlvAjPX/OJi1qIe4DtsR6ukjoifZorDSH3uG0qNE4is4tTNYPAQQvW6gz2UzCLERqIJQSrNBBABZDqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6R8+lPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757508415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fg0nN23zdG+Cj1AIL0JlOHP5r+qXN0zqupg/FdERDms=;
	b=P6R8+lPQl+4DnIgIW4wJgAJoAD4i3XTkWiiqCkbImdrJJUBXmHiIgbeDyI6YQ+wGjZrd/g
	gwwVUBylmEwTCg7OXjYKtVXRE9KI9tePCtfen9/T3dcvW9hXMhtFDsk39NIOFLbcie+Vcg
	UrbrBjSJx2+QoA3GjB6YPZ7cE3AEJdM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-zpachb3xNECsdqihOUpudQ-1; Wed, 10 Sep 2025 08:46:53 -0400
X-MC-Unique: zpachb3xNECsdqihOUpudQ-1
X-Mimecast-MFC-AGG-ID: zpachb3xNECsdqihOUpudQ_1757508409
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de27bf706so18675615e9.0
        for <linux-arch@vger.kernel.org>; Wed, 10 Sep 2025 05:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757508409; x=1758113209;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fg0nN23zdG+Cj1AIL0JlOHP5r+qXN0zqupg/FdERDms=;
        b=g9ZVoK09OwzK2z9hcnVy6uM/hmxLIZTMWsGYI0wFt9Gi5aGqAmCu6CYgWZy/CCcRpB
         KxYgtNqBmpaJhEdCVL4DCQWoMjW7T243exx0migwY8KFM54cTXUCGnMYE7rtJHJZ4W/O
         QKj0AcMh74WiZwrdzDVkMq1wtpMU4Yz7GpGz2s9WOi3r5XdIwz9wZvYFfutT09oZLfML
         KOZHwGNsQkGEkdibJfG9A/Xn2Vv6s8KDHiIoOiX0DvXMEB6QrPX5ipuC84QTgkr/oy+4
         4Fr9fvBJuDuRwOgwgu47u79ejv+o421HPan8GWcafW3mxLF1H0XAF/RtakxIFi1Qyt8i
         wlYw==
X-Forwarded-Encrypted: i=1; AJvYcCVhfzhmWOGLYVam6JAfYa7hRKuxtLxC5eeJAS0sqp1fNG/4HQkkhADuMxNV81ftl+wrG8KjrhiiWOwa@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ0AcAgFLtcloPQSoMp4OPGnJf6XrVv6DJHC8c9njb4TKLurv
	98/LuFI/Rqf3IP0v5nTNU9zCsvqVl4aUqifPD4kYw4bjUdJM6wuHzj3hSr+m4e5PLUitT/6QO5g
	JUxqUuoizRKh+TtnXy+PNhi0Ej701IBtKbgraKjP4dyy6da5e+mrb8LLACFz2M9Q=
X-Gm-Gg: ASbGncteyIXp8IExaO4wbhKDii/uWet4diY2NVInhc9FngkJTDON6lBebiEsKrzQLNM
	lxiDJaKfutTcuIW5DS2W76QM5WDz7gJ7NJV82reIlozqtrYl4MrhHAvGO4hSqmfHmnKs06JQwyx
	B8EXbLPWmo5CuVxi1oM9iinEZ4NbtKR2JOD7bTgaQr9kaXDp81f3slI8TR+SaWi/FBjIPLerqYs
	MlD4T2beHtjMoVZFipbO6ZdHHU/GiCNZByOimlH8/Tp0NTJ2rxgQNyn/QD8hpiHlZ9fuynJoKVa
	vKEX+m+c0FeCkP1fmzdgY5/ovCS0+k2bjsfVZYmEe4EuKkAP0v3GWBnZ0kYso9VySrBpFLMTSOu
	kWPPySeBOcNxEHsFdEhxvQK7SuNB7YYTvkc8thOMLvyqyx4YbvB554yJa9G018M6ILNs=
X-Received: by 2002:a05:600c:1381:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45dddee9e66mr165311395e9.17.1757508409284;
        Wed, 10 Sep 2025 05:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfG6L/uzjflaWrAZuTj313xzj9w8AgoE6w48KlPrUqJtdVMiWnFR507+BjF0Lk6RA0A9XiRA==
X-Received: by 2002:a05:600c:1381:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45dddee9e66mr165310555e9.17.1757508408609;
        Wed, 10 Sep 2025 05:46:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d3ee4sm27184435e9.6.2025.09.10.05.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 05:46:48 -0700 (PDT)
Message-ID: <e61c1029-d760-4c04-acfb-55bc0af88e88@redhat.com>
Date: Wed, 10 Sep 2025 14:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/22] mm: Add msharefs filesystem
To: Pedro Falcato <pfalcato@suse.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com,
 arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com,
 corbet@lwn.net, dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
 jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
 liam.howlett@oracle.com, linyongting@bytedance.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
 maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
 pcc@google.com, peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org,
 shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
 vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org,
 viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org,
 x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-2-anthony.yznaga@oracle.com>
 <do7cmy4eiiqd5ux62r3u2ghizc62ljg5m3mqx7qzy3im4kc2p6@upmigdbp7eat>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <do7cmy4eiiqd5ux62r3u2ghizc62ljg5m3mqx7qzy3im4kc2p6@upmigdbp7eat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 14:14, Pedro Falcato wrote:
> On Tue, Aug 19, 2025 at 06:03:54PM -0700, Anthony Yznaga wrote:
>> From: Khalid Aziz <khalid@kernel.org>
>>
>> Add a pseudo filesystem that contains files and page table sharing
>> information that enables processes to share page table entries.
>> This patch adds the basic filesystem that can be mounted, a
>> CONFIG_MSHARE option to enable the feature, and documentation.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   Documentation/filesystems/index.rst    |  1 +
>>   Documentation/filesystems/msharefs.rst | 96 +++++++++++++++++++++++++
>>   include/uapi/linux/magic.h             |  1 +
>>   mm/Kconfig                             | 11 +++
>>   mm/Makefile                            |  4 ++
>>   mm/mshare.c                            | 97 ++++++++++++++++++++++++++
>>   6 files changed, 210 insertions(+)
>>   create mode 100644 Documentation/filesystems/msharefs.rst
>>   create mode 100644 mm/mshare.c
>>
>> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
>> index 11a599387266..dcd6605eb228 100644
>> --- a/Documentation/filesystems/index.rst
>> +++ b/Documentation/filesystems/index.rst
>> @@ -102,6 +102,7 @@ Documentation for filesystem implementations.
>>      fuse-passthrough
>>      inotify
>>      isofs
>> +   msharefs
>>      nilfs2
>>      nfs/index
>>      ntfs3
>> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/filesystems/msharefs.rst
>> new file mode 100644
>> index 000000000000..3e5b7d531821
>> --- /dev/null
>> +++ b/Documentation/filesystems/msharefs.rst
>> @@ -0,0 +1,96 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================================
>> +Msharefs - A filesystem to support shared page tables
>> +=====================================================
>> +
>> +What is msharefs?
>> +-----------------
>> +
>> +msharefs is a pseudo filesystem that allows multiple processes to
>> +share page table entries for shared pages. To enable support for
>> +msharefs the kernel must be compiled with CONFIG_MSHARE set.
>> +
>> +msharefs is typically mounted like this::
>> +
>> +	mount -t msharefs none /sys/fs/mshare
>> +
>> +A file created on msharefs creates a new shared region where all
>> +processes mapping that region will map it using shared page table
>> +entries. Once the size of the region has been established via
>> +ftruncate() or fallocate(), the region can be mapped into processes
>> +and ioctls used to map and unmap objects within it. Note that an
>> +msharefs file is a control file and accessing mapped objects within
>> +a shared region through read or write of the file is not permitted.
>> +
> 
> Welp. I really really don't like this API.
> I assume this has been discussed previously, but why do we need a new
> magical pseudofs mounted under some random /sys directory?
> 
> But, ok, assuming we're thinking about something hugetlbfs like, that's not too
> bad, and programs already know how to use it.
> 
>> +How to use mshare
>> +-----------------
>> +
>> +Here are the basic steps for using mshare:
>> +
>> +  1. Mount msharefs on /sys/fs/mshare::
>> +
>> +	mount -t msharefs msharefs /sys/fs/mshare
>> +
>> +  2. mshare regions have alignment and size requirements. Start
>> +     address for the region must be aligned to an address boundary and
>> +     be a multiple of fixed size. This alignment and size requirement
>> +     can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
>> +     which returns a number in text format. mshare regions must be
>> +     aligned to this boundary and be a multiple of this size.
>> +
> 
> I don't see why size and alignment needs to be taken into consideration by
> userspace. You can simply establish a mapping and pad it out.
> 
>> +  3. For the process creating an mshare region:
>> +
>> +    a. Create a file on /sys/fs/mshare, for example::
>> +
>> +        fd = open("/sys/fs/mshare/shareme",
>> +                        O_RDWR|O_CREAT|O_EXCL, 0600);
> 
> Ok, makes sense.
> 
>> +
>> +    b. Establish the size of the region::
>> +
>> +        fallocate(fd, 0, 0, BUF_SIZE);
>> +
>> +      or::
>> +
>> +        ftruncate(fd, BUF_SIZE);
>> +
> 
> Yep.
> 
>> +    c. Map some memory in the region::
>> +
>> +	struct mshare_create mcreate;
>> +
>> +	mcreate.region_offset = 0;
>> +	mcreate.size = BUF_SIZE;
>> +	mcreate.offset = 0;
>> +	mcreate.prot = PROT_READ | PROT_WRITE;
>> +	mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>> +	mcreate.fd = -1;
>> +
>> +	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
> 
> Why?? Do you want to map mappings in msharefs files, that can themselves be
> mapped? Why do we need an ioctl here?
> 
> Really, this feature seems very overengineered. If you want to go the fs route,
> doing a new pseudofs that's just like hugetlb, but without the hugepages, sounds
> like a decent idea. Or enhancing tmpfs to actually support this kind of stuff.
> Or properly doing a syscall that can try to attach the page-table-sharing
> property to random VMAs.
> 
> But I'm wholly opposed to the idea of "mapping a file that itself has more
> mappings, mappings which you establish using a magic filesystem and ioctls".

I don't remember the history (it's been a while) but there was this 
interest of

(a) Sharing page tables for smaller files (not just PUD size etc.)

(b) Supporting also ordinary file systems, not just tmpfs

(c) Having a way to update protection of parts of a mapping and
     immediately have it visible to everyone mapping that area.

In the past, I raised that some VM use cases around virtio-fs would be 
interested in having a "VMA container" that can be updated by the parent 
QEMU process, and what gets mapped in there would be immediately visible 
to the other processes.

I recall that initially I pushed for just generalizing the support for 
shared page tables so it could be used for other file systems. I recall 
problems around that, likely around protection changes etc.

So current mshare really is the idea of having a (let's call it) VMA 
container that can be mapped into processes where all processes will 
observe changes performed by other processes.

I agree that it's complicated, and the semantics are very, very, very weird.

-- 
Cheers

David / dhildenb


