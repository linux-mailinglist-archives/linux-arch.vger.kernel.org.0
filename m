Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAED326E3F
	for <lists+linux-arch@lfdr.de>; Sat, 27 Feb 2021 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhB0RMc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Feb 2021 12:12:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:57118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhB0RJH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Feb 2021 12:09:07 -0500
IronPort-SDR: Z+9VHSpTwjsXASRy6We2WJ7PavGrEQIUvTDWSUs7R1TpKpWYhqBPs5DaKatJZQPliQEYJatgv/
 2jYo+XU8Y4LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="205700325"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="205700325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 09:03:58 -0800
IronPort-SDR: 3NNKH8C+BDh4SNttR0EgUbJBjMeSt4yejVmvxfOpPBFG/7Ykq2UaYINzVYDyy80ImSLUQx8vbO
 E4i9KpeLk0rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="503906841"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2021 09:03:58 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Date:   Sat, 27 Feb 2021 08:59:06 -0800
Message-Id: <20210227165911.32757-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210227165911.32757-1-chang.seok.bae@intel.com>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
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
Change from v5:
* Reverted the arm64 change. (Dave Martin)
* Massaged the changelog.

Change from v4:
* Added as a new patch (Carlos O'Donell)
---
 include/uapi/linux/auxvec.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index abe5f2b6581b..15be98c75174 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,5 +33,8 @@
 
 #define AT_EXECFN  31	/* filename of program */
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery  */
+#endif
 
 #endif /* _UAPI_LINUX_AUXVEC_H */
-- 
2.17.1

