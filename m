Return-Path: <linux-arch+bounces-10985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFFA6A68D
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 13:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8B78A383A
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257245027;
	Thu, 20 Mar 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjFExFxj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE417996
	for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475389; cv=none; b=qcjGq3e2dAWTOGqa3bm+n0fcv+C1/AGfo/AGspxLSQ8XmmXgi3h/VHiH6vnR7T/OtaVM1E/g/y6LsXPbkjBs4jMPJeIFBnvYNknueqKQVQfUQumrdIlO8JkdnV3F1PDcivuwgJsuUcF45deuAmfTaaXTJfoWjdaOKd49wHS7Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475389; c=relaxed/simple;
	bh=zTnXAKmTuZRtU1d1p7Q5TlC/BTFpcP/VJalqvVhGyj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQnupCxvTcqwGqijAIJJVYiJR9sOKXR7PW4oeQ2JN4ibBE39Up5dE5PPcmO18bbt0VeU8E7EfUjCydUF9ZXwF48GlWrW/CEye3/oRiNr/vbx4KhedE5Cq6orpQs5tnIL7gqQgv3tY4lLnZOJoEew0l9xmTbhhvfNyIoufWSl1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tjFExFxj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf3d64849dso135439966b.3
        for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 05:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742475384; x=1743080184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTiBMnvR5EfiapTBlQ2zIHklJYLCh/G/HYnYPld7nw4=;
        b=tjFExFxjbUzksAmUGKs8bktnIAL/dOdAIUu3uNWvSMhjDPsaW4uoHKutafmN0FVyLh
         ekTaSBtt9wKZaKYmJXpK72UxQPHEy43whWsR5evtAvjC5huZNbQpB/CNjzTIrri7rh8N
         diz+e0BKg56edVlYvqArZmvLOH0LrYe0k9nLU2dZ1ljZgq1r8uSbf1ewL53kyVpOPUx9
         gxN58T0N5A+uOB5eEIPVPYJGOaFcoKgI6B3HpwjjRafAzpyBDJq/2dj8u+BKcU5yNKmM
         Tu6DTpMrgszaMYb8navO0fLM09oejSADZEt4fhIqYfO9mKU0yz6YpXRmSxwMjAYWM6dE
         6TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475384; x=1743080184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTiBMnvR5EfiapTBlQ2zIHklJYLCh/G/HYnYPld7nw4=;
        b=vw8hLNOGd12Hrgfn20HyU0TGywLcuHpaLQGIjaKVwSkuZvHjF6AJl4jvLEhZ/Tc+b9
         3o4oMWbtxfIHODp+pHsNiJJ2lymobcQLeLToJZprPxAMsYsvTs9NzvOQBvCyMTLqd/1/
         adTMm6G/8scbsWrYrV71gyUgMgJ4iIEjF6N1nch7x9edQyQQAOLbrN+qCkx43X1LMlCe
         txdl95rpJpA65b09mKR3khCOY65tyCFt/7hcBJHO/NfW8D75iotvI2/QYMc6JdadHbc+
         gL6m1iUwrGfemY5aFR8scsYunpdSZW/qLwRnDV2X9Dt3Rgbczw2u1yJfF+qjp7StjDvJ
         ICbA==
X-Forwarded-Encrypted: i=1; AJvYcCUjT1eVsaA/OA8Uc+5zYyVYhYl+ZKH1MQzpaZWEO8cz8JzFYKY2kb9Az/hf2VfrZkf9qZbZGTnP89W+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWxU/B5IgR/i/cpZpITzMY31mq6LC3/xV3yfU+wkxbQZYWLMWE
	QeFEXNjjOPiUotTDkFh6Gn2c5hbG+RlYu1FFBGYfq+835IvrpDbFcanXWK7bVOs=
X-Gm-Gg: ASbGncuMRLh9bNpCtRrBJNsVO9sPBd8hfrV3d/Hbb/4PDURC4FtvYsjcwlqdSaWn8Ym
	GiRMltY3OHc3W8oY0fjGDvpnp+MikOvJ4mlFCzX0Y8K9z9Ck7JTsvh2A01/pYzhiG65lGNL7moI
	M/y8ce/08k7dxQmjpjfXsSW1yarYkoSgUn1kAd95wCyV2kxyDM2n7bG4hH89HOBIbsV+GRiUNj/
	c2BJRA0SYCKf+68q+vBgAgyiAsKm8uxekTG9NIqSdl4LY+1AdHcrW4I8I9D0poWZPrNev4CaYR9
	xoGeGRBQwRTrgnsv0UnqGetz+ckbXJxg8litlH40RQ71OgMUczQlEj9NjySftvav7gH+aaUxQjz
	ecJJCvN15HD7r
