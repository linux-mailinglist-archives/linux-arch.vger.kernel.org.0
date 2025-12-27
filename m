Return-Path: <linux-arch+bounces-15559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE9CDF96F
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 13:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A94030090A9
	for <lists+linux-arch@lfdr.de>; Sat, 27 Dec 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14763223708;
	Sat, 27 Dec 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbsQ/fNy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B351E0DFE
	for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766836834; cv=none; b=hfSR4z3cZpdn3NFbhjcMEpKnWxk6yjiDGCLKCCltR3yrl3T1tlL3NJgNgj/Gx1OvCC1O4FHGmvsycx97tG5Uk5CWHj2HjriCLeVCe17H+d0njOvRMqC2UtF7i+VIdx1Ude/2MaR7MedujdEFAKYUeUXRdjvuYqlRvE1cQnwNhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766836834; c=relaxed/simple;
	bh=NBPN+y91sKNZcaVYaS97cuL5mgiLSQVqWs78lHNDxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1+YKyga/X7vfGdEoEjCciRwWYhq7a5h8ZE2EfTt/n+3DwtEhsiHf33qDC916Si3uwBd4cyIavdluUj48x9aCKLg9UKSXHFh6LDceBq8CDYFaiF9I6wv3idVhtK/zmPiqQFS6edof1cmf4Ray9yMeGCS/66NOdgYYgcaX88Nj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbsQ/fNy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0bb2f093aso79237375ad.3
        for <linux-arch@vger.kernel.org>; Sat, 27 Dec 2025 04:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766836832; x=1767441632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCzDGurgT3NnrlDgTv+wtsy6PG3zYK67/4czNPTH8/I=;
        b=JbsQ/fNyuVELk95M45FdRUs6IDSl7ILFpCuWOJZHINW1hYeLWD+TJhSLWY74hU3Ji3
         2I9QgI9cqnZZhgv7G9fsRioX7qNBOcLwHm45YDSOaK1bVtT995R26Do5H1w3zoiL9I2r
         F+rpCGVQ10jXNGcm9ldewvS9yCuGO1P4wwbUtnRFgDqlF5w64lde4qHdX8B4b7IwRDoQ
         po9X7NyWFmk/x3ZzdO6Uz5YKCuHK3L+V9AiDQteVUdPjQaYjAZm6ydr4m8HHLSCgjch/
         ONibWqJKNdeRwwfF5or+rsqNn0zsMWEBYuqdHPvkpxPF3nfkzt4qW6Wk7ma4yVHu4nn6
         ug+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766836832; x=1767441632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCzDGurgT3NnrlDgTv+wtsy6PG3zYK67/4czNPTH8/I=;
        b=RgqlqE30Ki5844lby2zyInicUUJFuaK+dMDASh1/F8pXcTArnTqI6vB8piq5ocowS7
         X5465VlpStubc37YlVu3Lb9I5WqcHw5DNux/E/FVQB+VxR2JkHubreTH13NIoA0C/oyU
         JuLHE5/ezFpXqg/HtALvM+AqO6yPvQxfY+R1W23S+gogj5feaNFBm0yWGMazcgIxWraQ
         katAlcVZJ5X0SVsTdsWRnAZBwCDw0K/9ejOEfIOXS/uhKDL2F7ZGFB+KBiwTywAqE2Hy
         SxsOfHATtiafMjU3XWn3nMIBoJHvVKesGPct9/N85hBS2tZDgDKKXrfOX/aFR5S/Fe4+
         MRag==
X-Forwarded-Encrypted: i=1; AJvYcCXvCZcM2UOcMTzRqzUyOxtH1kfkKLcTstC8XUq0j6DwCIoPTN21oMEWqDaP9fgAYcND6jtGdmZHCk5A@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvkM0ZZW2rwaHU8pPGZ2OHUnrsL4yBmv+8C2AOTkwPCIabMqk
	/IN2to1Wk7lTMYI650hTPWLiRr2h5AN47VNUpifpdgIzLlX1yBMpSSRY
X-Gm-Gg: AY/fxX7lJ9A+JwMS8t3Jok3IExjzVUY+nyDUuyFP0iGhmv2LElzL8w55UlbbIUWfAaK
	g+VyXjUz9HeOqDLbtDSkWDX0d3sI9tDIbi/NCtVhe6KvmPjtwqH9S/USpMNpCcPf3zN3nGQx2DA
	sLx6tuOSTd7z92NTESAswiz2h5dcViPFndysJd7VcMavnMYpsGpcygBNUmSUZLCbW4dRjFjP2RV
	Et8pdLHp8qlU3KNKuWILo+n294XbcLrJI3OKFzgNFoTkm+WyS/Ff0syrGL19KFB3z/3bu5VsQ6H
	brx63ZGhwNbBnpk5zRmUyNeZIwLQJnRdWhNfENH4pi0X2Z4rR1QyQZPxTcz2lerJ4O8YpJXbhS4
	l2ARIdMAgtM56NPSQEPW9ZBw4rCOo5scv/duoGGDydpkqXusPlNPkDMnPnBuWJ5NLo9c4Eq2V5E
	IoBcii8P+QOfvSaz44MGD19Kij1v3h9PL8rc2B3g/NXCkzvh1ZtA/rUYGbhqeUfQ==
X-Google-Smtp-Source: AGHT+IHqqGP9aJCyf1v+AkR3JBOeT81xZsuW5irTGZbouwmiPTzcSDJoLmZ36jJsbEr/FWa2YTtDRw==
X-Received: by 2002:a17:902:f68b:b0:2a0:afeb:fbb6 with SMTP id d9443c01a7336-2a2f2202efbmr224735055ad.8.1766836831684;
        Sat, 27 Dec 2025 04:00:31 -0800 (PST)
Received: from bee.. (p5342157-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.39.242.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbcfsm231033165ad.50.2025.12.27.04.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:00:31 -0800 (PST)
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
Subject: [PATCH v1 2/4] rust: helpers: Add i8/i16 atomic try_cmpxchg_acquire helpers
Date: Sat, 27 Dec 2025 20:59:49 +0900
Message-ID: <20251227115951.1424458-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
References: <20251227115951.1424458-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add i8/i16 atomic try_cmpxchg_acquire helpers that call
raw_try_cmpxchg_acquire() macro implementing atomic
try_cmpxchg_acquire using architecture-specific instructions.

x86_64 uses full-ordering try_cmpxchg().

On other architectures, try_cmpxchg_acquire() isn't implemented; so
calling try_cmpxchg_acquire() ends up using cmpxchg_acquire()
implementation.

arm64 and riscv implement acquire-ordering cmpxchg.

loongarch uses full-ordering cmpxchg().

arm v7 only supports relaxed-ordering cmpxchg; __atomic_op_fence()
macro is used to add barriers after the relaxed cmpxchg.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/atomic_ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 9d62f659c8d2..69a258ebbfa0 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -100,3 +100,13 @@ __rust_helper bool rust_helper_atomic_i16_try_cmpxchg(s16 *ptr, s16 *old, s16 ne
 {
 	return raw_try_cmpxchg(ptr, old, new);
 }
+
+__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_acquire(s8 *ptr, s8 *old, s8 new)
+{
+	return raw_try_cmpxchg_acquire(ptr, old, new);
+}
+
+__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_acquire(s16 *ptr, s16 *old, s16 new)
+{
+	return raw_try_cmpxchg_acquire(ptr, old, new);
+}
-- 
2.43.0


