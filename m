Return-Path: <linux-arch+bounces-12613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7BAFF91F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5619E3A4E3D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83029A313;
	Thu, 10 Jul 2025 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdGuH5pO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA0292B37;
	Thu, 10 Jul 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127262; cv=none; b=AN9Nk0fodNvKLlTKDHaNTZSSD/PHXoOK3yLk6y1H1I7HltqbqSbqr2OgT0BcXAn7XG3TguldHnE3MlyFxSfQEt4fjObQwXNpBU1tmjSQps8RZFON995/lkOkvIVhNLT7vVd35lOlwTCpUnBx9eOcBE1qH/XvFFlPBdNWnjqrtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127262; c=relaxed/simple;
	bh=clBkOKdOt3OPliSRUnnc9ikSUOgMniGHVGWMvtSIp5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4wiJhUFgqEbLR6uonNey3kebd0YcyUnpiQQ6+UILzo2+KcM6VTcXTePmwYkX1PArRuZzf/QDlcBHxkQjF12J3TtUFSZvLdhMPEL7A29p1UyzZdnfxntv6ns69oob+HAyZFX/pIZuU8tktb9IolD4JfsHG9RPd8b/JvScsz+MCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdGuH5pO; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so9484621cf.1;
        Wed, 09 Jul 2025 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127258; x=1752732058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4dkxON11nGIA5NYLSI97c5y67hFYtsqVKB22BPIBIMA=;
        b=NdGuH5pOorQhHEUHfnvKhBpwrVchuKIRNQosSq0S5aRhm7KMkmpQBd5ODVy50fW7dV
         qA0BHpf4iD4DIwg9rCzQFAZIMjHSTfggQ5nEVOkeHitQckpeUbnnKec3bj1RjQLAZgjx
         tKo6nucfL+E/i5jVty6shOXc2sOfA3pHnx5tapQLDY+G1DBUqiXog0Ii5he7QBbdqhW9
         jUv4yxgZ8S3ZMru2E3ybNuwnpfFOt2PJbmUcfZUMJjNCP+1XHC5kUWx4zABtYA2Xk77p
         jhDPFrTkPZzX9L4Dd84YSZAG4yibN16/cIsCybxFzPgqgXGtSwERsPVu6C7d2D159mTY
         pvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127258; x=1752732058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dkxON11nGIA5NYLSI97c5y67hFYtsqVKB22BPIBIMA=;
        b=THbQKTIEfNUYidiuuUUQ9NMCkS0tK8uAce/Hjw63efmvN/I/VGT4+SvZswfjRRQ+Ib
         8tAxQdUz5AEbxuTEYvAstsWlUH2kQGAod27fwzipSZ5TrzZBuEJGwwjDzhFO2XspVtm/
         0Hcx6GYaFoHpOY1lrj/2f4vJMeNeItv5VMIhF5TGLAjCofytVDu46J87twVzFm8/BpdF
         9hC4uXif3bX+RdvCiCnMc9utqw4w7wQQJIA+X6In6kb8q/HuNdxQOXQzpJSbXbUXk/sO
         kE0scZkJKdK1AUjRBNHRviGF1RZ1xkZMYxfxzcmqiFtB1gN1V6BXdvtqGKdkXNlckEjs
         wPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbSkdRqXkJ1B223eSTewJFHk0sMb3I+xFsBd5xgvboJQI1YzTF0Y5ABLd2yHCHp/t0a3hgW1RRS+ydPDk0ziw=@vger.kernel.org, AJvYcCXCCi7bnC5ROfvnqx9MhLtw86e8zMCwG3lB/1TWRbkdIo751uo7RB96/zdL67+uNraxWYvmxXv7fSo/@vger.kernel.org
X-Gm-Message-State: AOJu0YxfecMXhupyfkINiXWOGNNSlvqEBO+mMVU0fYJiY7KnhDVC3gZQ
	FpqH8yqudMrms+N/CpNO/AMdk9HBHzWf6AT2gBZRV8lkT/ysQgRVs35j
X-Gm-Gg: ASbGncuw02xCK/GmAx1CZCuDupf6l8/CqhLFU4e92I5e+XdXdFno5egihW7kpSErd8P
	1bVOCuAry4WZK7/SsO7BytkBzCTWXtYEE+vrlHCMLwVsvwEOZHRSxNfhq1K/Ey71NDrxxGyitoy
	srDdDo4FWQwgqzzk7gyc5t7ARB7Utufs73aTU+VHGbBv9pZoBNJhmwACs8GCH29pQ6yhXOczkKB
	DSkNu6GA5KAUxJfQk/Yo5A5LT8ZI66j9BUF4K3dVJmMjR61a3eX8Z3Dc4rdC7BfQ1mhlZ5B+Xhy
	sccS0vDI9ZSAjX7sv8A40sJH9idlB071e6y2EnRaCviJ41yMY0V7E0f4TPUBqMDKnmbWTa/u4zb
	BheSOhP6BLhfh15n3Y7b/4klJGMOeiEpFn2G4b8jLSawGi6YaWtrK
