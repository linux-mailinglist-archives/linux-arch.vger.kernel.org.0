Return-Path: <linux-arch+bounces-5992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF359948229
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 21:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69886284134
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E37143879;
	Mon,  5 Aug 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCHw9O+3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6244364AB;
	Mon,  5 Aug 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885630; cv=none; b=FqCghGW34JOL3ZFPVcP/oOc4u90Q+3Ttz0swhcMhOEJd451g5+gHyHLuV0h3BscwkjplqOdiAOne8OtaGQIey/Q8Hbu9aQ8fd+GhnCar3Oiuuow06m9FiH9WKYQZIagrOkTi5QP2infhmS13oMv9TDPAC9kiin2Ql2qnXIZZ81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885630; c=relaxed/simple;
	bh=yDMt0EqrqAyLKxe7X4rCEOBXWgRTFVTEgyEZvPiduZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mRyrQPIUaQ/6rR2N20Z3Abui+F/23WzcwMak0HyMCZ0CQdYyz32w5HJL57M1qqmxaq62OUbL0dgmA1Aa4GMena7ML/MW1VU/NpiISQVd/FRvuZluv5/ejkOAOdhwTsqcqsN4IXdmE8OyFWRJ3q9UOP3oqTSIeRA2FwokSSuTSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCHw9O+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA8AC4AF0B;
	Mon,  5 Aug 2024 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885630;
	bh=yDMt0EqrqAyLKxe7X4rCEOBXWgRTFVTEgyEZvPiduZo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=aCHw9O+3I7TwTqw2bgfYVX6WUAu1hjbYIeBT6Tvsk5RZkdWLdrx1y79mOL30w9ic+
	 T3B2USrL8Lb6wosurq1IxTway3u1g6PZo6ctQ+rfZ/41S/ad2pfmEZ0CrBrhSrby6F
	 Yw23/AFYdNfctK6rax3X9KEaoWk8DzIzIeG+ospSOHPd0wlfaQUkVs9ECdl18vZYcZ
	 pOON4GD3hv3t3ETaOq+GIaJPOJQ5v3VWHEWl5TaTQjP2p7LKrDB+XYk6sm8eZjgaj6
	 IwEjGGRDVcgxCwlHZXSY3p27ALgGEhws0COdLj9PqOjJZkfcqrfoRf3n/a/xSZcmPW
	 LRA2d52n+Y2IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BFCC1CE0A6F; Mon,  5 Aug 2024 12:20:29 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:20:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org, arnd@arndb.de,
	geert@linux-m68k.org, palmer@rivosinc.com, mhiramat@kernel.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org
Subject: [PATCH cmpxchg 0/3] Provide emulation for one-byte cmpxchg()
Message-ID: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
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

This series provides an emulation function for one-byte cmpxchg(),
and uses it for the remaining architectures not supporting these in
hardware and not providing emulation.  The emulation is in terms of
the fully ordered four-byte cmpxchg() that is supplied by all of these
architectures.  The emulation has been used in mainline since v6.9
by csky.

Once this emulation is in place for all architectures needing
it, RCU Tasks will use this capability in place of the current
rcu_trc_cmpxchg_need_qs() open-coding of this emulation.

1.	xtensa: Emulate one-byte cmpxchg.

2.	ARC: Emulate one-byte cmpxchg.

3.	sh: Emulate one-byte cmpxchg.

						Thanx, Paul

------------------------------------------------------------------------

 arc/Kconfig                  |    1 +
 arc/include/asm/cmpxchg.h    |   33 ++++++++++++++++++++++++---------
 sh/Kconfig                   |    1 +
 sh/include/asm/cmpxchg.h     |    3 +++
 xtensa/Kconfig               |    1 +
 xtensa/include/asm/cmpxchg.h |    2 ++
 6 files changed, 32 insertions(+), 9 deletions(-)

