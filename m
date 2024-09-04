Return-Path: <linux-arch+bounces-7010-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C4C96C10B
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FE21F23777
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF91DC061;
	Wed,  4 Sep 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMaeIFXV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5A1D014A;
	Wed,  4 Sep 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461100; cv=none; b=foRrnN+A/Dsy0xiLmTjHXEab6PcaV1CzT4Y4gRW1QV0I56UE8sj2Tdqmk/rRNMW+2ijvUt//h4e+X1jHAK0CX7yLIXJHgjqedEMsiKCyRDGrsqbruIpP3CfBQ1+F730qD5C45Gm/am0NCO8tPZTQFYsk4Z83AFYfL0OFK516HGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461100; c=relaxed/simple;
	bh=ArAPCxI1Kj/v1qq50FpqqDgsTk6eZ/UAqDvPFj1T2/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOK1aiwRZ0HC6gcLsic6Sa0S1UfcrUXPUbG9sl24EUYVzci/dVcznS244Gw38aWA35jochw+JrrMX4kKyJaGSPbvFKPtbF2LZ+Zxu8Sbw1pXHON4LRPRAaeclwg7uFODgUp+SR9ia9A8QlYTe9zDysJ+dipSNx757kNN02HTE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMaeIFXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19D1C4CEC9;
	Wed,  4 Sep 2024 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461099;
	bh=ArAPCxI1Kj/v1qq50FpqqDgsTk6eZ/UAqDvPFj1T2/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vMaeIFXVmG5TwnYwCPIyHpt12OpEsK/pI0cxjWT9uUKQHp1pWc4ZBU/WcIJSR0DZs
	 QzSqsGdkj+OuQ9wXdNsaJvxdRuzx7e3Rz9elyL9vkhWYfhdY3U6Zer/Cy/8idp3bGL
	 muQdcKV7rfHrAYEc67s94wy9Lkprb7fg0VbpeKve+qiPIbqPRDqhlIDDDj+MByqxQf
	 Y1zUwjFiV5emnv2A9qfHNjTv1ELkKIhBAjN9WVVJTS0ZaVhTLaQyh5YkRMzHiDywrR
	 XRVkQT8R+O7CVZ8tJC4KewPEtHaaBpJ+a8tPYK2FYZ9y7WDWjV/gQF9x/ubByzdmdx
	 vd6yrc+Yj9Vdw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e0047fcb3aso421398b6e.0;
        Wed, 04 Sep 2024 07:44:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULFXLEc7g6WRLhuTsdqDs6nYQlciCIsPHbOeIlh0PQ09vfkq3pkMnnxWdZu3c0MhaFUz519TsbfUVR@vger.kernel.org, AJvYcCV5SjevB/WkVeO0RvA1mTtgHqW7sykecMf2tAYXYaJZsCCx/q/v9dzveqi5bk1Dd5DIbKIMU4Bo1N240QM=@vger.kernel.org, AJvYcCVpHsYVdSGteaaWFuiBd6oPJMDSjxbmuwdPKcHsTi5j7NcYsoSCykealBQog+7sERkufqvUDrOhGOnW6U4=@vger.kernel.org, AJvYcCWJBZmUMyN1gkb+GP4OONIHduk5pFwTHA6V10Ec9qUeH/UnliXZEDFe7fu8ICCr7MZqLDAackbk3zxQH44+@vger.kernel.org, AJvYcCWKKw6TBk77hqmXb0K2zscxiXahOmNBYFnGxKXCXtDUS3WOaOzkk7sKdJJO3DcHEfoqahT5qNf+@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjcRSyr85YSp1dnmBr31sF376Wc4M5LqonDw6QLMrqLYK7te5
	tfbDa6Ys7HQJF68hHBu8DRkmDI3cm9m1QVPTbQeFFXDU+E9gPh3jXXDxTHnjN29d4VMR3aUzr27
	FgBfEEldwFG+Wr7IDKFIhFvgM1dk=
X-Google-Smtp-Source: AGHT+IEv8U+fDbCjLqUFxz4//WKn6tB39IzLuCQnJWmLkgmLJZnbV32x+Njonp88P0xuQvY07t3qf0x9Ck/Ekt8R4EI=
X-Received: by 2002:a05:6808:138a:b0:3db:50ed:e121 with SMTP id
 5614622812f47-3e01315d6camr1093652b6e.0.1725461099193; Wed, 04 Sep 2024
 07:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 16:44:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_tLZ6W2gb4VbqkYhDEfA_KM2EPyogQRFZGtsN=uGdpw@mail.gmail.com>
Message-ID: <CAJZ5v0i_tLZ6W2gb4VbqkYhDEfA_KM2EPyogQRFZGtsN=uGdpw@mail.gmail.com>
Subject: Re: [PATCH 00/15] timers: Cleanup delay/sleep related mess
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, netdev@vger.kernel.org, linux-sound@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 3:05=E2=80=AFPM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi,
>
> a question about which sleeping function should be used in acpi_os_sleep(=
)
> started a discussion and examination about the existing documentation and
> implementation of functions which insert a sleep/delay.
>
> The result of the discussion was, that the documentation is outdated and
> the implemented fsleep() reflects the outdated documentation but doesn't
> help to reflect reality which in turns leads to the queue which covers th=
e
> following things:
>
> - Minor changes (naming and typo fixes)
>
> - Split out all timeout and sleep related functions from hrtimer.c and ti=
mer.c
>   into a separate file
>
> - Update function descriptions of sleep related functions
>
> - Change fsleep() to reflect reality
>
> - Rework all comments or users which obviously rely on the outdated
>   documentation as they reference "Documentation/timers/timers-howto.rst"
>
> - Last but not least (as there are no more references): Update the outdat=
ed
>   documentation and move it into a file with a self explaining file name
>
> The queue is available here and applies on top of tip/timers/core:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.gi=
t timers/misc
>
> Cc: linux-kernel@vger.kernel.org
> Cc: Len Brown <len.brown@intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> To: Frederic Weisbecker <frederic@kernel.org>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Thanks,
>
> Anna-Maria
>
> ---
> Anna-Maria Behnsen (15):
>       timers: Rename next_expiry_recalc() to be unique
>       cpu: Use already existing usleep_range()
>       Comments: Fix wrong singular form of jiffies
>       timers: Move *sleep*() and timeout functions into a separate file
>       timers: Rename sleep_idle_range() to sleep_range_idle()
>       timers: Update function descriptions of sleep/delay related functio=
ns
>       timers: Adjust flseep() to reflect reality
>       mm/damon/core: Use generic upper bound recommondation for usleep_ra=
nge()
>       timers: Add a warning to usleep_range_state() for wrong order of ar=
guments
>       checkpatch: Remove broken sleep/delay related checks
>       regulator: core: Use fsleep() to get best sleep mechanism
>       iopoll/regmap/phy/snd: Fix comment referencing outdated timer docum=
entation
>       powerpc/rtas: Use fsleep() to minimize additional sleep duration
>       media: anysee: Fix link to outdated sleep function documentation
>       timers/Documentation: Cleanup delay/sleep documentation

I like the changes, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for the series.

