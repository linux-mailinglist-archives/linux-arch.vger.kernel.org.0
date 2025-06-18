Return-Path: <linux-arch+bounces-12389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40230ADF301
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C71BC1D53
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC352F94B9;
	Wed, 18 Jun 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDRaKUsG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012D2F5477;
	Wed, 18 Jun 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265393; cv=none; b=FuKAXc2rlfdqJu1YPvGEnFIKOPofRj9JaA8fQyzENsnCo5O3IKNIUZi8TXtZfm+0Mc8YcBF17tTR6xJcuJFNyeCXp6H1AKLPjpgP/FJNFtJ0mwaFe02GsyL4i1wayZS9SbMEzxI6FBlpL8jH2A7SkpyJMaYLKCFY4PXTF/5EaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265393; c=relaxed/simple;
	bh=fere2FiE8wcY7FYKyqup4BtXpG8xUmjDEuEEhDZQYm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdP9blHBa0SIeMFPRuSksbKxODcYOGWJflV6w9eIsfhcX8MiIyDycS832AJ4Rv17AIOY7uAMmjqZwGI9B1XRwU7/aFEnAspR6w71f89w/cjb6+cuEBwJYFNtWzDK5vqnFwgaxj2PDtGP0XT2ogBp+Q3+YAOcRlnPEKIcXWjhIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDRaKUsG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d094ef02e5so104725385a.1;
        Wed, 18 Jun 2025 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265390; x=1750870190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IiqenWQWU7iuzOQuKuquY7EpMvEiluNmSmj/bpcg5CQ=;
        b=DDRaKUsGIqx8IWS0uXh8JIIgT3LzTDarvHx/6moGlYz1Tczo4Pb33K7ds/6GbLsTbV
         1T1Oqyk9W9aOuhl9n0akHlhEwdLuq9c7TPcNyE5iXHwl59GRKtRSIesh9MJpUNCk5M9y
         VJNyLLBiOGJ0lkoAtHCRmXgKD4lfhuyZ9kHndHGuYxH4NLHuAweMFg/WdUBdSnDgIa3a
         OrnlstKgejHIKF9EmONU7fhR4w42kX/Jvavx7extV4r75q5qgnMb2DB63COmvRq+6bc2
         nJsWyaqzalkvPxh5e0N9hvlSvq8bLKJ6rWLI3k1wJMOfC9TpSR6EOJ4bN5LtJFSpHjsu
         6JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265390; x=1750870190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiqenWQWU7iuzOQuKuquY7EpMvEiluNmSmj/bpcg5CQ=;
        b=a7hBd0p5Nias7//esu3DgsvGjBJr6STF5dCHo5W0Jwni4/Rhu/uNPrjzIAD7A9qH5T
         MIsJFbaDtml2PRBkWNjFNSDgimS4ui3asP7FtDtqCILb5Su9s7PdbN9MYcn3S8gWMj1J
         3c7ouOt+ob+UomIqLhxI97fsP44re+WkMJ+7u1pNCOf9wgfwlw1TyOyPti68xO7zfQVI
         fouxlp8W48k0fhYp2DNEMglJkUqucZ8WRi4LvAPyLbxZ83Vim9BYe+MJW8hrMijO+sPb
         cqj06Yd7oS1PwsizT+pLh5PNSAIy2FIzdTEAQX/Iip1MlViLF1jBwjDy1SfMdqyvPA2W
         TFqg==
X-Forwarded-Encrypted: i=1; AJvYcCV4vAr+p2Zw/RzTTDE9adimjpKp4+/C3oylDw+0Nsy3RX7dLuLX9fTi8f3SAgMkJdGlSHD0pEamFn10CBG6enQ=@vger.kernel.org, AJvYcCW0rN0faVAj7vbNLS4VcxSVru48r8OZu9FfIQdRws9lg7Ja3mdZLVCA+bRNlI+He2HFaCUf9HUOEd0V@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhEsGeOMSHH8RcHP1UEPh2SdMRt0VDrfvTWQEBe4x83uenGVm
	HysbUSSgtTisCkg4XSRmziWPjsCILx8PvJk0+LzTFRsleQD13xtIFxQb
