Return-Path: <linux-arch+bounces-15562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCCCE4B78
	for <lists+linux-arch@lfdr.de>; Sun, 28 Dec 2025 13:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D923A3005303
	for <lists+linux-arch@lfdr.de>; Sun, 28 Dec 2025 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E661DF755;
	Sun, 28 Dec 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZI0T2zd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A536154425
	for <linux-arch@vger.kernel.org>; Sun, 28 Dec 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766923607; cv=none; b=GAgbekTnxhtNUk2/hudAY9ha46W4T04kxoN0tP/gjWDmPChJ9B790/Ca/2zMksy8aBRjdS2rD6MfZ12lCaJqczW88sjMrwli4xcQKYAXZH86dPOCep51vPzx5V8BGwTD/gCCg1tvQZAnzzpEJ61xaVic813y+b8ZACo/2ueGtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766923607; c=relaxed/simple;
	bh=9zf1QRozT8KCsiIULA6btPDXdgAwDzaGF817jMCueAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odBZvAsb6I8GZQX2Xc2G3RnzriND5Pe/mONBJaQE57VzCoWDuAJYAQA0ZsSc5Rn7xmEpIMaSZAzWh6LmTi3eqaCjEuVsSlSfvzupK3a1vrcCw8A89aVnYkjI5P9ZGBoZeTshqrlJIsjlAT5qi8h3Hq0dkKqOS4CtO91dqN+nAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZI0T2zd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so6428785b3a.1
        for <linux-arch@vger.kernel.org>; Sun, 28 Dec 2025 04:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766923605; x=1767528405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5+s04JKeWMqoE6uzvVDsiNFkvM4oi1f/jyWCaBJv8Y=;
        b=MZI0T2zdlEboGQtrVokatzA7/AJB+gv0vhH1vIDI9/D6nUIrMs51wcx6C0+Muzo3Sj
         cZ8RpvTtHv/cCikpmdoqL5Pyp+ekSeu4DdOI/VhvoxtQDTPN0Mxu5Hq/eKGc5hJ5HwQF
         SgtI6Qj37cEIBki0aNB4CQWrQEPJaCN2aeP9ZmBGCY49tZtL+jpVia9fsBSjNICqFZdA
         B6xL7ENpWVnJjS3PV2Sc/2NjPCJFNxhvzQjJihE1QjFHIzBxHCfVbFYRnVfmnMD6ad+E
         tBllJBspeKh2QX4dl4PvtcVniwn246WRDjhHeB/3alnBsreNeMhSk6F7JHmYtGpyufP2
         GC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766923605; x=1767528405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5+s04JKeWMqoE6uzvVDsiNFkvM4oi1f/jyWCaBJv8Y=;
        b=ZtW7MfHcY0ljQdx/TAipxD0Axaq1HVxgSPIhEAl5hU0VbQCivjzHh5wastwTYA1y4p
         LGSil2FZReFR1SzmJKgo8f+tI7uR9FrUnqaZ1e4veD6FPf6qRYq8IzUxHdfiFV8ttZoQ
         SXsGJxt6g4AoNuCS8CMaRvgM2/zjAfH7eeBPcRE4EePKJrx/RGvpPgoOwxJ/gDTWc4eb
         EoxrEw5sAFFBZAfMxjdg6VCeoAgxvGel2TqSWy4zhi5fm2NbuZNJkTIy1VxPtmVSAsDT
         lv5LN1cgQEOoFZskjBBCL3xMw7g8HDXv7WkNPk48Glnxo64nWAmSTeH1EyW1hhgbQY1m
         Th+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMOo8SPnP7ZPrmefb9e9vP7X6jyhon0H9gfKRiEk4nr4j2ShNLVdjv0bIZUgIU6UhuSYBuyqmBogBj@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvVestM721iZf+vpg9oRIM72Xe04NbN4niM4Sey2pva8s65L7
	ZX7VAbpQHEP2rtB6TUjs/wbUT/iZBRRD9f1BxozkikRBzQuiKSav6pU0
