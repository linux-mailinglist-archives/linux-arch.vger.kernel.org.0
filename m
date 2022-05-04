Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32B51A4B7
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 17:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352965AbiEDQAu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352962AbiEDQAs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 12:00:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9D4615A;
        Wed,  4 May 2022 08:57:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 641FE210E1;
        Wed,  4 May 2022 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651679827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nu4FNczpZovRCMLybZ5k5rdDCEUYi3yOv4DX+sivCNc=;
        b=YaaUVhSRP5GfOdY2LJNhrw0zcyHIdbiTMz0zj9Uc7X0cg8wRTltA+1tJX8+n+pE3HmN/96
        GCQ4MBEVKbCBpzNefZPdi8vvKmVmniACzN6LXAmRJGwENURN4ArHLM2iHP3MAqfwFoO41q
        WQJiMyj03IXIYJcUR850l7JEgifK4ZA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF262132C4;
        Wed,  4 May 2022 15:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GLt2KVKicmLWPAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 04 May 2022 15:57:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: [PATCH v3 1/2] kernel: add platform_has() infrastructure
Date:   Wed,  4 May 2022 17:57:02 +0200
Message-Id: <20220504155703.13336-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220504155703.13336-1-jgross@suse.com>
References: <20220504155703.13336-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple infrastructure for setting, resetting and querying
platform feature flags.

Flags can be either global or architecture specific.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- rename set/reset functions to platform_[set|clear]() (Boris Petkov,
  Heiko Carstens)
- move function implementations to c file (Boris Petkov)
---
 MAINTAINERS                            |  8 ++++++++
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/platform-feature.h |  8 ++++++++
 include/linux/platform-feature.h       | 15 ++++++++++++++
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/platform-feature.h
 create mode 100644 include/linux/platform-feature.h
 create mode 100644 kernel/platform-feature.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cdb85e8..2749a88d75f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15657,6 +15657,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
 F:	drivers/iio/chemical/pms7003.c
 
+PLATFORM FEATURE INFRASTRUCTURE
+M:	Juergen Gross <jgross@suse.com>
+S:	Maintained
+F:	arch/*/include/asm/platform-feature.h
+F:	include/asm-generic/platform-feature.h
+F:	include/linux/platform-feature.h
+F:	kernel/platform-feature.c
+
 PLDMFW LIBRARY
 M:	Jacob Keller <jacob.e.keller@intel.com>
 S:	Maintained
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 302506bbc2a4..8e47d483b524 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -44,6 +44,7 @@ mandatory-y += msi.h
 mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
+mandatory-y += platform-feature.h
 mandatory-y += preempt.h
 mandatory-y += rwonce.h
 mandatory-y += sections.h
diff --git a/include/asm-generic/platform-feature.h b/include/asm-generic/platform-feature.h
new file mode 100644
index 000000000000..4b0af3d51588
--- /dev/null
+++ b/include/asm-generic/platform-feature.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_PLATFORM_FEATURE_H
+#define _ASM_GENERIC_PLATFORM_FEATURE_H
+
+/* Number of arch specific feature flags. */
+#define PLATFORM_ARCH_FEAT_N	0
+
+#endif /* _ASM_GENERIC_PLATFORM_FEATURE_H */
diff --git a/include/linux/platform-feature.h b/include/linux/platform-feature.h
new file mode 100644
index 000000000000..6ed859928b97
--- /dev/null
+++ b/include/linux/platform-feature.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PLATFORM_FEATURE_H
+#define _PLATFORM_FEATURE_H
+
+#include <linux/bitops.h>
+#include <asm/platform-feature.h>
+
+/* The platform features are starting with the architecture specific ones. */
+#define PLATFORM_FEAT_N				(0 + PLATFORM_ARCH_FEAT_N)
+
+void platform_set(unsigned int feature);
+void platform_clear(unsigned int feature);
+bool platform_has(unsigned int feature);
+
+#endif /* _PLATFORM_FEATURE_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 847a82bfe0e3..2f412f80110d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    cpu.o exit.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o user.o \
 	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
-	    extable.o params.o \
+	    extable.o params.o platform-feature.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o
diff --git a/kernel/platform-feature.c b/kernel/platform-feature.c
new file mode 100644
index 000000000000..cb6a6c3e4fed
--- /dev/null
+++ b/kernel/platform-feature.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+#include <linux/cache.h>
+#include <linux/export.h>
+#include <linux/platform-feature.h>
+
+#define PLATFORM_FEAT_ARRAY_SZ  BITS_TO_LONGS(PLATFORM_FEAT_N)
+static unsigned long __read_mostly platform_features[PLATFORM_FEAT_ARRAY_SZ];
+
+void platform_set(unsigned int feature)
+{
+	set_bit(feature, platform_features);
+}
+EXPORT_SYMBOL_GPL(platform_set);
+
+void platform_clear(unsigned int feature)
+{
+	clear_bit(feature, platform_features);
+}
+EXPORT_SYMBOL_GPL(platform_clear);
+
+bool platform_has(unsigned int feature)
+{
+	return test_bit(feature, platform_features);
+}
+EXPORT_SYMBOL_GPL(platform_has);
-- 
2.35.3

