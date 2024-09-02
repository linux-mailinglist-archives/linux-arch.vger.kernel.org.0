Return-Path: <linux-arch+bounces-6887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555CC967E89
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 06:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9DB9B21492
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541D150997;
	Mon,  2 Sep 2024 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObbJEsFl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2E14AD20
	for <linux-arch@vger.kernel.org>; Mon,  2 Sep 2024 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725252096; cv=none; b=inirKCjvIoxWiKK65LFS3ekFWPres3C1wYGehOOAcUZ0cxr1WT7CCgptk+OOwBSYpWt6cwHkHl6OBAHGkqjATbqDObgb32wmJ0AhHktI0W2xluAlxHH5A+Rtfcp7s4OdoTUKB5101HojvgkN6xnAniUGegUc7GvmpTWTKefADfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725252096; c=relaxed/simple;
	bh=knnBZu7kPS2XiZHCOoomuagEtSw2A+8o8O+N0AJpu1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MMMz5Q03LQerax20dK9JQgpPSqzSAOGHl8HAV56xloVzk70AEipZ9nRsiqCKwSH4UIFrhNhi1+8eO7N1VTb9gHHOmoOFpZku7ew8wIYhWAcUr8FnaxGm1DTUjQcWs9AsqIOruNY3EbKg3fLiMwA35fvin07IOVVy7a87waGD8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObbJEsFl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso6508909276.1
        for <linux-arch@vger.kernel.org>; Sun, 01 Sep 2024 21:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725252094; x=1725856894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpU39ux3x2TTO/xeONsOF6qZRhVUZNcpjltFBicrmM=;
        b=ObbJEsFlLJj8q/uKPICo68h7XtFK06WRs42lj1wo+168rApzvRYv51HHAlJitWtqhe
         /uNRbCQ8Zmt/9Igg0ogICyUA3lZO9IfvX3pUV25vgVQz+ys9AdH++a+hDTIkc6e1tqHt
         fdybiZ7BtsHMX4zid+OMrBrn90A1oPdVW3rHcZvmkOTSkO/tI7piYo0ajYi78Al6IAmJ
         qaG8Rwy/6Ebw8cZtQyzfQPIAW2G++DWwCYOn5Kbh9ugsFMlCLN1O0xkdSKpS/DTZQ0H5
         1Zmd/csCJnyNXSm8miBpMWZa+P6PIF4PupFNY1iySiwyLlidYQfNw5OZbl/ZqaiqSyp8
         BXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725252094; x=1725856894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpU39ux3x2TTO/xeONsOF6qZRhVUZNcpjltFBicrmM=;
        b=N6qM6v7erBiepyexdZEkKLEEmcoPnBllQR9e0KK5Z1diWgqKpq+IDhhbQ2qqIzL26g
         ixYCQNVSLH36l/esl2TXXJtG+Jpb0W1OAwllflphFNKIfaYa7on59+4hkINo1W2nqI+Y
         1h5GM2Feetrmk2tA4O04N+709lhuCXcSrDGMItPaeApvWHtRu0hTXsGAfcQ6mP3NKIY3
         6YRWZbGFy3+7Q6/KZoRfOMUMELVZxYjiwRUBwjv7HWrCg8PMqBW+Svk73uSnfo7EtRCr
         LvA6U0/5hmiIh5euv0ArkPdRjm7z3GHDGL9yNk0bwWiL9tYQ0nQfXNC7CwG0q32IJB44
         3efw==
X-Forwarded-Encrypted: i=1; AJvYcCWWg0kmAO15t+xTe+Azip52NLq+b3mtVUJ/bewQpLDrXwgB4+258ALAnsloL25QkZ/G91rQWJRH+7af@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwz46xtlnCCTwTUbGCT9rUaYzkggAGn4NN1xJpc7EY681KbBz
	DvPonuF1NO2g628KZErtX4aljQAcZC+jqXfaM2oQQfWwqEO+v09l2W+ggdIFIwCD0OnIZrvSdOP
	Lzw==
X-Google-Smtp-Source: AGHT+IE+2G0xxDfv2kbdFSiqwhGjdz1DeNRKuCcVpqvSyerK6sADotCLCA7OoS3t5ommCEFjIJVLeySgq3I=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7343:ecd2:aed:5b8f])
 (user=surenb job=sendgmr) by 2002:a25:83c4:0:b0:e03:3683:e67f with SMTP id
 3f1490d57ef6-e1a79fed1aamr15821276.5.1725252094100; Sun, 01 Sep 2024 21:41:34
 -0700 (PDT)
Date: Sun,  1 Sep 2024 21:41:23 -0700
In-Reply-To: <20240902044128.664075-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902044128.664075-2-surenb@google.com>
Subject: [PATCH v2 1/6] maple_tree: add mas_for_each_rev() helper
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add mas_for_each_rev() function to iterate maple tree nodes in reverse
order.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/maple_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 8e1504a81cd2..45e633806da2 100644
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
2.46.0.469.g59c65b2a67-goog


