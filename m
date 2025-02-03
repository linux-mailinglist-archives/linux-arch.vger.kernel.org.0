Return-Path: <linux-arch+bounces-9976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827EBA2636B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 20:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4291F1885EDD
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57920E318;
	Mon,  3 Feb 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEtWCcTq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BC20E305;
	Mon,  3 Feb 2025 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610114; cv=none; b=ES0Ts0KrFI+6QR3+Wx24XrsdTM6f8YlvgZwR42WEsy3EpL6KDdEgAEWx3bw9mSJJXsclzFjSRCY5kG94pHYcxyLIGNK+6bBMy7cYet3vIL+BygUYUlUmltvhN/IE6TU0UvQ99yxTCiZ96Y8fEf9yVk2QEJZfiegNjlZk4y+2BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610114; c=relaxed/simple;
	bh=8HQ4a1E4SDVOQ5YBvLQgJdIjKRquxOBX3OP+awOzn44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WsFsL3C4+W3OHwxXbQkIsNPUC89IvlaqzicRCZvNYDaZ7PVnCoQ5zUHJpv501qhR2GWAA37Fl489pPcMJj+BtBpuGnXYbVw/sXYICmRTSXjMrAn0gOANuvv31GUhRf5iP/Ub+jP1zhPOqDZBNELKsXyxu+QbhuG1+RxN8AxvYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEtWCcTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3405DC4CEE8;
	Mon,  3 Feb 2025 19:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738610112;
	bh=8HQ4a1E4SDVOQ5YBvLQgJdIjKRquxOBX3OP+awOzn44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qEtWCcTqxtSD1UgKWJSa3crMG4kGSavYOQGcCcI4V2cyH4DOILJiyITwiSJtgrhHJ
	 leMpKr+OZgSpraWb0RiKFAKjm2zqvuhyymj1LfT8j1LOjp2fCtL0lg6qoyRWBlojQI
	 ZiaJmTEaG54Lo9sr/U8i6GeSmTgxwh0kIBhsKt5unGdN62jNr4PwFCDw08fmRqfzFL
	 BX4XCHouDDkARe7MVneI8SuivabGbQ0ef19DQGBgsurLFrWhryNqMG+dh8YZhkYfEY
	 oasu2bD4iIR5M3wZq53wObBELHA9T5YPUy+0+nOm85VEduVf6KsFBTNEF9j2Fb88zz
	 VG58pi8j5CwdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71824380AA67;
	Mon,  3 Feb 2025 19:15:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] Account page tables at all levels
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173861013901.3409359.14741114405031556153.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 19:15:39 +0000
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
In-Reply-To: <20250103184415.2744423-1-kevin.brodsky@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, linus.walleij@linaro.org, luto@kernel.org,
 peterz@infradead.org, rppt@kernel.org, ryan.roberts@arm.com,
 tglx@linutronix.de, will@kernel.org, willy@infradead.org,
 zhengqi.arch@bytedance.com, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri,  3 Jan 2025 18:44:09 +0000 you wrote:
> v1: https://lore.kernel.org/linux-mm/20241219164425.2277022-1-kevin.brodsky@arm.com/
> 
> This series should be considered in conjunction with Qi's series [1].
> Together, they ensure that page table ctor/dtor are called at all levels
> (PTE to PGD) and all architectures, where page tables are regular pages.
> Besides the improvement in accounting and general cleanup, this also
> create a single place where construction/destruction hooks can be called
> for all page tables, namely the now-generic pagetable_dtor() introduced
> by Qi, and __pagetable_ctor() introduced in this series.
> 
> [...]

Here is the summary with links:
  - [v2,1/6] mm: Move common part of pagetable_*_ctor to helper
    https://git.kernel.org/riscv/c/11e2400b21a3
  - [v2,2/6] parisc: mm: Ensure pagetable_pmd_[cd]tor are called
    https://git.kernel.org/riscv/c/3565522e15eb
  - [v2,3/6] m68k: mm: Add calls to pagetable_pmd_[cd]tor
    https://git.kernel.org/riscv/c/1879688e5c42
  - [v2,4/6] ARM: mm: Rename PGD helpers
    https://git.kernel.org/riscv/c/94771023712a
  - [v2,5/6] asm-generic: pgalloc: Provide generic __pgd_{alloc,free}
    https://git.kernel.org/riscv/c/a9b3c355c2e6
  - [v2,6/6] mm: Introduce ctor/dtor at PGD level
    https://git.kernel.org/riscv/c/d95936a2267c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



