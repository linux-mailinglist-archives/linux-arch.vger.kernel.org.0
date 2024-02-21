Return-Path: <linux-arch+bounces-2607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DEB85E74C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F7F1F23BB8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731F86122;
	Wed, 21 Feb 2024 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQYH7P0o"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3A85950
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543861; cv=none; b=nEBjeOiQOnLDfXxTJIHIx5QFAh91KwnRylozWa9K31HcOaSizVOAU/4QQ49Ea5cOjmZ9THiCN9rODd2DVnyXEi2rVBRP2vA/QVCV2b1IY4rfiIKgIFq5h7w4sT9zIbaRdzdmbx0mt2KpTOr/LJ1brzmZ9k4k/tRumWV743m3x/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543861; c=relaxed/simple;
	bh=n8rm99TQBU0HI9VQaP2Yzv/1b/39idLuaopiNlQpNCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXPyljt1ugRaLr3M19QBjW6RFQ/NI4weCMoTX5xF948Bk7uImQJQS2cQx9jTJnPSXQ2psM7W9aboiU8RQrfCpau1mnZ4nbTCRKd/zCioaD1gM87vftEg52iuJr489Fl6KbRVyk3ljKxPauXqgObvi4W0BFfPZ78Mr6LpZ1hYSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQYH7P0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708543858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e92swIaUqEXhIB7gf6Yq/Avzv/ncoPBOXFnJskwAgWg=;
	b=PQYH7P0or7DfG4bx7ZAL1f9mem5oDZ6CS7e0vtIAjUbJ2SeI+mMuS3EsvBLI9c3/jXGxin
	hKDsw9eu5YqNTyX77dJRTRiDtIU6kf2iLZlnpQhQyx8x2gNkm8AKr9LcJ+hWJyzzV0G7pg
	wcV+ektqRD8M6vzdSb0lAwHhyP85c90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-JJWalnHZNciF0GKIToT-Rw-1; Wed, 21 Feb 2024 14:30:57 -0500
X-MC-Unique: JJWalnHZNciF0GKIToT-Rw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4127eafcdc8so92515e9.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543855; x=1709148655;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e92swIaUqEXhIB7gf6Yq/Avzv/ncoPBOXFnJskwAgWg=;
        b=Bbnd8a9rdJb4/xQVI3EH01Ee0YsKUkjZC0ZK7hl+7jx23rYv85XG/tKCsbwkiHaFVi
         Tgp0NzJMq0ObBkMq9CkEol2bdKUM9P6X43oX7uf1mPl+nyG+b49EQ9WJvEYVt1/2KXWU
         +rY2dn5YS6MSZc3SDEmaGkHTNVYZvzNrQ5Y37LPRZSFFeHosI45SC3x69FW8u68DjfWz
         yn5UiDMNEnhRGdbEFsnmM3+2BgQBLgX6LCH+JA34McF8yJiJcxqva4pu31KwpzXF9A5p
         nMkDaLqNjco/H/ltxaoOcTD15G8U76lsbhvygi0YH55GCpVCNaxH4dn7VStYRSEZovtQ
         ujjg==
X-Forwarded-Encrypted: i=1; AJvYcCX5JqEm8rMAWXUCiBhKq1fpI/b0V8PcbVR4u+iZB3hajC0bg/ZAM5qHaq+dFDTReCKnjBD+9Sx6wjCD0UT8Spjnvl2viPfD/SJhIQ==
X-Gm-Message-State: AOJu0YxaGGPZMkhypOCmHpCeZTsewNBp37TQKsnLKNOBQgSpL+9Fnptu
	roKTi9NKmBrrTL+Cj1nKJkf0yjEPulfRdt2y+FbpyXNbpKEVmEV/mYwL7icQWU4dorNcPgzlR6G
	+jjChR/YgQ4ac0zDrYzxHlEL3ewhEnGqKCYRPWB/6h2FLE0nxoOB05PkYeUQ=
X-Received: by 2002:a05:600c:3b9d:b0:412:6ea6:8206 with SMTP id n29-20020a05600c3b9d00b004126ea68206mr3882410wms.3.1708543855645;
        Wed, 21 Feb 2024 11:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6JyNCqtS4prmjexnVFCpGuUHYuxVCVVfbgiUensLVbTQNTKifSwoaAOzgWz/I+um13e3+jA==
X-Received: by 2002:a05:600c:3b9d:b0:412:6ea6:8206 with SMTP id n29-20020a05600c3b9d00b004126ea68206mr3882402wms.3.1708543855277;
        Wed, 21 Feb 2024 11:30:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:4200:ef82:84d2:3d2d:f069? (p200300cbc70b4200ef8284d23d2df069.dip0.t-ipconnect.de. [2003:cb:c70b:4200:ef82:84d2:3d2d:f069])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033cdbe335bcsm17888920wrm.71.2024.02.21.11.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:30:54 -0800 (PST)
Message-ID: <edebfa0b-7955-41c0-89d2-8a86fd3d0c55@redhat.com>
Date: Wed, 21 Feb 2024 20:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mmu_gather: change __tlb_remove_tlb_entry() to an
 inline function
To: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240221154549.2026073-1-arnd@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240221154549.2026073-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.24 16:45, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 

Hi Arnd,

> clang complains about tlb_remove_tlb_entries() not using the 'ptep' variable
> when __tlb_remove_tlb_entry() is an empty macro:
> 
> include/asm-generic/tlb.h:627:10: error: parameter 'ptep' set but not used [-Werror,-Wunused-but-set-parameter]
> 
> Change it to an equivalent inline function that avoids the warning since
> the compiler can see how the variable gets passed into it.
> 

Ugh, quite an annoying clang behavior in this particular case. I wonder 
why no build bot complained so far.

Thanks!

> Fixes: 66958b447695 ("mm/mmu_gather: add tlb_remove_tlb_entries()")

That commit id is not stable yet. So Andrew might want to fold it into 
that commit before moving it to mm-stable.


-- 
Cheers,

David / dhildenb


