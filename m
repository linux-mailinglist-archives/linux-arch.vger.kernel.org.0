Return-Path: <linux-arch+bounces-9396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C39F328D
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985177A2D41
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B9206266;
	Mon, 16 Dec 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMQujSz5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qm/1Jdwi"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF900205E33;
	Mon, 16 Dec 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358257; cv=none; b=dXrN2dWAw7fvw4tTfUCVB5iE5IflkT+/AGWCbKxgkzNr3nIrstwn169hVOw0+IUsRNZR/BXkMxzBifchUI9tQRAvSKl5ZMGeLsbWsy2Ss5U4mSsk8WWG0LIJ+X06EgZUzXjTTk/krnH5g/e3DfG4x/bO1mKZDqJwj0sWRik7PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358257; c=relaxed/simple;
	bh=Klz0GewD0ghfBFLK7c5qIVdXa+oTtzdoujgf0ypgqME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTxb0KVtYe8YnmLF5SHHKDKIHRcU3wX1i5sc+Nt85AQGNCrvwim4uPnNmqAkFpdLjk4agTMg0/KLevQpzLAAHo5I1moTyQLzPmt/vS4EJW1TnKfwXqiwlTc56ZeBuDSsYTrXP+PdFslPgItv1gqSjRnjUSYK3xY07+RDGLRqVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMQujSz5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qm/1Jdwi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734358253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSwWjoN9hxq4jHDYryBIZocNpGvXWb/8NjpFHhRy2oo=;
	b=ZMQujSz5tD2kN7+lI0fYpPj98xs+sNfo+W3vBIuWWMNlwpDV/izuo9GkscwMhLkuBG+VwU
	gHcWMsBZi+0oJhgJRxAUYy5qeuKaj3OpwcngqvunDPibOk9ughtlxw6pMuUb6pCV3sFP0Z
	+ARJ8WdZfA7lEkHqX+a58WZSo2329Sf4ZWH/WQT83OraaLzYcppk0aOpV6RYAD5lZFFCM6
	WJhmmmkV6HuSG5f9T1Dv37/9DZ33NYVKdO0fkvbOXx9aGqKVyKsknZEJH9KHiPTtrWK+E6
	INXYArNSQNPlC8uqsma3APkSoos+GlBeVzWuv5mM9ZqC1MYMmGxLAl0UZiWS7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734358253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSwWjoN9hxq4jHDYryBIZocNpGvXWb/8NjpFHhRy2oo=;
	b=qm/1JdwisukCAQ6GVoTkT6wBWxbHH10UkJwsn+dKhsduD9m20Mq0KPz3CVRZZHlB2C11fW
	9Ov67GseUEPV1BDA==
Date: Mon, 16 Dec 2024 15:10:00 +0100
Subject: [PATCH 04/17] vdso: Add generic random data storage
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-vdso-store-rng-v1-4-f7aed1bdb3b2@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
In-Reply-To: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734358247; l=4160;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Klz0GewD0ghfBFLK7c5qIVdXa+oTtzdoujgf0ypgqME=;
 b=thexmYXfp+n2eSvYCtrf5cHaHBiOJId1Zbewgq/CRRe/slaV9CWnriEbx6SMa7+VxZ1s/NRmL
 of3YMYg6mVqBPc5bM65DLHRgkU9CD5Z5/CTZ07zGsAVXWNGT54vKQM2
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the generic vDSO data storage with a page for the random state data.
The random state data is stored in a dedicated page, as the existing
storage page is only meant for time-related, time-namespace-aware data.
This simplifies to access logic to not need to handle time namespaces
anymore and also frees up more space in the time-related page.

In case further generic vDSO data store is required it can be added to
the random state page.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/datapage.h     | 24 ++++++++++++++++++++++++
 lib/vdso_kernel/datastore.c | 14 ++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 69af424413db1f265607d0f1bdbf88550548c5ba..5ce322422fcb7ba77aeafddbf132fd3e5dbc5a0c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -145,8 +145,10 @@ extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")))
 #else
 extern const struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
 extern const struct vdso_time_data vdso_u_timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern const struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
 
 extern struct vdso_time_data *vdso_k_time_data;
+extern struct vdso_rng_data *vdso_k_rng_data;
 #endif
 
 /**
@@ -162,6 +164,7 @@ union vdso_data_store {
 enum vdso_pages {
 	VDSO_TIME_PAGE_OFFSET,
 	VDSO_TIMENS_PAGE_OFFSET,
+	VDSO_RNG_PAGE_OFFSET,
 	VDSO_NR_PAGES
 };
 
@@ -185,6 +188,20 @@ static __always_inline const struct vdso_time_data *__arch_get_vdso_u_timens_dat
 #define __arch_get_timens_vdso_data(vd) __arch_get_vdso_u_timens_data()
 #endif /* CONFIG_TIME_NS */
 
+#ifdef CONFIG_VDSO_GETRANDOM
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
+{
+	return &vdso_u_rng_data;
+}
+#define __arch_get_vdso_rng_data __arch_get_vdso_u_rng_data
+
+static __always_inline struct vdso_rng_data *__arch_get_vdso_k_rng_data(void)
+{
+	return vdso_k_rng_data;
+}
+#define __arch_get_k_vdso_rng_data __arch_get_vdso_k_rng_data
+#endif /* CONFIG_VDSO_GETRANDOM */
+
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
 /*
@@ -211,10 +228,17 @@ static __always_inline const struct vdso_time_data *__arch_get_vdso_u_timens_dat
 #define __vdso_u_timens_data
 #endif
 
+#ifdef CONFIG_VDSO_GETRANDOM
+#define __vdso_u_rng_data	PROVIDE(vdso_u_rng_data = vdso_u_data + 2 * PAGE_SIZE);
+#else
+#define __vdso_u_rng_data
+#endif
+
 #define VDSO_VVAR_SYMS						\
 	PROVIDE(vdso_u_data = . - __VDSO_PAGES * PAGE_SIZE);	\
 	PROVIDE(vdso_u_time_data = vdso_u_data);		\
 	__vdso_u_timens_data					\
+	__vdso_u_rng_data					\
 
 
 #endif /* !__ASSEMBLY__ */
diff --git a/lib/vdso_kernel/datastore.c b/lib/vdso_kernel/datastore.c
index c9cd269b1ed1b6cdd5fdf9fe929d0b778314b962..0d4f5317b508a54b4f3295f0335d1eefce74d78c 100644
--- a/lib/vdso_kernel/datastore.c
+++ b/lib/vdso_kernel/datastore.c
@@ -15,6 +15,15 @@ static union vdso_data_store vdso_time_data_store __page_aligned_data;
 struct vdso_time_data *vdso_k_time_data = vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) == PAGE_SIZE);
 
+#ifdef CONFIG_VDSO_GETRANDOM
+static union {
+	struct vdso_rng_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_rng_data_store __page_aligned_data;
+struct vdso_rng_data *vdso_k_rng_data = &vdso_rng_data_store.data;
+static_assert(sizeof(vdso_rng_data_store) == PAGE_SIZE);
+#endif /* CONFIG_VDSO_GETRANDOM */
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -49,6 +58,11 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			return VM_FAULT_SIGBUS;
 		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
 		break;
+	case VDSO_RNG_PAGE_OFFSET:
+		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+			return VM_FAULT_SIGBUS;
+		pfn = __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
+		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}

-- 
2.47.1


