Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBE33CE2D
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 07:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhCPG5O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 02:57:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:44607 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235767AbhCPG5M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 02:57:12 -0400
IronPort-SDR: trabEZny+SVCq4S+h164e1UYw6bRxAB07c8ePwYD47uz104xPJs0q3IQWr2/2LqyZPdv4erQAJ
 pIkKk+hJSWvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253227831"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253227831"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:57:11 -0700
IronPort-SDR: rOPDJOAsOFDbRcEfR+EqNuSZh1wdhYTg+KOn6YNhaZXTxqe24dCh82+XZ59vNByO6rEyvF+VN5
 K60J2nycGLRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="511296073"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2021 23:57:11 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/6] uapi: Define the aux vector AT_MINSIGSTKSZ
Date:   Mon, 15 Mar 2021 23:52:10 -0700
Message-Id: <20210316065215.23768-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316065215.23768-1-chang.seok.bae@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
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

