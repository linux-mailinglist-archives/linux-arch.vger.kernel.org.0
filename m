Return-Path: <linux-arch+bounces-9707-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4DA09A1C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F181C188DFE0
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA724B230;
	Fri, 10 Jan 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2mFD0sn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6424B225
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534950; cv=none; b=EEQktRFO6mU5AV7LoXlvIeJnYKnI0/RxtcZYIX9JkejhOLlfblidKVLTdOcoRGGbh1hkrIuBAAS++C5/vj9FWVOeDwEKSOlsSiBkdhteZV8HdmiFlV9Nw+/XvVEwk1kJYE1T0085VDbL3ilAvkoE+yXhCxi7jU60IjkEZMrN6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534950; c=relaxed/simple;
	bh=GVYtkqY4mowPCZiA8XVd8DkPsgYd6+NdH6iE4GQP/oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KbluuWhhlse8Zqp0dhXQ4caQYr3+7NpH6oPZS77K7irQgoIDzNd7qpRld/RZ6waYO4y+5sTMEcaEWmawmuBhd9oc/YGTHf5eoJrsuPw23/jNZgdoOeSV6k5YXEDdb7cc4J1n1mZMAZNkaz5w1+mnzekw3TgSAyYq0WoDET7djFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2mFD0sn; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so2487358a12.3
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534946; x=1737139746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPVLK2dGaKuBzLzuN4/iPTz64M+48MZ0VyD4n5dtrVo=;
        b=W2mFD0snKzkCfacyYU7uCeX8o3k/UbU6bd/PGs3USySyTlVADACAMHHQkzrLNvrdWm
         oDkgIF/FeUU5KXP5XqOxzPu8zs89YlV5nkGgEcnQY19TtTFkTNiqSNKsCKCTmaovBBT5
         o1QtRNIrPgqr1dEGNZMMPA5Rc547RMARcsbmNoFGoKgWInmqDQkgLmWKpmgl29+rLoIC
         f/uT7za8HZupFTKbQYW4CR8hayX21Uz79hHDMy2NFgDHor+VX5ql9gxYjh4+ICcxuxNR
         Hp5QJctMETZppG0XYfhGGnOieaLFOoY+KyciNcew4vCDSjVlPXGQ4Io0/ruWij7he62p
         ui9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534946; x=1737139746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPVLK2dGaKuBzLzuN4/iPTz64M+48MZ0VyD4n5dtrVo=;
        b=pSz7O01CvlRI38AiljW7zJtCLWnKkq3sdwqKgG0k/R/Q3un+sUS8Anzybsf6lzjYOk
         pZhL8AJekhVs48PeGbZWXmv/PPChjxRzEYOu61agXoD3NvxIjIKqnRD5CkaaMvHO3Dxi
         9Uli1QKimvkClgzU+coX5CX6jCFW78XrOcd/++XTM/r0gOJkJKDQIPU8PTgN6o+Si9lN
         KHc2hYuTSpTNTJLbGh/TZIITrIhINZ3P6/EqlRTJ/Crn7uCuuuCFPh2zechAQnBdh/mo
         Tnm4eDQcHBTLl3rIRFDdiWwLHwzvnP2yyRZi7mkouDCpjnilfOK1+zzJlmkGZn4gUUpK
         kNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSotI0pf0rHZDuhufrsZNCtlMcDPTRc9PO3YqIiw6waKeXnwfHD11oDpkJmF2np9npwAiWXVfjdfp5@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnILkYEDA9gV8njx3ADuBu5t33nEdQeHWd6dIBVbb7Iufwk4z
	vcViTS/T6fFAtBJiGugtBPFIVbyjwxSkz+munWiCokahnhfvGnV5YYhyD/A109vIMchbgYLsj9Y
	QgeQixze5YQ==
