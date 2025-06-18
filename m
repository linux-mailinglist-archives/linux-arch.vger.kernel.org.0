Return-Path: <linux-arch+bounces-12381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C43ADF2F1
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B7A7ABA3D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509E2EF9DD;
	Wed, 18 Jun 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6DxLjIL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB72F0053;
	Wed, 18 Jun 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265382; cv=none; b=GkLOd9rkNmX1iUa9LZ7cjUbz7cx3TAbA2mvXkh8e0R5IePsV6bq1AJi0fjwnOATERoRKZiLNsS2ReTrm7xyGzCX8U/CZn9FrK4fQ7bln4iJMnfeCbepUXTjprx5i5nMjE345gkxnWsvl6xhiVqOKvl9Qq1elv6jX+n8IdG2TX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265382; c=relaxed/simple;
	bh=9mP5MxUgs9RWMbl19nVAvrHbVqhzIEtGpLbygPd5vdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXVZpJ/AOIzGrpOxUwXd+ptIuosiOu05BxloPNn3W2uDD0pWwzd8K5JBYu5UV2Hp9fJSvvMthVCwguZXkbVQJw3cSbVZ0bHbe5WeRFAympAnQVgkVGPcbHXogQzadg3cH3He6bF8B3Z0BhPXpUdzMIYys5Tg4MRWpVqYaBLF78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6DxLjIL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d219896edeso800338785a.1;
        Wed, 18 Jun 2025 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265379; x=1750870179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0p/zYCkfYb3q7I+SyNYIQjc1L7AsOX0EyXyUuKKC30M=;
        b=Q6DxLjILm9HtxTnQbZ8c+1iEKPLKuzV7dYafgyOwcv0CxztxpM84odl0QTNtDjuszi
         csOW6/iB+9Zw+ZlfQ3XP1k8imrASznFOW/wnxmZAvtXuP7N7/Egw2BNzQQuz/UPkGYH4
         UZgGiGNEGRPI3PQm/pmX3jS3a+0dhsVvBuYE41m/Mu5W4JJmwbNpC71ZPKkSee3bCDrB
         K22lCON9SargTH6sTsZOH6WSzp5cK4/DTigQ/+P/Jx1mly1SIVeJY7cfQpp0azEfiFrY
         VBZMjm9uY2BlU3+swdp90gCBXelAULVfPWHNoe+XRBNhKG0UC0i3FDxJPfE+sRvCS8g7
         PS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265379; x=1750870179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0p/zYCkfYb3q7I+SyNYIQjc1L7AsOX0EyXyUuKKC30M=;
        b=r+JJd927lZ/jZwCd49zsqRXG/8Pe9IWyc7kGLHWfJYJMW30L2TxmfnmdEUouNr5KqW
         Gpf62hrX7MyetMz/tKzcjkNIELZIyU7spw2e+AzS04BFtFOlNUMSedqn3vjbkgodn+Qq
         km7od+1V2AYCo0hPaj2fBn+sIUvHu4lYdX1yiHf0CUAS9DeZE0uFThAnY36tGueOr6z0
         b1uBmu7DD9sOMT+6e8DCmCCTguAptjQCGAjBAOIrGg5Ku/trMMpjtOejcXaoK9+lbVHH
         hl145ZZ6iStzcCJWWBquMlfHaK7CHFXLqXAYyk7d6NndAWSkdgezlRiJ2DI+Jzme3jMm
         9XQw==
X-Forwarded-Encrypted: i=1; AJvYcCU+xKuN5KYxxzRtcuIs4qN/73t5sWyEyzCL2oB2hYMEEEs1Qm9GoHHR8OEsFYzIDqlIxomPRipNx9gH@vger.kernel.org, AJvYcCVSdhoLw6xiKqltOBdJqbGy4ybFvu54p6MW1WJNIvBBoRMQ4/0+ar0jrTzBSMRTamUp76SRikxZJwJ1FnxGxdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjj+uEo6vTjDNEEOMMWb2ykepc5W/kfbfM0SGLHRWmcOc9Nxdl
	nr8f9UT7M8Fgr4p03Whrhf9aDb8tNb4k2cTx8HxQYGwxnQroCmahE2i/
