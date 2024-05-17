Return-Path: <linux-arch+bounces-4460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16378C89CC
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 18:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC02EB225DC
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751412F5AD;
	Fri, 17 May 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzY46KJ2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0A2EAE1;
	Fri, 17 May 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962189; cv=none; b=acPGVc2me7c9+7EKOs6WvsCqzQV/9Ya6YyfrqUu3lG+umJ3s9UUruqo8NGEty4SyQOSg+0TCV5TKoiUT5USfExJV6YRipBACNog3u3VCy7nm5Arqlq7BdHO8x9GSelwxa2G7YvJmEPmNHSLMnqOocKD9cR9z4u6pYulZxl5hnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962189; c=relaxed/simple;
	bh=Nf4RNkeImLEAmR+itasCgmxOOOn/nmm3CPvksEHRQiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/4D3wXVH3g7ZYzav0YUFeSkZyznpy4HASdZk+nRjeNipuuqOTdl4XBGZJwgqz5DJv+cWXCy4YJfsZ1gjMv258XOPdBFYPU1XQ+nbb2OHQJWFT+CBMBCicPFMyKviNld8BLIjBKDTDpbx7WngkH08lVlBjOFm7itTrTYQQvykac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzY46KJ2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so11564841fa.3;
        Fri, 17 May 2024 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715962186; x=1716566986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IstAfylTBNaTxmmaRyk4imp16sEYUHGaznoMjv7UZHs=;
        b=gzY46KJ24SqO952EeXZ1ZO64bPCcjC9ww5yqMYdkda2VCXqZ1BHujAjp48nLIIhP+S
         cT2FibLbWOCcbAhe8wD3crfcaviP0/zRZ0+5bs/6JiMQuG/Mm20itWyTvIQvzY6+Dv3X
         mVYiRewPhKc3UO/H0zDT1uzxqM1GzZ6WFT8uWdUxhjOC0j1zyuLVpQEXUAds8Ll8SBDR
         2vaUVuPdVRMjfp+cGKOXGirmJAWaP00pVr9bE8jAxG+UVkMd4K1xyMzGy9vD2fh0ubz/
         Hh62aMMN+izN0mgiwBL1BNy4ecDGxBLvL+wc++odjdJ+dGXHRMjUn+ySqQY3LKvMmAle
         8vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715962186; x=1716566986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IstAfylTBNaTxmmaRyk4imp16sEYUHGaznoMjv7UZHs=;
        b=U23BflJQlQ2SGJx6BVQqRxoFzFWgcmhTqIm1wSvgx3EyT3hwUs2+5BGBwZNKB7kere
         MoeIJ946/NxmLgjRu3LL8wV2uecsu37yvbcF6GGWVRtFIc3iEoXeZuqTLXtT6XP30GhO
         9pr1lnw7TPURUUP7nhr6sUiPYcYHTBst/pfXzMJUF+WDjaFo7KAx7CEItwyXwG60rhRz
         LQU8wait7HO3oaeXn9gt+F3SZItVu6J7zzvGwC6xDdqavqJ0qT0PTVYPrwNXaz1y5FU2
         oK6FfLTOVtxcpBkNxrZ+BCGko7ppZQnA3BOeia8I6Kkc+RUtXSiJdb/4S4Mu2NRRZHaP
         S/4A==
X-Forwarded-Encrypted: i=1; AJvYcCVzrSMCrjLxH+iRV0A35S2goPPB7Ob/Ks0PtFJEQluR3WUOaZ0wAYAojqCSrw8LUSgND8nWjrVyAC0iudBvgq6lu30F+E3jX21QEK8DdPIglEJt5keV3Aj39yBeuqAqo5/dktfEo7vyZFtjosNlbp/kPvsf/EczQHymfiMM66snE7D2egW8Qqm+D07E2Yz9JkiOIk4NL421Xz+mmp4nGlAkQr4IHxjjfHlyM7XPbz2gMw5tWwvtp4+AB4q7qhgLjkxwQFFFL6VKautv5puOPnvg3f3l8FEjWH8PXei73VlCeADJcTqi6Tj9RYW5msNrhPedxvJu5x/U6bjMnK+ZwTxt8R0tsLrwcuNs9Wc6ctG72lMZXsXr1s9S0c67BGUm/qFAjrXMxcPlqFMC0+mFcY/VhsCtMc9EWF2OV+OeDoCnN1jmwBZ9izYEcKY=
X-Gm-Message-State: AOJu0Yx1QqQpPvKlKY35dejdl+ioSYdJ8e3F1ggS4wOeT4PT6j9KumUx
	JijzxMan+uhxZgF5wivoX6We58viImiA10v2lncSfF0OabKe5kks
X-Google-Smtp-Source: AGHT+IHgmwwit2WhgD28ItKwKm0UGYj6mPQDthm9VUXNUEsMkvdnQLGvWiUajRHCK+r/d8TH466Lzg==
X-Received: by 2002:ac2:54b9:0:b0:51f:d72:cd2d with SMTP id 2adb3069b0e04-5220fc7aeb4mr13493469e87.22.1715962185544;
        Fri, 17 May 2024 09:09:45 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d7ee4sm3314135e87.182.2024.05.17.09.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 09:09:45 -0700 (PDT)
Message-ID: <170eca58-8950-40b5-b2af-3ac3844af3aa@gmail.com>
Date: Fri, 17 May 2024 18:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 16/16] bpf: remove CONFIG_BPF_JIT dependency on
 CONFIG_MODULES of
To: Will Deacon <will@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, Liviu Dudau
 <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit <nadav.amit@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Russell King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
 Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20240505160628.2323363-1-rppt@kernel.org>
 <20240505160628.2323363-17-rppt@kernel.org>
 <7983fbbf-0127-457c-9394-8d6e4299c685@gmail.com>
 <20240517154632.GA320@willie-the-truck>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240517154632.GA320@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-17 17:46, Will Deacon wrote:
> Hi Klara,
> 
> On Fri, May 17, 2024 at 01:00:31AM +0200, Klara Modin wrote:
>>
>> This does not seem to work entirely. If build with BPF_JIT without module
>> support for my Raspberry Pi 3 B I get warnings in my kernel log (easiest way
>> to trigger it seems to be trying to ssh into it, which fails).
> 
> Thanks for the report. I was able to reproduce this using QEMU and it
> looks like the problem is because bpf_arch_text_copy() silently fails
> to write to the read-only area as a result of patch_map() faulting and
> the resulting -EFAULT being chucked away.
> 
> Please can you try the diff below?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 255534930368..94b9fea65aca 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -36,7 +36,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
>   
>          if (image)
>                  page = phys_to_page(__pa_symbol(addr));
> -       else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> +       else if (IS_ENABLED(CONFIG_EXECMEM))
>                  page = vmalloc_to_page(addr);
>          else
>                  return addr;
> 

This seems to work from my short testing.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

