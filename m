Return-Path: <linux-arch+bounces-12724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EAB035F8
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBA63B6D5F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC7220685;
	Mon, 14 Jul 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5PFREYY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3B217F55;
	Mon, 14 Jul 2025 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471433; cv=none; b=j1fqvjv6abM0QVOMzGA0fddD8G1eVVpWRc5EI4asxeJPJNCGwqeFgdfpBZZhINwPlh1qGewxuImuxc0+k6S1ascbg5APE8y472WiBZMlXzTXpYQ5mC1+IPSFQKENqv3hwnTTuz4mT+0xIz8dYwkZ6sJzGwRhwzJKvRr5TTjLWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471433; c=relaxed/simple;
	bh=4BQnBfjc/LwIW7eyCMKZeLLL1VQCGahjf8Z4myRD0uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+kzycfp5iKxOXGx8XPkDw6HgK14qFo1d68S9tc9i5TJz5M9XDDX60Iqsm5iGo6S8u5BXSF19HwRTG4WEaiKyNkk/iSi7uii9XDHOtFms4gFcGzppdUkApeZrwA9OxomBcGvgGjJNQGD0y1cBzO8TQxheqW/kySphXpUac4Y/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5PFREYY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6faf66905adso23743266d6.2;
        Sun, 13 Jul 2025 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471429; x=1753076229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dNcoDZr/aAe6eSq6ohwKrUFKjFwcgrYkPqbuZXs/X3s=;
        b=V5PFREYYc9SVDcigLZtNZR4ZmBDajXVQTr3sb8tFBJMt/ZzJ4ubZgZcLeWFcuxbiaL
         xNLnj8dHBY7XGj78Nk4AkbunFoDFaFheM3y85Qt0A6zLxEjtPSTl9yapUYvnP3zKfl0p
         GFMOsw4jfpd13mlCiFWwvthu+hIm5fSpREgtdTT9OH/wdjbJ2wX8xVfQIC9bvbpaa5ZS
         o4sVKz7v4ywZuQTZaVOe96S7Sooyp/JMkzx0IFNoPmj4LVkKawNi1+K9IrIqYybhP9Rp
         TLdI43oldODLxgKXrU3Ht3krx90rX02zPiDO+Yids7C39BKA+D5CbAXqyRnWSVhTQzwk
         G+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471429; x=1753076229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNcoDZr/aAe6eSq6ohwKrUFKjFwcgrYkPqbuZXs/X3s=;
        b=CiSvRlScnYnaCCLKNfiB8T5DB8uzFxNz0evNa7e8UNHSUlBaoZ7oU9vXZohsqTZ9jz
         PATFRPRCmLVUdXgO3Ho4/wKttPYFJrbXKdBx8gmHsR2KyGy5ba6b1ool5iqOXcrUKfoz
         GqoKQft22cSPxxGy0gpbo24hSNqKZnCdNhngdad+zBvsd+UpCGxjpLqYTdzAOzJYKx8/
         vtz7d7CPATJkk9Q39Gmn4OWxDMrylwhhTAw3lrewu+3Of5jzNjYGz2eiu72Q1M2FHhwD
         /4CxO7tgJcTpmHXWYoI3Dq0xEx7jeuV7ZnRFAQTy0IBp4BQab0r7lWsXKTRYMDec7NS/
         klRA==
X-Forwarded-Encrypted: i=1; AJvYcCV5t7/ni3Jflley2svd/kiXn+bT0ISpQ4bNKryAihs1lQyQ4DziDm+16km4PbTD1pX8hSEAd+ex3WFW/Dw9++4=@vger.kernel.org, AJvYcCVteYtj0DnA/E0M9ZSeOfN9qSjTJA35HW9P5oH/xofMgCNiq3YBc+k9+l2TBGT+nnrj70i7VsrqrRnR@vger.kernel.org
X-Gm-Message-State: AOJu0YzulWsyqwnEiaTjNafh4M61tirw3b2RQpyZXxC5uIUdQMpzKLjW
	MkHqxLqpurBoxvwAFl25JfN1P5zzwA+B2igf4/ug/H4FoTW52wQzdMO4
