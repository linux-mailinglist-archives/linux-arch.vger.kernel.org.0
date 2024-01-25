Return-Path: <linux-arch+bounces-1699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947A483CF40
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 23:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DCD2961EA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A757C13A27D;
	Thu, 25 Jan 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiTWWLkd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A5130E3C;
	Thu, 25 Jan 2024 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221421; cv=none; b=FWOxMqv6tcZGoyJRYwYJhR9A9lGWqfqzv21XVK4qY/2iA1NDqqMq9C+MwhuH9qApJ+NOlkrFzvsTodfRO/k2+uHbzD5R/3OHGwc8Jh8PQaukbUuEpoFmONrg0zREEoZ6F6wHSNv5OmWBnkoARtiB57BJMCB04HdBeNYu6Lsbudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221421; c=relaxed/simple;
	bh=KfWASBKDRevu5qr6cQGKAvSwJBw6sVXr+1MQuNzLhVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLXgvEhuuXy4WPSpw9UHjX7gSCNtj7XVgSzKFq893thmDlarkD02JSlCdDPdBp6gXRdWnlp5Ga+RZJbwHO5wyYPzkPapvfzFKvGWnpkCF8GOgUpZkW+fIsDxbbJexXM8HvsAIzGn8idiCqCQxtcTti0Zp+/sgP1PJfWa2YcxmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiTWWLkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9870C433C7;
	Thu, 25 Jan 2024 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706221420;
	bh=KfWASBKDRevu5qr6cQGKAvSwJBw6sVXr+1MQuNzLhVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiTWWLkdkQo12gTzQBOX3h+TwC0Ruzgc3ZyfL26QUpfjrM8YESoBKG87eQ9BQ0k1U
	 toK3R+OF32jGpRzPDcDOOg0iy0GjzvEyiKE633qLanq2ehveV7Uk/nmM3tKARUzq+j
	 yImY/0ZtWWA6UwfMLcuvKmdFf8NP4NR3KfpcqmwxJh5TTUhnztD9nrFakXMNOtvXuR
	 3fi+2PYGybO3IG1UohFZnfVCY7xbuNzcZByUklN4yJnRDNhCLp5AEwdg5DFpXQzMV8
	 hfkA1682Nfk2TESVmvlkbjU7gcyEdk7rHt6jX9joAehJ49UhP7yCXSTwqyugKyPOri
	 ulUUEbCf9qecw==
Date: Thu, 25 Jan 2024 15:23:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 00/17] x86: Confine early 1:1 mapped startup code
Message-ID: <20240125222338.GA2585843@dev-arch.thelio-3990X>
References: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>

Hi Ard,

On Thu, Jan 25, 2024 at 12:28:19PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> This is a follow-up to my RFC [0] that proposed to build the entire core
> kernel with -fPIC, to reduce the likelihood that code that runs
> extremely early from the 1:1 mapping of memory will misbehave.
> 
> This is needed to address reports that SEV boot on Clang built kernels
> is broken, due to the fact that this early code attempts to access
> virtual kernel address that are not mapped yet. Kevin has suggested some
> workarounds to this [1] but this is really something that requires a
> more rigorous approach, rather than addressing a couple of symptoms of
> the underlying defect.
> 
> As it turns out, the use of fPIE for the entire kernel is neither
> necessary nor sufficient, and has its own set of problems, including the
> fact that the PIE small C code model uses FS rather than GS for the
> per-CPU register, and only recent GCC and Clang versions permit this to
> be overridden on the command line.
> 
> But the real problem is that even position independent code is not
> guaranteed to execute correctly at any offset unless all statically
> initialized pointer variables use the same translation as the code.
> 
> So instead, this v2 proposes another solution, taking the following
> approach:
> - clean up and refactor the startup code so that the primary startup
>   code executes from the 1:1 mapping but nothing else;
> - define a new text section type .pi.text and enforce that it can only
>   call into other .pi.text sections;
> - (tbd) require that objects containing .pi.text sections are built with
>   -fPIC, and disallow any absolute references from such objects.
> 
> The latter point is not implemented yet in this v2, but this could be
> done rather straight-forwardly. (The EFI stub already does something
> similar across all architectures)
> 
> Patch #13 in particular gives an overview of all the code that gets
> pulled into the early 1:1 startup code path due to the fact that memory
> encryption needs to be configured before we can even map the kernel.
> 
> 
> [0] https://lkml.kernel.org/r/20240122090851.851120-7-ardb%2Bgit%40google.com
> [1] https://lore.kernel.org/all/20240111223650.3502633-1-kevinloughlin@google.com/T/#u

