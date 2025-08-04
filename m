Return-Path: <linux-arch+bounces-13024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43878B19B3B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 08:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8E8188D447
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE12236F7;
	Mon,  4 Aug 2025 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsE0Ub23"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D528371
	for <linux-arch@vger.kernel.org>; Mon,  4 Aug 2025 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287328; cv=none; b=q56j7g1u3xDCnsbFFsvBHuTNLnpSJJLWes3HoC55lk61hkI7RzpH8/gcmj6kDKUDPEHU5KiamGVvo24x53ucPKWlToex9Ejy84oRWr/TK4a3pneFnwuV+dptFGS0xgv3JeP93PfzIvlHLzcSspPclyu7/XI7JbvQOM1m1mPT5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287328; c=relaxed/simple;
	bh=KMBl5cETYacFC2LqqdLO4JBKck38P6h1v/keks1Lous=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQWcBrKuhm95twZiAwwphYIgXZysgLntTNnn0TsGgwsNUiYhuhX5zguMQTyaY6LH7PWeO/ylLu5RtW+HTW1EWN+YwhbAV1PMYN2++D0t+PmQ8s5FF23jzomvtnqXQWVIXOwQIA/KEXK9a8EH+wIeNGkPkSP10APxUUgPnS5/gCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsE0Ub23; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754287325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vLIrdWw8oN7dfx3cTZ5HSnDeQakkB5ZepQhkEnhTNlA=;
	b=SsE0Ub23mnIVVqdQ8q5X/JMxlWgNw4GczxfzE6yf+ZqqteY26RgMZNU3BWh/bqNywSYSJF
	NFOeALXouCKxW7u+s9ei/d68wBhViYbASScf2iLywbBaNh4Dt/hTkXyFfv6YX7AJjZWo12
	zYmUAx4i87l8rzNnTbvxS8NtJ2/TEPw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-rj5LKolmMmOwMrh7JIrPSg-1; Mon, 04 Aug 2025 02:02:01 -0400
X-MC-Unique: rj5LKolmMmOwMrh7JIrPSg-1
X-Mimecast-MFC-AGG-ID: rj5LKolmMmOwMrh7JIrPSg_1754287321
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e6857795eeso845084185a.3
        for <linux-arch@vger.kernel.org>; Sun, 03 Aug 2025 23:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287321; x=1754892121;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLIrdWw8oN7dfx3cTZ5HSnDeQakkB5ZepQhkEnhTNlA=;
        b=NO+2OrMomd/QYlP7/EZhQB//vkfGr4Bh7OcVXrSwN0SPYzW3tMQWelGr386JrcEIOD
         PloP/cQUhU7xY0Ow3XArwu8lD7dL6mr3DWr9PkNNsSjCfmTqHtmc5zvYMn/x4xi+EVTC
         9xvk9FHzrFM/Y7oORxHuBEtmpt+2dde4S8TTwa0xYziVMWRLoinfBBC+3QzrK3pfNVGm
         vtjCv17sMqh7EEm4VCNYFVu5B1fvNJCwh2C2zHIh8P2Vxe3RNkSBQ3ojxIn90RARzqxI
         GCzCmLPUxzw9e+cSuVXhTRjIxffBZnmFu175lXZsglOhkvB5dZmy1ZxPzgTaErpRtgSs
         Rfkw==
X-Forwarded-Encrypted: i=1; AJvYcCVrvG7eIzmr+eI0Cf78c5TsepVplwhFRykbyxZs9bcmdh3J+MVwuLeIfqLgnmEENzzyGuLmqLyltqqY@vger.kernel.org
X-Gm-Message-State: AOJu0YwL//c/PVXaRdyC8yWmWY5Ey7IJ5bWhWMvKCV4Yf4pV5IXaxj3B
	GSfPlco2aMCEmfhH4KVf+0uZDbd8Iq0d86KFfs3VOVkNWfB6h8XLrTWxA4yTa+tmVOVygFWek90
	ezCNKum91boueAHsx0Eb6hRXyz5l4e6Uv205A9CILM4nDDWNg+hkPLcoC+B62zo8fh00xb0o=
X-Gm-Gg: ASbGncvcSO3t6GbWGFgYwQlFsNj6y0tjiJ3Rs1Qpxxe/clzHoNsNalyxxrNwtnMp0H4
	RP2ujVcz7c602RUWNr6gaQ9gADfXxjoJ+mespZccTBPW9rILjrFyzTWfPMmRj94HXw2xS6skVG+
	YoL7DhD7KU1IZogJY5qsgyOdguTQg6ozjyXE9C/hjBmXcQdejZ5ylDlIBm9BIB7D5vE4T4XZ5hA
	FxI3SjWIh7b/snpYdaNBz3ngtRIwNELJjLd347jBTCFNBCn2Ctd4Gt+luMznwQfb1PhKf9Q+lky
	CZVGidX23P8p7OjVm3x0kiZoNohYGR3sdMmRXvk+RjTwhw+Xt8Dd/v+Q3UahrOjdqUtXtTMcpAg
	2UP0=
