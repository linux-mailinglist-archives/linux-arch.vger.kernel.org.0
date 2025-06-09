Return-Path: <linux-arch+bounces-12296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA6AD298B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 00:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F7616FCB2
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA0223DC5;
	Mon,  9 Jun 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnMMdYtQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674454652;
	Mon,  9 Jun 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509195; cv=none; b=XxZZMq4Msn7LaMbSasmyJzYe2V3Fzi3ZfSRrFYzuj3B5ek3BeWuI8lh3PVqGoe/pOvDXbNW7NWt1n8I+GbROX9MFbd5MV4q6hsEQuA4ih5gb39E4HzXVuArwP3wQ5rPQwa1keUs9kXzeQ0gbE8AdRhmhoA1knk2Qtongam5cS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509195; c=relaxed/simple;
	bh=IEqm1JdCJmQGuOAMdzOGJLauECy2w663mdnt4zkoHAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RlbhkyJB7tpdjgEM8M2Ya2HTCSDo8J/2B3Xae9WlcUpX1iwbg5RB4ybtcfBIhxHKLjLnwim3yC7N/vPfAHLIV9WLogHHfRuxSkF8DD2ckRKbu5g3lZUje0k+aCd5Q+p2EHQUZ72T18WzgnarUxmMx4C4gwqv3sm4fZDutwESnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnMMdYtQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d098f7bd77so549518285a.0;
        Mon, 09 Jun 2025 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509193; x=1750113993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V5UGBtq13GxPtnNntFLWLuUNWSuRazB9K2mUu5fyq/A=;
        b=EnMMdYtQzyrGIkXfAjksPNVV58qWUhO/HQH33C+ukjy79/M/Ibu8ieDNix8OIO/bmP
         1jC83hij98FekEJ3hNiTdZuht5iNKgSgQVKRTyiPTJ6F9CRUOoI1tGPh3cLtoWqwQkbj
         V7rMf7eJ6xJW0a5zopMZusgB3ad38igPBmh5BASveYUDWVKKWfvji6TB6JCD8mHNw98M
         A2BJw5RfFgjBXZOqhhWimO0ekaQygaP0KzcOrFA4Z5L8rn1juEXRcV86MgUP8pvn6q5G
         xnoPXiMX4yyKlXtkY1hke5+1ZZmpfibngBCMeuS9+EaJxoqkgEeszmV3gK804yKvEte1
         S9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509193; x=1750113993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5UGBtq13GxPtnNntFLWLuUNWSuRazB9K2mUu5fyq/A=;
        b=r+Ai3Y5527IcrqSIzvGYqVzNqMbsfL1cOMa7w2UCiQiD+0Vef0RUpqeWQYbsA2TTif
         8/2GN/R6Cq98pwsl+iUEeqj/YojV71b8WXoGli/lkqmmUwa6TOj63rV1FP5ZthqqlSh9
         y2jQGnRgpNLwjWz4540wnFu6iADrl7qSvBvTZss1e3PreBW8O19YNY80r/AgptcaJSgg
         bT/kjTf3obLPgTYvaRJDvw4Y1GiqXAXN1x8gGS2+TqWXRITJjFyBB9NrrCLxa8bLB5N7
         Ef50qsmEkGxR8Upe/ll/s3tDZZ1OcQtv27lNost3dndX6jqcY6A2dVG0GAj2wGnstNW3
         qVWg==
X-Forwarded-Encrypted: i=1; AJvYcCUE1KlHjE7sjcNlZ5SVO2v/bkgFQwcRc6LFJNdgMQp6Ju4zE9EEguVZyEQqCDWnZ04fBgtAC4EpeHV+@vger.kernel.org, AJvYcCWE/cPPoUPwNq30Wodp700dOHU+ynuUc/VSMKo0xRS+6Gnz8JUw6h/6c8aZCqIub3b3mhEfpTspnqckzsXgcME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqiACz5JreikEulMJ5RxbK/2JoSP5/BvMpNPqfK+WXX310nFFg
	gGnzwe3KFErWCy7ThY9n89nRXTEFJszfCMEaBK6HecuVkisA4IZYHP9D
X-Gm-Gg: ASbGncu5xGVv1WfS6VI4J6ucxfqeRgL3wv7cFFak6E7PlNzloAy7GvRyK8ur2m75S+1
	HStqYd/xHh6+KBFjXfJuYu6EcgWT3T4lLRKva50sLMQ+ikGZmwxRcJsJjLxGN7nYCQJfuUujal8
	8i/w/lX3V2mA239xv3xg1NclyNR1e9jZRqcAa7SzmVwXpSfK8osc0djaw9X0m0PA+qB9VwxhKVt
	fcnO9qN7P5k6FWdorlm1ufdDacP5/0pho5bn3S/v7kEZkvX9bZ3OZP+BMtkJgvazPw7HEROAjlE
	1I1JgREv+ZVzIK/satqPEfKC7oLuL/XkxZSMWVsU4FhP+2rQ519W2fcn2C9detxr0SCAFXax8Tu
	f85RAOUJBMGknfIGFbt84mqIQ4f7din1XPMYzfa2cNMGTB1Voyw96
