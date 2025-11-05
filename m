Return-Path: <linux-arch+bounces-14545-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09CC37FA6
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 22:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C5D188D5C0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AA2C11C6;
	Wed,  5 Nov 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkhK4jvA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B9126C02
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377359; cv=none; b=iPdEjZ6ihgYo7hfgnfv4C93MlQUOdX8Rsuq1gYzDajWAid/kuObq7koTOzA4uzIXsoIvzLHEXQoaJ1+Fjm5WcK2FnJBJXQpen/bqDkQNlqdS27DcE4v9goICEE6IzjCsGcpqas419wZlat6E6UEELNEG6gPgfV/OmMbXIGXaIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377359; c=relaxed/simple;
	bh=f9gnacKKf2I1AkHrp5BqN18zRTjnCOrkCGu1EP+5wLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVR0gUS+FU7x3c6twJ1Nm83n3YfYm9/p8ULJn827MfBXcpAAO5uumPIW/iPhvYzKW/SR5yBnPKCBrkWsiQak6tkCR7E04h83TEf87UQR3CbFqIuVzoSG5UHfQhqSe+jDatzDcvsT5z0Y6drLKu/86L+ia2z1ibENb/B4SFifwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkhK4jvA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-421851bcb25so148658f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377356; x=1762982156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ppaE2LQfT94SEh9VKLVy8mNImdVN7dwxyvCopktHPk=;
        b=VkhK4jvA99PG3acbgpmUypWPEdtb0MKnA5L0WDSKIpwQwS3xHnOn9s8Y0xdq3FiNAS
         68cVm7oqgzT70gg+TPdHlJ1EijPf+hAt2zhvLNS7uPQOyBUoy9p2O9gGFTWL3zWsKRgH
         57w/sLfa7P2x/2tlr5TUvpld/VD65YmWFqwwJAUngCXEQq0dO6P7fcgjn6a0Ece3tj3d
         PbEX7jrRRObD7pZRGtsO6csWRKwEg9tdla8SWVrPXJvzOJKqmcCz80g0gxa9q2dGLkf4
         X7NnPJtcJhOHU9k5JPEK2uyGjkHcbbSzvqz+wQFPCBkGDsyiQI6wZc/mV76QK2S3eBAB
         7DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377356; x=1762982156;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ppaE2LQfT94SEh9VKLVy8mNImdVN7dwxyvCopktHPk=;
        b=JRe1vl92XTlUZ+YLxLOV2EZt715GKVXII5zicQNgT0Wof+JqN1NA2QgSJeZE1mCExk
         Vd1sGzU+DDYN3Eh+ov9ufSwKDryeuNXtA9WIZ2drFM5dpMcVAHDbPWqybkwcA72McAsG
         ne37+HQaGESR4VUy3fgvaHJJG3lUyUwByzvJjvJnNPovKQCc//LJ0zru7jE7OQ5hhv9b
         NQKuDPQM7Tartvx3VK9zlwzy3GfJ0WQtl6eX48HTxr7uCVRe1N6onXOGoZBUcVHFqaBj
         hCpWxEB21wkUoSt6/5pwJhP6QmePcsup1NHIZ62fMSW/K2J8H0h2Jm33D/brAzxNpwmR
         Le8g==
X-Forwarded-Encrypted: i=1; AJvYcCUE7vAKyYN012XXxDGf3HJXuv9oSPPhWJQfKP3oG5D3GR4jBnan31Ax6qFkmRrfochBt/YdQ0dvqLVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/e+xtGxJXw+bWuKXIfS7E5ue6u9USAy2mv0EXOw4Dw0UiPMs
	Y0ppPFXAHApXSq+u/wLbmSUr6bYB7unGMJqXYAOJO0Mz7tHb7Ehl/FAm
