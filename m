Return-Path: <linux-arch+bounces-12333-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F95AD7F55
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 02:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E623B1C0C
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FE2AD21;
	Fri, 13 Jun 2025 00:01:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A6139D;
	Fri, 13 Jun 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772919; cv=none; b=ZyFovpBo88W+mNpyJVrwnd05VsH1WkkmkaZrOqk2/lnUetwmkI4+pLtZqtP5ViV2SFmfSTD5kV+hF3Y2YYkmWBet2dRbMytNbX5ng2ld/+GABECZcpJjQ5M+BG/8b6fmG9auD9pW9Wx9+D109vx5/MktSjNGX6Ej1sMGAXwVHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772919; c=relaxed/simple;
	bh=6X6YyF+WmEpHgmZwhbhrlTroU5ZhUwoXBgY6pNP9Id0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ucDaVkVwWVcd+qyUs0gsPPElUL6XMjFKRnVqulkTYJVaCR9iWiXC8USf5qr2b3Ukh0GHmkmfyttRhcAVbFL12JEO/ELmBlVSVlEgi5APAUA1gUdjaDAoDaq1nwG3oGhF/fR6bH5y4qtUuymS0hvt4IyMnz6PjwtB7phD/n1BaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DAFD31D3744;
	Fri, 13 Jun 2025 00:01:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 7CDC520031;
	Fri, 13 Jun 2025 00:01:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPrtI-00000001wlg-3EO1;
	Thu, 12 Jun 2025 20:03:28 -0400
Message-ID: <20250613000328.620789081@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 19:58:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/5] tracepoints: Add verifier that makes sure all defined tracepoints are
 used
References: <20250612235827.011358765@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 7CDC520031
X-Stat-Signature: gif8eonr5am6qscjy8j3h13p95g4kpmt
X-Rspamd-Server: rspamout06
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19gNSZmr1/AtJ7GQ18jz1v4oZktpuJFyhM=
X-HE-Tag: 1749772912-528732
X-HE-Meta: U2FsdGVkX1/x9WX7wj7C22IPbglr2v5XvUGWuBvVNt5ScvxZ4ZaOQX/Uvlk60zw03VDOFNqxisbkC7iySs815i8MAXhSDkUtX2nfquuNfptMVOqWfAcgmP2J/GvzEAaVaV5VMNX5aAMrEkufrLqhvaVkAbDDSu2MVR7PPrv0MrsePeFdy4UCiAcn7EOTxKsaHzojKe7+6rntio/+0usQnPjtLtNj0fwbaN7vsD8BP3a58NO+nmuWArzvWfRJXbvD7q9HCbBCp2vGl92NFtA1zuOVXFwXfmBB0tSPxFBVQ6uBnXLZwGlHyV9iTMy8mO8RfAI+8tvfLn66UYf71EtQWuwKd7QIy2AppZNheVMFci/QVj3fet4v/UrMEwiXknQ3P202jHwxyWXpGoyNaO9HUh5vCPpuWT1d03GvFgmNySM=

From: Steven Rostedt <rostedt@goodmis.org>

If a tracepoint is defined via DECLARE_TRACE() or TRACE_EVENT() but never
called (via the trace_<tracepoint>() function), its meta data is still
around in memory and not discarded.

When created via TRACE_EVENT() the situation is worse because the
TRACE_EVENT() creates meta data that can be around 5k per trace event.
Having unused trace events causes several thousand of wasted bytes.

Add a verifier that injects a pointer to the tracepoint structure in the
functions that are used and added to a section called __tracepoint_check.
Then on boot up, iterate over this section and for every tracepoint
descriptor that is pointed to, update its ".funcs" field to (void *)1, as
the .funcs field is only set when a tracepoint is registered. At this
time, no tracepoints should be registered.

Then iterate all tracepoints and if any tracepoints doesn't have its
.funcs field set to (void*)1, trigger a warning, and list all tracepoints
that are not found.

Enabling this currently with a given config produces:

 Tracepoint x86_fpu_before_restore unused
 Tracepoint x86_fpu_after_restore unused
 Tracepoint x86_fpu_init_state unused
 Tracepoint pelt_hw_tp unused
 Tracepoint pelt_irq_tp unused
 Tracepoint ipi_raise unused
 Tracepoint ipi_entry unused
 Tracepoint ipi_exit unused
 Tracepoint irq_matrix_alloc_reserved unused
 Tracepoint psci_domain_idle_enter unused
 Tracepoint psci_domain_idle_exit unused
 Tracepoint powernv_throttle unused
 Tracepoint clock_enable unused
 Tracepoint clock_disable unused
 Tracepoint clock_set_rate unused
 Tracepoint power_domain_target unused
 Tracepoint xdp_bulk_tx unused
 Tracepoint xdp_redirect_map unused
 Tracepoint xdp_redirect_map_err unused
 Tracepoint mem_return_failed unused
 Tracepoint vma_mas_szero unused
 Tracepoint vma_store unused
 Tracepoint hugepage_set_pmd unused
 Tracepoint hugepage_set_pud unused
 Tracepoint hugepage_update_pmd unused
 Tracepoint hugepage_update_pud unused
 Tracepoint dax_pmd_insert_mapping unused
 Tracepoint dax_insert_mapping unused
 Tracepoint block_rq_remap unused
 Tracepoint xhci_dbc_handle_event unused
 Tracepoint xhci_dbc_handle_transfer unused
 Tracepoint xhci_dbc_gadget_ep_queue unused
 Tracepoint xhci_dbc_alloc_request unused
 Tracepoint xhci_dbc_free_request unused
 Tracepoint xhci_dbc_queue_request unused
 Tracepoint xhci_dbc_giveback_request unused
 Tracepoint tcp_ao_wrong_maclen unused
 Tracepoint tcp_ao_mismatch unused
 Tracepoint tcp_ao_key_not_found unused
 Tracepoint tcp_ao_rnext_request unused
 Tracepoint tcp_ao_synack_no_key unused
 Tracepoint tcp_ao_snd_sne_update unused
 Tracepoint tcp_ao_rcv_sne_update unused