X-Gm-Gg: ASbGncvRbaFt88DZ0opFV3Rmx8Sd/zgJECxPFtsQWlKjemflf3m8jDJk6+9KTLsYGdb
	ZKd+vrX6VVqGGym1WBkKGlmCqP+WEEQ/2BJp0qbdLwjjsfeSwZFcubwblWWjlIXFgKsJz62tyMg
	DSTGO5Vk4oufB9wbM25mQVybHQ6c1JKeyzAW8rpPAM0IXRABsePtbXrjJpuOafIILJ+77+ncR7v
	hLwOnbZsBxvBl0UldVwP+pSk9kVKDc4OTYu711D4wSJPlBOLrxcxhcxef+RAa7tqVWigYiROU/B
	jKU98ItyDMy9KgGH83PvokgTXaWunXD476wspojAruJPFyG3quww83Owk0/tS2mmrQMqakvenpJ
	EMO3kOd/7z768u2aPXEQh9xyplzhlu3m+IDkii3Ce3RxeQBmq/J5n
X-Google-Smtp-Source: AGHT+IEhcLGc2UeY+9z0aWySUyn/shT48csoLk6ORNprMbEKw6NLOoJme6+One3cz7IPbxiAkzP+rQ==
X-Received: by 2002:a05:620a:31a9:b0:7ce:b9ed:24dc with SMTP id af79cd13be357-7d3c6c1f5c4mr2762499185a.23.1750265378759;
        Wed, 18 Jun 2025 09:49:38 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eac7efsm783780085a.68.2025.06.18.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:49:38 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9FE7B1200043;
	Wed, 18 Jun 2025 12:49:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Jun 2025 12:49:37 -0400
X-ME-Sender: <xms:Ie5SaIE1noxV3i3ha4rUeYingQLbhgkuWi81CA5teNR7cqXBzXGDqw>
    <xme:Ie5SaBXKUHysqSvFDuEA36ME5dxN9qmiXrH4GumA9FDMxQMtVVPa_wVYUHo56M9uH
    pWwQJfPyuXBBZbzRw>
X-ME-Received: <xmr:Ie5SaCJBsfxyqX68E0bj4_cLs6NpBzDJNbbnCnvk2FTuLeX-JFCODNXFZHcRVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefudeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Ie5SaKGzOKTvePTyfeVuauVevdJ-DTTtPtjNkEqygnqMeC9P4QjFDg>
    <xmx:Ie5SaOXlNlD9M2izGP9Gz_UzeBAyuu5EKa1iFB9FZBdsO5ZQPpLdiw>
    <xmx:Ie5SaNM87n_yof_SwIdoC3urVKOVTqBq-M8B-5RLrOQ2U_7ZI26HgQ>
    <xmx:Ie5SaF0JNwIptUT2X8gtuLv87rsgPEOa0Z64nD9zMInzeqkwpmhklw>
    <xmx:Ie5SaHVXRbSdN7O96KA9cs9UwujNKSbt-9qndpVHZ2QcRPismPe6dccp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 12:49:36 -0400 (EDT)
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
Subject: [PATCH v5 00/10] LKMM generic atomics in Rust 
Date: Wed, 18 Jun 2025 09:49:24 -0700
Message-Id: <20250618164934.19817-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v5 for LKMM atomics in Rust, you can find the previous versions:

v4: https://lore.kernel.org/rust-for-linux/20250609224615.27061-1-boqun.feng@gmail.com/
v3: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun.feng@gmail.com/
v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

The reason of providing our own LKMM atomics is because memory model
wise Rust native memory model is not guaranteed to work with LKMM and
having only one memory model throughout the kernel is always better for
reasoning.

Changes since v4:

* Rename the ordering enum type and corresponding constant in trait All
  as per feedback from Benno.

* Add more tests for Atomic<{i,u}size> and Atomic<*mut T>.

* Rebase on v6.16-rc2


Still please advise how we want to route the patches and for future
ones:

* Option #1: via tip, I can send a pull request to Ingo at -rc4 or -rc5.
* Option #2: via rust, I can send a pull request to Miguel at -rc4 or -rc5.
* Option #3: via my own tree or atomic group in kernel.org, I can send
             a pull request to Linus at 6.17 merge window.

My default option is #1, but feel free to make any suggestion.

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
 rust/kernel/sync/atomic.rs                |  233 +++++
 rust/kernel/sync/atomic/generic.rs        |  523 +++++++++++
 rust/kernel/sync/atomic/ops.rs            |  199 ++++
 rust/kernel/sync/atomic/ordering.rs       |  106 +++
 rust/kernel/sync/barrier.rs               |   67 ++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   65 ++
 12 files changed, 2257 insertions(+), 1 deletion(-)
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


