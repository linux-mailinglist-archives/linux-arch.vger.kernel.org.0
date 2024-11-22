Return-Path: <linux-arch+bounces-9151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7629D5ECD
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2024 13:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F436283452
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81D1DF243;
	Fri, 22 Nov 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LQQILLiK"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172181DEFF5;
	Fri, 22 Nov 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278446; cv=none; b=VNj4yVS/uNxpFd2Nxbf2KhQ0UZmZQPQcC+ng9XqocjmAAHc4cQAPW8FXeQ7gPyURzwuRXvVWYOpMA5aRI3S7mLZSm3RgwW99sI4ShoVQSZ7TMFMrXoDb3z5TXPEKH+eDxxa7pMVQj3r2wxccK2szHIb7uTp86mK3ip8pAIwqAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278446; c=relaxed/simple;
	bh=0kGSHw8JTyuHlCkouecYymNm2X42fBKssXcFo3omKQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ForVg/v9m5OJS2twog7vIlQlgW7CqMjG0fjzeNKRqwFsWIY2Kj7D5v7Fsbdn89R2vY8kUdbh51gJ5vIJoLinkyEOoQn4sX4d9yYGu0cswEUA4uHWwhWDdwacbEC7EVHp5YPfX90ZAejaDymETJbDL6KKucoOZtWNjDquUHMcgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LQQILLiK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0kGSHw8JTyuHlCkouecYymNm2X42fBKssXcFo3omKQc=; b=LQQILLiKYSM3aRqMyif85PqZM8
	g+46MJsI6aZvdT+t7iqH03XXfsjBleDyps7waXsLLQ+pNGWuMUkV+AHXnqwTkVqN5y6XqNOIPQV9I
	FhBcPw0n9AYFeONmqGBOlLQEnqviwwcx/A5ibdcdi78J/DhlhstftDI6WnCczfzFFAIzYSJyhwjCw
	m2ZRVvpUZnb6mJLPpkh7Vr3l8qdHWfDEZ7+3DRFMeUpI9VQzUX+bzHkd1TBi7oTgOGVrGfH6r+VEP
	BkPpm7G9DK5B6zS1b9UKLCNZIck4BLXsmuygD8rmMbIQwo+KRr1uVKl/WETCy5X6f4SDP8Ze7BNS2
	oQbg1QbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESka-00000000hcd-0TQO;
	Fri, 22 Nov 2024 12:27:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B386A30066A; Fri, 22 Nov 2024 13:27:03 +0100 (CET)
Date: Fri, 22 Nov 2024 13:27:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Wentao Zhang <wentaoz5@illinois.edu>, Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org, andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com, ardb@kernel.org, arnd@arndb.de,
	bhelgaas@google.com, bp@alien8.de, chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com, dvyukov@google.com, hpa@zytor.com,
	jinghao7@illinois.edu, johannes@sipsolutions.net,
	jpoimboe@kernel.org, justinstitt@google.com, kees@kernel.org,
	kent.overstreet@linux.dev, linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, llvm@lists.linux.dev, luto@kernel.org,
	marinov@illinois.edu, masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	richard@nod.at, rostedt@goodmis.org, samitolvanen@google.com,
	samuel.sarkisian@boeing.com, steven.h.vanderleest@boeing.com,
	tglx@linutronix.de, tingxur@illinois.edu, tyxu@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20241122122703.GW24774@noisy.programming.kicks-ass.net>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003232938.GA1663252@thelio-3990X>

On Thu, Oct 03, 2024 at 04:29:38PM -0700, Nathan Chancellor wrote:

> $ /usr/bin/time -v make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper {def,amd_mem_encrypt.,fortify_source.,llvm_cov.}config bzImage
> ...
> vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x6e: call to kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_syscall_64+0x141: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: do_int80_emulation+0x138: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: handle_bug+0x5: call to kmsan_unpoison_entry_regs() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x73: call to user_enter_irqoff() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x62: call to user_enter_irqoff() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter+0x45: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_exit+0x4a: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4: call to lockdep_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_exit+0x67: call to lockdep_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: enter_s2idle_proper+0xb5: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpuidle_enter_state+0x113: call to lockdep_hardirqs_off() leaves .noinstr.text section
> vmlinux.o: warning: objtool: default_idle_call+0xad: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpu_idle_poll+0x29: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x118: call to lockdep_hardirqs_on() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section

Just saw this fly by, that looks like something is buggered bad. Notably
lockdep_hardirqs_{on,off}() are noinstr.

Is this patch-set causing this, or what?

