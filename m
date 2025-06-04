Return-Path: <linux-arch+bounces-12205-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6FACDD73
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689E97AA72A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C723185F;
	Wed,  4 Jun 2025 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBhdUkRV"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12D1DED6D
	for <linux-arch@vger.kernel.org>; Wed,  4 Jun 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038746; cv=none; b=jQQJDf593wz/E7auHR8bx6qzahvkbK0mS95XHUl8XegJSCR92nt3D/nOhARjDqaTZ4AvdsJelZtJEsYCsyjBWxcpO3xP4vIEPZbnfpBCTPcjn74DSyJN9dLP4m8W0WDSVm7NUExfUlImVSIlsOj9irWtlr08z6+vNuB17140dIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038746; c=relaxed/simple;
	bh=U8AVzAlrbEZ0aChrxNGmrNRiyqyM220uTc6XmlAQjho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1hvNXCmuK5CZRS8OzJtrKQPZDyWdolIDxYEMUUXlRrWbkl+4p+Z4gP6S1AvMmChrGKesZmxZzvCXHA/Qk4T60yMsdB3l8U3I8ILgN5W/Z4aR+vAjKfKFDSqws022O/LhmvUTzIDkY0c2rQClNDJ+WZy2XdZvNFvS3Vs/apLMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBhdUkRV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749038743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rs0btbQ6D2xanKsfDuTxjlpnDIaLcj7WvAFOziSOBxI=;
	b=fBhdUkRVnDqJ0Y5HcKvW08xkfXZaD3avkTu/F3zxVkEh5D6WlWfSM6FH9xjfa9Vhdwk0h7
	g+baqeuBmcZeCUyBStQ6wky4Q39sJdv6USYWNYIvbjzBpyHNCYx8IcFBqVT3PVNsPg6DPE
	5rG8l/Dyyrs98orazEYgRZYiPMekAMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-LfLzizjnO0SkERxNVjhA-g-1; Wed, 04 Jun 2025 08:05:42 -0400
X-MC-Unique: LfLzizjnO0SkERxNVjhA-g-1
X-Mimecast-MFC-AGG-ID: LfLzizjnO0SkERxNVjhA-g_1749038741
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso22778285e9.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2025 05:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749038741; x=1749643541;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rs0btbQ6D2xanKsfDuTxjlpnDIaLcj7WvAFOziSOBxI=;
        b=FMkY2rbsCriMcbHt1Zi1a0IrQJpRXdq5PHWmT68yI9xFkWRy+0kKH2kTJHxWWZjkfP
         gELSu3UaJt8xgcX5n+iweEKn55rkivvIkLgKeLLWbIRgaVu+nmY6+6s8CraE2B9X8ilL
         RBD31xcgJvthy+XDb/LxPveP21I+/ipHxGYlggGTWl37s0W01ZkgMayyOy6zav9TXwJQ
         ZeFOBK/0U/RWB/AJwFgVjNA5jgj2imWl2BCEoXdWGA06Eh6TIlOG3x813c9nw6U7MAUQ
         tT3vPY5QaPR/dSkU+nNvFbqgTA1LhvV4mv6s2s0EFKnK8nCHmynzrWYMhGxWd/p6cHoK
         ruXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSmST/Y8RaJ9jeRy+uy68FnASBJOarx8m6BoAxZJDJkodfEzsbtm0MS8VMcZHeU9T6rdtaNId+wjKC@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHzZoPuWBJEC3kOh7GQCOJc2yQ7hhxjhKGB6oPxJ480Aon9Rh
	/IQwucsrDZRxqkDn1VVr73omprOJPt8d50TBsqTlefY41G8vw/q0x4Nemg4gTbM+YaKvX46vYqk
	GzRQgOD8FjOytA/t8szfrLbZT/5AxEN4rn9+HawhZ96j0vDwp1JDpNNC/Ue1V3LI=
X-Gm-Gg: ASbGnctiqcg1BkP4kz6gjiSUVw0aMA19qYvGdoU9Ix3WqYUAqayGen0+1d0QS2iBqHM
	QSVvFBs6GZuBv4ToPAtu6xvJI255hOX2l15kAIwA2uX/TUp3keBPGOdoSW38VkHDSRu0vo0X3St
	CcUpjOhWp0ariHkpqZ1OtaTSGURcG9lfA49OXRSazbQd6h0vkeS/QiRExkTp8zuLHk2mpWX/5Yg
	qRSTHWdg0hY5+AtTxxWS+G3hQ3EISUxk0yqsc+qeUi5UuMQAe4MPgQGq/pPWQHiASyqAFe7AbVd
	OBzcsomN5sZBIMDRtlWvn/wOtA6tOfY5znFuhRHJTl98MHTeVa2DFqfKpNw0AdCR40ADohthD+7
	TwqA7Ic9TvRMNmiwVkWlydU5rc5o9bG/9GZ68gDc=
X-Received: by 2002:a05:600c:34c2:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-451f0b09f62mr18360275e9.20.1749038741072;
        Wed, 04 Jun 2025 05:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBsuyo9l+yFSCcNj2JR7ZoUNJ4TDGNXGCjYZQjJw2vbSw0Yu0DciIRlxFRq3I5iJNsenYpfg==
X-Received: by 2002:a05:600c:34c2:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-451f0b09f62mr18359835e9.20.1749038740628;
        Wed, 04 Jun 2025 05:05:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d8csm196532255e9.24.2025.06.04.05.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 05:05:40 -0700 (PDT)
Message-ID: <5c054941-62c2-483c-ac19-592aa795ed93@redhat.com>
Date: Wed, 4 Jun 2025 14:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
 <CAGsJ_4yKDqUu8yZjHSmWBz3CpQhU6DM0=EhibfTwHbTo+QWvZA@mail.gmail.com>
 <20250604120013.GA1431@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250604120013.GA1431@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.06.25 14:00, Johannes Weiner wrote:
> On Fri, May 30, 2025 at 07:52:28PM +1200, Barry Song wrote:
>> On Fri, May 30, 2025 at 9:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
>>>> Barry's problem is that we're all nervous about possibly regressing
>>>> performance on some unknown workloads.  Just try Barry's proposal, see
>>>> if anyone actually compains or if we're just afraid of our own shadows.
>>>
>>> I actually explained why I think this is a terrible idea. But okay, I
>>> tried the patch anyway.
>>>
>>> This is 'git log' on a hot kernel repo after a large IO stream:
>>>
>>>                                       VANILLA                      BARRY
>>> Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
>>> User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
>>> System time               14.41 (    +0.00%)         14.64 (    +1.50%)
>>> pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
>>> workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
>>>
>>> Clearly we can't generally ignore page cache hits just because the
>>> mmaps() are intermittent.
>>
>> Hi Johannes,
>> Thanks!
>>
>> Are you on v1, which lacks folio demotion[1], or v2, which includes it [2]?
>>
>> [1] https://lore.kernel.org/linux-mm/20250412085852.48524-1-21cnbao@gmail.com/
>> [2] https://lore.kernel.org/linux-mm/20250514070820.51793-1-21cnbao@gmail.com/
> 
> The subthread is about whether the reference dismissal / demotion
> should be unconditional (v1) or opt-in (v2).
> 
> I'm arguing for v2.

+1

-- 
Cheers,

David / dhildenb


