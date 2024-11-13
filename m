Return-Path: <linux-arch+bounces-9070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F959C75F7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99451F2395C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E21F9EAA;
	Wed, 13 Nov 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enaSTBNQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948161DDA15;
	Wed, 13 Nov 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510765; cv=none; b=n2EM6Bi9zbNvDoCaqMUvHXva8saaf0dNgXi/ThIG+qfd2yhtdc9BuuSTnDAh0F+jAIZScczuHUPcJnsDOyKHhD0b3n0v7j/IQnIgb/+p6Izg4KgT0qkw33Bt1W+1wvnobBn1qZZNFEAnL8UVdxGZyyrQwhSRKN7A5oTIPzAGyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510765; c=relaxed/simple;
	bh=TFqBsCEEhiEfUZXx4rlGwlcvCf9x/nrUHFsj/Ii/Gnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rX6XWc7/l81WfC82mOmD21IXHIPYQCiv+vZwngNILxCfOeFrT/VZgwpyx/AnZM5GqBtPZrbM+8Pr60ipg+CuuLt5LKCGUGJ80wIeq32Sdd/J9Li9JDIu+/H+ZfksvOykXHmx2CwKJTx1G1Bf/kQtmhIroQ8dxAQt2xCLGPkQ4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enaSTBNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21583C4CEC3;
	Wed, 13 Nov 2024 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731510765;
	bh=TFqBsCEEhiEfUZXx4rlGwlcvCf9x/nrUHFsj/Ii/Gnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=enaSTBNQt0IiBQIiu7I69IWa79Y00emUOBHMQmq+W0IYB1CGcDtJcoTz58JjLF8NS
	 5hGay2n3XUoE2c4i6NtTOBFIG75mQHhoA/mgweNWoVCnEgKSDGu193CpRzKKOe/bAp
	 5hnXo+lJ/rPOVxNu9oz/vf7WSlY6Bs+J3RFgqXagoAlA9z6VcKnRd/1SygjKmeQ8X1
	 3ZpNgY60ZgKaGoKczU5A3j9dPM8mPhTokpL6EGt9cCTDHwSqY63XHFw50psLnnSL0y
	 MVedQEtlvbmBMEDq1iEItNs/I6QVCv9DMTP1vTDy9G2FY2FCJ82chUPeAP0zVWQi8c
	 Hf06mFby3gkEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDAD3809A80;
	Wed, 13 Nov 2024 15:12:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 00/13] Zacas/Zabha support and qspinlocks
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173151077551.1250875.2817493635093268101.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 15:12:55 +0000
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
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

On Sun,  3 Nov 2024 15:51:40 +0100 you wrote:
> This implements [cmp]xchgXX() macros using Zacas and Zabha extensions
> and finally uses those newly introduced macros to add support for
> qspinlocks: note that this implementation of qspinlocks satisfies the
> forward progress guarantee.
> 
> It also uses Ziccrse to provide the qspinlock implementation.
> 
> [...]

Here is the summary with links:
  - [v6,01/13] riscv: Move cpufeature.h macros into their own header
    https://git.kernel.org/riscv/c/010e12aa4925
  - [v6,02/13] riscv: Do not fail to build on byte/halfword operations with Zawrs
    https://git.kernel.org/riscv/c/af042c457db0
  - [v6,03/13] riscv: Implement cmpxchg32/64() using Zacas
    https://git.kernel.org/riscv/c/38acdee32d23
  - [v6,04/13] dt-bindings: riscv: Add Zabha ISA extension description
    https://git.kernel.org/riscv/c/51624ddcf59d
  - [v6,05/13] riscv: Implement cmpxchg8/16() using Zabha
    https://git.kernel.org/riscv/c/1658ef4314b3
  - [v6,06/13] riscv: Improve zacas fully-ordered cmpxchg()
    https://git.kernel.org/riscv/c/6116e22ef33a
  - [v6,07/13] riscv: Implement arch_cmpxchg128() using Zacas
    https://git.kernel.org/riscv/c/f7bd2be7663c
  - [v6,08/13] riscv: Implement xchg8/16() using Zabha
    https://git.kernel.org/riscv/c/97ddab7fbea8
  - [v6,09/13] asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
    https://git.kernel.org/riscv/c/cbe82e140bb7
  - [v6,10/13] asm-generic: ticket-lock: Add separate ticket-lock.h
    https://git.kernel.org/riscv/c/22c33321e260
  - [v6,11/13] riscv: Add ISA extension parsing for Ziccrse
    https://git.kernel.org/riscv/c/2d36fe89d872
  - [v6,12/13] dt-bindings: riscv: Add Ziccrse ISA extension description
    https://git.kernel.org/riscv/c/447b2afbcde1
  - [v6,13/13] riscv: Add qspinlock support
    https://git.kernel.org/riscv/c/ab83647fadae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



