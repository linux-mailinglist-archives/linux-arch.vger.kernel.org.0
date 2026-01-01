Return-Path: <linux-arch+bounces-15629-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7DCECD41
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 06:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D351830052C7
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 05:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115F1AAE28;
	Thu,  1 Jan 2026 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaPqlGt9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250615746F
	for <linux-arch@vger.kernel.org>; Thu,  1 Jan 2026 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767245594; cv=none; b=c//nCC9rFMQMcwOOYzlDzXEM3mCvOWEL/I35EJ4QSttw0AIM3KYp9l+XtnRbgNgLa/R+5CeUVvfAQF8/tV8BTcIaL1gMkDjlsrYmGYl2ninkys1Gq2jGqFCRRzTepqyLATnFp8i76g5qg2SbpBsSNHNktSsYtE6m0k2LMVpucHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767245594; c=relaxed/simple;
	bh=U/2E5GAtl0oNkf5HxUW9QvEBIlT1L87ssDSpWmoqdGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mU4wLeItoNV2OkJLDhi7IbokXV9gGAHqYRfxfXAnT1Ne9jDxFjZGJcmJx+ma0miAfqnskNhzh9/h8/XSrVExCnHZA0o8fli1sgCRsSMTngDx0d7y86f6NZG9p1bI/wJGRDlzOsQxQBNR2wTumh+VNY8hsB6qIjls9Nx+jZ/afKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaPqlGt9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94130b88642so7551043241.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 21:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767245591; x=1767850391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZUb8hdR1MjA8tGqWbXzEvPck7ntlz9IljAIWpnnPqY=;
        b=OaPqlGt9vp3wHg00JnavKY+0fCKFG/K75reG1sGoHQ8/RQzgKYY6QoN3uCxsrwlyYt
         zY/1ONTcgCEINWVoyFs3FfzgKNYRjP7mAVAbKMxZeG1DNUyHiQqV0BIohm02YdKaVhk5
         mw97423nek1il4vIqtc1TTLJka4a7+ohfn62TqKDhaUXKMq7RRqC/gU7W9d0D3MruOqc
         01Rvnqt7QxfLPqs7VBYYvO52yvGYhBWRdzRe+/Re77IyZOcq230EmRgHheOd86p/l96F
         /Rrk046t1MOkpUYE0v7mgRZUB7XSY9qqbb1p9XPVU1zmh7ArOpqS+tTKkDiwnDiRPw2l
         WVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767245591; x=1767850391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZUb8hdR1MjA8tGqWbXzEvPck7ntlz9IljAIWpnnPqY=;
        b=cHMLuBzdGmmvoelwVTMP9TsWAjXtj8YRvz0GMjuu95z6q8OD7P2G1iOGni6WP9mF6G
         7ibdlJ3yl3U9YOJHsieGVN1NusmxcXkr+/KMmjZRDBSwrD+B35wc1iITtoeEv9gG/C75
         pQiHWkfv6yF5WPn7dxbekbPLpfcDXKeMpoTKLsVVPwLK+wtOc/Xsdj3RO4daJjmzhX0b
         mkoMRooyBU2pA+/me90cbjArSAw0/bOhM7saTUwXzNgfOJgytj6iMw4Byhql6N1GtPxV
         hnRwrNL9hpsuCnDgHLD/1bQXzhYgzYTLbuRwzFaxYuu2x8QW9zMo/e8LGVz9fhTBRavw
         kZxw==
X-Forwarded-Encrypted: i=1; AJvYcCV/HxlgmyKk53Hqxurqwa9RNkMdzQVt/o+pu7bDc8hvG+Q8AFiBu4R83Ie3aazZEO0KK8u32nj8ecoz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZvYw8kaLqstCwnO1bozzlbDJtMRilcVjTaCVkzL9Tb+7pduu
	/m3k1iADVBMZzMN2PsxB8oSVuSfZf62CyZFQ91hZjkWbHErHCjRyjyRz/n4A/g==
