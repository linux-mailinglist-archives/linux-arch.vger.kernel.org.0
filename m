Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F7D3F3324
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhHTSUj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 14:20:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:22456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237758AbhHTSUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Aug 2021 14:20:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302407811"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="302407811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533074712"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:47 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v29 13/32] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Date:   Fri, 20 Aug 2021 11:11:42 -0700
Message-Id: <20210820181201.31490-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820181201.31490-1-yu-cheng.yu@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..1d4e5012c27d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -370,7 +370,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	37
+# define VM_UFFD_MINOR_BIT	38
 # define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
 #else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 # define VM_UFFD_MINOR		VM_NONE
-- 
2.21.0

