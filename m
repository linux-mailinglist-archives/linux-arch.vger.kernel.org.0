Return-Path: <linux-arch+bounces-15536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0B5CD83ED
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 07:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 548443032AAA
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 06:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D62FFFAB;
	Tue, 23 Dec 2025 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlUKelN/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A22FF679
	for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470946; cv=none; b=kIrpOtTKcWg1QR6gYkomSbiB+cwlyo6ofuoa3ghxkLQebw3Wypt8kqblTAESb/zdkW2dyTeXsQyf7OdfumKAPuuL1ElCi+41zBvjfMMoFGnKv95fMdfNEaHE9bYcsIWm/B286Tut/IJnC2Vy+NmWMii1CIPiojVb2AA1Fk0bTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470946; c=relaxed/simple;
	bh=vq8ucebWVJ6DbYpYIK7arrOivfQkS5JNvL7qnmUHjxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo0pBklfKAPxjh+/4nIbIBN1EEOILxGkXsKB6iBm5L0hLvJZmTJFdMu2mayOZ60tHtyvqnNz88zxmzvvj6g6WmNH9mF+teKKzqSoeUYzSuEYDy3PmJuoLmT7CgIqhLJTqyN6DL+wQ8WCr0y8Azf2PCH+5CyCUC3U06DWnMZGq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlUKelN/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so3700996b3a.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Dec 2025 22:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766470944; x=1767075744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A23/BwoPpl4iTyohVo4Yx1n36ioI5UQicIsC2zaHSQk=;
        b=NlUKelN/w+G795x3Cz9yX63PMg3Mc8s5XbIpcuiGreGjD6poU9IgLFOUVxPNzPrBSr
         9geSzlpBo3hdSszQZAPs9f1nroMwFd+o+KEvitlJGSqhcWGA4eexoR4Q5AcTlCvDzbT8
         lrLWTSppBEdjBXWqwkKsQcXWR1pta3DFBvTErkrlzZkPaopCcjOzClpNIfYt53iP4eUk
         QKFF2Gi1ZRimcQDT0Tz91rfthzqtBA5zYr41tZn3qp8rT+hVXjCu9/2E1qX2xiVxA+Jf
         vakSvdhGw+s7oNA0G+FBzUVEY3kSh99M2tK5i7+xc9oTxr4MVqb7g/OwEkSi1JgoFxhE
         De7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766470944; x=1767075744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A23/BwoPpl4iTyohVo4Yx1n36ioI5UQicIsC2zaHSQk=;
        b=OuF2MR6xVAxgkW5LcO04CjYhtZw/VVU7r+BtDwGBfOHLuN/9ghTQk3xNUUUJKcsNe6
         59UhBYxzk4tW/LNNor+XlxK8xyPzCTCT8pHHsxkg+VyIG2czvrCvO1Sup7lnaNOxOXZ2
         Cfs/LOvQI1b9c4QjgM3DiJEuHNxAzUYdI00i7zKIK7+lIROsP/xQehbGkhoTbIi8GU8o
         EUBRyf/pt4hguPeGkijYqY/PAF0Ii5ZxDLCh3ka9NYMxA9AcFNgD2xr+SKx9OpJd9reL
         js/6lwW50sI3vptJm8PHRSAFUK1QhvVZ/hcc1EPAMAvcNiWr8ifTD6WSq4yzXedi/H2w
         ubgg==
X-Forwarded-Encrypted: i=1; AJvYcCWCUkyuU8MGpjfFzRsJ3RzsFHFOZn5NxdeTAPMVqPnJjFyp9KkBLmUpFiospsB/MJ3AbzWTX6m/TxMW@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJZhIWErumEVTKyV5asCGNrFqOKo8aZBzKxflUWG06h83rXjs
	lAls481U/6Tl/0KIAft4Y6wVXkB0koxLEcXhyoA1vi+pRhEyxrLomQM8
X-Gm-Gg: AY/fxX4g+33iGSDqL+2YIh6iSEsFwbw1xPbs6gNXL3UJuA/Uu5flIpgKwatVjJA+oYg
	a6/zyA8Ku++dY18qzADiODE/fPIC+Kj+CvWmehG6eN87gEQrlnCmKYHG+5PBW8Gci5vUOgnU3ME
	Di2+xgzyrzKWvKkbO5f3txYIBaMC2PULyhYpDoceyWAB2KIJrN5sOWvIFcNuepFDzG6JZbXb7Os
	CYYNt3z/z9X1CpICZLB4KlFbIt7u9UiZLSV/jpN0FU/PU5lLdu73xxuK8UAmKk6jQNcOHt4+hVf
	lqIIm9Gl8+FzTKAwol3xq+ZP0Tz6akQEq85ldT2WM1lSJtXAeb00fOOje14NwrwHmsGdBtjLxxF
	eoimVhLOq7s+MEjvxH//1doCz/WLWsBDpK7RmNS1GSbfipSqRNbzGYdILrseZem80XwZSw+qIkA
	sshpIkJl/9kuuRmWsUpuiuG0qyKh8IpAikjCiUxw0Vjx0RbkWVpm4OcMGLUdcqqw==
X-Google-Smtp-Source: AGHT+IGvMPYK4zPqautqeC1L9E7p6nNIQWcfDo8nBZ25WN6eA2Xs71rF3b8hE1FBu7lelDSbpjhCGA==
X-Received: by 2002:a05:6a00:419b:b0:7e8:4587:e8b0 with SMTP id d2e1a72fcca58-7ff65f7750fmr13025522b3a.35.1766470943904;
        Mon, 22 Dec 2025 22:22:23 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm12395362b3a.35.2025.12.22.22.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:22:23 -0800 (PST)
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
Subject: [PATCH v2 3/4] rust: helpers: Add i8/i16 atomic xchg_release helpers
Date: Tue, 23 Dec 2025 15:21:39 +0900
Message-ID: <20251223062140.938325-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223062140.938325-1-fujita.tomonori@gmail.com>
References: <20251223062140.938325-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add i8/i16 atomic xchg_release helpers that call raw_xchg_release()
macro implementing atomic xchg_release using architecture-specific
instructions.

x86_64 and loongarch use full-ordering xchg.

arm64 and riscv implement release-ordering xchg.

arm v7 only supports relaxed-ordering xchg; __atomic_op_release()
macro is used to add barriers before the relaxed xchg.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 538e0b10a15b..a48bb632dc44 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -70,3 +70,13 @@ __rust_helper s16 rust_helper_atomic_i16_xchg_acquire(s16 *ptr, s16 new)
 {
 	return raw_xchg_acquire(ptr, new);
 }
+
+__rust_helper s8 rust_helper_atomic_i8_xchg_release(s8 *ptr, s8 new)
+{
+	return raw_xchg_release(ptr, new);
+}
+
+__rust_helper s16 rust_helper_atomic_i16_xchg_release(s16 *ptr, s16 new)
+{
+	return raw_xchg_release(ptr, new);
+}
-- 
2.43.0


