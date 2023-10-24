Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F587D52B8
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbjJXNtA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343593AbjJXNsX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:48:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6709C19B9
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so5381128276.3
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155241; x=1698760041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zb+0nW/ZZ6NW74eJtanLAYQ/ebma3WHtobF3vZ6u4HE=;
        b=RzHufcbgXx2cEN3yIVWU4PH1tEu/cLpKoxe7nA+zR5SLjN9VGaPP2vNr8vhDCax+4g
         ax+h3usOj5cObP7vEmL5yTVFGZHxIM60QKZwhYNloIfizPp4BOW8mAcS//o4OX+q8rz0
         mma8Di4JRbJT6PmY8K8R0XlTxllX6p08tgirWbxkMZaIlkrHn81JGU06qZHFvpAnL8XL
         pNYvynIuCsq1H5vH1w/MfgVIO1GHIvY6qFBSvUFImn9urejhBSpKMGwRf4ZUtJYDU0yF
         TElOrWWUZ7Db4OSv7KYCaz8rATN2Ycx+se30qBZwMr4Y0BsGN9eNRQJpv7CluAHAXyAi
         PZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155241; x=1698760041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zb+0nW/ZZ6NW74eJtanLAYQ/ebma3WHtobF3vZ6u4HE=;
        b=k/Kkp3KIn9jOKYQwixa28I5vt5Q+f2OUkwjHUZzkPC94Kw8ME+fRhLOnRVvyvc1Ppk
         8kHGfK2PE3jrVKdU9Ig6VhLNpKmGCltDQxVb+kCTNccI/uMCbLu20zdJrqASVbswDUm2
         KolvLlVv34Kn6Mrll93oUooMJkOkZ8W1h8jmLmEU/Kgy8YAo2YhIbBMsZSGYd9vTkSav
         tnrIrZeZkkV6uFjUMuw0BI6gyWkbPVVJgTbzr85qjOPu1U8jbH2PbL12v+FaCa1wXvXu
         21iWJ0/Oclxxhhmi4hy3WaD7CD0NhbJIjR9MdGJjkc/rBfIN+K2mUGyh+wOtHjjkFcpv
         fKEw==
X-Gm-Message-State: AOJu0Yy/F47qRaJIEYmZK3/sfojq0N8ka78+1e9G45HZ6iwZ21lzz5Ho
        kz77Yy8SUQ/nbUWMsIDtP5xHsX+VsKE=
X-Google-Smtp-Source: AGHT+IEpPcNXSaLopMEVj+acIv3rs50iHU0ea/y8V1UNdWnab+iEcPBoSFwF1WABxkknLPWrzIDF+i6tstI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a05:6902:544:b0:d13:856b:c10a with SMTP id
 z4-20020a056902054400b00d13856bc10amr261040ybs.3.1698155241467; Tue, 24 Oct
 2023 06:47:21 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:15 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-19-surenb@google.com>
Subject: [PATCH v2 18/39] change alloc_pages name in ivpu_bo_ops to avoid conflicts
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

From: Kent Overstreet <kent.overstreet@linux.dev>

After redefining alloc_pages, all uses of that name are being replaced.
Change the conflicting names to prevent preprocessor from replacing them
when it's not intended.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/accel/ivpu/ivpu_gem.c | 8 ++++----
 drivers/accel/ivpu/ivpu_gem.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index d09f13b35902..d324eaf5bbe3 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -61,7 +61,7 @@ static void prime_unmap_pages_locked(struct ivpu_bo *bo)
 static const struct ivpu_bo_ops prime_ops = {
 	.type = IVPU_BO_TYPE_PRIME,
 	.name = "prime",
-	.alloc_pages = prime_alloc_pages_locked,
+	.alloc_pages_op = prime_alloc_pages_locked,
 	.free_pages = prime_free_pages_locked,
 	.map_pages = prime_map_pages_locked,
 	.unmap_pages = prime_unmap_pages_locked,
@@ -134,7 +134,7 @@ static void ivpu_bo_unmap_pages_locked(struct ivpu_bo *bo)
 static const struct ivpu_bo_ops shmem_ops = {
 	.type = IVPU_BO_TYPE_SHMEM,
 	.name = "shmem",
-	.alloc_pages = shmem_alloc_pages_locked,
+	.alloc_pages_op = shmem_alloc_pages_locked,
 	.free_pages = shmem_free_pages_locked,
 	.map_pages = ivpu_bo_map_pages_locked,
 	.unmap_pages = ivpu_bo_unmap_pages_locked,
@@ -186,7 +186,7 @@ static void internal_free_pages_locked(struct ivpu_bo *bo)
 static const struct ivpu_bo_ops internal_ops = {
 	.type = IVPU_BO_TYPE_INTERNAL,
 	.name = "internal",
-	.alloc_pages = internal_alloc_pages_locked,
+	.alloc_pages_op = internal_alloc_pages_locked,
 	.free_pages = internal_free_pages_locked,
 	.map_pages = ivpu_bo_map_pages_locked,
 	.unmap_pages = ivpu_bo_unmap_pages_locked,
@@ -200,7 +200,7 @@ static int __must_check ivpu_bo_alloc_and_map_pages_locked(struct ivpu_bo *bo)
 	lockdep_assert_held(&bo->lock);
 	drm_WARN_ON(&vdev->drm, bo->sgt);
 
-	ret = bo->ops->alloc_pages(bo);
+	ret = bo->ops->alloc_pages_op(bo);
 	if (ret) {
 		ivpu_err(vdev, "Failed to allocate pages for BO: %d", ret);
 		return ret;
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index 6b0ceda5f253..b81cf2af0b2d 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -42,7 +42,7 @@ enum ivpu_bo_type {
 struct ivpu_bo_ops {
 	enum ivpu_bo_type type;
 	const char *name;
-	int (*alloc_pages)(struct ivpu_bo *bo);
+	int (*alloc_pages_op)(struct ivpu_bo *bo);
 	void (*free_pages)(struct ivpu_bo *bo);
 	int (*map_pages)(struct ivpu_bo *bo);
 	void (*unmap_pages)(struct ivpu_bo *bo);
-- 
2.42.0.758.gaed0368e0e-goog