X-Gm-Gg: ASbGnct2hUfeNtbyYwEG0BZwH24uIWzK27KMgvwEoB82j7brV0lrsJuKg3WrZ7hEq3G
	1n5b4FEprznhq0qHnH3HddQ7inL2+XkeBdR/VbOtj3VozK4oKECU6CQqtBmUyFmtfku+C3GPBcy
	/vGKrppVmmVY2c0rooKExMIrd5bOgaErWitfWVKdzxksxX1FdN46XYI9azEzHYICPrMUD4/ZQ3h
	ysQt8CK2KzF3wHsGEHSLSN7HWu4qubr4l7zAcMyk3WUqDEYD99iwGO+0AunjlNfMTP2EE9d5tyC
	YHOJgbsy99Xpm5Ivh+ACyyk7oLCqi6QAuR09CvpF1/D+l8vvh3DzTrWRmr3ITXza6xsqX+Jn+Xb
	04oR64ETl3dLrE9fRKsuVYeZ85mT9qo3Za2M/aAtVJv2WeV5ydWjV
X-Google-Smtp-Source: AGHT+IFrny/vCbBmkBRC9BnME0hYm/8gTb/V8VUqVO59PYMWA65CHg4iSYOfVJWSz/SsFM5tNpjDew==
X-Received: by 2002:a05:620a:4805:b0:7cc:13f:fa30 with SMTP id af79cd13be357-7d3f1738bbfmr39720585a.27.1750265389701;
        Wed, 18 Jun 2025 09:49:49 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8f0b35csm783472585a.102.2025.06.18.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:49 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id B76991200043;
	Wed, 18 Jun 2025 12:49:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 18 Jun 2025 12:49:48 -0400
X-ME-Sender: <xms:LO5SaM2iGSuM1JtSI3i4jCMBCItjR0M9dHU15aXP2R2K3Adyg5htRg>
    <xme:LO5SaHGbIIU22-ZsJqOZIsM8w6D9KtclHL1fIYSeQ-no02ltMCtdHtknXTY0KndXt
    BvBqMa27I_MpQKtoA>
X-ME-Received: <xmr:LO5SaE4NFjyiSK5ZesbsPXHCPMptHpIzgB8ONJljdPncEVBJvXoYOxhm0KJ9VQ>
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
X-ME-Proxy: <xmx:LO5SaF0qI5KJh9zKUzDNvjVsVzvsRP-ljl25pUpL4tXmzSirj9iCsA>
    <xmx:LO5SaPFbCMFqeMrTuuCf2kl5QX8iH9t_IUPIYtpDE2QKlC_CE5b1UA>
    <xmx:LO5SaO9HPPQcTD1lWh4HAB4y4DCWwNZ4ez1cBhBTEfcnNSIEQb6N3w>
    <xmx:LO5SaEnsPCvIjiYEVypGDaYLgp3bi2izhgG5rwZpKrtyCTEvgEM88Q>
    <xmx:LO5SaPH9Nk-WWm3A0qL7lV4jNRIk-KrIDI7NHOZzZeauruuVRBGQ4RfW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:48 -0400 (EDT)
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
Subject: [PATCH v5 08/10] rust: sync: atomic: Add Atomic<{usize,isize}>
Date: Wed, 18 Jun 2025 09:49:32 -0700
Message-Id: <20250618164934.19817-9-boqun.feng@gmail.com>
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

Add generic atomic support for `usize` and `isize`. Note that instead of
mapping directly to `atomic_long_t`, the represention type
(`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
the necessarity of creating `atomic_long_*` helpers, which could save
the binary size of kernel if inline helpers are not available.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 58 +++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 965a3db554d9..829511f4d582 100644
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
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -106,7 +156,7 @@ fn atomic_xchg_tests() {
 
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -121,7 +171,7 @@ fn atomic_cmpxchg_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));
-- 
2.39.5 (Apple Git-154)


