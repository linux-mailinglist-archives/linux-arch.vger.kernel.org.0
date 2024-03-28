Return-Path: <linux-arch+bounces-3076-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753DE885E59
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EFF280D2B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Mar 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE413BAD8;
	Thu, 21 Mar 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQ6t8u0m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AE13B297
	for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039085; cv=none; b=hKhKC2wnvvsc4V/Dosr5Y4G8Krfanve/ZbxidEfWGiSY/jVwW9XRF7CC5skXj4xZg1Oe7uv+puBI2fk480rHextaNe0CwAE1PMdoxEcMObbhELdWQ5z6ZJ7SnIcLSWGjQhqC8yB9XlcMNiruZVs/7HuyZWSpPg7C08XMaKmjwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039085; c=relaxed/simple;
	bh=jXsURVn8SIEDSxm3ybi646KeGxqom+Lp+iDA2OWR8bA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GcqXmzvz49OH9jYEWG+4xLPPuJtMhFCmiV9FVEXSoSCieYPyqYGJ7tBz7LFDqMu4doKlJWS45bSGpXK5xF9M+/JuP5KDq/7BZ8n2RrzF3iFxBkTzul7w07Y1uY9+al6j+Je6eWSYyh25pncwq7BrYO1OqP7FseqX0WsZi7KH8Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQ6t8u0m; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ccc3cfa39so16720767b3.2
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2024 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039082; x=1711643882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s40WFNE8AOKkW3fMlFNAMtyrdkqCS9mljSRdY//hl9w=;
        b=CQ6t8u0msbijO81264wqXFw8BKrxYLrJuEZuSSTwkWEAqjDy/Q856UuJhkY5p+lnvz
         6TC7Ca0uS/TphDMECYCmS2UeoRk+YO8XQEW/0+SwfexB8JfPBfisXkLBgF4/HC8+k27R
         j993HXFtLbTxTfGtrYGDhlG0r7kpf6NZ55u+tGs9q2uDCRiKunTuM91MCuxr0OfsU1oz
         POegw9ggM0eo/7L0VU4f7EN1hrXC9JKao7nunpo+ol0iFfgiCWTrdViub0KDPvQe2u2R
         wxtUJuRgZR4EJRtONFiiIOiFx2W2w/M+dgfy93A9T3GXXU2pEZG8XYIO0sgM/U6S2dEF
         XUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039082; x=1711643882;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s40WFNE8AOKkW3fMlFNAMtyrdkqCS9mljSRdY//hl9w=;
        b=Gd2qVGmDh+oYAt4pWJA8I9Nq6omvNTBeNiP19O1VaeCtCyiTvvpB2LjURTHf9b7HTZ
         hwehkUFLqI/OFq5ZeWmK/Jtpx77SXjmUP6vAQoC+JOTY20AmXDoi6qJBA+v87BLGYYoZ
         DiTVWxS1ysXrC9rxkKiRy+egJ9HcJkwfaHURSMog2NLfwfFT6HCZos4jDtJ4GCIWex7L
         8Nzf1xAzG6VgKylN3s6c+uQ0T+SFXTer6S4mH3z7BVH/HQNPwBJuPd3ifkw7L6NBQC3W
         rix0myZweQKp+hOaOfpGPQsuy6oG6TZACrF1Ndu5XmWwYAyVSxfY8muyPOEGdxzEwit4
         wHig==
X-Forwarded-Encrypted: i=1; AJvYcCWu5VSoVYiwf84YX+PRw9WVs5hlos5T8QSbopV93EcMmnEO4a1dIieILEyNVzzt8Rw335KEsg8tIEweclLeUChLF2LjyEoXnIvQ9w==
X-Gm-Message-State: AOJu0Yw7qHd6Bandrpe83FWc/NFMbPbPal14tW9ctzxclthNT/68HArJ
	V7J7cMoZhCu036DRGP9cXiOX//5dWGkXqHuMKvnFyMAAgGGWrlkAfrMdn0Z8m0LDo4+FPVscGg5
	sHA==
X-Google-Smtp-Source: AGHT+IFs+Nf82Ul1t74I4vPuVX4weNJROFN7yWXEOAVfX30LUtXPCkGRPdyvAgyHRn4LwSGt1RsLpaikF8g=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a0d:ca91:0:b0:610:fc58:5b83 with SMTP id
 m139-20020a0dca91000000b00610fc585b83mr1061193ywd.8.1711039081806; Thu, 21
 Mar 2024 09:38:01 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:46 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-25-surenb@google.com>
Subject: [PATCH v6 24/37] rust: Add a rust helper for krealloc()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Kent Overstreet <kent.overstreet@linux.dev>

Memory allocation profiling is turning krealloc() into a nontrivial
macro - so for now, we need a helper for it.

Until we have proper support on the rust side for memory allocation
profiling this does mean that all Rust allocations will be accounted to
the helper.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..858d802abd11 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -157,6 +158,13 @@ void rust_helper_init_work_with_key(struct work_struct=
 *work, work_func_t func,
 }
 EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
=20
+void * __must_check __realloc_size(2)
+rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
+{
+	return krealloc(objp, new_size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_krealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indi=
ces.
--=20
2.44.0.291.gc1ea87d7ee-goog


