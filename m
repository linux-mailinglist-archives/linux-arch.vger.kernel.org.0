Return-Path: <linux-arch+bounces-3351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6C89469C
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 23:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90E51F22576
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037854BE8;
	Mon,  1 Apr 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V14wXNbf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EA54780;
	Mon,  1 Apr 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007562; cv=none; b=bSNMr7QsH+ZN8LVwdVliF3wTmpaX6Vxtv1sUDRos9pu0ntraTuPjoPCqmKjIruXmDEZgGmIySBJCV9Vmnsh41OLJARnWGZ47mRH4rH0Mo00tBcxLW6jij6w63bpaB+ivjs3ScPxSzIxf8If8e1DBxk2AI5V0hePCKadzZYKo/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007562; c=relaxed/simple;
	bh=buxczkDbw87LRqB3G3AkFGflteHI7ut4iQT5fzESfXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S90IElMQEHVtnYedMr5Y9+x5SLG0mXCo0SVZ9iXu7XYwS3mQqZzbk/RZwFVHFMDL47Rf8VMUrkG90CQzBTcIpYZDrV/UTKz7dE3vX3Drym4lE3cGWrKtRoPD9UxQZz0VQRLZ4Mgy04I3hNQq7EcaYReedpJ4pzKwi+KmRTrifmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V14wXNbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90048C433C7;
	Mon,  1 Apr 2024 21:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712007561;
	bh=buxczkDbw87LRqB3G3AkFGflteHI7ut4iQT5fzESfXo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=V14wXNbfgmxWUq6ugybjfZF0CKDf96wILwi6ERFYeEar/nFCCNQNZ/ey0g6PtieBI
	 75UkAr+2pJAxMelwZ6B7op6zf8i5x4ZDyRBnjMEbsyuVJfBT0JT8n/43YQsOXWfsEG
	 B5id4n4p1evi+1OlyvWekBKoYky5KXrp4ezqwjM++rfkOu8G18qRZzotGciuegYjOs
	 DcElSUJYSw5x2vXhJElFRp5nEcyQ5R/ByQdxEs04h22jp3Hsgk3nKyg3QQ2XETIO6x
	 YXjkwYU/2vQ1JDs7tS4SpGmWNu5HcNGITzzQEJGZs1l+yyCKhV3tPtbvNM0jKKWUEN
	 jxBhY2NTSAlNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2879CCE0738; Mon,  1 Apr 2024 14:39:21 -0700 (PDT)
Date: Mon, 1 Apr 2024 14:39:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org
Subject: [PATCH RFC cmpxchg 0/8] Provide emulation for one- and two-byte
 cmpxchg()
Message-ID: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series provides emulation functions for one-byte and two-byte
cmpxchg, and uses them for those architectures not supporting these
in hardware.  The emulation is in terms of the fully ordered four-byte
cmpxchg() that is supplied by all of these architectures.  These were
tested by making x86 forget that it can do these natively:

88a9b3f7a924 ("EXP arch/x86: Test one-byte cmpxchg emulation")

This commit is local to -rcu and is of course not intended for mainline.

If accepted, RCU Tasks will use this capability in place of the current
rcu_trc_cmpxchg_need_qs() open-coding of this emulation.

1.	Add one-byte and two-byte cmpxchg() emulation functions.

2.	sparc: Emulate one-byte and two-byte cmpxchg.

3.	ARC: Emulate one-byte and two-byte cmpxchg.

4.	csky: Emulate one-byte and two-byte cmpxchg.

5.	sh: Emulate one-byte and two-byte cmpxchg.

6.	xtensa: Emulate one-byte and two-byte cmpxchg.

7.	parisc: Emulate two-byte cmpxchg.

8.	riscv: Emulate one-byte and two-byte cmpxchg.

						Thanx, Paul

------------------------------------------------------------------------

 arch/Kconfig                        |    3 +
 arch/arc/Kconfig                    |    1 
 arch/arc/include/asm/cmpxchg.h      |   38 ++++++++++++++----
 arch/csky/Kconfig                   |    1 
 arch/csky/include/asm/cmpxchg.h     |   18 ++++++++
 arch/parisc/Kconfig                 |    1 
 arch/parisc/include/asm/cmpxchg.h   |    1 
 arch/riscv/Kconfig                  |    1 
 arch/riscv/include/asm/cmpxchg.h    |   25 ++++++++++++
 arch/sh/Kconfig                     |    1 
 arch/sh/include/asm/cmpxchg.h       |    4 +
 arch/sparc/Kconfig                  |    1 
 arch/sparc/include/asm/cmpxchg_32.h |    6 ++
 arch/xtensa/Kconfig                 |    1 
 arch/xtensa/include/asm/cmpxchg.h   |    3 +
 include/linux/cmpxchg-emu.h         |   16 +++++++
 lib/Makefile                        |    1 
 lib/cmpxchg-emu.c                   |   74 ++++++++++++++++++++++++++++++++++++
 18 files changed, 187 insertions(+), 9 deletions(-)

