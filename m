Return-Path: <linux-arch+bounces-15533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF6CD83E4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 07:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FC23024E64
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9348C2D12EB;
	Tue, 23 Dec 2025 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsknRvkQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E972FFFAB
	for <linux-arch@vger.kernel.org>; Tue, 23 Dec 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766470937; cv=none; b=mDClDgVQt7t8rp9Afr4jfjqT20lzxiBQBDPycAzGU9S1+cruOShwijoykSVt5/VF1j/UwTiSbPAe8XHLsoQajsX/n9oGUBvbkvDtBoaTvyAulTC6GuTFyvYEjYjZUomDGP2wsQRIq2OEV8KacZFmhnE42QHczDQOxBvuj1wRR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766470937; c=relaxed/simple;
	bh=9IpNWk4XZs89WEN3U5XtWoTeUoZhaaQQghmf0KvaYR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUX1z4Zr+i786WCfv7+EhWHjrhgOVzWAMvj+4kHOT66LejSO2fXNJWIJ5449aFZUBLdbtlYnNz2KDWkJeVBFALJxhwDZIQd97fFVuEkaWoAwUc7n34SIwFbDw90TQiHUqw12WJYGNYeZr3H2JkYQ2umucTmz5a2eF5NfTpYmLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsknRvkQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso5304269b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Dec 2025 22:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766470935; x=1767075735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovND0kPjb8CwNQINf6h6haDpGM/6RmL30Y0iCssV0xI=;
        b=WsknRvkQSSIV6OyXtapWZX2CI0UdPmnkyZuSNL6VZ7v7ilahi5KbWMUTqxgMv5FBtR
         oov+sfgzqbzGXW8zqwSqxfLOctjdjUdWpvOrxaiISfhUU/2ssf0wPRk5MI/nRYDNPLDQ
         0DQPlSN4jdUfkytv8Ypy2+ZuUor+Wb9wKEmmhZUUEJiCjfHbqYyBbN+nfEngHTBLmPsH
         vJWuQ1Mzd/KvZCLtjKjFUvd71WnUBcGwWQpkOfp1yJ/Bcq3lJNc/VFdBgYrLjEpgvNQm
         58TTC77q4VOQYnxQjph/BsGMHbDq7F6+sGSebKFPusmn7Ivh8LqSD8xTHF9MwO5Ua4Iq
         aMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766470935; x=1767075735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovND0kPjb8CwNQINf6h6haDpGM/6RmL30Y0iCssV0xI=;
        b=C/gDVBBEDe2pLXhMt4Lxy7c9g3wQj5OsWlcmGDjZOr0OkblKF7wI7EhHNLSJ/1OVEd
         kWrRY/nsbZHOFSNwiJcitO0ySnANOz0cVUHNVXdRnxq+TzIGrSUIUKQNsA3eyQgWfHfx
         oNWtNTmWPFOae9yEEgV5qOVwlQPm6/I2Ab/GLnttsjDunsSIgMQrkGrWANH1m4c0hPiu
         JM94b9j4438pzXiRBASowqV977T6hl3gE++PiCVGDjMnIRrpuTWhfZV/SsMoVGIaGcmh
         N9E6bIEElwlS3OSI9hgupsOzv0uXWsqavll73o/wlTDD5xI54ld5uxyab6YJZCyZZBxf
         z1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCW9+aXvZyzz7cL3sfrPG5xjmKvBYlOiS9EE8DEjS0+2cOSmv4NO8bwBzLqqDO38NDrpOp+EHugXXh+D@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsBNHy3qiRGjGPh0xTzBArPhy31z+IbvyFvWb5EEv4rcQDTxQ
	/KztORnAB2Uu3Ugg4nY8gA/tKcM40q2ZZ2vlHxLraB8FYrq1jkrV91tP
X-Gm-Gg: AY/fxX5BxC9f6iaxT+Hvt699cMzALgzBjS4pv52duGHcyPTdaIe7tWOSVwH3Rc8JOE5
	hSRSt2eE6bDPXWMWn5hNJIJvJAMYsh42R2qlQQ+r22w4465Qxo4PtKybl3Mf/2dTCb1lZIioLUK
	A3msb0j20kqTTKk0L1ayhymgcIHtOvJrMs8RDWKSpv5UTpFEOQS/FoUnkOOy7ivvKp17C7W1Bfr
	/1oASPvQYQE1pWHYmbcNu0AdLzM/TE7kC4lMzTI+6dZsHuQaIerL+yBIP1W0yyZvQgDxFsZlFCg
	Ubzg+pVXPa0C4yr4vlXgcbMcWk3GOWUK7iLZb68OGyrOyR6PbCfNo+rt03+5vMTQq8a0qC5hgOe
	fu61QxbggC+dMIeItgNbO0MOBmtFUK3Vm7dzG1ZF78rvQv1nxP9Qb4sqB3QPM/CAhRRUrP+NTKW
	N0ug3TB/eVj8OsATa9DVVg9oxAK/KjpRfT9/VJMftbEGUKz0WPkXxiV5JKxFottQ==
X-Google-Smtp-Source: AGHT+IG1KaweWMqCFNI5IyK2Iyck6ddrbW6P6bYU8dxPQsEM6rx7XWMSfbevH/CsT3hoWXQm1yjYUQ==
X-Received: by 2002:a05:6a00:90a2:b0:7e8:4471:ae5c with SMTP id d2e1a72fcca58-7ff67456c12mr11022198b3a.40.1766470935217;
        Mon, 22 Dec 2025 22:22:15 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab841sm12395362b3a.35.2025.12.22.22.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:22:14 -0800 (PST)
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
Subject: [PATCH v2 0/4] rust: Add i8/i16 atomic xchg helpers
Date: Tue, 23 Dec 2025 15:21:36 +0900
Message-ID: <20251223062140.938325-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This adds atomic xchg helpers with full, acquire, release, and relaxed
orderings in preparation for i8/i16 atomic xchg support.

The architectures supporting Rust, implement atomic xchg families
using architecture-specific instructions. They work for i8/i16 too so
the helpers just call them.

Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).

Note the architectures that support Rust handle xchg differently:

- arm64 and riscv support xchg with all the orderings.

- x86_64 and loongarch support only full-ordering xchg. They calls the
  full-ordering xchg for any orderings.

- arm v7 supports only relaxed-odering xchg. It uses __atomic_op_
 macros to add barriers properly.

v2:
- Add comment about ARCH_SUPPORTS_ATOMIC_RMW dependency
- Add Alice's Reviewed-by
v1: https://lore.kernel.org/rust-for-linux/20251217213742.639812-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (4):
  rust: helpers: Add i8/i16 atomic xchg helpers
  rust: helpers: Add i8/i16 atomic xchg_acquire helpers
  rust: helpers: Add i8/i16 atomic xchg_release helpers
  rust: helpers: Add i8/i16 atomic xchg_relaxed helpers

 rust/helpers/atomic_ext.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)


base-commit: cae418334e4c402e410d3ee234935da33c7f904b
-- 
2.43.0


