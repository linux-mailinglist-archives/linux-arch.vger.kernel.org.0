Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8937D5284
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjJXNsF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343553AbjJXNrG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:47:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712EC10E5
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a92864859bso39842087b3.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155221; x=1698760021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlkdsRQXiDN3rg6CmmMqMbDupjvE+Qo4H/i7Q99VP7E=;
        b=uxaCAWtyIJT6QvIegl8QCczQrkHie5BVYJuqhMS+k5AFm6IyO61Gp74KG1GLSSet+N
         JVmeRny/hD8P2gA/CBe6rvFAM0vCSu9Kq/EtwTUJHp3UgrzLurZ6sO/lutfjVZ9u3pi4
         Cwkfh1GCvT+zGqaDj+SlLcQGS5bNbb0kszgGzY58vVxaTUoJvy1FkV70jx8v2H8z539B
         5rSqX2vCM1UbewVAL58EikUcI8fLRr2Wpv3mohu3gmB0aQ4SMd0OfuqqbLTgZBQQZHt3
         /FghF91vUsZRzwNe1Ht1nwKQvcy5znGVX2e1DAKFjBKVHUGfiPwWMLU7Ol8qA0TAyWJK
         GcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155221; x=1698760021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlkdsRQXiDN3rg6CmmMqMbDupjvE+Qo4H/i7Q99VP7E=;
        b=FMx3g+ouw+fHV+4FIqjELydBLroS6A7cCkXtkGU9MYOocsy/8g4PApW89y0S7EYvmP
         +r4FCUGN1mZ+xmnapc/yauZZQDihsXpUUgp5V8epcYwkbYwnf8fJ3g3jQ9wvcSM4AcW0
         tRb/94eaqcrNkCG2zNanvHx67V8UYDnxozLoPlzIii7X5GcqHdB5/xHh29eChJJ4cNsA
         0Va+mi/gGk/hiEfEbw3zhNMCAUDeJnVPm9akCWR/Uebe1IDoWRwsVGJ+8HptTkSbpI9+
         SSPsKE1pAxf7bDV4oqUEAnKG5fxuB3fKDj5v7qfviXufovS8eBr6Kf8PZju8itROgU0R
         0lsg==
X-Gm-Message-State: AOJu0YxtbJbCzl5u258xs+rz5XRX74Hnz7JNzstXIS7Do7UvAaAMBhal
        eljNV8zn6MUCmtFRSfAD/QRh0KAz680=
X-Google-Smtp-Source: AGHT+IH4vkQmrXlidCVXKzYYty2ay4HPBInW5lCi3Eqpl3vZeKIQVqiJUvatNMDtWsMNHeDdaowbWxA4kC0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:d50f:0:b0:5a7:be3f:159f with SMTP id
 x15-20020a0dd50f000000b005a7be3f159fmr287305ywd.5.1698155221495; Tue, 24 Oct
 2023 06:47:01 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:06 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-10-surenb@google.com>
Subject: [PATCH v2 09/39] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid obj_ext creation
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

Slab extension objects can't be allocated before slab infrastructure is
initialized. Some caches, like kmem_cache and kmem_cache_node, are created
before slab infrastructure is initialized. Objects from these caches can't
have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
caches and avoid creating extensions for objects allocated from these
slabs.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/slab.h | 7 +++++++
 mm/slab.c            | 2 +-
 mm/slub.c            | 5 +++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8228d1276a2f..11ef3d364b2b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -164,6 +164,13 @@
 #endif
 #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+/* Slab created using create_boot_cache */
+#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000U)
+#else
+#define SLAB_NO_OBJ_EXT         0
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.c b/mm/slab.c
index 9ad3d0f2d1a5..cefcb7499b6c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1232,7 +1232,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 		offsetof(struct kmem_cache, node) +
 				  nr_node_ids * sizeof(struct kmem_cache_node *),
-				  SLAB_HWCACHE_ALIGN, 0, 0);
+				  SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 	list_add(&kmem_cache->list, &slab_caches);
 	slab_state = PARTIAL;
 
diff --git a/mm/slub.c b/mm/slub.c
index f7940048138c..d16643492320 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5043,7 +5043,8 @@ void __init kmem_cache_init(void)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
+			sizeof(struct kmem_cache_node),
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	hotplug_memory_notifier(slab_memory_callback, SLAB_CALLBACK_PRI);
 
@@ -5053,7 +5054,7 @@ void __init kmem_cache_init(void)
 	create_boot_cache(kmem_cache, "kmem_cache",
 			offsetof(struct kmem_cache, node) +
 				nr_node_ids * sizeof(struct kmem_cache_node *),
-		       SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
 	kmem_cache_node = bootstrap(&boot_kmem_cache_node);
-- 
2.42.0.758.gaed0368e0e-goog

