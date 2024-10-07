Return-Path: <linux-arch+bounces-7750-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA0992925
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 12:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D4F1C22CF6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995C1B85DD;
	Mon,  7 Oct 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZtdbv0a"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24F1B5EDE
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296704; cv=none; b=avR+XbUmzx+dRD0eOGThgFTgT5dr+EIHXrHWCwvg45z7D2z6/W3HbCVWn5eqKMpbuvlzSTpJ3fM75M2OLUpMAkz+sMP3/qBSDCZK7Orpzpu9Hn05lSmyhewzcCngLqDHwp7IuUXQDFVMj+GLXObB3MXr8ZbcC6TMFaDyrwkyp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296704; c=relaxed/simple;
	bh=fkAzh6HKnTVkN9u8oxgAlrLIgYJMbNBUPxpZVbaBnho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pE8jF66Fr2X1HRQ6KP6V3uftp+OdeKe0F4a12CVWNKd4/teUu6U7QY43nyV6L+RgEleajz5x7vHSj2P5l21wWYMQnMnN/Zm8JpY1uYHn8iGf1ItUgpS3M4RI2vUtSCBAU/P9WwALPd7cBW4nPqYPTkZRUkv79ROck7pUHMkJPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZtdbv0a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728296700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OqsZjaaBaUUsDXvs4mHnhWXU90gxYxc87aEmageaD9o=;
	b=VZtdbv0aANbED2JKhq2iUBkVbHlZ6c+BY2d597QRYcxF2AE15ub40XLq3e2GRCB59zLkma
	JJ8jZPfFtjFkM2PLZKKVBIEYyKdcqmEoVNzHj2p0PRZtQllrykhvM1l0nCw+GSmrmMCQfO
	eLRbeKV7P3N0E22p9afMn3448y2qCYM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-_NMBJUt5NxiJQe5povsvoQ-1; Mon, 07 Oct 2024 06:24:59 -0400
X-MC-Unique: _NMBJUt5NxiJQe5povsvoQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cbcf60722so37863465e9.1
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 03:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296698; x=1728901498;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OqsZjaaBaUUsDXvs4mHnhWXU90gxYxc87aEmageaD9o=;
        b=Aomv5ZtWrn47SrFbHf+O4QWPYP58Lji+kAfuZquSO3HnP9p0DNk8QdRSMSutLhki3W
         tL4UrY3IvbtFCP9jzpHBZi4UzlgxZYMjtxJyGpWyiMUXkbVOfO4zqN407EBDuLcCk9qM
         Oair3liSJwp3qwVQYwO3DtTvJu8vmauMdS4jY5o6zcvk0fTLmNsfTk53ZYIODTG/zMNj
         pFs04879FVKpEEiPkyK0iZya4C168atvSuZAswcPeLR+c64/coKzlb/QoS4FlJ+Es00c
         eGTtuFVeirbyunus8WfPEeeeidrbmGKeztWciVwIv+1aI34bqA9vwBaACUtNE71Xf962
         0qLA==
X-Forwarded-Encrypted: i=1; AJvYcCVhH3kIgO0EQY+2TBTsPzBJsPoQYMBNkT5h8TjfZ5xWpp1sqxHvi3TeqMjerTbP0IxQ3LdW2c4kvOJ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yiXxal1+4r0I6nh6xPOZ9k/3DLg7ZTUeDT5a3HecUsU5n+Jy
	YFhtKHa+7fkfSUnQIJc9+oMT9yZeT+6WVvB/VuxK2CGoqZ6c6YG5zQISNgxdxwfL3fxvqMXq3Jb
	EMYg/z2oF+vzTO5QycJDyuLTWo0pPEJ3qwMnFyqD17buruZNyX9XvrYdOqYk=
X-Received: by 2002:a05:600c:1e26:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-42f9210c3d1mr13493485e9.12.1728296698239;
        Mon, 07 Oct 2024 03:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkP+jiCh5p6yhuunhbY+WDtBNvwCLEabBxZDiquvMZ1w1+g+/pjtLs6yQ7Cn6elaAxAQq1bg==
