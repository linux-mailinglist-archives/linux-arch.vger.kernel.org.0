Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B3736F31
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFTOwR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjFTOwR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 10:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D671733
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687272687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iujXwuftdxXImWSWSI9VizTXy4E1fvuK20wksczwI/k=;
        b=iLZstAJrrnz8zZ+K4hUWA5A7sOvAkgN6dDPENCDwN6ygWihUl7g0DK4FlSkNTLIJ1GJ5iu
        nnFW/FbHIyrMyTbiritPc3nutuXiPL7t8PuQL3vVnI2cB3QQU37wS7H60fSMGYc3y1ahTP
        kOk30GrDLiKCzPY/5IxVpV/6RBzr9gE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-x-AozXEzMu217ZwsSukKWg-1; Tue, 20 Jun 2023 10:51:23 -0400
X-MC-Unique: x-AozXEzMu217ZwsSukKWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71CC488D51C;
        Tue, 20 Jun 2023 14:46:42 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.195.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 905379E9C;
        Tue, 20 Jun 2023 14:46:34 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     mtosatti@redhat.com, ppandit@redhat.com, david@redhat.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, paulmck@kernel.org,
        frederic@kernel.org, will@kernel.org, peterz@infradead.org,
        ardb@kernel.org, samitolvanen@google.com,
        juerg.haefliger@canonical.com, arnd@arndb.de,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ypodemsk@redhat.com
Subject: [PATCH v2 1/2] arch: Introduce ARCH_HAS_CPUMASK_BITS
Date:   Tue, 20 Jun 2023 17:46:17 +0300
Message-Id: <20230620144618.125703-2-ypodemsk@redhat.com>
In-Reply-To: <20230620144618.125703-1-ypodemsk@redhat.com>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some architectures set and maintain the mm_cpumask bits when loading
or removing process from cpu.
This Kconfig will mark those to allow different behavior between
kernels that maintain the mm_cpumask and those that do not.

Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
---
 arch/Kconfig         | 8 ++++++++
 arch/arm/Kconfig     | 1 +
 arch/powerpc/Kconfig | 1 +
 arch/s390/Kconfig    | 1 +
 arch/sparc/Kconfig   | 1 +
 arch/x86/Kconfig     | 1 +
 6 files changed, 13 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..953fbfa5a2ad 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1466,6 +1466,14 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
 	  address translations. Page table walkers that clear the accessed bit
 	  may use this capability to reduce their search space.
 
+config ARCH_HAS_CPUMASK_BITS
+	bool
+	help
+	  Architectures that select this option set bits on the mm_cpumask
+	  to mark which cpus loaded the mm, The mask can then be used to
+	  control mm specific actions such as tlb_flush.
+
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0fb4b218f665..cd20e96bc1dc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -70,6 +70,7 @@ config ARM
 	select GENERIC_SMP_IDLE_THREAD
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
+	select ARCH_HAS_CPUMASK_BITS
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index bff5820b7cda..c9218722aa2f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -156,6 +156,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_CPUMASK_BITS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 6dab9c1be508..60bf29bc3f87 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -84,6 +84,7 @@ config S390
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_CPUMASK_BITS
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8535e19062f6..e8bf4d769306 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -99,6 +99,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_CPUMASK_BITS
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..b351421695f3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -185,6 +185,7 @@ config X86
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
+	select ARCH_HAS_CPUMASK_BITS
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_USERFAULTFD_WP         if X86_64 && USERFAULTFD
-- 
2.39.3

