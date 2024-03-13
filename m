Return-Path: <linux-arch+bounces-2979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197587B0C1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952A71C23CD4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847575EE67;
	Wed, 13 Mar 2024 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL4RzePf"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EC5E22C
	for <linux-arch@vger.kernel.org>; Wed, 13 Mar 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352931; cv=none; b=IW14MMG9J4rReq40+HZ5JcLBOZDWEKwxIwsu4LsjKyxmGoE4t0gO1MWHUh5PmW67Snd2LUyUWQ5kxb9LwjcqwfTGlU5H2R9Th40LlV3/uW21r/+WpEbqZFagusAwlqGIrtgfUttZBpKiG2jSIcxgcwU+cjG2R4RxmvzDuIke2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352931; c=relaxed/simple;
	bh=if5Vz7lK7UhrjNdaEGTiinUB9qTVNJRrc31biNi1pqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7quCid6/WmsaDiUdVWSnJ5bzbMfPuMqXfaLXssbsUEpFU+fWvSJD44h4kvBX9MCww6bw+4EVLIR+RKjxkKtcuaQsacmBVuDyh4Ko29zt2mIpiihyUtFGQC7iYDjxLHWJEiPKLBt0oEfBpcrF3Mm19SoX3/i3BwTRRKWrRWDBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL4RzePf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710352928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5VYGZeD7kglC8ytwECbHJWVaIFSn0T7zKddNgOZwh0=;
	b=OL4RzePfj6k5GyAsA2Trq5VOGwHc+vPxMbyD+pAN8LkJPqL0TuHaMv3NUMilbl8rgEv+0R
	hyYiwd4yqnKRsrsyzDff9/zgPD2lLlGbJdJ5A5Kl7bLV/qSe/PMTmXEqwW6L8RgonVt99/
	h5QWCx+C9gkuGjR2K9GsJI9RUA/LBfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-PyVhjpBjOjeA-91TjYvsRg-1; Wed, 13 Mar 2024 14:02:06 -0400
X-MC-Unique: PyVhjpBjOjeA-91TjYvsRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92FBD185A784;
	Wed, 13 Mar 2024 18:02:04 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.115])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FBE7C04222;
	Wed, 13 Mar 2024 18:01:59 +0000 (UTC)
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
Subject: [PATCH v3 1/4] jump_label,module: Don't alloc static_key_mod for __ro_after_init keys
Date: Wed, 13 Mar 2024 19:01:03 +0100
Message-ID: <20240313180106.2917308-2-vschneid@redhat.com>
In-Reply-To: <20240313180106.2917308-1-vschneid@redhat.com>
References: <20240313180106.2917308-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

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
 include/linux/jump_label.h     |  3 ++
 init/main.c                    |  1 +
 kernel/jump_label.c            | 53 ++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

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
index 7dce08198b133..6fc421b4d5fdb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1412,6 +1412,7 @@ static void mark_readonly(void)
 		 * insecure pages which are W+X.
 		 */
 		rcu_barrier();
+		jump_label_ro();
 		mark_rodata_ro();
 		rodata_test();
 	} else
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8d..7e3e8d1a0fea7 100644
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
@@ -699,6 +748,10 @@ static void jump_label_del_module(struct module *mod)
 		if (within_module((unsigned long)key, mod))
 			continue;
 
+		/* No @jlm allocated because key was sealed at init. */
+		if (static_key_sealed(key))
+			continue;
+
 		/* No memory during module load */
 		if (WARN_ON(!static_key_linked(key)))
 			continue;
-- 
2.43.0


