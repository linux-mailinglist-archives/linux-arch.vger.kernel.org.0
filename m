Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FBA3E1C3B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbhHETOc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 15:14:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53912 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242383AbhHETOc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 15:14:32 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D1DB6463B9;
        Thu,  5 Aug 2021 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628190857; bh=FIJHlm9Oeck01oRbTOwcXlwmWsrlbmTLxX4fL7vtOCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1Yf2opcY13IMkJZskMdfodkmnSDmgbc5mnOxZlET7IJwgbCplACG8NEsL5+CXrZz
         cMzw/zLsItWOWiC7RKePUWusvGfLyCHL0HSSMElPc/EOw9jMJbq2ZFPhDLUxNF8OuY
         ASEiiJEhBvLed01eZR9RCsI0BuhPOGbFGlSJVUgBFzfpiiBVCV95qAgOKx8vcT8YYs
         j0tfPjBF3ofSw3RQbLKP6iIzQ/UY+8ISLkqk51qS2PNy0vuCg2GY4d9CNybhTOs83e
         NS8FHTudKYKB15in7atPzURYab5zhVUK7AfJ4cFDHBD9r0VG1QVxgfRdw2K+3+GYiH
         rgvvX4wHIe+XQ==
Received: from vineetg-Latitude-7400.internal.synopsys.com (snps-fugpbdpduq.internal.synopsys.com [10.202.17.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 9A53DA029E;
        Thu,  5 Aug 2021 19:14:14 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC] bitops/non-atomic: make @nr unsigned to avoid any DIV
Date:   Thu,  5 Aug 2021 12:14:08 -0700
Message-Id: <20210805191408.2003237-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
References: <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

signed math causes generation of costlier instructions such as DIV when
they could be done by barrerl shifter.

Worse part is this is not caught by things like bloat-o-meter since
instruction length / symbols are typically same size.

e.g.

stock (signed math)
__________________

919b4614 <test_taint>:
919b4614:	div	r2,r0,0x20
                ^^^
919b4618:	add2	r2,0x920f6050,r2
919b4620:	ld_s	r2,[r2,0]
919b4622:	lsr	r0,r2,r0
919b4626:	j_s.d	[blink]
919b4628:	bmsk_s	r0,r0,0
919b462a:	nop_s

(patched) unsigned math
__________________

919b4614 <test_taint>:
919b4614:	lsr	r2,r0,0x5  @nr/32
                ^^^
919b4618:	add2	r2,0x920f6050,r2
919b4620:	ld_s	r2,[r2,0]
919b4622:	lsr	r0,r2,r0     #test_bit()
919b4626:	j_s.d	[blink]
919b4628:	bmsk_s	r0,r0,0
919b462a:	nop_s

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
This is an RFC for feeback, I understand this impacts every arch,
but as of now it is only buld/run tested on ARC.
---
---
 include/asm-generic/bitops/non-atomic.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bitops/non-atomic.h
index 7e10c4b50c5d..c5a7d8eb9c2b 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -13,7 +13,7 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __set_bit(int nr, volatile unsigned long *addr)
+static inline void __set_bit(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -21,7 +21,7 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
 	*p  |= mask;
 }
 
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
+static inline void __clear_bit(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -38,7 +38,7 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile unsigned long *addr)
+static inline void __change_bit(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -55,7 +55,7 @@ static inline void __change_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static inline int __test_and_set_bit(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -74,7 +74,7 @@ static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static inline int __test_and_clear_bit(unsigned int nr, volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
@@ -85,7 +85,7 @@ static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
 }
 
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr,
+static inline int __test_and_change_bit(unsigned int nr,
 					    volatile unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
@@ -101,7 +101,7 @@ static inline int __test_and_change_bit(int nr,
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
+static inline int test_bit(unsigned int nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
-- 
2.25.1

