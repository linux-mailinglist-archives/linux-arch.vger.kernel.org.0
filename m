Return-Path: <linux-arch+bounces-8095-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFF99D486
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4751C22F2F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D681AD3F6;
	Mon, 14 Oct 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjvASecr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226C28FC;
	Mon, 14 Oct 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922969; cv=none; b=IRAS71gf3qvxOBzQ69rz568bl1v9YF1qYiZdTDH/Zqd0uiSVt0aiCkZO9iplI6NdkWE3hfqzEAAaI+4uWeJetEcQhIgWUF7NImMbmToAEIwwvr0LAfSOdkwU0YsKRWR9u4K2LBxR10nqgkBxcogDf83tYrXa196s4ks3OY7lMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922969; c=relaxed/simple;
	bh=bOmZl1NspXLcp+g5lMmcQ+7bUkVBQAQpj9wx9QBEe50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m86DeGKPH0LdBmi/G5IAqYFFew+nqzsVW9It8kNaVtCMFVpM0+pN/p4vgOgaU5R2nEj7hEIBZG/tKFY5/P9QFGTfSY2LAfuXE/fFZLaZ5cN2c3/FSY4jLsikUna34+xVSkXsNFsCHA4odXXYO72FMhqykU4NZDQoZB2i3zRO4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjvASecr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98083C4CEC3;
	Mon, 14 Oct 2024 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728922968;
	bh=bOmZl1NspXLcp+g5lMmcQ+7bUkVBQAQpj9wx9QBEe50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RjvASecrxZpOpjKcvFG+IN8xFnp2LLI7I/RQfDEumNR/fQ3dS3+ADtMMRqHsQLGWi
	 EiXcmJWG9MDl8SGDSw1DA484/IMjM+uzu5CzVDAq1/IZ1dfy10hZAX9QXRftnPsrA6
	 v7nW9WsF7Me3GHVXmVVLGWhDBdcmlR96zubbrpQBmVXykyz0gLJxLv+tGOX0yPBgaW
	 wNNbKikiZGTeIOLxImqJAKhdV5na4sITHxDQQ+sWwUK9V8CsgLugxk6mMLUctaJkSS
	 rhI/oQh4z6V+zVrzmrZ5VVbpUJF+CUwKegliRYJmKRWN42rdZBaGoSPWbfHa9aKxxF
	 ZN7b3RxDizdUQ==
From: Mark Brown <broonie@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org, SeongJae Park <sj@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, netdev@vger.kernel.org, 
 linux-sound@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
Subject: Re: (subset) [PATCH v3 00/16] timers: Cleanup delay/sleep related
 mess
Message-Id: <172892295715.1548.770734377772758528.b4-ty@kernel.org>
Date: Mon, 14 Oct 2024 17:22:37 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 14 Oct 2024 10:22:17 +0200, Anna-Maria Behnsen wrote:
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

[11/16] regulator: core: Use fsleep() to get best sleep mechanism
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


