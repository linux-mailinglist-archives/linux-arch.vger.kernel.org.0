Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1358E7D5285
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjJXNsF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343559AbjJXNrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:47:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E901E10F3
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da05c625cb9so179236276.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155224; x=1698760024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHgfLVMScT5H/FxRnxJh+3xP9v/l17ghYQJMJklbWxc=;
        b=ogBFPLi8fvrnXU6vKCvucgyBHD5/3evNz0uRdyIFs1oqcaBX8qH5RZIeDsGH5V53QY
         JLd7XMnbQQW4W6PcPFwunDg79vf1GF+pP0ZszfguoLxlNiM6dNl9bhmgYu9aYHXqe5MG
         y16phkyjP8bmXcYvLbVM7YJLoOIG6SS4BfVuqAGapmdfBrGOrgcKjgu7u44cD8cOm9kE
         qpUSR4ZpYt1oFZNTpSldByfENNAof0Yda8pAhuvtUGtgQiJ0Lwc5DkLRBOPLUEGZpma7
         qyjusp0eIOv43YbpV2B02o5Bmw7aBZdYPAM0vGYC3iHwM7a+tawV6Rat4RnOz5U+04yt
         JClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155224; x=1698760024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHgfLVMScT5H/FxRnxJh+3xP9v/l17ghYQJMJklbWxc=;
        b=kgAAsjZIe8ddWps4r82itbvZkjM72o1AH7Zhacxw/3l5O2Y8RWbieZp9p8bnXgnEif
         B+0FbS/SJIWzpopBLp38/gQc9MJ8bBK0EYKm54uJDbtAWVQkAztgGxwH9KSI1MiVHzuf
         zoHP8D4b7NTlrgRs7FQr23qQwF28BA6hGl+yjxwxidmdDiRv5P6htuKmsFDSnWIUzE9m
         ASi/OOJyNfF+xrinqJf93FGRq7K/vLEtvqVerAVbE1bI5C4n/yxQ18wcgt7RuRDRncX1
         tfEcC9KyaPyeJ7fPg/O/twzhmFp+tfIQuGMuMRbOx1QEu1paocACtdTq6YjOJWgTVSwa
         D3Rg==
X-Gm-Message-State: AOJu0YyBC/Y0XkWrcUtR7ehaY2fZbEGbG67+Y4q60T8SMR1KfzWbS9iW
        EaZ/kVOrklkxtC7iS2IXTsMaUaK5se0=
X-Google-Smtp-Source: AGHT+IHeBKvEZxCc8z4s40S7ha5hgPZX8U0NGngnhsFR9kbksVyPLDfdSNwpUqF/X+vAqjdciG/7nvEnCYM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:297:0:b0:d9a:4c45:cfd0 with SMTP id
 145-20020a250297000000b00d9a4c45cfd0mr213074ybc.2.1698155223878; Tue, 24 Oct
 2023 06:47:03 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:07 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-11-surenb@google.com>
Subject: [PATCH v2 10/39] mm: prevent slabobj_ext allocations for slabobj_ext
 and kmem_cache objects
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slab.h        | 6 ++++++
 mm/slab_common.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 5a47125469f1..187acc593397 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -489,6 +489,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	if (!need_slab_obj_ext())
 		return NULL;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return NULL;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return NULL;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab) &&
 	    WARN(alloc_slab_obj_exts(slab, s, flags, false),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2b42a9d2c11c..446f406d2703 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -222,6 +222,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
-- 
2.42.0.758.gaed0368e0e-goog

