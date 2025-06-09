Return-Path: <linux-arch+bounces-12298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04979AD298F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB853AD2A8
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE2225A38;
	Mon,  9 Jun 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAYXwLJb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C62253F9;
	Mon,  9 Jun 2025 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509198; cv=none; b=q75ycEmzss2MTIntw2bq25BtmnLurKi4w2LavXHvRuYgn0pyW2yIKpxOSpMEreA1RrEztgpw7USHm93u/q/7CECTg4AQd8yezglW5jSgmX7G0eonN9k0kvHKZOZpAQoJ93WjdxiEjUwAxSEPr3qLHfXL91q79IsvcjY00wdhDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509198; c=relaxed/simple;
	bh=Bbfnlmdb7pL1AZNSDTylkcETam08CHqt13It1u6xVzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+TEQDcLXskAlIa7Nx7ciFJmQUtLfIam0swazVMCQXenWb/g5Vf4aWvCc5xF1WjYTLeIGWEIIEHbKZofXHoddXuIRW1nivEuOAxo2eCYDDztytqKdwdyD7hGIGErevjUDkpTkkNNcpCKvdP6uMe+1dOMB6RyscVarlHBG2gbSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAYXwLJb; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fabb948e5aso51818586d6.1;
        Mon, 09 Jun 2025 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509196; x=1750113996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XHGo75oqWDF4T9zmnZXRrh82GOdxct6o5A5IyIi3k28=;
        b=DAYXwLJb58CbGGBMhQlrP7ePhVeK0Iyti7QlHUJcu0wu4gJp+57HvyZbVr/YfoLHen
         0rsdlpM0PyoGL1bJOBqyvtCz1aHKNPQVCpEYNsQykxXJSjGleeISoO2jnnlDlX5NuLZa
         CbASm1axWxhelLkGmyxYL+jmCp3yUQnTkTVr2LLvErXPx2pf0nmlg7sJm9B9rK7rasmm
         YMd3NCYxvszr/FV/7qZuLXhNBYj6dlkCZaRs3nMld1os3d6SgAYS/vFl+gi7940yzDXW
         +U1T6y3YrRPWPYQmSraKVn5xPgGqwRM4g/FR+N7B/YtVogk4zazAiswLFpbFSa0IPEXy
         zg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509196; x=1750113996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHGo75oqWDF4T9zmnZXRrh82GOdxct6o5A5IyIi3k28=;
        b=veluu5kJ6WoCcqHvYFNBZJeX9rFent4Dc7DuFUl8OkzaZZesVGPR7a7NDN3rLMpVOg
         ol1FELpcvL3eu6Vs+oAz+S30B3JymHouTmyz/xYi9qZ6GCjqYJ/t2kP3KNs8wr0lZHRs
         383x+UFhWN5Ttrw9TgEYHJtEw8l+BhWYeSl7u3FpmY+n50QcnLZdl9tBnbX/cDlbrbz7
         nmxVF4xcILWpBPf+p/QEu+K0WKcS9Ry4xQkZz7YmCWHcg+i3TcQx6yYtSuANF3+EAA64
         KMr95GWnnQhDhAM+ugHU8+5pW0TbPscpWZMfaeRAyhG9s5ji0/UBfQmXGZwrMwtmrnmb
         FQkg==
X-Forwarded-Encrypted: i=1; AJvYcCVlZeNBqge2st+RGMof9WfL4nmPcok6ms0B7RGHa16tVXDMSz12smUqZAm/rapYhNRCnMzwTq191Zvq@vger.kernel.org, AJvYcCXApFcQefJMBt5YaGJ9nx9yRpIBCMT+RDKNaKjTDlpFbBDXsesPPiPxnpAHVxWo2BzAoap0ocsfSt5Z9YPPJCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3j20rNSAOkk53QjXbcVoHT7gtGv+nCZZ1iccH5VyR5Ha8wwv
	H07CCuT7ni3aEkdRetSGqmRLO+4nbQIdT6IxeP5Viip/8DgjprETyJvs
X-Gm-Gg: ASbGncs03eNg1YjobDA9le+WzsgtBMLpcpfy0zLxxr/vBbZf4QszEJ0JcZvxEKRf+iM
	+oJYVsSdLkynp3HthvHWbMelFTvhTm9molW9ujov7676zaSpRcOSFlU+13Vb1EmJaxBBeIaNTF3
	BojePhDlK/Gr9BbnYzO5baJaRLqf/P85DSWv8a7UDBJwlD3idHYS6iWrE50rzBSeNgsuImm5x9P
	QjVoje+ticjblgwFdcUSfo/slBGBTmsPOD8VeoI8sYOPaMlpseKCF1WUrmVAOlR0hHmYsBUJbIb
	Ulp8TkcrMzJefiMavpSUcrQJhylhO+u8sUJt+sKI+kH26mw8uK1mKeZQvVf5OCTEeifA4Geb2yc
	wYORolP2OzG/hWOeO1Kd2EbahK7/1Kh8eIS++1yd1ZaFIXBp8h/FO
X-Google-Smtp-Source: AGHT+IEHZ/kRtadcmXuePllJAmx0hwL8ujRB9dvF1LyUXLFoSEgcYIZK/sbnIBWDSvTFQe4D5gZiQQ==
X-Received: by 2002:a05:6214:c6c:b0:6fa:c6e6:11f9 with SMTP id 6a1803df08f44-6fb08fdc77amr229218096d6.11.1749509195528;
        Mon, 09 Jun 2025 15:46:35 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38de859casm332802785a.38.2025.06.09.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:35 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82F531200043;
	Mon,  9 Jun 2025 18:46:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Jun 2025 18:46:34 -0400
X-ME-Sender: <xms:SmRHaCoywDP55nT_NC7nMyTQdPMF1IC3fiB1pV1g0w9-kHcPmUvsWw>
    <xme:SmRHaAo0laigSqR4cp1_V_0QUpYB4ZHSqIN13pH15gCelhyXe6NJswuaQBcAsmOhM
    Ud_F-W2YMJ5ocb5Jw>
X-ME-Received: <xmr:SmRHaHN84HAnq6-nmbfvmyOytdVZ2dkvspSGdmbppq9jc0-TOdYQKF3NTBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:SmRHaB67S3gx1opGCjquYIsY3gJ0cVfNdwnDmlJvIH3uryCevGvWyg>
    <xmx:SmRHaB5kRwIj4Sj7sv0as5l4iB6_tpEYySnevuMR71aJGzo6pDQxOw>
    <xmx:SmRHaBgx5-xv82yIApAyf9Q_5QU3LS-oGuqo6-AxM4-oiKyzBnNvOA>
    <xmx:SmRHaL4ISRkjzEpwOg0u5P_xZ7H5NXTMkSwy38RdrOUkWhYlOOgF_w>
    <xmx:SmRHaMI5zD2lW61iB9tXlT3BUWZTm1w7f3-x_i3m5U4h3N4f3XYeEZiY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:34 -0400 (EDT)
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
Subject: [PATCH v4 02/10] rust: sync: Add basic atomic operation mapping framework
Date: Mon,  9 Jun 2025 15:46:07 -0700
Message-Id: <20250609224615.27061-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250609224615.27061-1-boqun.feng@gmail.com>
References: <20250609224615.27061-1-boqun.feng@gmail.com>
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
index a92290fffa16..fe0cf0a2e6e5 100644
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


