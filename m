Return-Path: <linux-arch+bounces-6437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8346F95A44D
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 20:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BD1F22B45
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0013AD2B;
	Wed, 21 Aug 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9fH/UCw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879507D07D;
	Wed, 21 Aug 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263339; cv=none; b=DHAENtlhqAVOVsPZpZocYsyi0IX4WkKTEx2MAFFjMkaq6UAwpf9NZLKPEkTwyvQfFe/U3s4nIgu5GjS8P/FUp8Q0KNQUNW8CMAvpb5KJ9FtCQMHntuTaQWewS2WeT4dmN+quvu+KqDjrNIoy8reWoCSvtXsvzt9FtPEQC0PK4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263339; c=relaxed/simple;
	bh=McNAGRZDnJ7u79fmlszPR8St8pd0flKr5dQvmUicyWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c94iYK/Yfc6PODCyzHLhba4QBZmBEaQ9Vu/Tq2GnrgIULlAN6trhX7tGpef30xF/bWKoUYzcvYFdoiho6Zz5PP/UZDgfb/ulsjxYySNH9DAI6UwSanflvjrLrfXbPePkRMWKvbjguPqofECSZO2a52nnt8gcbE7r8X0704XCYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9fH/UCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ED8C32781;
	Wed, 21 Aug 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263339;
	bh=McNAGRZDnJ7u79fmlszPR8St8pd0flKr5dQvmUicyWg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=c9fH/UCwU4ovqXBiXcpHiMBfm5emz7PVbY4+KAe+V9wvRs5Y8v9Z0V4ajuP1Q26a6
	 skPF4b52M7xH25Xneik/dnR35/M3KAGhdOSCczgMjdN18xPLgpNBCcMcXLDwFtqwVf
	 C8CjdOqD862ATRW1q5+ER0btPtUzdL2sRmDL2oc03TbX6cbtJdA8KZEPjYf1/vfozI
	 xXANc7Tqiqjo3rf37jLTZk2saQJoIVNh24SX89MS3k4pittEFa0a8MIIlDnBX1pwbk
	 ytbfRZzuwg15DBxxOwqjjG+UdREaDVK2EgHrSYNSqUnXIwAYAFgRPH8RQup57RUvN8
	 o+bclw4MRIsfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99434CE160F; Wed, 21 Aug 2024 11:02:18 -0700 (PDT)
Date: Wed, 21 Aug 2024 11:02:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org, arnd@arndb.de,
	geert@linux-m68k.org, palmer@rivosinc.com, mhiramat@kernel.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org
Subject: [PATCH v2 cmpxchg 0/3] Provide emulation for one-byte cmpxchg() for
 v6.12
Message-ID: <04a6010c-536d-4906-bf7c-b2335a2f54b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>

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

Changes since v1:

o	Add acked-by tags.

						Thanx, Paul

------------------------------------------------------------------------

 arc/Kconfig                  |    1 +
 arc/include/asm/cmpxchg.h    |    6 ++++--
 sh/Kconfig                   |    1 +
 sh/include/asm/cmpxchg.h     |    3 +++
 xtensa/Kconfig               |    1 +
 xtensa/include/asm/cmpxchg.h |    2 ++
 6 files changed, 12 insertions(+), 2 deletions(-)

