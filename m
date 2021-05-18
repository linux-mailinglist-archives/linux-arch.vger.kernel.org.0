Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129A0388100
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbhERUKU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 16:10:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:15751 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352120AbhERUKM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 16:10:12 -0400
IronPort-SDR: PWtDrqdsH0X3xVaZ9FZgIUD7t2bFG+vYqpGGlOQKG+vqRGrCgWSsmOTzXoD0ykDjG8xDaULLNQ
 x2RsQ5ZmouTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180411911"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180411911"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:08:52 -0700
IronPort-SDR: 3ygskozssrcjv9P5mwJMevQdKbUc/2OHTMBeFlJ6lb4nnLfwcxUMdID+AA0vR7yyD9VySsMhGf
 ZzjgzUOcMdiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="394993613"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2021 13:08:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Date:   Tue, 18 May 2021 13:03:15 -0700
Message-Id: <20210518200320.17239-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518200320.17239-1-chang.seok.bae@intel.com>
References: <20210518200320.17239-1-chang.seok.bae@intel.com>
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

