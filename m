Return-Path: <linux-arch+bounces-9360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 123739EDA26
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 23:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A957188664A
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 22:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC12208961;
	Wed, 11 Dec 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWKDnM8z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19082080C5;
	Wed, 11 Dec 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956381; cv=none; b=Lz9FFVnz6SMN/zLQecwibFgSyb1j1c7eY60Tp+uK2112Nv+JelSZcAEjW1kXdCFGUIhHha7hp8eKEjObXSBY+fDMwQf//j8MGBv922RiqkN9HMnglnERTSkEJWpfvXlhflnuQ9DIeZYUD/JE3YP+yklfPtIXG1ZmYCfoVWr82o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956381; c=relaxed/simple;
	bh=22J+gOpjU9cUBjJTCfbYoXOQOQ02vFL/kmDAmitv0Oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fY5UEvozfHIZAp5lC8zqbdNd9Vi7etQCzkBM7Q6R7GDGZEUHp/xl+xBF3oyQ1IiHb3I91JaCbFsbaGQ84Xmgi0+7D0YYuV8w7mxbhQLb+vCVpAVuOt27xXKYeKoSoNbV3pk4Lj6btq/TplbIxhFRNDOuF3FxCGJLGkU1yc1J0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWKDnM8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92BFC4CED2;
	Wed, 11 Dec 2024 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956381;
	bh=22J+gOpjU9cUBjJTCfbYoXOQOQ02vFL/kmDAmitv0Oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nWKDnM8zbcIF2djxC8fiOIOI3aUWr7TPAJCWU7ymE3mh5w2HYnJyAIXKcD5Z/72Ik
	 RXR4O9F/aU40PoBXvJ7XQXthLV2s4bsqOgfr50SDKFPRdnN9Us4sRkg4wVPA1v1sWs
	 kmuwkRDqP/9t5kMphxqk619d2ax7wRCqOpRNHKzjgvwJVCBNZYsBwGByJZh6bRNViD
	 yrqc1wHdhtHkBz1Bsd0sAtAVRFHXuN3A8nyxlLFqzm4TGzLspNaCqc2nuGjGhk5Ngr
	 pRCorRCtj+x28DI2Z1vxcZ2g3p4dEWd2sTvDRfb/s5xPU/4+C8mw0GfDgU2OE3HHnZ
	 3Ww2yKRibpabg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACB2380A965;
	Wed, 11 Dec 2024 22:33:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] ftrace: Make ftrace_regs abstract and consolidate code
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395639774.1729195.5975449690225774291.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:17 +0000
References: <20241008230527.674939311@goodmis.org>
In-Reply-To: <20241008230527.674939311@goodmis.org>
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

This series was applied to riscv/linux.git (fixes)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Tue, 08 Oct 2024 19:05:27 -0400 you wrote:
> This is based on:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/
>      ftrace/for-next
> 
> ftrace_regs was created to hold registers that store information to save
> function parameters, return value and stack. Since it is a subset of
> pt_regs, it should only be used by its accessor functions. But because
> pt_regs can easily be taken from ftrace_regs (on most archs), it is
> tempting to use it directly. But when running on other architectures, it
> may fail to build or worse, build but crash the kernel!
> 
> [...]

Here is the summary with links:
  - [v2,1/2] ftrace: Make ftrace_regs abstract from direct use
    https://git.kernel.org/riscv/c/7888af4166d4
  - [v2,2/2] ftrace: Consolidate ftrace_regs accessor functions for archs using pt_regs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



