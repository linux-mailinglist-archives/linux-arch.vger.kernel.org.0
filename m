Return-Path: <linux-arch+bounces-12615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F546AFF925
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1758D5A5B35
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F52BE046;
	Thu, 10 Jul 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhAQ1UTE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDE28F939;
	Thu, 10 Jul 2025 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127265; cv=none; b=A1n0qUQ8mQRWgfmcKq56KZU2uYto6FoKW2/bwO9suTTpbcYdkysW2uTnsb+j4xkBwSCgTRLMr2fZECiSt7ccK0zK8ORKI+1ECy3Q+2ebRQ6gJ6mmPYLg225niqyCLLZj9REZj9QoOtRCgY341xKFmCYbQGcJmK8HlkQjCicrb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127265; c=relaxed/simple;
	bh=qy5FEETkiBvgopjXeebnW8YWe2JigwYRCQH/qWzGYHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xy7RWMYx0fb2c4n3jGvRPg6RfQQ9VqHBsxXUX0oH+i8s3wLaiAifCwJyQFDdlaDx2AjanC2PGVyz7KTO2Vd/ldqYhLAiN2hdHBgdQxdjjeM6XGu0rObdhlhQVQrsK6VnJ0XjLd+1+y1Xj7rZyuIR/K22NylCBzNkO0PbSqvdFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhAQ1UTE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7db39af4d22so68401085a.0;
        Wed, 09 Jul 2025 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127261; x=1752732061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmxZh0kPcuIR00xg4FNk0vUM7gWMjruROudJ19fQk24=;
        b=AhAQ1UTEvFnD97zlYJwNSqq6ob4iClAaUo26NNaw2Gsc4BMU6be+/OfS5IwRjfd0vm
         IMurmTxE/vSIg72LCinGBpzRcJGPRQctKVSqIu36hscckszHq907SKLtHj/43MljkmsN
         9GDHJrZ2hYWCQKScXKs9yT4BSjKgDAtnlIKeduZtwTC7z1CNBdKuF+4g7MAlxS+g5mGj
         CSlnWKrgCVnC/JFkr+TCWcqHdXuSBUU5nRzHRqGzvTrSBeDyZgK0AjqMTVBCF3L/Id4H
         qqXI/qqWwFUVUie3WdT9pMG+gPTGaq5S4aMaaLFzelg/mG/6T7hi4hH7qXnt1iP92NzZ
         Z+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127261; x=1752732061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmxZh0kPcuIR00xg4FNk0vUM7gWMjruROudJ19fQk24=;
        b=NP5Qzd8ppf1YpnDxfvF+qj0g+fth2m45Rl58NYmiP+HLf4sjwMVnjth4pLjUa49lO+
         fCqazz6J6TfPSJ9jcDe6f4qmgzzj1B+cG82wdAtojWzV9isBvihSJVX0hnACChXKs8+n
         P7XIUt0PDpiuC08pNoGT9ANDc6EtZXgkCfbyGloDr/HwPAtpR5l8c0gMihunQ370mkpk
         XmDBsabm2+w+hmgFa0md/AY4LPMJK49Dn/xX4kXeCUb44JwiU31Sd9/jVfpwgg+CHdjc
         lxDzUu4Zh+Fhp10PtLRVKOOsbaTppcQU7L0Efs+5/LbOWZJhJrQKe8/2t21hwt+Zz7R2
         dhMg==
X-Forwarded-Encrypted: i=1; AJvYcCW7dRoxnsL9cXW9R36Frm5e8BXW0SvsfuPLopnzW5IBib+ReqlagjcbeotQhuu1NSY7nSqu6obSm4AF@vger.kernel.org, AJvYcCWHiYVcp2WbR13A6q7GmVxA355Z1uXrd02rVHmCrNM8GIdr2dgBDXnvPOjrqca5Z6nvhP7bD0Wg8I+CNnbEVVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SSe5d55Agnho0eeDBOOOv713+zSgF2QLhCnDBSG12LYIOgyp
	bd67cqpU0WB2Zx2/VCBs7S/KAC7/nHl+1PLjA3Uqc03AG0YwLT+q8E+S
X-Gm-Gg: ASbGncuT+gk5hI24QXKq4bTGQtTL1sX1jH5TpjanyCtq7JlOPr47A/XdaJivH9DJ3lv
	V7yuOtk56VSpPNWYeu7snV9EDj+TKTt4obXml3MqX02SlQAwiCfl42ew1ZQW2h8MJfVxcnEhceX
	l2J41o5fMngTi4I1U5NHOs+YrNuE+cEolI6GE+jbZBGmTo5uIgW7iFC5LMl8jUYgQMUUuiARbqs
	WVDAba6ME8Q12N35TD/oxM0Jj+i+GKPheAjfzy/tuuAcvI0jCmusoJh6iH144hJoHWSdgKWYLgU
	c2EghQ0zBucmPZmdm7Au2RlLclH1Yy+D/vOfKXtg2xoi4YDLv/9GUlbspHF0FfVcvLZXvyPMe0c
	ZpJqhdfjm2jSRSjvApHB4Z+xV8KrVPRsz5zXBAxX0mJFw+TY1rSE/
