Return-Path: <linux-arch+bounces-9359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF49EDA1B
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 23:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7451628C4
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497772063F4;
	Wed, 11 Dec 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnrDcNkO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CA2063EA;
	Wed, 11 Dec 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956375; cv=none; b=YhMZ8JNnovSvW44MS0/NyasMHPIKtIhp2bqwPgiO2VtlSiV8KLXWIaXjqKNY53Db/z/yKugCeYraLqJSqxrH0sWMTIAy6tOK3F3DD4UGteGcYXoSmvL7ts8R3AQlloSxoq2jxDgRJQ33JiTVx5j3AiMIUSjquSTThC7pNQSdnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956375; c=relaxed/simple;
	bh=29u5B09z/mNiOUipvbCAR8d/HfuJKD9vMPDnfCmrneU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I8SEnBthGNtu76sMssaHt4AQXBTItLIGBBYK44W+zhzbBCmbh+UUTudFAerDuWGImnKv8pvG4YSz3CVgW/1XEfKzQhaukImnIT/ElN3Z8W8lTS6izRAeNOVrgttt35XgYVpC8uQw+wVQOnj84we5rhhReHOi9QI6yA2oYznwj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnrDcNkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C1BC4CED2;
	Wed, 11 Dec 2024 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956374;
	bh=29u5B09z/mNiOUipvbCAR8d/HfuJKD9vMPDnfCmrneU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dnrDcNkOoxwSBjPjDdUGrvVokaL8PbY/29PjhRdPkvydqw8DxYooD5ABeBk3HzL/N
	 76xby5lMWnFghEv7vC3hF+lPCP97eOVPUwp3+ZSkE4SEdqJhuc4M4tsMuMgquf/1Sh
	 MR1GipeeO24AReN6/ejtJZElR5CRC8RyZljN784IO+9YPc2RBnMzEXA7w+OQ/yoYqa
	 adhGvjnBGfHafNdP3219wtIr4V6sPs3ti0dnt0aZa1Z6WSjl0+E+Zb5OzErlTpRYgu
	 UkzyIpABUuFP1nVewt4cL6HBuOiiJYxbTNdocbttNyq8XlE99Zmw+EmsHH8rPlCKUB
	 H5x4fe1dWfyKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD93380A965;
	Wed, 11 Dec 2024 22:33:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ftrace: Consolidate ftrace_regs accessor functions for
 archs using pt_regs
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395639050.1729195.18342749493985130890.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:10 +0000
References: <20241010202114.2289f6fd@gandalf.local.home>
In-Reply-To: <20241010202114.2289f6fd@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de,
 mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Thu, 10 Oct 2024 20:21:14 -0400 you wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Most architectures use pt_regs within ftrace_regs making a lot of the
> accessor functions just calls to the pt_regs internally. Instead of
> duplication this effort, use a HAVE_ARCH_FTRACE_REGS for architectures
> that have their own ftrace_regs that is not based on pt_regs and will
> define all the accessor functions, and for the architectures that just use
> pt_regs, it will leave it undefined, and the default accessor functions
> will be used.
> 
> [...]

Here is the summary with links:
  - [v3] ftrace: Consolidate ftrace_regs accessor functions for archs using pt_regs
    https://git.kernel.org/riscv/c/e4cf33ca4812

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



