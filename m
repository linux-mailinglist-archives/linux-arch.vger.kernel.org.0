Return-Path: <linux-arch+bounces-15631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6BCCECD4A
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 06:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EEAD300287C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 05:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A72459DC;
	Thu,  1 Jan 2026 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe5uGqgD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEFCA5A
	for <linux-arch@vger.kernel.org>; Thu,  1 Jan 2026 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767246310; cv=none; b=PQnaoIyUGBp/mnMOYCc+dj8t28i75Y+Imp1G5z7uXfzkxF5pY++2jj9Qj4FxukP5NgMTtmRw+RUW/0/mAMF6J3DU4yu+qhKwefPuzO3OGUC9ypysgfbaTfM4aeXB10t5nfK9U0gIubYyBjh9a5VVPfKxYbJ2uUa/Fgn40FEYj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767246310; c=relaxed/simple;
	bh=INs61yhCH1AlbbGVY6+6ZOmQtPdrw+F4faDkpd6qt58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckloqsSBT7HqFFGjuRhsDEVezTB7H9vG8yK1o/g5Z8K32fI0sMDsavj0JxATsEARMhjO6R47H6+w3i7ccPJOVx1IDPceZzfvHzDEBqaZOTCVX5ucowm268vC939eJMhQs80LLCN7IZ5qFkZ4gIlUr00AtBlNJ5F7759I2bJDoT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe5uGqgD; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656d9230cf2so6158433eaf.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 21:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767246308; x=1767851108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KytvHvTJcGq4zNtgFIHF3Jj8J5A5OCE5SX9E10BLYkc=;
        b=Fe5uGqgD0qhi1b8WlyKHqh4/sCnoDNACWCM1OyRPAaURidv4hzvWn2V4v7ajV65Jpd
         TwfrAb7Zk4tp8vuYurzEr83c1e3idQt1cRlxIphVrOAmP+bxf7Dl4zWu3Q4AuM8Nj2Lr
         D7AtUBvhgzAX1B69++ybVoRUQezWYRcGAo0bOYfEY4Cd3+oUnaIxGLfzmI3FCVHDSdO9
         Ty7OuCaSOzz1g8MXFaD1nouV00DgbP4E0KV7xx9uctEsteRNK7GqTFWgiqSwn6hqPD4k
         3Yk4y2N+/v34uhbe/UFsK6dHItBJ6viLhJY0SzxBNrfRyi0IhU8vtifraA26lF2rrfGK
         tPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767246308; x=1767851108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KytvHvTJcGq4zNtgFIHF3Jj8J5A5OCE5SX9E10BLYkc=;
        b=UyqneQHWeBDELE5+xyJBuWQ0HUHCHz0h1SrBMVlQSPzdSDk7uAf0068z3D1zaRF4G4
         7+nudw7qJu4uaaA7CraEoKH0od4ONjv56NaPNikgwotOOpnirg/O/Zp59sgvyUlJp1P0
         K21VPu5iGJ1gP++EGlPccfQpL48k7b8/yNGUnYWPP46joSKrS67kHhuqNkVPrSkhPxEj
         fOQLalJ5wE9ana83jQ0I7ks4jFI+bvDedpacQck/Ar7O3IxyIkijb2GCvougS7aNR/mx
         pc1kv0MBN6viN30eNIzIsi+3hspMR09S/02ltxMZt+rq9WHS3e6FGDkOv7AVq4WmtVap
         jztA==
X-Forwarded-Encrypted: i=1; AJvYcCUA7rKiCO2N3wlI4rc/Q879rbM5XdpLXT68m8elRXAWrMnS21bxgnnfphF2kgxpI/wHmy+d0+h5nseE@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrUNCSdTrsJnPsxSuY/w7yAl0DVjsP9k/J48qznoyDt+UoE2l
	we4bHvZHEkqplGAkf1nVZgpF5p3J96pxKRzWUtF85eYSXJJRetB657uiTvO9qQ==
X-Gm-Gg: AY/fxX4L1Haq2YMrBZXknKx8udjzLTEvogHQySTuVTZSJqdoL5GQOXoffPaRXJkZnN6
	3O6yMNSxCTa+S0RlSP1+uvU65pzfXZRIor16pMqWGNQ/jlDkJts6I1+g07rUFm4JmOEOBUTWy4a
	W9yFy6AKv+00L1dAVb2mycWKxKj5gQ4SvUyd/ZxqbVbKee2+e+M+36Y82RvgdRX/q1uW1PLI2o+
	hDOecmwUIeBT3vLIIB+Hr8B29/KGhWsb3yDhtyVzldAm8dFDV8743e4QEL+9zhAblJxfMXztrW/
	kIuG4l0Wyd+2efLbhlqRP1BH3PRs3Pb+5p00wZ9dDmWvmh1u/e9JDIj6frw4e4OA1L2lB6FwHLk
	GEz+L3Z8dq6QKsyTQUDWolrjo+mFM3UZ9pkK/rPgqtPlor6ElOPVjfmOLHUv94nwWqJV4j/UOFf
	1KKDngjFUppvjlrsNr6V7oEV5FXS6daoYQiyFUWu5bm3+5G4ozD2qc0qJzTQ0Kuw==
X-Google-Smtp-Source: AGHT+IF5gwcyd1zngqLBrxFDVoP06XhHyOWsQWXS58QUEVAylTsmGpgLpg2Hcfx44nuhnrb+ZZ5WCQ==
X-Received: by 2002:a17:903:4b47:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a2f28335ffmr411627425ad.50.1767239429491;
        Wed, 31 Dec 2025 19:50:29 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c83325sm341874445ad.34.2025.12.31.19.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 19:50:29 -0800 (PST)
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
Subject: [PATCH v2 0/2] Add atomic bool support
Date: Thu,  1 Jan 2026 12:49:20 +0900
Message-ID: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
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

[1] https://doc.rust-lang.org/reference/types/boolean.html

v2:
- remove AtomicImpl
- remove Safety comment about the bit patterns
- remove from_ptr() comment in cover letter
v1: https://lore.kernel.org/rust-for-linux/20251230045028.1773445-1-fujita.tomonori@gmail.com/


FUJITA Tomonori (2):
  rust: sync: atomic: Add atomic bool support via i8 representation
  rust: sync: atomic: Add atomic bool tests

 rust/kernel/sync/atomic/internal.rs  |  1 +
 rust/kernel/sync/atomic/predefine.rs | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)


base-commit: dafb6d4cabd044ccd7e49cea29363e8526edc071
-- 
2.43.0


