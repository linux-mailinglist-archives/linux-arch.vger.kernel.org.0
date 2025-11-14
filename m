Return-Path: <linux-arch+bounces-14785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF4C5E13C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 17:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7072D3A1E01
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39B320CAE;
	Fri, 14 Nov 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iirRmPEn"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7A336EFB
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133464; cv=none; b=rYzEA3uYHHu8GImEpGfiu6MpaEZ3McnFZ3CwJGCCoei3uBudyfYNnqYQIURJa98Xrik8cZP7dBMutVDtoa7XYaTqRPsmH49tzhRJEN5kAfp0PZNokNFWUZTRvS3UqV8BiIu+mEVWSJKCzPyG7vW0k6oA9m7/YdOcWnuKEvSBIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133464; c=relaxed/simple;
	bh=k4QzhlWoFW0nKlX+gCLSWARw5LDdpUWLbvAWfPBN+UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQSeVpeF2nPFCCvBK09ezdoSiGXSggaWPapHGpK4P8xsVM6IUbFN8c6mbzRVUt6OX3C/BcfYaMX6I1pthJhy/K4NmD2HZi3IrCD7T89s3+C/NjMvq2LcpIC8U3scBwyuayZ8BN4qU+FJ4HHyABpe76o9vU1qG8VWUviSU4+aJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iirRmPEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763133461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHbOf6w5rlj656BCFSOxLzgqhHO7ycdTLJssDuPvEBo=;
	b=iirRmPEn5keefa8xiA70bhb7vKhUlus6LpLEwZW0Q2Yg1Hf0BFVcimm6w/TapkVf71m17e
	/ehTR7M1CVl5xFR6Be/I0lt0PKj12ofuiykppIZ4HaQqqxl6H6wjGf8kuiMqlMg2CP7H+U
	pK/ugHJRf7UmwO9AIj8AyS6RRqWDDmQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531--Ii0M5UDM1-LvTUINdpoDg-1; Fri,
 14 Nov 2025 10:17:37 -0500
X-MC-Unique: -Ii0M5UDM1-LvTUINdpoDg-1
X-Mimecast-MFC-AGG-ID: -Ii0M5UDM1-LvTUINdpoDg_1763133453
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DC7C1956096;
	Fri, 14 Nov 2025 15:17:33 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.226.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A94EB180049F;
	Fri, 14 Nov 2025 15:17:18 +0000 (UTC)
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
Subject: [RFC PATCH v7 31/31] x86/entry: Add an option to coalesce TLB flushes
Date: Fri, 14 Nov 2025 16:14:28 +0100
Message-ID: <20251114151428.1064524-11-vschneid@redhat.com>
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

Previous patches have introduced a mechanism to prevent kernel text updates
from inducing interference on isolated CPUs. A similar action is required
for kernel-range TLB flushes in order to silence the biggest remaining
cause of isolated CPU IPI interference.

These flushes are mostly caused by vmalloc manipulations - e.g. on x86 with
CONFIG_VMAP_STACK, spawning enough processes will easily trigger
flushes. Unfortunately, the newly added context_tracking IPI deferral
mechanism cannot be leveraged for TLB flushes, as the deferred work would
be executed too late. Consider the following execution flow:

  <userspace>

  !interrupt!

  SWITCH_TO_KERNEL_CR3 // vmalloc range becomes accessible

  idtentry_func_foo()
    irqentry_enter()
      irqentry_enter_from_user_mode()
	enter_from_user_mode()
	  [...]
	    ct_kernel_enter_state()
	      ct_work_flush() // deferred flush would be done here

Since there is no sane way to assert no stale entry is accessed during
kernel entry, any code executed between SWITCH_TO_KERNEL_CR3 and
ct_work_flush() is at risk of accessing a stale entry. Dave had suggested
hacking up something within SWITCH_TO_KERNEL_CR3 itself, which is what has
been implemented in the previous patches.

Make kernel-range TLB flush deferral available via CONFIG_COALESCE_TLBI.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa9229c0e0939..04f9d6496bbbc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2189,6 +2189,23 @@ config ADDRESS_MASKING
	  The capability can be used for efficient address sanitizers (ASAN)
	  implementation and for optimizations in JITs.

+config COALESCE_TLBI
+       def_bool n
+       prompt "Coalesce kernel TLB flushes for NOHZ-full CPUs"
+       depends on X86_64 && MITIGATION_PAGE_TABLE_ISOLATION && NO_HZ_FULL
+       help
+	 TLB flushes for kernel addresses can lead to IPIs being sent to
+	 NOHZ-full CPUs, thus kicking them out of userspace.
+
+	 This option coalesces kernel-range TLB flushes for NOHZ-full CPUs into
+	 a single flush executed at kernel entry, right after switching to the
+	 kernel page table. Note that this flush is unconditionnal, even if no
+	 remote flush was issued during the previous userspace execution window.
+
+	 This obviously makes the user->kernel transition overhead even worse.
+
+	 If unsure, say N.
+
 config HOTPLUG_CPU
	def_bool y
	depends on SMP
--
2.51.0


