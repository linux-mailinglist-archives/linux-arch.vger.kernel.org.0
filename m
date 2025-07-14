Return-Path: <linux-arch+bounces-12723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ECB035F5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 07:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110203B875A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44CD21882B;
	Mon, 14 Jul 2025 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjicrYrQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30644205ABA;
	Mon, 14 Jul 2025 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471431; cv=none; b=Xyas1uAkuTGBsje3haCaMS8jhQuQthNU83t41+TurdOL5W1dR+7ZG8GRI7ZtVWxmWLlMX9cbIYddgefmd/eE/A2HEyBNCuMo39W2cB2zzfR/wos3qfKzn2kUsTS3T9A2+blfo+hn8JLP3svMpQ47w5lGQk+nAS0B73AABda8Qhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471431; c=relaxed/simple;
	bh=22djv8E6MRg4uvxlUWiDx6U/LmxxxIyjKjQ4JApsS2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XzfLaJO1JfNvdzTnRhZ2vHh/FgZpjPC9eO6w9r0x9rC9b6spghF3XMRCabAVu70V2v0q8OigRK/7YFAio0pHLaalIYogm/PrDOBfMfqKPpZVovehtglsrzDdD9bob9tQdyEKM+mZgYgca/aXbvttvnKP0bVlY5WSHFrfOPvpsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjicrYrQ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e1d89fcc31so102190685a.1;
        Sun, 13 Jul 2025 22:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752471428; x=1753076228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MROVhjbXAwDJvnFQvYhC8HYg2UDwZTq9JXFvovjW0rc=;
        b=bjicrYrQEhClgIZSlFhWGKrgCJHJx7VG8MlQR2gVC2WmMdUNlIFaYrmJahmb7fWaxP
         2r91a6TCYWdQga/lifgE++RuV7FtHJI9gao2L4dXRfFadc4GEmsbbCvoDwXtBByLYmIc
         RvzoqFE20d+ofak/ENuFtC5Z7JMuqH8WZc0Q6+5Xs3MD3TkQdL0gB7gVxGk5sunsE0ui
         cf2bpV/FPDHwNRH+kP708eW3GqzdDb0mK2MY3HPV4x4BP6Tw2QTHCdPDX0JGQ9v2hB7Y
         VMoUboQj97SpVg6LZbrgaxPouoYi5iUuaoNt7gUCn2IxzPjQuB1j2V+5uQ6ToshPEdvp
         99wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471428; x=1753076228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MROVhjbXAwDJvnFQvYhC8HYg2UDwZTq9JXFvovjW0rc=;
        b=V9nefyqNxUPpRCUylL7QMNE2Go1CbE7oYeyO392YkLcHJcPWfW1v8G3o8VpOlKzKnN
         YPFJ2S3xH89DtlnJ3Nhze2hqqZhbMKxFjxS0Bro3w80bfm4gmqL9yhaZ9S+i+71asGVc
         reJcaPeu+MApzkj0PmTMbPnYz6zU5RwjcLFQeG9wcu+/VFNbIgencN2marAlHt/OdlCI
         NLrZQTo45PUZyrQqfuqAO1W9hU5EwabaetVRKRqR+lbLjVOX2YFkDK5/j+oYFLwWdJnl
         GEloub0EMVRGouB90FBS7X3wTE9FinxRLrTR+dJv60g+k6CknpHt36M0jw5yiD55Tk2T
         uCAA==
X-Forwarded-Encrypted: i=1; AJvYcCVKyUvMcjPD3D7cVDVFR3pzD0xpYodD7fqKoMwtGmkkrTPCMTt7GlUm1WV/iWnLaYe/ar0YCevgbHMr@vger.kernel.org, AJvYcCXGjE+jXRhpIcPAbiH8//lO6RlTWOrBcZIhwWsJKVimhdb09CkC4bCzDlzoxTDzSgLTui7Quys+6RoLz0bfdIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Jg1TY+YCeyfBlFtJp0rKSPBTd4aRolvGk7u237TB1SNomtUU
	Zuv+cvv1ko7yv2ICSC2WP4FQks7qt58ss/O8EXURO18aBL4fcFKwiFE6
