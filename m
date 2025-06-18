Return-Path: <linux-arch+bounces-12384-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088E1ADF2F6
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A3A189F84A
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD62F49EB;
	Wed, 18 Jun 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp/TV4jE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68D2F3C2F;
	Wed, 18 Jun 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265386; cv=none; b=VLGd9FQcPmvZeDfrGoGEcoxgHrAMfcLy4WxICwY35sZ5nqNwkLia38jDqch1jcsyBxCwS8SNl5/9HrI994Fnu+8uw2vid6+GWXwjYZyP80b7/lnxZLmeh3UsyDSEm7yb3wvrXAG2+YNdRCPj5vFsAPYfokdyJF70AgT3a6pcCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265386; c=relaxed/simple;
	bh=M1OMjv22fj+u6grhVnfc0b8X9uE9mcPUgP7UW4eovbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3J+0vUCq0nbor29pIMfrtk5/pnKoIsWo6KItEpnORL7kW/NWR88sJ5od0MAFK1GJrK2n+7NQRHSkkkn3iG3dWshT4qLza8LSe/11/h39Ho40gF/vzunlz5+wd4XjNd1jRMh/lxQz1PFw7mZWj12K2/sIgLy61IoTVuAaaqd288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp/TV4jE; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so60506866d6.2;
        Wed, 18 Jun 2025 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265383; x=1750870183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=etVYqiCm1fjHGt42+uzJ+bwpTeWEzpsqqf0LF/x0Vak=;
        b=Pp/TV4jEskwXAktv/HxUZkB44Pnw/3dbvasBUKYw7l82lEP+1mXiystp5cmRxeATwd
         7/so/9r7+WwUtHEqy3T6gUUYyM8B6LuXZmnmKj+Ziv8otdT/2zf35xRD1pLOgNJ+adKW
         Qsp4b9q3Hoeffs4Wm67tv9cTP4lRucg78Ywh7jmjeFOUmVLEcdplsEvCoHcs4h66iG3K
         MGBe26D09E8x/q5+oQyKaP/Ye3hqfJD5sFkfDN0sggobtqllYaJq+QR+mOsGDSI7UERY
         kXETzv9aOypw0+UDp5mplEH9dRSifMQq5qzXIEOnOmRZ7k2yEyi6frM0OZ5msq/yznhU
         GZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265383; x=1750870183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etVYqiCm1fjHGt42+uzJ+bwpTeWEzpsqqf0LF/x0Vak=;
        b=BLP9HkP8RVJDoIl6nxOfPKja+m8TL9M5sFmc1rjemxzroJLWJVppNp/XhLyM6SuMEB
         fUAB7uJB+CE6AOL4TCThP0Yp5FWJJj3gYyt8Msx5zcQ/aaQZ/yrMsP1blNLDLci1cnSe
         Vrf8DXxc/Rg7q04Y3KtTIQNsSKCqSOHDfFY33rz970nIHS2lnIplOzbtykoUfwbnabo6
         tEWLb89udivZFSBQa9aRwKWe5eJ3ZeurvRRXsF6UejM/wQgp+E3enXiIHumRc9bikq1Y
         eeb2hmaE4hTNgX6tnHB+PNRaL1+BYd1WcjPfgT9OWgrlUp96BW68RO7tf2YUe/PqmMDz
         Z2LA==
X-Forwarded-Encrypted: i=1; AJvYcCVPg69yALZgAHr2JMSR0PDne7SZSLX7W68x3Gd5m26bn2z9WnmU1qEpU/F8TItqg8lOFjocH7fV14KV@vger.kernel.org, AJvYcCViTbCXSM/6P60M9AR1Of1uwLouE9J0CM/E3v1feJiyypsXkjI9kyA+JhG/lyvZEB6LnV6CCw6bTf3brWltQio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYoGcRm3R3vE/22ozHCA4r5J8GvsQz5J6myY9poI+VsWXNv1aD
	0sdc5jX9so0drSJkfDkcgSsG0itR9kRIWiKeDuVRuM8u/c8+iN87WRNK
X-Gm-Gg: ASbGncstIYB0x1cCIW4X0i8g1ZAHwmIOyEdyS1vYH6uzrwCgNou7iFEQpRancgkdprm
	JAW8DZTOyfEv7h9zhwfEA+QLjaVvu19CWS9apmAqtf6fwT9MwYYJCgRoiWMvWFzERfHl8hi3MhH
	PDOcmNZYE0p/Y9c2E6tL1y+QjT1Znp9Qm5R+lLOSIU2m9h09QTIqjOeosyDsxm1ELwST3TZRWTk
	1tSQE2Fs1kthFyqT47bEPctxGpbvk56l03MqFo0A8vWc+emSIPpYlC+ANvS3qLX6qN8/nvMRa+4
	kxt1PfBv5JnsJj/dOCilQB+kWZDyR17woneR6a1DfgC7asGd3evWk5wi0MN98qjXgmxE5PgQuAh
	+W/HiRiMVY5xSFcABYEhK+M0WKf8wJWUN1qO9Lfbh1j3k/uYBwL5N
X-Google-Smtp-Source: AGHT+IFQqzW7wOfbqXab4kMODpMgkW6utkQ+Kr95/gp03dKp6mt/gZWwxLm0eqs9K7w2/oYN7eTQPg==
X-Received: by 2002:a05:6214:d02:b0:6fa:ce35:1ab4 with SMTP id 6a1803df08f44-6fb477360a6mr260669576d6.5.1750265382704;
        Wed, 18 Jun 2025 09:49:42 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c42bd9sm75065116d6.84.2025.06.18.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:42 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CB13E1200043;
	Wed, 18 Jun 2025 12:49:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 12:49:41 -0400
