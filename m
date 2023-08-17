Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C278009F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355548AbjHQWCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355509AbjHQWCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 18:02:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 156B230F1;
        Thu, 17 Aug 2023 15:02:02 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42250211F928;
        Thu, 17 Aug 2023 15:02:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42250211F928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692309720;
        bh=VWQPdnoO2AKnlcVCBK2uWcpOSyiq2ea2s0AoxyvchiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7luczd2a2mcxfkBlPHQEVvd/0/nsxFjznSFmp6L/KvT4tc9IzoYLRF14yxckw/1Z
         l+0fBI3hKrheDNI2XJqYemtL1OOgfvQffTlsjg3jg+iOmCwm646rOFN70cx8k9wtvZ
         J7TUdSzTzvtoVlzxwr0uwwUQTSB+1eyMvbagUYGk=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v2 14/15] asm-generic: hyperv: Use mshv headers conditionally. Add asm-generic/hyperv-defs.h
Date:   Thu, 17 Aug 2023 15:01:50 -0700
Message-Id: <1692309711-5573-15-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add hyperv-defs.h to replace some inclusions of hyperv-tlfs.h.

It includes hyperv-tlfs.h or hvhdk.h depending on a compile-time constant
HV_HYPERV_DEFS which will be defined in the mshv driver.

This is needed to keep unstable Hyper-V interfaces independent of
hyperv-tlfs.h. This ensures hvhdk.h replaces hyperv-tlfs.h in the mshv driver,
even via indirect includes.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h |  2 +-
 arch/x86/include/asm/mshyperv.h   |  3 +--
 drivers/hv/hyperv_vmbus.h         |  1 -
 include/asm-generic/hyperv-defs.h | 26 ++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h    |  2 +-
 include/linux/hyperv.h            |  2 +-
 6 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 include/asm-generic/hyperv-defs.h

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 20070a847304..8ec14caf3d4f 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -20,7 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
-#include <asm/hyperv-tlfs.h>
+#include <asm-generic/hyperv-defs.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 79ffc7913016..c009e9c71445 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -6,10 +6,9 @@
 #include <linux/nmi.h>
 #include <linux/msi.h>
 #include <asm/io.h>
-#include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
-#include <asm/mshyperv.h>
+#include <asm-generic/hyperv-defs.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 85f3c08bb42b..49529f0b8b99 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -15,7 +15,6 @@
 #include <linux/list.h>
 #include <linux/bitops.h>
 #include <asm/sync_bitops.h>
-#include <asm/hyperv-tlfs.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
 #include <linux/interrupt.h>
diff --git a/include/asm-generic/hyperv-defs.h b/include/asm-generic/hyperv-defs.h
new file mode 100644
index 000000000000..ac6fcba35c8c
--- /dev/null
+++ b/include/asm-generic/hyperv-defs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_HYPERV_DEFS_H
+#define _ASM_GENERIC_HYPERV_DEFS_H
+
+/*
+ * There are cases where Microsoft Hypervisor ABIs are needed which may not be
+ * stable or present in the Hyper-V TLFS document. E.g. the mshv_root driver.
+ *
+ * As these interfaces are unstable and may differ from hyperv-tlfs.h, they
+ * must be kept separate and independent.
+ *
+ * However, code from files that depend on hyperv-tlfs.h (such as mshyperv.h)
+ * is still needed, so work around the issue by conditionally including the
+ * correct definitions.
+ *
+ * Note: Since they are independent of each other, there are many definitions
+ * duplicated in both hyperv-tlfs.h and uapi/hyperv/hv*.h files.
+ */
+#ifdef HV_HYPERV_DEFS
+#include <uapi/hyperv/hvhdk.h>
+#else
+#include <asm/hyperv-tlfs.h>
+#endif
+
+#endif /* _ASM_GENERIC_HYPERV_DEFS_H */
+
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 2b20994d809e..e86b6f51fb64 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -25,7 +25,7 @@
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
-#include <asm/hyperv-tlfs.h>
+#include <asm-generic/hyperv-defs.h>
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f90de5abcd50..66ed8b3e5d89 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -24,7 +24,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/reciprocal_div.h>
-#include <asm/hyperv-tlfs.h>
+#include <asm-generic/hyperv-defs.h>
 
 #define MAX_PAGE_BUFFER_COUNT				32
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
-- 
2.25.1

