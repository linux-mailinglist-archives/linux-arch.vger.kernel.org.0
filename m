Return-Path: <linux-arch+bounces-9770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1771A10F18
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19C01652DE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5871FF1BE;
	Tue, 14 Jan 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHSnlobI"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1051F9F52
	for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2025 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877712; cv=none; b=eWMD1mVdOVNz2ePtKnhT3PJLKI4YBQJU5IuAYlbXZvvS/S4leUf2VsL1Qc+0XOlvC4o7Qt2ZgfHJ2Eu0IpBrb5HDdRRnLRaY8HilzheE0Pgp2VbfIMG+9z8g0hGQIIk3/pYMKwrsOD+ujK2SBhMSu3byKz6cfjQ/d9OEo+ag+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877712; c=relaxed/simple;
	bh=ryUhge51tQnnrF0vva7tR3VdZBz7v56dDSBYXb8+9Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUlTCWI8dBSjvWC8q4wR36p4xMK4hPqP8Vbiyk5dsJeNGOidsc+OrqNiVrEt86G/W5kFyroE+tJVjJJUvJI/gsIViaTu8v886b4W6+xFDpTvmdqY4LWa+IGj43Ix4HN5n6xvZmpPttS0LuPFfVvZKaFC16TivOWAWHosuHkZoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHSnlobI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8MD/yxknvCsMYBCjJmdeKziBGiIOE307eysnVgCl2M=;
	b=bHSnlobIfJdvrPfu4xbGvjdBR0XpRqEe0coeQnGSW22hNrFzljTf6zKB/tFTa3hfUre7+3
	Z4b8OnWyXY8C66RmVPbtAsP9TNRwrLCvadtpfAk4MXvMyousWatQgqDpMIdp0KuZgZng//
	MLhQh2pdEzUar4J3h+iminhelNwmmGY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-yr-DHzXkMTap-bgFsYDaSw-1; Tue,
 14 Jan 2025 13:01:44 -0500
X-MC-Unique: yr-DHzXkMTap-bgFsYDaSw-1
X-Mimecast-MFC-AGG-ID: yr-DHzXkMTap-bgFsYDaSw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A8ED1A445CE;
	Tue, 14 Jan 2025 18:01:23 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.55])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8F64195608A;
	Tue, 14 Jan 2025 18:00:56 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v4 20/30] objtool: Add noinstr validation for static branches/calls
Date: Tue, 14 Jan 2025 18:51:33 +0100
Message-ID: <20250114175143.81438-21-vschneid@redhat.com>
In-Reply-To: <20250114175143.81438-1-vschneid@redhat.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Josh Poimboeuf <jpoimboe@kernel.org>

