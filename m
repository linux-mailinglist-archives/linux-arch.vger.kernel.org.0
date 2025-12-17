Return-Path: <linux-arch+bounces-15486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8EFCC7551
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 12:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 744C93121CE8
	for <lists+linux-arch@lfdr.de>; Wed, 17 Dec 2025 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458F335556;
	Wed, 17 Dec 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odrNTgZU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60F328617
	for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970512; cv=none; b=bt+wstdNXymJEErUqjJ+HcNsKUou2G7gJK4Z81UH5tSxlsRaz+GHleVe3bOGzQDOodvXA1ongfKNvPnRTh4Oi803f5XIGewjKX1Xy/rQGfKbJALAwODkS19Z720lg6c/MJn9aYPmAfVmAINgJGWWi86hg0Zr500k/Xy0oU5mgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970512; c=relaxed/simple;
	bh=djGK9a/PbIEvwH7fMw191k8tLn5bmy64ldWAKNGBEIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=apRAiUacMBNF78PJgrmMVV5ODTMGh1cHYUvTQ1J/Afc/UlaRYD18ekDXzlUBJSzHsHMDMRuJxXnNF0/vsFFsFaak5+jTbo/zs2WodPgjexmP6zrfdhknv2xZGDmVL+YxSFHCjhYicQApdvbVa47rFRjX/zHyIXzSXT6FAgBjoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odrNTgZU; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6496e6c9eb9so6262482a12.3
        for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2025 03:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765970507; x=1766575307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtTq+yFtULAr3S4+lmRLp6BZLceWbGit2YFFxC7qk9w=;
        b=odrNTgZUp0PeK6qrVE2P+vZBRLNdRX31YJB7WNgD+gqKcei3eUBJ1FKJdHQ3Baw1OA
         tIs2Op/z4JTNKPSzn79fY4AcMtrbSrtpDDLo9GQ0zhuxpUoTzaDmMR34iHRfwmcjo3Y4
         6nqjEFVtS1uCaUDciWEWjYzzAO14ZLMOwybvOaDQaUZvmrNniuV/PZe1XpYElqfTh/Ck
         8Ovp4zEDqSE6qjW8amb/2WanuiX2f2azyyL+QTxF2AgBqvJhpx5miJGEGGPc8e2qbKmV
         zv0/+IKNXzAAn7ZWkrL6tkxia1tusZC868p8Dt03gk5vOLBxS16g9ui7WKOwx201mfTI
         OBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970507; x=1766575307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtTq+yFtULAr3S4+lmRLp6BZLceWbGit2YFFxC7qk9w=;
        b=jbcwD7i0HTSHiszvYu8XOWjqSYLitLwGeg7yDSFlgFw30GK4RyvvdkgeMrkgldDFGW
         h8pid/K6yfdxbD6OAgPjHt3AMYuaA35X2ER9RjtWn927nt7fzwZx8KkIw218XapFCxHy
         qjyVnqqASMSxvSWw8XE7SqFEldjYf299Q6HFpqAIIbg4JsiWQu7n+0AqbdEvDUqZDknB
         MpFiHL6HBCnOm03o4+qeLeE9HcYZu2VOtlAvQcu1v8/1lEhm7ZG75/4xscOREXPukhnq
         kcXZJopRbXti0KTCgL51Pc03C5mQbmBof4VqcR8ONg6bHF3Kl9CF8D2zR53Bfe8QmYIZ
         Pm3g==
X-Forwarded-Encrypted: i=1; AJvYcCXsZ0Evh5oKjrB8HlrC+VWdpHRqEFWbmjNVridJEm9bCccVxc1Ytqrq6AfSQLEGb32PHh+2SZ+s5QWB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gtp+5PRtAnW5a/pieM1SAvQe4GrnDQHP1/9hg+JRouDAG/2L
	dwWOr1dG823VK8lvY0F6lSvSp48a/nWTRJbyvCQlRD65/m0PgNK0JK31GrwSbDvZGvyrZuZORsW
	WRMKbmQ==
X-Google-Smtp-Source: AGHT+IHf617U3EOpdp52V/RhXFK5v3RSOZhwgvcp0C9fXsJFLpQ1TQTfSiq2gZ9LKhWsDSYcQTVE98fnY+g=
X-Received: from edsx15.prod.google.com ([2002:aa7:dacf:0:b0:649:93b9:195f])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2792:b0:649:a84c:745b
 with SMTP id 4fb4d7f45d1cf-649a84c7534mr15485990a12.3.1765970507467; Wed, 17
 Dec 2025 03:21:47 -0800 (PST)
Date: Wed, 17 Dec 2025 11:21:28 +0000
In-Reply-To: <20251217112128.1401896-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251217112128.1401896-1-lrizzo@google.com>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Message-ID: <20251217112128.1401896-4-lrizzo@google.com>
Subject: [PATCH-v3 3/3] genirq: Configurable default mode for GSIM
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

GSIM (Global Software Interrupt Moderation) can be enabled only after the
interrupt is created by writing to /proc/irq/NN/soft_moderation. This is
impractical when devices that are dynamically created or reconfigured.

