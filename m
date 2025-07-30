Return-Path: <linux-arch+bounces-12985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EBB161FF
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49CB1899D0C
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E12D9780;
	Wed, 30 Jul 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4D8eQXA"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76112D8DD0
	for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883730; cv=none; b=KzI5Ecv01A9VpzmiQK9pV+Ec0MeBQQKYsQpL/iIa8OzMbPC3suKhFxyAUNGBbm9WGWbTJ0YmSw1mY0KJ5NN1mwqtfHQYpP4urupJ4NGgL0bki6SoiuCqw/bmFriU4+rFWuG3j2HgC6gxkTXDcmPyMJjsCOoM3AoqG7ZZvb/TTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883730; c=relaxed/simple;
	bh=03dvLXzJnjJL/BzSORv5mrGgeHu9RiQtwL9YnjAKfQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tesI5+agdNcH4FEqCrwXtYSYdI73jUi5hGJss5r8MNtJa+36YqiaoLBcThd3n5iXV7Obc6O/u9PqxTE3RBYbT3q/norE3KZaOaKCrwfRmlM4QOINm18sigFtmg6K9qpmfxQhskv6aBTbVfosLb0wNNryPR3BkOCQTOC2UN46Skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4D8eQXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753883727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3VcFQqoev4ndFVh1DgWdnNI6LwW73kLIz7RUlLHtApU=;
	b=U4D8eQXA+5wuPHvqhTS/DElTxJb5SXU6AfRUn+4VEWgSUlULNE0DNEbTLXvDGBlLex0u2A
	vLlZ4YGleS7WkEKJD6ERsdKOUIXqM2ALqE+DL0lWroyURD9blrIRlXIG52lYYh+AZWrJKd
	agq4jY8v8Ve2jUrRzByL9YpwHrEPYAI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-ZjOajLvsPDmLKtrSyzvQUA-1; Wed, 30 Jul 2025 09:55:26 -0400
X-MC-Unique: ZjOajLvsPDmLKtrSyzvQUA-1
X-Mimecast-MFC-AGG-ID: ZjOajLvsPDmLKtrSyzvQUA_1753883725
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af8fe47fb7eso87674766b.2
        for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 06:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883725; x=1754488525;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VcFQqoev4ndFVh1DgWdnNI6LwW73kLIz7RUlLHtApU=;
        b=t1HCoz5VD33dHD6JBGhknWdgefKUAN1oKOL3Qs/KRU90DOMjn37Ld7oVsAmJI4iMft
         3YkPbvGkocSJe8N357hl97GGFiJAaDXBmCGWVJo5SfEJ/zBQDiU2i/uUAz8j1Edm8Orh
         Qv6n1vI9d8h2GXo7RFLuGZBJEPvnJq9ijdZgo1udSMMeeK7H2f4WZ6bW0as2BFBeNRhv
         901bGQSfco1dzNteu+fhSol3pBN19c/BaiUeRtLKIQ7mLox9cgRXPixZiQ0U9PVUw6mf
         M1PMD1MsKtIsS2eOF3JZGw5zpOx6VxT8Pjg81XjX7cNMWs8KQUI4/jdM1hr+K+tftNh8
         8rHg==
X-Forwarded-Encrypted: i=1; AJvYcCVb2zixwbJetRORcrSWEzrFEtLJsUZyUSQrI1wQj4nAUKmtoLVQ71bbH5xEUsYPMF2XTc0I5fVb7Ry8@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwR481mjh8BP70rfXa130s4C/zYa+haXlH71VFhe7rnQUIZCS
	BuCbp6RnUX9um2vvY+5TE+vTZ8dstv/eIiZd6WcxkiZpoQYx20twdJT17paYmRDLCx5YNzlCiKp
	vXy/+r+OoX0ikW0Vu6iJmYNWJ0gkhu4mxRSW4yMmjUuiu+4kM3YZiigObHU9fpjA=
X-Gm-Gg: ASbGncuDYX1wlxRBo+OU3bL3SrJx5hG31XlN9InrEWV8KfGQzcBEIc1FJuEiYTm1pmW
	LSdso7gVAOaAzKKDQMaVTriVHh4Hcn3GS5+nQ5qUTcaE/sNH9hF81gub30LrhKiv3gcSNaMyzEu
	9PFDX2t6SDSvGg+tXohB8z5nYtDkQGuHAV2Aa8TiUEfvHjZaDHZl+HfknYLf2F7j5QymU7DUsbI
	QHkKLDrYXCfW/f7Pz3dH6W9v0mXitoKz0mZH/deDKW5DhkvpSGUjN+4xWF1cPaRtd4d8ughonfQ
	nwzI0nzL86c8L++aKnZ7pYpRM8hnXkp9/qNvB88azP45btt3BPnor1icPw7uvA==
X-Received: by 2002:a17:907:3f16:b0:ada:4b3c:ea81 with SMTP id a640c23a62f3a-af8fd957532mr381802466b.39.1753883724938;
        Wed, 30 Jul 2025 06:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnFvdC4+f6/eJenyOa18wsoa3h5I67gwGBhJ32KqQ2TAENVXY/DrKoXNbTnHSurkHrTJi8SA==
X-Received: by 2002:a17:907:3f16:b0:ada:4b3c:ea81 with SMTP id a640c23a62f3a-af8fd957532mr381798266b.39.1753883724471;
        Wed, 30 Jul 2025 06:55:24 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585fff3sm750425466b.21.2025.07.30.06.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:55:23 -0700 (PDT)
Message-ID: <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Date: Wed, 30 Jul 2025 15:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information
 into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-17-eugen.hristev@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724135512.518487-17-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 15:54, Eugen Hristev wrote:
> Annotate vital static information into kmemdump:
>   - _totalram_pages
> 
> Information on these variables is stored into dedicated kmemdump section.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>   mm/show_mem.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 41999e94a56d..93a5dc041ae1 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -14,12 +14,14 @@
>   #include <linux/mmzone.h>
>   #include <linux/swap.h>
>   #include <linux/vmstat.h>
> +#include <linux/kmemdump.h>
>   
>   #include "internal.h"
>   #include "swap.h"
>   
>   atomic_long_t _totalram_pages __read_mostly;
>   EXPORT_SYMBOL(_totalram_pages);
> +KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));

Tagging these variables that way is really rather ... controversial.

As these are exported globals, isn't there a way to have a list of what 
to include and what not somewhere else?

Not sure if any of that would win a beauty price, though.

-- 
Cheers,

David / dhildenb


