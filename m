Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2803E088D
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhHDTQ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 15:16:26 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40454 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239416AbhHDTQT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 15:16:19 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5D084C0CDE;
        Wed,  4 Aug 2021 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628104566; bh=/wh7ABtjn6/Tkz5G7lWiGEgr5tXzrW9gN1lxc/ICBZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJaYUc8hlMAFJLFIfiKtUWwtNIviGHBUZbCaIuONUk03l7b5KjGkiqURVWaC6kf9S
         8wBsK03NlXPvbnRCUnNmjJexM1G/3CKruW9J+acNEX15zOeOwzwMllL178/NkCynu2
         uZkpzeT3D+h25kDACWq2RO6Eaq8FuD+v6FXvZM+NujSj5tAP6Oz8yAZGaI0NBySy07
         f92m94YM822V10ivN0f5KC7jP+n0WRxW9A7nGuG3VMr1xEH9sz7duXFX//0W63S6Xi
         Nd736JM2vYkLYoAd47U7TYxEYG0I0s6T/lnV98QIcvOEjRjW/x5BU1rJ+ENnkaUfkQ
         hua53fwqBPz1A==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 06691A0096;
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
Subject: [PATCH 07/11] ARC: bitops: fls/ffs to take int (vs long) per asm-generic defines
Date:   Wed,  4 Aug 2021 12:15:50 -0700
Message-Id: <20210804191554.1252776-8-vgupta@synopsys.com>
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
 arch/arc/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 4f35130f5ba3..a7daaf64ae34 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -114,7 +114,7 @@ static inline __attribute__ ((const)) unsigned long __ffs(unsigned long word)
  * @result: [1-32]
  * fls(1) = 1, fls(0x80000000) = 32, fls(0) = 0
  */
-static inline __attribute__ ((const)) int fls(unsigned long x)
+static inline __attribute__ ((const)) int fls(unsigned int x)
 {
 	int n;
 
@@ -141,7 +141,7 @@ static inline __attribute__ ((const)) int __fls(unsigned long x)
  * ffs = Find First Set in word (LSB to MSB)
  * @result: [1-32], 0 if all 0's
  */
-static inline __attribute__ ((const)) int ffs(unsigned long x)
+static inline __attribute__ ((const)) int ffs(unsigned int x)
 {
 	int n;
 
-- 
2.25.1