Add a module parameter irq_moderation.enable_list to specify whether
moderation should be enabled at interrupt creation time. This is done
with a comma-separated list of patterns (enable_list) matched against
interrupt or handler names when the interrupt is created.

This allows very flexible control without having to modify every single
driver. As an example, one can limit to specific drivers by specifying
the handler functions (using parentheses) as below

     irq_moderation.enable_list="nvme_irq(),vfio_msihandler()"

ora apply it to certain interrupt names

     irq_moderation.enable_list="eth*,vfio*"

Change-Id: Id5f7aba5b21ad478e4fb7edd0f00eeb2b83e07d2
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/irqdesc.h     |   5 ++
 kernel/irq/irq_moderation.c | 125 ++++++++++++++++++++++++++++++++++++
 kernel/irq/manage.c         |   4 ++
 3 files changed, 134 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d42ce57ff5406..e0785c709d013 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -16,6 +16,7 @@ struct module;
 struct irq_desc;
 struct irq_domain;
 struct pt_regs;
+struct irqaction;
 
 #ifdef CONFIG_IRQ_SOFT_MODERATION
 
@@ -30,11 +31,15 @@ struct irq_desc_mod {
 };
 
 void irq_moderation_init_fields(struct irq_desc_mod *mod);
+bool irq_moderation_get_default(const struct irqaction *action);
+void irq_moderation_enable(struct irq_desc *desc);
 
 #else
 
 struct irq_desc_mod {};
 static inline void irq_moderation_init_fields(struct irq_desc_mod *mod) {}
+static inline bool irq_moderation_get_default(const struct irqaction *action) { return false; }
+static inline void irq_moderation_enable(struct irq_desc *desc) {}
 
 #endif
 
diff --git a/kernel/irq/irq_moderation.c b/kernel/irq/irq_moderation.c
index be7d10404a24a..216bd1f83d23e 100644
--- a/kernel/irq/irq_moderation.c
+++ b/kernel/irq/irq_moderation.c
@@ -50,6 +50,11 @@
  *   update_ms (default 5, range 1-100)
  *       How often the load is measured and moderation delay updated.
  *
+ *   enable_list (comma-separated list of handlers or interrupt names)
+ *       Enable moderation at creation for interrupts whose name or handler
+ *       functions match patterns in this list. Example:
+ *       "nvme_irq(),eth*,vfio_msihandler()"
+ *
  * Moderation can be enabled/disabled dynamically for individual interrupts with
  *
  *     echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable
@@ -142,6 +147,90 @@ void irq_moderation_init_fields(struct irq_desc_mod *mod)
 	mod->enable = false;
 }
 
+/*
+ * irq_moderation.enable_list is a comma-separated list of patterns to match
+ * against the name eg "eth*" or handler e.g "nvme_irq()" of the interrupt.
+ * There is one active buffer and one used for updates, so replacement just
+ * needs to swap the pointer.
+ */
+#define MAX_CONFIG_LEN 4096
+static struct enable_list {
+	char buf[MAX_CONFIG_LEN];
+	char buf2[MAX_CONFIG_LEN];
+	char *cur;
+	uint len;
+	struct rw_semaphore rwsem;
+} patterns = { .cur = patterns.buf, .rwsem = __RWSEM_INITIALIZER(patterns.rwsem) };
+
+static int set_enable_list(const char *val, const struct kernel_param *kp)
+{
+	uint i, len = strlen(val);
+	char *dst;
+
+	if (len >= MAX_CONFIG_LEN - 1)
+		return -E2BIG;
+	if (val[len - 1] == '\n')
+		len--;
+
+	/* Serialized by procfs. */
+	dst = patterns.cur == patterns.buf ? patterns.buf2 : patterns.buf;
+	/* Copy and split the string on commas. */
+	for (i = 0; i < len; i++)
+		dst[i] = val[i] == ',' ?  '\0' : val[i];
+	dst[i] = '\0';
+	guard(rwsem_write)(&patterns.rwsem);
+	patterns.cur = dst;
+	patterns.len = len;
+	return 0;
+}
+
+static int get_enable_list(char *buf, const struct kernel_param *kp)
+{
+	int i;
+
+	/* Join the patterns with commas. */
+	guard(rwsem_read)(&patterns.rwsem);
+	for (i = 0; i < patterns.len; i++)
+		buf[i] = patterns.cur[i] == '\0' ?  ',' : patterns.cur[i];
+	buf[i] = '\0';
+	return patterns.len;
+}
+
+static const struct kernel_param_ops enable_list_ops = {
+	.set = set_enable_list,
+	.get = get_enable_list,
+};
+
+module_param_cb(enable_list, &enable_list_ops, NULL, 0444);
+
+/* Called early in __setup_irq() without desc->lock. */
+bool irq_moderation_get_default(const struct irqaction *act)
+{
+	guard(rwsem_read)(&patterns.rwsem);
+	for (int arg = 0; arg < 3; arg++) {
+		/* buf includes room for "()". */
+		char buf[KSYM_SYMBOL_LEN + 3];
+		const char *name;
+
+		if (arg == 0) {
+			name = act->name;
+			if (!name)
+				continue;
+		} else {
+			irq_handler_t fn = arg == 1 ? act->handler : act->thread_fn;
+
+			if (lookup_symbol_name((ulong)fn, buf))
+				continue;
+			memcpy(buf + strlen(buf), "()", 3);
+			name = buf;
+		}
+		for (int i = 0; i < patterns.len; i += 1 + strlen(patterns.cur + i))
+			if (glob_match(patterns.cur + i, name))
+				return true;
+	}
+	return false;
+}
+
 static int set_mode(struct irq_desc *desc, bool enable)
 {
 	lockdep_assert_held(&desc->lock);
@@ -163,6 +252,12 @@ static int set_mode(struct irq_desc *desc, bool enable)
 	return 0;
 }
 
