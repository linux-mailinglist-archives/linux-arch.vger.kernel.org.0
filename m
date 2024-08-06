Return-Path: <linux-arch+bounces-6046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E129490B3
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C6A1F2668D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963841D2799;
	Tue,  6 Aug 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Awnt9+49"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4B1D175E
	for <linux-arch@vger.kernel.org>; Tue,  6 Aug 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950068; cv=none; b=D++giQbsdVsMd71U1go3RN9VXRn+Q6XER38AYGsR+fxCmG1MoFA0Nzap7mRAF6H3Ia08sTIEZHVJMgi+kYgk5V0orE3UYTELKwn5WDtEWzkO1Ap+9SgMtGufV0XEx9OVcIBiI+5u+7M4goZHp0lWtW2gXTzUed8O3KhbUJ8EJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950068; c=relaxed/simple;
	bh=HPutb47YyXZlMnQyn2ng5tcedqjYDvOUbkJUxgrL7rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYodm5mVQEFA26cRGYoAuWRqpxyV3vgyi8o6oZlqyFWEwYOE234ehnijgi/CKXf9l7gtH1niA0a4qCe6YlWz9hOPiZ2T29IAm0MERYo4lyfbDgI/ibD77E6A3A6kCk/iAU3Mk5tcvpTDDm73bGGFLIEmbqyx7Pxe6lAfAFjq3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Awnt9+49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722950066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vXB9n6PIcxQrCckz5y40n2q02jNpo3OBG3jBfQzye5E=;
	b=Awnt9+492wCrmIyMN3T1vsvh57y5wN/fZ63Wa9kFGdUMSrxkAhZdTybrkprpg9QqIQCLuJ
	VPJMXiv/dXwvZ2qO2Y82OXv51cKTJNx33XNizLsE938dqfRbl9d/2cOAYeacokXzqhcq4O
	OCdcAFyL53vQF8axod2z8Sus+Z5OVwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-cgEu5F0nM_KpTpbxLSUamA-1; Tue, 06 Aug 2024 09:14:24 -0400
X-MC-Unique: cgEu5F0nM_KpTpbxLSUamA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36875698d0dso430585f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Aug 2024 06:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950063; x=1723554863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXB9n6PIcxQrCckz5y40n2q02jNpo3OBG3jBfQzye5E=;
        b=HjSepKK99GmmRbFPUR7rLCy/9GFzSmvZp0Z0jDqXbmcYamiKTNuJ6Q6TWJOwDXTSVr
         D88KmfAaSsA+gI1Wm9536lp1gDEm73sveZzoBESHHAWvEX4kedOH1I5A25hjmOBYF4LE
         mH18ZumipcEFnMdhysldLnBAEFOWRSMKg9DQA9l5QGijG2KbUJbDm9YF10IpUkcpxkZQ
         CuMrRufm0qnl257W//rVIYyQAN2UY9k9ZNaL9LHrl8sDu/kRf02qn8gybBPStRjsoIFZ
         MrdKualFykZILRRxy7ZmaFryBjAODCn4YC27QR+oy6eAw6891DLjtsbbOrtiyzKtj/Nw
         ejCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+JW1V3YvuqbvrUFV0DStiTxFDEudkThpju5QxUjjG7Aw3bOaUfk+zB3J7o6cbqBRonmk0lY/EWd5C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vXmV0LyZ+g7EA10CLI6BlXRzt6Lb4oC79a+OJgzORDZs8voy
	ErY9hMtfuaOHoIIR55q61g719ifNx3vcXMr+09iP4AFjkcel9u2mS8d4jP3zF3pVrAwgtcstURM
	C1C2IAcUt8VcopZsJWYhpTmqAiNTt4114l7FztcOmVq8vBvYmSwKaN97h25A=
X-Received: by 2002:adf:a3d7:0:b0:368:4bc0:9210 with SMTP id ffacd0b85a97d-36bbc0ca7a6mr8742106f8f.25.1722950063189;
        Tue, 06 Aug 2024 06:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2kT3/Xi0cEGU+HkQRL1WChzAHxB3PhEUEr4okI+OvO3nyCFXV5GtBuMTDD0u+LHyFMqdaiQ==
X-Received: by 2002:adf:a3d7:0:b0:368:4bc0:9210 with SMTP id ffacd0b85a97d-36bbc0ca7a6mr8742068f8f.25.1722950062633;
        Tue, 06 Aug 2024 06:14:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c314sm12822253f8f.12.2024.08.06.06.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:14:22 -0700 (PDT)
Message-ID: <492667ab-81ad-468c-a615-babc4aea4131@redhat.com>
Date: Tue, 6 Aug 2024 15:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/26] x86/numa_emu: use a helper function to get
 MAX_DMA32_PFN
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso
 <dave@stgolabs.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will@kernel.org>, Zi Yan <ziy@nvidia.com>,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, nvdimm@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-16-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240801060826.559858-16-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 08:08, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> This is required to make numa emulation code architecture independent so
> that it can be moved to generic code in following commits.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> ---
>   arch/x86/include/asm/numa.h  | 1 +
>   arch/x86/mm/numa.c           | 5 +++++
>   arch/x86/mm/numa_emulation.c | 4 ++--
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index 7017d540894a..b22c85c1ef18 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -74,6 +74,7 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enable);
>   int numa_emu_cmdline(char *str);
>   void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
>   					unsigned int nr_emu_nids);
> +u64 __init numa_emu_dma_end(void);
>   #else /* CONFIG_NUMA_EMU */
>   static inline int numa_emu_cmdline(char *str)
>   {
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 9180d524cfe4..8b7c6580d268 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -868,6 +868,11 @@ void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
>   		__apicid_to_node[i] = j < nr_emu_nids ? j : 0;
>   	}
>   }
> +
> +u64 __init numa_emu_dma_end(void)
> +{
> +	return PFN_PHYS(MAX_DMA32_PFN);
> +}

Inline function in header?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


