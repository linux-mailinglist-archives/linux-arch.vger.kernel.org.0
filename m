Return-Path: <linux-arch+bounces-12304-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52BAD299C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A5F1891DB2
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B822B8AF;
	Mon,  9 Jun 2025 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXjKoL6s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAF22A810;
	Mon,  9 Jun 2025 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509206; cv=none; b=ou1sg2oeDBxqEDxhFxtRZyGZ+ZtPRmXUv+L0PK/paOwkiTCKWlz+FJ4wbWE0mo1ujMQ82rEh7XuIUTCWuUbOTJ5sLMl/VQUvkdpiMYx+1obHJDkVxEgoMwS+Kwmh+G/7qzNbUzilgl2O4hev3EaLkhyPfg4F8q1tt9TALDQDJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509206; c=relaxed/simple;
	bh=oFjgr6Gty0sYPZz6lkCRj5C7HTiuBJmRhc3BPpW6Gio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yq6qEgYJbIdwMJdmaoCQfP0HxD1XS/kmupwnYw74lUy0bofunrOUSr7bMWATaLopyyJWV1nc8XV38LEHRyaDw8iS0YCzCfKerroVpQ2RVSEf6T0CpJv1HIOFR8Bw+P5avGvnNPfoJFBucXgchEgag6yS8GJWp8IyqKBTURulsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXjKoL6s; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a44b9b2af8so29842261cf.3;
        Mon, 09 Jun 2025 15:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509204; x=1750114004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0VUmlWceKq0MhGDhxaelm4U0vrjMGoaihx4g6jot+hI=;
        b=ZXjKoL6sRWWnUrrTCbLJnw4mr4pQ/kpbMN7xV8ZABhz/DwG2E5vAqEWd16cXN9T72N
         ERxDFzeCFFN1gXs81NgU3fZggtdMqVzWUo0pmc1LU40lYAqowG7LFHTp90fsZVp2JYRB
         UAyWEOPv3ak+fGgPqN5FmUA3FHicfKtwaXUb90peJFoaYjiTL6vrvJ641LWyichjDFg0
         oh5lXWKfqWLT20zL0BX+nlQdNIZu5dZSfUhSgK4oczAD0Z2vfWtZfclm4tA/RDk/E7Fo
         xz9i1Vcu2aMocpggW7JDbcyTLtFOUkGLEcFZtbizSlSgaH0j1vUf9arYMMNww691RE76
         p1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509204; x=1750114004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VUmlWceKq0MhGDhxaelm4U0vrjMGoaihx4g6jot+hI=;
        b=TFtrmKRUwoMmfWHbYpEPcogUx4883B8Yw1K6lPF7CIrIPa/Z82BfzHUnhYZUryDkT8
         x4uvzWNJRZIpfoxCZKWb6M980Hynh4UR9qQHB/ZFfEaWcUiA0uh5zihXogkPu++Xqp/d
         tdobyU554prvFATGNWxv4FPeI2rx8ZCakyTGwVK5kurAlTJsJrvUgMswvvJPY1KRbVeM
         2dA2dQomriExotDaP4dQ3URFYUMpMQy7QarCA7gJ853yI+ABcpIt6kJyo2VFljmZ6Yiy
         qCAj+NF+p2qhwCaeQL3hMQQ6hNkUz059aTKJeIQStyWBION4SQrei74/U/TWr261DrJU
         rtww==
X-Forwarded-Encrypted: i=1; AJvYcCVVCznnE2oeYl/bva5ogE3nlRNOpBExz6nUu234bq/jLlR3LdWHsFwmhbcGkws5IPpCLGZyFmmocE5CN/4fYvE=@vger.kernel.org, AJvYcCWqbfaG7zf0iLdGKysAzVFjzHVTDsbdaP4rom/0SxWxDc1ZCZrhU0SR/fyP1bDCdmawrPMurIXQaESS@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6RTG4FCNlNNUzOIVavyTl4jYYvAhtoYpYcGGE4xeQ/u69AAX
	yN20LT5Wk8GdGXHmdbzWECox6w+24adk1rS5vqQNOaZkG1r7ZE/tLrfP
