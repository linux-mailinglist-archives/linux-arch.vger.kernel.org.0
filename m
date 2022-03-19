Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639CF4DE59B
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 04:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiCSD4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 23:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiCSD4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 23:56:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F123205C;
        Fri, 18 Mar 2022 20:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F0C0B825D5;
        Sat, 19 Mar 2022 03:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240B6C340F2;
        Sat, 19 Mar 2022 03:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647662119;
        bh=JDXWg1zwYrTJg3qBN3Fpv5jBQ9oDxemcN/lCbJ/1qRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2bzTd/C+ZXf8yaJXh9wIel+GNoB5VzxQHQ+lsT0C/jpzUh44QempyUKV27fC6yXi
         VCjc5MTcBX33EGZ43vNLa9n5tfw/m7jfW46JLF66+Jt5raFxr5DmeXuUNFErSvGV0v
         Te47lwtw6Dt9AkvFZYWmn07CzWaLxlE1lc7/O3YSfe51yID6iig2+CO7S2wR7lLaUs
         1a0SzAEwFd4Cl/sF9zczXXp3j3302vaJsUAwIA5X02E43rfEb5Bd4A93USQs5StFo4
         +KxpxBiWG4NV+6UEbOg0dZrEomY4sZER7KkzZ4XN5Snkc/L4T+jguAQkE8l3qsARBb
         NNOBN9XBNA2Lw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V2 2/5] asm-generic: qspinlock: Indicate the use of mixed-size atomics
Date:   Sat, 19 Mar 2022 11:54:54 +0800
Message-Id: <20220319035457.2214979-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220319035457.2214979-1-guoren@kernel.org>
References: <20220319035457.2214979-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The qspinlock implementation depends on having well behaved mixed-size
atomics.  This is true on the more widely-used platforms, but these
requirements are somewhat subtle and may not be satisfied by all the
platforms that qspinlock is used on.

Document these requirements, so ports that use qspinlock can more easily
determine if they meet these requirements.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/asm-generic/qspinlock.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index d74b13825501..a7a1296b0b4d 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -2,6 +2,36 @@
 /*
  * Queued spinlock
  *
+ * A 'generic' spinlock implementation that is based on MCS locks. An
+ * architecture that's looking for a 'generic' spinlock, please first consider
+ * ticket-lock.h and only come looking here when you've considered all the
+ * constraints below and can show your hardware does actually perform better
+ * with qspinlock.
+ *
+ *
+ * It relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no weaker
+ * than RCtso if you're power), where regular code only expects atomic_t to be
+ * RCpc.
+ *
+ * It relies on a far greater (compared to ticket-lock.h) set of atomic
+ * operations to behave well together, please audit them carefully to ensure
+ * they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced queued_fetch_set_pending_acquire().
+ *
+ * It also heavily relies on mixed size atomic operations, in specific it
+ * requires architectures to have xchg16; something which many LL/SC
+ * architectures need to implement as a 32bit and+or in order to satisfy the
+ * forward progress guarantees mentioned above.
+ *
+ * Further reading on mixed size atomics that might be relevant:
+ *
+ *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
+ *
+ *
  * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
  *
-- 
2.25.1

