Return-Path: <linux-arch+bounces-1098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2908155B2
	for <lists+linux-arch@lfdr.de>; Sat, 16 Dec 2023 01:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C3B1C225E5
	for <lists+linux-arch@lfdr.de>; Sat, 16 Dec 2023 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495D808;
	Sat, 16 Dec 2023 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slo6GkaM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62C10EE;
	Sat, 16 Dec 2023 00:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 095F5C433C9;
	Sat, 16 Dec 2023 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702687826;
	bh=REY7ZuYT6jJPWfRPau8JDVsTne7UEvPQl9xgjwckxWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=slo6GkaMTr9Way21zMIC0ORgchmdQJ92oHVwPGLzYvJxlTIO07OQnb3yhpnDzASu0
	 2dsRQpqcgwnYqd8gGhAagAZ6g9qwxz705a1J87TNXpnKrROmlQe79ntUIY2TrPPbfY
	 6/YjRpNviWEMP3xEODOO3iXxMDhSiya0Bznjw7SgqgYOsa0Tev8ogI/4I+Jbdub6PW
	 ei+OrtP/Z2jkVWA7w1Ik0zCH9TZYqr1FFQQ774zT5AYJzGwvhwMDrHab+KgaBrzykF
	 WYlQiq9IHYRQHiXIr37j1iqpANyKaoX0OBapWKDX8VbVG/UvLvX6NLkLr/E2LfRPSH
	 uJRmdn/n5bg3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E25A2C4314C;
	Sat, 16 Dec 2023 00:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/7] x86/cfi,bpf: Fix CFI vs eBPF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170268782592.26334.17481945540978625909.git-patchwork-notify@kernel.org>
Date: Sat, 16 Dec 2023 00:50:25 +0000
References: <20231215091216.135791411@infradead.org>
In-Reply-To: <20231215091216.135791411@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: alexei.starovoitov@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, arnd@arndb.de,
 samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
 ndesaulniers@google.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev, jpoimboe@kernel.org,
 joao@overdrivepizza.com, mark.rutland@arm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 Dec 2023 10:12:16 +0100 you wrote:
> Hi!
> 
> What started with the simple observation that bpf_dispatcher_*_func() was
> broken for calling CFI functions with a __nocfi calling context for FineIBT
> ended up with a complete BPF wide CFI fixup.
> 
> With these changes on the BPF selftest suite passes without crashing -- there's
> still a few failures, but Alexei has graciously offered to look into those.
> 
> [...]

Here is the summary with links:
  - [v3,1/7] cfi: Flip headers
    https://git.kernel.org/bpf/bpf-next/c/4382159696c9
  - [v3,2/7] x86/cfi,bpf: Fix BPF JIT call
    https://git.kernel.org/bpf/bpf-next/c/4f9087f16651
  - [v3,3/7] x86/cfi,bpf: Fix bpf_callback_t CFI
    https://git.kernel.org/bpf/bpf-next/c/e72d88d18df4
  - [v3,4/7] x86/cfi,bpf: Fix bpf_struct_ops CFI
    https://git.kernel.org/bpf/bpf-next/c/2cd3e3772e41
  - [v3,5/7] cfi: Add CFI_NOSEAL()
    https://git.kernel.org/bpf/bpf-next/c/e9d13b9d2f99
  - [v3,6/7] bpf: Fix dtor CFI
    https://git.kernel.org/bpf/bpf-next/c/e4c00339891c
  - [v3,7/7] x86/cfi,bpf: Fix bpf_exception_cb() signature
    https://git.kernel.org/bpf/bpf-next/c/852486b35f34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



