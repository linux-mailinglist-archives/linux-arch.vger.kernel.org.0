Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259835A6FD3
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiH3Vvm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiH3Vuw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:50:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C311C15
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:49:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n18-20020a25d612000000b0069661a1dc48so725574ybg.20
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=+dBCH/ZYeXKPl1XZC0y8jtwH0hgKGXE3JjJWq8gRM44=;
        b=AFaSMy8jXac7TuC+3zPxWUGJEoV6Xwt0zQp9MqDmFFlT9mWJtIdF7dkyLAZ2dlc2YA
         b9Gf5k0v2Zvts/DmzzZ5pyBGK4PvMyQtpd/jCDUfU7pbPfnKneDUuVfIqoh8xzC2EEXM
         ggO+9/ET/L3N7vFPV9TWkym8O3GXfgaPKOHQOvjujiuqNd9k0qGNIcoGl/dBIZk4zlFa
         QTsb0Fx654oBfwlYyCvPgpIbUnjCokKwOPL7A775wrhi+ShDtrR1D6bLCXYg9BBaYtDw
         bc4QILCqScR/90fRkJQtLt8mPydrXHAQRmui3zER0ZDrlUBSto4jKF/epnVV4Tt3A9sc
         lVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+dBCH/ZYeXKPl1XZC0y8jtwH0hgKGXE3JjJWq8gRM44=;
        b=WhtZZ7BzZ3ANhDuL5/cPBJYdI4N7RW7MX85uqMJjqR1CbNlle7IaUbvvBhw12YvmCe
         s2Ls/+lTjKdrBDxHmELdneWArqYDN9mJvvEj/J9y1O2oRToCG1iXeXRsYSxJFjUFyhUf
         AhizB5cG4jqYIlgf3tEaTyFy1M4F4Izcg8id+OUPGtRqpOd+QMXYVF49gtJLJ1x9AmFD
         QfLksrw+JSfw2e96UptIEDpJZQ5CEzOJRmC7+07f7Hl9YXfdsZPz14Ckgiu4AOTwoacQ
         Mk0c78HCNPuNsutejlDIzrOwfWfO5iLcINYO4rR/L42LMHO2LGB+YdZOeXkw61qeM9Nf
         HeiQ==
X-Gm-Message-State: ACgBeo3ZwcZz8+xyu+JDPXmNs4tJBVrxlrjnP+BMfiR5YZLI23XtWZAK
        7lXZecFAAtEV1Srivm+w6YQ25l4qjcY=
X-Google-Smtp-Source: AA6agR5IHyLOVpCYPsGCTl1WAh1PLHzSkOgAmQAkkvI/LDvSxkU9pCXJyMghFPF7B9PD/jn9WBQElFJpekI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:94b:0:b0:68f:4e05:e8f0 with SMTP id
 u11-20020a25094b000000b0068f4e05e8f0mr13319593ybm.115.1661896195289; Tue, 30
 Aug 2022 14:49:55 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:49:01 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-13-surenb@google.com>
Subject: [RFC PATCH 12/30] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
when allocating slabobj_ext on a slab.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/gfp_types.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index d88c46ca82e1..a2cba1d20b86 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -55,8 +55,13 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_SKIP_KASAN_UNPOISON	0
 #define ___GFP_SKIP_KASAN_POISON	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       0x8000000u
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x8000000u
+#define ___GFP_NOLOCKDEP	0x10000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -101,12 +106,15 @@ typedef unsigned int __bitwise gfp_t;
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
@@ -256,7 +264,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
-- 
2.37.2.672.g94769d06f0-goog

