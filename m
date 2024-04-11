Return-Path: <linux-arch+bounces-3553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7738A0553
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018C31C22643
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 01:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB20360B9C;
	Thu, 11 Apr 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XPbVJIBA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C869454
	for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797868; cv=none; b=uv9MAmsKJef9ZDVrv90/wSsrv1lfSaf7YaZazgtcwidBT2L6sbTG389z09lRhNmbIhJY74BVwq0zZV0e4tyCsR2SiFnToK3eIB5JmTW7/BLVHMRxsVXCRwAfsu58GoEcChgxmRBm3tkIRCOcRGZYSlWiuI272QpsFRicd9Ms2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797868; c=relaxed/simple;
	bh=9YyH9BgEo3s56+nSbcPZpFNHGs99BC+E0EcZLKOsSQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfizrOctEZ0w3lauxFua1CRWOmIVYpJ5b8tzQbPo+7MtL93LTyij1ty2GRiFRXngWHhGQO/oA9vOBoP5JTfPrMG28Hma0h2oZf66L3ULZ5jGdg48P8uTkQb2MIzllr1ALpP6t4nfHC5TQgDGIQ1HWkRnrFoWnuynEslXF+oyvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XPbVJIBA; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa27dba8a1so2546664eaf.0
        for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712797866; x=1713402666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7z1/Srv4eZ2vooDSDvwwBej5oDKDz5itKY0SDj8VoQ=;
        b=XPbVJIBA5sKDJg5tWzuNq6eZ8A32Qn9WAAu5sC8HAvddiaj0Gjjrj1CWwPyBlUsalv
         WG0BrPJiDk2YzjvMDDsesu/1yKqg6dwghb+i4Yl6wgvOBndvZP2R0DsPx+oGXdyh0NjZ
         EDIrEWHhJRYI9lafNcbMvdPXhuS7gRxg5XWC4YF3T27jH08fCxqH+ZllmZ9fiYm2/h3e
         NDsgQiMAIFKQF+WVNT4Wo+ZPBmAkoi6DifFrhaI40WPnXXJLehz6mbU+BUc95rW5ZwGq
         a8e+R+CZzHQIkYIwhZf5iw/bXtrTF3wAZQtDqCyWoHYtAKaP8LCvYgT0qKp9NfUkfJIu
         W+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712797866; x=1713402666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7z1/Srv4eZ2vooDSDvwwBej5oDKDz5itKY0SDj8VoQ=;
        b=nJSzk9l3TGd9GWu/CKpX2O1EA3vzt+T1uusxCuJFjowV9PGpsE7BjvAEt9yECOylVT
         gYllxdVuC++BWsQ+cxwm67SJAp9HOBBD0MCqqDVhsA9+zF1kxJaS1Qn3d23aAF/CZMok
         hrqjKtaS0lsB2nS9/EkNj9kZg5veyHfyv6DQCNo6BjVNWQ9Fapj3O8y9OXBN5nwMRXAZ
         S/72Yh8JdIAD8UHEBa+wn2l96/fk/Q/duLhlDnVAsCkcnZDAC30vEj5CEdRZUWSu2/70
         rek5qX5x8R1DwZ2ZV3TazXtlsRNtefUqeVIH6EDBl9ZuyH/O0ANdPp5QpWbTWRx96raH
         rwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGCpveQvEr71xq/PRuMSSO05q0JE9U/FRUxXAvedVW9yIK16d7Y+Vd7kfHmyghxNzlWBeREh7FZQXJR5ZNKj3jOd/GS4HhiITVUg==
X-Gm-Message-State: AOJu0YyrqJengOrP3mQkz62nhWkL1M+GJpUYTUI5YTbBFX+AOD1d+lSl
	JYLPb96u71PL3KEyZtBHzSgSIPaKcB9O6OCns3oWmujnIUm//6wgc4Ry3H/OZj4=
X-Google-Smtp-Source: AGHT+IFvdAWGolMk2tEZ8bM2BAlC1TsYZtb/fNUYXyTQY+hWEfuiEC430lr0paNhGs3so4u/3MehIA==
X-Received: by 2002:a4a:e9f3:0:b0:5aa:6a28:27ea with SMTP id w19-20020a4ae9f3000000b005aa6a2827eamr3725829ooc.6.1712797866523;
        Wed, 10 Apr 2024 18:11:06 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.167])
        by smtp.gmail.com with ESMTPSA id db1-20020a056820270100b005a4bc907f0asm113158oob.15.2024.04.10.18.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 18:11:06 -0700 (PDT)
Message-ID: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
Date: Wed, 10 Apr 2024 20:11:04 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org> <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
 <87wmp4ogoe.fsf@linaro.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87wmp4ogoe.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thiago,

On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> Samuel Holland <samuel.holland@sifive.com> writes:
>> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>>
>>> Unfortunately this patch causes build failures on arm with allyesconfig
>>> and allmodconfig. Tested with next-20240410.
> 
> <snip>
> 
>> In both cases, the issue is that the toolchain requires runtime support to
>> convert between `unsigned long long` and `double`, even when hardware FP is
>> enabled. There was some past discussion about GCC inlining some of these
>> conversions[1], but that did not get implemented.
> 
> Thank you for the explanation and the bugzilla reference. I added a
> comment there mentioning that the problem came up again with this patch
> series.
> 
>> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>> 32-bit arm until we can provide these runtime library functions.
> 
> Does this mean that patch 2 in this series:
> 
> [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> 
> will be dropped?

No, because later patches in the series (3, 6) depend on the definition of
CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
find a GPL-2 compatible implementation of the runtime library functions.

Regards,
Samuel


