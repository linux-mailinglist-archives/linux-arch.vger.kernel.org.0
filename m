Return-Path: <linux-arch+bounces-4678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA48FB9C3
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260041C216E1
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A30146A7A;
	Tue,  4 Jun 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQMSV9Ti"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1B145B15;
	Tue,  4 Jun 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520548; cv=none; b=eucjsNC9g3qhcU7yKn8e/I33xTHMGWNPzLKgnGRlQqGNtoz8sdCcxl3p+lpd/gL0beWyFKoj9U22xOvxQ9BTioUfKv+1vfbw1ZC8NsBh0dt6WpyMHfF11SJQ0FMStyB9OHhEF7XiN/PPcWE+7gBlwBHFmC6rQOZ6pJt5O59yN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520548; c=relaxed/simple;
	bh=ttCF5offEc5Dk77UJXmI99po7vaRi0r17j2E4t1YhSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSKPPWtnt+pcSFeUEeiRiVJf8aS67jZKTZ9Fam+1GVF/I/JfSZ2rh/Tw7VzSaDwDq67ZclrjSvQvsmmBDcYjY3Ye5raV+Nz3ICJxIMkCTW2sQoPrQKDIlKk/YmNI9dzbK0n7ZJF5y/Nf7ID+Oq3FpqSzuIxoFWlSCfk497ufJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQMSV9Ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781ACC2BBFC;
	Tue,  4 Jun 2024 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520546;
	bh=ttCF5offEc5Dk77UJXmI99po7vaRi0r17j2E4t1YhSo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bQMSV9TiAPDN4JoyKAS68RX1jzJWNzkdCoL5Du0VgjKgHsblV1iI9A+DHGRLR8bIQ
	 58GVhnKs2sU2H00ia+8pbM0ynER+tSd4xQSuiM4u/kQhtM7skvwbqQQVp7yptm5KMt
	 05yshSNK9e+QVRU/1lhpbvuGwGerdqnrnZ2zr6bmgCLgpuetUFKm8GfZ52Pb7MxBnk
	 pO3WYf9rd1kiAytAHT8J0uVVrhQNK/gLuGX/wgaKmpjM6KqByfG8ZlnlfDiEJvGteL
	 ypEx0S7OB6PvmNN1QsFIS9mm5SVejtDEAuEuYVE4VFPdUWtafHB9z+m6CtiSdu7Wn4
	 wCnBp+SfQjWYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 24EB6CE3F09; Tue,  4 Jun 2024 10:02:26 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:02:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 cmpxchg 0/4] Provide emulation for one--byte cmpxchg()
Message-ID: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>

Hello!

This v3 series uses one-byte cmpxchg emulation for those architectures
that do not support this in hardware and that are not already using this
emulation.  The emulation is in terms of the fully ordered four-byte
cmpxchg() that is supplied by all of these architectures.  This was
tested by the csky commit already in mainline and by making x86 forget
that it can do one-byte cmpxchg() natively:

f0183ab28489 ("EXP arch/x86: Test one-byte cmpxchg emulation")

This x86 commit has since been dropped from RCU in favor of the
aforementioned csky commit in mainline.

Once one-byte cmpxchg emulation patches are in mainline for all remaining
architectures in need of it, RCU Tasks will use one-byte cmpxchg()
in place of the current rcu_trc_cmpxchg_need_qs() open-coding of this
emulation.

The remaining patches are as follows:

1.	ARC: Emulate one-byte cmpxchg.

2.	Emulate one-byte cmpxchg.

3.	Emulate one-byte cmpxchg.

4.	ARM: Emulate one-byte cmpxchg.

Changes since v2:

o	Dropped the sparc32, parisc, lib, and csky patches due to their
	having been accepted into mainline.

o	Added a 32-bit ARM patch for systems with v6 and earlier CPUs.

o	Apply other feedback from review and testing.

Changes since v1:

o	Dropped riscv patch in favor of alternative patch that
	provides native support.

o	Fixed yet more casting bugs spotted by kernel test robot
	and by Geert Uytterhoeven.

Changes since RFC:

o	Add native support for sparc32 and parisc, courtesy of Al Viro.

o	Remove two-byte emulation due to architectures that still do not
	support two-byte load and store instructions, per Arnd Bergmann
	feedback.  (Yes, there are a few systems out there that do not
	even support one-byte load instructions, but these are slated
	for removal anyway.)

o	Fix numerous casting bugs spotted by kernel test robot.

o	Fix SPDX header.  "//" for .c files and "/*" for .h files.
	I am sure that there is a good reason for this.  ;-)

						Thanx, Paul

------------------------------------------------------------------------

 arc/Kconfig                  |    1 +
 arc/include/asm/cmpxchg.h    |   33 ++++++++++++++++++++++++---------
 arm/Kconfig                  |    1 +
 arm/include/asm/cmpxchg.h    |    7 ++++++-
 sh/Kconfig                   |    1 +
 sh/include/asm/cmpxchg.h     |    3 +++
 xtensa/Kconfig               |    1 +
 xtensa/include/asm/cmpxchg.h |    2 ++
 8 files changed, 39 insertions(+), 10 deletions(-)

