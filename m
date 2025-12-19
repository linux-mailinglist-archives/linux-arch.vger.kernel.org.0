Return-Path: <linux-arch+bounces-15512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F30CCEED4
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 09:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C92B3030764
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC022EDD6C;
	Fri, 19 Dec 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvV56RgS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507D2ECD2A;
	Fri, 19 Dec 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132000; cv=none; b=T2usEQbVEkNk7Gs2HflVXlAmyQkSMAWQa0fC2Zybh1BOflClonfH1EXJdBBoYudFrh/yd+IsiqhGZpC917uooOx42RHyRcVpM7sZwlXgQloujavYVj+ArLTZOBlNDizJpSc40+R1QmRDHP26NIEYAE4f2eYWvEYf9IdBP6TzmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132000; c=relaxed/simple;
	bh=c8UdFBb7F8dmejdnU77Se4Vh0A297D7YwvyeUjSzvGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GnvKy6UkEc7gJVNe9wJTI2U7d8Wj/RkHX2oweCoF4St5h/IwXw+PusydnnvI6gALE3Iw+ZUJv+e5a3js7wwkau12xH1Litnd/fxiT9+lnU/GytiftCqr8rGTl5zLhoG4PV9ZCFEP8l53jbRzDihnJV+2aAVH6zs0/wGkMnEsReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvV56RgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C38C116B1;
	Fri, 19 Dec 2025 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766131999;
	bh=c8UdFBb7F8dmejdnU77Se4Vh0A297D7YwvyeUjSzvGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bvV56RgSwPdWBOuOtUPVcXSmtsttDdT6myfmjpB+QZDRMIVyr7unLn+z+isWBP0Wy
	 Ny2hKlhPpLoymTC6JQ0DzSc0lTtu4IdOjoxflDk5ls0qr9rZjX4H6YN/PUpzbnQdAP
	 YpBOlDFBUmVl0ocWFf3MbPKhlUbei8L4bQwXt0Rf0W+fKMNrpn0yKASpPBE+phUtE+
	 eS0MjQp6QSCCa4q9q8ZjhuUYyTNuM7t+D6ja4QPtH8eUDpUit5SxogEKu15rseJwgW
	 mLfXoM8WdWG/4ZWUCIaOk3MfOwvaMmfztq3vshIPQCpKqjoQqXVEii+dxxDbG6AI8Q
	 Q/PUXYGj8Kqgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B5D380AA50;
	Fri, 19 Dec 2025 08:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 00/31] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613180853.3684357.18339473690014642605.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:10:08 +0000
References: <20251114150133.1056710-1-vschneid@redhat.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, jpoimboe@kernel.org,
 pbonzini@redhat.com, arnd@arndb.de, frederic@kernel.org, paulmck@kernel.org,
 jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
 samitolvanen@google.com, davem@davemloft.net, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, mgorman@suse.de,
 akpm@linux-foundation.org, masahiroy@kernel.org, shenhan@google.com,
 riel@surriel.com, jannh@google.com, dan.carpenter@linaro.org,
 oleg@redhat.com, juri.lelli@redhat.com, williams@redhat.com,
 ypodemsk@redhat.com, mtosatti@redhat.com, dwagner@suse.de, ptesarik@suse.com,
 sshegde@linux.ibm.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Frederic Weisbecker <frederic@kernel.org>:

On Fri, 14 Nov 2025 16:01:02 +0100 you wrote:
> Context
> =======
> 
> We've observed within Red Hat that isolated, NOHZ_FULL CPUs running a
> pure-userspace application get regularly interrupted by IPIs sent from
> housekeeping CPUs. Those IPIs are caused by activity on the housekeeping CPUs
> leading to various on_each_cpu() calls, e.g.:
> 
> [...]

Here is the summary with links:
  - [v7,01/31] objtool: Make validate_call() recognize indirect calls to pv_ops[]
    (no matching commit)
  - [v7,02/31] objtool: Flesh out warning related to pv_ops[] calls
    (no matching commit)
  - [v7,03/31] rcu: Add a small-width RCU watching counter debug option
    https://git.kernel.org/riscv/c/d1e6d2773898
  - [v7,04/31] rcutorture: Make TREE04 use CONFIG_RCU_DYNTICKS_TORTURE
    https://git.kernel.org/riscv/c/82a224498005
  - [v7,05/31] jump_label: Add annotations for validating noinstr usage
    (no matching commit)
  - [v7,06/31] static_call: Add read-only-after-init static calls
    (no matching commit)
  - [v7,07/31] x86/paravirt: Mark pv_sched_clock static call as __ro_after_init
    (no matching commit)
  - [v7,08/31] x86/idle: Mark x86_idle static call as __ro_after_init
    (no matching commit)
  - [v7,09/31] x86/paravirt: Mark pv_steal_clock static call as __ro_after_init
    (no matching commit)
  - [v7,10/31] riscv/paravirt: Mark pv_steal_clock static call as __ro_after_init
    (no matching commit)
  - [v7,11/31] loongarch/paravirt: Mark pv_steal_clock static call as __ro_after_init
    (no matching commit)
  - [v7,12/31] arm64/paravirt: Mark pv_steal_clock static call as __ro_after_init
    (no matching commit)
  - [v7,13/31] arm/paravirt: Mark pv_steal_clock static call as __ro_after_init
    (no matching commit)
  - [v7,14/31] perf/x86/amd: Mark perf_lopwr_cb static call as __ro_after_init
    (no matching commit)
  - [v7,15/31] sched/clock: Mark sched_clock_running key as __ro_after_init
    (no matching commit)
  - [v7,16/31] KVM: VMX: Mark __kvm_is_using_evmcs static key as __ro_after_init
    (no matching commit)
  - [v7,17/31] x86/bugs: Mark cpu_buf_vm_clear key as allowed in .noinstr
    (no matching commit)
  - [v7,18/31] x86/speculation/mds: Mark cpu_buf_idle_clear key as allowed in .noinstr
    (no matching commit)
  - [v7,19/31] sched/clock, x86: Mark __sched_clock_stable key as allowed in .noinstr
    (no matching commit)
  - [v7,20/31] KVM: VMX: Mark vmx_l1d_should flush and vmx_l1d_flush_cond keys as allowed in .noinstr
    (no matching commit)
  - [v7,21/31] stackleack: Mark stack_erasing_bypass key as allowed in .noinstr
    (no matching commit)
  - [v7,22/31] objtool: Add noinstr validation for static branches/calls
    (no matching commit)
  - [v7,23/31] module: Add MOD_NOINSTR_TEXT mem_type
    (no matching commit)
  - [v7,24/31] context-tracking: Introduce work deferral infrastructure
    (no matching commit)
  - [v7,25/31] context_tracking,x86: Defer kernel text patching IPIs
    (no matching commit)
  - [v7,26/31] x86/jump_label: Add ASM support for static_branch_likely()
    (no matching commit)
  - [v7,27/31] x86/mm: Make INVPCID type macros available to assembly
    (no matching commit)
  - [RFC,v7,28/31] x86/mm/pti: Introduce a kernel/user CR3 software signal
    (no matching commit)
  - [RFC,v7,29/31] x86/mm/pti: Implement a TLB flush immediately after a switch to kernel CR3
    (no matching commit)
  - [RFC,v7,30/31] x86/mm, mm/vmalloc: Defer kernel TLB flush IPIs under CONFIG_COALESCE_TLBI=y
    (no matching commit)
  - [RFC,v7,31/31] x86/entry: Add an option to coalesce TLB flushes
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