X-Google-Smtp-Source: AGHT+IEk0zas89MOBG4S4eZCmPaCtlBUN7QCZh+Pr6ROSTJbtHRJobeIQcYI59LjAeJh/0WNTD+zIA==
X-Received: by 2002:ac8:7c55:0:b0:494:7e91:eb4d with SMTP id d75a77b69052e-4a9ec85346cmr14881931cf.51.1752127257573;
        Wed, 09 Jul 2025 23:00:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc201b0sm5611561cf.14.2025.07.09.23.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:00:57 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 58A87F4006C;
	Thu, 10 Jul 2025 02:00:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 10 Jul 2025 02:00:56 -0400
X-ME-Sender: <xms:GFdvaKj-HoCkhDVpCKIv6t4kDdrR23Y7gUz1c9P5NYxFZ_CudURyCQ>
    <xme:GFdvaMjGriLVVArgyY8EpZlqguxdESxVQmFoBDvlLWtUI-vUXKUog-dkswr5MuWIC
    yNlU3BhDtFSk_Pd0A>
X-ME-Received: <xmr:GFdvaGqycb-fBnUpoQUQJ-tw48iKp-zYzbX7HlOS2CDlhSNwE0i7YP119Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeijecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:GFdvaCzdXbM5uJkcGYM_EKoUBhcK6m64V49ohJLpKWMOqk3Pz_gUFQ>
    <xmx:GFdvaFwLNHjqZCG7vTNDMSqoUIRr7ChOC_hKUNu5MiJSQFO5lpKmVw>
    <xmx:GFdvaKaU0bpodEj2bR4fbWfGGWxzl5OuZHEsZK4rloOAqJcMl4UXjA>
    <xmx:GFdvaGl4giPw6wG-au7OmvlEsY4FCHK8rkX5o9fwiawnG3WJK6W80w>
    <xmx:GFdvaPF7NWMB1mFzoW8RmnJxkJIzetKaOSGFWzFHKVaXrKLcVN1mOjFr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 02:00:55 -0400 (EDT)
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
Subject: [PATCH v6 0/9] LKMM generic atomics in Rust
Date: Wed,  9 Jul 2025 23:00:43 -0700
Message-Id: <20250710060052.11955-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is the v6 of LKMM atomics in Rust, you can find the previous
versions at:

v5: https://lore.kernel.org/rust-for-linux/20250618164934.19817-1-boqun.feng@gmail.com/
v4: https://lore.kernel.org/rust-for-linux/20250609224615.27061-1-boqun.feng@gmail.com/
v3: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun.feng@gmail.com/
v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

I dropped the support for atomic pointers for now
(Atomic<{isize,usize}> still exists), because further more work is
needed to ensure the implementation could preserve provenance [1]. And
we already other series depending on atomics [2], so it makes sense to
get some basic support in-tree.

Peter & Ingo, I take it that it's OK for me to send a PR to tip later
this week or early next week if things went well? Of course, any
feedback is welcome!

Changes since v5:

* Replace `as` cast with `ptr.cast()` in atomic/ops.rs per the
  suggestion of Andreas.
* Explicitly document `Acquire` and `Release` ordering definition per
  the suggestion of Peter.
* Rename `All` to `Any` for ordering accept traits per the suggestion of
  Andreas.
* Remove unnecessary fields in `AcquireOrRelaxed` and `ReleaseOrRelaxed`
  per the suggestion of Gary.
* Add round-trip transmutability (thanks Benno) as the safety
  requirement of `AllowAtomic` per discussion with Gary and Benno.
* Add doc alias for xchg() and cmpxchg() per the suggestion of Benno.
* Examples and documentation improvement.
* Applied Reviewed-by tags from Alice and Andreas.

[1]: https://lore.kernel.org/rust-for-linux/aGg4sIORQiG02IoD@Mac.home/
[2]: https://lore.kernel.org/rust-for-linux/20250709-module-params-v3-v16-1-4f926bcccb50@kernel.org/

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
  rust: sync: Add memory barriers
  rust: sync: atomic: Add Atomic<{usize,isize}>

 MAINTAINERS                               |    4 +-
 rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
 rust/helpers/barrier.c                    |   18 +
 rust/helpers/helpers.c                    |    2 +
 rust/kernel/sync.rs                       |    2 +
 rust/kernel/sync/atomic.rs                |  193 ++++
 rust/kernel/sync/atomic/generic.rs        |  567 +++++++++++
 rust/kernel/sync/atomic/ops.rs            |  195 ++++
 rust/kernel/sync/atomic/ordering.rs       |   97 ++
 rust/kernel/sync/barrier.rs               |   65 ++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
 12 files changed, 2250 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/atomic.c
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/generic.rs
 create mode 100644 rust/kernel/sync/atomic/ops.rs
 create mode 100644 rust/kernel/sync/atomic/ordering.rs
 create mode 100644 rust/kernel/sync/barrier.rs
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

-- 
2.39.5 (Apple Git-154)


