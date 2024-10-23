Return-Path: <linux-arch+bounces-8482-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2199AD224
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C744B24A90
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182D1CF7A8;
	Wed, 23 Oct 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qx652BjR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7E1CC8AA
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703287; cv=none; b=QAbPRdJ79/sigdZblimYMjgFD6nZIg+szanlSJfJabQtE0R5S0CIzroJfR5tNrZX/ezOTWqTzHqE4IMvhcYgz+pBA/mtDFHoiUjwQJh1n+tBrUUAYr1CSawHOT8FHqXRGGi+qO/8oVrzpm6LBkVJzd14YB5uS0O8uYvDTGANuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703287; c=relaxed/simple;
	bh=oPiAZk7sAUwyc2ZRzUfKOKHVYouPvs61/fhZTZAzOCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNYvNSIdTZ5WSp6P6z1A3fKvEDsf29d8ebZne5kREDCx8MtNcIeCz3rXiv9b4bDG0YIzqG1kJ8w+PzbJjOJ9H6SLmwbDr4xBLkLx8mQf9G8E/qTJnyseSbq6CHnkVcusipzO9NhaWegRgXRkvNHQGee7weNPY+axJpjqMqWS79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qx652BjR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35d1d8c82so112215337b3.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703284; x=1730308084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy4VkAGTnueEjEvw1TSjR77Zk0lX1faSNj+Oljrwa2Y=;
        b=Qx652BjRJlLBDhiwtgP7rFltqcVCeOz64AMfJMi1lfmNwRT3W6yJF2h66vz/NOdKvE
         iZX2r/6r71iZd3H6wP+kW3t8a0HXMP2YOsXTg3tOJAbvPBlyVSndmovQp59wBX4nnbV8
         jejqeBwwjT7qIeRe08oGq0Cp83lM1+FOvt43wByN6sfYVEa14DIljwjJONrccZ7wFFHv
         fZNNV++nuuSoZIeX9NJpihOasG9IF1MQ4QIyGQFQJs0TmnWguyVWNAywiZshv+JiuOUm
         SH/lNNTmYiapZtyvrkKBGRczlN8UQ2w9m85DNYwABykAZaiWY/T+pOmFff90ZJdc96hQ
         4Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703284; x=1730308084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy4VkAGTnueEjEvw1TSjR77Zk0lX1faSNj+Oljrwa2Y=;
        b=JYGaoZSr7w13VNYzzJQ3S8xk2CzlT0jYZklQAJJiDcsKB+PhMoZTMtvXCBtJlzkZy1
         00twTDf97GD/nZFbs+C1Na+z6NLIuZzt4qhRpZ5YLkpij4uxIKY0F0w+gUk+954iktJz
         BBdRbls7Uz34mclKRsdet4ma9fiOrBZHO6rvv87pZHKM/RuEe5KBAeB1MPnBHOae7MjT
         T3jk8C48LpyzqniQU99VTnCwJI4ED1jP4of5s/uX3ADnXyVrQzVb/1J0bl1lPMBWtrol
         7ZVeTUPiKBpgkbQ8oP78kcpXrbegdNeUTYRIUhxmYqB3j2lYNmAGRZYplgfma8vtIWKV
         b4CA==
X-Forwarded-Encrypted: i=1; AJvYcCXYtJ7dV1akFKP5+Vwq18mxmU1N1CSxXZGMqocUN7ffGU7IRy8B8bnz3BLJY3PVyEXWPLV5SzdBhjiz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7o/HFTE08Zbj2a3iMFyWv9SMN0NbvwIfdV5fk0C58q4Olu+a
	+ReuxS5V8gL1N8Jr5S4JPse0JU3IDdYMAP72OoFxKCkTEjb8/H1pWSdw4ZnXk73LIBM51lGjpwk
	cdg==
X-Google-Smtp-Source: AGHT+IG5P3EOBq94xAhs93OihXu6fn1+vh8Hj0b9Xh0nro0ohDjLm9Tm7P85Bm8yXiSBBXuIOUCegUy3OSE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a25:7241:0:b0:e2e:2b0f:19fc with SMTP id
 3f1490d57ef6-e2e3a631bf2mr3476276.4.1729703283882; Wed, 23 Oct 2024 10:08:03
 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:54 -0700
In-Reply-To: <20241023170759.999909-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-2-surenb@google.com>
Subject: [PATCH v4 1/6] maple_tree: add mas_for_each_rev() helper
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add mas_for_each_rev() function to iterate maple tree nodes in reverse
order.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/maple_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 61c236850ca8..cbbcd18d4186 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_for_each_rev() - Iterate over a range of the maple tree in reverse order.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__min: minimum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range for the
+ * entry.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_for_each_rev(__mas, __entry, __min) \
+	while (((__entry) = mas_find_rev((__mas), (__min))) != NULL)
+
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 enum mt_dump_format {
 	mt_dump_dec,
-- 
2.47.0.105.g07ac214952-goog


