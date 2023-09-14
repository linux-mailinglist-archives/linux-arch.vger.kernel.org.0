Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5F7A120B
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 01:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjINXzN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 19:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINXzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 19:55:08 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96A2100;
        Thu, 14 Sep 2023 16:55:03 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-59c04237bf2so8123327b3.0;
        Thu, 14 Sep 2023 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694735702; x=1695340502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CXhZiy70HyA4bPWCMkNn/kRD9ZJaqJTlM4EhRmptbc=;
        b=LOe/LikXW19ukL9ZXHXFbPkuiIUQZ8FKFi0Y/oISyKKsCJQKmACyL/xUuugaAjkBM+
         xM9kvI4LcYVf0rqvKrP4UNx0HcrpJMkZscSqSANXYLg3QTREPaqW2ICBFiFNmOkEnuyY
         /Louur2AJNyWnISnfyj0gJKOMUkc9wSCinQXqrcsoX9KnAslNsPVddgB4qoR8MqGnCI9
         mkQmDp2WEh47xbuauk7mQTSTj3Lm5ntRmlflWqaQSESqobF/PXom8t31aSe5tzm8awbL
         SopoEwqeNQJta6nVt9kkb4iB9AWyMP6LKVUdDWD11sCJjNkXZykwq1t8okmlVQ58+Uky
         O74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735702; x=1695340502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CXhZiy70HyA4bPWCMkNn/kRD9ZJaqJTlM4EhRmptbc=;
        b=TjbEMy/exk2I1MQBc3sFVwl5zKbVk69BhnNaga6etHydtXCeZ9KvumBRJXSaGY+eSg
         Z/VYRXUoU5lM7W0Q1btBF3Y+BtDUOFTLz8wasBYNkM02NOsDF7LwuKMaPIrEne5ZNyzt
         vw0/u+/cjyJFknVpaGUO+4jYaOXVIODIzL3E+LsRTvU7KBHG4XuC1Qehbj1SCdg0Pc+u
         XwgFRpdn1qNjd9sFH7AF5P74ZnhRBT3NLKc+5iK3NgY27kJb37HxzKbk2hlD+Qvh8368
         VDjDBKc26GccpCOhtqUeo9XShM9RrrQ+Io7KAEJfiQK8i748Kquwxj1iskfjHgyO0GFf
         6FIA==
X-Gm-Message-State: AOJu0Yw8h9ST9NMC56ckwCA03TJpLBUYxdvsM44q3Xasnr1CLgrFhYPS
        QRTRRHz5KH2qv2GH2JrsxYnlODnVYPuO
X-Google-Smtp-Source: AGHT+IEIWgJo0wJUTRcKR1PaJ0aESG57ai7kYcYG/JadNf7S+HXehkIlwnLEjBR0vRwghPm3obHLZg==
X-Received: by 2002:a0d:c385:0:b0:595:5609:cb78 with SMTP id f127-20020a0dc385000000b005955609cb78mr170870ywd.33.1694735702642;
        Thu, 14 Sep 2023 16:55:02 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p188-20020a0dcdc5000000b005777a2c356asm586300ywd.65.2023.09.14.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 16:55:02 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 1/3] mm/mempolicy: refactor do_set_mempolicy for code re-use
Date:   Thu, 14 Sep 2023 19:54:55 -0400
Message-Id: <20230914235457.482710-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914235457.482710-1-gregory.price@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Refactors do_set_mempolicy into swap_mempolicy and do_set_mempolicy
so that swap_mempolicy can be re-used with set_mempolicy2.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..f49337f6f300 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -855,28 +855,21 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return vma_replace_policy(vma, new_pol);
 }
 
-/* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+/* Swap in a new mempolicy, release the old one if successful */
+static long swap_mempolicy(struct mempolicy *new,
+			   nodemask_t *nodes)
 {
-	struct mempolicy *new, *old;
-	NODEMASK_SCRATCH(scratch);
+	struct mempolicy *old = NULL;
 	int ret;
+	NODEMASK_SCRATCH(scratch);
 
 	if (!scratch)
 		return -ENOMEM;
 
-	new = mpol_new(mode, flags, nodes);
-	if (IS_ERR(new)) {
-		ret = PTR_ERR(new);
-		goto out;
-	}
-
 	task_lock(current);
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		task_unlock(current);
-		mpol_put(new);
 		goto out;
 	}
 
@@ -884,14 +877,35 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
 		current->il_prev = MAX_NUMNODES-1;
-	task_unlock(current);
-	mpol_put(old);
-	ret = 0;
 out:
+	task_unlock(current);
+	if (old)
+		mpol_put(old);
+
 	NODEMASK_SCRATCH_FREE(scratch);
 	return ret;
 }
 
+/* Set the process memory policy */
+static long do_set_mempolicy(unsigned short mode, unsigned short flags,
+			     nodemask_t *nodes)
+{
+	struct mempolicy *new;
+	int ret;
+
+	new = mpol_new(mode, flags, nodes);
+	if (IS_ERR(new)) {
+		ret = PTR_ERR(new);
+		goto out;
+	}
+
+	ret = swap_mempolicy(new, nodes);
+	if (ret)
+		mpol_put(new);
+out:
+	return ret;
+}
+
 /*
  * Return nodemask for policy for get_mempolicy() query
  *
-- 
2.39.1

