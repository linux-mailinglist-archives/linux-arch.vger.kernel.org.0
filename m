Return-Path: <linux-arch+bounces-12383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF93FADF2F4
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D23B02E4
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442032F3C36;
	Wed, 18 Jun 2025 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXCfGl3e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0522F2C66;
	Wed, 18 Jun 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265385; cv=none; b=QURXoKZdiK5VPH6xOgSoAFx+Z7rBjZWfVJikj8/wJVbrXLhQSfZ/m3LYif8TQwmYgabpimXqGCR3Vk3Rz3oulW6xaHOXfL8LCMcY1BnsDq8nNAbxpVg3jZv3ILFcAdGjGFyu0EKQzM4oz5I5aQMbhpGQKYBH524qEdWFGdIIqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265385; c=relaxed/simple;
	bh=AcbNXih6+SLDPos2PPF6WDoP/6/w0arT6QDzYz/49c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6EsoGbcKWALzCtHwgzH2yk09En8kx3NcUmJXo/ypbWxXHrBTdelkDfXlB0jxK90kxWGnoNR4RsXYcnLhKV1PJK1ImODFH0BA15X4HGWUp6mQUU52SkApQI97T5E9o6pidgSyvSkf3OUxC6T+DZkJnRoJrfBcI+LWlvwvRBihxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXCfGl3e; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5f720c717so110746085a.0;
        Wed, 18 Jun 2025 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265381; x=1750870181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPTwaPkDamBVCovgIa4GW8UJndUClYPHV9qgoSe03iw=;
        b=mXCfGl3ehMy+jbpZRLNWg3GO93MpC6E1Dvvl/KIAtwOft9+qUDeHM5MWxPcBTvbfzJ
         F9hcrPk0ewDt5BGd4G9yqb6iN14cvtPB+6nDEhlRWYUuq2yDIxFN5LJ4Mio5Xt83xA2t
         fep3djRITrL9mPnoRtG21k3lrj+uRZBzpS+8dorM8ninAxigyAR9T+YPWD5dvRjZJBaG
         H8TenO9EV8UdSgaJcDuKAT+0mcLsv8ON9vUgQifLyLgwhXEBF7/WHVh3AS2PMhoK6sgY
         w1ICxv5LhntMUxyhHbic30YVv6nDrlFYT4SGpzW0VZ9ZiSwxUfZw1yXBTwbzns11XPvd
         /B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265381; x=1750870181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPTwaPkDamBVCovgIa4GW8UJndUClYPHV9qgoSe03iw=;
        b=Zz6b76RQPozLzZU5fzg0Kv7UfuqXpPCKLgMqAm09Z19i64KcS6cVUwJD+VkQPs/o/v
         6qCJEcyMo6ODft5YUGPUMdkjkXEa5204PY9G2wnM08stwE1GJAqIRGXWbIAavxjdZ6cl
         w5lJblgwho3D2vqw7JR9LxGNuY95mRy+qIad1dPwN376hh025x1zu4uazFYOrDFIMEV5
         //Yzmk+oiJGKFZFQEmHBWznWkJvupahR96uI7ZRcvv+syWhnOow7qbh1oic4TFU9n46K
         wgi1XHwFzlHzrJD+MdIJM4pJx1ARTuWST/dNrL1fEc682hXIo8QpzibdcrgAEv4s10uY
         g23w==
X-Forwarded-Encrypted: i=1; AJvYcCU6CHgPYP4QSb0wu+c4FcoGZAuOCTwb3ychVcVGP5O0B85IHbFMi1V4hwKWgN6oQralNWXRDZxOOVpk@vger.kernel.org, AJvYcCXsxY0i7B7NW1nvjZHBIBh2XurMtV+opEMg/ij+N+U77o2Tx7wYCVs/gRHG04VEdPrKAvHoPHOmSmdvrkOPweU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHeSj3I9KMu97noo362LYnLkjsCy1+LV3lPwsxIgQAbZWsOm/4
	Qwzxif/gKxciAZ1ElTHtcAOJmpoeG+FtPAJzfwMXXCrY8F5evVaH+AeK
