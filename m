Return-Path: <linux-arch+bounces-4378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579D8C4724
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFAB281ACF
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50E3BBD5;
	Mon, 13 May 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQv2VY3r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734D3A1BB
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626098; cv=none; b=E1zQhbUVk0JpRmobYUnJVbGEZYqwrfgSmT87bZMTrjmzWxbXpQ8X+tFTkTyDGZlX1rPR7/9lnuM+BDX5jbPbP+K8yiEWzeW1q8gily8nA6aw1zbe0qCMTWr1jgFJCNu8kqQFeXdjVzqAwGEMGSXyLaCNYLtH6zwS+3CHOBFtZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626098; c=relaxed/simple;
	bh=6YuPwQ/qKNz8HYBBy+q1ODXRn/TuSyAWfvhMnueWmI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/9ja/u1d2FXtwe/wbjv1jz4dntZls/WU4fUYGCX2TsQAe25rThKxAaUL5U9xDTwBHhdsMapZsfp+uH1xGsrl/yhYidsRBMnBhV9Ah/UzH7H0pby+YpOmdChfEE1emP5Nct+ACQsWpIxvR15BxwUrzdMafMNKSdk5sSQtfyp+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kQv2VY3r; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f47787a0c3so4264487b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715626096; x=1716230896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMCvolyyAMKqM2SEdNiyJ59O3X5pzLBrCG8ngReTAYg=;
        b=kQv2VY3rQSya4uXDs+ROzi24zH2iLgT/DDvwH/Ce3mPbBzuN22DIV9mdtqws4mVnkF
         P5sC+oDe+Ml5DxmUH4o3P8IJZgV/rJ+eG96FU7wXhtSXiDahLE59Dp8yFDbNyUmQd8y+
         xxDUqgkheyCv22+fYmBxae2dszVx7POHu11TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626096; x=1716230896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMCvolyyAMKqM2SEdNiyJ59O3X5pzLBrCG8ngReTAYg=;
        b=H6I1qYJRL5BTUA5EqND/Gg4hJeX1OAx5sXCcw8bMfApWWZaI4FEZMIlF53v8a/V/xj
         9x1aVbzfV/xH85VEqsBWMbwnhpFuUYwjENnyCUjgvqYYS6HIn3I/XkKAzeObyQnsOZmP
         83RnQ3JCH57dmwUBTSTdWKEGb1Hi6x0p7BQWwITOru83/rQf26+8K8vFgWbgVhriSxN6
         ZwOc8A4XSi4s8XVuvfnLLaMuyBY7OZD6whIajLgT4aWVvDGNkbPv3CU3oBPgQYwwowPa
         Glxnepg4sv4AcYTho6Io3BsW8VUA0dkiGL01x8WrfXlg1U2gMbwZbrIhx0nBQUVdJ0C+
         8/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFngDMw0NH9bPUQpvG2fOY76tY44JDLIO8IjCzuNptk04Sc0iAVChAEt9naZingHQnypik3U+RtPDLFLGxT4RfM60dipgvrvzI1Q==
X-Gm-Message-State: AOJu0YwIhW7OnFVvr2TebM4CnhhwUFNwx5Il5WVqYv/i3hYVsUANXzRu
	uGIzVGCphtFavocKREbujjp4Zz2+LTAvAC3RFxdklWaag+zD0A4tLL6U7msD1w==
X-Google-Smtp-Source: AGHT+IHQwdGR35u5IXK+H3e3GlXqBLLrEy3u5cdZwt6vW+ynInQiPgDptXNWJrBmTpcuZ0bqtBY4aw==
X-Received: by 2002:a05:6a21:983:b0:1a7:a6f3:1827 with SMTP id adf61e73a8af0-1afde1b719fmr11220335637.46.1715626096189;
        Mon, 13 May 2024 11:48:16 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a87bb1sm7697326b3a.87.2024.05.13.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:48:15 -0700 (PDT)
Date: Mon, 13 May 2024 11:48:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
Message-ID: <202405131136.73E766AA8@keescook>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506133544.2861555-1-masahiroy@kernel.org>

In the future can you CC the various maintainers of the affected
tooling? :)

On Mon, May 06, 2024 at 10:35:41PM +0900, Masahiro Yamada wrote:
> 
> This patch set removes many instances of the following variables:
> 
>   - OBJECT_FILES_NON_STANDARD
>   - KASAN_SANITIZE
>   - UBSAN_SANITIZE
>   - KCSAN_SANITIZE
>   - KMSAN_SANITIZE
>   - GCOV_PROFILE
>   - KCOV_INSTRUMENT
> 
> Such tools are intended only for kernel space objects, most of which
> are listed in obj-y, lib-y, or obj-m.

This is a reasonable assertion, and the changes really simplify things
now and into the future. Thanks for finding such a clean solution! I
note that it also immediately fixes the issue noticed and fixed here:
https://lore.kernel.org/all/20240513122754.1282833-1-roberto.sassu@huaweicloud.com/

> The best guess is, objects in $(obj-y), $(lib-y), $(obj-m) can opt in
> such tools. Otherwise, not.
> 
> This works in most places.

I am worried about the use of "guess" and "most", though. :) Before, we
had some clear opt-out situations, and now it's more of a side-effect. I
think this is okay, but I'd really like to know more about your testing.

It seems like you did build testing comparing build flags, since you
call out some of the explicit changes in patch 2, quoting:

>  - include arch/mips/vdso/vdso-image.o into UBSAN, GCOV, KCOV
>  - include arch/sparc/vdso/vdso-image-*.o into UBSAN
>  - include arch/sparc/vdso/vma.o into UBSAN
>  - include arch/x86/entry/vdso/extable.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
>  - include arch/x86/entry/vdso/vdso-image-*.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
>  - include arch/x86/entry/vdso/vdso32-setup.o into KASAN, KCSAN, UBSAN, GCOV, KCOV
>  - include arch/x86/entry/vdso/vma.o into GCOV, KCOV
>  - include arch/x86/um/vdso/vma.o into KASAN, GCOV, KCOV

I would agree that these cases are all likely desirable.

Did you find any cases where you found that instrumentation was _removed_
where not expected?

-Kees

-- 
Kees Cook