X-Google-Smtp-Source: AGHT+IGa4COP7j9J4GokCTwr7XdO0ZTV5zuQPMzgfz+JYaXuU8H1oEoG9KOP7c/HjvN6cC1FzOnvXoWDhc/niQ==
X-Received: from wmbbd12.prod.google.com ([2002:a05:600c:1f0c:b0:434:fd41:173c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:25a:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-436ee0a061emr59243545e9.11.1736534495189;
 Fri, 10 Jan 2025 10:41:35 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:48 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-22-8419288bc805@google.com>
Subject: [PATCH RFC v2 22/29] mm: asi: exit ASI before accessing CR3 from C
 code where appropriate
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
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="utf-8"

Because asi_exit()s can be triggered by NMIs, CR3 is unstable when in
the ASI restricted address space. (Exception: code in the ASI critical
section can treat it as stable, because if an asi_exit() occurs during
an exception it will be undone before the critical section resumes).

Code that accesses CR3 needs to become aware of this. Most importantly:
if code reads CR3 and then writes a derived value back, if concurrent
asi_exit() occurred in between then the address space switch would be
undone, which would totally break ASI.

So, make sure that an asi_exit() is performed before accessing CR3.
Exceptions are made for cases that need to access the current CR3 value,
restricted or not, without exiting ASI.

(An alternative approach would be to enter an ASI critical section when
a stable CR3 is needed. This would be worth exploring if the ASI exits
introduced by this patch turned out to cause performance issues).

Add calls to asi_exit() to __native_read_cr3() and native_write_cr3(),
and introduce 'raw' variants that do not perform an ASI exit. Introduce
similar variants for wrappers: __read_cr3(), read_cr3_pa(), and
write_cr3(). A forward declaration of asi_exit(), because the one in
asm-generic/asi.h is only declared when !CONFIG_ADDRESS_SPACE_ISOLATION,
and arch/x86/asm/asi.h cannot be included either as it would cause a
circular dependency.

The 'raw' variants are used in the following cases:
- In __show_regs() where the actual values of registers are dumped for
  debugging.
- In dump_pagetable() and show_fault_oops() where the active page tables
  during a page fault are dumped for debugging.
- In switch_mm_verify_cr3() and cr3_matches_current_mm() where the
  actual value of CR3 is needed for a debug check, and the code
  explicitly checks for ASI-restricted CR3.
- In exc_page_fault() for ASI faults. The code is ASI-aware and
  explicitly performs an ASI exit before reading CR3.
- In load_new_mm_cr3() where a new CR3 is loaded during context
  switching. At this point, it is guaranteed that ASI already exited.
  Calling asi_exit() at that point, where loaded_mm ==
  LOADED_MM_SWITCHING, will cause VM_BUG_ON in asi_exit() to fire
  mistakenly even though loaded_mm is never accessed.
- In __get_current_cr3_fast(), as it is called from an ASI critical
  section and the value is only used for debug checking.
  In nested_vmx_check_vmentry_hw(), do an explicit asi_exit() before
  calling __get_current_cr3_fast(), since in that case we are not in a
  critical section and do need a stable CR3 value.
- In __asi_enter() and asi_exit() for obvious reasons.

- In vmx_set_constant_host_state() when CR3 is initialized in the VMCS
  with the most likely value. Preemption is enabled, so once ASI
  supports context switching exiting ASI will not be reliable as
  rescheduling may cause re-entering ASI. It doesn't matter if the wrong
  value of CR3 is used in this context, before entering the guest, ASI
  is either explicitly entered or exited, and CR3 is updated again in
  the VMCS if needed.
- In efi_5level_switch(), as it is called from startup_64_mixed_mode()
  during boot before ASI can be entered. startup_64_mixed_mode() is
  under arch/x86/boot/compressed/* and it cannot call asi_exit() anyway
  (see below).

Finally, code in arch/x86/boot/compressed/ident_map_64.c and
arch/x86/boot/compressed/pgtable_64.c extensively accesses CR3 during
boot. This code under arch/x86/boot/compressed/* cannot call asi_exit()
due to restriction on its compilation (it cannot use functions defined
in .c files outside the directory).

Instead of changing all CR3 accesses to use 'raw' variants, undefine
CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION in these files. This will make
the asi_exit() calls in CR3 helpers use the noop variant defined in
include/asm-generic/asi.h. This is fine because the code is executed
early in boot where asi_exit() would be noop anyway.

With this change, the number of existing *_cr3() calls are 44, and the
number of *_cr3_raw() are 22. The choice was made to make the existing
functions exit ASI by default and adding new variants that do not exit
ASI, because most call sites that use the new *_cr3_raw() variants are
either ASI-aware code or debugging code.

On the contrary, code that uses the existing variants is usually in
important code paths (e.g. TLB flushes) and is ignorant of ASI. Hence,
new code is most likely to be correct and less risky by using the
variants that exit ASI by default.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/Kconfig                        |  2 +-
 arch/x86/boot/compressed/ident_map_64.c | 10 ++++++++
 arch/x86/boot/compressed/pgtable_64.c   | 11 +++++++++
 arch/x86/include/asm/processor.h        |  5 ++++
 arch/x86/include/asm/special_insns.h    | 41 +++++++++++++++++++++++++++++++--
 arch/x86/kernel/process_32.c            |  2 +-
 arch/x86/kernel/process_64.c            |  2 +-
 arch/x86/kvm/vmx/nested.c               |  6 +++++
 arch/x86/kvm/vmx/vmx.c                  |  8 ++++++-
 arch/x86/mm/asi.c                       |  4 ++--
 arch/x86/mm/fault.c                     |  8 +++----
 arch/x86/mm/tlb.c                       | 16 +++++++++----
 arch/x86/virt/svm/sev.c                 |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  2 +-
 include/asm-generic/asi.h               |  1 +
 15 files changed, 101 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1fcb52cb8cd5084ac3cef04af61b7d1653162bdb..ae31f36ce23d7c29d1e90b726c5a2e6ea5a63c8d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2531,7 +2531,7 @@ config MITIGATION_ADDRESS_SPACE_ISOLATION
 	  The !PARAVIRT dependency is only because of lack of testing; in theory
 	  the code is written to work under paravirtualization. In practice
 	  there are likely to be unhandled cases, in particular concerning TLB
-	  flushes.
+	  flushes and CR3 manipulation.
 
 
 config ADDRESS_SPACE_ISOLATION_DEFAULT_ON
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index dfb9c2deb77cfc4e9986976bf2fd1652666f8f15..957b6f818aec361191432b420b61ba6ae017cf6c 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -11,6 +11,16 @@
 /* No MITIGATION_PAGE_TABLE_ISOLATION support needed either: */
 #undef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
+/*
+ * CR3 access helpers (e.g. write_cr3()) will call asi_exit() to exit the
+ * restricted address space first. We cannot call the version defined in
+ * arch/x86/mm/asi.c here, so make sure we always call the noop version in
+ * asm-generic/asi.h. It does not matter because early during boot asi_exit()
+ * would be a noop anyway. The alternative is spamming the code with *_raw()
+ * variants of the CR3 helpers.
+ */
+#undef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+
 #include "error.h"
 #include "misc.h"
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f67af01c50a20bfe00a32138dc771ee88c..034ad7101126c19864cfacc7c363fd31fedecd2b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,4 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+
+/*
+ * CR3 access helpers (e.g. write_cr3()) will call asi_exit() to exit the
+ * restricted address space first. We cannot call the version defined in
+ * arch/x86/mm/asi.c here, so make sure we always call the noop version in
+ * asm-generic/asi.h. It does not matter because early during boot asi_exit()
+ * would be a noop anyway. The alternative is spamming the code with *_raw()
+ * variants of the CR3 helpers.
+ */
+#undef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+
 #include "misc.h"
 #include <asm/bootparam.h>
 #include <asm/e820/types.h>
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a32a53405f45e4c0473fe081e216029cf5bd0cdd..9375a7f877d60e8f556dedefbe74593c1a5a6e10 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -226,6 +226,11 @@ static __always_inline unsigned long read_cr3_pa(void)
 	return __read_cr3() & CR3_ADDR_MASK;
 }
 
+static __always_inline unsigned long read_cr3_pa_raw(void)
+{
+	return __read_cr3_raw() & CR3_ADDR_MASK;
+}
+
 static inline unsigned long native_read_cr3_pa(void)
 {
 	return __native_read_cr3() & CR3_ADDR_MASK;
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 6e103358966f6f1333aa07be97aec5f8af794120..1c886b3f04a56893b7408466a2c94d23f5d11857 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -5,6 +5,7 @@
 #ifdef __KERNEL__
 #include <asm/nops.h>
 #include <asm/processor-flags.h>
+#include <asm-generic/asi.h>
 
 #include <linux/errno.h>
 #include <linux/irqflags.h>
@@ -42,18 +43,32 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static __always_inline unsigned long __native_read_cr3(void)
+void asi_exit(void);
+
+static __always_inline unsigned long __native_read_cr3_raw(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static __always_inline void native_write_cr3(unsigned long val)
+static __always_inline unsigned long __native_read_cr3(void)
+{
+	asi_exit();
+	return __native_read_cr3_raw();
+}
+
+static __always_inline void native_write_cr3_raw(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
 
+static __always_inline void native_write_cr3(unsigned long val)
+{
+	asi_exit();
+	native_write_cr3_raw(val);
+}
+
 static inline unsigned long native_read_cr4(void)
 {
 	unsigned long val;
@@ -152,17 +167,39 @@ static __always_inline void write_cr2(unsigned long x)
 /*
  * Careful!  CR3 contains more than just an address.  You probably want
  * read_cr3_pa() instead.
+ *
+ * The implementation interacts with ASI to ensure that the returned value is
+ * stable as long as preemption is disabled.
  */
 static __always_inline unsigned long __read_cr3(void)
 {
 	return __native_read_cr3();
 }
 
+/*
+ * The return value of this is unstable under ASI, even with preemption off.
+ * Call __read_cr3 instead unless you have a good reason not to.
+ */
+static __always_inline unsigned long __read_cr3_raw(void)
+{
+	return __native_read_cr3_raw();
+}
+
+/* This interacts with ASI like __read_cr3. */
 static __always_inline void write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
 
+/*
+ * Like __read_cr3_raw, this doesn't interact with ASI. It's very unlikely that
+ * this should be called from outside ASI-specific code.
+ */
+static __always_inline void write_cr3_raw(unsigned long x)
+{
+	native_write_cr3_raw(x);
+}
+
 static inline void __write_cr4(unsigned long x)
 {
 	native_write_cr4(x);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0917c7f25720be91372bacddb1a3032323b8996f..14828a867b713a50297953c5a0ccfd03d83debc0 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -79,7 +79,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
-	cr3 = __read_cr3();
+	cr3 = __read_cr3_raw();
 	cr4 = __read_cr4();
 	printk("%sCR0: %08lx CR2: %08lx CR3: %08lx CR4: %08lx\n",
 		log_lvl, cr0, cr2, cr3, cr4);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 226472332a70dd02902f81c21207d770e698aeed..ca135731b54b7f5f1123c2b8b27afdca7b868bcc 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -113,7 +113,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
-	cr3 = __read_cr3();
+	cr3 = __read_cr3_raw();
 	cr4 = __read_cr4();
 
 	printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 931a7361c30f2da28073eb832efce0b378e3b325..7eb033dabe4a606947c4d7e5b96be2e42d8f2478 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3214,6 +3214,12 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 	 */
 	vmcs_writel(GUEST_RFLAGS, 0);
 
+	/*
+	 * Stabilize CR3 to ensure the VM Exit returns to the correct address
+	 * space. This is costly, we wouldn't do this in hot-path code.
+	 */
+	asi_exit();
+
 	cr3 = __get_current_cr3_fast();
 	if (unlikely(cr3 != vmx->loaded_vmcs->host_state.cr3)) {
 		vmcs_writel(HOST_CR3, cr3);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 181d230b1c057fed33f7b29b7b0e378dbdfeb174..0e90463f1f2183b8d716f85d5c8a8af8958fef0b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4323,8 +4323,14 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	/*
 	 * Save the most likely value for this task's CR3 in the VMCS.
 	 * We can't use __get_current_cr3_fast() because we're not atomic.
+	 *
+	 * Use __read_cr3_raw() to avoid exiting ASI if we are in the restrict
+	 * address space. Preemption is enabled, so rescheduling could make us
+	 * re-enter ASI anyway. It's okay to avoid exiting ASI here because
+	 * vmx_vcpu_enter_exit() and nested_vmx_check_vmentry_hw() will
+	 * explicitly enter or exit ASI and update CR3 in the VMCS if needed.
 	 */
-	cr3 = __read_cr3();
+	cr3 = __read_cr3_raw();
 	vmcs_writel(HOST_CR3, cr3);		/* 22.2.3  FIXME: shadow tables */
 	vmx->loaded_vmcs->host_state.cr3 = cr3;
 
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index bc2cf0475a0e7344a66d81453f55034b2fc77eef..a9f9bfbf85eb47d16ef8d0bfbc7713f07052d3ed 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -488,7 +488,7 @@ noinstr void __asi_enter(void)
 
 	pcid = asi_pcid(target, this_cpu_read(cpu_tlbstate.loaded_mm_asid));
 	asi_cr3 = build_cr3_pcid_noinstr(target->pgd, pcid, tlbstate_lam_cr3_mask(), false);
-	write_cr3(asi_cr3);
+	write_cr3_raw(asi_cr3);
 
 	maybe_flush_data(target);
 	/*
@@ -559,7 +559,7 @@ noinstr void asi_exit(void)
 
 		/* Tainting first makes reentrancy easier to reason about.  */
 		this_cpu_or(asi_taints, ASI_TAINT_KERNEL_DATA);
-		write_cr3(unrestricted_cr3);
+		write_cr3_raw(unrestricted_cr3);
 		/*
 		 * Must not update curr_asi until after CR3 write, otherwise a
 		 * re-entrant call might not enter this branch. (This means we
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ee8f5417174e2956391d538f41e2475553ca4972..ca48e4f5a27be30ff93d1c3d194aad23d99ae43c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -295,7 +295,7 @@ static bool low_pfn(unsigned long pfn)
 
 static void dump_pagetable(unsigned long address)
 {
-	pgd_t *base = __va(read_cr3_pa());
+	pgd_t *base = __va(read_cr3_pa_raw());
 	pgd_t *pgd = &base[pgd_index(address)];
 	p4d_t *p4d;
 	pud_t *pud;
@@ -351,7 +351,7 @@ static int bad_address(void *p)
 
 static void dump_pagetable(unsigned long address)
 {
-	pgd_t *base = __va(read_cr3_pa());
+	pgd_t *base = __va(read_cr3_pa_raw());
 	pgd_t *pgd = base + pgd_index(address);
 	p4d_t *p4d;
 	pud_t *pud;
@@ -519,7 +519,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		pgd_t *pgd;
 		pte_t *pte;
 
-		pgd = __va(read_cr3_pa());
+		pgd = __va(read_cr3_pa_raw());
 		pgd += pgd_index(address);
 
 		pte = lookup_address_in_pgd_attr(pgd, address, &level, &nx, &rw);
@@ -1578,7 +1578,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 		 * be losing some stats here. However for now this keeps ASI
 		 * page faults nice and fast.
 		 */
-		pgd = (pgd_t *)__va(read_cr3_pa()) + pgd_index(address);
+		pgd = (pgd_t *)__va(read_cr3_pa_raw()) + pgd_index(address);
 		if (!user_mode(regs) && kernel_access_ok(error_code, address, pgd)) {
 			warn_if_bad_asi_pf(error_code, address);
 			return;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 07b1657bee8e4cf17452ea57c838823e76f482c0..0c9f477a44a4da971cb7744d01d9101900ead1a5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -331,8 +331,14 @@ static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, unsigned long lam,
 	 * Caution: many callers of this function expect
 	 * that load_cr3() is serializing and orders TLB
 	 * fills with respect to the mm_cpumask writes.
+	 *
+	 * The context switching code will explicitly exit ASI when needed, do
+	 * not use write_cr3() as it has an implicit ASI exit. Calling
+	 * asi_exit() here, where loaded_mm == LOADED_MM_SWITCHING, will cause
+	 * the VM_BUG_ON() in asi_exit() to fire mistakenly even though
+	 * loaded_mm is never accessed.
 	 */
-	write_cr3(new_mm_cr3);
+	write_cr3_raw(new_mm_cr3);
 }
 
 void leave_mm(void)
@@ -559,11 +565,11 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	 * without going through leave_mm() / switch_mm_irqs_off() or that
 	 * does something like write_cr3(read_cr3_pa()).
 	 *
-	 * Only do this check if CONFIG_DEBUG_VM=y because __read_cr3()
+	 * Only do this check if CONFIG_DEBUG_VM=y because __read_cr3_raw()
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(prev->pgd, prev_asid,
+	if (WARN_ON_ONCE(__read_cr3_raw() != build_cr3(prev->pgd, prev_asid,
 						   tlbstate_lam_cr3_mask()))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
@@ -1173,7 +1179,7 @@ noinstr unsigned long __get_current_cr3_fast(void)
 	 */
 	VM_WARN_ON_ONCE(asi && asi_in_critical_section());
 
-	VM_BUG_ON(cr3 != __read_cr3());
+	VM_BUG_ON(cr3 != __read_cr3_raw());
 	return cr3;
 }
 EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
@@ -1373,7 +1379,7 @@ static inline bool cr3_matches_current_mm(void)
 	 * find a current ASI domain.
 	 */
 	barrier();
-	pgd_cr3 = __va(read_cr3_pa());
+	pgd_cr3 = __va(read_cr3_pa_raw());
 	return pgd_cr3 == current->mm->pgd || pgd_cr3 == pgd_asi;
 }
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 9a6a943d8e410c0289200adb9deafe8e45d33a4b..63d391395a5c7f4ddec28116814ccd6c52bbb428 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -379,7 +379,7 @@ void snp_dump_hva_rmpentry(unsigned long hva)
 	pgd_t *pgd;
 	pte_t *pte;
 
-	pgd = __va(read_cr3_pa());
+	pgd = __va(read_cr3_pa_raw());
 	pgd += pgd_index(hva);
 	pte = lookup_address_in_pgd(pgd, hva, &level);
 
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 77359e802181fd82b6a624cf74183e6a318cec9b..3b97a5aea983a109fbdc6d23a219e4a04024c512 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -66,7 +66,7 @@ void efi_5level_switch(void)
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
-	u64 *cr3 = (u64 *)__native_read_cr3();
+	u64 *cr3 = (u64 *)__native_read_cr3_raw();
 	u64 *new_cr3;
 
 	if (!la57_toggle || !need_toggle)
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index 7867b8c23449058a1dd06308ab5351e0d210a489..4f033d3ef5929707fd280f74fc800193e45143c1 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -71,6 +71,7 @@ static inline pgd_t *asi_pgd(struct asi *asi) { return NULL; }
 
 static inline void asi_handle_switch_mm(void) { }
 
+struct thread_struct;
 static inline void asi_init_thread_state(struct thread_struct *thread) { }
 
 static inline void asi_intr_enter(void) { }

-- 
2.47.1.613.gc27f4b7a9f-goog


