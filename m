Return-Path: <linux-arch+bounces-9153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914369D675C
	for <lists+linux-arch@lfdr.de>; Sat, 23 Nov 2024 04:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08472B20BC7
	for <lists+linux-arch@lfdr.de>; Sat, 23 Nov 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946312E7F;
	Sat, 23 Nov 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb2mV5E+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA7259C;
	Sat, 23 Nov 2024 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732331361; cv=none; b=tfMtvLNGw4bpkxaM36Qkg5XAAYGm+ant6MU3+q5waKKWgDi5TngTKdLgZnJ0WJJtvZqev4+WG9+LjBAh+Y4nU2y9KFo0C7qhurTmop8jaeYiV1T95h4zk0YhvlAcPw124PjV8VQgkSEAec1X4fqD9rxO/JpmIqBOLWpofxQri6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732331361; c=relaxed/simple;
	bh=xTIHzGabawTieoNHPmY6TAGibaQ4jK9SnDJEWSTFpxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtXeqaPL5ksR0cvzTefz5eioXe6oGUCtT5qsaONkObdLyRO897CUChQijnmPfC/WpSEsMeeJApZ1d0MwtluSJbJX9ElZfr/UbzXjB8g7Ox5v16ppY9k2otDnfe0FguTr2UFmC7zy7yC7hpO33w8OwDUcfZUaJ5bg3TOU0+saq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb2mV5E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A6BC4CECE;
	Sat, 23 Nov 2024 03:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732331359;
	bh=xTIHzGabawTieoNHPmY6TAGibaQ4jK9SnDJEWSTFpxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rb2mV5E+AX3UHtwVJrGvMLxMzSAQmyj1gb9WqUzDmisEbMoiww63NDH3or1xk6CYs
	 fbJi3gb+WJLWuYsSWxKalwT/Wiw91Hn6Q8cfHKNebAnw9llm9PKT7tAsrMzPu9Ibkd
	 hJZOSmKoEoYS3P+aFcphSAjnEMqNI0h4kvT+2Yi73LNk509HDO0ozBlEUXk0woux73
	 HCBRiJXcgt6w6zBWcHf9bxIMdCX/GP9cvSV0vO1N+JQghu6PCmmR7UJVk4Xv7PLbD0
	 TyH9F+FH3fx6Q+bf0OJo5wXMB/Ld5Yme3wtp6hcTGyaXPgUqDKNtDlO8fANt2obQnD
	 pL+/7UoZOQhrA==
Date: Fri, 22 Nov 2024 20:09:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20241123030915.GA1020125@thelio-3990X>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <20241122122703.GW24774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122122703.GW24774@noisy.programming.kicks-ass.net>

On Fri, Nov 22, 2024 at 01:27:03PM +0100, Peter Zijlstra wrote:
> On Thu, Oct 03, 2024 at 04:29:38PM -0700, Nathan Chancellor wrote:
> 
> > $ /usr/bin/time -v make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper {def,amd_mem_encrypt.,fortify_source.,llvm_cov.}config bzImage
> > ...
> > vmlinux.o: warning: objtool: __sev_es_nmi_complete+0x6e: call to kasan_check_write() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_syscall_64+0x141: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_int80_emulation+0x138: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: handle_bug+0x5: call to kmsan_unpoison_entry_regs() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x73: call to user_enter_irqoff() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x105: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x62: call to user_enter_irqoff() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_enter+0x45: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_exit+0x4a: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4: call to lockdep_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: irqentry_nmi_exit+0x67: call to lockdep_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: enter_s2idle_proper+0xb5: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpuidle_enter_state+0x113: call to lockdep_hardirqs_off() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: default_idle_call+0xad: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: cpu_idle_poll+0x29: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x118: call to lockdep_hardirqs_on() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section
> 
> Just saw this fly by, that looks like something is buggered bad. Notably
> lockdep_hardirqs_{on,off}() are noinstr.
> 
> Is this patch-set causing this, or what?

These warnings are not present without CONFIG_LLVM_COV_PROFILE_ALL, so
it certainly seems related to this patchset. In this configuration,
CONFIG_KASAN and CONFIG_LOCKDEP are disabled, so these functions are
simple 'static inline' functions. An immediate theory is that because
this instrumentation is applied by the frontend, these functions will
not actually be empty or simple, which may affect the ability to inline
them and eliminate the instrumentation by the __no_profile from noinstr?
It definitely seems like this should probably be investigated...

Cheers,
Nathan

