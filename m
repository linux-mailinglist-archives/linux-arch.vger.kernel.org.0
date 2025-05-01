Return-Path: <linux-arch+bounces-11773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75CAA6490
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 22:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B328A9A37E4
	for <lists+linux-arch@lfdr.de>; Thu,  1 May 2025 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C924729A;
	Thu,  1 May 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj+D09Ej"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420724677E;
	Thu,  1 May 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130055; cv=none; b=F6RgYDhGSSEdCow6qfxg7LVVI75rWBfezwq3I3XAJrWMQgTPGAmKRrVYq9IJSK6TkQeV3szjZXbYJamGF8Orydx2afJRi3TPJ/Z8i+HzULUNf/9W4rIr4h1oKuTZNRuueYXFF5hhFtuaQa7zMKyxsKptP/Cl4zafY9jpYL2bGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130055; c=relaxed/simple;
	bh=BrxaEXoYWGKXg2PGmFg5c8S5Eq4HVZ4HIKaULdVdahc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObsnO+PiYo7YKSLzhYq7Rk1nDzVV/zIS2zJq2yBWf0IpiIn0m4TXB7acdbOMUp/yXSyX6ZPCrJsgod9OxymfACcDRH13q3xXKhMl8/kWIHT9FRqce+fYGL1szei7nrfVMLZrlIOm9KrtoMuPzECdHO5voHa++j+an/N8e5w50iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj+D09Ej; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913b539aabso541324f8f.2;
        Thu, 01 May 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746130052; x=1746734852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOOEqm/pPCgs6BsMyD9s2dYK/FTS1v1KVmaovonx3qw=;
        b=nj+D09EjgL3XumX/QW3E6wuY8AN/x3UUDmuH5n81AydZeK1FUC9wPUJIdHBVLSVLhm
         ZuSy+Knf+TSZ9kms5if6871G4CjmCEn96O5/BHKzkmu0tLEaz8/brtUHSz6yEP27XP0q
         e1XuxEW1NIzzjR5MXcrUXBpfDzFBR7BvCdQIvq9bD3T57cIWXXwyoxzVBLBtPvwODKlU
         rUbOrG0lRSrZhq6G7xdvJblIshc1a+ZmfhE76z2NWd5LvQiOOPEcw6yi5hfO3MT3LRRi
         Y6nh9zQAZ2ZXUH3QstiaSsov276Q9BSky7WZOP7v57XmTwo/p4MsFy+Kq8znwhFR/xsq
         1Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746130052; x=1746734852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOOEqm/pPCgs6BsMyD9s2dYK/FTS1v1KVmaovonx3qw=;
        b=BX+dGsfg2kIPMHo4NJdoaKpmvRYmAr33D2806+CDJ8VWezfacSfsZ8c7qmyev1sGCq
         WpsGIla5WMBVJHbNBN1XMTMGJjv5vRy4IncViRuwtXuDoW6L2hFNVeVxIbjnLdx99O3+
         NGGJOa1hojWUl6882eqGKQN5Uuox9dYFgEAsbxJ5W301Fkjmir4FJqpF4Kk9nXyfgLHv
         4Cn1j3JAPOH2VhK4Y36UAGDpARxzYRvk4sMmEvReD9ZzHuxo+4M7fAUO984g5SWi8myI
         pL/oMcKZtnln/yHjlhwC3aqLsMXmtUOfv/jS77MKLPiNJ2WKr8u6cEUajyDKpFQR3jr2
         D33w==
X-Forwarded-Encrypted: i=1; AJvYcCULMkmsBsyJkz0oh4FD2BUkzXTUNOKzgnGjHIjl7Gpl66KTsAtqXC9tagAOKGE9hLtshVZ5VJ3PJOyd@vger.kernel.org, AJvYcCVwUTdPDCz/UeSLQ/Peb9ZEn+BYQul+ddC6vohhMDti4Il4TPc+7ipi99rMGqUKww4QLj9RyGLdfeC68IE2@vger.kernel.org
X-Gm-Message-State: AOJu0YyYspcEFUCZYp+c4esl8vFxsNNBt7o8rWHiLgnvKKaJsYX+r/pt
	v/LrQ8LEG6xZ+t8gXTZKz0Zxwb1OfzeJnWouN1fm9Bwq0h+SnZ2f
X-Gm-Gg: ASbGncsJEIEGMAd9z+pcMun267A33sf5NBGX143j498ivu9PKfwQpklP0rf2o38jdgr
	vBEzQIOjQh7fOV67eblqEMYRq8VO4lfz9czAE3UmmJ0MWWDEgexNj4nkeDoebseUFovIcWjffHL
	Yw/f1C1IZnB4lHR/W7VB34+G16Hspw+kEQn4OrbddFe3azg/eOwWk+hOBra2n+xwWsthxOddVfl
	8PMlDXJp3YpyTt95lku/a+fSIfLuEgJVynt3QZQV+99VW3+CC6LW6E/ZewYafn5p+h+2BXKMIgr
	1jENuaje4V3CPMgrcQS7KAHBKnNCIHSIvYkitIMMt8nOCs9Iudzk4w85sR5Ui67AIuYLi95lkes
	fmK8=
X-Google-Smtp-Source: AGHT+IH8a1pUJQSeh3X4FAtelAZ88iDsLxyl67Hy088a9nJih1+Ck1krTw97wj9Uh1G2vDiZtUQVcg==
X-Received: by 2002:a05:6000:4203:b0:3a0:7a8f:db22 with SMTP id ffacd0b85a97d-3a099ad7aebmr128136f8f.24.1746130051567;
        Thu, 01 May 2025 13:07:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7a35sm117740f8f.43.2025.05.01.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:07:31 -0700 (PDT)
Date: Thu, 1 May 2025 21:07:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan
 <leo.yan@arm.com>
Subject: Re: [PATCH v2 4/5] math64: Silence a clang -Wshorten-64-to-32
 warning
Message-ID: <20250501210729.60558b33@pumpkin>
In-Reply-To: <20250430171534.132774-5-irogers@google.com>
References: <20250430171534.132774-1-irogers@google.com>
	<20250430171534.132774-5-irogers@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 10:15:33 -0700
Ian Rogers <irogers@google.com> wrote:

> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit. This isn't to say the code is currently incorrect
> but without silencing the warning it is hard to spot the erroneous
> cases.

Except that the extra casts make the reader think something 'extra'
is going on.
For readability you want as few casts as possible.

	David


> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/linux/math64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index 6aaccc1626ab..f32fcb2a2331 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -179,7 +179,7 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
>  #ifndef mul_u64_u32_shr
>  static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
>  {
> -	u32 ah = a >> 32, al = a;
> +	u32 ah = a >> 32, al = (u32)a;
>  	u64 ret;
>  
>  	ret = mul_u32_u32(al, mul) >> shift;


