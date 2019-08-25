Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E089C3C0
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfHYNYw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:24:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36593 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYNYw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:24:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so9838223pfi.3;
        Sun, 25 Aug 2019 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAp9rBiagwe8XKAVdRDELHL9r8vQmtXA/ae5KwLFduo=;
        b=GksUN9j0Ha1KClE/9eLYSTylVI4jvyyGL7zrLmT2P9d4MzEEz8lwoNS5tg8XJc1pLG
         SMUxdI+WtLFvKmV679ZWdlTFnNildzsUJ2yszk/mcwlkQxq9MdW6QwtvO3ZJYprYTswz
         nrDRyO+nHTnyVgNCNLOXdVtX1oO5RDFs8kuey1uTOBMXImeWg2kkHRPRWBajbcukJ0eq
         AW487a1wzz2TwnuLl1GBj0LJgsxnDHWOnvvRQwZyX7OUfTLVlItIfT+Tmzfkfjh3X1Ba
         YnthDVNSdlOpIpG86RaM7LOcqB5U6gxkkwxaSSnWivL2z0XkydCd5eItNKqQl6pV/oPg
         /jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAp9rBiagwe8XKAVdRDELHL9r8vQmtXA/ae5KwLFduo=;
        b=BUmN+R+rCJbBMkzS0MDvpgmHtqus2oY8rykM6QaHNOeNAhlEfCT1JrH3w+VeFKpZZ7
         mmsfcaBXHjzu05CeKtyp1IjJleLph+0GAW3ntR5Wgff16C+ZHsV8j5keva3c03bO48jw
         f8vvfDOBN8zzNCGcG4xl9Vkbqk9Veh04BBVJdkgSwhGSnb4Lrtj212A4H35iUbtp7xU/
         CJ1GPdgWwKRa44khDE5vF9wHOV5ODBjJZnpnKb1/KztxbkC6y45HH1bE0tqzwoz6yxNg
         g7JPODoE1sHrw1zT/72TYbiYcAqYuonH1Mvo/3tyJeFwK2yAczztITTke/KhQIjAuDv3
         j3lg==
X-Gm-Message-State: APjAAAWfcar3NVhbVkJBpchILaXYewpb+xSSCUTag360k6guVh5+Bju5
        u+o0lFU/jM0bWBgqTYEE30Q=
X-Google-Smtp-Source: APXvYqw/JQNHIo4k980ZK4NFstZpfGbMg4A01vDLGmYKWi7iBVw5yootcvwOkApQ8aSTHVu3ur9wVA==
X-Received: by 2002:a63:494d:: with SMTP id y13mr12296270pgk.109.1566739490877;
        Sun, 25 Aug 2019 06:24:50 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:24:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 08/11] ftrace: introduce core part of function prototype recording
Date:   Sun, 25 Aug 2019 21:23:27 +0800
Message-Id: <20190825132330.5015-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch introduces the core part of our new CONFIG_FTRACE_FUNC_PROTOTYPE
feature. For arch which supports this feature must implement a new
arch-specific interface arch_fgraph_record_params().

In this patch, we add a new trace option "record-funcproto", and by now
only function graph tracer is supported. The major work is to handle
the printing stuff.

