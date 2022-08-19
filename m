Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA44F59A4BE
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354502AbiHSRq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354973AbiHSRpz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 13:45:55 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6216109759;
        Fri, 19 Aug 2022 10:10:44 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 45A3C4C1D4C;
        Fri, 19 Aug 2022 17:10:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 50A274C25EC;
        Fri, 19 Aug 2022 17:10:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660929034; a=rsa-sha256;
        cv=none;
        b=5cKO38w6HOtms0u9sQ3GepT4FM8gwF4I0LbfMs7RKCu3OuMusk7Uc3t8j0FEYniv6pFkXr
        7HSOfE9O5gsHyFuNIxxozJYFa4tcCY72Sg7QSJuxqrsL1vS+drxzsKRWRzMf0xXpsvMm+N
        J7YMYII+pGFI0EAAr8u0p/32bYsDRPSH47jpC3JuvyJOPyh/TLNEUU3EagVHPMzk6cNRzP
        ZWAozXtHnjHSUoxrVTbTFPMh5kQsYH3b6Tma/JNL3qNLaCdYfLkhz84Xbv/cXUIJl/hAlF
        Z/d2GlEg4JdxIrmg4JC9/zPSKl/5zgER42zneWoEoZhi6rEChrH4okhAK8uopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660929034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=WAH2Q04qOOZviyzR8Bbm7cthfCCUJ+xnXbB07gw5SSk=;
        b=ZoINtC4u5TA72FcggARe2fDeATKzoUQxzfw5aHtodIHyz0LQwD2+B+ZhwaI/7FpPeGpxTz
        gjOP+OmOxAvhS6RQArnqoyZhZvVpXtA7mvdiyeg0vqRBfUv3d8v8OZEjCf6GZjItsipOrj
        s5Ry6dHP97cJy6FV/xgQs9zjFGG2K0vSdjMmWK7ujLMhED6IRmP7M9SFWpM0pD7g8VZUEn
        CcdvJVZAm7wqMADxaEmz38wm9RX2+RIjURVoSUm2xVxnOI3csMC3eyCrmEl/ciz9owsSBA
        VlowFAMhEl2jnhFucruQqtAVzwPgXK1bZZqSiIikCG5Qc5T6skhAsVi9H+agJg==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-mwkdm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Chemical: 0736d13c36e1a4a8_1660929035054_241875966
X-MC-Loop-Signature: 1660929035054:962906012
X-MC-Ingress-Time: 1660929035054
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.195 (trex/6.7.1);
        Fri, 19 Aug 2022 17:10:35 +0000
Received: from offworld.. (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4M8Stw3PRHz33;
        Fri, 19 Aug 2022 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1660929033;
        bh=WAH2Q04qOOZviyzR8Bbm7cthfCCUJ+xnXbB07gw5SSk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=H2h3CfoxDs72tJyVbuC3+AuYHpXZSMGR3+CtYgVshT7Dyg/tQTNlTUX5W8/j3y+/0
         oLeuWhBADjU9GVaJY0lB8/isl3M0MW04ighymDUsMsnqIfi/P5fnT+XSMXYD0zaMMb
         zBWq/CAucu6GonWGiqxv6pUDqdOyGhmG8tBnS7Roi1qBg8EpVI7p2IgvzVSP97+WR9
         lyjBHLtmUn5sDawDBwNFeMl4KHETGG7sUPSiTNMOf8WL6qvFu/xPZqnt2iVxoSdEKE
         +9cRclOPvXUcAnla+INmBFLYzI9D1GG2k3Q7nqWou25V2TZNIUwmzMiV9eKMng3G+r
         BqyhY/DNrw/0Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-arch@vger.kernel.org
Cc:     dan.j.williams@intel.com, peterz@infradead.org,
        mark.rutland@arm.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        ira.weiny@intel.com, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH v2] arch/cacheflush: Introduce flush_all_caches()
Date:   Fri, 19 Aug 2022 10:10:24 -0700
Message-Id: <20220819171024.1766857-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CXL security features, global CPU cache flushing nvdimm requirements
are no longer specific to that subsystem, even beyond the scope of
security_ops. CXL will need such semantics for features not necessarily
limited to persistent memory.

The functionality this is enabling is to be able to instantaneously
secure erase potentially terabytes of memory at once and the kernel
needs to be sure that none of the data from before the secure is still
present in the cache. It is also used when unlocking a memory device
where speculative reads and firmware accesses could have cached poison
from before the device was unlocked.

This capability is typically only used once per-boot (for unlock), or
once per bare metal provisioning event (secure erase), like when handing
off the system to another tenant or decomissioning a device. That small
scope plus the fact that none of this is available to a VM limits the
potential damage.

While the scope of this is for physical address space, add a new
flush_all_caches() in cacheflush headers such that each architecture
can define it, when capable. For x86 just use the wbinvd hammer and
prevent any other arch from being capable.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