X-Gm-Gg: AY/fxX5x5B3rMuNaWFPlUU6jcKtmHU5VbN+J/k3hd0i8AmJyROI+2JYQyyoFZ9VBqZu
	+DfgvqE1LcnCXg+Hcey1T0KYF4pOJsTz8oojlyd7SgnG5nqoXepoKLvBwhh4v3kRwPX1oiDEQ/P
	5/BR7HGFVddFlbR2HFAiIoGkWVfva4YTpQ/Xx4aXWjj5deIKOHKLpyP2LtS72zpvvHuozPcpBRm
	3THUJ7RYLboXg3Y9P7SaYHYZvznNhBmENrudw83ToCke3+jvVr/Hj2LQhbxSqoVUj726NqVh+pG
	zDvdbfb8P4ZPUZGnUOujUxWzPc1g0qg7hFTELzu7zsHvTPZFpERd90lUtMjQFijyvoWuLQMgE7C
	UXVhVS79usCmT467q443yaKYzJmESSz25fEZ0eb295eo3xiWjA3Di+iAfEltUaD9PLE0tkYYq9e
	vRRSOWvALGuLta30rjXKcWw9N7w7N20dmwfprXVzI7bGRcDf4jyCvR+YikvQE0+g==
X-Google-Smtp-Source: AGHT+IEjXyvhUStbq4NbgwuhfHvz74nxQrKyNxHcNj94GYGjT6NKWEYz062187dzjz2wsor2aKW0LQ==
X-Received: by 2002:a17:903:22c3:b0:2a0:d05c:7dde with SMTP id d9443c01a7336-2a2f283b5e4mr322433005ad.44.1767239432629;
        Wed, 31 Dec 2025 19:50:32 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm341874445ad.34.2025.12.31.19.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 19:50:32 -0800 (PST)
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
Subject: [PATCH v2 1/2] rust: sync: atomic: Add atomic bool support via i8 representation
Date: Thu,  1 Jan 2026 12:49:21 +0900
Message-ID: <20260101034922.2020334-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
References: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add `bool` support, `Atomic<bool>` by using `i8` as its underlying
representation.

Rust specifies that `bool` has size 1 and alignment 1 [1], so it
matches `i8` on layout; keep `static_assert!()` checks to enforce this
assumption at build time.

Link: https://doc.rust-lang.org/reference/types/boolean.html [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/sync/atomic/internal.rs  |  1 +
 rust/kernel/sync/atomic/predefine.rs | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index 0dac58bca2b3..31ac4c83b1a5 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -16,6 +16,7 @@ pub trait Sealed {}
 // The C side supports atomic primitives only for `i32` and `i64` (`atomic_t` and `atomic64_t`),
 // while the Rust side also layers provides atomic support for `i8` and `i16`
 // on top of lower-level C primitives.
+impl private::Sealed for bool {}
 impl private::Sealed for i8 {}
 impl private::Sealed for i16 {}
 impl private::Sealed for i32 {}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 248d26555ccf..3fc99174b086 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -5,6 +5,17 @@
 use crate::static_assert;
 use core::mem::{align_of, size_of};
 
+// Ensure size and alignment requirements are checked.
+static_assert!(size_of::<bool>() == size_of::<i8>());
+static_assert!(align_of::<bool>() == align_of::<i8>());
+
+// SAFETY: `bool` has the same size and alignment as `i8`, and Rust guarantees that `bool` has
+// only two valid bit patterns: 0 (false) and 1 (true). Those are valid `i8` values, so `bool` is
+// round-trip transmutable to `i8`.
+unsafe impl super::AtomicType for bool {
+    type Repr = i8;
+}
+
 // SAFETY: `i8` has the same size and alignment with itself, and is round-trip transmutable to
 // itself.
 unsafe impl super::AtomicType for i8 {
-- 
2.43.0


