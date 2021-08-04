Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C53E0884
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhHDTQS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40360 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239144AbhHDTQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:18 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3C9BDC0CDA;
        Wed,  4 Aug 2021 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104565; bh=dacA0IyBg8UWykD27vZX0Ft/c8RD5hhX4Qz9JOOUI+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KX9ThU4YuWR0esgHnjRSDyuAar4isX3UBVt3TkRVy3KmIizWW39C72b6tvKKh8xtZ
         k2r+ksBhraA/EFw3PaDlzzDVDZY1GMSFdWvjvqGTAmnFCW+A9Gb75pLhim+zOqhToE
         nOuIPCBKwMAwSiyFJwrkAvc+EcdRCrpnqcGYbjMMPtf5VgSdbDEA6qJXq/3VT8JU8X
         eIdTxtG0A5YgAlTylaJPhhGZvzWKy6dCOcZKwJc+/LHdebwXSrL34aIAn40RmIIzRV
         rNj3pEty+sfGDnGJywhUFMMWkpU6wIFDe7U6Olty0J31bw3NiNDhVrFja+GPvNjs7L
         bfrpR3zUn5MiQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id D0538A009C;
        Wed,  4 Aug 2021 19:16:04 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 03/11] ARC: atomic: !LLSC: use int data type consistently
Date:   Wed,  4 Aug 2021 12:15:46 -0700
Message-Id: <20210804191554.1252776-4-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804191554.1252776-1-vgupta@synopsys.com>
References: <20210804191554.1252776-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/atomic-spinlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/atomic-spinlock.h b/arch/arc/include/asm/atomic-spinlock.h
index 8c6fd0e651e5..2c830347bfb4 100644
--- a/arch/arc/include/asm/atomic-spinlock.h
+++ b/arch/arc/include/asm/atomic-spinlock.h
@@ -42,7 +42,7 @@ static inline void arch_atomic_##op(int i, atomic_t *v)			\
 static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
-	unsigned long temp;						\
+	unsigned int temp;						\
 									\
 	/*								\
 	 * spin lock/unlock provides the needed smp_mb() before/after	\
@@ -60,7 +60,7 @@ static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
-	unsigned long orig;						\
+	unsigned int orig;						\
 									\
 	/*								\
 	 * spin lock/unlock provides the needed smp_mb() before/after	\
-- 
2.25.1