X-Received: by 2002:a05:600c:1e26:b0:42c:baf9:bee7 with SMTP id 5b1f17b1804b1-42f9210c3d1mr13493285e9.12.1728296697805;
        Mon, 07 Oct 2024 03:24:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34? (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de. [2003:cb:c725:8700:77c7:bde:9446:8d34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b44374sm87917245e9.30.2024.10.07.03.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 03:24:57 -0700 (PDT)
Message-ID: <04c4314e-7958-47bd-8281-23c3e35fc10e@redhat.com>
Date: Mon, 7 Oct 2024 12:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/10] mm/mshare: Add vm flag for shared PTEs
To: James Houghton <jthoughton@google.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
 viro@zeniv.linux.org.uk, khalid@kernel.org, andreyknvl@gmail.com,
 dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
 ebiederm@xmission.com, catalin.marinas@arm.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
 rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
 pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-7-anthony.yznaga@oracle.com>
 <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.24 01:40, James Houghton wrote:
> On Tue, Sep 3, 2024 at 4:23 PM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>>
>> From: Khalid Aziz <khalid@kernel.org>
>>
>> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
>> a function to determine if a vma shares PTEs by checking this flag.
>> This is to be used to find the shared page table entries on page fault
>> for vmas sharing PTEs.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   include/linux/mm.h             | 7 +++++++
>>   include/trace/events/mmflags.h | 3 +++
>>   mm/internal.h                  | 5 +++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 6549d0979b28..3aa0b3322284 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -413,6 +413,13 @@ extern unsigned int kobjsize(const void *objp);
>>   #define VM_DROPPABLE           VM_NONE
>>   #endif
>>
>> +#ifdef CONFIG_64BIT
>> +#define VM_SHARED_PT_BIT       41
>> +#define VM_SHARED_PT           BIT(VM_SHARED_PT_BIT)
>> +#else
>> +#define VM_SHARED_PT           VM_NONE
>> +#endif
>> +
>>   #ifdef CONFIG_64BIT
>>   /* VM is sealed, in vm_flags */
>>   #define VM_SEALED      _BITUL(63)
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
>> index b63d211bd141..e1ae1e60d086 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -167,8 +167,10 @@ IF_HAVE_PG_ARCH_X(arch_3)
>>
>>   #ifdef CONFIG_64BIT
>>   # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
>> +# define IF_HAVE_VM_SHARED_PT(flag, name) {flag, name},
>>   #else
>>   # define IF_HAVE_VM_DROPPABLE(flag, name)
>> +# define IF_HAVE_VM_SHARED_PT(flag, name)
>>   #endif
>>
>>   #define __def_vmaflag_names                                            \
>> @@ -204,6 +206,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,  "softdirty"     )               \
>>          {VM_HUGEPAGE,                   "hugepage"      },              \
>>          {VM_NOHUGEPAGE,                 "nohugepage"    },              \
>>   IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,     "droppable"     )               \
>> +IF_HAVE_VM_SHARED_PT(VM_SHARED_PT,     "sharedpt"      )               \
>>          {VM_MERGEABLE,                  "mergeable"     }               \
>>
>>   #define show_vma_flags(flags)                                          \
>> diff --git a/mm/internal.h b/mm/internal.h
>> index b4d86436565b..8005d5956b6e 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1578,4 +1578,9 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
>>   void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
>>   void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>>
> 
> Hi Anthony,
> 
> I'm really excited to see this series on the mailing list again! :) I
> won't have time to review this series in too much detail, but I hope
> something like it gets merged eventually.
> 
>> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
>> +{
>> +       return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
>> +}
> 
> Tiny comment - I find vma_is_shared() to be a bit of a confusing name,
> especially given how vma_is_shared_maywrite() is defined. (Sorry if
> this has already been discussed before.)
> 
> How about vma_is_shared_pt()?

vma_is_mshare() ? ;)

The whole "shared PT / shared PTE" is a bit misleading IMHO and a bit 
too dominant in the series. Yes, we're sharing PTEs/page tables, but the 
main point is that a single mshare VMA might cover multiple different 
VMAs (in a different process).

I would describe mshare VMAs as being something that shares page tables 
with another MM, BUT, also that the VMA is a container and what exactly 
the *actual* VMAs in there are (including holes), only the owner knows.

E.g., is_vm_hugetlb_page() might be *false* for an mshare VMA, but there 
might be hugetlb folios mapped into the page tables, described by a 
is_vm_hugetlb_page() VMA in the owner MM.

So again, it's not just "sharing page tables".

-- 
Cheers,

David / dhildenb


