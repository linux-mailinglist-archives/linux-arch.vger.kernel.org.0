Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1CD56CFB6
	for <lists+linux-arch@lfdr.de>; Sun, 10 Jul 2022 17:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiGJPVl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Jul 2022 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGJPVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Jul 2022 11:21:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A6DE9E;
        Sun, 10 Jul 2022 08:21:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id r6so98973plg.3;
        Sun, 10 Jul 2022 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVaXUpEXnFSePOO8ybge03AZi2rbsxwDM73MjsfciaA=;
        b=fjOx5BDu2Ebd4rD5ClRZmZKdSiH64xI+ffYK12U2eZ3Ho9NVhY5cUI4WGrMYopF/zE
         n7yOlrbwBD206k/nLmjhpEW7/Fb3HNYM15hJbhz2nCpIApJ34FAkvtrADJFRvKLjEMOX
         s6NI9pdvd+sE3/zXzwOwGq/OmmjVDW/IS1zOgru3Pq8ekvBoxzPFhDermDMWx2cshfN3
         NavwUBAm1axI9ZpKpNPE/GKO8LjxRVm6qPlRv/GOIN1YPiTozObjUQZay8rTh3n1XuiW
         4t2F0INqf0PZ4+5f5Ct1249duxQjPyFlxq0NP28w9sBBVOow+aozUJjbcL5huklbiJ9B
         A88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVaXUpEXnFSePOO8ybge03AZi2rbsxwDM73MjsfciaA=;
        b=7r0bag83p/uiBbezTnhdqH778CIAi7T76MZhk5i/7X8dfoopvp46AUDW/i4Kj9TzOP
         F3gK2CH5BHdOq+FTHV+q7+x66j7kvwtGsuNoeEE/n5GJ4VJTNJBXTQK4lKvY/kGPLRhs
         hUp4lzHxsnT/fGZuv4RE47SQslULufyibxCpgmLgBiuGRnM9xHcOgRFH0HF5oT4p1ttn
         99ohEWkbR0MlmZ3ws/ysuBMzUYnSTSwJ9EZMQ9q5VO/N47CEKiUDtt6tO/uWb7X2dQaf
         OQrsc6Y58P8FcyBwX3mgSqE7ycOmxHpR/HF9MTPfD55FIiQA+DNHtAWOiNJtiTfguB1q
         RE4g==
X-Gm-Message-State: AJIora9AMIXfDbG23suxP5lavYPFwaogAYQJRs81tZTuZiJ5HzleAGg+
        BdDicYcD4GBIko5S+h5IH3ibaS4vQmuA1Q==
X-Google-Smtp-Source: AGRyM1uDT4EZLLkG/lfBYLjkz+l0bIFgpzJg21wnjuCPAtAtF3Rw1V7fqt4/ExumSYrGYfiJomopQg==
X-Received: by 2002:a17:90b:388f:b0:1ed:3b:6c64 with SMTP id mu15-20020a17090b388f00b001ed003b6c64mr12367462pjb.34.1657466499621;
        Sun, 10 Jul 2022 08:21:39 -0700 (PDT)
Received: from eddie-laptop.localdomain (125-231-140-178.dynamic-ip.hinet.net. [125.231.140.178])
        by smtp.gmail.com with ESMTPSA id nk9-20020a17090b194900b001ef93f1dc6asm2917724pjb.50.2022.07.10.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 08:21:39 -0700 (PDT)
From:   Eddie Lin <eddielin0926@gmail.com>
To:     arnd@arndb.de
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, eddielin0926@gmail.com
Subject: [PATCH] sched: fix comment for sched_find_first_bit()
Date:   Sun, 10 Jul 2022 23:21:19 +0800
Message-Id: <20220710152119.3803-1-eddielin0926@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The result of __ffs is undefined if the word is zero. Therefore, it
should be guaranteed that at least one of the 100 bits is set.

Signed-off-by: Eddie Lin <eddielin0926@gmail.com>
---
 arch/alpha/include/asm/bitops.h    | 4 ++--
 include/asm-generic/bitops/sched.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index e1d8483a4..9af3528f5 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -434,8 +434,8 @@ static inline unsigned int __arch_hweight8(unsigned int w)
 
 /*
  * Every architecture must define this function. It's the fastest
- * way of searching a 100-bit bitmap.  It's guaranteed that at least
- * one of the 100 bits is cleared.
+ * way of searching a 100-bit bitmap. It's guaranteed that at least
+ * one of the 100 bits is set.
  */
 static inline unsigned long
 sched_find_first_bit(const unsigned long b[2])
diff --git a/include/asm-generic/bitops/sched.h b/include/asm-generic/bitops/sched.h
index 86470cfce..2b614eb40 100644
--- a/include/asm-generic/bitops/sched.h
+++ b/include/asm-generic/bitops/sched.h
@@ -7,8 +7,8 @@
 
 /*
  * Every architecture must define this function. It's the fastest
- * way of searching a 100-bit bitmap.  It's guaranteed that at least
- * one of the 100 bits is cleared.
+ * way of searching a 100-bit bitmap. It's guaranteed that at least
+ * one of the 100 bits is set.
  */
 static inline int sched_find_first_bit(const unsigned long *b)
 {
-- 
2.25.1

