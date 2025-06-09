Return-Path: <linux-arch+bounces-12305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A3AD299F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A6216296D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BFC22CBC4;
	Mon,  9 Jun 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOB+8X3o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3A22B5AA;
	Mon,  9 Jun 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509208; cv=none; b=pc/LyvVWh0YMqA3miXrElH5EH6mQPSMnLdQD8e2amNt2mF8ZFlTGBkrasJgl7bVTlKy5wXZAwD3gElQvMCvTv+Spcoe+L89698z5mJMECyyIHJ/v0LCtRn0sSRbSAJJiZOnGTNyjfGOvQzcNKmFsoreA3WaLG4O/kNbfycNAdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509208; c=relaxed/simple;
	bh=oShskdJdNehAIRIfwEnkypGXtdI0C/hh7/P9bKhB/HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rj9WGWmx2MvMgorrHaQ8XxQF6SCeCN3nwHmwtAEvQnu07+4qtG5h4Wdd0IiH3wdseRh3l5unqY6p1OmlKUdBsRBLm6AV6pkTnx9ZN5Jyoj6sRNKxGe6r15ksZJWtYmbBpinjByhb/++Dp7b/JCoI3mqajcefn05CHLxy/QcMyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOB+8X3o; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5b8d13f73so523696685a.0;
        Mon, 09 Jun 2025 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509205; x=1750114005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JDojvZPWlL3CFCvJoSK0mwbboSKSCM4nCY+n+4WMk+A=;
        b=ZOB+8X3o5wK4sgdCw65aBNzNFRhVMKMLLp1QuT84dfmceZF7Y7Wz0RxVR8lqDfkLED
         IEro/lGhkhuNAhEscXqbu+1kkp9Di744nIgNNZMzbVZiRmtps1obQanFORN/pdxkC9Qt
         +vbih+d5PjuU+JI4kCmncC5/0i9wQOqbOQqQvWXK5aLdD/KYq7QNa+vYPZIDdhG4TGRc
         7AA6r0MpzinPpOUyvg+jeXLEiU0o5O2uBb6oMpqm4t8R3brW7xRg8IucjTAAOsWR8ra0
         NxuLjrkVdMKoR/ajYw3SWmevCFDxREn5oavfkTqkibx1pm/jhPvZHTOZrpwqprxWuclE
         kCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509205; x=1750114005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDojvZPWlL3CFCvJoSK0mwbboSKSCM4nCY+n+4WMk+A=;
        b=R0miGrpidYAakgauJ5kHbUyfihwmJHc3bNAog9Hh5l7Tv8eYsYVfGYLd2QYr508V6O
         fubg24Xmn5w1BEWXz0o8/c7jhifoxM1CrYF65Ui19vK7yTIsIPvKX2OXfdyykEikq9HE
         eqV6vEKM3rGHCyxLkdSEMs5L3nXrXWZmy6tcNFt0uyaOC6qopEtqxvH8DI8qiHJBhPxb
         Z6UzyTNWZJfbLM78x1sVxv3Cqjkcf3h3Ct5V6VjLL2KZ5cCqsl67lcIFlW5a8AnfDZ+K
         7LpRZmOYrYacEZJAOdZi/V8QK1VOJnfJF23HtOeqpSyGBUrSOKTWXIvwaC76CHdLCCxs
         gIXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsU57ElmrcCVosYODZJMMXxcoDFR75US78g5MQLGAUhJPaXUosbv1MsciXggfcC67HNCLeczR0x/m0mRuybi8=@vger.kernel.org, AJvYcCXZHLeVjBIyH96XSipOwqrcex7naFFHEMsVQUdWEMoJQ2nuDS6dtUEPgr0/R4nW/BF2KLlrX3Glvzjy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/UXmQTYV0PMWn7Ac4mrKURgW/VGOMxC9m/dgZOy52TPkgXa7
	bj5tkrwqF9iJzYt5kt4SCKsAIQBCp9mibyf7v3eHMJsTtBJbFMXEtqDj
X-Gm-Gg: ASbGncvW5+W7x9IfJKgu2rKMVrMLgkqypDRMdXpE9xGgG5CJRIQYEVYaDV2Njx8skwX
	zhagv3+v9zC7PXb5pku/isq205d37RnMP+f0Vv1q8mYnqzhW2/w66V94C151SEGb19N4ZVxok7L
	eTSnfl+NftAomsB2LAasgBjE5eJZAo7glxWxq5jqagrAeqhojWZrbiCyFGzYydlP2hcHa21ngUY
	jrCC2b6uB7/CSVmyaE1CSNsya0ROIb8QXKgF/+dCYiUzU88/gVzwZF2Gc8/NRvdwBz/dlUTSH7Q
	MQCHbmzEBcTLvb/5ObmaqatQ7QcPpP4WezfnQsaIial8YVximeoFhGQwzkaq6ySHjHbgJRt+R6f
	/yPPiWSLETuhL+zfY6MX0wsUyF4zDWYwokZ1DcpUpWW3sl/XuuXeH
X-Google-Smtp-Source: AGHT+IFWdMXlzex7gDUzqrYkpBHW2HafBlv4t/6SL8q1hA5ZegRGjDNZEMNQbmxRYP3nvG3zy2bOpw==
X-Received: by 2002:a05:620a:24c3:b0:7c5:d1b2:166b with SMTP id af79cd13be357-7d229896668mr2335066085a.8.1749509205062;
        Mon, 09 Jun 2025 15:46:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b364c8sm57352876d6.109.2025.06.09.15.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:44 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 066001200066;
	Mon,  9 Jun 2025 18:46:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Jun 2025 18:46:44 -0400
