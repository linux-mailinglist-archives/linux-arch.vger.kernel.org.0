Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F71254352
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgH0KPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgH0KPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:15:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A005C061233;
        Thu, 27 Aug 2020 03:15:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so2350466pjb.2;
        Thu, 27 Aug 2020 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gsuwAWlE4Ohz54mRMi0rZJXgpp5AgeOB9KKtUdDvTLA=;
        b=dbXRHC4ze7LeL+Cm4RIJhQ1FUd9tZOr4Mx1+oJuWIi2k7Nc9pMDcl3+UHKS/d/iDrx
         mjxxtfFiG0xhdHA3M1Ps2hxGI94RDGVMmXrpphEQjESkog1VkHr3hPXJaZDkiuV1YDUL
         oplqZnWPD9yCd1Bq8c5gDrI8A/Nn95HBJDegWQA9VnoGyNvXoIUTC/Xl5BNnN6K0uaLO
         4C8+E4MTe89kNhc71/GMo50SxJhJb9KUROTOkw7jib9Wf3+oBU/ipEZhINwXMid8yet1
         K/R0CvwWopZ2LJrbY9uc85dgU0sl9sctd3OjnuUsSLutlWX5B9CRkKdUj5Udqroodmna
         H/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=gsuwAWlE4Ohz54mRMi0rZJXgpp5AgeOB9KKtUdDvTLA=;
        b=I3Jjn7Du9oej/sx8ha6W6h3dw2sK9kokz1bSPO2MWJI+5qdorJXJBi/h+OmUfi/bIm
         ZSUnlC3xOTyxLN1nmLAaTrf4+32NmYO2HhKmfTXGOR9vwWfYDxtoA2KbzJm2wPNYH0dk
         3BfDD4028twKa7KJdDY6TuLS1Qu7CJ+nF6vqwj0IUGb0fja/EdCqK+Nl52NkXQJjJ8RD
         ANiEQ4twLIw7DuuJaIW/EXy4TKrm2QVOAiNq1ahYX8QOILHyMmoFBPPzsHHlaYH/0GCx
         AEntmJLccFKMMNoBP64OsukDTU9beW6rE89qA6YZUT1y80LeSS2R/On5sUqkrKxMVDdT
         IMPA==
X-Gm-Message-State: AOAM533LAuZNZh8pyGSRpJphliMAoiZnYde13YLTwJ63AZa4wynBF2if
        Q6DLhidYiu4fC4xhKxyFrBE=
X-Google-Smtp-Source: ABdhPJyiQ5d5yPzC+ariiDTv9QSPiaZpVVYwS6m+U0ir5dr4RLEGld3Njghw2PavCkmzymZiCHPeuQ==
X-Received: by 2002:a17:90b:40cb:: with SMTP id hj11mr10477339pjb.67.1598523300941;
        Thu, 27 Aug 2020 03:15:00 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:15:00 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/23] ext4: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:26 +0800
Message-Id: <fbfe941021207ab2688ed045dc570e902b8d6a35.1598518912.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since ASSERT_FAIL() and ASSERT_WARN() have been provided, ASSERT()
may be realized through them, thus reducing code redundancy and
facilitating problem analysis.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e..99976e6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -591,15 +591,7 @@ static inline void mb_group_bb_bitmap_free(struct ext4_group_info *grp)
 
 #ifdef AGGRESSIVE_CHECK
 
-#define MB_CHECK_ASSERT(assert)						\
-do {									\
-	if (!(assert)) {						\
-		printk(KERN_EMERG					\
-			"Assertion failure in %s() at %s:%d: \"%s\"\n",	\
-			function, file, line, # assert);		\
-		BUG();							\
-	}								\
-} while (0)
+#define MB_CHECK_ASSERT(assert) ASSERT_FAIL(assert)
 
 static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 				const char *function, int line)
-- 
1.8.3.1

