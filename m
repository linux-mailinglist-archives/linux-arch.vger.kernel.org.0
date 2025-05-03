Return-Path: <linux-arch+bounces-11841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61103AA8018
	for <lists+linux-arch@lfdr.de>; Sat,  3 May 2025 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D616A9861C2
	for <lists+linux-arch@lfdr.de>; Sat,  3 May 2025 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1081D6DB4;
	Sat,  3 May 2025 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiJjNg6M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542741AAA1A;
	Sat,  3 May 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746268393; cv=none; b=N6gMtgKnwERnIhalv4EXXjI34XcKeVOpBhrmZmgehrjEnwh2c4eLzvE7xeguLFKOs/E6ES25hsznYD2bAz4BYz1fhUlMbp17ghoVi10ExaVRPpdSlFDhZLhHqajRChJZe0d9h+rlj7JnFxSP74TAPpqbG+Su4tJ3utybhwzETw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746268393; c=relaxed/simple;
	bh=Af5eJ9491V7Rdra5LfIAJarCq2ooV8hQqIHvng7TBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsUMY3I4m/NzRvYi5hqWvVnzHUEwYQSJZZaxVjJ/lv04kFp+SheVifaMyCLUQw1Tk/1Y9qMIjtAm4JUbWAbx1xVf2aF2I0AhqPnUEPHeBD1QkK9CtwiuJ0szFR+yMoRo4yd/Kf6xWxiSKWcPY1XP64wCLvQDDSxupOuzZiH8E+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiJjNg6M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ede096d73so16601435e9.2;
        Sat, 03 May 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746268389; x=1746873189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBV2rGv2S1NcPt4tVHRfpNM/jvRNqsvpOuHIr/RLX3s=;
        b=jiJjNg6Ma3aaWgUanI0cDXySfHtH/D81uc/tqnblGXNBgjB8BM88EttGdhx/K3ietr
         y+5cn/njvJoN3rP601LVv6sVlLhMuHj9CxF8K1ya1+B7j1aa+kZJl/QFJKIL4g5YnooW
         mRL3h+oZ4bDUmYC4vzsX3VShZf8Ze3nlyPdO64Jf8cJfqDVuiU4otU5w+pwI+BWejxiw
         UDHPEuiS+Fbzykl8AVK0aUxALq7aJGT9QPPFQyUugEDJiFOl6HSs7+eC0EWbeqrPGIfO
         YqEoc/7U7D9HWcsGmanQmrsPkVRNQjEnq9Nl1A2hCdoGm94dQYHVESnepl6KfUuij6Jf
         NyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746268389; x=1746873189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBV2rGv2S1NcPt4tVHRfpNM/jvRNqsvpOuHIr/RLX3s=;
        b=cBO3Yryr80dk/X5U/hwI6CdEgn91tGV9JS94edFjH8dl9vUxZHMSMEKjU4/ipLpqD1
         FnHH95p7HLtTDwxstwSgXlIIi5ad1IXYbdeDKGozAUmdmFg9w2BAzQBFVwmhH0wO6D6e
         LZi9BTtz6YRij4Ull6nFoE3NMOV7OO9v4yAMJEDVeo0MsGaL9nX1uG+R1ClGXv/qrdKZ
         9sAkXyNBgGWV3CK/9VXcfKWVM3tMqm9FEXCwFqPWUYUIKjlbFJLwMhjuGEqIA5q4f7E4
         l4YjQQt9W4hBg7i9TqjmyBreMGDKhkhdMfzPml1snh+L53yxQeJdZlTwkb6L+/Vk3q/J
         AQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVuTSbQdjTE/kv5Mdz4BqTe2DhsG63Sz0rCeCSS/fptNDXCQUFmVfyBCiDZuDyyW6Mgdb/fuXvR6/deWPFm@vger.kernel.org, AJvYcCX/EOBG0hOw2eti+CZGwXBeyIHv/p3/mDJCpnq+XKExylCeStapq/pO7/DP3ZWuioQx4oHpH1oT/AdB@vger.kernel.org
X-Gm-Message-State: AOJu0YwWP9N3azTcREQk4zUVxPxZ7wA/elCgREQbIJ2l/nY6aKGDNyf8
	/+m3WXWOJwilHL+5fFTFTp1AIaiv8byqB9C9aZma4rp+15TRfUsP
X-Gm-Gg: ASbGnctfrw8eEV53ajlDRZvp1R0do/o6WKGV4b958WnoB7H03iCD1lO3669cURLHC77
	vVYJSmOlLxfIE94YNnT9OA13Q0OqxsskLpYIl0261TJ3Y1XxYBkDm//jqgj589iycYhOvsL7RWh
	T2wS/sHa80eGUcAxrTN4b/6uWJ9GoLx58M/cl8YOorLCxOm073Q72wVcIDpgvHzll/qavff7Ph4
	uJvjCr3fO+ynai7/huvsETKwo0Y2VZtVWm5E0G9G0hhnSez+hmDZLjvm6i5qwDaMr81pkfLFrwB
	Z+s0hr53q65/kI/YZsM9xkZLkyNTfkZw5+JH/0ESGb93a8K8MY6eRiItNbIKMC6Lp0aSsQrQlnj
	D6FI=
X-Google-Smtp-Source: AGHT+IEnmj/wELsmjhFnfT6qGiVRS7j7iGSP1/hYYVfSSSPQpy4IlL0h4sVcusqZ7jCZSfWHVvIyUg==
X-Received: by 2002:a05:600c:4f51:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-441c494870cmr5137755e9.31.1746268389399;
        Sat, 03 May 2025 03:33:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc480sm72235925e9.2.2025.05.03.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 03:33:08 -0700 (PDT)
Date: Sat, 3 May 2025 11:33:07 +0100
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
Subject: Re: [PATCH v2 1/5] bitfield: Silence a clang -Wshorten-64-to-32
 warning
Message-ID: <20250503113307.37b71fdf@pumpkin>
In-Reply-To: <20250430171534.132774-2-irogers@google.com>
References: <20250430171534.132774-1-irogers@google.com>
	<20250430171534.132774-2-irogers@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 10:15:30 -0700
Ian Rogers <irogers@google.com> wrote:

> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit. This isn't to say the code is currently incorrect
> but without silencing the warning it is hard to spot the erroneous
> cases.

I suspect that is going to add an explicit mask in many cases.
Probably for u8, u16 and u32 if the return value from the old
code would return a u64 and the value is assigned to a u64.

Now if 'field_mask()' and 'field_multiplier()' are constants
then the compiler might optimise away the extra mask.
But in that case it shouldn't be bleating about the truncation
because it knows it can't happen.

So get the compiler fixed to do proper 'value tracking' and only
report about truncation when the high bits might be non-zero.
It also needs to not warn when the high bits are saved separately
(int h = v64 >> 32, l = v64;).

Then you have to worry about stopping the compiler bleating
for the return values of read (and similar).

Once you've got the compiler fixed to remove most of the false
positives worry about the Linux code.

	David

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/linux/bitfield.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..cc5cfed041bb 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -176,7 +176,7 @@ static __always_inline __##type type##_encode_bits(base v, base field)	\
>  {									\
>  	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
>  		__field_overflow();					\
> -	return to((v & field_mask(field)) * field_multiplier(field));	\
> +	return to((__##type)((v & field_mask(field)) * field_multiplier(field))); \
>  }									\
>  static __always_inline __##type type##_replace_bits(__##type old,	\
>  					base val, base field)		\