X-Gm-Gg: ASbGncvDMC/mks77sj2HR2yT9G84kJ39peWNZa2y8v6pbc1N9b7gDyoQ9kbuMG8CZJx
	mcoB23ycjj8d2qMhhfgqiyCrXDlGaNaTr9a0+1DUiKPZQ/DgbzwybXuBsOwfVagmla6aI2Lv9fJ
	JYdmqT+I94sBEiZGEKH4Jodyfou46lh2YYZecWtqJVyfIq0aPtDv048nKWYg690pISmuoTdNrQo
	DryWHNhRkebWXxRQRTjz2BY85gBSOctXoTmCVw1gTbE43mfmHkp8s+dOh+7/X59OAzn79d2eZRh
	BnBqQq1UbORl4PF6T2onJLBLhsJ8srfBJs8u/9WsAAwy0Ql6fCuYowR/o+SSLChwR9LfaMPmueS
	pd7BliKxmIczwItmP6DTjn/AkkBjajMsyd3lQvs24MTrusmGMwrth
X-Google-Smtp-Source: AGHT+IHUvGILmPxevlLiDdE4/5niU9zwzNHdixZ1E6LRUj9Z/4mSR8N5VsZ6oCwXtJouTe5pBCngUg==
X-Received: by 2002:a05:622a:588c:b0:4a4:4202:e77e with SMTP id d75a77b69052e-4a5b9a0528cmr245207171cf.6.1749509203935;
        Mon, 09 Jun 2025 15:46:43 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a611150018sm62230961cf.8.2025.06.09.15.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:43 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 957041200043;
	Mon,  9 Jun 2025 18:46:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Jun 2025 18:46:42 -0400
X-ME-Sender: <xms:UmRHaJTyc7qbO-HEt2gzY8TYPSPz9Z7ylZuu7hTjqkNTJ-wHCd5-sA>
    <xme:UmRHaCxdtc-Zh5pK0UM7v31k6t61-u9VHalsdDHmhLZMzYwUG4fGjwEaVTEj22VLs
    k53ewAO0AdTNR0rXg>
X-ME-Received: <xmr:UmRHaO2L3mWf0ki31mn_pDNrU1-QFP3sV08oJtLckMyDIZKIwf9Qwrjh-X4>
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
X-ME-Proxy: <xmx:UmRHaBDu1xrx37xMclGV5uwtH8bP1utCzAWGf7orMuXtfJhV4j-Jfg>
    <xmx:UmRHaCiB1gAN4snSQfplw4LPLhzds5deU4cgdBH3plIxnNETzp05-Q>
    <xmx:UmRHaFqKJVVM50ANxjRxT4b29pitt1ECkFhnDNaBzPEYOsoPSqHBcw>
    <xmx:UmRHaNhV3gSBlC4MCcank84CoPjqSWVYqpcR0XKAtH1KM3b8LwYZyA>
    <xmx:UmRHaNRpm097rN5_rK3gZa8gQzMep9b5VDDzV8NJDQfB3Ziw2sSyt4Nd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:42 -0400 (EDT)
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
Subject: [PATCH v4 08/10] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Mon,  9 Jun 2025 15:46:13 -0700
Message-Id: <20250609224615.27061-9-boqun.feng@gmail.com>
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

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessarity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 54 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 9039591b4d46..e36431f0b42c 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -65,6 +65,56 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
     }
 }
 
+// SAFETY: `usize` has the same size and the alignment as `i64` for 64bit and the same as `i32` for
+// 32bit.
+unsafe impl generic::AllowAtomic for usize {
+    #[cfg(CONFIG_64BIT)]
+    type Repr = i64;
+    #[cfg(not(CONFIG_64BIT))]
+    type Repr = i32;
+
+    fn into_repr(self) -> Self::Repr {
+        self as Self::Repr
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as Self
+    }
+}
+
+impl generic::AllowAtomicArithmetic for usize {
+    type Delta = usize;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
+// SAFETY: `isize` has the same size and the alignment as `i64` for 64bit and the same as `i32` for
+// 32bit.
+unsafe impl generic::AllowAtomic for isize {
+    #[cfg(CONFIG_64BIT)]
+    type Repr = i64;
+    #[cfg(not(CONFIG_64BIT))]
+    type Repr = i32;
+
+    fn into_repr(self) -> Self::Repr {
+        self as Self::Repr
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as Self
+    }
+}
+
+impl generic::AllowAtomicArithmetic for isize {
+    type Delta = isize;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as Self::Repr
+    }
+}
+
 use crate::macros::kunit_tests;
 
 #[kunit_tests(rust_atomics)]
@@ -84,7 +134,7 @@ macro_rules! for_each_type {
 
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.load(Relaxed));
@@ -93,7 +143,7 @@ fn atomic_basic_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));
-- 
2.39.5 (Apple Git-154)