Warn about static branches/calls in noinstr regions, unless the
corresponding key is RO-after-init or has been manually whitelisted with
DEFINE_STATIC_KEY_*_NOINSTR(().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
[Added NULL check for insn_call_dest() return value]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/jump_label.h              | 17 +++--
 include/linux/objtool.h                 |  7 ++
 include/linux/static_call.h             |  3 +
 tools/objtool/Documentation/objtool.txt | 34 +++++++++
 tools/objtool/check.c                   | 92 ++++++++++++++++++++++---
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/elf.h     |  1 +
 tools/objtool/include/objtool/special.h |  1 +
 tools/objtool/special.c                 | 18 ++++-
 9 files changed, 156 insertions(+), 18 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 88bb6e32fdcbc..dc8a82a62c109 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -75,6 +75,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/objtool.h>
 
 extern bool static_key_initialized;
 
@@ -373,8 +374,9 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_TRUE(name)	\
 	struct static_key_true name = STATIC_KEY_TRUE_INIT
 
-#define DEFINE_STATIC_KEY_TRUE_RO(name)	\
-	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
+#define DEFINE_STATIC_KEY_TRUE_RO(name)						\
+	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT;	\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DECLARE_STATIC_KEY_TRUE(name)	\
 	extern struct static_key_true name
@@ -382,8 +384,9 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
-#define DEFINE_STATIC_KEY_FALSE_RO(name)	\
-	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
+#define DEFINE_STATIC_KEY_FALSE_RO(name)					\
+	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;	\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 /*
  * The _NOINSTR variants are used to tell objtool the static key is allowed to
@@ -397,10 +400,12 @@ struct static_key_false {
  * definition with the rationale.
  */
 #define DEFINE_STATIC_KEY_TRUE_NOINSTR(name)					\
-	DEFINE_STATIC_KEY_TRUE(name)
+	DEFINE_STATIC_KEY_TRUE(name);						\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DEFINE_STATIC_KEY_FALSE_NOINSTR(name)					\
-	DEFINE_STATIC_KEY_FALSE(name)
+	DEFINE_STATIC_KEY_FALSE(name);						\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DECLARE_STATIC_KEY_FALSE(name)	\
 	extern struct static_key_false name
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index b3b8d3dab52d5..1a7389f273063 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -34,6 +34,12 @@
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define __ANNOTATE_NOINSTR_ALLOWED(key) \
+	static void __used __section(".discard.noinstr_allowed") \
+		*__annotate_noinstr_allowed_##key = &key
+
+#define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
+
 /*
  * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
  * for the case where a function is intentionally missing frame pointer setup,
@@ -157,6 +163,7 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
+#define ANNOTATE_NOINSTR_ALLOWED(key)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index ea6ca57e2a829..0d4b16d348501 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -133,6 +133,7 @@
 
 #include <linux/types.h>
 #include <linux/cpu.h>
+#include <linux/objtool.h>
 #include <linux/static_call_types.h>
 
 #ifdef CONFIG_HAVE_STATIC_CALL
@@ -198,6 +199,7 @@ extern long __static_call_return0(void);
 		.func = _func,						\
 		.type = 1,						\
 	};								\
+	ANNOTATE_NOINSTR_ALLOWED(STATIC_CALL_TRAMP(name));		\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
@@ -214,6 +216,7 @@ extern long __static_call_return0(void);
 		.func = NULL,						\
 		.type = 1,						\
 	};								\
+	ANNOTATE_NOINSTR_ALLOWED(STATIC_CALL_TRAMP(name));		\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c3ee959b63c7..922d3b41541d0 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -447,6 +447,40 @@ the objtool maintainers.
    names and does not use module_init() / module_exit() macros to create
    them.
 
+13. file.o: warning: func()+0x2a: key: non-RO static key usage in noinstr code
+    file.o: warning: func()+0x2a: key: non-RO static call usage in noinstr code
+
+  This means that noinstr function func() uses a static key or
+  static call named 'key' which can be modified at runtime.  This is
+  discouraged because it prevents code patching IPIs from being
+  deferred.
+
+  You have the following options:
+
+  1) Check whether the static key/call in question is only modified
+     during init.  If so, define it as read-only-after-init with
+     DEFINE_STATIC_KEY_*_RO() or DEFINE_STATIC_CALL_RO().
+
+  2) Avoid the runtime patching.  For static keys this can be done by
+     using static_key_enabled() or by getting rid of the static key
+     altogether if performance is not a concern.
+
+     For static calls, something like the following could be done:
+
+       target = static_call_query(foo);
+       if (target == func1)
+	       func1();
+	else if (target == func2)
+		func2();
+	...
+
+  3) Silence the warning by defining the static key/call with
+     DEFINE_STATIC_*_NOINSTR().  This decision should not
+     be taken lightly as it may result in code patching IPIs getting
+     sent to isolated NOHZ_FULL CPUs running in pure userspace.  A
+     comment should be added above the definition explaining the
+     rationale for the decision.
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6aa9259fc9940..24219538c1587 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1068,6 +1068,45 @@ static int create_direct_call_sections(struct objtool_file *file)
 	return 0;
 }
 
+static int read_noinstr_allowed(struct objtool_file *file)
+{
+	struct section *rsec;
+	struct symbol *sym;
+	struct reloc *reloc;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.noinstr_allowed");
+	if (!rsec)
+		return 0;
+
+	for_each_reloc(rsec, reloc) {
+		switch (reloc->sym->type) {
+		case STT_OBJECT:
+		case STT_FUNC:
+			sym = reloc->sym;
+			break;
+
+		case STT_SECTION:
+			sym = find_symbol_by_offset(reloc->sym->sec,
+						    reloc_addend(reloc));
+			if (!sym) {
+				WARN_FUNC("can't find static key/call symbol",
+					  reloc->sym->sec, reloc_addend(reloc));
+				return -1;
+			}
+			break;
+
+		default:
+			WARN("unexpected relocation symbol type in %s: %d",
+			     rsec->name, reloc->sym->type);
+			return -1;
+		}
+
+		sym->noinstr_allowed = 1;
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1955,6 +1994,8 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	orig_insn->key = special_alt->key;
+
 	if (opts.hack_jump_label && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
@@ -2731,6 +2772,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_noinstr_allowed(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -3494,9 +3539,9 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	return file->pv_ops[idx].clean;
 }
 
-static inline bool noinstr_call_dest(struct objtool_file *file,
-				     struct instruction *insn,
-				     struct symbol *func)
+static inline bool noinstr_call_allowed(struct objtool_file *file,
+					struct instruction *insn,
+					struct symbol *func)
 {
 	/*
 	 * We can't deal with indirect function calls at present;
@@ -3516,10 +3561,10 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 		return true;
 
 	/*
-	 * If the symbol is a static_call trampoline, we can't tell.
+	 * Only DEFINE_STATIC_CALL_*_RO allowed.
 	 */
 	if (func->static_call_tramp)
-		return true;
+		return func->noinstr_allowed;
 
 	/*
 	 * The __ubsan_handle_*() calls are like WARN(), they only happen when
@@ -3532,14 +3577,29 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 	return false;
 }
 
+static char *static_call_name(struct symbol *func)
+{
+	return func->name + strlen("__SCT__");
+}
+
 static int validate_call(struct objtool_file *file,
 			 struct instruction *insn,
 			 struct insn_state *state)
 {
-	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
-		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(file, insn));
-		return 1;
+	if (state->noinstr && state->instr <= 0) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (dest && dest->static_call_tramp) {
+			if (!dest->noinstr_allowed) {
+				WARN_INSN(insn, "%s: non-RO static call usage in noinstr",
+					  static_call_name(dest));
+			}
+
+		} else if (dest && !noinstr_call_allowed(file, insn, dest)) {
+			WARN_INSN(insn, "call to %s() leaves .noinstr.text section",
+				  call_dest_name(file, insn));
+			return 1;
+		}
 	}
 
 	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
@@ -3604,6 +3664,17 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
+static int validate_static_key(struct instruction *insn, struct insn_state *state)
+{
+	if (state->noinstr && state->instr <= 0 && !insn->key->noinstr_allowed) {
+		WARN_INSN(insn, "%s: non-RO static key usage in noinstr",
+			  insn->key->name);
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct instruction *next_insn_to_validate(struct objtool_file *file,
 						 struct instruction *insn)
 {
@@ -3765,6 +3836,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
+		if (insn->key)
+			validate_static_key(insn, &state);
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965a..c0da7246eac7b 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -77,6 +77,7 @@ struct instruction {
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
+	struct symbol *key;
 };
 
 static inline struct symbol *insn_func(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d7e815c2fd156..0cb79931262bb 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -69,6 +69,7 @@ struct symbol {
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
+	u8 noinstr_allowed   : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 86d4af9c5aa9d..ce4759358ec48 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -20,6 +20,7 @@ struct special_alt {
 	bool skip_alt;
 	bool jump_or_nop;
 	u8 key_addend;
+	struct symbol *key;
 
 	struct section *orig_sec;
 	unsigned long orig_off;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 097a69db82a0e..982d5cb55e1bb 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -119,14 +119,26 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 
 	if (entry->key) {
 		struct reloc *key_reloc;
+		struct symbol *key;
+		s64 key_addend;
 
 		key_reloc = find_reloc_by_dest(elf, sec, offset + entry->key);
 		if (!key_reloc) {
-			WARN_FUNC("can't find key reloc",
-				  sec, offset + entry->key);
+			WARN_FUNC("can't find key reloc", sec, offset + entry->key);
 			return -1;
 		}
-		alt->key_addend = reloc_addend(key_reloc);
+
+		key = key_reloc->sym;
+		key_addend = reloc_addend(key_reloc);
+
+		if (key->type == STT_SECTION)
+			key = find_symbol_by_offset(key->sec, key_addend & ~3);
+
+		/* embedded keys not supported */
+		if (key) {
+			alt->key = key;
+			alt->key_addend = key_addend;
+		}
 	}
 
 	return 0;
-- 
2.43.0


