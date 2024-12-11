Return-Path: <linux-arch+bounces-9357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD79ED9BD
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 23:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349B1282CED
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF11F2373;
	Wed, 11 Dec 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taXi5zli"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70D1F0E4B;
	Wed, 11 Dec 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956333; cv=none; b=o8mSu+BqJPxJD9NVYXcP15AKTpz5f5G4iG+d35yaCpsz9zNJGqU1+nhpMIuS/BykDL2uGrbh46dVjk4Al7tiFavpnCbnRz7eowgp7crw0H4neAnA1G/9yd6gQw8UqbJ6CLewIQdrYvpXVIqZWfAqi7LFZY0XthS1pBsyxRIZRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956333; c=relaxed/simple;
	bh=SEo/hZdGOI1Q/CSoVxc2NHBSSqNSaH3b4tjYopKGg5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=orDytnAGeb/8fM9FyJKi/DGo+pVosASWts2g5UXuDykr0MPL37bs56LG8b7OsZcuJQ91xLfto/AyO1CW6F6Mb0b1XwA1hXOqLpTYG952i7+0YQ1PyR/v0GuiRimJvKF5JlJs8cw3dU7kM7wPZ8K7sygSAlEDwdcU1b177R+5HKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taXi5zli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38846C4CEDD;
	Wed, 11 Dec 2024 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956333;
	bh=SEo/hZdGOI1Q/CSoVxc2NHBSSqNSaH3b4tjYopKGg5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=taXi5zliiFN3KW6tUo9STN8RrcaQwTguLWUw7vOA+mWtVIl/lOqyfp7tYIS/4F3zV
	 SrlDbBAQw0pq/i+m3XA8S2V5RKELeBAQDrM9ZlzmC5W2t3P2/1WtHs4/RSCdUgq8dQ
	 mlxsg6YPQmJkBgFPWopn0EvLsIRByEfTZmh5jsblEZTrZHF1YBr1gHB4u8SC/ZnwYc
	 JJmrOPumN6Bq+UlMa1Yy/gqSPnI2DNXR7U5+yK9MuW0ITZJZ/qhOwGYGwKr3anAyP3
	 KUBLzQdsNExdAOK6/2U41j0zEPH/NAHyaJyJUiYyz7Ml3I0TkGmyIhQT3WGrG4Z/r4
	 v9nQIb5qf2Bkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1D380A965;
	Wed, 11 Dec 2024 22:32:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 0/5] Tracepoints and static branch in Rust
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395634899.1729195.7492083712432982213.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:28 +0000
References: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
In-Reply-To: <20241030-tracepoint-v12-0-eec7f0f8ad22@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, ardb@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, ubizjak@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 mark.rutland@arm.com, ryan.roberts@arm.com, tabba@google.com,
 linux-arm-kernel@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, apatel@ventanamicro.com,
 ajones@ventanamicro.com, alexghiti@rivosinc.com, conor.dooley@microchip.com,
 samuel.holland@sifive.com, chenhuacai@kernel.org, kernel@xen0n.name,
 maobibo@loongson.cn, yangtiezhu@loongson.cn, akpm@linux-foundation.org,
 zhaotianrui@loongson.cn, loongarch@lists.linux.dev, cmllamas@google.com,
 palmer@rivosinc.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Wed, 30 Oct 2024 16:04:23 +0000 you wrote:
> An important part of a production ready Linux kernel driver is
> tracepoints. So to write production ready Linux kernel drivers in Rust,
> we must be able to call tracepoints from Rust code. This patch series
> adds support for calling tracepoints declared in C from Rust.
> 
> This series includes a patch that adds a user of tracepoints to the
> rust_print sample. Please see that sample for details on what is needed
> to use this feature in Rust code.
> 
> [...]

Here is the summary with links:
  - [v12,1/5] rust: add static_branch_unlikely for static_key_false
    https://git.kernel.org/riscv/c/6e59bcc9c8ad
  - [v12,2/5] rust: add tracepoint support
    https://git.kernel.org/riscv/c/ad37bcd965fd
  - [v12,3/5] rust: samples: add tracepoint to Rust sample
    https://git.kernel.org/riscv/c/91d39024e1b0
  - [v12,4/5] jump_label: adjust inline asm to be consistent
    https://git.kernel.org/riscv/c/aecaf181651c
  - [v12,5/5] rust: add arch_static_branch
    https://git.kernel.org/riscv/c/169484ab6677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