X-Google-Smtp-Source: AGHT+IFwbUtBKy1cKZpiAYgKgI/ab8Fj6ZMme+dS/eEmYErdP1Yx16iHt4BcTPb5hz8rYdlEnkXIEA==
X-Received: by 2002:a17:907:f50a:b0:ac3:45c0:6d08 with SMTP id a640c23a62f3a-ac3b7373065mr786509366b.0.1742475384270;
        Thu, 20 Mar 2025 05:56:24 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146af080sm1155354066b.31.2025.03.20.05.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:56:23 -0700 (PDT)
Message-ID: <817c02a0-5493-419a-9663-73a85182b047@linaro.org>
Date: Thu, 20 Mar 2025 13:56:22 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/41] mips: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 the mips headers
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-20-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314071013.1575167-20-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/3/25 08:09, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
> 
> This is almost a completely mechanical patch (done with a simple
> "sed -i" statement), with just one comment tweaked manually in
> arch/mips/include/asm/cpu.h (that was missing some underscores).
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/mips/include/asm/addrspace.h            |  4 +--
>   arch/mips/include/asm/asm-eva.h              |  6 ++--
>   arch/mips/include/asm/asm.h                  |  8 ++---
>   arch/mips/include/asm/bmips.h                |  4 +--
>   arch/mips/include/asm/cpu.h                  |  4 +--
>   arch/mips/include/asm/dec/ecc.h              |  2 +-
>   arch/mips/include/asm/dec/interrupts.h       |  4 +--
>   arch/mips/include/asm/dec/kn01.h             |  2 +-
>   arch/mips/include/asm/dec/kn02.h             |  2 +-
>   arch/mips/include/asm/dec/kn02xa.h           |  2 +-
>   arch/mips/include/asm/eva.h                  |  4 +--
>   arch/mips/include/asm/ftrace.h               |  4 +--
>   arch/mips/include/asm/hazards.h              |  4 +--
>   arch/mips/include/asm/irqflags.h             |  4 +--
>   arch/mips/include/asm/jazz.h                 | 16 ++++-----
>   arch/mips/include/asm/jump_label.h           |  4 +--
>   arch/mips/include/asm/linkage.h              |  2 +-
>   arch/mips/include/asm/mach-generic/spaces.h  |  4 +--
>   arch/mips/include/asm/mips-boards/bonito64.h |  4 +--
>   arch/mips/include/asm/mipsmtregs.h           |  6 ++--
>   arch/mips/include/asm/mipsregs.h             |  6 ++--
>   arch/mips/include/asm/msa.h                  |  4 +--
>   arch/mips/include/asm/pci/bridge.h           |  4 +--
>   arch/mips/include/asm/pm.h                   |  6 ++--
>   arch/mips/include/asm/prefetch.h             |  2 +-
>   arch/mips/include/asm/regdef.h               |  4 +--
>   arch/mips/include/asm/sibyte/board.h         |  4 +--
>   arch/mips/include/asm/sibyte/sb1250.h        |  2 +-
>   arch/mips/include/asm/sibyte/sb1250_defs.h   |  6 ++--
>   arch/mips/include/asm/smp-cps.h              |  6 ++--
>   arch/mips/include/asm/sn/addrs.h             | 18 +++++-----
>   arch/mips/include/asm/sn/gda.h               |  4 +--
>   arch/mips/include/asm/sn/kldir.h             |  4 +--
>   arch/mips/include/asm/sn/klkernvars.h        |  4 +--
>   arch/mips/include/asm/sn/launch.h            |  4 +--
>   arch/mips/include/asm/sn/nmi.h               |  8 ++---
>   arch/mips/include/asm/sn/sn0/addrs.h         | 14 ++++----
>   arch/mips/include/asm/sn/sn0/hub.h           |  2 +-
>   arch/mips/include/asm/sn/sn0/hubio.h         | 36 ++++++++++----------
>   arch/mips/include/asm/sn/sn0/hubmd.h         |  4 +--
>   arch/mips/include/asm/sn/sn0/hubni.h         |  6 ++--
>   arch/mips/include/asm/sn/sn0/hubpi.h         |  4 +--
>   arch/mips/include/asm/sn/types.h             |  2 +-
>   arch/mips/include/asm/sync.h                 |  2 +-
>   arch/mips/include/asm/thread_info.h          |  4 +--
>   arch/mips/include/asm/unistd.h               |  4 +--
>   arch/mips/include/asm/vdso/gettimeofday.h    |  4 +--
>   arch/mips/include/asm/vdso/processor.h       |  4 +--
>   arch/mips/include/asm/vdso/vdso.h            |  4 +--
>   arch/mips/include/asm/vdso/vsyscall.h        |  4 +--
>   arch/mips/include/asm/xtalk/xtalk.h          |  4 +--
>   arch/mips/include/asm/xtalk/xwidget.h        |  4 +--
>   drivers/soc/bcm/brcmstb/pm/pm.h              |  2 +-
>   53 files changed, 140 insertions(+), 140 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


