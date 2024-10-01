Return-Path: <linux-arch+bounces-7516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434FB98BDB0
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D37EB22BD3
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C701C57B4;
	Tue,  1 Oct 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmNZem5J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEB1C57A4
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789440; cv=none; b=bTctvKPOvUBra34stMlzjbaBKjbW4kWMaDDB11nf3sgd8VBcqt25m7zlARbtRPoI1Amce6p015+bsWyWHPgn3Xa6iC8ZSDi0ucZG3SozxupN1Wbla2Teo9Sdco8ZsG59bRaN+7V44hmU7ZaUkjISSicc2Jt+RPrxfvzuDVBHc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789440; c=relaxed/simple;
	bh=tevkgj09OalAKZgQaXHqxVyJ12UyDG/afaB9IjNpmbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKf/7kpRjQmvueDI86G3s40i6Mcq4boFQ3SrsNzg74kT3zvRiNtiA1tjrya5et+MqdbBBllh2h5Kgwbz22gscDL6kkkHE7ssBAcFgbnef+FMTF+iBPqPSEu5gCMVKNFW9JqHahECm/RzhsaaeUruklp4QKKTg4+aW827EpwAL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmNZem5J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e26ba37314so41340147b3.0
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789438; x=1728394238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uK9Ua6p4XY0W7oFZP1bhbr5r14FIpD3VJc8sLYS+srQ=;
        b=FmNZem5JxAatJFQPXTTC0CSVdqtnm6TFGh66U5fHhoMKw04qCFXUyCHdQEBq0Lgk2V
         8NwqvVA/S5CkhY0EAEo7ozaRC5qr/zQso+un0ZvMi4l7SoW9SjlvObb50Iyq3Jk7cCaB
         s4aJBhEL+nqYgLGnKP5IKioZ+GOW1JyXJDVHM4eE5iWWk4ylKn5Nph1XP2hjnqe97v5F
         6Y+5RrzvaXO44XYxoICDHu92ZUk48aCHzVFz9xcMMQqzhpolwsSQrzLCVInHnGIEdJBl
         GQnKrmKZmHRSmarHsbi6JA/mxjZGf+OeFwRZxGG7zIsk68eRB2UeSI0Pb4TBg7l2zzH3
         tn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789438; x=1728394238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uK9Ua6p4XY0W7oFZP1bhbr5r14FIpD3VJc8sLYS+srQ=;
        b=a9HKu2BmVHujAvDthdbFmGen+YSY7ABCdzngWkbEYYq5ccWbvP3gdhiVGyUvV5FAzo
         ZTbCAUWY9EF5xzhU3nfLnbNIwxRXINsyhXPtYNkaI/5AhJTtAxdKULuest5rA1EH+hMv
         iBmvo/h/mWS+4Q6RrtXdaeKaE1BpFY+jw/l5WMfx8q2f2GuYEqC/k1ah6FJAnwGXxUv3
         xzl5nUS/4UV0PFQmMppv4P0F+m0MR/+spm6oH8kdeAlNFqT76swZ0rvuNpjLn27eLLgK
         WluNNxXpAdMO4atAZg6/guqzAoUS7ALpEB3yU6S4qDaJwk9irUEJ66HL2X4t2v9EJ92M
         BIMA==
X-Forwarded-Encrypted: i=1; AJvYcCVTUab9mvhZLBSK+J4xA3+di8sbGHaSRoO6GF3O9b2JtSWu/pFcgZb0EW1GJNeZ0k8iq+yYGJht7HpO@vger.kernel.org
X-Gm-Message-State: AOJu0YxTShfGcN80kv4DuLCSKIT6iXhvE++dDWFBLfhuuWz/igmu0LAU
	gnhBWMeuX0ZWV6uRvq3j0F6hdwP2lfNzJbNUKiLxp1jZ8sM+RCBrVrE34wp79Edn5LJOKmbdS+E
	yr1ng8n3NOM4qrg==
X-Google-Smtp-Source: AGHT+IErH97ZXlD4tIoKA3thsCdHJH2G2pNUVlIr0AE5dq7niJnu55wTopZT9tfYYM/zS3Eb67ZCaVjEjZLfD4o=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:904:0:b0:e1a:97f7:3715 with SMTP id
 3f1490d57ef6-e2604b6eea6mr13252276.6.1727789438182; Tue, 01 Oct 2024 06:30:38
 -0700 (PDT)
