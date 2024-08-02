Return-Path: <linux-arch+bounces-5911-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A3945A9C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFD81C20CFA
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECF1D4158;
	Fri,  2 Aug 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbGgmTrx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA01C2305;
	Fri,  2 Aug 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590085; cv=none; b=Auo50E+f8R+VUEKHSISE8wsXRwa1/eTq0HYMicLd9DUVPryctXCcpqop3FoLlbUmnC63Mx0iCFywuQ3yG1eJ0nLoib59Zp975/vlP6BqKAv6LV9yDwJwiQrK8WtLh23Q2Wd7ZT2XO6y40zfuEDbCbj7CDJjCmEPgnP9xJXHa4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590085; c=relaxed/simple;
	bh=NtQgUIIaE/hqf9ZTyjTigeg1fDW8BSWir7Rbxa7onBM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dgyB9NXwAk338UCep/reZe4aj5Dk0Oq1gJ+jicG2jkk9fjNTGGsP3foBQONA6Lq8EG8STTpT5W9EkxtGP6pI6JEhSLnK8yxt6+9lKXpNCLPyo9IyyMGioGUf62ySWC8tWCAqS0HAZgTPOOe1JSoB3HhcuNb7dJYKJsJpTl0utZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbGgmTrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A92C32782;
	Fri,  2 Aug 2024 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722590084;
	bh=NtQgUIIaE/hqf9ZTyjTigeg1fDW8BSWir7Rbxa7onBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bbGgmTrxzQuS5tpbP9+9wboqMGAMhPhZxnIf7/wgIM1HfEZsdkvoOSZVzK6P9e32M
	 lMD2hyN+pM35SRh/ImRDfjqNugGhL7WfQYPU4aeJtxn6UhCioWMYMaeAtFc8TDGKF7
	 Gw1dgnn76w9678hmQ0dgbjflCp26qZIbs5XN6Q2d7cwg0TLPE66V3pZVcoHADS0qUi
	 V+mFXGTAJpF16uUhRlnTobySNCRf9enDuEef0rMrYIFgGoZ0K2aBYayOPV6tEX/IvY
	 BycB/v3LvDzb3ZKqzy0+ZGb+jk9UN+hXzBqPx2JJQdU+QNIeUKbTH9NiXb/jkt+mgj
	 sWYG+HG8RjSnw==
Date: Fri, 2 Aug 2024 18:14:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "H.J. Lu" <hjl.tools@gmail.com>, Sohil Mehta
 <sohil.mehta@intel.com>, Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC] uretprobe: change syscall number, again
Message-Id: <20240802181437.29b439e26608561f1289892a@kernel.org>
In-Reply-To: <20240730154500.3155437-1-arnd@kernel.org>
References: <20240730154500.3155437-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 17:43:36 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Despite multiple attempts to get the syscall number assignment right
> for the newly added uretprobe syscall, we ended up with a bit of a mess:
> 
>  - The number is defined as 467 based on the assumption that the
>    xattrat family of syscalls would use 463 through 466, but those
>    did not make it into 6.11.

OK... that was not expected.

> 
>  - The include/uapi/asm-generic/unistd.h file still lists the number
>    463, but the new scripts/syscall.tbl that was supposed to have the
>    same data lists 467 instead as the number for arc, arm64, csky,
>    hexagon, loongarch, nios2, openrisc and riscv. None of these
>    architectures actually provide a uretprobe syscall.

Oops, thanks for finding.

> 
>  - All the other architectures (powerpc, arm, mips, ...) don't list
>    this syscall at all.

OK, so even if it is not supported on those, we need to put it as a
placeholder.

> 
> There are two ways to make it consistent again: either list it with
> the same syscall number on all architectures, or only list it on x86
> but not in scripts/syscall.tbl and asm-generic/unistd.h.
> 
> Based on the most recent discussion, it seems like we won't need it
> anywhere else, so just remove the inconsistent assignment and instead
> move the x86 number to the next available one in the architecture
> specific range, which is 335.
> 
> Fixes: 5c28424e9a34 ("syscalls: Fix to add sys_uretprobe to syscall.tbl")
> Fixes: 190fec72df4a ("uprobe: Wire up uretprobe system call")
> Fixes: 63ded110979b ("uprobe: Change uretprobe syscall scope and number")
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I think we should fix this as soon as possible. Please let me know if
> you agree on this approach, or prefer one of the alternatives.

OK, I think it is good. But you missed to fix a selftest code which
also needs to be updated.

Could you revert commit 3e301b431b91 ("selftests/bpf: Change uretprobe
 syscall number in uprobe_syscall test") too?

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> I've queued up this version in the asm-generic tree so I can send a
> pull request in the next few days, but I'm fine with doing this a
> differently if someone has a stronger opinion on what numbers to
> assign for it on earch architecture.
> 
>  arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
>  include/uapi/asm-generic/unistd.h      | 5 +----
>  scripts/syscall.tbl                    | 1 -
>  3 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 83073fa3c989..7093ee21c0d1 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -344,6 +344,7 @@
>  332	common	statx			sys_statx
>  333	common	io_pgetevents		sys_io_pgetevents
>  334	common	rseq			sys_rseq
> +335	common	uretprobe		sys_uretprobe
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424	common	pidfd_send_signal	sys_pidfd_send_signal
> @@ -385,7 +386,6 @@
>  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
>  461	common	lsm_list_modules	sys_lsm_list_modules
>  462 	common  mseal			sys_mseal
> -467	common	uretprobe		sys_uretprobe
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 985a262d0f9e..5bf6148cac2b 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -841,11 +841,8 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>  #define __NR_mseal 462
>  __SYSCALL(__NR_mseal, sys_mseal)
>  
> -#define __NR_uretprobe 463
> -__SYSCALL(__NR_uretprobe, sys_uretprobe)
> -
>  #undef __NR_syscalls
> -#define __NR_syscalls 464
> +#define __NR_syscalls 463
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 591d85e8ca7e..797e20ea99a2 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -402,4 +402,3 @@
>  460	common	lsm_set_self_attr		sys_lsm_set_self_attr
>  461	common	lsm_list_modules		sys_lsm_list_modules
>  462	common	mseal				sys_mseal
> -467	common	uretprobe			sys_uretprobe
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

