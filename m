Return-Path: <linux-arch+bounces-12616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F591AFF92B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0015A58C3
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C02BEFF5;
	Thu, 10 Jul 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmAXtAuV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A129CB3C;
	Thu, 10 Jul 2025 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127267; cv=none; b=quAG0FZndDTzWpRTRAf72dPS/dXJMqiTNIy2jgg5R3QvZOX04lSEsY+k57P/mpAoQdvOGnWMkNsfyMALBwYSNyaqT/uOWit5Rn/SMKybbIulKc5MK1pHyBHux6Gw4biUzpVajvXFAHSZrKAiRUEwy72+IRxSk+HYdXfSjVf3/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127267; c=relaxed/simple;
	bh=AofuJkxBhjDiz8NtTL9ENppPKcq3Wvnh4vcrq/oOHfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hC9cPBK75VKm1nqLvgGksDPptx6xo9HhnuoE1D+NchaWd22htKW3DtRGWrUmkDapF3uP8t4mbJuajsJAFwUSl2Kp/fxNYMhsPMhEahz4Rs7DPMOtcOLKZZYhS9bc+OG7wGWCiNI3xZAYyTG85l7nRFnRm2270h83eUZCsokLuj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmAXtAuV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d95b08634fso40056485a.2;
        Wed, 09 Jul 2025 23:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127263; x=1752732063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/DU6Gd6GsvMpxfhg5e8gpmRBqjJBuHlmTByBwz0k8BE=;
        b=dmAXtAuVH0SnbaAdZmg6BHwySNHI+ju/aMrJ+TYDeH2QCNF+eAymUbRJ5C1YHnU3Hy
         tOm1TJAzbi9korMhWuxS0Q9T+WCo7W5LjjrhVdRDcITP3pMUtPYPlPE+4BbrMqVLwC/L
         RuhRmQxrJwQzstAzLnB92ZkUMRR53UT9z3IkFOooXjoQGSHDGAO2YepEB3IGjuos/ERn
         9j2ydwvfPSsGuwoaPfHXQdVmy9Isc9f+mlYSLJriGhWyd7P+GOKNWWuTbhTRibN8uJWi
         1UubVfWpX5xY9sDQ1LthQrOyEdsLhanfPjp8euO5Sg1fkc4XpGMalalIKr699sTLEFnr
         Kk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127263; x=1752732063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/DU6Gd6GsvMpxfhg5e8gpmRBqjJBuHlmTByBwz0k8BE=;
        b=ik04u/uksdYvBIdBvXeAlvjyc3huEnrPL0LVzv5DaFw4/G4eIglQQ+6nM2Paccg1WA
         0QB8SnGmbsauRFsxVl4FKBrHnU/LZJZhlaEHPghGir4v9xSqIKrrbUlxtiKqey+2G4kx
         izNcWm0+DEUBQckTmT1t6cS0OAQ2PoJCBfHfhVbyqkBUIiR7J+uCdMfWv/6JAMBh5B6/
         25lcqY4yfnAgxyNwQSerStQY0sEy8yHd6Pk0T2QhGKKnB2dLMrDG49zE68sVytIeUwiN
         PXLgg+Yi5G5gwx0mVX31DBDRgoYAGBXasMf/4rdb4dPBWRBRB+8anzOfx1uycCihNoIt
         Hq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd4LXvAjrXbG1fKwIguEJcYXDLwCMRXjfmzY5nr15bosjsjrPyphaMjTGIWITojf/fI/K51SJMiDYy3Iw4G5s=@vger.kernel.org, AJvYcCVxuDJNJmDvzCRTu8MeXKOfg7+5P7CXkv7iEY/edZsffk4qUjNqe3YbgzqZMyrMX3r+Yeex7/J689Yo@vger.kernel.org
X-Gm-Message-State: AOJu0YwXW8fxx3++W33MNpPbAgr3CtH0VROdzL1BQYlNuvCVirnHuaeP
	5W6BI44ARG6XRk7N608UTBThGaOrTR8jt88tjH7Gxo92Kx34CXDhSubp
X-Gm-Gg: ASbGnctWNP5eP2Fa3wOtdG1TOpzEkyo+WUFzAprg5D0yefEqFXtqQA6HaEwCKGmz2BI
	2pY2bq2WbwMaeHG53uK4V6jMf1F0rDy/6ZkJsshrWyxs4LN5DXBqps1BxamAQOZiSOnZzy7RDpQ
	5sc0WnNQNa+quemvI3vnTawcMT4ShRWKZhyD7ZgGVa9/9Fk03jI9hK7oZUNQ6e25WNjL4q80w04
	dEa4n9kUUOmYjubRTIhSB0zAHZ4stPZhtKeq6a61g1/WFylr2GtZzdN0yoSA4RRgNEThReSR+PB
	qfc9BnDaS3c7x5PPncn7GPUAWCslWHLspd/K+3bGW9O32sSNRNdcriMYjkHJZ7kK7D3hU6NSIL8
	XCZN/uvgoJi3vmirunW6m9Epq6wsVR3TxfLBwNFgopAVpL7TZ5vGT
