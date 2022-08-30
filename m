Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ABE5A6FE0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiH3VwH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiH3VvX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:51:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACDD1EACC
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:50:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33ef3e5faeeso183140857b3.0
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=gY+PdoFf3bNnEB0W9Vd0woPoFdt9hhtegjhiPtTj+AE=;
        b=pP4c3oP+YdesowZgNPs4eE1Xp1hWxAr9Ov2IDGBfglQ7uK9BWLrmzhDJ/utRpkPDJK
         tLMoERW1+3/smlLhO5G46VfqVywVDMABKHAv9jnhzz9ZshpBvX9ODCL7lsQaaZS0MLOk
         moKmQwwsOGjNod+M4t/tjA/+LNyP1VXOc5752+/a3Um/WwaPBzNEpe5l2cE7BDo787CF
         /PWmu6igP2xWBoiVtEHlimVT5AWdWMQxPlHvsqYO1szpGDqcGUPThIrLg/hGXqOCKmhM
         XRoOlsQx66oUshjUnxZWYY0qi/lYffvprIXZMUGryr7KjlXRCtsueZ1FZIWTKefulhTk
         stEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=gY+PdoFf3bNnEB0W9Vd0woPoFdt9hhtegjhiPtTj+AE=;
        b=ICW43XX7u0dEZ4UEJ3Md+0MDN7kP4oxiopZwwpJoLafEpCCRgcefWwlnmm13bLW5Qh
         ZpQ7KNhtBZ5z7Lo9Io3tZHRoR4p0n+PqARrtAej489unUGnt01DKGLPFunA+qpXTdpy+
         XiH6H2Add9D1Qu7WMztil/Ivx4gXixIWJWLUrAD0W/P3m+4YLcwYz1YpODh3HiL92OAZ
         aaI8t2MDYQHQZa6cJzBIQeOL0KfAFGnSwstTz8Fm2RfO7x7JeLKWccJA0V11XJcp9Mwj
         jqHgZp3DYbC4FhlfGaEbE390CRTiAFFfvphFz26vWU2WASJNOKfUsal6jsWy6bbZOGOG
         Nt0A==
X-Gm-Message-State: ACgBeo1P2K+IIKPFGHTgpeB0A+8p/NY4RND/jFtaj203Ka1Y/NnNQRuE
        zdb9jEV1Jc799ekzg5Ud9DUqNZdj070=
X-Google-Smtp-Source: AA6agR7WLdIMrAR0FWfuROzkHWzqEUxzLPyMUzXzjD/46yfJpgch8NK3VM+VyOZeNwYsSnGIQ5TrqCRxJvQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:ba91:0:b0:683:ebc2:7114 with SMTP id
 s17-20020a25ba91000000b00683ebc27114mr13866830ybg.319.1661896200808; Tue, 30
 Aug 2022 14:50:00 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:49:03 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-15-surenb@google.com>
Subject: [RFC PATCH 14/30] mm: prevent slabobj_ext allocations for slabobj_ext
 and kmem_cache objects
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        iommu@lists.linux.dev, kasan-dev@googlegroups.com,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
objects. Also prevent slabobj_ext allocations for kmem_cache objects.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memcontrol.c | 2 ++
 mm/slab.h       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3f407ef2f3f1..dabb451dc364 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2809,6 +2809,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	void *vec;
 
 	gfp &= ~OBJCGS_CLEAR_MASK;
+	/* Prevent recursive extension vector allocation */
+	gfp |= __GFP_NO_OBJ_EXT;
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec)
diff --git a/mm/slab.h b/mm/slab.h
index c767ce3f0fe2..d93b22b8bbe2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -475,6 +475,12 @@ static inline void prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags,
 	if (is_kmem_only_obj_ext())
 		return;
 
+	if (s->flags & SLAB_NO_OBJ_EXT)
+		return;
+
+	if (flags & __GFP_NO_OBJ_EXT)
+		return;
+
 	slab = virt_to_slab(p);
 	if (!slab_obj_exts(slab))
 		WARN(alloc_slab_obj_exts(slab, s, flags, false),
-- 
2.37.2.672.g94769d06f0-goog