Date: Tue, 01 Oct 2024 13:30:00 +0000
In-Reply-To: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001-tracepoint-v9-0-1ad3b7d78acb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4317; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tevkgj09OalAKZgQaXHqxVyJ12UyDG/afaB9IjNpmbE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+/lxOJBJv7omOMsbp/Xd4tFgRoa50P5L5jXEg
 q/9H5708lmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvv5cQAKCRAEWL7uWMY5
 RqSlEACEKv5QTIw+nAQSvSSW6Kpws6OZ6oAyOuZA+duoWU53yOedIOmcS616kIBLvLOJqQ5VR/3
 t4iFWYZkPFMl1gYEfQk9J6jbd20WdIip/QV0Zj/iqarYpZKWZZdfZ7xuhRBngrHVjpQyp+G//Cu
 2flzn3x0yol5SxeMSw/zPDCImqoSDJxf5qO0ug0WcHdWK72vOf0U9UkUeTbB5/CbWT6JWP8xmH5
 aSMWpJqml1bePjZEtR9hRE01LRD6DAYU55A6cwnsSVizAdgHrlIdcCUtNevexZPbfngWgSN5iIB
 lpclIa0KNxZO6XCIph0o/bWhuRxd8Y8z01nFoKbQFccYvcB5heYSMtcr1OOG32qkexg0I5cCmwd
 d9et3EwVRnUGnejQJcanzeN8ta+L/Vy/Ev8lyzRv23CKT94QfUac+Lkm+oOZHISIa6jAIfV+Dz2
 Mf8xnV1UzrsouZ30D13Cs2rPafyQ7nIybwbxL5+zKuVzpYMw6zcJ+u7JIUVSt1krIjmIH3dKNZZ
 sSAQSapkweJqcjTOxOM4hVN4lc8A8pnWqQxUamYrkBQGa5tIlGwbhuLhM87svgn8rqwLfcLp7mQ
 6itQZyogV0FJpRi7cRTONJ/G2htBlFNSSE00b9KRUppypTgwTZUn+yCGkTrq1/PhW0om84OGrWz a3fyXEthwW96hSg==
X-Mailer: b4 0.13.0
Message-ID: <20241001-tracepoint-v9-3-1ad3b7d78acb@google.com>
Subject: [PATCH v9 3/5] rust: samples: add tracepoint to Rust sample
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, loongarch@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This updates the Rust printing sample to invoke a tracepoint. This
ensures that we have a user in-tree from the get-go even though the
patch is being merged before its real user.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 MAINTAINERS                        |  1 +
 include/trace/events/rust_sample.h | 31 +++++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h    |  1 +
 samples/rust/Makefile              |  3 ++-
 samples/rust/rust_print.rs         | 18 ++++++++++++++++++
 samples/rust/rust_print_events.c   |  8 ++++++++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..5995a8982130 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20219,6 +20219,7 @@ C:	zulip://rust-for-linux.zulipchat.com
 P:	https://rust-for-linux.com/contributing
 T:	git https://github.com/Rust-for-Linux/linux.git rust-next
 F:	Documentation/rust/
+F:	include/trace/events/rust_sample.h
 F:	rust/
 F:	samples/rust/
 F:	scripts/*rust*
diff --git a/include/trace/events/rust_sample.h b/include/trace/events/rust_sample.h
new file mode 100644
index 000000000000..dbc80ca2e465
--- /dev/null
+++ b/include/trace/events/rust_sample.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Tracepoints for `samples/rust/rust_print.rs`.
+ *
+ * Copyright (C) 2024 Google, Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rust_sample
+
+#if !defined(_RUST_SAMPLE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _RUST_SAMPLE_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(rust_sample_loaded,
+	TP_PROTO(int magic_number),
+	TP_ARGS(magic_number),
+	TP_STRUCT__entry(
+		__field(int, magic_number)
+	),
+	TP_fast_assign(
+		__entry->magic_number = magic_number;
+	),
+	TP_printk("magic=%d", __entry->magic_number)
+);
+
+#endif /* _RUST_SAMPLE_TRACE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 752572e638a6..b072c197ce9e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -23,6 +23,7 @@
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <trace/events/rust_sample.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..f29280ec4820 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(src)				# needed for trace events
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
-obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o rust_print_events.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
index 6eabb0d79ea3..6d14b08cac1c 100644
--- a/samples/rust/rust_print.rs
+++ b/samples/rust/rust_print.rs
@@ -69,6 +69,8 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
 
         arc_print()?;
 
+        trace::trace_rust_sample_loaded(42);
+
         Ok(RustPrint)
     }
 }
@@ -78,3 +80,19 @@ fn drop(&mut self) {
         pr_info!("Rust printing macros sample (exit)\n");
     }
 }
+
+mod trace {
+    use core::ffi::c_int;
+
+    kernel::declare_trace! {
+        /// # Safety
+        ///
+        /// Always safe to call.
+        unsafe fn rust_sample_loaded(magic: c_int);
+    }
+
+    pub(crate) fn trace_rust_sample_loaded(magic: i32) {
+        // SAFETY: Always safe to call.
+        unsafe { rust_sample_loaded(magic as c_int) }
+    }
+}
diff --git a/samples/rust/rust_print_events.c b/samples/rust/rust_print_events.c
new file mode 100644
index 000000000000..a9169ff0edf1
--- /dev/null
+++ b/samples/rust/rust_print_events.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Google LLC
+ */
+
+#define CREATE_TRACE_POINTS
+#define CREATE_RUST_TRACE_POINTS
+#include <trace/events/rust_sample.h>

-- 
2.46.1.824.gd892dcdcdd-goog