X-Gm-Gg: ASbGncvyoF/V5GEViW9kqM138WMdAF1fb0u/zGMm/kQU/o670Ill8SCXoRiDNDJehON
	jkOtnKNaSKaVlogKMysvYYbW5DHHy2VdczofoCpSQl2szxBUnURUhJ/YRso8XVUB9iH1j5it0XD
	U+Zo6Etn0hMdJJATH0DJTYWwsPgfUSFeU5/bxfRFSUt+mMWTkzM7cUWnY9IkoODmklTm8XXfe9V
	bEpNwV4tqiwzxJzUTAu9wt1sGGlo7LzNZVTojWtF7COgK+zFXO3P3lQZUKA04Xi6203oA4h1Wke
	DWY7arzK02Kr1+5degPdcT6zS/Op3TkYyVdLIofVs6IL43+xhpMlXf/nbWln9Z/A4TMfug7qsHC
	95ZYqfNoXrayWXvW7okx+zIKeO+jORK81QapCdmur6onnFl8p6+ua2IoEzZhfU+bS3tFol+sqY8
	LKqyeuqhB5KwCW
X-Google-Smtp-Source: AGHT+IGK9SV++5EVXw2GaSUVUjWD8RHBJtjDLrMZ/mjy/zTXNpasmZhJ4/PiiR/6geKfjEiMm8DAPQ==
X-Received: by 2002:a05:620a:2544:b0:7d3:f17d:10c8 with SMTP id af79cd13be357-7dded1f16b8mr1723186285a.43.1752471427684;
        Sun, 13 Jul 2025 22:37:07 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799e874sm43764106d6.18.2025.07.13.22.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 22:37:07 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D7C7F40066;
	Mon, 14 Jul 2025 01:37:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Jul 2025 01:37:06 -0400
X-ME-Sender: <xms:gpd0aEov75l1d4_sfxF_hDA5D6_-o_zA3x9qX8qpd-PulhJ-U4SoCw>
    <xme:gpd0aMIHXX1GHbf4CEFmTODNKegvFLuxUIxlG51KMxTwgGMRuEFlZgvvLT-h5IGE9
    5rbt7RDSfaNd9TGyQ>
X-ME-Received: <xmr:gpd0aNz4e5zPSSe6D7fvRqSSKOoKpVyixEhlvdOFTSbGrnxDYa1DUR0-gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeggefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:gpd0aLZHINlFv7lGG5e_BKiCJ1ASgQJc9veb_mpk86VExVHViv-5Dg>
    <xmx:gpd0aB5k6xrOxMyPrqByfhjpXTe2SW9udF-8ZkqYnlZr9r7ZBgX74g>
    <xmx:gpd0aECreMv_pAQLecQotRuKEV6_bSTo0VDJYsrwn6HXUcUN-qc8iA>
    <xmx:gpd0aPtz7bph0yibz_91V3MCE3zPoJiDopbIXTo9A-gj_lyurcy5gA>
    <xmx:gpd0aBvFX4BJi2ooIiN5OStEPP8g4lzDu0IoQVsJ5RYMZfNGBuiAKMxI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 01:37:04 -0400 (EDT)
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
Subject: [PATCH v7 1/9] rust: Introduce atomic API helpers
Date: Sun, 13 Jul 2025 22:36:48 -0700
Message-Id: <20250714053656.66712-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714053656.66712-1-boqun.feng@gmail.com>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support LKMM atomics in Rust, add rust_helper_* for atomic
APIs. These helpers ensure the implementation of LKMM atomics in Rust is
the same as in C. This could save the maintenance burden of having two
similar atomic implementations in asm.