Here is an example of the graph trace of function pick_next_task_fair().
Note that we only record the parameter and return value of global
functions.

 2)               |  pick_next_task_fair() {
 2)               |    update_blocked_averages() {
 2)   0.765 us    |      _raw_spin_lock_irqsave(lock=0xffff88807da2b100); /* ret=0x0000000000000082 */
 2)   0.944 us    |      update_rq_clock(rq=0xffff88807da2b100);
 2)   0.612 us    |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff8880754f7488); /* ret=0 */
 2)   0.654 us    |      __update_load_avg_se(now=0x000000251b8516ee, cfs_rq=0xffff88807da2b180, se=0xffff88807be2e0d8); /* ret=0 */
 2)   0.206 us    |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff88807da2b180); /* ret=0 */
 2)               |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff888079b5fb18) {
 2)   2.410 us    |        __accumulate_pelt_segments();
 2)   3.103 us    |      } /* ret=1 */
 2)   0.193 us    |      __update_load_avg_cfs_rq(now=0x000000251b8516ee, cfs_rq=0xffff88807da2b180); /* ret=0 */
 2)               |      update_rt_rq_load_avg(now=0x000000251b8516ee, rq=0xffff88807da2b100, running=0) {
 2)   0.258 us    |        __accumulate_pelt_segments();
 2)   1.617 us    |      } /* ret=1 */
 2)               |      update_dl_rq_load_avg(now=0x000000251b8516ee, rq=0xffff88807da2b100, running=0) {
 2)   0.230 us    |        __accumulate_pelt_segments();
 2)   1.511 us    |      } /* ret=1 */
 2)   1.040 us    |      _raw_spin_unlock_irqrestore(lock=0xffff88807da2b100, flags=0x0000000000000082);
 2) + 14.739 us   |    }
 2)               |    load_balance() {
 2)               |      find_busiest_group() {
 2)   0.874 us    |        update_group_capacity(sd=0xffff88807c1d37d0, cpu=2);
 2)   1.761 us    |        idle_cpu();
 2)   0.262 us    |        idle_cpu();
 2)   0.217 us    |        idle_cpu();
 2)   6.338 us    |      }
 2)   8.442 us    |    }
 2)   1.823 us    |    __msecs_to_jiffies(m=0x00000006); /* ret=0x0000000000000002 */
 2)               |    load_balance() {
 2)               |      find_busiest_group() {
 2)   0.434 us    |        idle_cpu();
 2)   0.233 us    |        idle_cpu();
 2)   0.210 us    |        idle_cpu();
 2)   2.308 us    |      }
 2)   2.821 us    |    }
 2)   0.263 us    |    __msecs_to_jiffies(m=0x00000008); /* ret=0x0000000000000002 */
 2)   0.977 us    |    _raw_spin_lock(lock=0xffff88807da2b100);
 2) + 32.262 us   |  }

The printing rules of each value is:
  o For signed value, it is always printed as decimal number.
  o For unsigned value,
    - For value has size great than 8, it is printed as '{..}'.
    - For value has size of 1,2,4,8, it is printed as hexadecimal number.
    - If failed to record a parameter, it is printed as '?'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/linux/ftrace.h               |  27 +++++++
 kernel/trace/fgraph.c                |   5 ++
 kernel/trace/ftrace.c                |  50 +++++++++++++
 kernel/trace/trace.h                 |   8 ++
 kernel/trace/trace_entries.h         |  10 +++
 kernel/trace/trace_functions_graph.c | 106 +++++++++++++++++++++++++--
 6 files changed, 201 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e615b5e639aa..82b92d355431 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/trace_seq.h>
 
 #include <asm/ftrace.h>
 
@@ -377,6 +378,9 @@ struct func_prototype {
 
 #define FTRACE_PROTOTYPE_SIGNED(t)	(t & BIT(7))
 #define FTRACE_PROTOTYPE_SIZE(t)	(t & GENMASK(6, 0))
+
+void ftrace_print_typed_val(struct trace_seq *s, uint8_t type,
+			    unsigned long val);
 #endif
 
 int ftrace_force_update(void);
@@ -731,6 +735,13 @@ extern void ftrace_init(void);
 static inline void ftrace_init(void) { }
 #endif
 
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+# define FTRACE_MAX_FUNC_PARAMS		10
+
+# define FTRACE_PROTOTYPE_SIGNED(t)	(t & BIT(7))
+# define FTRACE_PROTOTYPE_SIZE(t)	(t & GENMASK(6, 0))
+#endif
+
 /*
  * Structure that defines an entry function trace.
  * It's already packed but the attribute "packed" is needed
@@ -739,6 +750,12 @@ static inline void ftrace_init(void) { }
 struct ftrace_graph_ent {
 	unsigned long func; /* Current function */
 	int depth;
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+	uint8_t nr_param;
+	char *param_names[FTRACE_MAX_FUNC_PARAMS];
+	uint8_t param_types[FTRACE_MAX_FUNC_PARAMS];
+	unsigned long param_values[FTRACE_MAX_FUNC_PARAMS];
+#endif
 } __packed;
 
 /*
@@ -753,8 +770,13 @@ struct ftrace_graph_ret {
 	unsigned long long calltime;
 	unsigned long long rettime;
 	int depth;
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+	uint8_t ret_type;
+	unsigned long retval;
+#endif
 } __packed;
 
+
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *); /* return */
 /* @pt_regs is only available for CONFIG_FTRACE_FUNC_PROTOTYPE. */
@@ -842,6 +864,11 @@ static inline void unpause_graph_tracing(void)
 {
 	atomic_dec(&current->tracing_graph_pause);
 }