I tested both this series as well as the pending updates on
x86-pie-for-sev-v3 at commit 0574677aacf7 ("x86/efi: Remap kernel code
read-only before dropping NX attribute") with my LLVM build matrix and I
noticed two problems.

The first issue is a series of errors when building with LTO around
mismatched code model attributes between functions. Unhelpfully, the
error message does not actually say what function is conflicting...

  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(numa.o at 1191378)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(buffer.o at 1211538)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(nfs4xdr.o at 1222698)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(namei.o at 1209498)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(vmalloc.o at 1207458)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(iommu.o at 1267098)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(ring_buffer.o at 1202478)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(sky2.o at 1299798)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(page_alloc.o at 1207578)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(percpu.o at 1206018)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(slub.o at 1207758)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(xhci.o at 1302858)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(blk-mq.o at 1233858)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(nfs4proc.o at 1222638)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(inode.o at 1218078)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(journal.o at 1219638)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(memory.o at 1206738)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(mballoc.o at 1218198)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(iov_iter.o at 1238058)'
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(head64.o at 1181178)' and 'vmlinux.a(filemap.o at 1204938)'

Turning off LTO for the translation units that use PIE_CFLAGS avoids
that, not sure if that is reasonable or not.

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 65677b25d803..e4fa57ae3d09 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -24,7 +24,9 @@ endif
 # head64.c contains C code that may execute from a different virtual address
 # than it was linked at, so we always build it using PIE codegen
 CFLAGS_head64.o += $(PIE_CFLAGS)
+CFLAGS_REMOVE_head64.o += $(CC_FLAGS_LTO)
 CFLAGS_sev.o += $(PIE_CFLAGS)
+CFLAGS_REMOVE_sev.o += $(CC_FLAGS_LTO)
 
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 87c79bb8d386..6bb4bc271441 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -25,6 +25,7 @@ CFLAGS_REMOVE_cmdline.o = -pg
 endif
 
 CFLAGS_cmdline.o := $(PIE_CFLAGS)
+CFLAGS_REMOVE_cmdline.o := $(CC_FLAGS_LTO)
 endif
 
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index b412009ae588..bf8d9d4bc97f 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -31,8 +31,10 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= $(PIE_CFLAGS)
+CFLAGS_mem_encrypt_identity.o			:= $(PIE_CFLAGS)
+CFLAGS_REMOVE_mem_encrypt_identity.o	:= $(CC_FLAGS_LTO)
 CFLAGS_pti.o			:= $(PIE_CFLAGS)
+CFLAGS_REMOVE_pti.o		:= $(CC_FLAGS_LTO)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 

The second issue is a bunch of modpost warnings I see with various
configurations around some UBSAN and tracing functions.

Clang allmodconfig:

  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x353 (section: .pi.text) -> __phys_addr (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x35e (section: .pi.text) -> __phys_addr (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x3f8 (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x41f (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x44a (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_cpuid+0xa6 (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_cpuid+0x316 (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_init+0x12d (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_cpuid_hv+0x10d (section: .pi.text) -> __phys_addr (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x5 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x15 (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x26 (section: .pi.text) -> __sanitizer_cov_trace_const_cmp8 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x36 (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x54 (section: .pi.text) -> __sanitizer_cov_trace_const_cmp8 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x6a (section: .pi.text) -> __sanitizer_cov_trace_const_cmp8 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x8d (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0x5 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0x42 (section: .pi.text) -> __phys_addr_symbol (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0x51 (section: .pi.text) -> __phys_addr_symbol (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_pgtable_calc+0x1 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_enable+0x5 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __strncmp+0x1 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __sme_map_range+0x1 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __sme_map_range_pte+0x1 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_prepare_pgd+0x1 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: cmdline_find_option_bool+0x5 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: cmdline_find_option+0x5 (section: .pi.text) -> __fentry__ (section: .text)

GCC allmodconfig

  WARNING: modpost: vmlinux: section mismatch in reference: early_load_idt+0x53 (section: .pi.text) -> native_write_idt_entry.constprop.0 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x348 (section: .pi.text) -> __phys_addr (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x353 (section: .pi.text) -> __phys_addr (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x436 (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text.unlikely)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x47b (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text.unlikely)
  WARNING: modpost: vmlinux: section mismatch in reference: __startup_64+0x4c0 (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text.unlikely)
  WARNING: modpost: vmlinux: section mismatch in reference: sev_es_ghcb_hv_call+0x58 (section: .pi.text) -> __phys_addr (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: setup_cpuid_table+0xf6 (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text.unlikely)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_cpuid_hv+0x6 (section: .pi.text) -> __sev_cpuid_hv_ghcb (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_cpuid+0xde (section: .pi.text) -> snp_cpuid_postprocess (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: snp_cpuid+0x16c (section: .pi.text) -> __ubsan_handle_out_of_bounds (section: .text.unlikely)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x6 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x15 (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x29 (section: .pi.text) -> __sanitizer_cov_trace_const_cmp8 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x33 (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x51 (section: .pi.text) -> __sanitizer_cov_trace_const_cmp8 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x5c (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x71 (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x82 (section: .pi.text) -> __sanitizer_cov_trace_const_cmp8 (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __pti_set_user_pgtbl+0x8c (section: .pi.text) -> __sanitizer_cov_trace_pc (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_pgtable_calc+0x2 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_clear_pgd+0x2 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_prepare_pgd+0x2 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_populate_pgd+0x2 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: __sme_map_range+0x2 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0x6 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0x19 (section: .pi.text) -> stackleak_track_stack (section: .noinstr.text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0x8f (section: .pi.text) -> __phys_addr_symbol (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_encrypt_kernel+0xa5 (section: .pi.text) -> __phys_addr_symbol (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: sme_enable+0x6 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: cmdline_find_option_bool+0x6 (section: .pi.text) -> __fentry__ (section: .text)
  WARNING: modpost: vmlinux: section mismatch in reference: cmdline_find_option+0x6 (section: .pi.text) -> __fentry__ (section: .text)

Should functions marked with __pitext have these sanitizers disabled?

Cheers,
Nathan