Originally-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
 rust/helpers/helpers.c                    |    1 +
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
 4 files changed, 1109 insertions(+)
 create mode 100644 rust/helpers/atomic.c
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
new file mode 100644
index 000000000000..cf06b7ef9a1c
--- /dev/null
+++ b/rust/helpers/atomic.c
@@ -0,0 +1,1040 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides helpers for the various atomic functions for Rust.
+ */
+#ifndef _RUST_ATOMIC_API_H
+#define _RUST_ATOMIC_API_H
+
+#include <linux/atomic.h>
+
+// TODO: Remove this after INLINE_HELPERS support is added.
+#ifndef __rust_helper
+#define __rust_helper
+#endif
+
+__rust_helper int
+rust_helper_atomic_read(const atomic_t *v)
+{
+	return atomic_read(v);
+}
+
+__rust_helper int
+rust_helper_atomic_read_acquire(const atomic_t *v)
+{
+	return atomic_read_acquire(v);
+}
+
+__rust_helper void
+rust_helper_atomic_set(atomic_t *v, int i)
+{
+	atomic_set(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic_set_release(atomic_t *v, int i)
+{
+	atomic_set_release(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic_add(int i, atomic_t *v)
+{
+	atomic_add(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return(int i, atomic_t *v)
+{
+	return atomic_add_return(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	return atomic_add_return_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_release(int i, atomic_t *v)
+{
+	return atomic_add_return_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_add_return_relaxed(int i, atomic_t *v)
+{
+	return atomic_add_return_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add(int i, atomic_t *v)
+{
+	return atomic_fetch_add(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_add_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	return atomic_fetch_add_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_add_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_sub(int i, atomic_t *v)
+{
+	atomic_sub(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return(int i, atomic_t *v)
+{
+	return atomic_sub_return(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	return atomic_sub_return_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_release(int i, atomic_t *v)
+{
+	return atomic_sub_return_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_sub_return_relaxed(int i, atomic_t *v)
+{
+	return atomic_sub_return_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub(int i, atomic_t *v)
+{
+	return atomic_fetch_sub(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_sub_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_sub_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_inc(atomic_t *v)
+{
+	atomic_inc(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return(atomic_t *v)
+{
+	return atomic_inc_return(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_acquire(atomic_t *v)
+{
+	return atomic_inc_return_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_release(atomic_t *v)
+{
+	return atomic_inc_return_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return atomic_inc_return_relaxed(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc(atomic_t *v)
+{
+	return atomic_fetch_inc(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return atomic_fetch_inc_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_release(atomic_t *v)
+{
+	return atomic_fetch_inc_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return atomic_fetch_inc_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic_dec(atomic_t *v)
+{
+	atomic_dec(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return(atomic_t *v)
+{
+	return atomic_dec_return(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_acquire(atomic_t *v)
+{
+	return atomic_dec_return_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_release(atomic_t *v)
+{
+	return atomic_dec_return_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return atomic_dec_return_relaxed(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec(atomic_t *v)
+{
+	return atomic_fetch_dec(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return atomic_fetch_dec_acquire(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_release(atomic_t *v)
+{
+	return atomic_fetch_dec_release(v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return atomic_fetch_dec_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic_and(int i, atomic_t *v)
+{
+	atomic_and(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and(int i, atomic_t *v)
+{
+	return atomic_fetch_and(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_and_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	return atomic_fetch_and_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_and_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_and_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_andnot(int i, atomic_t *v)
+{
+	atomic_andnot(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_andnot_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_or(int i, atomic_t *v)
+{
+	atomic_or(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or(int i, atomic_t *v)
+{
+	return atomic_fetch_or(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_or_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	return atomic_fetch_or_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_or_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_or_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic_xor(int i, atomic_t *v)
+{
+	atomic_xor(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor(int i, atomic_t *v)
+{
+	return atomic_fetch_xor(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_acquire(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_release(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_xor_relaxed(int i, atomic_t *v)
+{
+	return atomic_fetch_xor_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg(atomic_t *v, int new)
+{
+	return atomic_xchg(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_acquire(atomic_t *v, int new)
+{
+	return atomic_xchg_acquire(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_release(atomic_t *v, int new)
+{
+	return atomic_xchg_release(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_xchg_relaxed(atomic_t *v, int new)
+{
+	return atomic_xchg_relaxed(v, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_release(v, old, new);
+}
+
+__rust_helper int
+rust_helper_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
+{
+	return atomic_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_release(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	return atomic_try_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return atomic_sub_and_test(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_dec_and_test(atomic_t *v)
+{
+	return atomic_dec_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_and_test(atomic_t *v)
+{
+	return atomic_inc_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative(int i, atomic_t *v)
+{
+	return atomic_add_negative(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_acquire(int i, atomic_t *v)
+{
+	return atomic_add_negative_acquire(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_release(int i, atomic_t *v)
+{
+	return atomic_add_negative_release(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_negative_relaxed(int i, atomic_t *v)
+{
+	return atomic_add_negative_relaxed(i, v);
+}
+
+__rust_helper int
+rust_helper_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	return atomic_fetch_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return atomic_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_not_zero(atomic_t *v)
+{
+	return atomic_inc_not_zero(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_inc_unless_negative(atomic_t *v)
+{
+	return atomic_inc_unless_negative(v);
+}
+
+__rust_helper bool
+rust_helper_atomic_dec_unless_positive(atomic_t *v)
+{
+	return atomic_dec_unless_positive(v);
+}
+
+__rust_helper int
+rust_helper_atomic_dec_if_positive(atomic_t *v)
+{
+	return atomic_dec_if_positive(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_read(const atomic64_t *v)
+{
+	return atomic64_read(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_read_acquire(const atomic64_t *v)
+{
+	return atomic64_read_acquire(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_set(atomic64_t *v, s64 i)
+{
+	atomic64_set(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	atomic64_set_release(v, i);
+}
+
+__rust_helper void
+rust_helper_atomic64_add(s64 i, atomic64_t *v)
+{
+	atomic64_add(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_add_return_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_add_return_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_add_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_sub(s64 i, atomic64_t *v)
+{
+	atomic64_sub(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_return_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_sub_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_inc(atomic64_t *v)
+{
+	atomic64_inc(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return(atomic64_t *v)
+{
+	return atomic64_inc_return(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return atomic64_inc_return_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_release(atomic64_t *v)
+{
+	return atomic64_inc_return_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return atomic64_inc_return_relaxed(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc(atomic64_t *v)
+{
+	return atomic64_fetch_inc(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return atomic64_fetch_inc_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return atomic64_fetch_inc_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return atomic64_fetch_inc_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_dec(atomic64_t *v)
+{
+	atomic64_dec(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return(atomic64_t *v)
+{
+	return atomic64_dec_return(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return atomic64_dec_return_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_release(atomic64_t *v)
+{
+	return atomic64_dec_return_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return atomic64_dec_return_relaxed(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec(atomic64_t *v)
+{
+	return atomic64_fetch_dec(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return atomic64_fetch_dec_acquire(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return atomic64_fetch_dec_release(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return atomic64_fetch_dec_relaxed(v);
+}
+
+__rust_helper void
+rust_helper_atomic64_and(s64 i, atomic64_t *v)
+{
+	atomic64_and(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_and_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	atomic64_andnot(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_andnot_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_or(s64 i, atomic64_t *v)
+{
+	atomic64_or(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_or_relaxed(i, v);
+}
+
+__rust_helper void
+rust_helper_atomic64_xor(s64 i, atomic64_t *v)
+{
+	atomic64_xor(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_acquire(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_release(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_fetch_xor_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_acquire(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_acquire(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_release(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_release(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
+{
+	return atomic64_xchg_relaxed(v, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_release(v, old, new);
+}
+
+__rust_helper s64
+rust_helper_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
+{
+	return atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_acquire(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_release(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	return atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+
+__rust_helper bool
+rust_helper_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return atomic64_sub_and_test(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_dec_and_test(atomic64_t *v)
+{
+	return atomic64_dec_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_and_test(atomic64_t *v)
+{
+	return atomic64_inc_and_test(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_acquire(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_release(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_release(i, v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
+{
+	return atomic64_add_negative_relaxed(i, v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return atomic64_fetch_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return atomic64_add_unless(v, a, u);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return atomic64_inc_not_zero(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	return atomic64_inc_unless_negative(v);
+}
+
+__rust_helper bool
+rust_helper_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	return atomic64_dec_unless_positive(v);
+}
+
+__rust_helper s64
+rust_helper_atomic64_dec_if_positive(atomic64_t *v)
+{
+	return atomic64_dec_if_positive(v);
+}
+
+#endif /* _RUST_ATOMIC_API_H */
+// 615a0e0c98b5973a47fe4fa65e92935051ca00ed
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 16fa9bca5949..83e89f6a68fb 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,6 +7,7 @@
  * Sorted alphabetically.
  */
 
+#include "atomic.c"
 #include "auxiliary.c"
 #include "blk.c"
 #include "bug.c"
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 5b98a8307693..02508d0d6fe4 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -11,6 +11,7 @@ cat <<EOF |
 gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
 gen-atomic-long.sh              linux/atomic/atomic-long.h
 gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
+gen-rust-atomic-helpers.sh      ../rust/helpers/atomic.c
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
diff --git a/scripts/atomic/gen-rust-atomic-helpers.sh b/scripts/atomic/gen-rust-atomic-helpers.sh
new file mode 100755
index 000000000000..45b1e100ed7c
--- /dev/null
+++ b/scripts/atomic/gen-rust-atomic-helpers.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+ATOMICDIR=$(dirname $0)
+
+. ${ATOMICDIR}/atomic-tbl.sh
+
+#gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
+gen_proto_order_variant()
+{
+	local meta="$1"; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
+	local atomic="$1"; shift
+	local int="$1"; shift
+
+	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+
+	local ret="$(gen_ret_type "${meta}" "${int}")"
+	local params="$(gen_params "${int}" "${atomic}" "$@")"
+	local args="$(gen_args "$@")"
+	local retstmt="$(gen_ret_stmt "${meta}")"
+
+cat <<EOF
+__rust_helper ${ret}
+rust_helper_${atomicname}(${params})
+{
+	${retstmt}${atomicname}(${args});
+}
+
+EOF
+}
+
+cat << EOF
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by $0
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+/*
+ * This file provides helpers for the various atomic functions for Rust.
+ */
+#ifndef _RUST_ATOMIC_API_H
+#define _RUST_ATOMIC_API_H
+
+#include <linux/atomic.h>
+
+// TODO: Remove this after INLINE_HELPERS support is added.
+#ifndef __rust_helper
+#define __rust_helper
+#endif
+
+EOF
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+done
+
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+done
+
+cat <<EOF
+#endif /* _RUST_ATOMIC_API_H */
+EOF
-- 
2.39.5 (Apple Git-154)


