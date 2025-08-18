Return-Path: <linux-arch+bounces-13183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6295B29B35
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC3F5E8111
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30702727F4;
	Mon, 18 Aug 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVle09w6"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3427A114
	for <linux-arch@vger.kernel.org>; Mon, 18 Aug 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503275; cv=none; b=q4xBnyyRh4FSckUT2sgPRm0JIET/QauWPvdbiUWck9065zYHchgUyPr0OFbv2r5hMRo23bL1tVisiUn9/AakVK8K7vzstNpl/j75VDMyMSovn5dOMufDyJ3DbPZ9s/x4YWeqrS7UG/J5gUBm+OyH/Mm/calZj9EqbYu9gWNBHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503275; c=relaxed/simple;
	bh=ke/70mwNuZMQ4uUVMWKNowY7SVljptpZBjnzkw07fTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtAwxshHLYYKjatW4qWs0wQ6O5Web42BwildBmIZIscKgSpnPc4S8o14lPZTNMIVAQlm4sxTT+10ZpcYXpfSE964qPuiKb+59PEhsTogOxiAsS+W6QZroO7IfiVTNcVEFJQJJHOsvP6+K8NZ2a2Ohva3jjKCNZQ0k5/tfgZeux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVle09w6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yKouifB7G5rcBd40ZGRdNWHNyUYJpa/6R/7rwWgxaNU=;
	b=XVle09w677mML4zl4ckHmP+KEelydPKilolIXKpTfeYR+I2jKQo5z52ABH2ysvE+IhuIvp
	QwLopuLCf/QZW8nrg8/uXFQucYI+94DUcuDKau6/g3hIQT90dZ8XL741LTbMAt4Bk+R5V9
	1PVMCqkiHVbG5+Q4NkJLcHNaBWUG3Js=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-_GVUheXoOAOa1re_fl33-w-1; Mon, 18 Aug 2025 03:47:51 -0400
X-MC-Unique: _GVUheXoOAOa1re_fl33-w-1
X-Mimecast-MFC-AGG-ID: _GVUheXoOAOa1re_fl33-w_1755503270
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so15461165e9.3
        for <linux-arch@vger.kernel.org>; Mon, 18 Aug 2025 00:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503270; x=1756108070;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKouifB7G5rcBd40ZGRdNWHNyUYJpa/6R/7rwWgxaNU=;
        b=H/cloMKq707KkovPnf/r2RyT+OVeBaBvKbxoz555agqrO0la02x4orfWdCHJEkRS4U
         MgOlumjiIutjia6vndpJlyx8gUy1B2QLgei4thn3W/qW3s2ZXzIKiK0OUJDyIonV+tQE
         M7s1fQJSVbJMqSPbjCa8yCyhtwgmuD4Pnk/qgc9mvY/UjnT719NaBmutNbBFh6jwvghc
         MPAenI59exfgH7PJP+DcxUg737hMzjYS+emY4w1+P6JM2NMDfdFGxCOZT7Y8IW6p776o
         FaMlXHcLI2iLNQd3LwzclnNPiQ6wsO+01+2dhaCGpJu7EnL9IscedFWMHHOh1zEg0cXJ
         d+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLegI+9JsUEdnCGSX678Z3Yoy9ExA4LbWHxtP9/qini/6tEuzIfuJRJBd2DFN44sKJXXrYEL9MmSZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+O9b+jCq+X02n5c1ClRRU2vMpt4uyva1CmpcLRx/siPe4CQOh
	7iBt6qx5f+Bg8cSn9ScQ1XWADSXEWOQFF0jCtImG5322dr3mGHKenvxsUn/loEajPe3Dkr8H5hI
	cmm8zuoXcJ5hW0l9SuR11dUOjvI53elNzI85sllyAC5OUdXrQOtYYCVcad7GJAaQ=
X-Gm-Gg: ASbGnctP1m4/Kd7P2+sxlLmm7gwlojtPs3kCZ7JBDc1BQZpF6zt+V7oHdtN9BKxUC7a
	L9SiqsIZ3LEsbIfLBbKVGTuv2ynoYO+GahairtMyxcxcbWVBSZPK6dlqfJGfXMGRgypL5GCwylT
	0WlojWSX8wdmLu+ID3X1RxjLW9Ioc8yBh6Se/20qWNJ3X2OEmszdAy0IjmTisvIOou7KdhVE2ah
	TBS1Y2bjfgoDD+5dywl3Xu6E9w1PRRnnx191yi8A4OFHnKRiJciqmKEoOJKMKr58GoR7dD77pKw
	eKA9Dba6qG4JT/CvsdW4/qVnpu0gGtd5rfHQ3/tvyKWbNe4h6EfvYBnOSH5c2lBlsJumYQbKiTG
	vRBeiGlNQIee0DCH0eMREFqCT27/akpoGJmSHA/kCNZTAddR9kVSS7ENwkMFak299
X-Received: by 2002:a05:600c:154d:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45a26784890mr58197255e9.16.1755503270195;
        Mon, 18 Aug 2025 00:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8vuz2TuDec3PC8OQ2oalVcrssQL/Ez40NgjEUbWnLchljSNogxqDtuxCMN5BdLp0bZtq2rQ==
X-Received: by 2002:a05:600c:154d:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45a26784890mr58196695e9.16.1755503269634;
        Mon, 18 Aug 2025 00:47:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079da7sm11738572f8f.56.2025.08.18.00.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:47:49 -0700 (PDT)
Message-ID: <def7364e-ef77-4734-b870-278f9975e9c0@redhat.com>
Date: Mon, 18 Aug 2025 09:47:46 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 mm-hotfixes 1/3] mm: move page table sync declarations
 to linux/pgtable.h
To: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Juergen Gross
 <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Oscar Salvador <osalvador@suse.de>, Joao Martins
 <joao.m.martins@oracle.com>, Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Gwan-gyeong Mun
 <gwan-gyeong.mun@intel.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Uladzislau Rezki <urezki@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20250818020206.4517-1-harry.yoo@oracle.com>
 <20250818020206.4517-2-harry.yoo@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250818020206.4517-2-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 04:02, Harry Yoo wrote:
> Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
> linux/pgtable.h so that they can be used outside of vmalloc and ioremap.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


