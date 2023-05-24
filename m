Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C563E70FB03
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjEXP7B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbjEXP62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 11:58:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FB6E7F;
        Wed, 24 May 2023 08:57:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRG5m3Sfqz4wj7;
        Thu, 25 May 2023 01:57:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684943820;
        bh=qwsZV+PJ3cb3Udy+/4CR3STWLoi8PlYV5C8cGtG8aK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJuoWLcdzkR8HnaGpngf5T4KtnCDJHSDZUYmwKw3pPxMTPIJ0xX7+0v5GR54wH+kT
         cuGSHMg0dx13uCyFD3IBLTK3e6SDAvv0mqCg1Hmf9CSz9Z4hnw9l0sW3l1hkXjoXMq
         r7jtYBZvjoCjlR35GmMLhH0iMd1Xorj0G46RkgASgGqRKgTAN80OsyhNaaXO8loUB0
         FZ/4RhTQAJFdkAGi3T7fyarIQk20iuDMfCXAsjJSh/vzvslkN40aRZXaH08pfS8xD/
         tY+3SiUJMnpRPAvVboalycZAvtCcz7rbuLSJEyc33AJaAHdGbwWm+JxUrX3A7ZU13F
         Q4VfivmwPfBHw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linux-kernel@vger.kernel.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-arch@vger.kernel.org>,
        <ldufour@linux.ibm.com>, <tglx@linutronix.de>, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, x86@kernel.org
Subject: [PATCH 4/9] cpu/SMT: Create topology_smt_threads_supported()
Date:   Thu, 25 May 2023 01:56:25 +1000
Message-Id: <20230524155630.794584-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155630.794584-1-mpe@ellerman.id.au>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A subsequent patch will enable partial SMT states, ie. when not all SMT
threads are brought online.

To support that, add an arch helper to check how many SMT threads are
supported.

To retain existing behaviour, the x86 implementation only allows a
single thread or all threads to be online.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/smpboot.c       | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 66927a59e822..197ec2589f5d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -144,6 +144,7 @@ int topology_phys_to_logical_pkg(unsigned int pkg);
 int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
 bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
+bool topology_smt_threads_supported(unsigned int threads);
 #else
 #define topology_max_packages()			(1)
 static inline int
@@ -157,6 +158,7 @@ static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
+static inline bool topology_smt_threads_supported(unsigned int threads) { return false; }
 #endif
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..c7ba62beae3e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -286,6 +286,18 @@ bool topology_smt_supported(void)
 	return smp_num_siblings > 1;
 }
 
+/**
+ * topology_smt_threads_supported - Check if the given number of SMT threads
+ *				    is supported.
+ *
+ * @threads:	The number of SMT threads.
+ */
+bool topology_smt_threads_supported(unsigned int threads)
+{
+	// Only support a single thread or all threads.
+	return threads == 1 || threads == smp_num_siblings;
+}
+
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  *
-- 
2.40.1

