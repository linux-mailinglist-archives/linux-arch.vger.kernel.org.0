Return-Path: <linux-arch+bounces-12861-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62830B0AD96
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 05:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1EA189090B
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398171E9B3D;
	Sat, 19 Jul 2025 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGmx6cVf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BE8C0B;
	Sat, 19 Jul 2025 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894515; cv=none; b=uiLPba2XTuGKpnXoHDh4l+arev99kbxuyogMZqxR/jdZ68/rfLOFfhqjMcLis5w61ZCUMwUq4O0ux/jwi0VKWIJXY5EArsKNCPmA/2+jijVtuRV2AZyyICR3hP+g4HW6Vc8oSD1Dx+5ardpqk1y+JbwR7IUORgzJc6b+5TfaZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894515; c=relaxed/simple;
	bh=cA+Rlc1UA4aEgEbhMbx+uYk06TRoNYUa2mIsSD9jTQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbvffDXS2egTzm5Whbaxz1JfNTQ3FsA9IMKWOTikQSIWvapHXhYqDF6IAxF7U3avecUHw2eq27wwj1BnciJyDJgXy8YzSiL/XV/JZQJ3Dh9drD7XFi77fngdY3RA+q+CkImbBO8gJW/226yHTUDoSbSfHdttEpr3xbg6ph55M0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGmx6cVf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7df981428abso419538785a.1;
        Fri, 18 Jul 2025 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752894512; x=1753499312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nFN6uyXpb8WVQyZlorRYj+zulMxQ9kEVhp1w5q5VCv8=;
        b=hGmx6cVf4lTaD0EEWn+9nPl/ZjbxGzvuLNYUvDc5wCCZOMW/tpsnlUIGDuV9pb4Kmp
         gofnNYtJ2qRVHJi8DUw9FFbic5P+HIrlya/FRDkhsf3C0FNjF/wo3wphAP7/w+m+fcZB
         Om1pChZb0zUlHkFxCrePPC6ClR1T7EwOVcutGxbWOvqoGug6ArLLhCIvV/srZuxOP8y0
         zcV70GPyKzQlVofGBE/vy9N3nmhQkNmorR41J4WKRJlDNLAOikBV0+eBWbaqRE753NNf
         nSjUPjrC6RHcnsfGprs/e5aMJ8rByHe3mvBzMvMJ58+ObJUAH+THO2neMu+woIJaDbJO
         l2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752894512; x=1753499312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFN6uyXpb8WVQyZlorRYj+zulMxQ9kEVhp1w5q5VCv8=;
        b=VEczqeg281kJQWSMd8jIMat2AbPb/NGIXJ13tW0rMhTMnmF6qMFOReLNUq+MfAMdmp
         mDgUPI9lWH78v4kAKuoOGT+P3lGspmNxK/6A7kJGHj1ly8xi+wklWZQxZ1JxPiWJLfAy
         CnGQf7LP5wcu//stn3GmhHJJrdnvLtGFUBZ/+BXq5o/GaBglByn29Vb5G02TI/DxgfoX
         zHpZ5zLF6BRmAwXyWTdo46Vprq8UtFbXc9Oy/e3bSvRP3qBWP5SEQTuADIOtMXhiZZih
         pKgHCKzykdznxlygkF7XfIMjcjpjYzjwm9o2FudRvkxrYU/okA3XmC3n6ZG6nu5ubNfh
         EN2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQorImKStxn8X5CSZU7nDHccRX5o6a2OVnIZ3w1GIsDK9TWdPJnR0L8ZpWqFnoEBtskSp6p4xxrtVt@vger.kernel.org, AJvYcCVHuf+oTfn2gbBVGDsCE/dinV320JEbHAU1wY06b5m6/CoEITR+BGRSZBHGv3CTNHNR3A/I4GiSd136RYW7578=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQy3C7rDf2j4A0ZaEU0LNE22K8Onz7A5Hs9xMdtccuei/yTcV
	D5UmZIM1P2ZVTugFLS1Jzia5irqVPcuEX5d09HRfcHbiuEl8AKhM3/nP
X-Gm-Gg: ASbGncsrT7GU6aKaSwPLo47WcxHs5CsdeK4WjmTqHOCaDKhJN4h/iuN0bL7AyqDq3DH
	cgWUwniW90ywLrZ7Wh713YSi4l/8vCaDvoJFvuv/ibdje4oOcH5sCSUDmH2vujScTcCzTwVYmow
	MmKWfp0Chv0RgTQLON42BOlK2leDZpEh53uk0YIwNzFS7wdxHS7U3In+s1TqwzInd1AttB22Np3
	45mThMVGeDH7yfe69y9ytRdmXQan5Tybzalq7FXQBwcYhGx9HsHiGkfXZ1D33yuD12/XQrCVp+p
	H6RA0gBVx7DyJ5dIhW+NTjPKQ3/xucfMkm9Le8PKWtCwNx3Vhvg63ZcgZbrW2P7/FQsUSNX2t96
	4FcjHSRb53MeF9fLl+fcYqdTSoglc5xZCgQWQStT2ZDuaZ9M9v0tOUwc6WcPaAm8S8xXS1dmj1O
	WTYWeR8IzpHOOYd8p2FAJGNIQ=
