Return-Path: <linux-arch+bounces-9682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A13A099D7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125FA7A49E2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFE21C9E8;
	Fri, 10 Jan 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQAeyX4Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A6215F5A
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534466; cv=none; b=C8X1T+U9VdyL5GKbn2rEwCViF257IZ1mlQ4JzUbh+MwsGXGZi1lgx7mSFW2lLrdXJSs6B5aYvLZdeFR0WcoszUT24zqa3rvj962ShLDVQRtKyNin4z+yERp7g0WII+uQLJ3EWsw50vIbQiMmVY6mTc+uNHzzzkgILhLg3H2PBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534466; c=relaxed/simple;
	bh=yUJhfygL4zShgEMCarvXajCch8gRGTatWhXnwaWQKgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z7o9nM+y4NfK8/l4KJJGDGdoHlB54UZ2EPEliRvQf0zCXcq/giksk3us8SfeEp+z+a0WB27rYDTk5+CMMFv2b9lF2Q/HhBwp/c8Ag7Uec2n3DhQ+YrnlKRFIt0k22YeOvf3WdDKeaztb4k0MwdMegpK4B1OrvHWqu4LEZN3YZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQAeyX4Y; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so11437265e9.3
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534454; x=1737139254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/DwiwuishkWohq1Selw9AVX00i6WMTVrJEAuBvDTaE=;
        b=GQAeyX4YirKt2qq+bM+3Ddu908qkl3I/FgtJE7Gvv5IKzFedVmYvsNdyqKS1uGbu2Y
         ntaOCS4WEQQZYeOJmi6AYvPXxtWDQ9/8PuE6HwREv1KjWMyNkEBOi7WlsaInMdtxOIo5
         oCZoVUcGEAN7W1qInZIDDMIVOTAx2/n9ZOuLO01+tZjjD3hiQzN13b/UhdzRVLGiXZ2R
         qIKaUB0wBNvlXLMw17DC/8CTZJMXHReri2bWpHSJ8V/j/eFWI9mmiMUujS0IPovty4iG
         7pSRxtiUrwzX4UYOJn6do3frii+w2PhFxewhhht1AbFvi1YmipmILnmcmTuBf8LQ1X6R
         xPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534454; x=1737139254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/DwiwuishkWohq1Selw9AVX00i6WMTVrJEAuBvDTaE=;
        b=m+o/misBDVo6N6jtE8K+muu5ctDLhO3tjAmOfoY4ulcwhcvFKSAbTbdn8ksBGwu9gB
         sL9MwVlK/2AG/Q/EBP4E3p+YpVmnKMrOGGRV/ef7RtIpvmLVMV4rekA1tZXjohzdtNUB
         3MFr50FOsmZMSCKFC/sWFSJ24qEaQUrTdqtLG4BCsR+SxRi3/uYhwFlOImMfk3tmWVWm
         HD0TVK9lboe6PGhkB1Fy4OOpH1POWULYwX6h7M4rpc1xU4oKxNGzJTkEKumfxr3pvh1m
         TiBAKsbjLZqewyteGmZZ3Tw0mj4VrV8WKJRBsHTskAFNuXGND1OPrT1dpkPDX/LpFBWQ
         foDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeKfRmM3jhfpOvb2tZRuLDjpgf8xiWQQyH1BTYfAW2Wp+H3C6WsGvRfdSPq3AZq8bD8Jh/C4QlsY5S@vger.kernel.org
X-Gm-Message-State: AOJu0YzbykH4LICxG4Pw7f9VqlGae+CdenYDgvMb9lWtnNE3vL3M0yOO
	p2ZoCxLYBEN2+2U8+nVPdiZDue7ziqMeAks5o82m8GkdwwLBxFXwB77taq2grVJJIiIl3QIgL3s
	lnOuFWJfWZQ==
