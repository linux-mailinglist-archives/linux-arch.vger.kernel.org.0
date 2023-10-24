Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB97D5331
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjJXNvM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjJXNuT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:50:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57663269D
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7aa816c5bso59863127b3.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155279; x=1698760079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od9SIx6nrlV00gepzGuthWnU/KWY+8bGDr+wczV24Vo=;
        b=E6kpLefjgKPo0dphH2vyKJTPSa0dqO9i9a5GanO+53ZwZB/w4bJdOOr7fBG2Nirf7s
         pMiP8Z758l+ZTWAdCS3BqJiSYr98zy66BvgWD3xIwuhj0hcFSdJdcbh0jIlb3gIw2HwX
         wNKEG9IN6kGZYWRMpBu4pafPHfUdsxEXSzDI5Hh+3uR7IU2ut/aP8ItFL9bIlakdHH3F
         uA+1PAW1uAxmIk2U1B3jwra1vncjnkkLf09adv2/EmwFl6oCezFkYL89cYzWSk2oJU0g
         YeYfIXV5GtL8iVYeidLkDuCbBiB6CTtlS8nbRoa5X+w4H0+DdJqCqW8PHDjNj8SV6boi
         FGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155279; x=1698760079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od9SIx6nrlV00gepzGuthWnU/KWY+8bGDr+wczV24Vo=;
        b=sOjTIFjfvND5XbNau5VgS3tEVa03PcCwWaHN8P7aY1+lDqklCjno04wyUqBkSQNRl5
         7SWAn6EdwdRoNpgxqYsytKWDFr+fx258TPaNnWaeGWbbZ1+FCJD4+G44dWBVbquUkYeU
         9zK0OUJD9H8FOue/gbWruKrKX+fUumJRCF5dust3X+UHFTlKsxSy13iCKeHRGo/ffhDv
         atyEEohKusRAGhHyNuWGinSv4VmCY3vFlhEXRJORbJTNhA3dAaeGH24z0nFhtju5QXcN
         ThIhv7mDj0JGJrx/DB6uf45yTfsmaWH1qfQxx6Gu20O/B+bn4WraY+Q+y4CpOz1owjEd
         BeiQ==
X-Gm-Message-State: AOJu0YxaraeAun+745C3u0roDKyYbZeUmFK1LuRnNfwYztGi1q4tyYFE
        ykBe2/Il3LPnoO9y7jkCJB6ocpIxmio=
X-Google-Smtp-Source: AGHT+IHTNe96EdD9LLd7MUZqFW1q382ncfW7dWktSIhQfdb/UWURbia5QNDViYiMSeL9bXxhLhwSMXQz/Wc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:76cc:0:b0:d9a:68de:16a1 with SMTP id
 r195-20020a2576cc000000b00d9a68de16a1mr246429ybc.0.1698155279398; Tue, 24 Oct
 2023 06:47:59 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:32 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-36-surenb@google.com>
Subject: [PATCH v2 35/39] lib: add memory allocations report in show_mem()
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, surenb@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Include allocations in show_mem reports.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h |  2 ++
 lib/alloc_tag.c           | 37 +++++++++++++++++++++++++++++++++++++
 mm/show_mem.c             | 15 +++++++++++++++
 3 files changed, 54 insertions(+)

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
index 2d5226d9262d..2f7a2e3ddf55 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -96,6 +96,43 @@ static const struct seq_operations allocinfo_seq_op = {
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
index 4b888b18bdde..660e9a78a34d 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -12,6 +12,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
+#include <linux/seq_buf.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
 
@@ -426,4 +427,18 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
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
2.42.0.758.gaed0368e0e-goog

