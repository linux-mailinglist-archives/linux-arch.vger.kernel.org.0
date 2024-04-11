Return-Path: <linux-arch+bounces-3557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA48A0978
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6CBB21CBE
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A813DBA8;
	Thu, 11 Apr 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoTjX5JU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA463D;
	Thu, 11 Apr 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819756; cv=none; b=lRTPhAt1f6YJwPHO9NkC6mJEQhz00U/Ez91iTb338UAHD6q19PQxEIiKxxGfJRiAhhY1SFHsrqH1puu0M4haTpAGDaQXdqr0e41jMh4SwiMz4CMbbCpHFUgT0DCgSiWnRz/O9zcQk4J8l2V4kijVT+5dboU5HGfFBWd6k00OWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819756; c=relaxed/simple;
	bh=EGxUFWIY3FhDr3OERYjKXmTSAvHQ47fM+usiXa4A2Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyKFHolpue8BiJhsh/AI/asY6Wwx8I5PgTK1gGlln6YE5vrGuB5FREzbs6x2nUI7BZQyPehayd8UlYTpJR0xMMlu8QZsY3tKZSg26007Tt2NKJdufkW5/CYc7+ijpTB/K+LWoTx3tbp2SRuFAY9fSrAeX3nKGvv6pUVgHkBOZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoTjX5JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C20C433B2;
	Thu, 11 Apr 2024 07:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819756;
	bh=EGxUFWIY3FhDr3OERYjKXmTSAvHQ47fM+usiXa4A2Co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PoTjX5JUmRzsaa0P9y56kJydskXtPGFPN262bWdaHgDQod2o3roC0PZCNerABsCwG
	 bfYoknQIk2nufau511D9CeAz99/c+XBDYy9O7yS9Z1jFNFtUA7xvKQxJ/mBKdpOcAQ
	 8oBKA5LroCCkdcvSrmvcnHz8S4wEMgGzlbJBgQOBAwfoqFEvq51qHBY4tBRmieeKdp
	 K1V/z2yZw+dZ7cxWukX9RlSxbg26oONq6miKxZS20ViA44IL5h1YPGHEH4QM1NDmps
	 q4uBHpt3fB7RefgLPmbmEkh8QFaXUgnwKcsoM6Ruke9SxJbcWtDtjMPnbo5XIn7C6E
	 5gAsmHwkNvlMw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso35625111fa.1;
        Thu, 11 Apr 2024 00:15:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrA+GcYGtmGo5jFBzRGVVqOYE67safUu/mkyLoBD2mX67rtbixn8vJrd2NrQDjrVP+dXRZnUudI/sZHZscMtUEBVfsuA+LMMyP0sl0+hOJd+KUdqmZZQRBsmxVoN0nNuRS6g3c5XX2ZA==
X-Gm-Message-State: AOJu0YzTsuzoZEWAdmkBwpMjtZPAe7w9SMph0oy8/xL+TgzvXoZ1sXdl
	80qsmm3CsrwZyc82OzlIzHDJffBKNOwPmhL54bKRVIDiXLIBv0LWC5lH2PlOEp4DLtgPjLZJV8l
	4BuLj1q/iDCmhiuwv4yZ2dYZPyn0=
X-Google-Smtp-Source: AGHT+IEIbzlNGUw7dH6rrBUAPRiam7orrjfOi6n1jf8KoAxJeALyXjve8wFV4wHUyAY7FtZhkFPztybk10CRfm7afS8=
X-Received: by 2002:a05:651c:211e:b0:2d8:d8b5:73d4 with SMTP id
 a30-20020a05651c211e00b002d8d8b573d4mr2830394ljq.4.1712819754902; Thu, 11 Apr
 2024 00:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com> <87wmp4oo3y.fsf@linaro.org>
 <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com> <87wmp4ogoe.fsf@linaro.org> <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
In-Reply-To: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 09:15:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
Message-ID: <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"

(cc Arnd)

On Thu, 11 Apr 2024 at 03:11, Samuel Holland <samuel.holland@sifive.com> wrote:
>
> Hi Thiago,
>
> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> > Samuel Holland <samuel.holland@sifive.com> writes:
> >> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
> >>>
> >>> Unfortunately this patch causes build failures on arm with allyesconfig
> >>> and allmodconfig. Tested with next-20240410.
> >
> > <snip>
> >
> >> In both cases, the issue is that the toolchain requires runtime support to
> >> convert between `unsigned long long` and `double`, even when hardware FP is
> >> enabled. There was some past discussion about GCC inlining some of these
> >> conversions[1], but that did not get implemented.
> >
> > Thank you for the explanation and the bugzilla reference. I added a
> > comment there mentioning that the problem came up again with this patch
> > series.
> >
> >> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
> >> 32-bit arm until we can provide these runtime library functions.
> >
> > Does this mean that patch 2 in this series:
> >
> > [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> >
> > will be dropped?
>
> No, because later patches in the series (3, 6) depend on the definition of
> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> find a GPL-2 compatible implementation of the runtime library functions.
>

Is there really a point to doing that? Do 32-bit ARM systems even have
enough address space to the map the BARs of the AMD GPUs that need
this support?

Given that this was not enabled before, I don't think the upshot of
this series should be that we enable support for something on 32-bit
ARM that may cause headaches down the road without any benefit.

So I'd prefer a fixup patch that opts ARM out of this over adding
support code for 64-bit conversions.

