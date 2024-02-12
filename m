Return-Path: <linux-arch+bounces-2233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52A85209E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CC31C21D5A
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 21:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64C5DF3C;
	Mon, 12 Feb 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/1ZZfBR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA5DF02
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774042; cv=none; b=NixFR8A8842NUF1IlxlwSfP0TOwYhOlJbXgNYWAKJ6+xk3X7pnpg5jlzu14K+d1UiVtavOSuBISBO8bvS7fMyplQKYKlXM5JTTcN+f0KCk12hFIRE2tTkjW/cYd9YqpgvNdShQt58AMrrDwOmwZacIWk87Rq0FUWSGlUXmKoBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774042; c=relaxed/simple;
	bh=MrsgVd/Qc298kApLcMr0fYQLGuQi40dU4EQGVe/x6w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sr661dhCBq8Ex9CfknHH1JcvnJ5yyVJN+RWbZYpcY1DWx9UdSVWLocz1uV0bZ5O8QvraxcwHNQVGNdOl44nt47ER7BZj5LbmnPNqP0b38Lrnl8foY7IwttBHVzVq0LYNtyfu3+a0K1jYwrl7AaziwiQLn8Rw/yv2O4rSV4bzLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/1ZZfBR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047a047f4cso97757657b3.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 13:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774040; x=1708378840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFi0jScQsczt4c2Plav2pAvubIeyjPFOX5wIUH8AZHM=;
        b=c/1ZZfBRdBbLqbqdFHuYzhc9WAChL0QL3QRl25KzATLzer6svTpEiPd1L/ak7eCfCf
         rFChlTkhcz+Xz9gSjYMn2ynJelxCPQJWx2d2kkLQ6fb1YsCd/Jq/zQSXfXHpbVFvruWF
         bR5hSonjSEnsIDKQ97gQQKzxX1aH86iDpKnW7O+837eLQKXus7xEJIF6hxmPcOL+6sDh
         P/Pt1YadLifgnfiJ/fOyhztuRxtiqCOaWkp1En6qyU/TTKjPYVYvTBgquBy5i8eGPFL5
         nRVLR2xRR24diT4HrF8MA8tUNbR7jgTuSyvnnzHsYW4WfYRUsDN7jCObhXsCXajOy3sl
         UPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774040; x=1708378840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFi0jScQsczt4c2Plav2pAvubIeyjPFOX5wIUH8AZHM=;
        b=iDONlQ3RhGpGS4ajKp0nw/q6ln2h4+kwr81XW2s4Co6XO0l5flsfMMUOYoFHqMd7S4
         5YBz4EAJWmFZtiSZGnM4Ch+te5jdAadob2krrqK3REjqXx5l4Rh7F0EB4c0YPSCoFIPZ
         JTrf9FPEUDH927qE+L9Abl97XzequC7yMHL0+NpGD9esGMLWhuVQNojFPDg93GVB+Qf3
         Gr0m1mVDeY1yx2hk0O4FiyP3pSoMAN1wSQB4QDhkv8QCWRzXWsPVLONZcChUFesgPPFV
         Jq67Zpl75cSev8k0pjb1ETib0gPkXXsofPovAMVannN9PrHEQTKEnnThQ2Hgg9dovgru
         Ha/w==
X-Forwarded-Encrypted: i=1; AJvYcCUAyijX1WA6vKuHLF9a42dgjXfXP7JSO/9Ni3yhfg6/IuV0y31kzDKZX5HDmq1qtvfJzXJgIs4szpgrfHG9IuZ2lC/E88NQfw7LPA==
X-Gm-Message-State: AOJu0YwHG5zpj/cDm+RnJI+NlL8z7krH0tMtDR88jRAj3ot2JgNYnTK7
	8AHcy5YfPDypOus4Ztb//MYzrX01MxTh/3a3wMqOKHZ/GDTYacAPAT+yyUVDXpBHmhuSjr4pHZn
	adA==
X-Google-Smtp-Source: AGHT+IG01ZIdCxyG6doWIwi6F85UI5DWfcKo01/n0teetJJReA8rQ10tG50Lh8eu7adVmXuhCLeMmXOg6Mg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:690c:b8b:b0:5ff:96b6:8ee1 with SMTP id
 ck11-20020a05690c0b8b00b005ff96b68ee1mr2134418ywb.7.1707774039644; Mon, 12
 Feb 2024 13:40:39 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:17 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-32-surenb@google.com>
Subject: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h |  2 ++
 lib/alloc_tag.c           | 38 ++++++++++++++++++++++++++++++++++++++
 mm/show_mem.c             | 15 +++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 3fe51e67e231..0a5973c4ad77 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,6 +30,8 @@ struct alloc_tag {
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+void alloc_tags_show_mem_report(struct seq_buf *s);
+
 static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 {
 	return container_of(ct, struct alloc_tag, ct);
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 2d5226d9262d..54312c213860 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -96,6 +96,44 @@ static const struct seq_operations allocinfo_seq_op = {
 	.show	= allocinfo_show,
 };
 
+void alloc_tags_show_mem_report(struct seq_buf *s)
+{
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct {
+		struct codetag		*tag;
+		size_t			bytes;
+	} tags[10], n;
+	unsigned int i, nr = 0;
+
+	codetag_lock_module_list(alloc_tag_cttype, true);
+	iter = codetag_get_ct_iter(alloc_tag_cttype);
+	while ((ct = codetag_next_ct(&iter))) {
+		struct alloc_tag_counters counter = alloc_tag_read(ct_to_alloc_tag(ct));
+
+		n.tag	= ct;
+		n.bytes = counter.bytes;
+
+		for (i = 0; i < nr; i++)
+			if (n.bytes > tags[i].bytes)
+				break;
+
+		if (i < ARRAY_SIZE(tags)) {
+			nr -= nr == ARRAY_SIZE(tags);
+			memmove(&tags[i + 1],
+				&tags[i],
+				sizeof(tags[0]) * (nr - i));
+			nr++;
+			tags[i] = n;
+		}
+	}
+
+	for (i = 0; i < nr; i++)
+		alloc_tag_to_text(s, tags[i].tag);
+
+	codetag_lock_module_list(alloc_tag_cttype, false);
+}
+
 static void __init procfs_init(void)
 {
 	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..d514c15ca076 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -12,6 +12,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
+#include <linux/seq_buf.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
 
@@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	{
+		struct seq_buf s;
+		char *buf = kmalloc(4096, GFP_ATOMIC);
+
+		if (buf) {
+			printk("Memory allocations:\n");
+			seq_buf_init(&s, buf, 4096);
+			alloc_tags_show_mem_report(&s);
+			printk("%s", buf);
+			kfree(buf);
+		}
+	}
+#endif
 }
-- 
2.43.0.687.g38aa6559b0-goog


