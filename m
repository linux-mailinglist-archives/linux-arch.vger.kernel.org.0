Return-Path: <linux-arch+bounces-2103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755284BC5C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916A51F24092
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AD1B279;
	Tue,  6 Feb 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQM2rshg"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651B199B4
	for <linux-arch@vger.kernel.org>; Tue,  6 Feb 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241199; cv=none; b=QLlc/aj+C/XSvNU4JBiAEXwflHVQdPniriLnII672l2fIfurPPzVOEwUjuozvFtmQ+UvxdabgXx2OFli75MhIFTa9EyOko7e+hme1eSQNP7DY6o5MtIAGpA32bPOgnOkSuOXb/FW3rCAl1AFFN2+S/AUGdZpZt8eP38daFPz0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241199; c=relaxed/simple;
	bh=ZMQTWbcCGrR/agcFVkVVEI05vXn0HszebfL8x+q/HRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1TeQZVv4aGkBJRskgZknI45/T5nmOtiFG8I0vEfO0wcq6tkLVGK8MNcm1BaknTTmsgq/fft+R9ih86NuXXJmyJu5W5LGGxjIg6OgdeGbG5WFO/A6xAZPgMf18dOicT4IiipYCHk4VjZ+zI/oxtRnx3hmP/OGmpLl2WV0fQHgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQM2rshg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707241195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQJi5lVSKToVYNDb/xc3D9ULA1cJ8DD0UMSW58V8ctw=;
	b=SQM2rshgahd4zFYb7iSQWBd+XxXNgdCDmCkhxm0kep9pyL6d/VYwFVXNYRLgoqAGNYKS1p
	zLDfCKeOG2rPXUTHcZQ1VlvVANvWu3UW46qjcbxk819US/1DjYI65fb8EBhxM8b5/MGcg2
	MedAjoyV2Hk0owHRm8m0Sd1idt0UoFY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-ZIz0_IVqNuCeGd0hcpWWmQ-1; Tue,
 06 Feb 2024 12:39:52 -0500
X-MC-Unique: ZIz0_IVqNuCeGd0hcpWWmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 613AD1C29EA3;
	Tue,  6 Feb 2024 17:39:51 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB6A02026D06;
	Tue,  6 Feb 2024 17:39:46 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Michael Kelley <mikelley@microsoft.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH v2 1/5] jump_label,module: Don't alloc static_key_mod for __ro_after_init keys
Date: Tue,  6 Feb 2024 18:39:07 +0100
Message-ID: <20240206173911.4131670-2-vschneid@redhat.com>
In-Reply-To: <20240206173911.4131670-1-vschneid@redhat.com>
References: <20240206173911.4131670-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Zijlstra <peterz@infradead.org>

When a static_key is marked ro_after_init, its state will never change
(after init), therefore jump_label_update() will never need to iterate
the entries, and thus module load won't actually need to track this --
avoiding the static_key::next write.

Therefore, mark these keys such that jump_label_add_module() might
recognise them and avoid the modification.

Use the special state: 'static_key_linked(key) && !static_key_mod(key)'
to denote such keys.

jump_label_add_module() does not exist under CONFIG_JUMP_LABEL=n, so the
newly-introduced jump_label_ro() can be defined as a nop for that
configuration.

Link: http://lore.kernel.org/r/20230705204142.GB2813335@hirez.programming.kicks-ass.net
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Added comments and build fix]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/sections.h |  5 ++++
 include/linux/jump_label.h     |  3 +++
 init/main.c                    |  1 +
 kernel/jump_label.c            | 49 ++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index db13bb620f527..c768de6f19a9a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -180,6 +180,11 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+static inline bool is_kernel_ro_after_init(unsigned long addr)
+{
+	return addr >= (unsigned long)__start_ro_after_init &&
+	       addr < (unsigned long)__end_ro_after_init;
+}
 /**
  * is_kernel_inittext - checks if the pointer address is located in the
  *                      .init.text section
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f0a949b7c9733..3b103d88c139e 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -216,6 +216,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
+extern void jump_label_ro(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
@@ -265,6 +266,8 @@ static __always_inline void jump_label_init(void)
 	static_key_initialized = true;
 }
 
+static __always_inline void jump_label_ro(void) { }
+
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	if (unlikely_notrace(static_key_count(key) > 0))
diff --git a/init/main.c b/init/main.c
index e24b0780fdff7..5f51d8b910dc1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1407,6 +1407,7 @@ static void mark_readonly(void)
 		 * insecure pages which are W+X.
 		 */
 		rcu_barrier();
+		jump_label_ro();
 		mark_rodata_ro();
 		rodata_test();
 	} else
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8d..25a5ed1147841 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -530,6 +530,45 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
+static inline bool static_key_sealed(struct static_key *key)
+{
+	return (key->type & JUMP_TYPE_LINKED) && !(key->type & ~JUMP_TYPE_MASK);
+}
+
+static inline void static_key_seal(struct static_key *key)
+{
+	unsigned long type = key->type & JUMP_TYPE_TRUE;
+	key->type = JUMP_TYPE_LINKED | type;
+}
+
+void jump_label_ro(void)
+{
+	struct jump_entry *iter_start = __start___jump_table;
+	struct jump_entry *iter_stop = __stop___jump_table;
+	struct jump_entry *iter;
+
+	if (WARN_ON_ONCE(!static_key_initialized))
+		return;
+
+	cpus_read_lock();
+	jump_label_lock();
+
+	for (iter = iter_start; iter < iter_stop; iter++) {
+		struct static_key *iterk = jump_entry_key(iter);
+
+		if (!is_kernel_ro_after_init((unsigned long)iterk))
+			continue;
+
+		if (static_key_sealed(iterk))
+			continue;
+
+		static_key_seal(iterk);
+	}
+
+	jump_label_unlock();
+	cpus_read_unlock();
+}
+
 #ifdef CONFIG_MODULES
 
 enum jump_label_type jump_label_init_type(struct jump_entry *entry)
@@ -650,6 +689,15 @@ static int jump_label_add_module(struct module *mod)
 			static_key_set_entries(key, iter);
 			continue;
 		}
+
+		/*
+		 * If the key was sealed at init, then there's no need to keep a
+		 * reference to its module entries - just patch them now and be
+		 * done with it.
+		 */
+		if (static_key_sealed(key))
+			goto do_poke;
+
 		jlm = kzalloc(sizeof(struct static_key_mod), GFP_KERNEL);
 		if (!jlm)
 			return -ENOMEM;
@@ -675,6 +723,7 @@ static int jump_label_add_module(struct module *mod)
 		static_key_set_linked(key);
 
 		/* Only update if we've changed from our initial state */
+do_poke:
 		if (jump_label_type(iter) != jump_label_init_type(iter))
 			__jump_label_update(key, iter, iter_stop, true);
 	}
-- 
2.43.0