+/* Called with desc->lock held in __setup_irq(). */
+void irq_moderation_enable(struct irq_desc *desc)
+{
+	set_mode(desc, true);
+}
+
 #pragma clang diagnostic error "-Wformat"
 /* Print statistics */
 static int moderation_show(struct seq_file *p, void *v)
@@ -171,6 +266,7 @@ static int moderation_show(struct seq_file *p, void *v)
 	uint delay_us = irq_mod_info.delay_us;
 	u64 now = ktime_get_ns();
 	int j, active_cpus = 0;
+	char *buf;
 
 #define HEAD_FMT "%5s  %8s  %8s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %9s\n"
 #define BODY_FMT "%5u  %8u  %8u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %9u\n"
@@ -210,17 +306,24 @@ static int moderation_show(struct seq_file *p, void *v)
 			   ms->stray_irq);
 	}
 
+	buf = kmalloc(MAX_CONFIG_LEN, GFP_KERNEL);
+	if (buf)
+		get_enable_list(buf, NULL);
 	seq_printf(p, "\n"
 		   "enabled              %s\n"
+		   "enable_list          '%s'\n"
 		   "delay_us             %u\n"
 		   "target_intr_rate     %u\n"
 		   "hardirq_percent      %u\n"
 		   "update_ms            %u\n"
 		   "scale_cpus           %u\n",
 		   str_yes_no(delay_us > 0),
+		   buf ? : "",
 		   delay_us,
 		   irq_mod_info.target_intr_rate, irq_mod_info.hardirq_percent,
 		   irq_mod_info.update_ms, irq_mod_info.scale_cpus);
+	if (buf)
+		kfree(buf);
 
 	seq_printf(p,
 		   "intr_rate            %lu\n"
@@ -258,6 +361,8 @@ static struct param_names param_names[] = {
 	/* Entries with no name cannot be set at runtime. */
 	{ "", &irq_mod_info.increase_factor, MIN_SCALING_FACTOR, 128 },
 	{ "", &irq_mod_info.scale_cpus, 50, 1000 },
+	/* val = NULL indicates a special entry for enable_list. */
+	{ "enable_list", NULL },
 };
 
 static void update_enable_key(void)
@@ -270,6 +375,24 @@ static void update_enable_key(void)
 		static_branch_disable(key);
 }
 
+static ssize_t set_enable_list_from_proc(const char __user *buf, int count, int ofs)
+{
+	char *cmd;
+
+	if (count >= MAX_CONFIG_LEN)
+		return -EINVAL;
+	cmd = kmalloc(count + 1, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+	if (copy_from_user(cmd, buf, count)) {
+		kfree(cmd);
+		return -EFAULT;
+	}
+	set_enable_list(cmd + ofs, NULL);
+	kfree(cmd);
+	return count;
+}
+
 static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
 {
 	uint i, val, copy_len, name_len;
@@ -287,6 +410,8 @@ static ssize_t moderation_write(struct file *f, const char __user *buf, size_t c
 		if (name_len < 1 || copy_len < name_len + 2 || strncmp(cmd, n->name, name_len) ||
 		    cmd[name_len] != '=')
 			continue;
+		if (n->val == NULL)
+			return set_enable_list_from_proc(buf, count, name_len + 1);
 		if (kstrtouint(cmd + name_len + 1, 0, &val))
 			return -EINVAL;
 		WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8b1b4c8a4f54c..41b6e6ec2b09e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1449,6 +1449,7 @@ static bool valid_percpu_irqaction(struct irqaction *old, struct irqaction *new)
 static int
 __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 {
+	bool use_moderation = irq_moderation_get_default(new);
 	struct irqaction *old, **old_ptr;
 	unsigned long flags, thread_mask = 0;
 	int ret, nested, shared = 0;
@@ -1761,6 +1762,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 	irq_pm_install_action(desc, new);
 
+	if (use_moderation)
+		irq_moderation_enable(desc);
+
 	/* Reset broken irq detection when installing new handler */
 	desc->irq_count = 0;
 	desc->irqs_unhandled = 0;
-- 
2.52.0.305.g3fc767764a-goog