X-Google-Smtp-Source: AGHT+IE39I/ZCV5JUlSGV91Jhr/jX7eWhRzRc42gnXQJ1OTLx+9pk2H/73JWcJ7f9UbB1XdzHATvDQ==
X-Received: by 2002:a05:620a:47d1:b0:7dd:45dd:e307 with SMTP id af79cd13be357-7dd45dde396mr23579485a.45.1752127260734;
        Wed, 09 Jul 2025 23:01:00 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb25853sm63102185a.2.2025.07.09.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:00 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BE5F3F4006C;
	Thu, 10 Jul 2025 02:00:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 10 Jul 2025 02:00:59 -0400
X-ME-Sender: <xms:G1dvaPjn2jF-n_B7IwWkPdWgSDxFRI7K8DzyHzuxj7lvUEWghhxFNA>
    <xme:G1dvaNrzTBPGz_jaej2-XJ_B8SKYSbd-vVOoDeMNsHIW_4rtsij_Ffh52uwnDxXRm
    hWqiE6QsfmFRQNW8A>
X-ME-Received: <xmr:G1dvaNxZw9cqcI2T_9z_lHlwSLYqPRmmiftK3nvG4SDJl7nIjaum3vf4Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:G1dvaExCsLd-2M05DorKXXFOTVloO6YLMCR-SqhHOAbZ5o1mvpT9yQ>
    <xmx:G1dvaNaYUCHpsHDZiB2ARMqwS5bSmVrPHF5ZwFBgnyasw8QxuRg5Tg>
    <xmx:G1dvaNlgmmGv_YPhvXw5vZ0IkFMW-cP-U5mXlQzH2IyeAo7aZu9FgQ>
    <xmx:G1dvaKETeLXD02I3cvsqd6X4FyeMRdG6AscimYHwrTNUzQfnU1da1w>
    <xmx:G1dvaMhUUhmEQ9Wh6PhZmyq0vSwsvn3F0B42oiUrfaDvZThDP_X0P0M2>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:00:58 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: "Miguel Ojeda" <ojeda@kernel.org>,
	"Alex Gaynor" <alex.gaynor@gmail.com>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Wedson Almeida Filho" <wedsonaf@gmail.com>,
	"Viresh Kumar" <viresh.kumar@linaro.org>,
	"Lyude Paul" <lyude@redhat.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Mitchell Levy" <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping framework
Date: Wed,  9 Jul 2025 23:00:45 -0700
Message-Id: <20250710060052.11955-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250710060052.11955-1-boqun.feng@gmail.com>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for generic atomic implementation. To unify the
implementation of a generic method over `i32` and `i64`, the C side
atomic methods need to be grouped so that in a generic method, they can
be referred as <type>::<method>, otherwise their parameters and return
value are different between `i32` and `i64`, which would require using
`transmute()` to unify the type into a `T`.

Introduce `AtomicImpl` to represent a basic type in Rust that has the
direct mapping to an atomic implementation from C. This trait is sealed,
and currently only `i32` and `i64` impl this.

Further, different methods are put into different `*Ops` trait groups,
and this is for the future when smaller types like `i8`/`i16` are
supported but only with a limited set of API (e.g. only set(), load(),
xchg() and cmpxchg(), no add() or sub() etc).

While the atomic mod is introduced, documentation is also added for
memory models and data races.

Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
my responsiblity on the Rust atomic mod.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS                    |   4 +-
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/atomic.rs     |  19 ++++
 rust/kernel/sync/atomic/ops.rs | 195 +++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/ops.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b8..5eef524975ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3894,7 +3894,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -3903,6 +3903,8 @@ F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
 F:	scripts/atomic/
+F:	rust/kernel/sync/atomic.rs
+F:	rust/kernel/sync/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 36a719015583..b620027e0641 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -10,6 +10,7 @@
 use pin_init;
 
 mod arc;
