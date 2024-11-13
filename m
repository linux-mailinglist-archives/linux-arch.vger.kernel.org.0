Return-Path: <linux-arch+bounces-9071-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6789C75FB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39791F22902
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCA200B89;
	Wed, 13 Nov 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBBBy31W"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC532003A2;
	Wed, 13 Nov 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510767; cv=none; b=Dlvx+OvMM1905n9uJjBm7tp+RNaiWPPgUk2K+XzXwKO83uAKrE+Ig32SScRz1XBijtBYUhGA93t7uEWRu5c83K7HSXVlGSYHTYFfcKyd1YqZMwgVeNk0Y62UzZ4TSP/Wi6JWdN0/qStUOLNmNUb2E0db98zjPNxpEdlhvcmSYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510767; c=relaxed/simple;
	bh=+mOm1jVBlMQl06mqGb93rPEPLa+Adk6NChbI8ONl/FY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WSr5LupYNK+rNa25wO0oIhmyXoxOQqMPLlXPA+cKkkAeygHRw1hRq/H+Aqfyrjpavm6l5t1DFu2he+f81AEMOeoAqrrDnbR8pYcyTCBOKmD1w7S8OU1cz/gZSXs6LYxYVuPg6vpF7WI9J0gNUOaX2P0UMEGmFGVivEkdFNvB+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBBBy31W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4EBC4CEC3;
	Wed, 13 Nov 2024 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731510766;
	bh=+mOm1jVBlMQl06mqGb93rPEPLa+Adk6NChbI8ONl/FY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FBBBy31WBOhcPfZ8wMelhHag7Oju1fWFqLKGEU+k86hfHQCglpNh1yTu06JbNRbpT
	 u+lZGKDPg7Qfiml5/l8B20o2qTixnuiQ/BNS9uLetQ5XaW5CPMsHT/R0FDPjQIgzUx
	 Le+OEq2yOXCgA3SFI4lsVJ/8SSgHpG9D+yklx4RRQre6bCXfhh8E9y0Tlhf9KUCFYF
	 Op6pBP5CPMT+cOnU5zHBIuH6xtap6Rxr7qinY+eNebTQZTSj8Nx75D5OjGPQvquGUM
	 pshCm0Z0C4CZ4CImeyc7/4moQWS5JrWFHB1QsTAcEdAgAgwzmS5/L5H+U2ePjjxvfE
	 2MY3waRGyTB3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342473809A80;
	Wed, 13 Nov 2024 15:12:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 00/13] Zacas/Zabha support and qspinlocks
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173151077674.1250875.11061543352254749516.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 15:12:56 +0000
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, parri.andrea@gmail.com, nathan@kernel.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com,
 boqun.feng@gmail.com, arnd@arndb.de, leobras@redhat.com, guoren@kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 18 Aug 2024 08:35:25 +0200 you wrote:
> This implements [cmp]xchgXX() macros using Zacas and Zabha extensions
> and finally uses those newly introduced macros to add support for
> qspinlocks: note that this implementation of qspinlocks satisfies the
> forward progress guarantee.
> 
> It also uses Ziccrse to provide the qspinlock implementation.
> 
> [...]

Here is the summary with links:
  - [v5,01/13] riscv: Move cpufeature.h macros into their own header
    https://git.kernel.org/riscv/c/010e12aa4925
  - [v5,02/13] riscv: Do not fail to build on byte/halfword operations with Zawrs
    https://git.kernel.org/riscv/c/af042c457db0
  - [v5,03/13] riscv: Implement cmpxchg32/64() using Zacas
    https://git.kernel.org/riscv/c/38acdee32d23
  - [v5,04/13] dt-bindings: riscv: Add Zabha ISA extension description
    (no matching commit)
  - [v5,05/13] riscv: Implement cmpxchg8/16() using Zabha
    (no matching commit)
  - [v5,06/13] riscv: Improve zacas fully-ordered cmpxchg()
    (no matching commit)
  - [v5,07/13] riscv: Implement arch_cmpxchg128() using Zacas
    https://git.kernel.org/riscv/c/f7bd2be7663c
  - [v5,08/13] riscv: Implement xchg8/16() using Zabha
    https://git.kernel.org/riscv/c/97ddab7fbea8
  - [v5,09/13] asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
    https://git.kernel.org/riscv/c/cbe82e140bb7
  - [v5,10/13] asm-generic: ticket-lock: Add separate ticket-lock.h
    https://git.kernel.org/riscv/c/22c33321e260
  - [v5,11/13] riscv: Add ISA extension parsing for Ziccrse
    (no matching commit)
  - [v5,12/13] dt-bindings: riscv: Add Ziccrse ISA extension description
    https://git.kernel.org/riscv/c/447b2afbcde1
  - [v5,13/13] riscv: Add qspinlock support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



