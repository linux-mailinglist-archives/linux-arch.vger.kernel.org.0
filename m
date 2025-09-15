Return-Path: <linux-arch+bounces-13604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D5B57089
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 08:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E611892A2E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2931311AC;
	Mon, 15 Sep 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="tmdrCh1b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6327E045
	for <linux-arch@vger.kernel.org>; Mon, 15 Sep 2025 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918540; cv=none; b=Lxb9ZXzW4AUBrq5depXglpi2Kp84+HZ6YKexdTngH7EVpWEaRWqPgTytA9rLzYWtsApMxlE73749QWBdZ8vyTfspbkmMRZXGA+/jcoN8K6bxg0yHi00EzV5ovaVLip1lIoGs2zEpkzMipwUkO+CggBVoOg76lBoMMhdgU94iy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918540; c=relaxed/simple;
	bh=VDrHGtFOrHkGMUyMK7CG8vsgW1x0lP0y6Ux4RfvsjZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV00ZO+husu/p2H9k7Rlydm6i4l7mUFcP4aU8dz8eoestFcCTTZ6tqd57CBWOZofgXhtrvpXOucR+JqWbINQaUgBe0gEM6mAr+7ubqC6QvLrtqLv9GC16pvblJLZrfLQ5eiANXsTqqZIUlJ91N0Tbsq68S1Q7j+gJppQ94xrCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=tmdrCh1b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07c38680b3so411913766b.1
        for <linux-arch@vger.kernel.org>; Sun, 14 Sep 2025 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1757918533; x=1758523333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYpqNcnwO1AiOugXjAT6rZVipdVhaKdoRjjyakgRNKQ=;
        b=tmdrCh1bxc01Zos3g2onVQwwvTnW8nmYD9jL5RU+4oA87FxFPnbg6tm+V1vA8zBOe3
         Iz3uvQxrNI+r2W8PfIyg0HWUdrHYO5na5cnhfJO0h4uz2Iu/siWns9OyKQeZkde/g7IU
         LLNZhim5XgYUfamP/N4RSolXm4Rlnz1n5zvRvVWXQNwFqQEq7BSatqBWDzu5cJKobOOE
         W9wCPu1mvCbrql3cc1hHEg+CDgmkJkNOxqtehhh1TJeHP9r6IKyjIhw2A1FGu58MSjP0
         xZP/ocreefUMWJ35T46qyAEvxAwUID6Dld6XltEHkCTu2T0J531lqJQLvb1BxemKVUGa
         apyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757918533; x=1758523333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYpqNcnwO1AiOugXjAT6rZVipdVhaKdoRjjyakgRNKQ=;
        b=JSMCxDBfRmiG9atQl7+UCokAL7V5WVMbh9kFItFHjFBLY0KEv1oWBfW92AZzaXLI9B
         KuKe1pYTtIsOb9ey2LSyKjGfUNnplOavI8Yc2BswuxT3m1t4RSoirmh8wnKW4/KLxXte
         VADnqXxW23HHcBW5U6qWYG0lNTm6Ixo9L07zGq6s2syL3ZqWIHCEoOnc1RkPUB5LWpR5
         QXgwA/XiZDiV7v7LjHQw00dAXFBDdNiuNiesaVkJCk2VQ9Ze3OeJcDGwWpppyW6LIUTF
         vB8u6AbVXIL2u1u56qv9n83FQgUka1MmOp+W9lUKbPBwX7sanY7fB/cL2vsK/4W1CBcz
         9dHw==
X-Forwarded-Encrypted: i=1; AJvYcCU6HInScSAEjV1+gVs7F8O7SOzzxnYew6KNIYhDgsrhuSPN+eTyDKfgCi5ekx8yFfsdQEFstreWIJYl@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsZYEBGXjWmgXG1pp4fM86ZzmxAyKiUsvBvD6g5r0GN/xpFWo
	yXTKfiT7Stwpa6YT5AM2hrO30J1FDGHCP3FPvc6zz4GP0+olr8jotzWFoikhIGQBww==
X-Gm-Gg: ASbGncvSPXCuo2AXwuWG+Io524my/SGsvBbEI8pExDVwx2XEz1GoWcCm2+tov83uBuM
	+kab7oZC0boAS13aO1IIUA6Vwkhy05/8lGAcuAil/MGdR7exqJA94moso+JxTmgnxq0UQnstnA/
	sxJZKE9HmTUDmnWYPfveDhcokkz72ytJD6WMHb6zIiWuEWoVHsQaSoguyxYd3EtBwg0nItM1gWn
	PV7ApGvfl/5hdRsDgo+5C9lqAla2+rnB3Dxy1pxE55SmRr3HR0fKxekc8Rkacy29wcxMaw1/r5x
	Kz7HvevZUOkM3t4E++aP/Neg11I1au7vdNfIgjvlMgXSWB5YF2XIb0mk3pdnu4O+dDsYV8vofGa
	jhRBcRy1ULvNcmI8f734RUEYC
X-Google-Smtp-Source: AGHT+IHmUY+dFRWpugaWotftvE9e1WhXDKJpaHEynboNJZT47ghrfaqdx2cchbgiTQPPUsWBemmXoQ==
X-Received: by 2002:a17:907:7f22:b0:b04:578f:b3fb with SMTP id a640c23a62f3a-b07c35becafmr1318742766b.17.1757918532129;
        Sun, 14 Sep 2025 23:42:12 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c337e785sm703515366b.25.2025.09.14.23.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:42:11 -0700 (PDT)
Message-ID: <d71106e9-95d1-48ab-844c-ed3fa38762e7@monstr.eu>
Date: Mon, 15 Sep 2025 08:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6][microblaze,xtensa] kill FIRST_USER_PGD_NR
To: Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
 linux-alpha@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Jonas Bonn <jonas@southpole.se>
References: <20250911015124.GV31600@ZenIV> <20250911015440.GE2604499@ZenIV>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250911015440.GE2604499@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/25 03:54, Al Viro wrote:
> dead since 2005, time to bury the body...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   arch/microblaze/include/asm/pgtable.h | 1 -

Reviewed-by: Michal Simek <michal.simek@amd.com> # microblaze

Thanks
Michal
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


