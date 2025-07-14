Return-Path: <linux-arch+bounces-12722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D09B035EA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D22E3AC215
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148B1FE47B;
	Mon, 14 Jul 2025 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZZ3fPNh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3A1E9906;
	Mon, 14 Jul 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471428; cv=none; b=KcSFLfE5SQWDOU4W7487H+Vew7kWz8McpaTECbDeiLW92sDflq+jhAMhpOh0BRFGfutHWuH40T/DL8/E8+lXiI7adSk2gcvnw4ORY9PqRw/4cF4HNOUJoAOC0HZnVi3bXIkUUcH2wr6bp0Q9FHo6zC2etvZXK13AL1WJCKmLhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471428; c=relaxed/simple;
	bh=iHjLJHszEqHq1s5K6JvEHWnJ24watVghUAp7cxDJPos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=draTaHyLpQV1iYdQ1nRotpjaydERrY8ba5cYxpzWCK9lHWF52uJT4on2/axVWxQcy22WB7DijBlv9N7xilWyDM+x0ekHZ9sckMNyxyyh9YRKS6ebzghQRy1bDdMNb4FOcU/We8Fkz68lRNYtBQt2+WvVuGQHJ+vu4ini+n+jHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZZ3fPNh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab39fb71dbso31395751cf.3;
        Sun, 13 Jul 2025 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471425; x=1753076225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qhcs/TWFlBrU5N46VtyXcCLVqGqYLXRnhyvhBvhsGc=;
        b=fZZ3fPNhe5nfTlYnoqHdOItgce8+KTY19G24UwGTHMt+jSDpmZ4YpTxxLO9PHYLZj/
         DP7IdHmGbCHQkSvR3G1eXlAEPh634xell5+7hUpJmxissi8htFmYabw2sdODSEH8LZvz
         MRbHTic8qcDWp+RnRSvpiNzbHL4sJ3AzRkHbkW9ZPAOOuPDH9aZEvQc0WW/RWTlVS1N8
         cAMvvaFETRPJfrhdpxGa12l66fCnl7VCAdAIj7izkq3PUpI4T/6+Tf/pFwleSsTbdMG+
         nQ7XPZMlF9sm7O0HP32hC5UE1GIoK+aj7ArkE6z1d+PpAwC5wJdOrU3mHpkkzELB+Vq0
         kDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471425; x=1753076225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qhcs/TWFlBrU5N46VtyXcCLVqGqYLXRnhyvhBvhsGc=;
        b=T2xX6f3yCXM7Jtn19HZOVVBtdK5eTTJ5wLrnLIBU2vF+KkKhijknWPzy3Ot4BHz/vH
         klvM6hqiFJao54hs01DcB+6nFM7mh6eHZeLOmyo+gzkfbdxqRV3v0PRZgegUdVoN8Eut
         v4Q98kfcTG3b0Hklv7idknzis7Y/a1K8DQgcu7R1MBmLUKcRA9jobNR+19GM7RHt7beI
         JroynWD2E+j5o+3KseZVmTFVho64LhSp+AEfWL0vUVjvHH59aUMy+NSRJtPPr2P2+bnX
         B+XAs7SlDhKDly3rxNiGZx+QMEmHWIUYVGvWLjY4VRgUP5PAXJPwh2QluH0Ip0W8G06o
         CQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQajPvbK2y0Ic/7G9/mbAuK92T+p3hLXTUWjJFT8Z8JRyeZs7hY3/HpH24K/PS6BDYDjCMpfnk1hrx@vger.kernel.org, AJvYcCVp+2zqz+lW6bkIdVS1NIexuJotOfPKwr1jcDj5zgW7QUpn9A6uSZVkmVWzKjEBBvh3ioM95V9545Y7HEW6bxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrU8ly/rD3hvQgVp8EMtW+3mhcfNaVnIiUsFNbdYDuvGXwd3d
	Xafdlhd/jj+HU4LXMLG+dP5lfpcsClUgJx/9L034BaUvqRJ4uULUOo9R
