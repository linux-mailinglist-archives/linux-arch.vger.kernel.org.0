Return-Path: <linux-arch+bounces-5389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76112930AC0
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2024 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D47A281205
	for <lists+linux-arch@lfdr.de>; Sun, 14 Jul 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9BB13A414;
	Sun, 14 Jul 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6Cn7zjU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97617F;
	Sun, 14 Jul 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720974106; cv=none; b=uBal+RbMcuTPxBIEpGwJ/nZIN/aRFYwASpteXsSkz7PMZ3xEHTa1LD13Oc4Iai+tYSM6yObYNo3ADq1J85V8BbcT2GGRpxLNff3KnP7/46V8Dksme2fEQwhafU2c7xIC9dYScTX55SmEbDNDKpMEpFrlXLmg2D2knpIApRt49hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720974106; c=relaxed/simple;
	bh=29KduC3p2qvfFgWlffHXfswu7lsTeUXhlp7NOXxCWEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ugZ8jidY7iUINlUrxXOy2mNqUcmUhC2Ywu85n+YnORt+HmcAbN7t3eWDDzsYNo6k4B5S7eelF21mCI29/cD5iMPDQX55GOzZG7fWztGNP+qIMjDdVf2C8Zdtc9TsEiOMRHmXWjVY2oOYGHAGeuGQlDeGjwtDIbkxy2gZM4fnNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6Cn7zjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9BDC116B1;
	Sun, 14 Jul 2024 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720974106;
	bh=29KduC3p2qvfFgWlffHXfswu7lsTeUXhlp7NOXxCWEM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=p6Cn7zjUGKbw5N2rKCLNxJt6FwTGvrl0iG8uSK5b6SSxAAWYml4SqD6asew949Csu
	 iHrqNp9XHi4BPYpsy0oZ24IqVVCW/9Wu+AaKrsKvO2qXcIiLr7SC35h5Z5xHmfXIxW
	 f9f8ej39n1SWYWovjW6fbU64Ii1kg7tYkxrQgZL9xzQQVGxx9iGWfwNU/4AdqQyMzA
	 i54bgNM8ufl9WPC6jN95QQ0h8w8wzdw+AWTnjNwwwLB8rp+glKv5A2S6Yw7CKJQEvx
	 FARa6sCUBZI33oSFBg754PWzzPVu0ya7pd8b9UzexV0wlUo/8hpO3b/IWqqIdZG8RE
	 vf5tWK6G2JRZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E4AD7CE0B34; Sun, 14 Jul 2024 09:21:45 -0700 (PDT)
Date: Sun, 14 Jul 2024 09:21:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, arnd@arndb.de, broonie@kernel.org,
	naresh.kamboju@linaro.org, nathan@kernel.org,
	linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, afd@ti.com,
	eric.devolder@oracle.com, robh@kernel.org, mark.rutland@arm.com
Subject: [GIT PULL] Emulated one-byte cmpxchg() for ARM
Message-ID: <52c8725d-7fdd-4fd5-a773-9a347a8837b2@paulmck-laptop>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/cmpxchg.2024.07.12a
  # HEAD: f1b5644862c5b594f48ad01d7880a96b95d83a2f: ARM: Emulate one-byte cmpxchg (2024-07-04 13:32:41 -0700)

----------------------------------------------------------------
ARM: Provide one-byte cmpxchg emulation

This series provides emulated one-byte cmpxchg() support for ARM
using the cmpxchg_emu_u8() function that uses a four-byte cmpxchg()
to emulate the one-byte variant.

Similar patches for emulation of one-byte cmpxchg() for arc, sh, and
xtensa have not yet received maintainer acks, so they are slated for
the v6.12 merge window.

----------------------------------------------------------------
Paul E. McKenney (1):
      ARM: Emulate one-byte cmpxchg

 arch/arm/Kconfig               | 1 +
 arch/arm/include/asm/cmpxchg.h | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

