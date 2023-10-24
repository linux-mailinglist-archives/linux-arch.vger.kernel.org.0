Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF27D5302
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjJXNuV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbjJXNtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:49:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC91FF6
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cc433782so55253377b3.3
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155257; x=1698760057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OUWmo6RLkaXHvLlOp0/KP9HFW8MtULS71POlQ8HMTCI=;
        b=0SfEDlsjFph2hfUTgDdtPdJfD9EF4HnWhHqceRZHKqOWdnDRz/D+lsJ6i5WJmxMsQs
         3JG5/BQVP6jsoW8qmY13rD+i5tsNDHkUezUqCuKjv/aVuMkaI6euHBKWSZQCUyfhTBtf
         2uZ1EG0mcSHGlLbMH+miFiUgWP00R9bPULDuxZ1ywnc0AtARr2M+QImcmXoJ/Qqm/3Ug
         5iMQDTr6ICjIQcAcL0sVQHIsqp9OJHZHl+4oTb4jjfDgiSetrKlMmhdpjF+BTkGvmnqs
         zvy3Qdy2V8spEMyfMeoF/eNqsgZ2pTEOC5gPILWYtlTEcypaKn7grh68F4KHNT2PtFs/
         aWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155257; x=1698760057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUWmo6RLkaXHvLlOp0/KP9HFW8MtULS71POlQ8HMTCI=;
        b=nycm2dtdPRIYWY0DsN+iUFq2l51IxjLETWtcTLawqOk98koQjsc7aWFEEnbMqd7Pxz
         bal103BAquM3PyDhlUpagLbGDhTvaig3lDBDLBs43WCrN/UpMxhto5TR2jcKQkYH3Y6z
         EemJl8+X49jm1E46/zBJnf5kOT15177wsT4MC2Qy6Hm1oYj7OPWmbif80QRc3dtt6Wc9
         I9D+yLC/DRJqgHlwkTBuEjpTupobCfa60v34VOn/teHt1n8ajHrpmmsmh1l0S+V8jAIe
         g2HDv7SIH2FYn3VSdDW19HTiId9rnZmpKYlzxhVHa/OBHKIrw07PjZfcPzQcHAqrxbjw
         qeeQ==
X-Gm-Message-State: AOJu0YxPA+NaySiL/mzhjmJknOdP5qtCYcW6ftciKDQK00qOsRfAiGxg
        50qEm08/lmxVD2A+NNdpeHkrhmmvGZU=
X-Google-Smtp-Source: AGHT+IHQ3VEMdDHth6teCnTo9GNQ4j4PajdUPKRUHryC857gV5hBaW9Bct9jFesWnWbFdQlkFZvB05Yolzc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a81:48c9:0:b0:5a7:db29:40e3 with SMTP id
 v192-20020a8148c9000000b005a7db2940e3mr273153ywa.7.1698155257303; Tue, 24 Oct
 2023 06:47:37 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:22 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-26-surenb@google.com>
Subject: [PATCH v2 25/39] mm/slub: Mark slab_free_freelist_hook() __always_inline
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

From: Kent Overstreet <kent.overstreet@linux.dev>

It seems we need to be more forceful with the compiler on this one.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index f5e07d8802e2..222c16cef729 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1800,7 +1800,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
 	return kasan_slab_free(s, x, init);
 }
 
-static inline bool slab_free_freelist_hook(struct kmem_cache *s,
+static __always_inline bool slab_free_freelist_hook(struct kmem_cache *s,
 					   void **head, void **tail,
 					   int *cnt)
 {
-- 
2.42.0.758.gaed0368e0e-goog

