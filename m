Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8F3678EC
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 06:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhDVEyv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 00:54:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:45527 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhDVEyu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 00:54:50 -0400
IronPort-SDR: o7fhuytSAjo6pZXvHaKkMiugOGlaCRfjQG660x3ImHrBKz6T0Iq6EohNKd+CzX5hvC7ckAfl2J
 2ttca/W7ohhQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="183311513"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="183311513"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 21:54:15 -0700
IronPort-SDR: P0DlGVpZ8pz/xSNAlJpFfT4ZAUa7ab7o7dTD92FVDrCEGFToaHNKnhJmuFPcSgn/bLMSPw17lP
 Z6t4H08TZgLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="524515402"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2021 21:54:15 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Date:   Wed, 21 Apr 2021 21:48:51 -0700
Message-Id: <20210422044856.27250-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422044856.27250-1-chang.seok.bae@intel.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define the AT_MINSIGSTKSZ in generic Linux. It is already used as generic
ABI in glibc's generic elf.h, and this define will prevent future namespace
conflicts. In particular, x86 is also using this generic definition.

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
Change from v6:
* Revised the comment. (Borislav Petkov)

Change from v5:
* Reverted the arm64 change. (Dave Martin and Will Deacon)
* Massaged the changelog.

Change from v4:
* Added as a new patch (Carlos O'Donell)
---
 include/uapi/linux/auxvec.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index abe5f2b6581b..c7e502bf5a6f 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,5 +33,8 @@
 
 #define AT_EXECFN  31	/* filename of program */
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51	/* minimal stack size for signal delivery */
+#endif
 
 #endif /* _UAPI_LINUX_AUXVEC_H */
-- 
2.17.1