X-Gm-Gg: AY/fxX5IvPUcHVboTRNqvz4XKgfYLJReLfbfopt9CKDRLWpUQ1y8NQNPaJnp0wWfkDi
	ZguMLYKToVi4dHU6BA3UfR051bVX8UlL9IFHD1HSeyFWVoGNlkY/rD02H45NsodPHmX1ZLfJP17
	kXk8mQFp+0GJkrQX6TEdf42Bbfs64ZJh1pqjw2z4aaGsNIkFRJT2Z4B3jRavtgLnZKBNsei9u+K
	0V2QwN8QZQfUn11BMDlvPQkkI9Tlw3/tV/J8+QeCmNf48ErJrh8g8rOsw7vg72fX4z72nxXA+eI
	5nHAkgJteUV9ztO9wnuR8HfkKcxXNRfKbnprvWhi/lAtlQocbS86Zbcs5HMS5YJy/efabp9qvzk
	WUaKSdegEps3uHFCZ+cNH+G250bSqQKUouHRjCkHFxc0tXOB5SHLGK92BNW54NM06yOAvcgr31D
	agtoGygMuHf+GnL28xi//I5pBoa0dNzx0vum+vxswoA4WuxtwZMVil+UnakuPmEw==
X-Google-Smtp-Source: AGHT+IEH0HhKRno9jgQ/Lnv8hPD7TbN9TvtV127+wdIfm3ou+vBVe+R48oUqiWCyYmbaTGcV5nB67g==
X-Received: by 2002:a05:6a20:7d9b:b0:355:1add:c291 with SMTP id adf61e73a8af0-376a75f5bb2mr26479761637.10.1766923604676;
        Sun, 28 Dec 2025 04:06:44 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dccd14sm27914829a91.16.2025.12.28.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 04:06:44 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com,
	ojeda@kernel.org
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	dakr@kernel.org,
	gary@garyguo.net,
	lossin@kernel.org,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v1 0/3] rust: Add xchg and cmpxchg support on i8/i16
Date: Sun, 28 Dec 2025 21:05:43 +0900
Message-ID: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This series extends the Rust atomic internal to support i8 and i16
exchange operations (xchg and cmpxchg), in addition to the existing
i32/i64 support.

The macro structure is specialized around i32/i64 so i8/i16 has a
separate path for Basic operations only.

This series generalizes the existing declare_and_impl_atomic_methods!
macro so it can generate implementations for multiple backends via a
type-to-C-backend mapping, and uses that to add i8/i16 support for
AtomicBasicOps (load/store) and AtomicExchangeOps (xchg/cmpxchg).

With these changes in place, the i8/i16-only
impl_atomic_only_load_and_store_ops macro becomes redundant and is
removed.

AtomicArithmeticOps for i8/i16 isn't addressed here. There is no
corresponding C API for i8/i16 arithmetic atomics. Adding arithmetic
support in Rust would require a Rust-defined implementation that is
consistent with the kernel's atomic semantics and the LKMM
expectations. That direction would move away from the current design
approach of "using LKMM-backed C atomics for Rust code", and I'm not
sure yet whether we should provide i8/i16 arithmetic atomics.

This series depends on the i8/i16 cmpxchg helpers series [1].

[1] https://lore.kernel.org/all/20251227115951.1424458-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (3):
  rust: sync: atomic: Prepare AtomicOps macros for i8/i16 support
  rust: sync: atomic: Remove workaround macro for i8/i16 BasicOps
  rust: sync: atomic: Add i8/i16 xchg and cmpxchg support

 rust/helpers/atomic_ext.c            |  16 ++--
 rust/kernel/sync/atomic/internal.rs  | 131 ++++++++++++++-------------
 rust/kernel/sync/atomic/predefine.rs |   4 +-
 3 files changed, 76 insertions(+), 75 deletions(-)


base-commit: e24011042180d038293182de25eaaa21b8829050
-- 
2.43.0


