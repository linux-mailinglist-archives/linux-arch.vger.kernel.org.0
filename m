Return-Path: <linux-arch+bounces-1913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98228440ED
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 14:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3268C1F24E4C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60167F490;
	Wed, 31 Jan 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ft9+zo/2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA57BAFD;
	Wed, 31 Jan 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708709; cv=none; b=HkRchvNYy+9tsWQZEHh2YwKIPdFc3pg1UvGBjhyXRvjYPjX7+PwVpn6mCYE2lax/mBQCF5XU6vc5oBJ2NZT2tJsH9kh9J3CxsI2Rv96sQJK3Novc2Mf5JQZ1sx84vYiSAlJpbGcV72RElOYEyM77Un3sWJBbLLX4vaCTgdZToX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708709; c=relaxed/simple;
	bh=ko9z6/bFheAwnGiWMZ6vEZKMvFzJZVuzUrhnaUT0xNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPIMNBATFrU4iwCv3RR4ZH/o3qiCVmVrEBVFUiVtVZfCZOA5zonA9RVasA65ZufRh0hcpbqBbaMcE3dDGOdNrJ1h4j+u7BLbsv7n5x5FNHsrD8oEFhRziSb9MUTCiYyT/Zb8M239OXWcqF6bubeTUMfZSCZCFRRxEOgVtf9JfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ft9+zo/2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C8FBF40E0177;
	Wed, 31 Jan 2024 13:44:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5EzhkpaSewFH; Wed, 31 Jan 2024 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706708695; bh=vd0S3+VygE3QCe4RuOxmUMpSvRBiS6wvgNYSYf4SLJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ft9+zo/24INLYyRbnV1+Ue6tpOUUMqsqkgxYHXPFgAcsizBpOzGDL6MlN+vNGgwo4
	 YKDmbbRtah8FtD9nG8Qc29P8Semmu3NeswchNzRufDyeZrllDZ74E8XgnSE1rzFExo
	 B9WV4/sXDheqcDeQE+UB8zX0zcAhW/Vy9ZIZXgcq5Wlru9yPXw9aHzJG0+n1NJLbdG
	 UVKxx733vwMu/c6s80iJgnOzOEjIJJXd+D6NfnuyuNoUmeXw6pZ+O+nN3Gfs8L07xT
	 OEIZuv+wvNAnUYIo6ABZ9GjGDCPszIbp2shs5tj0z7lcs/sjMGiCHPD19JiRWWU0wk
	 YuNutbMPXcky7bAzTZWTCGxyK+wnAvpKSo7GQKO+b1S/LV9Hae8hWLvPo8JQySY5Vw
	 +NKGYW6dQ+DT/zw2aeNRDkJ5iOSNKswAuNGqTQUvjJGRYptkbkU3VoF/h9RzZDlUbR
	 TLq1FeUIk2Rb1B2xlk1b4qPcU9an6V++AH+HBQCGf+W4NxPxnxEHIxWFyex5LFbpRY
	 84xcA0/TsOBrJYEWV3RLW8FTuxbv2EnldN/cGQUQjYjOXO305LVMILVE+4QmGCg+MN
	 BfjsWECgJYF1NoBmwJ6A9muNf7ttPBqRPUeZq/+bH1eHNl0kXxKH9jR8vP4bqzdG9i
	 RIBHJzI1m00ykTVMj5fZFvZk=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A71440E00B2;
	Wed, 31 Jan 2024 13:44:37 +0000 (UTC)
Date: Wed, 31 Jan 2024 14:44:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 03/19] x86/startup_64: Drop long return to
 initial_code pointer
Message-ID: <20240131134431.GJZbpOvz3Ibhg4VhCl@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-24-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:06PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Since commit 866b556efa12 ("x86/head/64: Install startup GDT"), the
> primary startup sequence sets the code segment register (CS) to __KERNEL_CS
> before calling into the startup code shared between primary and
> secondary boot.
> 
> This means a simple indirect call is sufficient here.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head_64.S | 35 ++------------------
>  1 file changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d4918d03efb4..4017a49d7b76 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -428,39 +428,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	movq	%r15, %rdi
>  
>  .Ljump_to_C_code:
> -	/*
> -	 * Jump to run C code and to be on a real kernel address.
> -	 * Since we are running on identity-mapped space we have to jump
> -	 * to the full 64bit address, this is only possible as indirect
> -	 * jump.  In addition we need to ensure %cs is set so we make this
> -	 * a far return.
> -	 *
> -	 * Note: do not change to far jump indirect with 64bit offset.
> -	 *
> -	 * AMD does not support far jump indirect with 64bit offset.
> -	 * AMD64 Architecture Programmer's Manual, Volume 3: states only
> -	 *	JMP FAR mem16:16 FF /5 Far jump indirect,
> -	 *		with the target specified by a far pointer in memory.
> -	 *	JMP FAR mem16:32 FF /5 Far jump indirect,
> -	 *		with the target specified by a far pointer in memory.
> -	 *
> -	 * Intel64 does support 64bit offset.
> -	 * Software Developer Manual Vol 2: states:
> -	 *	FF /5 JMP m16:16 Jump far, absolute indirect,
> -	 *		address given in m16:16
> -	 *	FF /5 JMP m16:32 Jump far, absolute indirect,
> -	 *		address given in m16:32.
> -	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
> -	 *		address given in m16:64.
> -	 */
> -	pushq	$.Lafter_lret	# put return address on stack for unwinder
>  	xorl	%ebp, %ebp	# clear frame pointer
> -	movq	initial_code(%rip), %rax
> -	pushq	$__KERNEL_CS	# set correct cs
> -	pushq	%rax		# target address in negative space
> -	lretq
> -.Lafter_lret:
> -	ANNOTATE_NOENDBR
> +	ANNOTATE_RETPOLINE_SAFE
> +	callq	*initial_code(%rip)
> +	int3
>  SYM_CODE_END(secondary_startup_64)
>  
>  #include "verify_cpu.S"

objtool doesn't like it yet:

vmlinux.o: warning: objtool: verify_cpu+0x0: stack state mismatch: cfa1=4+8 cfa2=-1+0

Once we've solved this, I'll take this one even now - very nice cleanup!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

