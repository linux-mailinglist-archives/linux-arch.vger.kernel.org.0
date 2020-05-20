Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405061DB00B
	for <lists+linux-arch@lfdr.de>; Wed, 20 May 2020 12:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETKXR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 May 2020 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETKXQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 May 2020 06:23:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7DC061A0E
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2020 03:23:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so1319650pfn.11
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2020 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UeYH74heESnZiF/0WzARTRhBvqO0sJy8NsvoDg+3AZM=;
        b=XdM9DQOn//mg3VQ0zAw38oISQd7fr//RuX43QN4SmO2dfzhOasKxTnH2B2efhWow8x
         J9MSBlmVlxtz5ZYvH7tY99SRB9k7nMv0Kgr17lZN0hUXrPMlp8VgYspi5PvY2fhrPlMA
         EYiqN4vjb9L0Kzg5FIjLrg7qvtsIN7AOuDSRtdtxYMHuuAaEVOKBJO53LIgfAT3A2r6P
         GZxq9ddGt5X5Z8pTyPj4Dq9alUYYuc39/vpXcYmYfSS2xPC6VpTsA6PrmyQy00Q8DZvM
         bzZmUm7vnI3AV7C83PAgubZ5wdzLNt3E0GjZTR07Q241ySijf4AMOdqUst2+pbFcs+US
         MWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UeYH74heESnZiF/0WzARTRhBvqO0sJy8NsvoDg+3AZM=;
        b=qfLRERuqU6va/eTfv/MLcxxrDrYsxySqv0XoUABi3l0fnaNPBD5tFpMIjhceIgunDs
         Nqy99kZx3unihR3WutzJv+FJI94Y2x2RJwGsYsqlHhUonUIt2T3IdsXKv6DsdqsRwaqc
         0v/qE55wa9UG7oDSNAu84lxqO+s/kBeR+ydxnlTrDi0sNsY83Y1Q+b/K6HSWpuTJas6Y
         CBkKnPw/cYtFnuXNoQWwEIiSdxNP4rvbS5LtbkLtBbH0d0+ikduCVHKQaQucIP0LUJiK
         jimiSmE9D2t948pDDxnWWHIEWI1vIISvffd4LH3r7vowUFZ0OucegBRIJhI7O348zo/4
         g4yA==
X-Gm-Message-State: AOAM530vOoxWn4t+BhQpSlgPLY1J/WBjccuF6kWPpYgHuSlfQaNDQSuC
        CS9sNGV0i0uqtVDlseA3mBCpcA==
X-Google-Smtp-Source: ABdhPJw71J+/ZknkAY+XoPTM8ROD5fgMhPUYFR8W496/dKeyZt6keGJDKmK529dWGTs7LpQ0zvYC/Q==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr3536425pgb.252.1589970195997;
        Wed, 20 May 2020 03:23:15 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id l1sm1611630pgj.48.2020.05.20.03.23.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 03:23:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic/sembuf: Update architecture related information in comment
Date:   Wed, 20 May 2020 15:53:08 +0530
Message-Id: <64efe033394b6f0dfef043a63fd8897a81ba6d16.1589970173.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The structure came originally from x86_32 but is used by most of the
architectures now. Update the comment which says it is for x86 only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/asm-generic/sembuf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 0e709bd3d730..f54e48fc91ae 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -6,9 +6,9 @@
 #include <asm/ipcbuf.h>
 
 /*
- * The semid64_ds structure for x86 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
+ * The semid64_ds structure for most architectures (though it came from x86_32
+ * originally). Note extra padding because this structure is passed back and
+ * forth between kernel and user space.
  *
  * semid64_ds was originally meant to be architecture specific, but
  * everyone just ended up making identical copies without specific
-- 
2.25.0.rc1.19.g042ed3e048af

