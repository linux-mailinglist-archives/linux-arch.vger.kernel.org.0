Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADC37B5E19
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 02:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbjJCAWG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbjJCAWG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 20:22:06 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806AAAB;
        Mon,  2 Oct 2023 17:22:03 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1dcfb21f9d9so218383fac.0;
        Mon, 02 Oct 2023 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292523; x=1696897323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPM4Tm+gRAF5HcZr/x/m1YRPeyyhsFwt3Uq8B84rUs0=;
        b=ehO8UiO8w2i2wuGVPPGtyh33fY1tjQX8INV2vKWS1nINVSa2K2oc/+RILv8PB6w3jY
         Z3sGxpVcADX6aUBKlkA4UgDbP7+baCKIKOM6VX+Iz3aeUOoCfU9TYFceZmEDcctRRA3M
         /aDbQExqFU/XTDEcXl3wD/WcxJsofGxf6LW1npgm+EI8JmpOjM/M5AaY7YtFfS17KGdF
         r2QZzsNSFPCbXWDdXNpLNmEYh4SiymLR/bAvg7r8yRiBpudWK5UjDeOvZGAmk4wsSvI5
         6xedDGC6XUY/efbDZa4a4iF4Z8qy1njxMzJOU5oEyfeQt6Hg8j4G6+mRU7tAP4ADm+dY
         Ps/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292523; x=1696897323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPM4Tm+gRAF5HcZr/x/m1YRPeyyhsFwt3Uq8B84rUs0=;
        b=vCs6lfvbyRM6H1H5pCvJUTCwh5ZhXlkGyOXfx/LCjVHKRshqMVcxLsBKLiPe1idDkv
         wDFGKdMmMuhXwdYUkt/2KSpEH6M5BbOrpSLDtAXEpMDoOE1uBsp8Z0FvRmg3j+KKiBAp
         BJRZkwBwhNHf5v35VSRTmMoR8eEsGE9y8Uy9unzCpludV3VO0azJzUsXR50vjqJ5lwLD
         +gANBuvOATouVWJka2kmJYCLSBcffuqjKjmInNTeMZu3J6Od+Pukrljuugdx91lMCOKX
         LXaVbFy6w6yJLniStFUar3cn26ycrXuWc2OK7Ojj9VIFmj6Loo89+KQKUHeAGhtiKje4
         c0pg==
X-Gm-Message-State: AOJu0YyvIQ7i03+sRgRovK35XrU+7dlFas2u9NEg1ISQtYqy6eeWntc3
        Ir/S2cu6owUbnZfced3CGGlq5oI54SVIfpM=
X-Google-Smtp-Source: AGHT+IGmh/sX3rnQH0khFcSXjot7fTRBE+PB1L5NwU2r4WZVwOD7IXwhw/MY3oSnIyASIsxwaojz7g==
X-Received: by 2002:a05:6870:1494:b0:1bb:8842:7b5c with SMTP id k20-20020a056870149400b001bb88427b5cmr15065347oab.43.1696292522792;
        Mon, 02 Oct 2023 17:22:02 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870618200b001e135f4f849sm24725oah.9.2023.10.02.17.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:22:02 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v2 1/4] mm/mempolicy: refactor do_set_mempolicy for code re-use
Date:   Mon,  2 Oct 2023 20:21:53 -0400
Message-Id: <20231003002156.740595-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231003002156.740595-1-gregory.price@memverge.com>
References: <20231003002156.740595-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Refactors do_set_mempolicy into swap_mempolicy and do_set_mempolicy
so that replace_mempolicy can be re-used with set_mempolicy2.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f1b00d6ac7ee..ad26f41b91de 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -854,28 +854,20 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return vma_replace_policy(vma, new_pol);
 }
 
-/* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+/* Attempt to replace mempolicy, release the old one if successful */
+static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 {
-	struct mempolicy *new, *old;
+	struct mempolicy *old = NULL;
 	NODEMASK_SCRATCH(scratch);
 	int ret;
 
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
 
@@ -883,14 +875,32 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
 		current->il_prev = MAX_NUMNODES-1;
+out:
 	task_unlock(current);
 	mpol_put(old);
-	ret = 0;
-out:
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
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	ret = replace_mempolicy(new, nodes);
+	if (ret)
+		mpol_put(new);
+
+	return ret;
+}
+
 /*
  * Return nodemask for policy for get_mempolicy() query
  *
-- 
2.39.1

