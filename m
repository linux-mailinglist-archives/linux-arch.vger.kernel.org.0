Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB75862BF
	for <lists+linux-arch@lfdr.de>; Mon,  1 Aug 2022 04:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbiHACmn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 22:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiHACmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 22:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82113D0E;
        Sun, 31 Jul 2022 19:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFA346123C;
        Mon,  1 Aug 2022 02:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B19C433B5;
        Mon,  1 Aug 2022 02:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321761;
        bh=aUkod9ap6lals+as1v1yhEx9/EywmGgaYtecOunYJFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kn+8Aa0tETYarA5fdBTcXyltNRjWoMCGGJ//yFNIEtIdOpiloybQLuL7STnP36M3T
         fRGxLjEgqlmTH0HJOEFGFVhc46mxJcrP2JHs6DA4aL4v3tOEmDJfU64ofUl/pSIJpE
         yc9WVSJ/zGTR19QuN4pg+Qnz6deqG9icYccdEJdxjRTkYfS6A9f6Z3qS9dm7nCcz/k
         Wxl5dZbtT0zGgtdWkiqT1S1pIQFwr7awb6v24yz67LhrpbOd9VfoFgjGewZJ/WyHIW
         PrhtdHKUdQXv/5xzNBdzgQS+QqmtH/Y7IkJBx0wnjcGaJmFH6e79hPPzn8kH+acpLZ
         qEAtQ1SOWHSaw==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/2] csky: cmpxchg: Coding convention for BUILD_BUG()
Date:   Sun, 31 Jul 2022 22:42:28 -0400
Message-Id: <20220801024229.567397-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220801024229.567397-1-guoren@kernel.org>
References: <20220801024229.567397-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Use BUILD_BUG() instead of the custom bad_xchg.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/cmpxchg.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 5f693fadb56c..916043b845f1 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -4,10 +4,9 @@
 #define __ASM_CSKY_CMPXCHG_H
 
 #ifdef CONFIG_SMP
+#include <linux/bug.h>
 #include <asm/barrier.h>
 
-extern void __bad_xchg(void);
-
 #define __xchg_relaxed(new, ptr, size)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
@@ -46,7 +45,7 @@ extern void __bad_xchg(void);
 			:);					\
 		break;						\
 	default:						\
-		__bad_xchg();					\
+		BUILD_BUG();					\
 	}							\
 	__ret;							\
 })
@@ -76,7 +75,7 @@ extern void __bad_xchg(void);
 			:);					\
 		break;						\
 	default:						\
-		__bad_xchg();					\
+		BUILD_BUG();					\
 	}							\
 	__ret;							\
 })
@@ -107,7 +106,7 @@ extern void __bad_xchg(void);
 			:);					\
 		break;						\
 	default:						\
-		__bad_xchg();					\
+		BUILD_BUG();					\
 	}							\
 	__ret;							\
 })
@@ -139,7 +138,7 @@ extern void __bad_xchg(void);
 			:);					\
 		break;						\
 	default:						\
-		__bad_xchg();					\
+		BUILD_BUG();					\
 	}							\
 	__ret;							\
 })
-- 
2.36.1