X-Gm-Gg: ASbGncv6veMpvnKHZ4fYiBtrVJ9UKcCCo0DmrCdh2kOEkSi4KtkLFp0wKbLF5YyXRBt
	8xNyfQYwvQ/hig18/NxQmfoLIp7VOVsvtBo3eBgHwE3DGUDNbGTbqHrsZSwderUzK4hGElA3qQ6
	/tDTzGIPsjPApIImFDOkxGEH/WbvVxuJMYglnSLsLSXAcntViUVKUNeUulefEQt5hzlCqkt1V9r
	Dkx714IJD5wJVNIyPLbKppJI27Q5fjpAJ5b/G4uC2pBDA/PqExCIiLYF9oRM4gS2tulnHd7jYTH
	Xg2AyAU1k0kw0Vv++grats3TngSfFlQpLv5HIEUXbJEj91INj9X7nz+YRKKulMqYEEgP3x0gsDS
	GUZvlu/0vugVqAo4HjU0X2c3DuISBNm02Oj6bUAg12XQ2JqKIW2TX
X-Google-Smtp-Source: AGHT+IEPQI1YzhyDfouqUSY9/sOpo36n4yhM88JIbzy++xd8znNzyOknOUe8IMCJiblaE/xw/9oUUQ==
X-Received: by 2002:a05:620a:3916:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7d3f171a794mr34875685a.24.1750265381319;
        Wed, 18 Jun 2025 09:49:41 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb5a00e61fsm26118376d6.34.2025.06.18.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:41 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6DE111200043;
	Wed, 18 Jun 2025 12:49:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 12:49:40 -0400
X-ME-Sender: <xms:JO5SaMhgOSuWMD-oSXQVYvIQy_yhWq9PT3U7sl18d-Keru9dX5FgpA>
    <xme:JO5SaFABuOSCwtCtw6Mceoy9SrkIsALqVUUBMKgj1VMXlCTzNf5BeS8diJuyr_jHb
    1AHDgxWCgOVUteDeA>
X-ME-Received: <xmr:JO5SaEHHpkBFpPxOXv1HdUJVtzwQXlXGUfJfCzwCRU-0qGeBAgD-DoAlgt-9ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinh
    hugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhu
    nhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:JO5SaNSo1rAnRSKn96XAsLfeZTYS2ja5fkNKqs_i-AOPAe2BqTcs8g>
    <xmx:JO5SaJweyN6mMwwUi8JtdKGps0tbeylvwKN1HIxoVE4Dtn_Xvp5A2Q>
    <xmx:JO5SaL7Ma6ff5EejSz1Nt_pXMezJkKlaG17oIWM5wjxHk0kAxLgtwA>
    <xmx:JO5SaGxynhj19v7OA4wyrQItmK-9sHZpwEPjJLpMdo-waQqULPIUvA>
    <xmx:JO5SaNiMhAIDwn88zRPGCXb8a7ByJBFdNihvwLkTiVExCAN1xJdZB-JG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:39 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
Subject: [PATCH v5 02/10] rust: sync: Add basic atomic operation mapping framework
Date: Wed, 18 Jun 2025 09:49:26 -0700
Message-Id: <20250618164934.19817-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250618164934.19817-1-boqun.feng@gmail.com>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
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

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS                    |   4 +-
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/atomic.rs     |  19 ++++
 rust/kernel/sync/atomic/ops.rs | 199 +++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+), 1 deletion(-)
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
index 000000000000..65e41dba97b7
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
+//! [`LKMM`]: srctree/tools/memory-mode/
+
+pub mod ops;
diff --git a/rust/kernel/sync/atomic/ops.rs b/rust/kernel/sync/atomic/ops.rs
new file mode 100644
index 000000000000..f8825f7c84f0
--- /dev/null
+++ b/rust/kernel/sync/atomic/ops.rs
@@ -0,0 +1,199 @@
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
+            call(ptr as *mut _)
+        }
+
+        set[release](ptr: *mut Self, v: Self) {
+            call(ptr as *mut _, v)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    AtomicHasXchgOps ("Exchange and compare-and-exchange atomic operations") {
+        xchg[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            call(ptr as *mut _, v)
+        }
+
+        cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: Self, new: Self) -> Self {
+            call(ptr as *mut _, old, new)
+        }
+
+        try_cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: *mut Self, new: Self) -> bool {
+            call(ptr as *mut _, old, new)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    AtomicHasArithmeticOps ("Atomic arithmetic operations") {
+        add[](ptr: *mut Self, v: Self) {
+            call(v, ptr as *mut _)
+        }
+
+        fetch_add[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            call(v, ptr as *mut _)
+        }
+    }
+);
-- 
2.39.5 (Apple Git-154)


