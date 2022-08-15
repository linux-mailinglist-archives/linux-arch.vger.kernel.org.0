Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE275932B8
	for <lists+linux-arch@lfdr.de>; Mon, 15 Aug 2022 18:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiHOQHP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Aug 2022 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiHOQHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Aug 2022 12:07:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA401A82D;
        Mon, 15 Aug 2022 09:07:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D977B5A208E;
        Mon, 15 Aug 2022 16:07:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 211355A2B8D;
        Mon, 15 Aug 2022 16:07:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660579631; a=rsa-sha256;
        cv=none;
        b=dwy35Dq6MGivfs7YD0SiCsx7o/lmefiDQXuFB6kuAoJ2GZ1w/zY7XZEeKhE+Buxp+kVpkV
        aNKf3PQBZ5wknPxF9NEeQeDCkbavaCTKYZye7jnw1XTcDso5ufMiHrE5IFKw6Nd+ttCLE9
        KX/KMm1eXiBNdt4I77PznODaZj21QQYckOhr5FPp7GdGvzl9N4fD7s/o1BzsoEj6b0f9em
        kYTRMZCvvv3VOulYN/Whm9Y2ZXP9wIpsK6SwqI03lw/DXgAvgheaDrPjhujaNuSEyHr/yD
        1Wd47BWWbRgbpUCEs/vCAtZjGUypu8J+JLQzZHwASPZ/V05rbGJG42bzesfLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660579631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SWrmCDYRRkOHcBepfHdfZ2+Ekw3l2pMf1Y2VMTMTM4I=;
        b=h9RmqWmgiRegO2wOYKqT+5fUhLzOscKjonYh+kgeJvR7it3+DEXu9kbd/WCLhtp5U5Jojk
        FmvtB+1dCF7govsF1ALK5Rjjy09uvZ9XjWSNWeMAdtK4Yiit18mpxoXfrmXvZxjCLKRqkc
        zDdDGK3IupY43C8FD/m1HMDQ0csqOUwIqSTDb0QTeirLtrVdjxIw3FV0SztaBO6bqWxMpR
        kCTyAf5lKhxaH4Ulg7/f2XSfJEQqZpJRrd2K4oDUgtLbNCiKYIImHoUmCSdVy6bNKcodMb
        Ibx9AzWQxGe8Oto4CJGiNpzC3MteuQ7Y/fdlGOxA1IOdT7YVbLaXPCCTDnBpMQ==
ARC-Authentication-Results: i=1;
        rspamd-7586b5656-fgpvh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Society-Power: 6a49d4b33abf0487_1660579631606_2197245223
X-MC-Loop-Signature: 1660579631606:4165773123
X-MC-Ingress-Time: 1660579631606
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.123 (trex/6.7.1);
        Mon, 15 Aug 2022 16:07:11 +0000
Received: from offworld (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4M5zgd4syVz3Y;
        Mon, 15 Aug 2022 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1660579630;
        bh=SWrmCDYRRkOHcBepfHdfZ2+Ekw3l2pMf1Y2VMTMTM4I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jj4Cc7GxvFJDCpbsnMc8Pcg+Do8obnFG2gpvaPsDG1OI3Rc42JwCEQnWBFu5hyDSw
         YtFlOAuYS3RfC3dMKaSnF8M13SmlKJTy8sYwaB9tvs4Zjm4a+KW6A9n23diwYALWRm
         IXdP7VzTupOvYWvscXcCMWON5ZtUxg+gXUOeL5wenY453KeK0L6gniUAZr0K0W+nAa
         t2Odh8WClDC/AuBrNkm7pQ2H6Kp1YXdzofpoNNm73Kl1S9nbM3zIvDBYyMykPzFa42
         wwREa30YKMa3Ty9HSKSVggOqOn+fcLq8qTYKwXwGp6p9wrGYmGAGUhUnSEuGZukwFe
         uJfWwePvmuW2A==
Date:   Mon, 15 Aug 2022 09:07:06 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <20220815160706.tqd42dv24tgb7x7y@offworld>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
 <165791937063.2491387.15277418618265930924.stgit@djiang5-desk3.ch.intel.com>
 <20220718053039.5whjdcxynukildlo@offworld>
 <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CXL security features, global CPU cache flushing nvdimm
requirements are no longer specific to that subsystem, even
beyond the scope of security_ops. CXL will need such semantics
for features not necessarily limited to persistent memory.

While the scope of this is for physical address space, add a
new flush_all_caches() in cacheflush headers such that each
architecture can define it, when capable. For x86 just use the
wbinvd hammer and prevent any other arch from being capable.
While there can be performance penalties or delays response
times, these calls are both rare and explicitly security
related, and therefore become less important.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

After a few iterations I circled back to an interface without granularity.
It just doesn't make sense right now to define a range if arm64 will not
support this (won't do VA-based physical address space flushes) and, until
it comes up with consistent caches, security operations will simply be
unsupported.

  arch/x86/include/asm/cacheflush.h |  3 +++
  drivers/acpi/nfit/intel.c         | 41 ++++++++++++++-----------------
  include/asm-generic/cacheflush.h  | 22 +++++++++++++++++
  3 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index b192d917a6d0..ce2ec9556093 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -10,4 +10,7 @@

  void clflush_cache_range(void *addr, unsigned int size);

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
index 4f07afacbc23..f249142b4908 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -115,4 +115,26 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
	memcpy(dst, src, len)
  #endif

+/*
+ * Flush the entire caches across all CPUs. It is considered
+ * a big hammer (latency and performance). Unlike the APIs
+ * above, this function can be defined on architectures which
+ * have VIPT or PIPT caches, and thus is beyond the scope of
+ * virtual to physical mappings/page tables changing.
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