X-ME-Sender: <xms:Je5SaL5Ime4tTzAPCn11UHjf1yEfyTIZpPKZHguIBvFofayRAz0Jlw>
    <xme:Je5SaA7JvGny9KQxB5fqlv5wziMKcn7jRS3MXLo4b-1rSqYb5auECtLbATi8ZGQ4x
    yUTHWG7xbXUdiKs7w>
X-ME-Received: <xmr:Je5SaCeHTBYmrIPPPxF7GLAVmpuc-yZRhFThJAHWz45DYjlqa8d-kot52_a3Fw>
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
X-ME-Proxy: <xmx:Je5SaMIB2u5KdsX_61c6WlxEbFUaYZXCPOwDEUYvHVV3Q4tJcrRt9g>
    <xmx:Je5SaPLPgqfeSA89Yp3OyCLHbvL65jsEZpqtSBfc-0a2R4kSjI5wTA>
    <xmx:Je5SaFyShOkeSYqGXpII8i1pORNDHu_6uWPFswCk-_7mV2e23wo23w>
    <xmx:Je5SaLKKXrCXi-jDzmWdeFaxSvR0zjAfLooBiSdJ6NXl1BI4FL9m2A>
    <xmx:Je5SaKbGpUkJXQbc2tONUBwLBJNBYen9WJGhjdCUFempxjduG6QA1m-r>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:41 -0400 (EDT)
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
Subject: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation types
Date: Wed, 18 Jun 2025 09:49:27 -0700
Message-Id: <20250618164934.19817-4-boqun.feng@gmail.com>
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

Preparation for atomic primitives. Instead of a suffix like _acquire, a
method parameter along with the corresponding generic parameter will be
used to specify the ordering of an atomic operations. For example,
atomic load() can be defined as:

	impl<T: ...> Atomic<T> {
	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
	}

and acquire users would do:

	let r = x.load(Acquire);

relaxed users:

	let r = x.load(Relaxed);

doing the following:

	let r = x.load(Release);

will cause a compiler error.

Compared to suffixes, it's easier to tell what ordering variants an
operation has, and it also make it easier to unify the implementation of
all ordering variants in one method via generic. The `IS_RELAXED` and
`TYPE` associate consts are for generic function to pick up the
particular implementation specified by an ordering annotation.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs          |   3 +
 rust/kernel/sync/atomic/ordering.rs | 106 ++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/ordering.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 65e41dba97b7..9fe5d81fc2a9 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -17,3 +17,6 @@
 //! [`LKMM`]: srctree/tools/memory-mode/
 
 pub mod ops;
+pub mod ordering;
+
+pub use ordering::{Acquire, Full, Relaxed, Release};
diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
new file mode 100644
index 000000000000..96757574ed7d
--- /dev/null
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory orderings.
+//!
+//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
+//!
+//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
+//! - [`Full`] means "fully-ordered", that is:
+//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
+//!   - It provides ordering between the annotated operation and all the following memory accesses.
+//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
+//!     accesses.
+//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).
+//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
+//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
+//!   RELATIONS" in [`LKMM`]'s [`explanation`].
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
+
+/// The annotation type for relaxed memory ordering.
+pub struct Relaxed;
+
+/// The annotation type for acquire memory ordering.
+pub struct Acquire;
+
+/// The annotation type for release memory ordering.
+pub struct Release;
+
+/// The annotation type for fully-order memory ordering.
+pub struct Full;
+
+/// Describes the exact memory ordering.
+pub enum OrderingType {
+    /// Relaxed ordering.
+    Relaxed,
+    /// Acquire ordering.
+    Acquire,
+    /// Release ordering.
+    Release,
+    /// Fully-ordered.
+    Full,
+}
+
+mod internal {
+    /// Unit types for ordering annotation.
+    ///
+    /// Sealed trait, can be only implemented inside atomic mod.
+    pub trait OrderingUnit {
+        /// Describes the exact memory ordering.
+        const TYPE: super::OrderingType;
+    }
+}
+
+impl internal::OrderingUnit for Relaxed {
+    const TYPE: OrderingType = OrderingType::Relaxed;
+}
+
+impl internal::OrderingUnit for Acquire {
+    const TYPE: OrderingType = OrderingType::Acquire;
+}
+
+impl internal::OrderingUnit for Release {
+    const TYPE: OrderingType = OrderingType::Release;
+}
+
+impl internal::OrderingUnit for Full {
+    const TYPE: OrderingType = OrderingType::Full;
+}
+
+/// The trait bound for annotating operations that should support all orderings.
+pub trait All: internal::OrderingUnit {}
+
+impl All for Relaxed {}
+impl All for Acquire {}
+impl All for Release {}
+impl All for Full {}
+
+/// The trait bound for operations that only support acquire or relaxed ordering.
+pub trait AcquireOrRelaxed: All {
+    /// Describes whether an ordering is relaxed or not.
+    const IS_RELAXED: bool = false;
+}
+
+impl AcquireOrRelaxed for Acquire {}
+
+impl AcquireOrRelaxed for Relaxed {
+    const IS_RELAXED: bool = true;
+}
+
+/// The trait bound for operations that only support release or relaxed ordering.
+pub trait ReleaseOrRelaxed: All {
+    /// Describes whether an ordering is relaxed or not.
+    const IS_RELAXED: bool = false;
+}
+
+impl ReleaseOrRelaxed for Release {}
+
+impl ReleaseOrRelaxed for Relaxed {
+    const IS_RELAXED: bool = true;
+}
+
+/// The trait bound for operations that only support relaxed ordering.
+pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + All {}
+
+impl RelaxedOnly for Relaxed {}
-- 
2.39.5 (Apple Git-154)


