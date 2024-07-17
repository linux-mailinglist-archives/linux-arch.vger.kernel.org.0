Return-Path: <linux-arch+bounces-5461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B66933E75
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964401C22C11
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127A181328;
	Wed, 17 Jul 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT97eKJ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE3181304
	for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226787; cv=none; b=VTYCd3CiIOXQCkmb1/reESZ4Y+oVCXajkYV6QhpAfISSq0vttMd9LJTBSCUmGMQc/iUrEBM7F8eGrFEKcMkq/MrnDxBHMvuHLIDq5bgHGbm22wcyrTrk7N3zTZP4vz7D5xr7enc9wn19uimZdDFa+6kZNeynLaAc3GaUhIP52XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226787; c=relaxed/simple;
	bh=CrDDYOcmyPQoZCPC1i4Y1DcAZ3+d7HcTSETFYRrG8VQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsqQntcD1JdgdVe8NV3W/90MARKg4Mz12I3igByBF/pl+Ke06uXsTOAPkqgofwwaExTXeq4LU+UO15/yf7UI/yqR9hwkBGJXPuc4bsKW/yXsM+qxTxNG8D7x3dRqdPwXdbFWK6hs/4n2eeZVP/I5SG83eRV2K6wUh6PjnhoGmGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT97eKJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721226785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GICXT0BFVJy0QIZX9VPtiCc3OM2RPQjhgUFSA0WTx1U=;
	b=dT97eKJ8TzQxT9NkFXYCwXAehUW1rKTroapjgB1z0JGLjQsTie/DGKEGBffBZWfqffkJJh
	BXMMTluAgs8yIYwrmP+I6wVhmoivworP+62qK8EBZE21ZcETHuAoSZGLKcO6uWMepIsF0k
	UJUzYCFBJjRPNGjtadsilCYULMmssCg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--4IqmoDuNCyve84Wm5JYoA-1; Wed, 17 Jul 2024 10:33:04 -0400
X-MC-Unique: -4IqmoDuNCyve84Wm5JYoA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52ea883187cso6547135e87.3
        for <linux-arch@vger.kernel.org>; Wed, 17 Jul 2024 07:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226782; x=1721831582;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GICXT0BFVJy0QIZX9VPtiCc3OM2RPQjhgUFSA0WTx1U=;
        b=Z+DBLFu0Blno35IqyAC0Y7CMkU/SYI+otnyQHkFHLPVzUI7iUtBQuMheutVVyseduu
         6t3UZZm/ZS7AqxqKs3kelNIIR4CbvxPXWFPb+cPrG4b/c6dnh0TUvH2GcY1diWAqsCFI
         NUJtwJP1+JNG8hb+FssUUkM7tz1940TG8AiVGZseStewrA66cCqaqszqwmuOwJYp82tW
         PKDmNOY0FeG2CAFTmdSXi/p0AzTMJ6k9OfuAXa4GCH1dSKNbrzw/ZxAIpg/v9LGBIhzt
         2mIeRzFrlh7kI+L50Sy1BNWODFxhyDkkxdwbCXm6SD9mGWM5rCPdFS+DVsUmC9ARy6DL
         zxig==
X-Forwarded-Encrypted: i=1; AJvYcCW5W/gtMxXF/5Re4duMysSh+QRVBPm/kwxo7Vsm7rR/ikHrJiOEyKDCtrba/s/4vLGQ/B04KPW3nAtXnCMazuUC9lzMz/pLbAOaNw==
X-Gm-Message-State: AOJu0Ywn7JO3gvRpJXRliHyG//Vc3chxj90U2pjRTT77uVfFTteSMY8s
	5mB+ITZI6Z2g0bWXzM3i/wib8Q8FAAXD/BbHe+Z7+8B8VEOAl7kZUDnMbW4883sspO3iLAqK2ef
	n/bUWBb5DtYrvMux2NgTB+7Asw4f/J8Qubsr4NghjfqB4fh9deSA8DCuWB9c=
X-Received: by 2002:a05:6512:33c5:b0:52c:ec68:6165 with SMTP id 2adb3069b0e04-52ee53cc00bmr1663763e87.33.1721226782339;
        Wed, 17 Jul 2024 07:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqpAiEHpfyNE8LzYLpjmIqAoQj/aWWnfve8BOPOkkfeVMrwCw7kn1k4etYvjz09EiWJN/XQ==
X-Received: by 2002:a05:6512:33c5:b0:52c:ec68:6165 with SMTP id 2adb3069b0e04-52ee53cc00bmr1663731e87.33.1721226781780;
        Wed, 17 Jul 2024 07:33:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77a5804sm92385e9.16.2024.07.17.07.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:33:01 -0700 (PDT)
Message-ID: <e57eca18-b66d-4b5d-9e73-8ab22f6bc747@redhat.com>
Date: Wed, 17 Jul 2024 16:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] MIPS: sgi-ip27: make NODE_DATA() the same as on all
 other architectures
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 x86@kernel.org
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-3-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240716111346.3676969-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.24 13:13, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> sgi-ip27 is the only system that defines NODE_DATA() differently than
> the rest of NUMA machines.
> 
> Add node_data array of struct pglist pointers that will point to
> __node_data[node]->pglist and redefine NODE_DATA() to use node_data
> array.
> 
> This will allow pulling declaration of node_data to the generic mm code
> in the next commit.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   arch/mips/include/asm/mach-ip27/mmzone.h | 5 ++++-
>   arch/mips/sgi-ip27/ip27-memory.c         | 5 ++++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
> index 08c36e50a860..629c3f290203 100644
> --- a/arch/mips/include/asm/mach-ip27/mmzone.h
> +++ b/arch/mips/include/asm/mach-ip27/mmzone.h
> @@ -22,7 +22,10 @@ struct node_data {
>   
>   extern struct node_data *__node_data[];
>   
> -#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
>   #define hub_data(n)		(&__node_data[(n)]->hub)
>   
> +extern struct pglist_data *node_data[];
> +
> +#define NODE_DATA(nid)		(node_data[nid])
> +
>   #endif /* _ASM_MACH_MMZONE_H */
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index b8ca94cfb4fe..c30ef6958b97 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -34,8 +34,10 @@
>   #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
>   #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
>   
> -struct node_data *__node_data[MAX_NUMNODES];
> +struct pglist_data *node_data[MAX_NUMNODES];
> +EXPORT_SYMBOL(node_data);
>   
> +struct node_data *__node_data[MAX_NUMNODES];
>   EXPORT_SYMBOL(__node_data);
>   
>   static u64 gen_region_mask(void)
> @@ -361,6 +363,7 @@ static void __init node_mem_init(nasid_t node)
>   	 */
>   	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
>   	memset(__node_data[node], 0, PAGE_SIZE);
> +	node_data[node] = &__node_data[node]->pglist;
>   
>   	NODE_DATA(node)->node_start_pfn = start_pfn;
>   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;

I was assuming we could get rid of __node_data->pglist.

But now I am confused where that is actually set.

Anyhow

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