+
+void arch_fgraph_record_params(struct ftrace_graph_ent *trace,
+			       struct func_prototype *proto,
+			       struct pt_regs *pt_regs);
+
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 
 #define __notrace_funcgraph
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7451dba84fee..26e452418249 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -220,6 +220,11 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer,
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 	trace.rettime = trace_clock_local();
+
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+	trace.retval = retval;
+#endif
+
 	ftrace_graph_return(&trace);
 	/*
 	 * The ftrace_graph_return() may still access the current
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a1683cc55838..1e6a96f1986b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5658,6 +5658,56 @@ static int ftrace_process_funcproto(struct module *mod,
 
 	return ret;
 }
+
+void ftrace_print_typed_val(struct trace_seq *s, uint8_t type,
+			    unsigned long val)
+{
+	unsigned int sz = FTRACE_PROTOTYPE_SIZE(type);
+	bool is_signed = FTRACE_PROTOTYPE_SIGNED(type);
+
+	/* Don't show complex types */
+	if (sz > sizeof(long)) {
+		trace_seq_printf(s, "{..}");
+		return;
+	}
+
+	switch (sz) {
+	case 0:
+		/* The value is not valid. */
+		trace_seq_printf(s, "?");
+		break;
+	case 1:
+		val &= GENMASK_ULL(7, 0);
+		if (is_signed)
+			trace_seq_printf(s, "%d", (char)val);
+		else
+			trace_seq_printf(s, "0x%02lx", val);
+		break;
+	case 2:
+		val &= GENMASK_ULL(15, 0);
+		if (is_signed)
+			trace_seq_printf(s, "%d", (short)val);
+		else
+			trace_seq_printf(s, "0x%04lx", val);
+		break;
+	case 4:
+		val &= GENMASK_ULL(31, 0);
+		if (is_signed)
+			trace_seq_printf(s, "%d", (int)val);
+		else
+			trace_seq_printf(s, "0x%08lx", val);
+		break;
+	case 8:
+		val &= GENMASK_ULL(63, 0);
+		if (is_signed)
+			trace_seq_printf(s, "%lld", (long long)val);
+		else
+			trace_seq_printf(s, "0x%016lx", val);
+		break;
+	default:
+		trace_seq_printf(s, "{badsize%d}", sz);
+	}
+}
 #endif
 
 struct ftrace_mod_func {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4b31176d443e..f10acad0140f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1231,6 +1231,13 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+# define FUNCPROTO_FLAGS			\
+		C(RECORD_FUNCPROTO,     "record-funcproto"),
+#else
+# define FUNCPROTO_FLAGS
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1256,6 +1263,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(LATENCY_FMT,		"latency-format"),	\
 		C(RECORD_CMD,		"record-cmd"),		\
 		C(RECORD_TGID,		"record-tgid"),		\
+		FUNCPROTO_FLAGS					\
 		C(OVERWRITE,		"overwrite"),		\
 		C(STOP_ON_FREE,		"disable_on_free"),	\
 		C(IRQ_INFO,		"irq-info"),		\
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fc8e97328e54..68b044ea8440 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -82,6 +82,12 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_desc(	unsigned long,	graph_ent,	func		)
 		__field_desc(	int,		graph_ent,	depth		)
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+		__field_desc(	unsigned char,	graph_ent,	nr_param	)
+		__array_desc(	char *,		graph_ent,	param_names,	FTRACE_MAX_FUNC_PARAMS)
+		__array_desc(	uint8_t,	graph_ent,	param_types,	FTRACE_MAX_FUNC_PARAMS)
+		__array_desc(	unsigned long,	graph_ent,	param_values,	FTRACE_MAX_FUNC_PARAMS)
+#endif
 	),
 
 	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth),
