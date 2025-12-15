Return-Path: <linux-arch+bounces-15408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CACCBC8A2
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 06:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2512F3007E59
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7131B132;
	Mon, 15 Dec 2025 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdfG4xGM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8522D543E;
	Mon, 15 Dec 2025 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765775667; cv=none; b=KfzF82g6L89pc/PVQL7eoEV+4EIC+Vdue8UxwUaJdi+TEqzJTylqFdX+PzBG4WkskixJL9WtRZTF3VCmtlFaO9PGfhIhUV0i+lxi1R+P9iGtCWeF918JgH0FBd/RflQwTs7S+3EuI1xxw0Ymae1Y2qozqT2JeXnjUJjJTJmYi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765775667; c=relaxed/simple;
	bh=6oKeEWsAGgWcNvr2xLFSKT0iktHyWUhyJOdbpeo+Cu4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rSkREDQ3x6nn+te0BEhZK1FP9krmi4nzHdZPDmXoQFcBjVV4z1Dc7XL2s8SIOsC87DG+WuywgizGQMZMpINYqF3PZFkhF1DsxmKh1e+F0zZGuNPB0VcqZ3p7kWXhStB//6R3f51ww9rmg2CUjVMpl+OTY68sYHXTVxxvxFo8lIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdfG4xGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB595C4CEF5;
	Mon, 15 Dec 2025 05:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765775667;
	bh=6oKeEWsAGgWcNvr2xLFSKT0iktHyWUhyJOdbpeo+Cu4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EdfG4xGMpV4109L7vUlQhHa7tiIppNWoo4U1lyA6JEr1xmtOXm9T6U0slR+WlzU2q
	 TfeTOKYccf6dKZV4gvyozEgKh4ibG2h9mmpEHuZPts3/oO9G5xB9ezLJt+iV11YCsK
	 Jelz5suExdnjorwb/TJIunG8Kk4aV/r4chrbfAAaSv09LcfN91tgDEJiqqNWGGq3EI
	 f4usMiFdyn4IjozsLnSOMFu46Lt5Bz44EBI14T48Yyvm7Kn0HPAT4yEne6rxmsYJSa
	 Lfkjwdtg76TIG6HTttBA8vcPOOh4FcJuu/IrE0KOVQ/i/wRSLoCxBm0NxhiFLUmjQp
	 wb4yY7ZGIxeBg==
Content-Type: multipart/mixed; boundary="===============5514130710034652785=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5dfe5e4c186bcc18bf8fb935b4ba81c7e0a2ce3c13a49fe91aac51b07975a1a4@mail.kernel.org>
In-Reply-To: <20251215044919.460086-6-ankur.a.arora@oracle.com>
References: <20251215044919.460086-6-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v8 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Dec 2025 05:14:26 +0000 (UTC)

--===============5514130710034652785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
> index 9ea0a74e5892..a385603436e9 100644
> --- a/arch/arm64/include/asm/rqspinlock.h
> +++ b/arch/arm64/include/asm/rqspinlock.h
> @@ -3,91 +3,6 @@
>  #define _ASM_RQSPINLOCK_H
>
>  #include <asm/barrier.h>
> -
> -/*
> - * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
> - * version based on [0]. In rqspinlock code, our conditional expression involves
> - * checking the value _and_ additionally a timeout. However, on arm64, the
> - * WFE-based implementation may never spin again if no stores occur to the
> - * locked byte in the lock word. As such, we may be stuck forever if
> - * event-stream based unblocking is not available on the platform for WFE spin
> - * loops (arch_timer_evtstrm_available).
                                               ^^^^

Can lock acquisition hang indefinitely on platforms without event-stream
support? The deleted implementation provided special handling for the
arch_timer_evtstrm_available() == false case using
__smp_cond_load_relaxed_spinwait(), which checked the timeout condition
every 200 iterations via cpu_relax().

After this removal, resilient_queued_spin_lock_slowpath() at line 408
calls:

    res_smp_cond_load_acquire(&lock->locked,
                              !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));

This now falls back to the generic smp_cond_load_acquire() (defined in
kernel/bpf/rqspinlock.c:307), which uses __cmpwait_relaxed(). On
platforms without event-stream, __cmpwait_relaxed() becomes just
cpu_relax() (a yield instruction), and the WFE instruction may never wake
up if no stores occur to the lock word.

Even if WFE does wake up periodically, the RES_CHECK_TIMEOUT macro is
defined with amortization (checking timeout every ~256 iterations when
!(ts.spin++) wraps), which may be too sparse compared to the deleted
implementation's explicit check every 200 iterations.

This means the timeout and deadlock detection logic may not function
correctly, potentially causing lock acquisition to hang instead of
returning -ETIMEDOUT or -EDEADLK after the intended 250ms timeout
(RES_DEF_TIMEOUT).

Note: The next commit in the series (f150b57ec7c8 "bpf/rqspinlock: Use
smp_cond_load_acquire_timeout()") switches to proper timeout-aware
primitives, which resolves this issue.

> - *
> - * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
> - * copy-paste.

[ ... ]

> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
> -
>  #include <asm-generic/rqspinlock.h>
>
>  #endif /* _ASM_RQSPINLOCK_H */


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20221060323

--===============5514130710034652785==--

