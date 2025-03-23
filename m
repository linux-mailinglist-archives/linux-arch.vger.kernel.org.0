Return-Path: <linux-arch+bounces-11049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E3A6CFFB
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DA4168788
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7A5FDA7;
	Sun, 23 Mar 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT6Fwnkh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2D2BAF7;
	Sun, 23 Mar 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742746743; cv=none; b=CHHEVWzo9NQqDwYNwUFUH5muvfTwoTRxX5LjOWWzkTMMc+sYh8FghpdtZ2CRUWOKYPtQzE1/C2iagePveuNxILnWYVxMtNBAKNIgpqANOtNfuHTPK1GhuNI6ZZ7V7lx5J+FQoeQ1I8WqUnZiGWvUSBTHX44O0L8EGKDOC1g9NLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742746743; c=relaxed/simple;
	bh=xx+rvsZ74WKAsoxOH424X+Y+1Kp/fu/0+fzTOX3iuko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMXmJLV7pQ3K7Zf5VMJkR3MhSv4c6wXkIoVdVjCF8lceG/Ehygn6M9tpwiPwcmpmbhNuYR0vVS3IvdOk8XygIKz2QmPEw4mnZEk8lSoMVvn52CKrBBVAm7qelOwCVr7x0PuD5v7TW7xw6ACpexa9F9sebnz6z7dA+F3gBtbyHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT6Fwnkh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225477548e1so62786805ad.0;
        Sun, 23 Mar 2025 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742746741; x=1743351541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W8RJ8Z/RHpnWc3LGsmd97JoZyFLCP+Pu3qjQfO7gn9I=;
        b=TT6Fwnkh2dIp5mzmtLs0RLvPh6gadoh0od2pFElPrX5D12qc7auKrxkeI8jL3Qzoa/
         7VNjFXSI84KUpUZ0Q3n15dwqy2BwibSqWmNkfATrXhR7wP+cEy7HVBnyBzKIJWhXIV1T
         1mUTcu+VtDU2dV0c4Gdkv4IF+RYeX0k92sBgPAY829NPiBLhzjDw6pjl1x9bcRHQ2nVO
         IHzwDMPYmqcQ1Rg9nnYQN43ZmFsxezt0iPLp6B4syb1jud1fMT9FAl6xWRFnpY39yZAT
         /AYoI9PBXTlKYVZJythd9RQgzQSdBPAzIu6osMcqntucACG9crnN6hiGz6tHHrEBj4L5
         lLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742746741; x=1743351541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8RJ8Z/RHpnWc3LGsmd97JoZyFLCP+Pu3qjQfO7gn9I=;
        b=aFXyVQ3S1hKd3UrT78iS2IvkUqMAnVgPX3iERUT3eZfn5ZRix/34+PQHstosg7LQ+f
         03PRXIpKrXD1SWvGEdUW8HuLC66vjflbNuiPCFYPH2Q4kflvu9WNCaN8OPe974XYB3Ku
         WdjUEcjItrmHaD9V9hK5HhWMb98nOj165MO2628JurUCuxU1YhLgytzGANRZecB/PGM2
         MsKbRr2lizBNU5PuZg15zf1CeLDyn+WLXp1UxAveSnuwZnfb4QxU1/yP/bcnkM2xZeVt
         6WO/MUxXO9HSzCPu6a4ZkbGd/sNsoz2kVtns1V4fhjrkT98NTs55DbHJdXbqFmFA6DuL
         xuLg==
X-Forwarded-Encrypted: i=1; AJvYcCUQrRqA5RQa0yl1ED8Fx787cmd2+QsvJpkkH5SAAm0fluPlUnITrw7eeQb/7HMWvORDDq8A9i5kYVOS5QF5@vger.kernel.org, AJvYcCW5Hkj5C0v/4z0DAmCRW0dFFXkKxmLWRygO1UWftTWu4Zzhg5WEiX8t+bbPv+6TIrGdBKXdQLt41xp3@vger.kernel.org, AJvYcCWIXJ3YsjwKtlg++q8t2+Ysvic1en0meQAx6T44T2lnxT2RvdgJHc0hBZW/E/bCwAq/eN/WPt0ya+oMew9h@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxRrTwNoN59L7YO2hOu/wMIi1AH7I7RBDSw8JxpzjUxRlxslV
	UNJ/bhXGw0jUxs0RcVO5EqOMQ6jCChBA8kUFWLc0heYC1U3diB1kfCFFVg==
X-Gm-Gg: ASbGncvfwHMLbj9unjwetZKLE6ONM505svOz0MgVim09rZnXCZWgcPfH2tPC/veP9EB
	JyTpWpl8xusU35iHR5BLQWSFO+XY4s9SOTeYx5r3+1nFHCkAru33VPgpQWKVBW3+Ded+fuzitdd
	NJM2VMJis+dyMNwkfyJRmfPc3hqx1m7oPASI1q2q2Fx5MVJwbovFqEINALeJdfjOoTq/ML33DA9
	15GgzDjmZXGAFaphnPpWj3BAuw4sZvk4tLhEuEIuMm1lZ9yNNgX+MkFFi+CpTA1GFIJ0lxw1wSA
	ONYrLHr7onUNhN1V9bTZoG3xd99IlZD7A5yB4XdOnS8ki2pQbJsDvaBkwuQ9uQwgOR3HfkQ8Ps/
	602S82SFU1Tw3+GkylS3nZ4TNyFIL
X-Google-Smtp-Source: AGHT+IHo250qwi/lpasJeLUVqvJ1a8Gc4OglOyLVqF0R9kKJhzrb9+w7mS4jN+yzknNmRSCbqAhcAw==
X-Received: by 2002:a17:903:46c5:b0:224:191d:8a87 with SMTP id d9443c01a7336-22780d88c6cmr175299435ad.26.1742746740495;
        Sun, 23 Mar 2025 09:19:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da38asm53584125ad.186.2025.03.23.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 09:18:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22812c03-1b64-4e1c-b260-cddc14ea3e8f@roeck-us.net>
Date: Sun, 23 Mar 2025 09:18:58 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] lib/crc_kunit.c: add KUnit test suite for CRC
 library functions
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 Vinicius Peixoto <vpeixoto@lkcamp.dev>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20241202012056.209768-1-ebiggers@kernel.org>
 <20241202012056.209768-9-ebiggers@kernel.org>
 <389b899f-893c-4855-9e30-d8920a5d6f91@roeck-us.net>
 <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMj1kXHAktbQ-605wfqXCWtn8bP-yEv8sYKWAykajeAX2m1hEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/25 08:35, Ard Biesheuvel wrote:
[ ... ]
>> kernel_neon_end() calls local_bh_enable() which apparently conflicts with
>> the local_irq_disable() in above code.
>>
> 
> This seems to be an oversight on my part. Can you try the below please?
> 
> diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
> index 82191dbd7e78..56ddbd3c4997 100644
> --- a/arch/arm/include/asm/simd.h
> +++ b/arch/arm/include/asm/simd.h
> @@ -4,5 +4,6 @@
> 
>   static __must_check inline bool may_use_simd(void)
>   {
> -       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && !in_hardirq();
> +       return IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> +              !in_hardirq() && !irqs_disabled();
>   }
> 
Yes, that fixes the problem.

Thanks,
Guenter


