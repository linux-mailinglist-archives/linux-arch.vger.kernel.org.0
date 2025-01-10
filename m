Return-Path: <linux-arch+bounces-9686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE91A09B4E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9B3A110E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 18:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73FB22333D;
	Fri, 10 Jan 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZ8Jfce9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F221518F
	for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534475; cv=none; b=kO2Pzw8qtvuxT7cczGVvond3zvVB9P9v7hrEjBRBQLcGnL7QGWHhrsZEXUKSrmilEtnA6TU45gqSYTaLeNgk2eurfGuDJOKgwh7DMN5iNeigVAMmRYiZebnSEy3IFlK5vdlZ8qqEnjDwqCSFN5qVsEMhsWDfNhyNiskcmrfhtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534475; c=relaxed/simple;
	bh=/pPC1ygi9PuAIQr3pnrOT1/KCXhFsF8V8SBrs6XZuug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SCSvCB7hlVPiuFCDEicmou01ATge3BQDM5fZj2HhOLzC8We03o+EuDGlrCXgxuWpKdg2R7aWSFvC0ogQaRgKT3q1JELobUafl+C2J0/dNvy5pN5xIwIjS0I8LThx55nIMNohwHDf7rXJoaue8q3+i5aVifeMoZ578u4RyPOADok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZ8Jfce9; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385d7611ad3so1372650f8f.2
        for <linux-arch@vger.kernel.org>; Fri, 10 Jan 2025 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534462; x=1737139262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/j+RB8/lAgzqGTtPca+XTmsHyqC3ld9qGwXYbAsCbQ0=;
        b=ZZ8Jfce99xDwuy8LFvrFwJcu8q4ErOhhVo/kYEVcuoXkPiVBLeaKvvP0bTbRPP7/7O
         GtsUo0cQOV0TtlJUfCjXKyDG5uPqudrHhH6y69EmId5dKrfinbIxibRGL4I4TNOmILib
         GDHjdSZty1RvRYto0gz9xyaH1bYGeOFt+gbHKHkCFsCixoqY0MqoEPhsplq77/+abGy2
         g9GYfhcO9HQfTyDKxIwzBGubAKhB62VteRRNUelDuYO8e1ZLExAYrD4YczF1GmKPJEb8
         01ixMxVi6S6St/6agTCjvS4JhnI/Hz7zeZehzMFITa5eM0m/j5d4eice3M5YVZAVfEix
         yvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534462; x=1737139262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j+RB8/lAgzqGTtPca+XTmsHyqC3ld9qGwXYbAsCbQ0=;
        b=PAH3E4XgcGBYAEbldUlRV1e4BTFCiB7LpJkcCYqz8yefx5RReYoBnq4q7awHFBTjm6
         2jMV0RL+cMZaxXl/lkApXNeZMGJlZqK+TxXQcAZrPzOSyxUlPto8B92Uh752u2+2WXKV
         V1FZ7NNG+qO3vQxJmyYN9ySNodVQgApOtsEczcmbMhCzsoqNAKpD+xbCUEjGqrK1Awo6
         PIhKOGZST8/buqiBA++scR03YwurW6FcpcG3jd6udURezFRu9gMS4N2k+WZpLS9VzidD
         wNymQOWtXrFec3Wh8pzGetCqE5/SALvDkAWajJ4eK5gPAgb3Cx0ycr25PYHL0ow81IuF
         9Dmw==
X-Forwarded-Encrypted: i=1; AJvYcCVHp2USl6bWVaQSWG6l2crGNa9vrz73WoMnHupQBMopM5DpEcWbROXb2g3MoGgYcAg3ORkNAzx1aamZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1M4oRQ+dYhIPg0TOW133TUO86AFyKVxB8ghSEND8KFxhOe4j
	7ug7sZKngH188YZkQHS+St5NA1XBoylJjr8YoMJnadyW9oASRnul/bFwKRdgHFIRxuOvXbc1Tbn
	sZcUBgI11EA==
X-Google-Smtp-Source: AGHT+IEaBJ4kVsH9fdlEpqyA1vEXALZVlXyRkre6Nr4itvNL2JHwYHaMyiaIiF1xr8efeWfazalHNzAFq1Ad7A==
X-Received: from wrbfi1.prod.google.com ([2002:a05:6000:4401:b0:386:333e:ad16])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:470d:b0:385:dedb:a156 with SMTP id ffacd0b85a97d-38a872cfdffmr10312148f8f.6.1736534461506;
 Fri, 10 Jan 2025 10:41:01 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:33 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-7-8419288bc805@google.com>
Subject: [PATCH RFC v2 07/29] mm: asi: Make __get_current_cr3_fast() ASI-aware
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
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="utf-8"

From: Junaid Shahid <junaids@google.com>

When ASI is active, __get_current_cr3_fast() adjusts the returned CR3
value accordingly to reflect the actual ASI CR3.

Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/tlb.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2601beed83aef182d88800c09d70e4c5e95e7ed0..b2a13fdab0c6454c1d9d4e3338801f3402da4191 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -20,6 +20,7 @@
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
+#include <asm/asi.h>
 #include <asm/perf_event.h>
 
 #include "mm_internal.h"
@@ -197,8 +198,8 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
 	return build_cr3(pgd, asid, lam) | CR3_NOFLUSH;
 }
 
-noinstr unsigned long build_cr3_pcid_noinstr(pgd_t *pgd, u16 pcid,
-					     unsigned long lam, bool noflush)
+static __always_inline unsigned long build_cr3_pcid(pgd_t *pgd, u16 pcid,
+						    unsigned long lam, bool noflush)
 {
 	u64 noflush_bit = 0;
 
@@ -210,6 +211,12 @@ noinstr unsigned long build_cr3_pcid_noinstr(pgd_t *pgd, u16 pcid,
 	return __build_cr3(pgd, pcid, lam) | noflush_bit;
 }
 
+noinstr unsigned long build_cr3_pcid_noinstr(pgd_t *pgd, u16 pcid,
+					     unsigned long lam, bool noflush)
+{
+	return build_cr3_pcid(pgd, pcid, lam, noflush);
+}
+
 /*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
@@ -1133,14 +1140,32 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  */
 noinstr unsigned long __get_current_cr3_fast(void)
 {
-	unsigned long cr3 =
-		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-			  this_cpu_read(cpu_tlbstate.loaded_mm_asid),
-			  tlbstate_lam_cr3_mask());
+	unsigned long cr3;
+	pgd_t *pgd;
+	u16 asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	struct asi *asi = asi_get_current();
+	u16 pcid;
+
+	if (asi) {
+		pgd = asi_pgd(asi);
+		pcid = asi_pcid(asi, asid);
+	} else {
+		pgd = this_cpu_read(cpu_tlbstate.loaded_mm)->pgd;
+		pcid = kern_pcid(asid);
+	}
+
+	cr3 = build_cr3_pcid(pgd, pcid, tlbstate_lam_cr3_mask(), false);
 
 	/* For now, be very restrictive about when this can be called. */
 	VM_WARN_ON(in_nmi() || preemptible());
 
+	/*
+	 * Outside of the ASI critical section, an ASI-restricted CR3 is
+	 * unstable because an interrupt (including an inner interrupt, if we're
+	 * already in one) could cause a persistent asi_exit.
+	 */
+	VM_WARN_ON_ONCE(asi && asi_in_critical_section());
+
 	VM_BUG_ON(cr3 != __read_cr3());
 	return cr3;
 }

-- 
2.47.1.613.gc27f4b7a9f-goog


