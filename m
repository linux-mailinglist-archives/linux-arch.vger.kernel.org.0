Return-Path: <linux-arch+bounces-3612-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766F8A2375
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 03:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E2287E05
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 01:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26266AB8;
	Fri, 12 Apr 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdbONLGY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20C53A7;
	Fri, 12 Apr 2024 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886879; cv=none; b=iYBbYQt28FoCSqdBBqTaD9j3Nju9meZOoJv0gPImf0lKIRs15ox87HhJ4YNu+jjtho9KzvUE2pUONx0//EYfyjzBJ/reKR1FLmVmfPAolLeiukDocR4vv5at29wmHJbWjZdMzS2lJsng1pnKGnzOqvCpwF+KmSu7JhhL5OJRRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886879; c=relaxed/simple;
	bh=y4vlt8TB9yDjErxa7aoPppj34TQs7XIg9OjF7nGdMbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIGvdWT8BE5Yf+wceiyPfbr4z7uWtdzjoB//mOuIyjZr4Kw1o+zPEseQr8U7ZnOxFbXuu9/vCEptHFPcFszmKPjOlary1qRwfhg8UzE3TMx92fjnM0AMwRe6xxdnb0ybflM7b4oIkdRGBf1DcWRzgmTjynQ8PMPtHBGDsm+Byx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdbONLGY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-346b09d474dso363183f8f.2;
        Thu, 11 Apr 2024 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712886876; x=1713491676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4vlt8TB9yDjErxa7aoPppj34TQs7XIg9OjF7nGdMbk=;
        b=kdbONLGYw2QldU//Gv4Ys+kJRUEYyE1Wkx9stlBiRwEA3BetUjUy7y2Gg8nnVxHtvC
         0pXPmsdzzacgTPR9NmR993Ump2WWYyJwdG5+K2EZ2w2s6nY3MvjLgexU6tX8Hx7by4XB
         2B+UzHDbNTYp+uZBVmCa30o1nTv3LWe6wdDXjpCb6LK7C0+ypf/UBbG8bbnHipw8hUTJ
         8bzTRflt74OEd3O2RYQHuuk2PQh6Bexe+QuEdkpo4Mb83IZlaO0FhWRy4nulfPId7BVT
         y4c33ws+NE8f1HyOGAAjeJACZBIYI6GRZ+PbRBzhE5Za/jexbvwiULFX6iFFYOcga8ZB
         XCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886876; x=1713491676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4vlt8TB9yDjErxa7aoPppj34TQs7XIg9OjF7nGdMbk=;
        b=MVy98J8kdp+YYIOYzzRtVjsE0rJbR/J4Uzp7o4FPCoqMejHAYslhgM/IjR8ITLx4U0
         f7ZNFdIt1KWWFEtNq3DOe1YDCFuK/y22TaaKvVZIGihEFvKgArzNZI6PvkH1ublYNx6l
         1z0yDeRl63OoY7k9v12fvvHLDU38lMP5MJHmGpQBYuHtYqb9CcZB6GVCR2p+FrY2zE7Z
         KE8+tGw604ZmFJu9nQhsY2Rv7qZEHEGhHfTLhsEwjrIBfhG75F/2/d4POk6ki4CPbvkZ
         CDBN39llaxrBznXNXSCvJYWbnGhtVsXp+Sq/lkxCDO/u3D4NRvnkDcY4rL2E2URa/lGz
         q1cA==
X-Forwarded-Encrypted: i=1; AJvYcCW5x1fawopXJpoluSTsfIHvpSLEkIxw8ZGEuQ+hXhwgx2AWtMJR3/EpzP6ZGasBkUxcN4M5NyiiiAE56NAHrWEzfQEalR5o6i0MSkzaU/Jkp27fF4HRbDYMRG/cmUtCq1osqZc0exrR8Q==
X-Gm-Message-State: AOJu0YxTdC39WWyCmGBK1x+9QA6pmeg2WNZTYLc7dLicm5eT8KUA9elf
	XRO0tJLhIE0gsio+OnnTeo+qTE4AguL9z4SMFbL8XiaGn4RKRfdW5onGQr2k1t5AjzvPo7YMMny
	1+EVKf0weLc6clnSz8zhAx70UKgm6DMV6
X-Google-Smtp-Source: AGHT+IH+PR4h3oVtQ8Ez0cRs6zyDvlUxECTYXxWqfVRSac34W79R5yeA3Zq4bIaDyQbovOeeCgfyqRUJHwPOnRqGQX0=
X-Received: by 2002:a5d:474f:0:b0:33e:ca28:bb59 with SMTP id
 o15-20020a5d474f000000b0033eca28bb59mr856430wrs.57.1712886876424; Thu, 11 Apr
 2024 18:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com> <87wmp4oo3y.fsf@linaro.org>
 <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com> <87wmp4ogoe.fsf@linaro.org>
 <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com> <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
 <c0e170f7-5498-40ed-ba35-2ac392c2dd2a@app.fastmail.com>
In-Reply-To: <c0e170f7-5498-40ed-ba35-2ac392c2dd2a@app.fastmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 12 Apr 2024 11:54:25 +1000
Message-ID: <CAPM=9ty_9yKEk+cS6oJ8gD_UiB_K4X3P4mLv2RmKixLaq-1RfQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 17:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 11, 2024, at 09:15, Ard Biesheuvel wrote:
> > On Thu, 11 Apr 2024 at 03:11, Samuel Holland <samuel.holland@sifive.com> wrote:
> >> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> >> > Samuel Holland <samuel.holland@sifive.com> writes:
> >>
> >> >> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
> >> >> 32-bit arm until we can provide these runtime library functions.
> >> >
> >> > Does this mean that patch 2 in this series:
> >> >
> >> > [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> >> >
> >> > will be dropped?
> >>
> >> No, because later patches in the series (3, 6) depend on the definition of
> >> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> >> find a GPL-2 compatible implementation of the runtime library functions.
> >>
> >
> > Is there really a point to doing that? Do 32-bit ARM systems even have
> > enough address space to the map the BARs of the AMD GPUs that need
> > this support?
> >
> > Given that this was not enabled before, I don't think the upshot of
> > this series should be that we enable support for something on 32-bit
> > ARM that may cause headaches down the road without any benefit.
> >
> > So I'd prefer a fixup patch that opts ARM out of this over adding
> > support code for 64-bit conversions.
>
> I have not found any dts file for a 32-bit platform with support
> for a 64-bit prefetchable BAR, and there are very few that even
> have a pcie slot (as opposed on on-board devices) you could
> plug a card into.
>
> That said, I also don't think we should encourage the use of
> floating-point code in random device drivers. There is really
> no excuse for the amdgpu driver to use floating point math
> here, and we should get AMD to fix their driver instead.

That would be nice, but it won't happen, there are many reasons for
that code to exist like it does, unless someone can write an automated
converter to fixed point and validate it produces the same results for
a long series of input values, it isn't really something that will get
"fixed".

AMD's hardware team produces the calculations, and will only look into
hardware problems in that area if the driver is using the calculations
they produce and validate.

If you've looked at the calculation complexity you'd understand this
isn't a trivial use of float-point for no reason.

Dave.

