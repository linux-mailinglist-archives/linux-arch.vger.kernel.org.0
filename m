Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7173E0888
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbhHDTQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40372 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239208AbhHDTQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:18 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 80D99C0CDB;
        Wed,  4 Aug 2021 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104565; bh=OBVOhlFpb0ubl681yuxTSCalPDqOt+4DEullYEuvCBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1MyVDo9q04I9gOvz1Ddj9PEDHuZVyUgxx+ni1izear6AquuLnQNWT0ReF90V2znj
         zrUhLKZykQ5LpxmbtJDFmvaienRC7i/qR38g3ltNB0etdI4HI+YAhqt8IQflgjkmD1
         KipBITz9l1B6fj21Ltz83vt6qmbFGW1eWzE2Gn8RsLi5iftMtTVaDdQVBU8OUxkpet
         UJMD3OS7f+q4Qdy9BWbdbqVbjm1MD23LiMszSJ4RA7pjPYgrQM9tL8jGc3KOGvLMpZ
         58DPZzKrAzuEQ2KRVJqIrsygQ/uAf5CLPyg/ng9gUpD0tW7mBzkM7SrWE/AM/AddV1
         GZ1GHX/6zBfSw==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 15603A009F;
        Wed,  4 Aug 2021 19:16:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 04/11] ARC: atomic64: LLSC: elide unused atomic_{and,or,xor,andnot}_return
Date:   Wed,  4 Aug 2021 12:15:47 -0700
Message-Id: <20210804191554.1252776-5-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a non-functional change since those wrappers are not
used in kernel sources at all.

Link: http://lists.infradead.org/pipermail/linux-snps-arc/2018-August/004246.html
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic64-arcv2.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index 53996b11b551..22ef1cbb94e2 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -116,6 +116,12 @@ static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
 
 ATOMIC64_OPS(add, add.f, adc)
 ATOMIC64_OPS(sub, sub.f, sbc)
+
+#undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op, op1, op2)					\
+	ATOMIC64_OP(op, op1, op2)					\
+	ATOMIC64_FETCH_OP(op, op1, op2)
+
 ATOMIC64_OPS(and, and, and)
 ATOMIC64_OPS(andnot, bic, bic)
 ATOMIC64_OPS(or, or, or)
-- 
2.25.1

