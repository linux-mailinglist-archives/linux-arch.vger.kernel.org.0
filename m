Return-Path: <linux-arch+bounces-14541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FBC37A62
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CD93BA02F
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DAE317701;
	Wed,  5 Nov 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3qaftoK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2072E03E6
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373514; cv=none; b=oPMHlKD8O0iT6owqND8+y2/Q28+9fhgymN6Jl0lsOscZX1EFs6JhOjlX+mYKo2fEHM0CV++EqRW5UsDteMnNo5v+2hyCBNhwwQuShwegs4a07RUvO1+xtpGFM+f+lQegaZHM6e/M2odgFy5u0gBK5+dX5gcHfEQK0ii4ZpZWNfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373514; c=relaxed/simple;
	bh=NFp/V37n2JlPJmM4Ml3ZxXNzYR6pZ1s9aep17sOBoWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDwxiYR7uQted23YJTKGVKfYUSoRqbHqd+rLJgU0XdkJVRuVBTdrPOecaO/SzPbWI4hkTbrQRtZcPmtUNN4kNTFYewvgCiKN8TsRHD1iY0KkfnxVVRon/U9PI4b3Ek/8qEd2sbTNKP4p2Wb6g7toYCDgHZLd85HLf/13lhZFtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3qaftoK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710683a644so1628195e9.0
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762373511; x=1762978311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TumQxLyft0zt3kRPj4Gvce84mIv/VXDVvsyQGcXgpBE=;
        b=G3qaftoK+YdtvWNtyjNFuwkMQyswW02+5KSfVUblB/mKLciKFoV5m+wKCH/awie5Q8
         HgCnNlsiWSziPPivGXCApLVpm+sPhXR7Cd3yBI0TcWhoS/YeUUAK0r8E4hndWs1/cel5
         R3vakXMGZX9GAUlVSZet7XNFgUfitgFuhifBR4xuIhJvRZ2z+Fbt/24ea3+JCc7zEoIE
         uRgRKcU0LQjbNmbaGWti3+Gxu3tc2jgE7stWFy2QP1rUUa7fzsRXdH/fSYkXCvHSpCPG
         ZMv56OfCT+f9bEphoMsxyZTazxHQ4FsMYYXIzql8Fd+bGbwoizcROk/aJfP0ETo/cko5
         +6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373511; x=1762978311;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TumQxLyft0zt3kRPj4Gvce84mIv/VXDVvsyQGcXgpBE=;
        b=ZPPz0HgW9NCYpeszoM7XcAoxmnE1y3xbRb+rCDPReRqO8vgEmVvPbY+b+Enj+xhRXv
         S1ToT0K+0UmMxEKDGsGv47xJxh5tpoUGF+wJx7M7vxwSMO0CnOC5XHNIObVqMZw5mBGU
         IbMgtLSCjTcwObpcaHGDb9v1KHmnQ/2VQak8soruTv6OKa/FGE6ibARMhDKpCS64Kcw5
         kDa7T6vZS1pTlQQ5kV44eDHbrKzCGt43VQhPGcdI5Xckc0qVt9Sc0mAffXeoSA5tVFVS
         QrXS83J5WsSGDJ/R4ZeX4x4FiSdI+c+TJdf1QkSBIHKALJmOSDrM/noqYC51GTaUghwf
         ifxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcS4UxyMtjIAsdSntP3smbrueqS0BU/cAGri+QCXWTnQSJZg8Q6B2W8iDwmCgX5VUmu1TXGzbBTJNc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+vRGC3voQTNqmLi3IcJjdjutEzfK82UZiw8XMNtz+Gor/Gxr
	dz01FqADD3RDmAJP/YA6uBQmgNm/2xKa5YszENTh0IaepE1GAXtWpX+b
X-Gm-Gg: ASbGnctv5q/2UTISj+dArgB37VpCvYuZfa1JCD5vDYy5yRuFuBTz9gLVjTYBOa0afR2
	tOPzhg9Kb31cjPP+j9t0GYXbcnxacRkuDWY3YR9Y8JqPHXQYaGnB4MHvcfWVnG5f7Fr4wOByNAv
	aVybQQjbEQTtAAMJW5xZ2aq7AceoedRNU8YR1a+PxJu6K1p3QPJsRlcwOMRQZM/rNWu1FNGJOyj
	Q2Yhk661O53G1LP6ala9UDa5Vy0xynJXSkKKYdBmQtFlUcStw667cAYi/nSuBz6QBAdobyni4/J
	stJbrwdYAbmFDQaXFOPf+dh+YkDUPfADj8g0KhAUiYfJyASjunCNauZOb4kFKFiDMSt/w73dlXF
	wuK5AWPBt+4jjvfl9jiJOdqssKZpj3pFBSrrz1yPjN9cMQn/1kDwusmLPWc90xYzaojcpV0Hoko
	rxdKzJYJLJ0HkNOcqLSyXtlDeoXsaDAXV/HP3ppAIXU29GMhfMuyKMxr8C096J1CI+VwTfwpm+o
	e5d66otjo/ZDLYoF2TweOP/rum629M=
X-Google-Smtp-Source: AGHT+IGU2uJHKe1jjk7qRSxlMsv3pia9G9MZgIFjxGc/cMqJ0vMZlW4f3Bo9nX4bKGT6SOm0X+42uA==
X-Received: by 2002:a05:600c:590e:b0:477:632c:47bc with SMTP id 5b1f17b1804b1-477632c4936mr892375e9.6.1762373510748;
        Wed, 05 Nov 2025 12:11:50 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755938f45sm51392505e9.4.2025.11.05.12.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 12:11:49 -0800 (PST)
Message-ID: <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
Date: Wed, 5 Nov 2025 21:11:45 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
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
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 21:05, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
>> On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
>>> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
>>>> On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
>>> I thought about doing this but it doesn't really work as the type is
>>> _abstracted_ from the architecture-specific value, _and_ we use what is
>>> currently the swp_type field to identify what this is.
>>>
>>> So we would lose the architecture-specific information that any 'hardware leaf'
>>> entry would require and not be able to reliably identify it without losing bits.
>>>
>>> Trying to preserve the value _and_ correctly identify it as a present entry
>>> would be difficult.
>>>
>>> And I _really_ didn't want to go on a deep dive through all the architectures to
>>> see if we could encode it differently to allow for this.
>>>
>>> Rather I think it's better to differentiate between s/w + h/w leaf entries.
>>>
>>
>> Reasonable - names are hard, but just about anything will be better than swp_entry.
>>
>> SWE / sw_entry seems perfectly reasonable.
> 
> I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?
> 
> I am quite fond of my suggested soft_leaf_t, softleaf_xxx()

We do have soft_dirty.

It will get interesting with pte_swp_soft_dirty() :)

ptw_softlead_soft_dirty() Well, at least I would understand it.

