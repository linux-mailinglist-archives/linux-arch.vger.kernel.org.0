Return-Path: <linux-arch+bounces-5473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550B9340A1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4EB23C50
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED561822DE;
	Wed, 17 Jul 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hplCPUbH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7F1822CD;
	Wed, 17 Jul 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234231; cv=none; b=o5t9v03rKIxfallRvgaXng1mwwkA7t65HInr4HtR718ftxJCW6/qvlRCP56JIrkq/ZRCzB0hiY5aREyid7EieNxv/c19MR4lUT2y4Sm08FFRVy0CCRApXsPUq9fchjJraAF1glRX4HYaCIZlnk0jdGThprfe/9Mlvlr5oJfzoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234231; c=relaxed/simple;
	bh=X2LJXlqqhdboNYjpN3n0+rKKg6IyCtnIsHjBGf04D28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgQgB5dnh+QN+xd+njJh8jQH683lq+i1sUk7s4dKFFBMlgxg7lxPo7J5TOaHlV35z3EEZIHtdLRG7OsYpyMh/Y0Z3kYRz92tSzcQJ11AlS1B4BaENYMG4kbHjig+QyIPl4buBMcitDpop66KCpnRn/jU/LU6HhpWlYyS5cbOb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hplCPUbH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so8753171a12.3;
        Wed, 17 Jul 2024 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234228; x=1721839028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z89Kh3KCBz8pTCaoWQSn1UAiDUeeBm1FlToMf75uMRM=;
        b=hplCPUbHdf2TkonloaA+oxP5Bt6ODC8G2jJxNv0AO93xo2A9pjBMK6kJ6gf5XfkYFF
         M3PnhDNjz4ZL/HwbgtLWmWd5fAXBX1wVRA+AnjJQFXJmvEBOkR2DKSBAOR43+Zt/mT61
         1KibXCGZRV1x1FhCUVJM5ETuShSKf8IPfl+GJeXY+jc7oZF0ywGlisHUD+G6WnWdodj2
         clYMIPerkn1G2r27eYHDJ52610H5yncWHAT5z5FBVLN0Zbed/IWMNd3xi1TtjoSGMCN2
         jTlTjT11EjtMxxvprJckuewiobc/whpDjexlwA4V5bQ2DwRgGjdPLDYOrCAd6NwldCPc
         iO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234228; x=1721839028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z89Kh3KCBz8pTCaoWQSn1UAiDUeeBm1FlToMf75uMRM=;
        b=NKh3SmYwpUCdV48xyKMk0eoT9U8/BMUkct8lllwWwXuQjIXr5bHrIOPR7wXWuH/efN
         EFXJSSh62XpWgsEQ/VDr58B7Arpfsr6CZ8eG7F1k2ud8qEJVlXngDxCu3R/MbGoJW+Y9
         nevdYVPDENm+FgMLxs0CddeVVdXVQpR9gjUfRRlqN0gGpPs+Fz2jldaC7dRiKo8V1EXu
         nu43LAhwS3IeANP5A5kB2ly9Dc5fCfGkQSLxvt0upV50+G/3f8EkqyHJshnePL7088/8
         qnMVLsEFJ0DqepmbIE+lnVD9uCHBi4MMlWY2AO41QqvhCHKJe/mH08tjnbvzbQ0mZ0WB
         QODQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlK9V98Ubp+i7cJPmC36TEJVxTUhNGLULFJljfuimvhL5pgFYc6h+KqsMoz4XHVvMNr6bvae6gSR9C/zvkaKEHT1I4po4RHYW332qk3tg/voK5E1hRD3n9XHoPBZcEsknQ8QiGoqbAqCrMbMj3iOaUKo4CFcBDyPnJmQcZsN9zu5Uj/w==
X-Gm-Message-State: AOJu0Yx+cOpu6xScY5PRv5LvCmsMikE/kYqiCfnhcjcAvYC6epzcVTtH
	IocgwdC1NfKfiQpA/2C1mFSznLG0Dd5BMrshW49e3KUKA2eyp4Dw
X-Google-Smtp-Source: AGHT+IELctoSCj2hRw5kTT4hjGzJpy2wpaiIk26gJLVJFRhtyk68IEVDqRl9amp3GFoglbhVDzl/8Q==
X-Received: by 2002:a05:6402:40c4:b0:5a1:c43:82c6 with SMTP id 4fb4d7f45d1cf-5a10c4386d6mr862718a12.5.1721234228195;
        Wed, 17 Jul 2024 09:37:08 -0700 (PDT)
Received: from andrea ([84.242.162.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b2504b711sm7185658a12.35.2024.07.17.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:37:07 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:37:01 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Zacas/Zabha support and qspinlocks
Message-ID: <ZpfzLVEiEvuetl8+@andrea>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717061957.140712-1-alexghiti@rivosinc.com>

>   riscv: Implement cmpxchg32/64() using Zacas
>   dt-bindings: riscv: Add Zabha ISA extension description
>   riscv: Implement cmpxchg8/16() using Zabha
>   riscv: Improve zacas fully-ordered cmpxchg()
>   riscv: Implement arch_cmpxchg128() using Zacas
>   riscv: Implement xchg8/16() using Zabha

These look good to me.  Thanks!

  Andrea

