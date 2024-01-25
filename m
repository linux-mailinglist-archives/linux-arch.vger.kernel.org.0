Return-Path: <linux-arch+bounces-1696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05B83CEA3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC1DB23D9D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39BF13A265;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgVnWqls"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBF1CFA8;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218229; cv=none; b=kQL1gv1xAcJCKD9Aiyj5PDGzegCaaWK1zPzCHF2yDmx7atOMy2T0zwPDPNj+fwuKWELXxtStnpP6/Q2kpnO4VU2Y4LeCNoeaOfa9h+KrpoioPAllnVNP7zCs33S9QYOfHbQ+Ff3KCrS/lIaXeTDXvwHt2a/Gs1Jyg2C0ppZEFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218229; c=relaxed/simple;
	bh=wrgUPoOJ4HD3nsO2w4LJrxQ73MuL5zYEqj4uUDLdhkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z5fgImcHS5rOqjdyrR4I9gcIPYmPu0SuTOdzwr07Tkznt0Ad1n/tg5RV6aurPjWuIh+17EB1CXTa1P0ElilLqRuqFrrRPmBoHZueZf/9PkEvqvgTDHYhJrGQkTg57tNUmJzVaU1qruu5JkpmqhTM9M/XUuxT+rNLhe8Itaeqyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgVnWqls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4451CC433C7;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706218229;
	bh=wrgUPoOJ4HD3nsO2w4LJrxQ73MuL5zYEqj4uUDLdhkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZgVnWqlsIp6YEf9U9yaB4UEMa1CX5af2w3FpOae+3UJj7iJx8WN0kV9pHC+pKxB2/
	 6bWc3v8ZG8i5QELCWMQrXQrSERoHHD80R+ofmm+VbfWoQvKi531fU8RqLvT+ZA33q1
	 dGKLNQ3iBG/HfD/K0EkYl0BAjDNDphufUlzVMuQqlFje9Db/h0Av+GcJdpHaljeVjK
	 MrHFNiIYml7uzsTAutkSvSrUfbjJsTxQutnLGbtSdeF8pE/NObhKLM46VIEfBKh8K3
	 2hqIerJysZiZWD+8AY/+J0bKXSNhy8/82a6FJQpuzktubl50pz3sMEDellBgsoBfSt
	 sMFIZNVpun0QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CF59DFF765;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] riscv: support fast gup
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170621822917.6239.16632170403831651230.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 21:30:29 +0000
References: <20231219175046.2496-1-jszhang@kernel.org>
In-Reply-To: <20231219175046.2496-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, will@kernel.org,
 aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 20 Dec 2023 01:50:42 +0800 you wrote:
> This series adds fast gup support to riscv.
> 
> The First patch fixes a bug in __p*d_free_tlb(). Per the riscv
> privileged spec, if non-leaf PTEs I.E pmd, pud or p4d is modified, a
> sfence.vma is a must.
> 
> The 2nd patch is a preparation patch.
> 
> [...]

Here is the summary with links:
  - [1/4] riscv: tlb: fix __p*d_free_tlb()
    https://git.kernel.org/riscv/c/8246601a7d39
  - [2/4] riscv: tlb: convert __p*d_free_tlb() to inline functions
    https://git.kernel.org/riscv/c/40d1bb92a493
  - [3/4] riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP && MMU
    https://git.kernel.org/riscv/c/69be3fb111e7
  - [4/4] riscv: enable HAVE_FAST_GUP if MMU
    https://git.kernel.org/riscv/c/3f910b7a522e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



