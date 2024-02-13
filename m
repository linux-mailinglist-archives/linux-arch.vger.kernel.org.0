Return-Path: <linux-arch+bounces-2305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D6853BE1
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 21:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5899B2174D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 20:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D49608ED;
	Tue, 13 Feb 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jTN0VsHU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBE1428F;
	Tue, 13 Feb 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854787; cv=none; b=Z6C10b0C99ZvfIqvgJIDuQwpu8HTPaT3fbMg5P5jQ4PadHXDN54sDzzzUC1qg6XsxsFuv1AGISZlBN+d7hYHqML+o4Phg7Th9D3WWPGOqyZ60gD9hbRCAjzXQYnLcNFYtRl3jgpXpNpw+ho2GOtWpaZlUR2hS4EZlO5aycPGdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854787; c=relaxed/simple;
	bh=vdxp4/PPE9hCtMCXH030GyY19LKK9iQwEhgR0euELVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6RxC5xozzJ+9RFkUQbsSphoH8LSOssI2vmLLicDVeKt5yZzoqXBgWW4hQkDE6gd/gexPNyGnIYht1jj2N7MgQPkbe0iQMs408FT/XpPudn7ltUeb2q2sAbqhYCLTCf5EM/YJSm+FvtGvqBKrqndMnjPjPVl7ifaowJiR3WRI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jTN0VsHU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A769740E01BB;
	Tue, 13 Feb 2024 20:06:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4n2K_bezxT6a; Tue, 13 Feb 2024 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707854778; bh=goOcw7LN1zf72G8QXmdoMLRbJAF9DoW+MoDb3aH9utw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTN0VsHUjY3YLADs/06htH0XYziIGGjqIjbZSKXZIKZReSlPlwD17cU292sGLc0bT
	 BXcax6hSvypq0AsEM05kT+cEBem3YEWo3Kr178JKLbZ/snZ0F858U4HKzNZNpjEPLF
	 bfJfXB6umEEtvxPXlGkEmwifX6T9I5X/ecJQ9UagagQdltwgnYEIDJz5NLLAiX/en7
	 PN/5zUrP8/zRxp2zni4xXU3Qs+2D8U7QEFbh+41/mB5mOjyOneMizQtM6A9KRCf7ck
	 9pIQBSoOD+TcPn24xQ83o5A5/aeKgeCpjQqEM3L7rzptpuTfixSvbVggMTfnyT9/7P
	 +wxAs5vuJGCZkDKv5fMB8SFR1WCOV0bLkRkbFsUh840rChFU/nirUSVJo169RiLnXE
	 YdPHGrjVUF8A7rachK3LtlvccDpJzfU6EY84Zqc5DTrywU4alBrwOyRZ9l04ROB82h
	 BaqZ/m3/f/6ppe3Edcl2BtBTh2HhuAJOdnW+8KfFMTTAUV7kNhRW0lpD4QHmmEUe0W
	 PSbCZlbHluFvwdYQpk5y8uv6TI6hVb9OO02QoChfcMMHF+Ytl4/gWv9hPKA5hTgzBE
	 Z/MWvQEnJzPLofiJiuU2zrvIWtiSeJSL21DO1spxf6MV/vd1GArBAFnV0KNLS4ZwKZ
	 vGvyzpTJ4SN0m+Q985PSuq/w=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AA6040E0192;
	Tue, 13 Feb 2024 20:05:59 +0000 (UTC)
Date: Tue, 13 Feb 2024 21:05:53 +0100
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
Subject: Re: [PATCH v4 01/11] x86/startup_64: Simplify global variable
 accesses in GDT/IDT programming
Message-ID: <20240213200553.GYZcvLoYUNJOPGxoid@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213124143.1484862-14-ardb+git@google.com>

On Tue, Feb 13, 2024 at 01:41:45PM +0100, Ard Biesheuvel wrote:
> @@ -632,5 +616,5 @@ void __head startup_64_setup_env(unsigned long physbase)
>  		     "movl %%eax, %%ss\n"
>  		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
>  
> -	startup_64_load_idt(physbase);
> +	startup_64_load_idt(&RIP_REL_REF(vc_no_ghcb));

It took me a while to figure out that even if we pass in one of the two
GHCB handler pointers, we only set it if CONFIG_AMD_MEM_ENCRYPT.

I think this ontop of yours is a bit more readable as it makes it
perfectly clear *when* the pointer is valid.

Yeah, if handler is set, we set it for the X86_TRAP_VC vector
unconditionally but that can be changed later, if really needed.

But this way it is clear by having the callers select the pointer. I.e.,
it is a more common coding pattern this way, I'd say.

Thx.

---

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 9d7f12829f2d..e39114c348e2 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -582,8 +582,8 @@ static void __head startup_64_load_idt(void *handler)
 	};
 	gate_desc *idt = (gate_desc *)desc.address;
 
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
-		/* VMM Communication Exception */
+	/* @handler is set only for a VMM Communication Exception */
+	if (handler)
 		set_bringup_idt_handler(idt, X86_TRAP_VC, handler);
 
 	native_load_idt(&desc);
@@ -592,10 +592,14 @@ static void __head startup_64_load_idt(void *handler)
 /* This is used when running on kernel addresses */
 void early_setup_idt(void)
 {
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+	void *handler = NULL;
+
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		setup_ghcb();
+		handler = vc_boot_ghcb;
+	}
 
-	startup_64_load_idt(vc_boot_ghcb);
+	startup_64_load_idt(handler);
 }
 
 /*
@@ -603,6 +607,8 @@ void early_setup_idt(void)
  */
 void __head startup_64_setup_gdt_idt(void)
 {
+	void *handler = NULL;
+
 	struct desc_ptr startup_gdt_descr = {
 		.address	= (unsigned long)&RIP_REL_REF(startup_gdt),
 		.size		= sizeof(startup_gdt) - 1,
@@ -616,5 +622,8 @@ void __head startup_64_setup_gdt_idt(void)
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
 
-	startup_64_load_idt(&RIP_REL_REF(vc_no_ghcb));
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
+		handler = &RIP_REL_REF(vc_no_ghcb);
+
+	startup_64_load_idt(handler);
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

