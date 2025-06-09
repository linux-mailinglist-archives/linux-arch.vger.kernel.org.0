Return-Path: <linux-arch+bounces-12299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF166AD2993
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8191891A29
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1476227B95;
	Mon,  9 Jun 2025 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg/FW/4W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AF223DC5;
	Mon,  9 Jun 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509200; cv=none; b=oN81fSs1GfEQVpsixAX2+cOizXZqzPPrUlNfQnU1VTUsqSeDmz2OgYamr/sXEXBNEf0an75srj0E04UyqTh8balofscYWFz4Z/tQwOCFjxn/vVmEFsEtoWqjail1rld0Baewae9S4S4+zUccFN755WuJ3miOFwPSi+XmKDFVsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509200; c=relaxed/simple;
	bh=0bInjRe6WsElsR76wx5HxxQl5ek7EdEBeQSHoOJJMSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eq27GMFx3e17vcpoKAGSAqzzWcUzCOFp2cX5cXzEnP3LgMzdWMl0BsX+QfqN82E3YrXuwStbqTfgqO81DjTzcuDV+i/RyL1gkcYcyZDb+oe56e7MwyaAM6x9zaxahjULXa5bvxiruFATdmBPB/a28f9W4w8GtCp8X7Wl5UQEUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg/FW/4W; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d38ddc198eso207317185a.1;
        Mon, 09 Jun 2025 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509197; x=1750113997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iocCkfb+nHX+01sle1IC4FFymsCULZeQmkzsDFnCdV8=;
        b=Sg/FW/4W46umMHAhLQIGxuMLeYa3g9z24l4r4MshBzVlHJZFfbSaeoJlnYPYSqSZ/v
         rrgiuRrJyqBZh5EYWR8l60TiKBJjaiC397Y3c5c/o6Q/gg0ltVu3I1yv2CaIFDa1EAbt
         tOEOpEutPgM5XPH1tkEZmk7JCsLbwuxENZA3p+FnvnRCAPH7i1NzfNZihRjA9C8xneHG
         DWqg+fsTA5hnON2ctKE24RDHfaOUrTiwsPmVU/USwkSKNrrU6Nvuglgp8bSMxYrsC/Kr
         JASn0Eq9Qo3jI311OhUbEKyJ+PZVPP2SDJXtCw1HXhcFQRgnkXQOLhLtWeeKC53ggq+O
         099A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509197; x=1750113997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iocCkfb+nHX+01sle1IC4FFymsCULZeQmkzsDFnCdV8=;
        b=UqbyUNDv6EyRr5n5mwVZwjKcyfzf1pakfWmjH05fc1OMpfUqquvNeaCK205wIt89l+
         RHlasgF9u1sn0eICXsmNtk2agQllv8A9+iq3xaM+njWale4cg70+kk7qw8155buXRcj3
         hdmfOo5iE30awvfF8tjgGwYOy14j6BYw8C9sYCSxi527gm7SIkKMYhlFKLv+ZdhNtt4/
         q9R0FoKeZ992tP4nFZuC5UtwBWXJFJImzQmxS9Ln0w7TOrzPPsnaeUXyEySR4Xxjxik3
         jJorjYMP8vfKNkvdzlQCjdKJeA4Dw7S3oEp90JKcJ7HT7OfVBCAnjQA9TVZUEKqsLaWs
         3akA==
X-Forwarded-Encrypted: i=1; AJvYcCWwgEPKY2g+ZFcVC6oeNn3fCKkP3mrKZW55gO3psZLC973YnjKh92HF0HuEjkM0qySSrXcRiGF5nhYA+iBERhw=@vger.kernel.org, AJvYcCXH/lYqXrNRyHpCwonxPA/B4rC25rIsDTQ4kv/QU3Fe23wlTS8fUr0fSgJZqlojQylWzronZx2aBrCT@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGG2elB+YwARLCbX2qAYbx2o8ufkbMGaat5L0pBr7wJ4Bjso8
	AUadPJ/Vcq9CyYDaF65ugTycflRj1TW8YWCtSdvtjgQP8CBLX83bgPtm
