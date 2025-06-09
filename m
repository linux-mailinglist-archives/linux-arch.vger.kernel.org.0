Return-Path: <linux-arch+bounces-12303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A78AD299B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D831891DB0
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875A222ACEE;
	Mon,  9 Jun 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF6BRhOc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F3227BA5;
	Mon,  9 Jun 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509205; cv=none; b=T9h2xzfBPe1B6e9CLtMR/hNS+1yDr9dwI8NRbOiyIOj9dMaYIXK/wF7FbBS1uUQYXCcbwO5aM/6Foqw46b968IsEIBXEcmQC9YVImU7NbX+/koINozFCveMDNb9Yc53M+9cYmgAj5HfWeYatkrMZZCU+zRVQEXuyZuKFcHueBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509205; c=relaxed/simple;
	bh=3t90svxWEHL37ohE0fJHFmRBiBXjgm3lFXGoX5OddKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srSiVJX09EzJbHbMZgSB64ZAU0s+pxqPLdlEm8Bc1NNbuBDaeyoVNQXJbDbPb8Lie17aI3AxW4cGP+IEmsXaWqBvW2Ua3bdZ30gAxTFXpIvT9FaUcJQYFTvCAUnAq+Wbx2+6q+4fCqwZ7sTY3/zhOOoiTSgSulWx4VoncQDwNow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF6BRhOc; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d09f11657cso457383285a.0;
        Mon, 09 Jun 2025 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509202; x=1750114002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ykfv0JUDwfNHM9Hye+0iZ2AUZ2hpC7+5v9dE8kxQRZU=;
        b=fF6BRhOcC/eDx6KPpd7jMxDCCcrVboMTEO17iUgrOU3hiTxapAmBHgzkEFRMvOxQjd
         q2RNaxXDS9AxQQdUwUESzVu9LUXIUATBSgfWnO1qXaFKaJ49BQ8GfQ6UX3rmeZw+TyE3
         H+cf92B51C5dtUCFfrldkzY5J9e5+ok6M/T+wxmmOZo11a2gg1vH1RXI1IT8t3NVEsrM
         Es44lL4UEQd8WdzlRRoruTFW1rnqHY/xzm8zO6mMexXMa/AF9M8S3Pah/aDNkIOrHcza
         jwGCVMlFZQ4F4Lw8VDDjArWZ76HcCVmdadfbsAmiZEpPeyyox6CsuKnZKoVFM02rnJvF
         c7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509202; x=1750114002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ykfv0JUDwfNHM9Hye+0iZ2AUZ2hpC7+5v9dE8kxQRZU=;
        b=QUdu6VP6EiT/kgyPRneGQ84z6pA/XBvURHOaAWqkL22kuMshoaFiczTfSn5WzZpiSl
         c2Y9j6aAES8aA/ES/guOuvq5KdsGpNBBQ0LXBwrTtbsCODe+3yccY/puAOvxxxo4Uwxo
         aY60xeTZJDMHhIo1w+gE1L2zJR8Uq5KiJifKnCnpo7DLYaxYbiyxZRYtSH7UeB6U8Zs9
         sZAfl2tzBdJbVZU1v8fb6UEwKcjf+/ADbr3OJTd9PG1hHyHZcTaK+ZrLbITqf//HIPK3
         c+XIoctHCdXwbJ38HSyHNkFB/x17F9Wj1lxsVHJ/GkiIWVv6iHbZhNFrPK44W6q7X2oj
         Bozw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGiYs1+ihpwzESi+yio4lrWr7ICL4XJiuHBr/TtLNJtkGkA7o8Oty67Ah0G91dS1vfcOCYgJ9aJ2x1ndo1og=@vger.kernel.org, AJvYcCWjVHEjhoLQsaDY5V8WZRZm634RXrIciZmBVmEFWWEgDNV3fo/I5MWhUONJ43okwHIR3T+WEzmhgStU@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGiHXF2EKYd+a1vbKpBqYiIZT5EDg6fWXLwSgaEDMBA+aW+Iu
	vJPfhhA53CuHSbYIVO4qEVf55xvtmOwVIFx4VK0Nyl1w+S2bixi6Mxvz