X-Gm-Gg: ASbGncuY7BZJMxxOX+s4bJ4ajz9SEhvJkIH5x2WqBlzngb7mfV3Jt8NP97uFOCV+xi6
	qWV95r5csYIezUW7IczGrDUkPIme/0iR8AIlAhFF3PnotaxJOnVGd1AviRbnfJDWmQLeKAR1CSv
	x0ZGBOmJlEFxsNfrCg7/WXBrutJCXH1mIoWaI1WX1MaMcAgKa1BscdLs2cKW2RBFJq9eRxRv2tt
	J11zFRZ+OAW+xoQ+r/g0nyTKaEuhan1MD9szexuwvOfnmbCmtbD71JNtk61FLdravxTmagGnccG
	Bu/wzIHxNG00I9AFsF+8MFJzggSi7As01HJg87tD67R8F1hjY6kmX2mXgcEC1jmL03iXlITSgyE
	oR4+4Fomq0IfhEtOl5wl6Sn5SgPaMveBa1fSt08POasGGf1CFDTCtH+/VjJtGyX3eXHxi/TixTH
	+AdoLcHQ3JTs00x7sMNrYN1u/ZT2z+EAWeQilSuxE685lZeD+yc/7rBk2oi1+ZYRxUzcSpKJOO2
	ybQuAlM3hp8T/8Y9m0ZcnFQsV5b52Q=
X-Google-Smtp-Source: AGHT+IHhnDU7C8JIw0mU7ueaGAVALbH7ZSUb6hbiggFXfD6/S5ypV4gK3TS5wjxW/SnnCtFGhSbz5Q==
X-Received: by 2002:a5d:5f53:0:b0:427:4b0:b3e5 with SMTP id ffacd0b85a97d-429e330aed4mr4567372f8f.47.1762377355551;
        Wed, 05 Nov 2025 13:15:55 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40617asm851462f8f.10.2025.11.05.13.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 13:15:54 -0800 (PST)
Message-ID: <563246df-cca4-4d21-bad0-7269ab5a419c@gmail.com>
Date: Wed, 5 Nov 2025 22:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
 <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
 <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
 <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
 <2d1f420e-c391-487d-a3cc-536eb62f3518@lucifer.local>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <2d1f420e-c391-487d-a3cc-536eb62f3518@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 22:08, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 09:11:45PM +0100, David Hildenbrand (Red Hat) wrote:
>> On 05.11.25 21:05, Lorenzo Stoakes wrote:
>>> On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
>>>> On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
>>>>> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
>>>>>> On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
>>>>> I thought about doing this but it doesn't really work as the type is
>>>>> _abstracted_ from the architecture-specific value, _and_ we use what is
>>>>> currently the swp_type field to identify what this is.
>>>>>
>>>>> So we would lose the architecture-specific information that any 'hardware leaf'
>>>>> entry would require and not be able to reliably identify it without losing bits.
>>>>>
>>>>> Trying to preserve the value _and_ correctly identify it as a present entry
>>>>> would be difficult.
>>>>>
>>>>> And I _really_ didn't want to go on a deep dive through all the architectures to
>>>>> see if we could encode it differently to allow for this.
>>>>>
>>>>> Rather I think it's better to differentiate between s/w + h/w leaf entries.
>>>>>
>>>>
>>>> Reasonable - names are hard, but just about anything will be better than swp_entry.
>>>>
>>>> SWE / sw_entry seems perfectly reasonable.
>>>
>>> I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?
>>>
>>> I am quite fond of my suggested soft_leaf_t, softleaf_xxx()
>>
>> We do have soft_dirty.
>>
>> It will get interesting with pte_swp_soft_dirty() :)
> 
> Hmm but that's literally a swap entry, and is used against an actual PTE entry
> not an abstracted s/w leaf entry so I doubt that'd require renaming on any
> level.

It's used on migration entries as well. Just like pte_swp_uffd_wp().

So, it's ... tricky :)

But maybe I am missing your point (my brain is exhausted from uffd code)