X-Gm-Gg: ASbGnct03Wtsn02UJgYu88tkaOYnGaYwgtT4Annv0mCSSA1YZZglk1l7bkKFXTlVgut
	Qi4tpBTQNMYMXbNlC5Ic6GNuZ68rumoCzK1zEoP2bc4pdYiQf6qMAk8jBfDcU3v8EyH1SvH4e9h
	5fcdZpd6va89sOqUOICnQluFaOJ2eiiVQE+rMVHdFMjKnq7fzxc3wlCtxQDXV3nPVj78xp6anew
	9ohTOSdpRgKVL4T27NA+jvfA6U798hT86DSwQQivS8OOpiebg684VVNOb+85a+zJKW+q4lGtad5
	uXBaoNyYEkx4UBFONKdRIHDk35/aV46KGCWjn3ctixpPblKYxyf7scaCFsU5aBOOgSaiSVGnEsB
	ceAuovM9SUFqKZOqaSoZuDmMMU8vW0OKAYBOgMY2PbRjsg8ftA5PDFO2Vx71iMNDSkdHP+Vq91H
	exkU9biqxSwjg1
X-Google-Smtp-Source: AGHT+IFZPQ7KVRBfbu0kUDAqM/ngOVoZkYjch+APC3tJM933WyE5ntRgzw8FfbOgKIbHwyjJCW7JVg==
X-Received: by 2002:a05:6214:2482:b0:6fd:1b0f:8b93 with SMTP id 6a1803df08f44-704a42d7ccdmr191010506d6.33.1752471429081;
        Sun, 13 Jul 2025 22:37:09 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39421sm43489896d6.69.2025.07.13.22.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:08 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 104CFF40066;
	Mon, 14 Jul 2025 01:37:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Jul 2025 01:37:08 -0400
X-ME-Sender: <xms:g5d0aKznx8mDzo9wUe89b8XSkqeuvLzhp-5uWV7FNzzjun1uN_YZzw>
    <xme:g5d0aH6L4YKkZimeLuNzDt1phB7IB1L7i_hSZXL-GOpp3hKByXFpUxSK1PbtuXMFI
    adzp3k5-ieb5ct6Cw>