+pub mod atomic;
 mod condvar;
 pub mod lock;
 mod locked_by;
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
new file mode 100644
index 000000000000..c9c7c3617dd5
--- /dev/null
+++ b/rust/kernel/sync/atomic.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic primitives.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions of
+//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consistency) Model is the
+//! only model for Rust code in kernel, and Rust's own atomics should be avoided.
+//!
+//! # Data races
+//!
+//! [`LKMM`] atomics have different rules regarding data races:
+//!
+//! - A normal write from C side is treated as an atomic write if
+//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
+//! - Mixed-size atomic accesses don't cause data races.
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+
+pub mod ops;
diff --git a/rust/kernel/sync/atomic/ops.rs b/rust/kernel/sync/atomic/ops.rs
new file mode 100644
index 000000000000..da04dd383962
--- /dev/null
+++ b/rust/kernel/sync/atomic/ops.rs
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic implementations.
+//!
+//! Provides 1:1 mapping of atomic implementations.
+
+use crate::bindings::*;
+use crate::macros::paste;
+
+mod private {
+    /// Sealed trait marker to disable customized impls on atomic implementation traits.
+    pub trait Sealed {}
+}
+
+// `i32` and `i64` are only supported atomic implementations.
+impl private::Sealed for i32 {}
+impl private::Sealed for i64 {}
+
+/// A marker trait for types that implement atomic operations with C side primitives.
+///
+/// This trait is sealed, and only types that have directly mapping to the C side atomics should
+/// impl this:
+///
+/// - `i32` maps to `atomic_t`.
+/// - `i64` maps to `atomic64_t`.
+pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {}
+
+// `atomic_t` implements atomic operations on `i32`.
+impl AtomicImpl for i32 {}
+
+// `atomic64_t` implements atomic operations on `i64`.
+impl AtomicImpl for i64 {}
+
+// This macro generates the function signature with given argument list and return type.
+macro_rules! declare_atomic_method {
+    (
+        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            #[doc = concat!("Atomic ", stringify!($func))]
+            #[doc = "# Safety"]
+            #[doc = "- Any pointer passed to the function has to be a valid pointer"]
+            #[doc = "- Accesses must not cause data races per LKMM:"]
+            #[doc = "  - Atomic read racing with normal read, normal write or atomic write is not data race."]
+            #[doc = "  - Atomic write racing with normal read or normal write is data-race, unless the"]
+            #[doc = "    normal accesses are done at C side and considered as immune to data"]
+            #[doc = "    races, e.g. CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC."]
+            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
+        );
+    };
+    (
+        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            declare_atomic_method!(
+                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
+            );
+        );
+
+        declare_atomic_method!(
+            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
+        );
+    };
+    (
+        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        declare_atomic_method!(
+            $func($($arg_sig)*) $(-> $ret)?
+        );
+    }
+}
+
+// This macro generates the function implementation with given argument list and return type, and it
+// will replace "call(...)" expression with "$ctype _ $func" to call the real C function.
+macro_rules! impl_atomic_method {
+    (
+        ($ctype:ident) $func:ident($($arg:ident: $arg_type:ty),*) $(-> $ret:ty)? {
+            call($($c_arg:expr),*)
+        }
+    ) => {
+        paste!(
+            #[inline(always)]
+            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)? {
+                // SAFETY: Per function safety requirement, all pointers are valid, and accesses
+                // won't cause data race per LKMM.
+                unsafe { [< $ctype _ $func >]($($c_arg,)*) }
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)? {
+            call($($arg:tt)*)
+        }
+    ) => {
+        paste!(
+            impl_atomic_method!(
+                ($ctype) [< $func _ $variant >]($($arg_sig)*) $( -> $ret)? {
+                    call($($arg)*)
+            }
+            );
+        );
+        impl_atomic_method!(
+            ($ctype) $func [$($rest)*]($($arg_sig)*) $( -> $ret)? {
+                call($($arg)*)
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[]($($arg_sig:tt)*) $( -> $ret:ty)? {
+            call($($arg:tt)*)
+        }
+    ) => {
+        impl_atomic_method!(
+            ($ctype) $func($($arg_sig)*) $(-> $ret)? {
+                call($($arg)*)
+            }
+        );
+    }
+}
+
+// Delcares $ops trait with methods and implements the trait for `i32` and `i64`.
+macro_rules! declare_and_impl_atomic_methods {
+    ($ops:ident ($doc:literal) {
+        $(
+            $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
+                call($($arg:tt)*)
+            }
+        )*
+    }) => {
+        #[doc = $doc]
+        pub trait $ops: AtomicImpl {
+            $(
+                declare_atomic_method!(
+                    $func[$($variant)*]($($arg_sig)*) $(-> $ret)?
+                );
+            )*
+        }
+
+        impl $ops for i32 {
+            $(
+                impl_atomic_method!(
+                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        call($($arg)*)
+                    }
+                );
+            )*
+        }
+
+        impl $ops for i64 {
+            $(
+                impl_atomic_method!(
+                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        call($($arg)*)
+                    }
+                );
+            )*
+        }
+    }
+}
+
+declare_and_impl_atomic_methods!(
+    AtomicHasBasicOps ("Basic atomic operations") {
+        read[acquire](ptr: *mut Self) -> Self {
+            call(ptr.cast())
+        }
+
+        set[release](ptr: *mut Self, v: Self) {
+            call(ptr.cast(), v)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    AtomicHasXchgOps ("Exchange and compare-and-exchange atomic operations") {
+        xchg[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            call(ptr.cast(), v)
+        }
+
+        try_cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: *mut Self, new: Self) -> bool {
+            call(ptr.cast(), old, new)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    AtomicHasArithmeticOps ("Atomic arithmetic operations") {
+        add[](ptr: *mut Self, v: Self) {
+            call(v, ptr.cast())
+        }
+
+        fetch_add[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            call(v, ptr.cast())
+        }
+    }
+);
-- 
2.39.5 (Apple Git-154)


