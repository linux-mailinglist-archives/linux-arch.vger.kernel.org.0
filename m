Return-Path: <linux-arch+bounces-12483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE8AEB90A
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194233A7E3A
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3492C3745;
	Fri, 27 Jun 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGV9S0Du"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B2294A11;
	Fri, 27 Jun 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751031272; cv=none; b=gNxoOmHHXVRcHT0qWAx1YH4UfCbYOniTLg8c8VXJzkDVaK4p+dvAYILbyggNqMmxWIGiX+zWw1RlYbK+dYgk/F+A2BlLsqDtgVnsOuVFQnqiyf7YI6zhiG68dOy6kGFuGCaG9zhL8Qv2YY36k7XNtZRIX2PUMAm0Z8wJJF4mqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751031272; c=relaxed/simple;
	bh=IdTDvFP8y9HaGTCvvR1/VaHuRyW7QodsgF7bM8TCSI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaS+wc5JkZOe2me+Z7LcxIIMGnf4Jv+0umGTRNzsyrNRgCFZPrWXkJJPcVz50Qck1Zi/SFrdmdE+VDfxCFk1D8qBB94MjLKLgm3/gaZJrGYUoIxDJWbC1sYnCBp6iCMQ2jyX0JzT1P/Ze5sdeGDJESG3XUAqpD8UfUeIKoRGNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGV9S0Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E84C4AF09;
	Fri, 27 Jun 2025 13:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751031272;
	bh=IdTDvFP8y9HaGTCvvR1/VaHuRyW7QodsgF7bM8TCSI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dGV9S0DuN0PMGbTcSCHn0V2FGwVDGdhEXR3I4FUJ9/YySKuhAQSzKWPC5ArWakjbs
	 XMCzbvUTLK5/R4eWuNHhnTwGYwtNaTvcvZbW+yOcOodJ7GCu0IPv3sjktwFI61jyAF
	 lTQ1sTzZOWVnU/Z1TE+0I0WhZAqmS/cmZhnI+E1OFdwbY3JnZ6CdPRijk0ixaTUovH
	 d2cDv6ytpRwCYMhPVUxh4+5zaK2odYUEDjwzn6Bh8ltMFRnKzp9MEgNZioFt8bh2tY
	 KYP7clxaiDJN2XrmKDUc/aMiPoebM6CREcwsnP0YOgS3Ous7gPnpoqOUXsZni2JYii
	 AFtzOAC3SJMJQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so3820707a12.1;
        Fri, 27 Jun 2025 06:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsM2TJeCdXlaU1Fnb+0wmEG9C8FPSwvJGpc7CY5F0SiKUEIptFpF4e/Sf9HI807m/9qKSA4eNSc1F9@vger.kernel.org, AJvYcCVxPllmP9ne0g6s/6Lsc97a2zjxQsW1WkZgfqVECjxinFBuargabvaQoRPqMKjN7irD/TgE7CWtm6pBWywi@vger.kernel.org, AJvYcCXMOZYFfQjZ6suYXUsaoW8mMkUXqWXOksJ4GvYbTawE2IBSRRYIAwbZ3Otyn6qFCeSm0JTWwPRHqtSYLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZapbGPiLWC0AQ46P38+p6fD00hRsS/sspYkPJ/BZxRKUT1KED
	HQA9IXwhiHFQnngKmBwxLKFyB14KWfbr5EAuQ+DT81HP4qI1StdolYALycc0+YGf6GOM+D4WmIt
	VOhP705aXn+aFFEbqcyyHpC5Fquwu1w==
X-Google-Smtp-Source: AGHT+IEVRFNBFlTP6R9fUrxtJFc+ywLiUb4Q+PsDVjgttF7BLiyvAKx8hYh9X9Oqt+d5yA8ADVKHtkuR4NjvhsGbj6E=
X-Received: by 2002:a17:907:7f14:b0:ae0:c561:b806 with SMTP id
 a640c23a62f3a-ae3500f276fmr296866566b.37.1751031270546; Fri, 27 Jun 2025
 06:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
In-Reply-To: <20250625085715.889837-1-daniel.lezcano@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 27 Jun 2025 08:34:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLNQ729cwSEUnk5bNMjhJR7WTqcPPh1uL4suN1GhNhRMw@mail.gmail.com>
X-Gm-Features: Ac12FXxw2NuGvxwtqORXKtaK75DRC2OKF-_MV83Pl275d2zGx8F2rQx8EOkHjI8
Message-ID: <CAL_JsqLNQ729cwSEUnk5bNMjhJR7WTqcPPh1uL4suN1GhNhRMw@mail.gmail.com>
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	lorenzo.pieralisi@linaro.org, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 3:57=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> In the context of the time keeping and the timers, some platforms have
> timers which need to be initialized very early. It is the case of the
> ARM platform which do not have the architected timers.
>
> The macro TIMER_OF_DECLARE adds an entry in the timer init functions
> array at compile time and the function timer_probe is called from the
> timer_init() function in kernel/time.c
>
> This array contains a t-uple with the init function and the compatible
> string.
>
> The init function has a device node pointer parameter.
>
> The timer_probe() function browses the of nodes and find the ones
> matching the compatible string given when using the TIMER_OF_DECLARE
> macro. It then calls the init function with the device node as a
> pointer.
>
> But there are some platforms where there are multiple timers like the
> ARM64 with the architected timers. Those are always initialized very
> early and the other timers can be initialized later.
>
> For this reason we find timer drivers with the platform_driver
> incarnation. Consequently their init functions are different, they
> have a platform_device pointer parameter and rely on the devm_
> function for rollbacking.
>
> To summarize, we have:
>  - TIMER_OF_DECLARE with init function prototype:
>    int (*init)(struct device_node *np);
>
>  - module_platform_driver (and variant) with the probe function
>    prototype:
>    int (*init)(struct platform_device *pdev);
>
> The current situation with the timers is the following:
>
>  - Two platforms can have the same timer hardware, hence the same
>    driver but one without alternate timers and the other with multiple
>    timers. For example, the Exynos platform has only the Exynos MCT on
>    ARM but has the architeched timers in addition on the ARM64.
>
>  - The timer drivers can be modules now which was not the case until
>    recently. TIMER_OF_DECLARE do not allow the build as a module.
>
> It results in duplicate init functions (one with rollback and one with
> devm_) and different way to declare the driver (TIMER_OF_DECLARE and
> module_platform_driver).
>
> This proposed change is to unify the prototyping of the init functions
> to receive a platform_device pointer as parameter. Consequently, it
> will allow a smoother and nicer module conversion and a huge cleanup
> of the init functions by removing all the rollback code from all the
> timer drivers. It introduces a TIMER_OF_DECLARE_PDEV macro.
>
> If the macro is used a platform_device is manually allocated and
> initialized with the needed information for the probe
> function. Otherwise module_platform_driver can be use instead with the
> same probe function without the timer_probe() initialization.
>
> I don't have an expert knowledge of the platform_device internal
> subtilitie so I'm not sure if this approach is valid. However, it has
> been tested on a Rockchip board with the "rockchip,rk3288-timer" and
> verified the macro and the devm_ rollback work correctly.

Have you looked at the SH "early_platform_driver"? How does this
compare? IIRC, that used to be generally available, but has been
pushed into SH since that was the only arch using it and no one likes
it.

Rob

