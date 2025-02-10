Return-Path: <linux-arch+bounces-10073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F12A2E5A7
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 08:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C23A82AC
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED0A1B6CE9;
	Mon, 10 Feb 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hEHhEnub"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3A1B424F
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173363; cv=none; b=rysQW5yht2pNFT4q5GqgV4SjyFpURmeIW4FF6DzvhNwbmycdhhQdyhS5vxN1WdgzbkA/QzH0j7iiPJ0RDURhZPzPGlAME0zY71slPIjDkezdRCqDF16z2CreJv/1Rpu2kvqiHNE4QkmRc10On+KVNCa96OBpvhZyiNj2H3cnURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173363; c=relaxed/simple;
	bh=uELykYu2UfnPFrcbXaL5ytU50E2XF8fxhOESv8wBqLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u75FGHT8xQs63vKlDc01pi+AFRqcz2jhRLpxH4nQdL60617kovyGxYR771tKeRcllFyjj4ci1927fjcPQ35BicvyDWVNxNeG6whlytXo4ZcP4ULBN7HNYdQQ402bgfbfLwrGifFKjOTO8G/AdJBUfU6ZdmuCyn5XdTKNX/MhqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hEHhEnub; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so5024545e9.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Feb 2025 23:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739173360; x=1739778160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jki0b2am8yzlz3QyhCDEFnMh6r+K6Xff5FC3zmcGxIQ=;
        b=hEHhEnub9vJ60lxT2vbKKBzRLmTMTfzEohjaxyIuLzLiow2SvvpkSatF4AZQxAJjnt
         GldSg7omHp61iZ44O1NoCTj6O106Fa44wXsTEgwrO3V6PzE0XKFkh6b/1ZhCnDiUMPLD
         iwdjtrUpH14ypIzDoUIvMM99VMZk3yMbhrAuLsSxv/dZnbni6dapXkUUVW/cIaTFVxpU
         G5YOpqgvdH6tvuTG1XbLoQT9/+QjN8WaQ3SBagZb0OxHRyre8cxLMu7PshbV34ULqsvb
         gv/zLIyYV/g09f6i49Cxt3Z9AKBh7vYEdtAS2ASA6AqW2u06PJmqX7yjLhHIybimdYpn
         yLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173360; x=1739778160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jki0b2am8yzlz3QyhCDEFnMh6r+K6Xff5FC3zmcGxIQ=;
        b=B+bQqY8YX42WIDbDx5f/iLr/8bX+0anLfALFUh7ucAfRN50vGGjUSGnU8ckyDEL1lB
         VU0G64U7nezkXnW/YuNt11lTjtX+wwMGA9nAvJ057jyVt0tgtDHWZg3o9Viymg3yFnR0
         X6ZNukAjar6ROSKJ+8OToVnOEEtjuzsa4grLcptd8zZ57MNUJx7dXQGzTAtrUJk4lj3b
         mKOdBGXlkfnJ4QjV/vMIjJZf76iHr+91PMmwjHVzOqCFSJHMgyNcwEh1OnJVJufitYL+
         9Ocn6xG6ImFbl6nPsfDCJ5JYBlic6/C3sZfQ13FN2JS2r8NFAyQxz0EGvQ+gUx2ZxhVW
         fhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3kJh6tu9eaWrPIJTI3GihyRex/Y463E6M1dPWOicg8zszeqwX/KsvCjMT8eSuKdmbIKyaHAT5xTlM@vger.kernel.org
X-Gm-Message-State: AOJu0YzU51YXoYR4rfhd58jV33WDDoYrUW5z6hKd+z+p9AhImsLksSFP
	YOC1mKTeS9qaRD+NYTGT4/38L2AafrfrhzSkDI2s5D8GHkdZnUcmOLh3VlAd+QU=
X-Gm-Gg: ASbGnct7Ae2DX+krgzqkDpb4KRMy8ULEjb4CGvqsJZntYPSLUyuE8n63gziGoQcU4Ik
	SwDLaoYkCxBJ570/PgAWQgSN+gkAr4oHDeQAOoaJ7UMIvmpMOIjc7pqJ3FMRsO7uScc3dXuIasg
	njmMRQJH/qKwZovqacvxBtLBIR69E7ivqrtwmk5dm06hQLL5JWIvrski/CterbaBuOYcw5NMUJg
	23u9wyWL/p07f9+2cwB0gfm/VYV3jkUgt8/XATgLhSM1TkTrYLQafFiiXnn7O1vXrPva2qFP+3G
	6StKq37OPp1SND1JdxiG14sTr3IjypPOVW85jxs+9Z8USwiE2sHslrOe/CGs
X-Google-Smtp-Source: AGHT+IF39BdEkA9ZgcBIHbLRArZRwyqYfhbYwkkcPtQvR89C0KQhk8Xnq25iZkfcHIflDsp+ppJQFw==
X-Received: by 2002:a5d:47ad:0:b0:38b:d7c3:3768 with SMTP id ffacd0b85a97d-38dc90fdb89mr7501603f8f.12.1739173359748;
        Sun, 09 Feb 2025 23:42:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d896d70sm171375435e9.0.2025.02.09.23.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 23:42:38 -0800 (PST)
Message-ID: <4320b0be-acce-43b2-b148-1577c6a56dff@rivosinc.com>
Date: Mon, 10 Feb 2025 08:42:34 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/26] riscv/traps: Introduce software check exception
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, alexghiti@rivosinc.com,
 samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-14-b37a49c5205c@rivosinc.com>
 <fec3b7be-4259-4eef-87f9-b2cee5718cae@rivosinc.com>
 <Z6Z6mhiQ3DmsNZe9@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Z6Z6mhiQ3DmsNZe9@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/02/2025 22:26, Deepak Gupta wrote:
> Hi Clement,
> 
> Thanks for looking at it. Inline
> On Thu, Feb 06, 2025 at 02:49:09PM +0100, Clément Léger wrote:
>>
>>
>> On 05/02/2025 02:22, Deepak Gupta wrote:
>>> zicfiss / zicfilp introduces a new exception to priv isa `software check
>>> exception` with cause code = 18. This patch implements software check
>>> exception.
>>
>> Hey Deepak,
>>
>> While not directly related to this patch, is the exception 18 delegation
>> documented in the SBI doc ? I mean, should we specify that it is always
>> delegated when implementing FWFT LANDING_PAD/SHADOW_STACK ?
> 
> I don't think it's document in SBI spec anywhere. Should it be ?

That's a good question ! I don't know the process to document that part
of the SBI but that would probably be nice to document it anyway I
guess. Atish may know what to do with that.

Clément

> 
> 
> In code, opensbi delegates the exception (SW_CHECK)
> https://github.com/riscv-software-src/opensbi/
> commit/110524441a827e026db3547ed03c5723b9c9e211
> 
>>
>> Thanks,
>>
>> Clément
>>
>>>


