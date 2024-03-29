Return-Path: <linux-arch+bounces-3334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625189231A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 19:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5151F22866
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E930136666;
	Fri, 29 Mar 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="l1NnkLAV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6B85633
	for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735381; cv=none; b=ZsRJK4JxmW706m+Ow5mFMSwNz55nFakz6nb8bY6qtj3FiOGYQGmK+vkb6tNOliPRsz/FMHjM2Rbg4DEeFIEz2DmmMvROpuWScAX08e3o/DJT+57ZoNjtGnH6V9izR85FHANAmGldK4xoFEGpOG/nPbGyhh+1BPDxBJXpK1rBqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735381; c=relaxed/simple;
	bh=+S3hlEF4bZldPHqmLCThWpT6aoGahvI+J6fFNIlvYoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpTpbIj6kV7N8a+sC6tWOJ/MUiLXj4d1CSWkFdUoSbvBvdC/6bWlCcHa3qBptzsEjWUEbBxsKEi1MnOw64dWQG/E2z3q5vm+qyFBfT0rgpWIxAMMfSLRsSpKdBVN0Hpm+gcV+ArNlhdrX3xRn4WCx5YVlvr1RivybWOjrnEKPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=l1NnkLAV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3666affcb59so8544745ab.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2024 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711735379; x=1712340179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdcMw9p8wYMiyXmXvRCHMMbWNQHaQ3aY6vG2uVIiJB8=;
        b=l1NnkLAV8jpGHw8+yZzd6AWT6yP57DzKtKZX+GioxGIKexWlgIW0fhWfFb2cv4x/xH
         cNPzgK6ASnebgSbnHirtnFrN5pR2RlrryO9oZq5+rmfqvBCd2GSY082+KLpkCo6q05VB
         /q+4N0igCBX4IKPSGy43sr0HBa/ZJvZaW0cCnto1tH4+mvBLdaJcxd5r+gosgK4kX5Zz
         ISMgUToRYfB5k7+f4nIAZEOnJyZC/copoActlzd4P8bgRdAay8mt5VB/8ACwg+K25Jju
         PHFA8tnylcTeb7CxGWM3L8Z8+l9xuuKMFWqJosmZa+8fNU8n6uTGcYFg3mHH2OeuhAaP
         oLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711735379; x=1712340179;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdcMw9p8wYMiyXmXvRCHMMbWNQHaQ3aY6vG2uVIiJB8=;
        b=aAYymEJEMJouwZBYMXx79lFuMoT7k0GLz4p+uoF/6YhaTuHhLJgsnOPuXgMQcKQsRO
         K8BJ7uLO46s+IfNprfpSCMXHHtJd03da4yJ6PPxSvdtDWynMwrhPLAF56sxmkywoknZ6
         kaZ/ZU9kSPiTmZIxh6GFCstDxsj0GH+uQ/9zQ97lxwcMiErgMvfwdXMgDT93nzHCj+xj
         oGsKK1silDNWVKodfL/odTmffNLvid7vDzmoGENxZEAFAPiTcdulqQ8kUuCE+Wpfg4Uj
         Xz8E5Cos/peTGyijzixQvz6Rm+/4WLmi6Vyn3tgo2sX9L5rFATNJdY71mBJYZIqc3xch
         SADA==
X-Forwarded-Encrypted: i=1; AJvYcCWgPlz+XU2Za3bBxiCEsGfuKJTlOcZny4DqpvwVqTvg4wdAIve3/P+jkJ+2mNhVUxKXIbf3YJ7szNgKmECuE2+H3ac9Y6sgKEslTA==
X-Gm-Message-State: AOJu0Yxjd51WzHfV3niaV3N8jm5ulN6CuGifM8TAKS7W4Cz03xcoqmnT
	xWq9MTLfEg2hVhDtmbaOXP0IZ+HvejlHf5jCOyJE96UFjVbrJosxShFK0fNR3jc=
X-Google-Smtp-Source: AGHT+IFqMNmDL2GVO2cyYm+vIEEaj43NPiUKo2CRXyyGfQmLknY9TtLFDSxdZDVwWotlePg1wJz6nw==
X-Received: by 2002:a92:ca4e:0:b0:366:ab6f:f6a with SMTP id q14-20020a92ca4e000000b00366ab6f0f6amr3003624ilo.24.1711735379197;
        Fri, 29 Mar 2024 11:02:59 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id k4-20020a056e021a8400b003689a9e5017sm1217549ilv.47.2024.03.29.11.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 11:02:58 -0700 (PDT)
Message-ID: <0319d84e-ec4c-45a6-9edd-a606809371d8@sifive.com>
Date: Fri, 29 Mar 2024 13:02:56 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-11-samuel.holland@sifive.com>
 <d2c3cd78-cdc6-4a39-9804-4f30402751b1@intel.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <d2c3cd78-cdc6-4a39-9804-4f30402751b1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-29 12:28 PM, Dave Hansen wrote:
> On 3/29/24 00:18, Samuel Holland wrote:
>> +#
>> +# CFLAGS for compiling floating point code inside the kernel.
>> +#
>> +CC_FLAGS_FPU := -msse -msse2
>> +ifdef CONFIG_CC_IS_GCC
>> +# Stack alignment mismatch, proceed with caution.
>> +# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>> +# (8B stack alignment).
>> +# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
>> +#
>> +# The "-msse" in the first argument is there so that the
>> +# -mpreferred-stack-boundary=3 build error:
>> +#
>> +#  -mpreferred-stack-boundary=3 is not between 4 and 12
>> +#
>> +# can be triggered. Otherwise gcc doesn't complain.
>> +CC_FLAGS_FPU += -mhard-float
>> +CC_FLAGS_FPU += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-stack-boundary=4)
>> +endif
> 
> I was expecting to see this (now duplicate) hunk come _out_ of
> lib/Makefile somewhere in the series.
> 
> Did I miss that, or is there something keeping the duplicate there?

This hunk is removed in patch 15/15, after the conversion of lib/test_fpu.c:

https://lore.kernel.org/linux-kernel/20240329072441.591471-16-samuel.holland@sifive.com/

Regards,
Samuel