@@ -101,6 +107,10 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_desc(	unsigned long long, ret,	rettime	)
 		__field_desc(	unsigned long,	ret,		overrun	)
 		__field_desc(	int,		ret,		depth	)
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+		__field_desc(	unsigned char,	ret,		ret_type)
+		__field_desc(	unsigned long,	ret,		retval	)
+#endif
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index f331a9ba946d..ba4eb71646e9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -169,6 +169,17 @@ int trace_graph_entry(struct ftrace_graph_ent *trace, struct pt_regs *pt_regs)
 	if (tracing_thresh)
 		return 1;
 
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+	trace->nr_param = 0;
+	if (tr->trace_flags & TRACE_ITER_RECORD_FUNCPROTO) {
+		struct ftrace_func_entry *ent;
+
+		ent = ftrace_lookup_ip(ftrace_prototype_hash, trace->func);
+		if (ent)
+			arch_fgraph_record_params(trace, ent->priv, pt_regs);
+	}
+#endif
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -250,6 +261,21 @@ void trace_graph_return(struct ftrace_graph_ret *trace)
 		return;
 	}
 
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+	if (tr->trace_flags & TRACE_ITER_RECORD_FUNCPROTO) {
+		struct ftrace_func_entry *ent;
+
+		ent = ftrace_lookup_ip(ftrace_prototype_hash, trace->func);
+		if (ent) {
+			/* The retval has been saved by trace_graph_return(). */
+			trace->ret_type =
+				((struct func_prototype *)ent->priv)->ret_type;
+		} else
+			trace->ret_type = 0;
+	} else
+		trace->ret_type = 0;
+#endif
+
 	local_irq_save(flags);
 	cpu = raw_smp_processor_id();
 	data = per_cpu_ptr(tr->trace_buffer.data, cpu);
@@ -380,6 +406,71 @@ static void print_graph_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 	trace_seq_puts(s, " | ");
 }
 
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+static void print_graph_params(struct trace_seq *s,
+			       struct ftrace_graph_ent *call,
+			       struct ftrace_graph_ret *graph_ret)
+{
+	int i;
+
+	BUG_ON(call->nr_param > FTRACE_MAX_FUNC_PARAMS);
+
+	trace_seq_printf(s, "%ps(", (void *)call->func);
+	for (i = 0; i < call->nr_param; i++) {
+		if (i > 0)
+			trace_seq_printf(s, ", ");
+		trace_seq_printf(s, "%s=", call->param_names[i]);
+		ftrace_print_typed_val(s, call->param_types[i],
+				       call->param_values[i]);
+	}
+
+	if (graph_ret) {
+		/* leaf */
+		if (graph_ret->ret_type) {
+			trace_seq_printf(s, "); /* ret=");
+			ftrace_print_typed_val(s, graph_ret->ret_type,
+					       graph_ret->retval);
+			trace_seq_puts(s, " */\n");
+		} else
+			trace_seq_puts(s, ");\n");
+	} else
+		trace_seq_printf(s, ") {\n");
+}
+
+static void print_graph_retval(struct trace_seq *s,
+			       struct ftrace_graph_ret *trace,
+			       bool tail)
+{
+	if (trace->ret_type) {
+		if (tail)
+			trace_seq_puts(s, ", ");
+		else
+			trace_seq_puts(s, " /* ");
+
+		trace_seq_printf(s, "ret=");
+		ftrace_print_typed_val(s, trace->ret_type, trace->retval);
+
+		trace_seq_printf(s, " */");
+	}
+}
+#else
+static void print_graph_params(struct trace_seq *s,
+			       struct ftrace_graph_ent *call,
+			       struct ftrace_graph_ret *graph_ret)
+{
+	if (graph_ret)
+		trace_seq_printf(s, "%ps();\n", (void *)call->func);
+	else
+		trace_seq_printf(s, "%ps() {\n", (void *)call->func);
+}
+
+static void print_graph_retval(struct trace_seq *s,
+			       struct ftrace_graph_ret *trace,
+			       bool tail)
+{
+}
+#endif
+
 /* If the pid changed since the last trace, output this event */
 static void
 verif_pid(struct trace_seq *s, pid_t pid, int cpu, struct fgraph_data *data)
@@ -665,7 +756,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps();\n", (void *)call->func);
+	print_graph_params(s, call, graph_ret);
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -703,7 +794,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps() {\n", (void *)call->func);
+	print_graph_params(s, call, NULL);
 
 	if (trace_seq_has_overflowed(s))
 		return TRACE_TYPE_PARTIAL_LINE;
@@ -950,10 +1041,15 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 	 * belongs to, write out the function name. Always do
 	 * that if the funcgraph-tail option is enabled.
 	 */
-	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-		trace_seq_puts(s, "}\n");
-	else
+	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL)) {
+		trace_seq_puts(s, "}");
+		print_graph_retval(s, trace, false);
+		trace_seq_puts(s, "\n");
+	} else {
 		trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
+		print_graph_retval(s, trace, true);
+		trace_seq_puts(s, "\n");
+	}
 
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
-- 
2.20.1