X-Gm-Gg: ASbGnctNbxQkW9CYS0GpAKoP6vc1fHorI0HWDYI9AKSj5Exqfzs3gLup60bz1OF5qRY
	FOJ9T9oHjL2RuKKgTUd7TD8H0jdrLAgXanK9G90/DSWQWj9uO4UwOl5Q944P6P9o03UAV3pyBT/
	2Gbl6Avj/U0FukCJsmnd9f/H3k+mS6foatk3lNtVub1n6TzochRFTOlH79eXTJM+qBmpcv6RI5M
	Prx4VGv4n3aBDv/mz7i1cY/E0otbbfPQvW5xq7ht63SyCK+mft9K8UwFE+gmASb4Tp+EOonVzEZ
	j36h1jUwhWd3w8JJTjBHgzYE2t3qPj31famG0/Ks3jvBRSM2MLsEvv+pSo91odpbPGbRVj2oNTJ
	nllL7wgjMmkD12iC6r3hSD1z9bSiWfME0lZaPajUhrtTGZuKINrbb
X-Google-Smtp-Source: AGHT+IFUi/CH1qbuTMavhtVevTlVgWxfuQBtFoEfwJqR6HTbU+n+FxJv1MMM0BL61L4p6Kak/iTk1Q==
X-Received: by 2002:a05:620a:29c9:b0:7c7:694e:1ba0 with SMTP id af79cd13be357-7d2298d6f08mr2328173785a.44.1749509202149;
        Mon, 09 Jun 2025 15:46:42 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09aba071sm57749346d6.24.2025.06.09.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:41 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 459101200043;
	Mon,  9 Jun 2025 18:46:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 09 Jun 2025 18:46:41 -0400
X-ME-Sender: <xms:UWRHaGlNxKmD3s9WeTH-uG3XfN8hfANDj7H6wlTEQvsrRSc8jpqGDQ>
    <xme:UWRHaN1n41g_8UlK46Y5jEN6oLciXfno3fIz8tRxpNiuck0TuyHuOZLm7vYQDKxt3
    jkaMtK3wq65-C_kxg>
X-ME-Received: <xmr:UWRHaEofQIWNayLYRE7Jb_1eRZuXsHW0qEzw7biyjeWU_0_JlI1NwnFJc34>
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
X-ME-Proxy: <xmx:UWRHaKk6haGCIigi3EELRmLFej66hn1_ihcuNAYKuIA1eo2HZAG8Rg>
    <xmx:UWRHaE2UfVbFnVIjfSZs3c3sFcGJXx3bBMRR4gN-DnZG1VnkYVIuMQ>
    <xmx:UWRHaBvvl6TM8sVMF065ZNSZuqm5RTCQXETlZnzU0WsigMPWVY49NQ>
    <xmx:UWRHaAWiBN_Fq0G-qpXZRJgO6br-Rv_ng_zbIlo5p9FCyYjbdDtfhg>
    <xmx:UWRHaP1G1tkUWfB4TMGfsb_HZOYFh2xW4vt0k6P_yt8x5cTiGsC0lbNa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:40 -0400 (EDT)
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
Subject: [PATCH v4 07/10] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Mon,  9 Jun 2025 15:46:12 -0700
Message-Id: <20250609224615.27061-8-boqun.feng@gmail.com>
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

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index a01e44eec380..9039591b4d46 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -22,3 +22,86 @@
 
 pub use generic::Atomic;
 pub use ordering::{Acquire, Full, Relaxed, Release};
+
+// SAFETY: `u64` and `i64` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u64 {
+    type Repr = i64;
+
+    fn into_repr(self) -> Self::Repr {
+        self as _
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as _
+    }
+}
+
+impl generic::AllowAtomicArithmetic for u64 {
+    type Delta = u64;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
+
+// SAFETY: `u32` and `i32` has the same size and alignment.
+unsafe impl generic::AllowAtomic for u32 {
+    type Repr = i32;
+
+    fn into_repr(self) -> Self::Repr {
+        self as _
+    }
+
+    fn from_repr(repr: Self::Repr) -> Self {
+        repr as _
+    }
+}
+
+impl generic::AllowAtomicArithmetic for u32 {
+    type Delta = u32;
+
+    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
+        d as _
+    }
+}
+
+use crate::macros::kunit_tests;
+
+#[kunit_tests(rust_atomics)]
+mod tests {
+    use super::*;
+
+    // Call $fn($val) with each $type of $val.
+    macro_rules! for_each_type {
+        ($val:literal in [$($type:ty),*] $fn:expr) => {
+            $({
+                let v: $type = $val;
+
+                $fn(v);
+            })*
+        }
+    }
+
+    #[test]
+    fn atomic_basic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_arithmetic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.fetch_add(12, Full));
+            assert_eq!(v + 12, x.load(Relaxed));
+
+            x.add(13, Relaxed);
+
+            assert_eq!(v + 25, x.load(Relaxed));
+        });
+    }
+}
-- 
2.39.5 (Apple Git-154)


