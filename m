Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75F6F340D
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjEAQ4z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjEAQ4J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 12:56:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959B2102
        for <linux-arch@vger.kernel.org>; Mon,  1 May 2023 09:55:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51b7810ec2cso1417195a12.1
        for <linux-arch@vger.kernel.org>; Mon, 01 May 2023 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960129; x=1685552129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6/s7foZNj5EExVH4gZckioJVPcIxI52cq1C7FfTD8=;
        b=j+Kr4wFQ8hb6ghgASWLoQmwshyZipq1bE+D/CA603zsc4kB1n7R3CTQw1X9N4pK0pE
         0zmuTlr7BciP0EtB463YkQ7YcnZO9MQaA53eLGwRosKH+IiuL9AF+xukRwd1DIpRoQoE
         CuOOiRq7K1VtqSyYvIO65JDUgFMtQPFNC1XFk5UKDZu8zG86BBXEpcIuAsalgfYjpqSk
         4H7kaQB7eIw3KHROJbChdasmtpmhAOtDolQRdOsPV+jVQQISfSODNw3+xILO7OLY0pMp
         pmy+NWFCOxFQwMauo6Mv0q9Qa8hd2IlOPM48vsABoana6/QPtONXZz6Lhi9KWaOg0TwZ
         kOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960129; x=1685552129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6/s7foZNj5EExVH4gZckioJVPcIxI52cq1C7FfTD8=;
        b=j3SEXXYnzAtr+XbUTNsBEHcwoIC2k2DrOBUTN2FFWzqxauBAK15aU+X7vxSRSE2f5E
         arN28eu927d7Da8J/haS1lO2QSMR6pHsNbr4ijeBX/oV7ZXxu3ZcSBMkIL0nb0FPN3cf
         kgMYP6pu2eQxB022MbrCIWwbCMpBeunSWW5Zl3HWU4UmhdaqlAULIxJ8FWMolIKwnXJL
         IiZZvpz4WCiBWf31w7Qz9VaHInsc92jUOP6runrNT7YIcFC0AuEHy4klsBhRhwnsZiyk
         nx731REYBEg0f7ILp+0jqbIj+JvXY23BjGM0BdO0S3D8VVPg9nv6tql0ChOPgdwBqjpN
         d16A==
X-Gm-Message-State: AC+VfDx8Zz0t/VhZYXKVRyu9QUw7gvYnPbOXk+Wa60rVgjkp9UnFZzI9
        WdizkCJxEo9PLqrdz1qxcx2F5yTCaww=
X-Google-Smtp-Source: ACHHUZ501oAX8t/t8FRpUPo9PQ1t5ZgNv7pUhAgWb4tueLlYCBA4gtRhgJc8gsKy6W9D1EibQZVYd1jDC2Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a17:902:6a84:b0:1a6:4543:d295 with SMTP id
 n4-20020a1709026a8400b001a64543d295mr4657171plk.5.1682960128744; Mon, 01 May
 2023 09:55:28 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:19 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-10-surenb@google.com>
Subject: [PATCH 09/40] mm: introduce __GFP_NO_OBJ_EXT flag to selectively
 prevent slabobj_ext creation
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
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
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
index 6583a58670c5..aab1959130f9 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -53,8 +53,13 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_SKIP_ZERO	0
 #define ___GFP_SKIP_KASAN	0
 #endif
+#ifdef CONFIG_SLAB_OBJ_EXT
+#define ___GFP_NO_OBJ_EXT       0x4000000u
+#else
+#define ___GFP_NO_OBJ_EXT       0
+#endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x4000000u
+#define ___GFP_NOLOCKDEP	0x8000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -99,12 +104,15 @@ typedef unsigned int __bitwise gfp_t;
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
@@ -249,7 +257,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
-- 
2.40.1.495.gc816e09b53d-goog