X-Google-Smtp-Source: AGHT+IFG2gVbYjLEgd+rVsDr92xsiDXdhg3a2JRtZbNVmnh3EgFoUPLrUSfZq6jOhgEgZFCkNrLAplfHg1IQBQ==
X-Received: from wmqa17.prod.google.com ([2002:a05:600c:3491:b0:434:fa72:f1bf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d81mr55448175e9.30.1736534454514;
 Fri, 10 Jan 2025 10:40:54 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:30 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-4-8419288bc805@google.com>
Subject: [PATCH RFC v2 04/29] mm: asi: Add infrastructure for boot-time enablement
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="utf-8"

Add a boot time parameter to control the newly added X86_FEATURE_ASI.
"asi=on" or "asi=off" can be used in the kernel command line to enable
or disable ASI at boot time. If not specified, ASI enablement depends
on CONFIG_ADDRESS_SPACE_ISOLATION_DEFAULT_ON, which is off by default.
asi_check_boottime_disable() is modeled after
pti_check_boottime_disable().

The boot parameter is currently ignored until ASI is fully functional.

Once we have a set of ASI features checked in that we have actually
tested, we will stop ignoring the flag. But for now let's just add the
infrastructure so we can implement the usage code.

Ignoring checkpatch.pl CONFIG_DESCRIPTION because the _DEFAULT_ON
Kconfig is trivial to explain.

Checkpatch-args: --ignore CONFIG_DESCRIPTION
Co-developed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Junaid Shahid <junaids@google.com>
Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/Kconfig                         |  9 +++++
 arch/x86/include/asm/asi.h               | 19 ++++++++--
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/disabled-features.h |  8 ++++-
 arch/x86/mm/asi.c                        | 61 +++++++++++++++++++++++++++-----
 arch/x86/mm/init.c                       |  4 ++-
 include/asm-generic/asi.h                |  4 +++
 7 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5a50582eb210e9d1309856a737d32b76fa1bfc85..1fcb52cb8cd5084ac3cef04af61b7d1653162bdb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2533,6 +2533,15 @@ config MITIGATION_ADDRESS_SPACE_ISOLATION
 	  there are likely to be unhandled cases, in particular concerning TLB
 	  flushes.
 
+
+config ADDRESS_SPACE_ISOLATION_DEFAULT_ON
+	bool "Enable address space isolation by default"
+	default n
+	depends on MITIGATION_ADDRESS_SPACE_ISOLATION
+	help
+	  If selected, ASI is enabled by default at boot if the asi=on or
+	  asi=off are not specified.
+
 config MITIGATION_RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	select OBJTOOL if HAVE_OBJTOOL
diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 7cc635b6653a3970ba9dbfdc9c828a470e27bd44..b9671ef2dd3278adceed18507fd260e21954d574 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -8,6 +8,7 @@
 
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
+#include <asm/cpufeature.h>
 #include <asm/processor.h>
 
 #ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
@@ -66,6 +67,8 @@
  * the N ASI classes.
  */
 
+#define static_asi_enabled() cpu_feature_enabled(X86_FEATURE_ASI)
+
 /*
  * ASI uses a per-CPU tainting model to track what mitigation actions are
  * required on domain transitions. Taints exist along two dimensions:
@@ -131,6 +134,8 @@ struct asi {
 
 DECLARE_PER_CPU_ALIGNED(struct asi *, curr_asi);
 
+void asi_check_boottime_disable(void);
+
 void asi_init_mm_state(struct mm_struct *mm);
 
 int asi_init_class(enum asi_class_id class_id, struct asi_taint_policy *taint_policy);
@@ -155,7 +160,9 @@ void asi_exit(void);
 /* The target is the domain we'll enter when returning to process context. */
 static __always_inline struct asi *asi_get_target(struct task_struct *p)
 {
-	return p->thread.asi_state.target;
+	return static_asi_enabled()
+	       ? p->thread.asi_state.target
+	       : NULL;
 }
 
 static __always_inline void asi_set_target(struct task_struct *p,
@@ -166,7 +173,9 @@ static __always_inline void asi_set_target(struct task_struct *p,
 
 static __always_inline struct asi *asi_get_current(void)
 {
-	return this_cpu_read(curr_asi);
+	return static_asi_enabled()
+	       ? this_cpu_read(curr_asi)
+	       : NULL;
 }
 
 /* Are we currently in a restricted address space? */
@@ -175,7 +184,11 @@ static __always_inline bool asi_is_restricted(void)
 	return (bool)asi_get_current();
 }
 
-/* If we exit/have exited, can we stay that way until the next asi_enter? */
+/*
+ * If we exit/have exited, can we stay that way until the next asi_enter?
+ *
+ * When ASI is disabled, this returns true.
+ */
 static __always_inline bool asi_is_relaxed(void)
 {
 	return !asi_get_target(current);
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 913fd3a7bac6506141de65f33b9ee61c615c7d7d..d6a808d10c3b8900d190ea01c66fc248863f05e2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -474,6 +474,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_ASI			(21*32+6) /* Kernel Address Space Isolation */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b0595ec77f89dc9b0cefe5e3e64be41..c7964ed4fef8b9441e1c0453da587787d8008d9d 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -50,6 +50,12 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+# define DISABLE_ASI		0
+#else
+# define DISABLE_ASI		(1 << (X86_FEATURE_ASI & 31))
+#endif
+
 #ifdef CONFIG_MITIGATION_RETPOLINE
 # define DISABLE_RETPOLINE	0
 #else
@@ -154,7 +160,7 @@
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
-#define DISABLED_MASK20	0
+#define DISABLED_MASK20	(DISABLE_ASI)
 #define DISABLED_MASK21	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 105cd8b43eaf5c20acc80d4916b761559fb95d74..5baf563a078f5b3a6cd4b9f5e92baaf81b0774c4 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -4,6 +4,7 @@
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 
+#include <linux/init.h>
 #include <asm/asi.h>
 #include <asm/cmdline.h>
 #include <asm/cpufeature.h>
@@ -29,6 +30,9 @@ static inline bool asi_class_id_valid(enum asi_class_id class_id)
 
 static inline bool asi_class_initialized(enum asi_class_id class_id)
 {
+	if (!boot_cpu_has(X86_FEATURE_ASI))
+		return 0;
+
 	if (WARN_ON(!asi_class_id_valid(class_id)))
 		return false;
 
@@ -51,6 +55,9 @@ EXPORT_SYMBOL_GPL(asi_init_class);
 
 void asi_uninit_class(enum asi_class_id class_id)
 {
+	if (!boot_cpu_has(X86_FEATURE_ASI))
+		return;
+
 	if (!asi_class_initialized(class_id))
 		return;
 
@@ -66,10 +73,36 @@ const char *asi_class_name(enum asi_class_id class_id)
 	return asi_class_names[class_id];
 }
 
+void __init asi_check_boottime_disable(void)
+{
+	bool enabled = IS_ENABLED(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION_DEFAULT_ON);
+	char arg[4];
+	int ret;
+
+	ret = cmdline_find_option(boot_command_line, "asi", arg, sizeof(arg));
+	if (ret == 3 && !strncmp(arg, "off", 3)) {
+		enabled = false;
+		pr_info("ASI disabled through kernel command line.\n");
+	} else if (ret == 2 && !strncmp(arg, "on", 2)) {
+		enabled = true;
+		pr_info("Ignoring asi=on param while ASI implementation is incomplete.\n");
+	} else {
+		pr_info("ASI %s by default.\n",
+			enabled ? "enabled" : "disabled");
+	}
+
+	if (enabled)
+		pr_info("ASI enablement ignored due to incomplete implementation.\n");
+}
+
 static void __asi_destroy(struct asi *asi)
 {
-	lockdep_assert_held(&asi->mm->asi_init_lock);
+	WARN_ON_ONCE(asi->ref_count <= 0);
+	if (--(asi->ref_count) > 0)
+		return;
 
+	free_pages((ulong)asi->pgd, PGD_ALLOCATION_ORDER);
+	memset(asi, 0, sizeof(struct asi));
 }
 
 int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_asi)
@@ -79,6 +112,9 @@ int asi_init(struct mm_struct *mm, enum asi_class_id class_id, struct asi **out_
 
 	*out_asi = NULL;
 
+	if (!boot_cpu_has(X86_FEATURE_ASI))
+		return 0;
+
 	if (WARN_ON(!asi_class_initialized(class_id)))
 		return -EINVAL;
 
@@ -122,7 +158,7 @@ void asi_destroy(struct asi *asi)
 {
 	struct mm_struct *mm;
 
-	if (!asi)
+	if (!boot_cpu_has(X86_FEATURE_ASI) || !asi)
 		return;
 
 	if (WARN_ON(!asi_class_initialized(asi->class_id)))
@@ -134,11 +170,7 @@ void asi_destroy(struct asi *asi)
 	 * to block concurrent asi_init calls.
 	 */
 	mutex_lock(&mm->asi_init_lock);
-	WARN_ON_ONCE(asi->ref_count <= 0);
-	if (--(asi->ref_count) == 0) {
-		free_pages((ulong)asi->pgd, PGD_ALLOCATION_ORDER);
-		memset(asi, 0, sizeof(struct asi));
-	}
+	__asi_destroy(asi);
 	mutex_unlock(&mm->asi_init_lock);
 }
 EXPORT_SYMBOL_GPL(asi_destroy);
@@ -255,6 +287,9 @@ static noinstr void __asi_enter(void)
 
 noinstr void asi_enter(struct asi *asi)
 {
+	if (!static_asi_enabled())
+		return;
+
 	VM_WARN_ON_ONCE(!asi);
 
 	/* Should not have an asi_enter() without a prior asi_relax(). */
@@ -269,8 +304,10 @@ EXPORT_SYMBOL_GPL(asi_enter);
 
 noinstr void asi_relax(void)
 {
-	barrier();
-	asi_set_target(current, NULL);
+	if (static_asi_enabled()) {
+		barrier();
+		asi_set_target(current, NULL);
+	}
 }
 EXPORT_SYMBOL_GPL(asi_relax);
 
@@ -279,6 +316,9 @@ noinstr void asi_exit(void)
 	u64 unrestricted_cr3;
 	struct asi *asi;
 
+	if (!static_asi_enabled())
+		return;
+
 	preempt_disable_notrace();
 
 	VM_BUG_ON(this_cpu_read(cpu_tlbstate.loaded_mm) ==
@@ -310,6 +350,9 @@ EXPORT_SYMBOL_GPL(asi_exit);
 
 void asi_init_mm_state(struct mm_struct *mm)
 {
+	if (!boot_cpu_has(X86_FEATURE_ASI))
+		return;
+
 	memset(mm->asi, 0, sizeof(mm->asi));
 	mutex_init(&mm->asi_init_lock);
 }
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index de4227ed5169ff84d0ce80b677caffc475198fa6..ded3a47f2a9c1f554824d4ad19f3b48bce271274 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -28,6 +28,7 @@
 #include <asm/text-patching.h>
 #include <asm/memtype.h>
 #include <asm/paravirt.h>
+#include <asm/asi.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -251,7 +252,7 @@ static void __init probe_page_size_mask(void)
 	__default_kernel_pte_mask = __supported_pte_mask;
 	/* Except when with PTI where the kernel is mostly non-Global: */
 	if (cpu_feature_enabled(X86_FEATURE_PTI) ||
-	    IS_ENABLED(CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION))
+	    cpu_feature_enabled(X86_FEATURE_ASI))
 		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
 
 	/* Enable 1 GB linear kernel mappings if available: */
@@ -754,6 +755,7 @@ void __init init_mem_mapping(void)
 	unsigned long end;
 
 	pti_check_boottime_disable();
+	asi_check_boottime_disable();
 	probe_page_size_mask();
 	setup_pcid();
 
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index 6b84202837605fa57e4a910318c8353b3f816f06..eedc961ee916a9e1da631ca489ea4a7bc9e6089f 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -65,6 +65,10 @@ static inline pgd_t *asi_pgd(struct asi *asi) { return NULL; }
 
 static inline void asi_handle_switch_mm(void) { }
 
+#define static_asi_enabled() false
+
+static inline void asi_check_boottime_disable(void) { }
+
 #endif /* !CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 
 #endif  /* !_ASSEMBLY_ */

-- 
2.47.1.613.gc27f4b7a9f-goog