X-Gm-Gg: ASbGncu6orcEg8FByVdSx+OJsetjqe/OOYoVcrFTFbEdjXI2BSwdnnmteu8gX466NtM
	lK3ecm5cJoSUByXoYkKe7ShAjtUq4vpiW6Lk4faPi/zauWw1zvqvScsiiZubU9Dy+pHuJxm4DCz
	gcLG6vZ5m+7ds7gwI9gTrRI8Jq9qtUSivsIGFcMLtRy1brdXD7bd9cMCqVXzuDpwYBrNmlQJ1lo
	YDmUOfuWTJhGQif4ZA/sDtWqTyW8ndBsjoBCUPfoGap0rq6esRy1JJyxAoOm1WoEqxoJOZs1uRh
	tBUUPh2FTLIjLJWkMd/Ya11N1tkRtyfqTE9ESS9Cw9IXqWtVQcbEGAOr+p5fv/MnZeKOTGh15ur
	QJ9UMxkR+18N0GuR3GVkIoYuUA+CRH+GIGvbB9lSEtDg/6hKV7R8nKjkljMGrWd8=
X-Google-Smtp-Source: AGHT+IFntFkNxx24CgiS118e5vZlr/FBZTsgX2Ln2DccFMO21mlALdHdkwVTMB4EKfRtDA/OFpbY0Q==
X-Received: by 2002:a05:620a:3726:b0:7ca:cd71:2bf8 with SMTP id af79cd13be357-7d2299339d3mr2562207085a.54.1749509197486;
        Mon, 09 Jun 2025 15:46:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a536b91sm597967385a.32.2025.06.09.15.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:36 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id E3EF91200043;
	Mon,  9 Jun 2025 18:46:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 09 Jun 2025 18:46:35 -0400
X-ME-Sender: <xms:S2RHaAv4npj3y2FfDkQ2-4j-c583mzRTVC4hdJym7aju215mluA2Pg>
    <xme:S2RHaNeao0rodrRNcspFdp3ejoNu7TgIsDeOMOcpupvOJfG30CslTo6uz6yFg6M2Y
    wlUO925ttmK3l7Nwg>
X-ME-Received: <xmr:S2RHaLxvWuykGoodmNf8XcD5GfMd3UC9rEoY5k-5ARsyEsm6AXY93dKV6Yw>
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
X-ME-Proxy: <xmx:S2RHaDPnFzGKrMPBb5Mf83MOmBIWfccBL8BilGJBcrz2bL5-s2lw6w>
    <xmx:S2RHaA8HLfqGS4fAFwI1Qvgf7caRQ9pxY-JiNce966ZpBCmWFqbVyA>
    <xmx:S2RHaLUXPv5c5CSdbGU6IIwYyntsBB4xCRLYBKmQWGtUETwdZFEgDQ>
    <xmx:S2RHaJdHNk1oUhcQ-zyTfLUtwJAaUnHHJzHkR3ygaW88v3wKJhaQZg>
    <xmx:S2RHaCfyUp5ArtuwvccjxU0RhZjl77WM2tI8mdIV-mIOBBaT6ZeS5EZ4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:35 -0400 (EDT)
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
Subject: [PATCH v4 03/10] rust: sync: atomic: Add ordering annotation types
Date: Mon,  9 Jun 2025 15:46:08 -0700
Message-Id: <20250609224615.27061-4-boqun.feng@gmail.com>
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
`ORDER` associate consts are for generic function to pick up the
particular implementation specified by an ordering annotation.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs          |  3 +
 rust/kernel/sync/atomic/ordering.rs | 94 +++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
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
index 000000000000..14cda8c5d1b1
--- /dev/null
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -0,0 +1,94 @@
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
+/// The trait bound for operations that only support relaxed ordering.
+pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + All {}
+
+impl RelaxedOnly for Relaxed {}
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
+/// Describes the exact memory ordering of an `impl` [`All`].
+pub enum OrderingDesc {
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
+/// The trait bound for annotating operations that should support all orderings.
+pub trait All {
+    /// Describes the exact memory ordering.
+    const ORDER: OrderingDesc;
+}
+
+impl All for Relaxed {
+    const ORDER: OrderingDesc = OrderingDesc::Relaxed;
+}
+
+impl All for Acquire {
+    const ORDER: OrderingDesc = OrderingDesc::Acquire;
+}
+
+impl All for Release {
+    const ORDER: OrderingDesc = OrderingDesc::Release;
+}
+
+impl All for Full {
+    const ORDER: OrderingDesc = OrderingDesc::Full;
+}
-- 
2.39.5 (Apple Git-154)


