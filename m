Return-Path: <linux-arch+bounces-14783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 815A9C5E257
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 17:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C207B3672EA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA25329388;
	Fri, 14 Nov 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az/THQw/"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0232C94A
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133436; cv=none; b=G+IKBBrj64QBFJ2Fv1LiEIv4hrgHfG8lS/SVONJzXhQ6LsRKWY9dtR2Tri7gz4cimaNGcgjH12Ic49F4Xi4Sq4nrn13DT/lN2LQSZ5AN02RDwUJn5/r0cne90XkD2SnNBMl+SLcSupGKZFwZGVOqShYNgFitQlslyh54TtFC/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133436; c=relaxed/simple;
	bh=dq+9vdpT4F4YDpOuYqYMrNvq6Z0Eu8BbCmKisrHSM5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn5VXc7jGUPj7jYFxEhFGYzpZTtLPsmtVu4ArCz0hHr0sGgljvdlnjnLeCYDGCwkG9aGyn2WAC/TUps0OhuJpwR9NtoxKtpn7ZZzRB0546dmIqbR5ZKbf69XgEJR30FrXQKi92EuRLSV4BBebOFhTXAWSPH4EIBoGlCfcPQjUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=az/THQw/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763133433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X87uiojng2a6RCMXxkyxjZHQ7qUm6Xyc1h3s0fKM3s=;
	b=az/THQw/Nef9DVwrFDjDZtykiTD5qR2NqW2UM235/x7W4P8dCyJCBUIj1SOLmrXoMRy6aM
	h5ZhOXXOwqZYZhSJYC31a7UwRPhC/UttDyMpYgXbw2ag/0K1w/9YO33TOZ7lo3HY8dEsr1
	L87X0VCMOHYY2vhJU0BZaUqaqEIyFis=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-2-uC21UoNNia6LI_UqojzA-1; Fri,
 14 Nov 2025 10:17:08 -0500
X-MC-Unique: 2-uC21UoNNia6LI_UqojzA-1
X-Mimecast-MFC-AGG-ID: 2-uC21UoNNia6LI_UqojzA_1763133423
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8653180009D;
	Fri, 14 Nov 2025 15:17:02 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.226.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E4EA180049F;
	Fri, 14 Nov 2025 15:16:48 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush immediately after a switch to kernel CR3
Date: Fri, 14 Nov 2025 16:14:26 +0100
Message-ID: <20251114151428.1064524-9-vschneid@redhat.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Deferring kernel range TLB flushes requires the guarantee that upon
entering the kernel, no stale entry may be accessed. The simplest way to
provide such a guarantee is to issue an unconditional flush upon switching
to the kernel CR3, as this is the pivoting point where such stale entries
may be accessed.

As this is only relevant to NOHZ_FULL, restrict the mechanism to NOHZ_FULL
CPUs.

Note that the COALESCE_TLBI config option is introduced in a later commit,
when the whole feature is implemented.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/entry/calling.h      | 25 ++++++++++++++++++++++---
 arch/x86/kernel/asm-offsets.c |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 0187c0ea2fddb..620203ef04e9f 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -10,6 +10,7 @@
 #include <asm/msr.h>
 #include <asm/nospec-branch.h>
 #include <asm/jump_label.h>
+#include <asm/invpcid.h>

 /*

@@ -171,9 +172,27 @@ For 32-bit we have the following conventions - kernel is built with
	andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
 .endm

-.macro COALESCE_TLBI
+.macro COALESCE_TLBI scratch_reg:req
 #ifdef CONFIG_COALESCE_TLBI
	STATIC_BRANCH_FALSE_LIKELY housekeeping_overridden, .Lend_\@
+	/* No point in doing this for housekeeping CPUs */
+	movslq  PER_CPU_VAR(cpu_number), \scratch_reg
+	bt	\scratch_reg, tick_nohz_full_mask(%rip)
+	jnc	.Lend_tlbi_\@
+
+	ALTERNATIVE "jmp .Lcr4_\@", "", X86_FEATURE_INVPCID
+	movq $(INVPCID_TYPE_ALL_INCL_GLOBAL), \scratch_reg
+	/* descriptor is all zeroes, point at the zero page */
+	invpcid empty_zero_page(%rip), \scratch_reg
+	jmp .Lend_tlbi_\@
+.Lcr4_\@:
+	/* Note: this gives CR4 pinning the finger */
+	movq PER_CPU_VAR(cpu_tlbstate + TLB_STATE_cr4), \scratch_reg
+	xorq $(X86_CR4_PGE), \scratch_reg
+	movq \scratch_reg, %cr4
+	xorq $(X86_CR4_PGE), \scratch_reg
+	movq \scratch_reg, %cr4
+.Lend_tlbi_\@:
	movl     $1, PER_CPU_VAR(kernel_cr3_loaded)
 .Lend_\@:
 #endif // CONFIG_COALESCE_TLBI
@@ -192,7 +211,7 @@ For 32-bit we have the following conventions - kernel is built with
	mov	%cr3, \scratch_reg
	ADJUST_KERNEL_CR3 \scratch_reg
	mov	\scratch_reg, %cr3
-	COALESCE_TLBI
+	COALESCE_TLBI \scratch_reg
 .Lend_\@:
 .endm

@@ -260,7 +279,7 @@ For 32-bit we have the following conventions - kernel is built with

	ADJUST_KERNEL_CR3 \scratch_reg
	movq	\scratch_reg, %cr3
-	COALESCE_TLBI
+	COALESCE_TLBI \scratch_reg

 .Ldone_\@:
 .endm
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 32ba599a51f88..deb92e9c8923d 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -106,6 +106,7 @@ static void __used common(void)

	/* TLB state for the entry code */
	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);
+	OFFSET(TLB_STATE_cr4, tlb_state, cr4);

	/* Layout info for cpu_entry_area */
	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
--
2.51.0


