Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FEF30E116
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 18:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBCR2G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 12:28:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:4059 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhBCR2C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 12:28:02 -0500
IronPort-SDR: cUZWd+DWcbV5kdFuQIuq54M/wUx1AUi4FaqxNfMTttYlo+71DV17ONXO/mW12DoA5HDM46GgwR
 5VwlRZSmjNdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242592377"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242592377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 09:27:21 -0800
IronPort-SDR: Zai1BmQvbq3jyby+nkQruNCl9QuP/uC4qAGcVTVQo34i1MgpLZsnPeBoV6Ssqizf3Lw9tsF2t2
 HeiWMdRh3u1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="406723661"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 09:27:20 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/5] uapi: Move the aux vector AT_MINSIGSTKSZ define to uapi
Date:   Wed,  3 Feb 2021 09:22:38 -0800
Message-Id: <20210203172242.29644-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203172242.29644-1-chang.seok.bae@intel.com>
References: <20210203172242.29644-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move the AT_MINSIGSTKSZ definition to generic Linux from arm64. It is
already used as generic ABI in glibc's generic elf.h, and this move will
prevent future namespace conflicts. In particular, x86 will re-use this
generic definition.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: libc-alpha@sourceware.org
Cc: linux-arch@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Change from v4:
* Added as a new patch (Carlos O'Donell)
---
 arch/arm64/include/uapi/asm/auxvec.h | 1 -
 include/uapi/linux/auxvec.h          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
index 743c0b84fd30..767d710c92aa 100644
--- a/arch/arm64/include/uapi/asm/auxvec.h
+++ b/arch/arm64/include/uapi/asm/auxvec.h
@@ -19,7 +19,6 @@
 
 /* vDSO location */
 #define AT_SYSINFO_EHDR	33
-#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
 
 #define AT_VECTOR_SIZE_ARCH 2 /* entries in ARCH_DLINFO */
 
diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index abe5f2b6581b..cc4fa77bd2a7 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,5 +33,6 @@
 
 #define AT_EXECFN  31	/* filename of program */
 
+#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery  */
 
 #endif /* _UAPI_LINUX_AUXVEC_H */
-- 
2.17.1

