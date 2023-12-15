Return-Path: <linux-arch+bounces-1070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A56814482
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CA82835FD
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151EE18E28;
	Fri, 15 Dec 2023 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKTY9C+Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E6171BB;
	Fri, 15 Dec 2023 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=z79WJTlUkpGdsrYGZxRofGTWpjl5gntweNg1HQWKrSY=; b=BKTY9C+YqD87P54owc5F7b/Qn0
	UQ7eqYLs8JXjLvGcrgMXgzA1mB5IRjRx7oambwG+fguM5VRL8jgy8NuT/pVOaMbNQ28W9Zsu5gXkv
	GxAlZtOMKilcoqkIzW1weuxThEKpLS2idiB9L7vznPnbIwA3laTCWDkli8FoBfPoV/NLMoR0yRid0
	oXnsQTNdNPK90SrKYQaH1kXrZyqo9Zj8IrtQH2KoOCitrlUzD9Tb6wpg6kkOWUGgdJqarNsDQkrL7
	37FbfJe680BaRWDccu5O5vQRHIK1Bd2TsCV1DKwJ7UDzae8DkOkZQJumJ6D7ZYt0HW05qAWNdOz1H
	yHv/QUfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE4ZD-00FSOV-HC; Fri, 15 Dec 2023 09:33:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CB29B3006DD; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215092707.451956710@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@google.com,
 haoluo@google.com,
 jolsa@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 samitolvanen@google.com,
 keescook@chromium.org,
 nathan@kernel.org,
 ndesaulniers@google.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 jpoimboe@kernel.org,
 joao@overdrivepizza.com,
 mark.rutland@arm.com,
 peterz@infradead.org
Subject: [PATCH v3 3/7] x86/cfi,bpf: Fix bpf_callback_t CFI
References: <20231215091216.135791411@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Where the main BPF program is expected to match bpf_func_t,
sub-programs are expected to match bpf_callback_t.

This fixes things like:

tools/testing/selftests/bpf/progs/bloom_filter_bench.c:

           bpf_for_each_map_elem(&array_map, bloom_callback, &data, 0);

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h    |    2 ++
 arch/x86/kernel/alternative.c |   18 ++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   |   18 ++++++++++--------
 3 files changed, 30 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -106,6 +106,7 @@ struct pt_regs;
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
 extern u32 cfi_bpf_hash;
+extern u32 cfi_bpf_subprog_hash;
 
 static inline int cfi_get_offset(void)
 {
@@ -128,6 +129,7 @@ static inline enum bug_trap_type handle_
 	return BUG_TRAP_TYPE_NONE;
 }
 #define cfi_bpf_hash 0U
+#define cfi_bpf_subprog_hash 0U
 #endif /* CONFIG_CFI_CLANG */
 
 #endif /* _ASM_X86_CFI_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -866,6 +866,23 @@ asm (
 "	.size	cfi_bpf_hash, 4					\n"
 "	.popsection						\n"
 );
+
+/* Must match bpf_callback_t */
+extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
+
+__ADDRESSABLE(__bpf_callback_fn);
+
+/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_subprog_hash,@object			\n"
+"	.globl	cfi_bpf_subprog_hash				\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_subprog_hash:						\n"
+"	.long	__kcfi_typeid___bpf_callback_fn			\n"
+"	.size	cfi_bpf_subprog_hash, 4				\n"
+"	.popsection						\n"
+);
 #endif
 
 #ifdef CONFIG_FINEIBT
@@ -1181,6 +1198,7 @@ static void __apply_fineibt(s32 *start_r
 		if (builtin) {
 			cfi_seed = get_random_u32();
 			cfi_bpf_hash = cfi_rehash(cfi_bpf_hash);
+			cfi_bpf_subprog_hash = cfi_rehash(cfi_bpf_subprog_hash);
 		}
 
 		ret = cfi_rand_preamble(start_cfi, end_cfi);
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -312,12 +312,13 @@ static void pop_callee_regs(u8 **pprog,
  * in arch/x86/kernel/alternative.c
  */
 
-static void emit_fineibt(u8 **pprog)
+static void emit_fineibt(u8 **pprog, bool is_subprog)
 {
+	u32 hash = is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash;
 	u8 *prog = *pprog;
 
 	EMIT_ENDBR();
-	EMIT3_off32(0x41, 0x81, 0xea, cfi_bpf_hash);	/* subl $hash, %r10d	*/
+	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
 	EMIT2(0x74, 0x07);				/* jz.d8 +7		*/
 	EMIT2(0x0f, 0x0b);				/* ud2			*/
 	EMIT1(0x90);					/* nop			*/
@@ -326,11 +327,12 @@ static void emit_fineibt(u8 **pprog)
 	*pprog = prog;
 }
 
-static void emit_kcfi(u8 **pprog)
+static void emit_kcfi(u8 **pprog, bool is_subprog)
 {
+	u32 hash = is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash;
 	u8 *prog = *pprog;
 
-	EMIT1_off32(0xb8, cfi_bpf_hash);		/* movl $hash, %eax	*/
+	EMIT1_off32(0xb8, hash);			/* movl $hash, %eax	*/
 #ifdef CONFIG_CALL_PADDING
 	EMIT1(0x90);
 	EMIT1(0x90);
@@ -349,17 +351,17 @@ static void emit_kcfi(u8 **pprog)
 	*pprog = prog;
 }
 
-static void emit_cfi(u8 **pprog)
+static void emit_cfi(u8 **pprog, bool is_subprog)
 {
 	u8 *prog = *pprog;
 
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		emit_fineibt(&prog);
+		emit_fineibt(&prog, is_subprog);
 		break;
 
 	case CFI_KCFI:
-		emit_kcfi(&prog);
+		emit_kcfi(&prog, is_subprog);
 		break;
 
 	default:
@@ -381,7 +383,7 @@ static void emit_prologue(u8 **pprog, u3
 {
 	u8 *prog = *pprog;
 
-	emit_cfi(&prog);
+	emit_cfi(&prog, is_subprog);
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */



