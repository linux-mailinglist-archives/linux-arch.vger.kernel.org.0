Return-Path: <linux-arch+bounces-21-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F187E356A
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 08:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7FD1C203D8
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 07:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA3BE47;
	Tue,  7 Nov 2023 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="qavlxJPt"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FCBA3B
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 07:00:09 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F610F
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 23:00:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc9784dbc1so31247515ad.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 23:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699340405; x=1699945205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT+fB+nShc13WFwJsBmCnkPpP2szplCX09J2M/XdGJc=;
        b=qavlxJPtvsJtxFBdQwFOVgEYU7hi5LpRx19AgpWuaBEju9wwL+/KUkWaoy93hx8shG
         HMABIivvvYeuDmsjjlRlCZ2XgL0hWC3gY6RcuDyJwEihZ886d9W2EiEJ2Cbbc3lOUbU2
         RhQ1BLodh6XCL3x3iSl0aXDaYPP0FzKxCsVsqyZ+g9FMh3PESug7OHPksU5T+TXmjFSp
         E2UT9qcFTz7Dt4+QRz4OX8eJFclaQUk0aQtgXinCaBOFTyA+pONTn1PPuGuJYdCr9wWo
         sSOG7tNc1h1T8/EedW99MIJtH1DKlZj39/Opq+5XyX1TeUgQXP1WX2hZfJrxXs8BLAc9
         y50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699340405; x=1699945205;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT+fB+nShc13WFwJsBmCnkPpP2szplCX09J2M/XdGJc=;
        b=mUt0rGZ/GZ65JT4G6Oc4xD5TsjOlvkG3hXppWgZIs50i23M7yJfUbm2rlV8aEqIxxY
         btCRqMQVCOJXMBCdFzwlZl6M2Xh/ncz8+v90o+BWylVuwruRoVazr8w7vHvQ32PxFxuN
         vCt74lM2i5qieib6GI0vdOAQZXAxN+/Owei1tt8ZOyZ0xwS7JhmTXRZc6XhObzmtbjg5
         Evy5tlWFAyrv/Fwm8CesUVs9CFh2eQBOBV0BLbvO7amK6g6PwH/qAhVSaFeDORSl7r10
         Z/oBNh1K+tENyh2jTeKg1GyAP7Y899byn/2mQ6Ae7I2RcX0FAF4FVu+v3JuCQi4MZ8u+
         C4RQ==
X-Gm-Message-State: AOJu0Yyc8/k+rxab1d6uzjlwVRooiM0LUKViOcYUhNfa/Xs4flgle1hF
	OZIVKFV00YLFDgse7Ko6ceBMAA==
X-Google-Smtp-Source: AGHT+IHfFOWchFvO8pJneXAWC0dzM9ECoTMi1CyG7yOXyLVhl6cL8Z+QF9QwrVc4186nG4cx0iwg+A==
X-Received: by 2002:a17:902:bd85:b0:1cc:ef72:8600 with SMTP id q5-20020a170902bd8500b001ccef728600mr1911154pls.62.1699340404326;
        Mon, 06 Nov 2023 23:00:04 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001ca222edc16sm6950068plb.135.2023.11.06.23.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:00:03 -0800 (PST)
Date: Mon, 06 Nov 2023 23:00:03 -0800 (PST)
X-Google-Original-Date: Mon, 06 Nov 2023 22:59:59 PST (-0800)
Subject:     Re: [PATCH v6 0/4] riscv: tlb flush improvements
In-Reply-To: <24E0FC81-810E-44FD-9494-CA9374E495B5@gmail.com>
CC: alexghiti@rivosinc.com, Will Deacon <will@kernel.org>,
  aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org,
  mchitale@ventanamicro.com, vincent.chen@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, linux-arch@vger.kernel.org, linux-mm@kvack.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, samuel@sholland.org, prabhakar.csengg@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: nadav.amit@gmail.com
Message-ID: <mhng-4e3e3fa7-5e25-494c-a3ad-6ef7ec78cf20@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 30 Oct 2023 07:01:48 PDT (-0700), nadav.amit@gmail.com wrote:
>
>> On Oct 30, 2023, at 3:30 PM, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> 
>> +			on_each_cpu_mask(cmask,
>> +					 __ipi_flush_tlb_range_asid,
>> +					 &ftd, 1);
>> 
>
> Unrelated, but having fed

Do you mean `ftd`?

If so I'm not all that convinced that's a problem: sure it's 4x`long`, 
so we pass it on the stack instead of registers, but otherwise we'd need 
another `on_each_cpu_mask()` callback to shim stuff through via 
registers.

> on the stack might cause it to be unaligned to
> the cacheline, which in x86 we have seen introduces some overhead.

We have 128-bit stack alignment on RISC-V, so the elements are at least 
aligned.  Since they're just being loaded up as scalars for the next 
function call I'm not sure the alignment is all that exciting here.

> Actually, it is best not to put it on the stack, if possible to reduce
> cache traffic.

Sorry if I'm just missing something, but I'm not convinced this is a 
measurable performance problem.