X-Gm-Gg: ASbGncvb2V35QKwdSiAuY8MKAj0BxgaUA/D4VF5dpHacIsD2tHzzV80H1/0zlGye2La
	P67Dak9U5obG+MGgHqhEaezAUrEa0dBSKyjd/v139EttdDi3rhhvB2V4zd+MgmdI7cZv0KTCRc0
	zlI3eyqjkHp9fZR+a2nhjDpDukxKvJZLgyRkGCBqRTfLjzh/lwiNK5UR3wWQ9TlZ6Py6PkfbRJ0
	bLRuGLwysmpDAdPC8bFS152MH61TYRZzUuzT1T3Z8akoKwgOO/py44npUXSBnlJ/yWi4FlCGFkO
	sI9kwM+Ooxzofgjn/bSEXNqOw5vIDVlXJR7Zk59vSV2rKPFqHs4BJC8GoqQdShGwy2811SRTDjc
	RWg0yFPJvuEjoiS75Pi24iSyoaWJTA2KgPINvhgIi82iuf90j6HZijcm526E73igt8KNhD+kQy4
	T6m99Ermo0vjW3
X-Google-Smtp-Source: AGHT+IFeO40qekGkcTefZighKvWO4HYU8IrbCt2yVdA8YEWYCXGqKt+3KhadXB/eWoKXwgxOz8OwAg==
X-Received: by 2002:a05:622a:15c6:b0:4ab:6b08:9dcf with SMTP id d75a77b69052e-4ab6b08adecmr39762331cf.18.1752471424841;
        Sun, 13 Jul 2025 22:37:04 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edea72cesm46259891cf.57.2025.07.13.22.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:04 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 72602F40066;
	Mon, 14 Jul 2025 01:37:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 01:37:03 -0400
X-ME-Sender: <xms:f5d0aCjPacFsm-BANZv_DDyo9gvjDDMxawUM0IlgleB2JGv8_UZ_aw>
    <xme:f5d0aEqDGlebr63DvYmftKY80kDmnfUqoLLP_ALyvzJx9ujsune0Xjf34hIf6GUIR
    uaIhzrp6V3cZGWK9Q>
X-ME-Received: <xmr:f5d0aIwMaMBATMhzxMSC-2ZTfFLFf6PyYzQtD6qXoaTQnoJghw4X0qWI-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:f5d0aDx3mhgp38rjAsVBDunltXZoPEwmJj_nFpgKwm6k9lcv8WvxLQ>
    <xmx:f5d0aAbD2L3zXWRcTxxjWghu7n9AGWfGHtS9OgiVDXG_GqTr3zs6iw>
    <xmx:f5d0aEl3u-EXZatjHjHkLdy5n8SZRcQ4w-Jolbxsp6Rrc9hpJJugaQ>
    <xmx:f5d0aFFB98y6DRXh4nkDMTRnqXHPF1RdCRNyH1Bwn7ci1HiTN9v0uA>
    <xmx:f5d0aLjoxBsB7JNbZVnD77kwXz6j1ia398NmXgxh45aVa-SEc5bV6M2j>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:02 -0400 (EDT)
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
Subject: [PATCH v7 0/9] LKMM generic atomics in Rust
Date: Sun, 13 Jul 2025 22:36:47 -0700
Message-Id: <20250714053656.66712-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is the v7 of LKMM atomics in Rust, you can find the previous
versions at:

v6: https://lore.kernel.org/rust-for-linux/20250710060052.11955-1-boqun.feng@gmail.com/
v5: https://lore.kernel.org/rust-for-linux/20250618164934.19817-1-boqun.feng@gmail.com/
v4: https://lore.kernel.org/rust-for-linux/20250609224615.27061-1-boqun.feng@gmail.com/
v3: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-1-boqun.feng@gmail.com/
v2: https://lore.kernel.org/rust-for-linux/20241101060237.1185533-1-boqun.feng@gmail.com/
v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/

I think I resolved most of the comments from the last version. I do
really want to see if this can be in v6.17-rc1, please take a look.

Changes since v6:

- Changed the macro format of atomic/ops.rs and improved the safety
  requirements per the suggestion of Benno.
- Used fine-grained trait design like `AllowAtomicAdd` for arithmetic
  operations per the suggestion of Benno.
- Added an `isize_atomic_repr` internal type to reduce the #[cfg(_)]
  usage for implementing Atomic<{i,u}size> per suggestion of Miguel.
- Made barrier functions always inline.
- Documentation and safety comment improvement. Thanks Benno!

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
 rust/kernel/sync/atomic.rs                |  187 ++++
 rust/kernel/sync/atomic/generic.rs        |  573 ++++++++++++
 rust/kernel/sync/atomic/ops.rs            |  265 ++++++
 rust/kernel/sync/atomic/ordering.rs       |  109 +++
 rust/kernel/sync/barrier.rs               |   61 ++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
 12 files changed, 2328 insertions(+), 1 deletion(-)
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


