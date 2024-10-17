Return-Path: <linux-arch+bounces-8251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FCE9A24DC
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DDA28B6D0
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E81DE893;
	Thu, 17 Oct 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJPU1l5K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4141DDA24;
	Thu, 17 Oct 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174803; cv=none; b=AhLeotwwISopy5qsbBvl1Anh+uiFjE0Md4AEPBwrjmRTodMwcm7S0MDwn4OY1H3DJboFn5bN+e/8PrT4kZQvz7GXCTYG1G1BskrUW2MZ1XPGyiYefgxjDBfDpKG4dDmIoEewLMyxs0qKr3KhezOUEUH6EumPVcvAoP9lxZWND00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174803; c=relaxed/simple;
	bh=GLCrs3Dovv1NiZDErsK/6Wy5iJ7ydSzeUdxuxMzzEbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NgzOwb45mQG5PO3HA1c58AGE4SKtGW0TQ19UOrTY6Z5Yj/Fo0yCR/IDE79NylduH9ozl4i207Xo283Z41mFlLjenZW6ohF6Cprl29NSHT7TqZHQbnaumokOmJXwzpaG5r08ixKt+mGXUEaLEEY7IttzH0OScR7aYVOFI9dLVrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJPU1l5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855DFC4CEC7;
	Thu, 17 Oct 2024 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174803;
	bh=GLCrs3Dovv1NiZDErsK/6Wy5iJ7ydSzeUdxuxMzzEbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cJPU1l5Kps56v8mtpHDahoOu/sesVEsbfkxPxTBjZJUFVPTfhquqJmMWgfV57Mzxr
	 g1rd1vIx0qWhbCmkzM6IbOU0nOCP1F0T68LieQMKCfZIshfUbktERB0aoZhno+uJIB
	 A5o+vNmH35gCfzcJ1QOdrFU13evRECzSwE6VGCf7j0zJO0BnRmoebOmEkEyOrIn/Fv
	 R89L1k8bbBzfwhnKPHRNxgVxbKJcHvuhl0Yv/hVpD8djyoy1qYZwYfCn3aQs2Yl9av
	 VvVxXTl2yNmlJn7lkLhFj8V6hfAEtpxPJ6+iyN7zNxSED2vaeBmgGrG4sDBsIoQhrm
	 +AHc8oQp8Nn9g==
From: Mark Brown <broonie@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, SeongJae Park <sj@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
 linux-arch@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 netdev@vger.kernel.org, linux-sound@vger.kernel.org, 
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 linux-media@vger.kernel.org
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
Subject: Re: (subset) [PATCH 00/15] timers: Cleanup delay/sleep related
 mess
Message-Id: <172917479725.89568.14288418643818666155.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 15:19:57 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 04 Sep 2024 15:04:50 +0200, Anna-Maria Behnsen wrote:
> a question about which sleeping function should be used in acpi_os_sleep()
> started a discussion and examination about the existing documentation and
> implementation of functions which insert a sleep/delay.
> 
> The result of the discussion was, that the documentation is outdated and
> the implemented fsleep() reflects the outdated documentation but doesn't
> help to reflect reality which in turns leads to the queue which covers the
> following things:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[11/15] regulator: core: Use fsleep() to get best sleep mechanism
        commit: f20669fbcf99d0e15e94fb50929bb1c41618e197

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


