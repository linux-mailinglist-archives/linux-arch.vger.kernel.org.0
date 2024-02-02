Return-Path: <linux-arch+bounces-2001-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884A8474F5
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A99D1C2749A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718C1487CD;
	Fri,  2 Feb 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DjWjJhKY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB991487E7;
	Fri,  2 Feb 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891743; cv=none; b=WrxHHd2Ft3Uis8MtCsFVJ9P+4n8WJUyF30eLuY8hqHUFzT9q04OSyywknwKpzOe81Cg07ZNEOOLEVuA8gi6JExSQH//hekb7uywUKenn8bXtZg1R49KZgSPo0q5zGMTnwj/C97P584BVFzP+nxe/xQUz9Pmrptet0F6SvhVb2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891743; c=relaxed/simple;
	bh=jfP5FzF2iADTs+nsumSsf+1ytpdI2PwVjp67EKLfiAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXX0uCT+gnqPo6sUSa6aNfgo3Rt3xMniTwN53BaU6TINU366mvT6YJq/PxaFj2zKjigCyemJPC4i6G+E559pfw3eNKtDxtIhWb0r416/mj0qbu2wB3BsqB1pCNIWgdkzJqMdnfkvdY5PxJe8XQ8xmqOG6evuMLpM8xRlPnX7ecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DjWjJhKY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D347240E01A2;
	Fri,  2 Feb 2024 16:35:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BDgLq2vi6VrF; Fri,  2 Feb 2024 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706891735; bh=owu4C5rP9Sd62pQo+ZZmYYXOi0xhUhCRq+QLaeQVQpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjWjJhKYuKNK0B335q79y2JbDvwkbghSEGXDReaL7Cg1RJtRKkXofVtq1nTBVZYFi
	 NowRJnt6AZzjVGdQXfyoK3lTxR79KCU89p043iQp2G6OSDb5f1nfaTLW3z2H4RgZq2
	 y9lrlWDxtzk8HVUP2YJ9wG0mhbKPb+0G0s0Mefn2qTxGLwkmbmyJYZfu0PoqABvXpt
	 /8GfEiQDhzYMT695rw8G95eurTWucDepUJF1M6nIOMR4W4qp9eeZEj7Va1k5/hCl0b
	 8Aq8IR9bgZjtCvxYrvcNFiUklU/dLr8+1+R48++a/I9ah0Ias/yQ3L5qKvu4CM28jG
	 182l15VndVVs5pW2EmKozZh9+FWxpmJDtqdlidMwHmvrV+z19zjgp0aVcmqvsLjlQj
	 EO1sEM9Ows2Mhs8BSraRTv6JfSrcqrtdn8mJDXFMY+vGq4ItmzIZhahm4T03KYvvgK
	 tqoXR4Mxzz7of/FQGvXn3zaUDaPYWQQYkOReLU9tzWhw+0mIL1lbncx7JXbH0sXmay
	 xwFfgNHMV0dBmFIWezmZLwFZNyhbY0XfGmjIhvbeyIl0H65UvzF8a+B6ElLl4M74yN
	 Ee25ps5Kn2cvhQB2MRfVMeC9wlh9tvPRDKSGSZtUexgk9Vr8SgQd6whdz5pyTzBBBc
	 jg42PO4t4LFSICDfcWKeKE14=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D894040E016C;
	Fri,  2 Feb 2024 16:35:16 +0000 (UTC)
Date: Fri, 2 Feb 2024 17:35:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
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
Subject: [PATCH] x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
Message-ID: <20240202163510.GDZb0Zvj8qOndvFOiZ@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com>
 <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
 <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
 <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local>
 <8b38ef82-ec2b-4845-9732-15713a0e2a85@amd.com>
 <CAMj1kXH4U7X3_xgwhYUgbWqVfnzL5Dx0QaUhb_5TpZGQEh=_8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXH4U7X3_xgwhYUgbWqVfnzL5Dx0QaUhb_5TpZGQEh=_8g@mail.gmail.com>

On Thu, Feb 01, 2024 at 05:15:51PM +0100, Ard Biesheuvel wrote:
> OK, I'll remove it in the next rev.

Considering how it simplifies sme_enable() even more, I'd like to
expedite this one.

Thx.

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 2 Feb 2024 17:29:32 +0100
Subject: [PATCH] x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT

It was meant well at the time but nothing's using it so get rid of it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/kernel-parameters.txt  |  4 +---
 Documentation/arch/x86/amd-memory-encryption.rst | 16 ++++++++--------
 arch/x86/Kconfig                                 | 13 -------------
 arch/x86/mm/mem_encrypt_identity.c               | 11 +----------
 4 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..2cb70a384af8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3320,9 +3320,7 @@
 
 	mem_encrypt=	[X86-64] AMD Secure Memory Encryption (SME) control
 			Valid arguments: on, off
-			Default (depends on kernel configuration option):
-			  on  (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y)
-			  off (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=n)
+			Default: off
 			mem_encrypt=on:		Activate SME
 			mem_encrypt=off:	Do not activate SME
 
diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 07caa8fff852..414bc7402ae7 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -87,14 +87,14 @@ The state of SME in the Linux kernel can be documented as follows:
 	  kernel is non-zero).
 
 SME can also be enabled and activated in the BIOS. If SME is enabled and
-activated in the BIOS, then all memory accesses will be encrypted and it will
-not be necessary to activate the Linux memory encryption support.  If the BIOS
-merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG), then Linux can activate
-memory encryption by default (CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y) or
-by supplying mem_encrypt=on on the kernel command line.  However, if BIOS does
-not enable SME, then Linux will not be able to activate memory encryption, even
-if configured to do so by default or the mem_encrypt=on command line parameter
-is specified.
+activated in the BIOS, then all memory accesses will be encrypted and it
+will not be necessary to activate the Linux memory encryption support.
+
+If the BIOS merely enables SME (sets bit 23 of the MSR_AMD64_SYSCFG),
+then memory encryption can be enabled by supplying mem_encrypt=on on the
+kernel command line.  However, if BIOS does not enable SME, then Linux
+will not be able to activate memory encryption, even if configured to do
+so by default or the mem_encrypt=on command line parameter is specified.
 
 Secure Nested Paging (SNP)
 ==========================
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..58d3593bc4f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1539,19 +1539,6 @@ config AMD_MEM_ENCRYPT
 	  This requires an AMD processor that supports Secure Memory
 	  Encryption (SME).
 
-config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
-	bool "Activate AMD Secure Memory Encryption (SME) by default"
-	depends on AMD_MEM_ENCRYPT
-	help
-	  Say yes to have system memory encrypted by default if running on
-	  an AMD processor that supports Secure Memory Encryption (SME).
-
-	  If set to Y, then the encryption of system memory can be
-	  deactivated with the mem_encrypt=off command line option.
-
-	  If set to N, then the encryption of system memory can be
-	  activated with the mem_encrypt=on command line option.
-
 # Common NUMA Features
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7f72472a34d6..efe9f217fcf9 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -97,7 +97,6 @@ static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
-static char sme_cmdline_off[] __initdata = "off";
 
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
@@ -504,7 +503,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
+	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
@@ -587,12 +586,6 @@ void __init sme_enable(struct boot_params *bp)
 	asm ("lea sme_cmdline_on(%%rip), %0"
 	     : "=r" (cmdline_on)
 	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
-		sme_me_mask = me_mask;
 
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
@@ -602,8 +595,6 @@ void __init sme_enable(struct boot_params *bp)
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
-		sme_me_mask = 0;
 
 out:
 	if (sme_me_mask) {
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