X-Google-Smtp-Source: AGHT+IENOpjPB1yljzfiMwwSApPRUkLli1+qtSLEn+wxBrXU5IyRAiAyOKuFF67UnXoHNcSDCEwJLg==
X-Received: by 2002:a05:620a:4405:b0:7ce:ed0e:423c with SMTP id af79cd13be357-7d39d8a98c1mr206503185a.9.1749509192780;
        Mon, 09 Jun 2025 15:46:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d250f64b80sm600930285a.23.2025.06.09.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:46:32 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9CB111200043;
	Mon,  9 Jun 2025 18:46:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Jun 2025 18:46:31 -0400
X-ME-Sender: <xms:R2RHaDFX-ayTKY_XEAtPlRZLaUJcmcTzMNqXxYt5tMIOMw2ZbL2Qhw>
    <xme:R2RHaAVCotEba3hJ6wiE7eELRHOlN9cNpkq0idcja6IhRYZ5l-G79l5j5_Y7grJlA
    AmDgu-D6WnfWHcCSA>
X-ME-Received: <xmr:R2RHaFLyYjOrAK9AajBPQlvBK38jrTtlHgECn4abbmDU9j_ozl9mBvgLZI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeggeeukeeghfevudektdevjeehhfekffevueefudei
    vdelteeltdekheejgfeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhu
    gidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:R2RHaBFFUoumlD9FVwR97VsnRb_VGE5ZjMU2O_H7o1alcLDtmh6-Tw>
    <xmx:R2RHaJVyBOKURSgIPW_MM4HpqdtbuOrjj2f8vRhRXqQz_Bz6n5bsfQ>
    <xmx:R2RHaMNDGZOUKtvkKEOaibtuuXJlhTBJb_R3RMYe2Rna5oYj4Dvm_A>
    <xmx:R2RHaI2dBFkwHzWUnlTwZ93d9ieuVEvXRJI2eOsDr0qkFL8cJraYOA>
    <xmx:R2RHaOWPMJkRRQo2mlVml8cuv0Ggdgy91zrVbjFfdtJApm9qDyX-HE-k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:46:31 -0400 (EDT)
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
Subject: [PATCH v4 00/10] LKMM generic atomics in Rust 
Date: Mon,  9 Jun 2025 15:46:05 -0700
Message-Id: <20250609224615.27061-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v4 for LKMM atomics in Rust, you can find the previous versions:

v3: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun.feng@gmail.com/
v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

The reason of providing our own LKMM atomics is because memory model
wise Rust native memory model is not guaranteed to work with LKMM and
having only one memory model throughout the kernel is always better for
reasoning.


I haven't gotten any review from last version but I got a few feedbacks
during Rust-for-Linux weekly meeting. I trimmed two more patches to make
the current series easier to review, the current version includes:

* Generic atomic support of i32, i64, u32, u64, isize and usize on:
  * load() and store()
  * xchg() and cmpxchg()
  * add() and fetch_add()

* Atomic pointer support on:
  * load() and store()
  * xchg() and cmpxchg()

* Barrier and ordering support.

Any missing functionality can of course be added in a later patch. There
are some use cases based on these API can be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rust-atomic-dev

for example, RCU protected pointers and AtomicFlag.

I think the current version is ready to merge (modulo some documentation
improvement), and I would like to postpone small implementation
improvement because we are seeing growing usages of atomics in Rust
side. It's better to merge the API first so that we can clean up and
help new users.

But I do have one question about how to route the patch, basically I
have three options:

* via tip, I can send a pull request to Ingo at -rc4 or -rc5.

* via rust-next, I can send a pull request to Miguel at -rc4 or -rc5.

* via my own tree or atomic (Peter if you remember, we do have an atomic
  group in kernel.org and I can create a shared tree under that group),
  I can send a pull request to Linus for 6.17 merge window.

Please advise.

Regards,
Boqun

Boqun Feng (10):
  rust: Introduce atomic API helpers
  rust: sync: Add basic atomic operation mapping framework
  rust: sync: atomic: Add ordering annotation types
  rust: sync: atomic: Add generic atomics
  rust: sync: atomic: Add atomic {cmp,}xchg operations
  rust: sync: atomic: Add the framework of arithmetic operations
  rust: sync: atomic: Add Atomic<u{32,64}>
  rust: sync: atomic: Add Atomic<{usize,isize}>
  rust: sync: atomic: Add Atomic<*mut T>
  rust: sync: Add memory barriers

 MAINTAINERS                               |    4 +-
 rust/helpers/atomic.c                     | 1038 +++++++++++++++++++++
 rust/helpers/barrier.c                    |   18 +
 rust/helpers/helpers.c                    |    2 +
 rust/kernel/sync.rs                       |    2 +
 rust/kernel/sync/atomic.rs                |  176 ++++
 rust/kernel/sync/atomic/generic.rs        |  524 +++++++++++
 rust/kernel/sync/atomic/ops.rs            |  199 ++++
 rust/kernel/sync/atomic/ordering.rs       |   94 ++
 rust/kernel/sync/barrier.rs               |   67 ++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
 12 files changed, 2189 insertions(+), 1 deletion(-)
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