X-Google-Smtp-Source: AGHT+IFs5ymxGXZTKT0mW5UQCDuMkgRaKeOffj5osmMYN6AhUjxFiddukVJ8qK5/G6K6QWWdCKvJqg==
X-Received: by 2002:a05:620a:1a04:b0:7d4:57c8:af59 with SMTP id af79cd13be357-7dcccbb4d3bmr225348385a.50.1752127262264;
        Wed, 09 Jul 2025 23:01:02 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb1dbc5sm62289085a.22.2025.07.09.23.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:01:01 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D85EF4006C;
	Thu, 10 Jul 2025 02:01:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 02:01:01 -0400
X-ME-Sender: <xms:HVdvaI9cn1_Z_tNbj2LiSKo8N63CF9WOHyphCEhjUO-IYt-BzMSgcg>
    <xme:HVdvaCNMqIOEMkrmp_8DmOZpppN8oKQxEQBYIlGg63CR7uRI4V2xsalgLuq_4ULnB
    gYwrF75PQiLR-jV8g>
X-ME-Received: <xmr:HVdvaCk8YxFVcSLOb0Snv5KASgFy3EqayLM1sDbAkWB0NjJfSLKMG9zxqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
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
X-ME-Proxy: <xmx:HVdvaH8dCzeJffYK2lkrIaxWC3l1UFB409OEcgR1bk3rG7eWRHX4Uw>
    <xmx:HVdvaLMAR3c9Pi5MizGpTEHHzNp80V0pgxJjqUnLG7ETCsddepJGcw>
    <xmx:HVdvaLE0hPyw_Xc2CjUJkKC09XIibhSqusHpn8U3cxarSBKoS25cDA>
    <xmx:HVdvaBh_fqxDHKQciVrNSUzQI5qLcoR1Rn38PVvp9i2OPlH-XTx8mw>
    <xmx:HVdvaHSO2Q_cpvd_ven0Nef96QOJ-qooqZcm3i5Zj5171_teWwyMOelt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:01:00 -0400 (EDT)
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
Subject: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation types
Date: Wed,  9 Jul 2025 23:00:46 -0700
Message-Id: <20250710060052.11955-4-boqun.feng@gmail.com>
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
all ordering variants in one method via generic. The `TYPE` associate
const is for generic function to pick up the particular implementation
specified by an ordering annotation.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs          |  3 +
 rust/kernel/sync/atomic/ordering.rs | 97 +++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 rust/kernel/sync/atomic/ordering.rs

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index c9c7c3617dd5..e80ac049f36b 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -17,3 +17,6 @@
 //! [`LKMM`]: srctree/tools/memory-model/
 
 pub mod ops;
+pub mod ordering;
+
+pub use ordering::{Acquire, Full, Relaxed, Release};
diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
new file mode 100644
index 000000000000..5fffbaa2fa6d
--- /dev/null
+++ b/rust/kernel/sync/atomic/ordering.rs
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory orderings.
+//!
+//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
+//!
+//! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
+//!   following memory accesses, and if there is a store part, the store part has the [`Relaxed`]
+//!   ordering.
+//! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
+//!   the annotated operation, and if there is a load part, the load part has the [`Relaxed`]
+//!   ordering.
+//! - [`Full`] means "fully-ordered", that is:
+//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
+//!   - It provides ordering between the annotated operation and all the following memory accesses.
+//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
+//!     accesses.
+//!   - All the orderings are the same strength as a full memory barrier (i.e. `smp_mb()`).
+//! - [`Relaxed`] provides no ordering except the dependency orderings. Dependency orderings are
+//!   described in "DEPENDENCY RELATIONS" in [`LKMM`]'s [`explanation`].
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
+#[doc(hidden)]
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
+    /// Sealed trait, can be only implemented inside atomic mod.
+    pub trait Sealed {}
+
+    impl Sealed for super::Relaxed {}
+    impl Sealed for super::Acquire {}
+    impl Sealed for super::Release {}
+    impl Sealed for super::Full {}
+}
+
+/// The trait bound for annotating operations that support any ordering.
+pub trait Any: internal::Sealed {
+    /// Describes the exact memory ordering.
+    const TYPE: OrderingType;
+}
+
+impl Any for Relaxed {
+    const TYPE: OrderingType = OrderingType::Relaxed;
+}
+
+impl Any for Acquire {
+    const TYPE: OrderingType = OrderingType::Acquire;
+}
+
+impl Any for Release {
+    const TYPE: OrderingType = OrderingType::Release;
+}
+
+impl Any for Full {
+    const TYPE: OrderingType = OrderingType::Full;
+}
+
+/// The trait bound for operations that only support acquire or relaxed ordering.
+pub trait AcquireOrRelaxed: Any {}
+
+impl AcquireOrRelaxed for Acquire {}
+impl AcquireOrRelaxed for Relaxed {}
+
+/// The trait bound for operations that only support release or relaxed ordering.
+pub trait ReleaseOrRelaxed: Any {}
+
+impl ReleaseOrRelaxed for Release {}
+impl ReleaseOrRelaxed for Relaxed {}
+
+/// The trait bound for operations that only support relaxed ordering.
+pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + Any {}
+
+impl RelaxedOnly for Relaxed {}
-- 
2.39.5 (Apple Git-154)


