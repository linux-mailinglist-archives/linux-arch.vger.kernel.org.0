Return-Path: <linux-arch+bounces-15605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB360CE8B09
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 05:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA993301176F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Dec 2025 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3101259C80;
	Tue, 30 Dec 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPkMx5Gs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE5242D70
	for <linux-arch@vger.kernel.org>; Tue, 30 Dec 2025 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070237; cv=none; b=QLTPDRydK63b+2bJcQna6rpCXIIXQjI8TvzBAHL3tBqUPGNto40V/WOJjqQ+6yxVQ5vYlZOhYEG7w6nI4+lTrnuoai60utAwlBPixsXacYGIfHMc9yM8de5PJ40L+apil7lHWdx6eMXscXW+NG7Hl1CL8CM6XskOXk64i7lckRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070237; c=relaxed/simple;
	bh=xissyskG0qR90M0G1WwgAZAozu2LoD5LNaS70ZDa83U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvuCcEJS68jqZlqaS85UVlFhhd4BKpV0KDHSZQMjhjMQLSo5Alrf1Ic6wQgn/f5/hoFJbXcqjEyrpxvCYOzx+H7OhR1CobdViR/fVbyUu0nX/WH8PtFqOKgsxOYJKhFL6iOmNctJVKojDRqarlCRc+GX+HJDlX9HvokBLd15wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPkMx5Gs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so11834760b3a.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 20:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767070235; x=1767675035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qr+4ta4/jYgKWvFgnJT7af5StHuT6GQN0B6K9K9dWg=;
        b=aPkMx5GsIJPXUE38147xqS3EJmAhxtx5BCF3ai4bEWG6ZJde4pobX95nC9wk71fb9T
         if/af+5KM+UvSSoz0gKnIMBb0F7pnwIIQ35vacXTah7NzLNULl5OtLMTANFQv9LZqPKU
         SpTrc8hwy/7xlFmS/q7eLtJqk0f+QIWfQqcXQ1Y8kSOHpmo0pH7XRQCeFIUFwrtx9QSx
         AUDBXFdXLm1fUXkFk5SaDuD/W7QVRTkGYMOLW5Vv1HgiWa93cIAzhklJVjQZ9DhI2tAj
         +l3ms52ssQyBFTYu14A4hmFsBRURLRMEkWzh+QSvbzD3ePrJrMvrdoqwTe3XCZlMH0ie
         T3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767070235; x=1767675035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qr+4ta4/jYgKWvFgnJT7af5StHuT6GQN0B6K9K9dWg=;
        b=ghRc7k7fbQf6VDk9ANCK02E4zqh3QHaZ9sfs5AIRXwxOp/Yan95rKAuoqh7J/nVa2x
         MsBY3aAMT5AdR1srEyvEgeQlDOsUeHVEdVFCr4vuSun7UaHQE5cVmBqEwUU/Z9kteRqD
         i3Sg0wAiNmfw7/8K6EIJ7WDH8o+2gcyi8HpOWD7xQ0HfNS25gndb3pe5zohT5/Cenjwf
         OJZ655YDRvkcR348s16uXUT9NhwZkT7ii8dzuBT/O0ugiOdixPFrIbVesWIP5ZZH9YbX
         tr33LVBKaWRVJxAyEuLH23T+kh1dAcUVCcfKyH1jMOgLTxX0dLb0/tFIzN/PoIqKTquO
         RxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCCU+ufpeiFAHqqcslPE2ta4q/nmLXB5Nt7C+aFSKy7FEMDeUBViZdTRQkYP7j+MNpMlcLck711KeW@vger.kernel.org
X-Gm-Message-State: AOJu0YxudXLiToPoWkNWHxFFzDs8lDsniJyZBX+b9gE4H1tAbPdCtaX1
	JcMXV8uvPhrE6PTNPTcco+QMjrMHHv2LumNAwOMH3OcfjixyZI9yC04Z
X-Gm-Gg: AY/fxX6b742j43Vz5ZzDrmtHeXmrvDXJVJhKCeqHH8LnKvxFcZEn9ekFoMQP7Ib4G3a
	8SuKC3BPpVWuSXSwwZhYado3lv5i8urbqoMl0+lL901j3f7hMpwL5utWe8FD2Y5MFe1byaSNFaT
	wGqQDjHjeEbDX+fRT/tXzWkfSrF9yYPj5sdli51SV12p3JpvGkgNpiifqXi79F3h2fvKMMdFnyq
	d47pL3c1Qg7JYHXtgByoOo0CWnmD6bVROsgG4uH6ZLHmr2FB+cxG6O9KQkPWgHH41/jUkJF2RtK
	yoQRfoKvtyI09xrzNlCWdeWe2Xw2AdHSwySUAfccyjnpP+e3gUveS0lE+kerCTA3XXf+n0QucPY
	6wIMhANGRM/Twd6mlON+s7fAvuT4Aj15Ua0jW/L5J8AAixemQC70aH39udn46LRm1nOSBRJTgp6
	dp51/tXaabaQTGhw3hMYxlT5MgXW+NR01rLz7Nc7iPFXGGw11ECRBVpZtoT4gQPg==
X-Google-Smtp-Source: AGHT+IHZwqw7WI0eDteGJtVMDgY/WJufMm18cyPwTl5Ld8U0NeYz2hCd2aF5Y/zSFAWmeqs1ibz72w==
X-Received: by 2002:a05:6a00:4298:b0:7a2:8529:259 with SMTP id d2e1a72fcca58-7ff650c7d8dmr27613478b3a.9.1767070235487;
        Mon, 29 Dec 2025 20:50:35 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm31100194b3a.11.2025.12.29.20.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 20:50:35 -0800 (PST)
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
Subject: [PATCH v1 0/2] Add atomic bool support
Date: Tue, 30 Dec 2025 13:50:26 +0900
Message-ID: <20251230045028.1773445-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This adds `bool` support to the Rust LKMM atomics.

Rust specifies that `bool` has size 1 and alignment 1 [1], so it can
be represented using an `i8` backing type.

Since `bool` only permits the bit patterns 0x00 and 0x01, the first
patch also documents an additional safety preconditions for unsafe
`Atomic::<T>::from_ptr`.

`from_ptr()` exists to operate on C-side storage so I don't think it
makes sense for bool. We could restrict from_ptr() via a marker trait.

[1] https://doc.rust-lang.org/reference/types/boolean.html


FUJITA Tomonori (2):
  rust: sync: atomic: Add atomic bool support via i8 representation
  rust: sync: atomic: Add atomic bool tests

 rust/kernel/sync/atomic.rs           |  1 +
 rust/kernel/sync/atomic/internal.rs  |  8 ++++++++
 rust/kernel/sync/atomic/predefine.rs | 27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

base-commit: 13ade169e801a423bc1a5a5c3c6ac680a144a608
-- 
2.43.0