X-ME-Received: <xmr:g5d0aLBCdd3nxoQ2kKki8HeJvQxtmGqaK9FprUtd4GEZ6pXFEbPLtOSuBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:g5d0aJDcDnfZZHzSHVcVzjSFMiULgbAmTe5MuNSTeTSPNkbbTbKNOQ>
    <xmx:hJd0aMpf4ckrP7xPsjXXJhmmsiax5HgGwQ73dK_0Vd2Kn8ggiShnpA>
    <xmx:hJd0aL1O7jqu4I5cQFBbAP5r5Cef6tLiqkVMrJKr9VAu_74Cs-q2uQ>
    <xmx:hJd0aLU1H6z48hhs3rlu9gxN_jBXqF88eO_qBDituYphFsBksucCyQ>
    <xmx:hJd0aEzPiQnv6mwxWtI16qsxTC7rHkypuJQuuW_2NzWBw2M2MxrO3kdQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:07 -0400 (EDT)
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
Subject: [PATCH v7 2/9] rust: sync: Add basic atomic operation mapping framework
Date: Sun, 13 Jul 2025 22:36:49 -0700
Message-Id: <20250714053656.66712-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714053656.66712-1-boqun.feng@gmail.com>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
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
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Benno, I actually followed your suggestion and put the safety
requirement inline, and also I realized I don't need to mention about
data race, because no data race is an implied safety requirement. Note
that macro-wise, I forced only #[doc] attributes can be put before
`unsafe fn ..` because this is the only usage, and I don't think it's
likely we want to support other attributes. We can always add them
later.

 MAINTAINERS                    |   4 +-
 rust/kernel/sync.rs            |   1 +
 rust/kernel/sync/atomic.rs     |  19 +++
 rust/kernel/sync/atomic/ops.rs | 265 +++++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)
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
index 000000000000..1353dc748ef9
--- /dev/null
+++ b/rust/kernel/sync/atomic/ops.rs
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic implementations.
+//!
+//! Provides 1:1 mapping of atomic implementations.
+
+use crate::bindings;
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
+pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
+    /// The type of the delta in arithmetic or logical operations.
+    ///
+    /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually it's the same type of
+    /// [`Self`], but it may be different for the atomic pointer type.
+    type Delta;
+}
+
+// `atomic_t` implements atomic operations on `i32`.
+impl AtomicImpl for i32 {
+    type Delta = Self;
+}
+
+// `atomic64_t` implements atomic operations on `i64`.
+impl AtomicImpl for i64 {
+    type Delta = Self;
+}
+
+// This macro generates the function signature with given argument list and return type.
+macro_rules! declare_atomic_method {
+    (
+        $(#[doc=$doc:expr])*
+        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            $(#[doc = $doc])*
+            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
+        );
+    };
+    (
+        $(#[doc=$doc:expr])*
+        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            declare_atomic_method!(
+                $(#[doc = $doc])*
+                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
+            );
+        );
+
+        declare_atomic_method!(
+            $(#[doc = $doc])*
+            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
+        );
+    };
+    (
+        $(#[doc=$doc:expr])*
+        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        declare_atomic_method!(
+            $(#[doc = $doc])*
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
+                // SAFETY: Per function safety requirement, all pointers are aligned and valid, and
+                // accesses won't cause data race per LKMM.
+                unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
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
+    ($(#[$attr:meta])* pub trait $ops:ident {
+        $(
+            $(#[doc=$doc:expr])*
+            unsafe fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
+                bindings::#call($($arg:tt)*)
+            }
+        )*
+    }) => {
+        $(#[$attr])*
+        pub trait $ops: AtomicImpl {
+            $(
+                declare_atomic_method!(
+                    $(#[doc=$doc])*
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
+    /// Basic atomic operations
+    pub trait AtomicHasBasicOps {
+        /// Atomic read (load).
+        ///
+        /// # Safety
+        /// - `ptr` is aligned to [`align_of::<Self>()`].
+        /// - `ptr` is valid for reads.
+        ///
+        /// [`align_of::<Self>()`]: core::mem::align_of
+        unsafe fn read[acquire](ptr: *mut Self) -> Self {
+            bindings::#call(ptr.cast())
+        }
+
+        /// Atomic set (store).
+        ///
+        /// # Safety
+        /// - `ptr` is aligned to [`align_of::<Self>()`].
+        /// - `ptr` is valid for writes.
+        ///
+        /// [`align_of::<Self>()`]: core::mem::align_of
+        unsafe fn set[release](ptr: *mut Self, v: Self) {
+            bindings::#call(ptr.cast(), v)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    /// Exchange and compare-and-exchange atomic operations
+    pub trait AtomicHasXchgOps {
+        /// Atomic exchange.
+        ///
+        /// Atomically updates `*ptr` to `v` and returns the old value.
+        ///
+        /// # Safety
+        /// - `ptr` is aligned to [`align_of::<Self>()`].
+        /// - `ptr` is valid for reads and writes.
+        ///
+        /// [`align_of::<Self>()`]: core::mem::align_of
+        unsafe fn xchg[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self {
+            bindings::#call(ptr.cast(), v)
+        }
+
+        /// Atomic compare and exchange.
+        ///
+        /// If `*ptr` == `*old`, atomically updates `*ptr` to `new`. Otherwise, `*ptr` is not
+        /// modified, `*old` is updated to the current value of `*ptr`.
+        ///
+        /// Return `true` if the update of `*ptr` occured, `false` otherwise.
+        ///
+        /// # Safety
+        /// - `ptr` is aligned to [`align_of::<Self>()`].
+        /// - `ptr` is valid for reads and writes.
+        /// - `old` is aligned to [`align_of::<Self>()`].
+        /// - `old` is valid for reads and writes.
+        ///
+        /// [`align_of::<Self>()`]: core::mem::align_of
+        unsafe fn try_cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: *mut Self, new: Self) -> bool {
+            bindings::#call(ptr.cast(), old, new)
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    /// Atomic arithmetic operations
+    pub trait AtomicHasArithmeticOps {
+        /// Atomic add (wrapping).
+        ///
+        /// Atomically updates `*ptr` to `(*ptr).wrapping_add(v)`.
+        ///
+        /// # Safety
+        /// - `ptr` is aligned to `align_of::<Self>()`.
+        /// - `ptr` is valid for reads and writes.
+        ///
+        /// [`align_of::<Self>()`]: core::mem::align_of
+        unsafe fn add[](ptr: *mut Self, v: Self::Delta) {
+            bindings::#call(v, ptr.cast())
+        }
+
+        /// Atomic fetch and add (wrapping).
+        ///
+        /// Atomically updates `*ptr` to `(*ptr).wrapping_add(v)`, and returns the value of `*ptr`
+        /// before the update.
+        ///
+        /// # Safety
+        /// - `ptr` is aligned to `align_of::<Self>()`.
+        /// - `ptr` is valid for reads and writes.
+        ///
+        /// [`align_of::<Self>()`]: core::mem::align_of
+        unsafe fn fetch_add[acquire, release, relaxed](ptr: *mut Self, v: Self::Delta) -> Self {
+            bindings::#call(v, ptr.cast())
+        }
+    }
+);
-- 
2.39.5 (Apple Git-154)


