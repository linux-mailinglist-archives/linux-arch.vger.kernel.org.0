Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23373E088E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhHDTQ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58778 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240502AbhHDTQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:21 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 07BA940DB9;
        Wed,  4 Aug 2021 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104567; bh=jWJMgYot8ioyaXe2+NdNR9EqQrXjSWR6QdetbVU+E2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ap9uR9CKAUC4E+TOAIdABbceBx7F2yyLajbac4DWSdOQo2qtnU3nr7IcCT52roO1F
         blNSY1Pj5xdMx3Gv7Jdco/HCt8HH1dlLLyBdeone7J5g3wQXoG4dXVlZsPSRbD8uu2
         MFaFm79kMKlIz6/OAyM2HhkScaxGdee9rq+v2Vgw0GpA9O7n8PUucdkQJsQI05z5Ne
         V3B5VWRqqPuQaoTLn98CC6tjEkosbNdWmH+2TEal64xRZ1kOkb/efhuQwz37PLFc+q
         esccLOixOvW+xKSsEzs2WBNLUK+XejkNghXxC/bci3tKtfffvZvZNI+HxwzpspQmOU
         PQtTCT/wjh9fg==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id B20B6A009B;
        Wed,  4 Aug 2021 19:16:06 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 10/11] ARC: cmpxchg/xchg: implement relaxed variants (LLSC config only)
Date:   Wed,  4 Aug 2021 12:15:53 -0700
Message-Id: <20210804191554.1252776-11-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It only makes sense to do this for the LLSC config

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/cmpxchg.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 00deb076d6f6..e2ae0eb1ca07 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -38,7 +38,7 @@
 	_prev;								\
 })
 
-#define arch_cmpxchg(ptr, old, new)				        \
+#define arch_cmpxchg_relaxed(ptr, old, new)				\
 ({									\
 	__typeof__(ptr) _p_ = (ptr);					\
 	__typeof__(*(ptr)) _o_ = (old);					\
@@ -47,12 +47,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 4:								\
-	        /*							\
-		 * Explicit full memory barrier needed before/after	\
-	         */							\
-		smp_mb();						\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
-		smp_mb();						\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -108,16 +103,14 @@
 	_val_;		/* get old value */				\
 })
 
-#define arch_xchg(ptr, val)						\
+#define arch_xchg_relaxed(ptr, val)					\
 ({									\
 	__typeof__(ptr) _p_ = (ptr);					\
 	__typeof__(*(ptr)) _val_ = (val);				\
 									\
 	switch(sizeof(*(_p_))) {					\
 	case 4:								\
-		smp_mb();						\
 		_val_ = __xchg(_p_, _val_);				\
-	        smp_mb();						\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.25.1

