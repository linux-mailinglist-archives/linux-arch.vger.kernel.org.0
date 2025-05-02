Return-Path: <linux-arch+bounces-11795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B15DAA7177
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B466464C04
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EFF2550AA;
	Fri,  2 May 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJRevxLE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78C253B71;
	Fri,  2 May 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188243; cv=none; b=EQyrrgK3+Nzp9l9d8j7IxtrQKJZm7vnsNPnKhoox2PWSS+zONu/+CQLkX3LndiyydxDwxroc0j5jjGShr3U+iWmvYmhVkZoXzp7c0JGDsSqRBNgiKSW4H8JmxpicmVXHCc12sQzEOlUXj7y17zNdvdEximpGBOlP4hyxJKEJ06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188243; c=relaxed/simple;
	bh=4wbgRYNXz6Heu23u130WXz2Ie3l2+rM1ky9/GtEsM/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO7l42YR4oio6/WM6ngbNOWq4ZkiBQ7dq2WRz8iVsD2AZyz3mr7AovupfUidivtGeNIvxa4lhyJUjnu6kF8Bwp0rEbljDYIpRvEo4LsQldVSEFy9xULfwInJn1bCNOIGALYCeg0gcZ+7C50ZaT/d5gwbkYSN9Ffq20qof1NSUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJRevxLE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso1175622f8f.1;
        Fri, 02 May 2025 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746188239; x=1746793039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=briwm5ooAxRyu9iD9OhCO5jhS4ZNlh92ZAJ4LiUJhxY=;
        b=bJRevxLE61MK7D8CI3Yj7wd6ANWRuM67LqijACYjgQd7lq8WM+Wag9q21N21xJp1Jl
         xoTIU0cRqlF2OxdzvvcnLJoz/NGBD6MPwkq3XSf4oa/nINce7sEoqdxjeFE1kcaW/DVO
         FuIzHksLTK/iH2IrcSfpgT57fcFZ4bIigCZrOMousw1lgFT/XibAsRBJSaS4IEgLByG6
         wxUplaGU/2oa7FvKb0d6LpD8StbPv3Er2snEGRNx1BI1TR/0FheuAXPU2gpfR6JtAW3V
         nodzPNZH2x3gw9ZT0NB+mN50GlC0hcwMqx4Gqi3BBMSw0lfudw2dOgidIaDRt8K1FOtn
         pb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188239; x=1746793039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=briwm5ooAxRyu9iD9OhCO5jhS4ZNlh92ZAJ4LiUJhxY=;
        b=XKXsspMhhSaXpldnk7mQB/5xhbr5A653CrMQier/XXPv881AVQ7ZyE8ibRlGn3mtEm
         SIhVzok6cqejATteN1Xdpvwyg1lgwGUmh+xfiM6T2mMV7LjPdWzGDz0ZckiP1Zn7AWfJ
         GiAlJyLBW5R5+H75OcxM4k3vIxt/Ye8DRkhU2H0sxBdIMTtk5qoyLQAVwaUGfYEusSj5
         lQ1psD0Mq37ExO06FsH0o6nC5yQyiMjQhsHHN2rJOD6Y3CItywLlpdDRsJz3boi2DXZv
         UxSBQahNA9MUbOi1LLtflZNW1gWsWJ7rLnvFK2L5Tc6CJgHJNSYrDYnw5Pgk9vUhgXte
         3Ndg==
X-Forwarded-Encrypted: i=1; AJvYcCVVZy3BtPrduvOJ9Sakk5rKxbTcydW9I3Jl+5iFH56YKXABb94fmSPM46pa6OabhPwwIBOe4DPmsger@vger.kernel.org, AJvYcCWlxfzRJ3Y6dqRlnT1hyEV2O6lP1I5cEcmQEy6fLA1ESXEZnTONROSKdgT5iCOejP2Mr8jfagFZxw5VWS6d@vger.kernel.org
X-Gm-Message-State: AOJu0YwIT8H+W6y9AwoPKKkvnOd8VWGUv5AT6r0N77iF9B02Y0UTOv9P
	ENYtvXhHWYexFnS849YIC4+BdvfeA46v4Py1ql1RYrF6ANmctN6T
X-Gm-Gg: ASbGncvReLObqABpph9PDSe7JDEKOMIXRwOdBOqVvkLqfdosWTql++GQ2oVm3jQ7XkB
	W2wRiIG0ZNDnTfN+AewGlMaN0Q66HU7sCbuX8rF7b644wCvLQk3je5xZcZQcNvGgp5C5SygZLeD
	qJFiEARX1HNpVPwPhEwtn56YwkCma50RsstJQob1NzTPk1T5ZF102q/gwtLrnxKNzEq0Z3BnJMg
	FN9AizaUbAqcKC9cBYuz5GEpoPdTlOz9++ag/XC2iyLl5BlZaHE36A8ala0FsybRubDIDrN9kWu
	oqCRlybpuMU4zI/bhemjnJ/GZitvYfpm2Hy8tBo2mYog/hD3EHMON0pYkQ/m2wPdc6PKLG5a6Wr
	9QWE=
X-Google-Smtp-Source: AGHT+IEIG3mjr93MsKdu6mTI7c0HzAfynRUUo2gBbYpI6a+TNHWHTrdGPuaGpbRxVWPG7gOzPGLOFA==
X-Received: by 2002:a05:6000:178e:b0:397:8f09:5f6 with SMTP id ffacd0b85a97d-3a099ae96e3mr2270971f8f.47.1746188239357;
        Fri, 02 May 2025 05:17:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffd5sm2001845f8f.70.2025.05.02.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 05:17:18 -0700 (PDT)
Date: Fri, 2 May 2025 13:17:17 +0100
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
Message-ID: <20250502131717.69af6fbe@pumpkin>
In-Reply-To: <CAP-5=fVjAR0g=wN8sWetHoNWdoDVGNoKb8d8UdwxF_te=wmMLA@mail.gmail.com>
References: <20250430171534.132774-1-irogers@google.com>
	<20250430171534.132774-5-irogers@google.com>
	<20250501210729.60558b33@pumpkin>
	<CAP-5=fXrhsZYJwjJzqb-zMg+UoC-bKoYCjstq8yD9wHNCfbS5g@mail.gmail.com>
	<20250501212659.7e642411@pumpkin>
	<CAP-5=fVjAR0g=wN8sWetHoNWdoDVGNoKb8d8UdwxF_te=wmMLA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 14:11:59 -0700
Ian Rogers <irogers@google.com> wrote:

....
> Sorry I don't understand what you're saying. Java certainly has bugs
> in this area which is why I've written checkers like:
> https://errorprone.info/bugpattern/BadComparable
> For code similar to:
> ```
> s32 compare(s64 a, s64 b) { return (s32)(a - b); }
> ```
> where the truncation is going to throw away the sign of the subtract
> and is almost certainly a bug. This matches the bugs that are fixed in
> this patch series for the perf code, in particular an issue on ARM
> that Leo Yan originally provided the fix for:
> https://lore.kernel.org/lkml/20250331172759.115604-1-leo.yan@arm.com/

That code is wrong with or without the (s32) cast.
And the explicit cast will hide the compiler warning.

If you want the compiler to find bugs you need to reduce the number
of casts to an absolute minimum and disable/fix the compiler warning
for false positives.

These type based (rather than value domain) warnings are all a PITA.

Another example is the 'signed v unsigned compare' which bleats for:
	int rval = read(... sizeof (foo));
	if (rval < 0)
		return -1;
	if (rval != sizeof (foo))
		// truncated
Whereas a statically_true(rval >= 0) test will pass.

	David