X-Received: by 2002:a05:620a:170f:b0:7e6:98be:ee33 with SMTP id af79cd13be357-7e698beef16mr1090099485a.14.1754287320747;
        Sun, 03 Aug 2025 23:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCpcZa4mW7/9f/KvcAzgEBAsyfJP76Jklr8rh6ncLExIaCZlOHzu5wcDmMOLVFqz7NKYlH2A==
X-Received: by 2002:a05:620a:170f:b0:7e6:98be:ee33 with SMTP id af79cd13be357-7e698beef16mr1090094585a.14.1754287320202;
        Sun, 03 Aug 2025 23:02:00 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-086.pools.arcor-ip.net. [47.64.114.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5943f5sm507610085a.3.2025.08.03.23.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 23:01:59 -0700 (PDT)
Message-ID: <810a8ec4-e416-42b6-97bf-8a56f41deea1@redhat.com>
Date: Mon, 4 Aug 2025 08:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-35-thuth@redhat.com>
 <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2025 15.33, John Paul Adrian Glaubitz wrote:
> Hi Thomas,
> 
> On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
>> While the GCC and Clang compilers already define __ASSEMBLER__
>> automatically when compiling assembly code, __ASSEMBLY__ is a
>> macro that only gets defined by the Makefiles in the kernel.
>> This can be very confusing when switching between userspace
>> and kernelspace coding, or when dealing with uapi headers that
>> rather should use __ASSEMBLER__ instead. So let's standardize on
>> the __ASSEMBLER__ macro that is provided by the compilers now.
>>
>> This is a completely mechanical patch (done with a simple "sed -i"
>> statement).
...
> This causes the kernel build to fail:
> 
>    CC [M]  drivers/gpu/drm/nouveau/nv04_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv10_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv17_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv50_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
>    LD [M]  drivers/gpu/drm/nouveau/nouveau.o
>    AR      drivers/gpu/built-in.a
>    AR      drivers/built-in.a
> make: *** [Makefile:2026: .] Error 2
> glaubitz@node54:/data/home/glaubitz/linux> make
>    CALL    scripts/checksyscalls.sh
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>    AS      arch/sparc/kernel/head_64.o
> ./arch/sparc/include/uapi/asm/ptrace.h: Assembler messages:
> ./arch/sparc/include/uapi/asm/ptrace.h:22: Error: Unknown opcode: `struct'
> ./arch/sparc/include/uapi/asm/ptrace.h:23: Error: Unknown opcode: `unsigned'
[...]

D'oh! I guess it's because sparc is using "asflags-y := -ansi" in it's 
Makefiles ? -ansi seems to change the behavior of the compiler so that 
__ASSEMBLER__ does not get defined anymore :-(

Do you know why sparc uses "-ansi" for the assembler files? I just tried to 
install the latest sparc64-linux-gnu-gcc on Fedora 42, and when I try to 
compile the kernel with that one, I even get earlier errors related to that 
flag:

   AS      arch/sparc/kernel/head_64.o
In file included from ./include/linux/atomic.h:80,
                  from ./include/asm-generic/bitops/lock.h:5,
                  from ./arch/sparc/include/asm/bitops_64.h:52,
                  from ./arch/sparc/include/asm/bitops.h:5,
                  from ./include/linux/bitops.h:67,
                  from ./include/linux/log2.h:12,
                  from ./include/asm-generic/getorder.h:8,
                  from ./arch/sparc/include/asm/page_64.h:158,
                  from ./arch/sparc/include/asm/page.h:6,
                  from ./arch/sparc/include/asm/pgtable_64.h:23,
                  from ./arch/sparc/include/asm/pgtable.h:5,
                  from ./include/linux/pgtable.h:6,
                  from arch/sparc/kernel/head_64.S:16:
./include/linux/atomic/atomic-arch-fallback.h:1:1: error: C++ style comments 
are not allowed in ISO C90
     1 | // SPDX-License-Identifier: GPL-2.0
       | ^
./include/linux/atomic/atomic-arch-fallback.h:1:1: note: (this will be 
reported only once per input file)
In file included from ./include/linux/atomic.h:81:
./include/linux/atomic/atomic-long.h:1:1: error: C++ style comments are not 
allowed in ISO C90
     1 | // SPDX-License-Identifier: GPL-2.0
       | ^
./include/linux/atomic/atomic-long.h:1:1: note: (this will be reported only 
once per input file)
In file included from ./include/linux/atomic.h:82:
./include/linux/atomic/atomic-instrumented.h:1:1: error: C++ style comments 
are not allowed in ISO C90
     1 | // SPDX-License-Identifier: GPL-2.0
       | ^

etc.

So using -ansi in the kernel sources nowadays sounds wrong to me ... could 
it be removed?

  Thomas


