Return-Path: <linux-arch+bounces-7307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D0A978EE3
	for <lists+linux-arch@lfdr.de>; Sat, 14 Sep 2024 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5306C2861AD
	for <lists+linux-arch@lfdr.de>; Sat, 14 Sep 2024 07:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FF7A15A;
	Sat, 14 Sep 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh8JOugt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0E57CA7;
	Sat, 14 Sep 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726299051; cv=none; b=MP9Ud0CnBSFTiCjyO49cjHbEcKg9du7t1FPYaZdfrdEZ9xH4XTiUWQGcHW7efBOA11aPepNU1wuMj02fPZLqJeciuklOspHTkAVL/cv/KQkHdpKvIyu3pTUsTifoS1Okec9dQHLlwhr3wQaM1LoU48Q5z30KGT03+UmmZmo6M/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726299051; c=relaxed/simple;
	bh=lIeKmaLoCOmVme4H3Fn1x8hNoYV7+LCeW9p0eyUY2Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MjPtbs7fv5KeFNWy8tyxrQzjdt7mvH8TjD1YI/T0sSpS86IM1rgp41f320ggiKhgQcNE3hHpHPiFKw3kpjheYaIZN5b82Fg2eouTvY9DXFMdQgdvCbyv63sYrAcLD/15aB7/qTsCGVdKekJl4UXXjtmRBpPhTYFNZgamdBWA5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh8JOugt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A5DC4CEC0;
	Sat, 14 Sep 2024 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726299050;
	bh=lIeKmaLoCOmVme4H3Fn1x8hNoYV7+LCeW9p0eyUY2Wo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=Uh8JOugtH46vjvYJ1roy8tS2KgMjujfju3oo3nJOMysN9yIEeHgT8HF7kd6VqrJcX
	 8/JyMvMPnIOZ7F/L4sFxceJuLVNRJXcMjRIufYdmmBhF74jMtA2Sov4biB5vYf6hXn
	 fqF1Id73rwyOJPb2ghXr4lF8Qu3Oz1d13RmkXwYktIV0XsbUZnwIJ9KIBiTwUnjm93
	 vKs128b8karEY4rltGEtvO2uXrczREHOKD5UX/nYBi3vO53YCOnZpCDygKQfntd3HX
	 geglAKFuEC0TeWqmPYJZbBMV6Q8Y1toszq/hxSB5QPIzi/k8eyHhYlx3L0ys8trVD5
	 GCXi7N3E8NtlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F18CCE0E7A; Sat, 14 Sep 2024 00:30:48 -0700 (PDT)
Date: Sat, 14 Sep 2024 00:30:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org,
	tglx@linutronix.de, peterz@infradead.org, arnd@arndb.de,
	broonie@kernel.org, naresh.kamboju@linaro.org, nathan@kernel.org,
	linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, afd@ti.com,
	eric.devolder@oracle.com, robh@kernel.org, mark.rutland@arm.com
Subject: [GIT PULL] Emulated one-byte cmpxchg() for ARC and sh
Message-ID: <c22df1ae-42b4-4a57-91f7-a02e50176ad0@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linux,

Please pull the following cmpxchg()-related changes:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.09.14a
  # HEAD: c81a748edefd098ea21dd35d4bba03f69412fc26: sh: Emulate one-byte cmpxchg (2024-09-13 07:10:38 -0700)

----------------------------------------------------------------
ARC/sh: Provide one-byte cmpxchg emulation

This series provides emulated one-byte cmpxchg() support for ARM and
sh using the cmpxchg_emu_u8() function that uses a four-byte cmpxchg()
to emulate the one-byte variant.

A similar patch for emulation of one-byte cmpxchg() for xtensa has not yet
received a maintainer ack, so it is slated for the v6.13 merge window.
If you are not that patient, there is another signed tag covering all
three (ARC, sh, and xtensa) named cmpxchg.2024.09.15a.

----------------------------------------------------------------
Paul E. McKenney (2):
      ARC: Emulate one-byte cmpxchg
      sh: Emulate one-byte cmpxchg

 arch/arc/Kconfig               | 1 +
 arch/arc/include/asm/cmpxchg.h | 6 ++++--
 arch/sh/Kconfig                | 1 +
 arch/sh/include/asm/cmpxchg.h  | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

