Return-Path: <linux-arch+bounces-15557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40173CDF96C
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A275230057FB
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA61A073F;
	Sat, 27 Dec 2025 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwuPjEhw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D9274B4D
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766836827; cv=none; b=B+CMS7pH1s/Er//llbHMeWq+SWkRjESaFwt00szgI+TGhF0tW4+1rFhApYYhVeHmYRLODgNt6wy+FYH+0QutqocstL5dPFWLGxpUdnjIitY8QhD55kGL9aviAf8Zydcj6a5v64dWjFe9li3fJSO4dodlVF133PRU7StMWdS/5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766836827; c=relaxed/simple;
	bh=kQZdT8uUPHSe/dzSYVg9uu1G8iQ4QIfebKVRvfCtR3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/BM3EfxTWzRMHhbgQTu27aJaqzdEm5gFH+H9A+jBZSkFyLeMp50IE+PGhANxKIV8VTMwG+cz8Ht9LkMEFxwA/X7IE27jwbMiCRBVjLM1lueW99/cPefTNYegODqoN+8slnSG/GUL3YPVSRWksh0N6Hy2q3IlGwGxnwZawUO6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwuPjEhw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a2ea96930cso90313205ad.2
        for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766836826; x=1767441626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqLeAfU9Xo+cqKfof/vWwBJRWGkSTKrPAXLP8+Y6zB4=;
        b=hwuPjEhw2K4B7j3nKgh10z2pLI3pZH+0xmJ+DB1SLcbOfj88a/zjKGarQi3Oe72n9s
         tgp4fnSXlHtsYLH396UOP2TJqmSEFV24s5PbcRdIPvli8w9SNd36Y+pe2iE/AZlpX9Lb
         NUdobbqg33OCOL4EsDbxWu7s7Pp9RiUwQ4x8OMvWVQXE2i3AolivNYcTE3JswDxkgfvc
         JdTckNl5/ch7C6KFndwfysAVGcpIETbKMAzE6ClxpnIcJnqK5HFowthZ4kKD5T1dODLG
         Qwwdo19oBxrnydTYqXcU8p1AcMVKo+OdKZb8Ve1JpDP/Hk0g1T6yeump1Q8/SBjOgm5w
         uL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766836826; x=1767441626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqLeAfU9Xo+cqKfof/vWwBJRWGkSTKrPAXLP8+Y6zB4=;
        b=kr8jW3x2OMgbnEwmK0ynXZ9hDVoWcAkFyi9VzmpC+vybF2DmNFrv6FOcrxJ/HWRYQn
         5KppD6RoQrvq5qz3CXreBQkLht5OORO2IUCnPp+6ZrxgLoBN5O1ZDQJ8DGb1SgaYK5yR
         7dbxL19luFt+KSn//rVW+OiEN1p1XCnEjiUrIXFAIVgeQmlLuxb7XxrE2NV9oFiLQyg5
         vdaJBPha0nj8jjwgOqPM8JZkZ4iVjWCHpb4D1uDt28lL2cp28nrS0qVi6wDGcSY1JDbh
         XcsG1PoOArzJTo6yeFvFHvVNV4SnZ+/rpZDqMTsWU4CsAOLPp7jv0lVJzKNyae604asG
         WhTA==
X-Forwarded-Encrypted: i=1; AJvYcCWvXaYxDmargvTB+d7td2Adk6xQFVfFnshEO0J2CEWqAMM3JsRexGQ+/kdq3JxYA3H9DBocJw3ZyZd0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3Og2gayP+i3Yo3mnWu+jh37zxNixmj/eGmXK80TtXZbHrQl8
	1pLsIpeCpddHfHladypw4eLFumlWpWG56XkJFI4Tr/piG2TInHcrSX1/
X-Gm-Gg: AY/fxX5O9L7W9SHdTHGZMYr4reENXp+NVuAPaMpYiCyb9J1XI6IKwH1Mz2158INptkw
	jmCfP3SiiWi/w/FlJ/LykDCARFbYMgLasK+EHjGosxUcUIU2dVKiKd3HP20Kt4fP+FvOUXrkj1E
	ttciHSytgbw/mO2djGX75VUlcyJMjH3WAP6A0MASG4xuedF/dFJy0u+x9bmD63VQyx3krrHdZEs
	qGHqvMcGwusFjZg21lqfV69hH21rkQUUsZN/sEKesIiDWJS9UpNebApDC5HXff+I+zIWtQFSr4h
	TrkwYtYuHaYQh8AvBnUfxa1+cemeOXedez8KjjnOltYu6dI+lUKcnOyz33wtluPEMpWVEyEt8NB
	qBeNSPZfH8yycz713ZSr1WNmsqTsfc4tY0kbwbhEYzd89O8qQAB53mINJU2x7PsfIsPrssJ+XEx
	WoH5EKDAmUIRI9LQ9OpWGwBH8W9OiHGunHBtbtGQr8o2XuQI0gbfEOBnf7tTU3mQ==
X-Google-Smtp-Source: AGHT+IFGUTcorGykjnyxafmjxJwRXcwp+7UqaNbZgZ5ZtGZ4+MIvTAbGHFIfiyLgwMxAjhTe0yR1UA==
X-Received: by 2002:a17:903:2445:b0:2a0:d629:903c with SMTP id d9443c01a7336-2a2f27365edmr265642305ad.30.1766836825413;
        Sat, 27 Dec 2025 04:00:25 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm231033165ad.50.2025.12.27.04.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:00:24 -0800 (PST)
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
Subject: [PATCH v1 0/4] rust: Add i8/i16 atomic try_cmpxchg helpers
Date: Sat, 27 Dec 2025 20:59:47 +0900
Message-ID: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This series adds Rust helpers for atomic try_cmpxchg on i8/i16 with
full, acquire, release, and relaxed orderings in preparation for
supporting Rust-side cmpxchg on those types.

Rust atomic cmpxchg is implemented on top of the kernel C APIs,
try_cmpxchg.

On architectures that support Rust today, the kernel already provides
try_cmpxchg implementations that work for i8/i16, using
architecture-specific instructions.

Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).

Follow-up patches will add Rust users of these helpers.

Boqun, feel free to drop the ordering-related notes from each patch.

FUJITA Tomonori (4):
  rust: helpers: Add i8/i16 atomic try_cmpxchg helpers
  rust: helpers: Add i8/i16 atomic try_cmpxchg_acquire helpers
  rust: helpers: Add i8/i16 atomic try_cmpxchg_release helpers
  rust: helpers: Add i8/i16 atomic try_cmpxchg_relaxed helpers

 rust/helpers/atomic_ext.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)


base-commit: 30f5de001fb2ffacdb61e82c8626cae2d68b4d03
-- 
2.43.0