X-Google-Smtp-Source: AGHT+IH46tO8GnXNGM87ZiDkJfwNSMULwxgsOqQxzPPUobUpcgLsukjaJK1/fL19UjstzFKC6zQ0nA==
X-Received: by 2002:a05:620a:26a1:b0:7e3:3fba:900b with SMTP id af79cd13be357-7e356a247e5mr726807785a.4.1752894512106;
        Fri, 18 Jul 2025 20:08:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9015dsm158556385a.92.2025.07.18.20.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 20:08:31 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DE9E0F40066;
	Fri, 18 Jul 2025 23:08:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 23:08:30 -0400
X-ME-Sender: <xms:Lgx7aERoHNNeVjwf-paVvotjTQFXJgE99Mgmthi-tIFAlHVGzHfQLw>
    <xme:Lgx7aDTmRslI_3R_c5CLjHlBL13Dsezs5ctVaotve9infeOUqqsQ44B68pCiC3VLs
    IDV_sQsQ3XIX1WXSw>
X-ME-Received: <xmr:Lgx7aGYbAvohmhRhNWNhDKsk63c7SKaV6br2Gv-cJU5mQAfKrjDBTz5-kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeihedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhu
    giesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:Lgx7aHj4fLEY0XA2kEsKo321ag5eJddKRA-R2YajcYP4KN_xjV2nSA>
    <xmx:Lgx7aLjyCLDTPGd04bc8YFDg55LKSOHAfunzN_46Qoygb1mFtyW0kw>
    <xmx:Lgx7aNK-JNmVmNmkJjnT9eLSf5uXl1TCkEzQO86MoQxiE5lz8kAMoA>
    <xmx:Lgx7aCX1Xs1kRRoSkYzUYcnMU2O6HXGuqhzbzNrkcolhZ_LLvjZXaA>
    <xmx:Lgx7aP1_d9MMuGoAfDB_71KJ2Sf2AwapEYqmRW2HQZSePemBwEk1WOo5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 23:08:30 -0400 (EDT)
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
	"Alan Stern" <stern@rowland.harvard.edu>
Subject: [PATCH v8 0/9] LKMM atomics in Rust
Date: Fri, 18 Jul 2025 20:08:18 -0700
Message-Id: <20250719030827.61357-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is the v8 of LKMM atomics in Rust, you can find the previous
versions at:

v7: https://lore.kernel.org/rust-for-linux/20250714053656.66712-1-boqun.feng@gmail.com/
v6: https://lore.kernel.org/rust-for-linux/20250710060052.11955-1-boqun.feng@gmail.com/
v5: https://lore.kernel.org/rust-for-linux/20250618164934.19817-1-boqun.feng@gmail.com/
v4: https://lore.kernel.org/rust-for-linux/20250609224615.27061-1-boqun.feng@gmail.com/
v3: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun.feng@gmail.com/
v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

Changes since v7:

- A lot of trait renaming per the suggestion of Benno.
- Add new internal type `AtomicRepr<T>` to make Atomc*Ops function safe.
- Rename atomic/ops.rs => atomic/internal.rs per the suggestion of
  Benno.
- Move `Atomic<T>`, `AtomicType` and `AtomicAdd` into atomic.rs.
- Remove atomic/generic.rs and move `impl AtomciType for {i,u}{32, 64,
  size}` blocks and the tests into a new atomic/predefine.rs file.
- Make `internal` not public, except that `AtomicImpl` is public.
- Other minor documentation improvememt.

Regards,
Boqun

Boqun Feng (9):
  rust: Introduce atomic API helpers
  rust: sync: Add basic atomic operation mapping framework
  rust: sync: atomic: Add ordering annotation types
  rust: sync: atomic: Add generic atomics
  rust: sync: atomic: Add atomic {cmp,}xchg operations
  rust: sync: atomic: Add the framework of arithmetic operations
  rust: sync: atomic: Add Atomic<u{32,64}>
  rust: sync: atomic: Add Atomic<{usize,isize}>
  rust: sync: Add memory barriers

 MAINTAINERS                               |    4 +-
 rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
 rust/helpers/barrier.c                    |   18 +
 rust/helpers/helpers.c                    |    2 +
 rust/kernel/sync.rs                       |    2 +
 rust/kernel/sync/atomic.rs                |  553 +++++++++++
 rust/kernel/sync/atomic/internal.rs       |  265 ++++++
 rust/kernel/sync/atomic/ordering.rs       |  104 +++
 rust/kernel/sync/atomic/predefine.rs      |  170 ++++
 rust/kernel/sync/barrier.rs               |   61 ++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
 12 files changed, 2286 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/atomic.c
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/internal.rs
 create mode 100644 rust/kernel/sync/atomic/ordering.rs
 create mode 100644 rust/kernel/sync/atomic/predefine.rs
 create mode 100644 rust/kernel/sync/barrier.rs
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

-- 
2.39.5 (Apple Git-154)