X-ME-Sender: <xms:U2RHaD9QZ0BNJuSJmE9xTZDKkgtXqI7OXEdKcf3WyThV-O2jNA6JWg>
    <xme:U2RHaPvgHyKlsIvz_4tLr4UEJX68aDwWQrCGeqNwt8b4oFScOB0RNKIRfT7GLkbU1
    VuXW8WI3UhiP0glmQ>
X-ME-Received: <xmr:U2RHaBCleDSkBvpj2W1wr73VMWI8cAr97qHiTrhPskqVESZRw-gTePyyTzk>
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
X-ME-Proxy: <xmx:U2RHaPcTTguIyphhccZPGOV7M3b-jdCmc-VCLzDS-lVYzcZOM97k5A>
    <xmx:U2RHaIMuJszmMHijMBjOu-I40nPW1cXz70aoXMnpCC7o4CPTi1m09g>
    <xmx:U2RHaBkctjWqYgf-tLtD_Z5Elm3Sf8bAZb8UEJSe2UNLfiGLHlz82g>
    <xmx:U2RHaCv-cYOKgpRwZrMPrP8TDQCcGAcsx95Adx8dXD_74KRV5-3DCA>
    <xmx:VGRHaCunOAQ2PqMZOSwV5PXUB8RlsDdLBzDY9Bmbq3pIe5z7O0TV1AjX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:43 -0400 (EDT)
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
Subject: [PATCH v4 09/10] rust: sync: atomic: Add Atomic<*mut T>
Date: Mon,  9 Jun 2025 15:46:14 -0700
Message-Id: <20250609224615.27061-10-boqun.feng@gmail.com>
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

Add atomic support for raw pointer values, similar to `isize` and
`usize`, the representation type is selected based on CONFIG_64BIT.

`*mut T` is not `Send`, however `Atomic<*mut T>` definitely needs to be
a `Sync`, and that's the whole point of atomics: being able to have
multiple shared references in different threads so that they can sync
with each other. As a result, a pointer value will be transferred from
one thread to another via `Atomic<*mut T>`:

	<thread 1>		<thread 2>
	x.store(p1, Relaxed);
				let p = x.load(p1, Relaxed);

This means a raw pointer value (`*mut T`) needs to be able to transfer
across thread boundaries, which is essentially `Send`.

To reflect this in the type system, and based on the fact that pointer
values can be transferred safely (only using them to dereference is
unsafe), as suggested by Alice, extend the `AllowAtomic` trait to
include a customized `Send` semantics, that is: `impl AllowAtomic` has
to be safe to be transferred across thread boundaries.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs         | 19 +++++++++++++++++++
 rust/kernel/sync/atomic/generic.rs | 16 +++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index e36431f0b42c..e4dd31a3e3e2 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -114,6 +114,22 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
         d as Self::Repr
     }
 }
+// SAFETY: A `*mut T` has the same size and the alignment as `i64` for 64bit and the same as `i32`
+// for 32bit. And it's safe to transfer the ownership of a pointer value to another thread.
+unsafe impl<T> generic::AllowAtomic for *mut T {
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
 
 use crate::macros::kunit_tests;
 
@@ -139,6 +155,9 @@ fn atomic_basic_tests() {
 
             assert_eq!(v, x.load(Relaxed));
         });
+
+        let x = Atomic::new(core::ptr::null_mut::<i32>());
+        assert!(x.load(Relaxed).is_null());
     }
 
     #[test]
diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
index f0bc831e8079..e2f60e89fbbb 100644
--- a/rust/kernel/sync/atomic/generic.rs
+++ b/rust/kernel/sync/atomic/generic.rs
@@ -19,6 +19,10 @@
 #[repr(transparent)]
 pub struct Atomic<T: AllowAtomic>(Opaque<T>);
 
+// SAFETY: `Atomic<T>` is safe to send between execution contexts, because `T` is `AllowAtomic` and
+// `AllowAtomic`'s safety requirement guarantees that.
+unsafe impl<T: AllowAtomic> Send for Atomic<T> {}
+
 // SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
 unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
 
@@ -31,8 +35,13 @@ unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
 ///
 /// # Safety
 ///
-/// [`Self`] must have the same size and alignment as [`Self::Repr`].
-pub unsafe trait AllowAtomic: Sized + Send + Copy {
+/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
+/// - The implementer must guarantee it's safe to transfer ownership from one execution context to
+///   another, this means it has to be a [`Send`], but because `*mut T` is not [`Send`] and that's
+///   the basic type needs to support atomic operations, so this safety requirement is added to
+///   [`AllowAtomic`] trait. This safety requirement is automatically satisfied if the type is a
+///   [`Send`].
+pub unsafe trait AllowAtomic: Sized + Copy {
     /// The backing atomic implementation type.
     type Repr: AtomicImpl;
 
@@ -45,7 +54,8 @@ pub unsafe trait AllowAtomic: Sized + Send + Copy {
 
 // An `AtomicImpl` is automatically an `AllowAtomic`.
 //
-// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size and alignment.
+// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size and alignment. And all
+// `AtomicImpl` types are `Send`.
 unsafe impl<T: AtomicImpl> AllowAtomic for T {
     type Repr = Self;
 
-- 
2.39.5 (Apple Git-154)