Some of the above is totally unused but others are not used due to their
"trace_" functions being inside configs, in which case, the defined
tracepoints should also be inside those same configs. Others are
architecture specific but defined in generic code, where they should
either be moved to the architecture or be surrounded by #ifdef for the
architectures they are for.

Note, currently this only handles tracepoints that are builtin. This can
easily be extended to verify tracepoints used by modules, but it requires a
slightly different approach as it needs updates to the module code.

Link: https://lore.kernel.org/all/20250528114549.4d8a5e03@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250529130138.544ffec4@gandalf.local.home

- Separate the config that does the runtime warning from the
  sections added to the calls to tracepoints so that it can
  be used for build time warnings.

 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/tracepoint.h        | 10 ++++++++++
 kernel/trace/Kconfig              | 19 +++++++++++++++++++
 kernel/tracepoint.c               | 26 ++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa5f19b8d53a..600d8b51e315 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -708,6 +708,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	MCOUNT_REC()							\
 	*(.init.rodata .init.rodata.*)					\
 	FTRACE_EVENTS()							\
+	BOUNDED_SECTION_BY(__tracepoint_check, ___tracepoint_check)	\
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
 	ERROR_INJECT_WHITELIST()					\
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..2b96c7e94c52 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -221,6 +221,14 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		__do_trace_##name(args);				\
 	}
 
+#ifdef CONFIG_TRACEPOINT_VERIFY_USED
+# define TRACEPOINT_CHECK(name)						\
+	static void __used __section("__tracepoint_check") *__trace_check = \
+		&__tracepoint_##name;
+#else
+# define TRACEPOINT_CHECK(name)
+#endif
+
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -270,6 +278,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
+		TRACEPOINT_CHECK(name)					\
 		if (cond) {						\
 			guard(preempt_notrace)();			\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
@@ -289,6 +298,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
+		TRACEPOINT_CHECK(name)					\
 		guard(rcu_tasks_trace)();				\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 	}								\
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..e676b802b721 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1044,6 +1044,25 @@ config GCOV_PROFILE_FTRACE
 	  Note that on a kernel compiled with this config, ftrace will
 	  run significantly slower.
 
+config TRACEPOINT_VERIFY_USED
+	bool
+	help
+          This option creates a section when tracepoints are used
+	  that hold a pointer to the tracepoint that is used.
+	  This can be used to test if a defined tracepoint is
+	  used or not.
+
+config TRACEPOINT_WARN_ON_UNUSED
+	bool "Warn if any tracepoint is defined but not used"
+	depends on TRACEPOINTS
+	select TRACEPOINT_VERIFY_USED
+	help
+	  This option checks if every builtin defined tracepoint is
+	  used in the code. If a tracepoint is defined but not used,
+	  it will waste memory as its meta data is still created.
+	  A warning will be triggered if a tracepoint is found and
+	  not used at bootup.
+
 config FTRACE_SELFTEST
 	bool
 
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c9..7701a6fed310 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -677,10 +677,36 @@ static struct notifier_block tracepoint_module_nb = {
 	.priority = 0,
 };
 
+#ifdef CONFIG_TRACEPOINT_WARN_ON_UNUSED
+extern void * __start___tracepoint_check[];
+extern void * __stop___tracepoint_check[];
+
+#define VERIFIED_TRACEPOINT	((void *)1)
+
+static void check_tracepoint(struct tracepoint *tp, void *priv)
+{
+	if (WARN_ONCE(tp->funcs != VERIFIED_TRACEPOINT, "Unused tracepoints found"))
+		pr_warn("Tracepoint %s unused\n", tp->name);
+
+	tp->funcs = NULL;
+}
+#endif
+
 static __init int init_tracepoints(void)
 {
 	int ret;
 
+#ifdef CONFIG_TRACEPOINT_WARN_ON_UNUSED
+	for (void **ptr = __start___tracepoint_check;
+	     ptr < __stop___tracepoint_check; ptr++) {
+		struct tracepoint *tp = *ptr;
+
+		tp->funcs = VERIFIED_TRACEPOINT;
+	}
+
+	for_each_kernel_tracepoint(check_tracepoint, NULL);
+#endif
+
 	ret = register_module_notifier(&tracepoint_module_nb);
 	if (ret)
 		pr_warn("Failed to register tracepoint module enter notifier\n");
-- 
2.47.2