Changes from v1 (https://lore.kernel.org/all/20220815160706.tqd42dv24tgb7x7y@offworld/):
- Added comments and improved changelog to reflect this is
  routine should be avoided and not considered a general API (Peter, Dan).

 arch/x86/include/asm/cacheflush.h |  4 +++
 drivers/acpi/nfit/intel.c         | 41 ++++++++++++++-----------------
 include/asm-generic/cacheflush.h  | 31 +++++++++++++++++++++++
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index b192d917a6d0..ac4d4fd4e508 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -10,4 +10,8 @@
 
 void clflush_cache_range(void *addr, unsigned int size);
 
+/* see comments in the stub version */
+#define flush_all_caches() \
+	do { wbinvd_on_all_cpus(); } while(0)
+
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 8dd792a55730..f2f6c31e6ab7 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -4,6 +4,7 @@
 #include <linux/ndctl.h>
 #include <linux/acpi.h>
 #include <asm/smp.h>
+#include <linux/cacheflush.h>
 #include "intel.h"
 #include "nfit.h"
 
@@ -190,8 +191,6 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	}
 }
 
-static void nvdimm_invalidate_cache(void);
-
 static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
@@ -210,6 +209,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 	};
 	int rc;
 
+	if (!flush_all_caches_capable())
+		return -EINVAL;
+
 	if (!test_bit(NVDIMM_INTEL_UNLOCK_UNIT, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
@@ -228,7 +230,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 	}
 
 	/* DIMM unlocked, invalidate all CPU caches before we read it */
-	nvdimm_invalidate_cache();
+	flush_all_caches();
 
 	return 0;
 }
@@ -294,11 +296,14 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 		},
 	};
 
+	if (!flush_all_caches_capable())
+		return -EINVAL;
+
 	if (!test_bit(cmd, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
 	/* flush all cache before we erase DIMM */
-	nvdimm_invalidate_cache();
+	flush_all_caches();
 	memcpy(nd_cmd.cmd.passphrase, key->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -318,7 +323,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	}
 
 	/* DIMM erased, invalidate all CPU caches before we read it */
-	nvdimm_invalidate_cache();
+	flush_all_caches();
 	return 0;
 }
 
@@ -338,6 +343,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 		},
 	};
 
+	if (!flush_all_caches_capable())
+		return -EINVAL;
+
 	if (!test_bit(NVDIMM_INTEL_QUERY_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
@@ -355,7 +363,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 	}
 
 	/* flush all cache before we make the nvdimms available */
-	nvdimm_invalidate_cache();
+	flush_all_caches();
 	return 0;
 }
 
@@ -377,11 +385,14 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 		},
 	};
 
+	if (!flush_all_caches_capable())
+		return -EINVAL;
+
 	if (!test_bit(NVDIMM_INTEL_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
 	/* flush all cache before we erase DIMM */
-	nvdimm_invalidate_cache();
+	flush_all_caches();
 	memcpy(nd_cmd.cmd.passphrase, nkey->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -401,22 +412,6 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 	}
 }
 
-/*
- * TODO: define a cross arch wbinvd equivalent when/if
- * NVDIMM_FAMILY_INTEL command support arrives on another arch.
- */
-#ifdef CONFIG_X86
-static void nvdimm_invalidate_cache(void)
-{
-	wbinvd_on_all_cpus();
-}
-#else
-static void nvdimm_invalidate_cache(void)
-{
-	WARN_ON_ONCE("cache invalidation required after unlock\n");
-}
-#endif
-
 static const struct nvdimm_security_ops __intel_security_ops = {
 	.get_flags = intel_security_flags,
 	.freeze = intel_security_freeze,
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 4f07afacbc23..89f310f92498 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -115,4 +115,35 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 	memcpy(dst, src, len)
 #endif
 
+/*
+ * Flush the entire caches across all CPUs, however:
+ *
+ *       YOU DO NOT WANT TO USE THIS FUNCTION.
+ *
+ * It is considered a big hammer and can affect overall
+ * system performance and increase latency/response times.
+ * As such it is not for general usage, but for specific use
+ * cases involving instantaneously invalidating wide swaths
+ * of memory on bare metal.
+
+ * Unlike the APIs above, this function can be defined on
+ * architectures which have VIPT or PIPT caches, and thus is
+ * beyond the scope of virtual to physical mappings/page
+ * tables changing.
+ *
+ * The limitation here is that the architectures that make
+ * use of it must can actually comply with the semantics,
+ * such as those which caches are in a consistent state. The
+ * caller can verify the situation early on.
+ */
+#ifndef flush_all_caches
+# define flush_all_caches_capable() false
+static inline void flush_all_caches(void)
+{
+	WARN_ON_ONCE("cache invalidation required\n");
+}
+#else
+# define flush_all_caches_capable() true
+#endif
+
 #endif /* _ASM_GENERIC_CACHEFLUSH_H */
-- 
2.37.2

