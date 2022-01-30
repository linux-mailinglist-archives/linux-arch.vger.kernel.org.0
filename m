Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885474A3A4F
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356798AbiA3V0D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:26:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:9048 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356821AbiA3VZc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577932; x=1675113932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qjlVyEBxxP1l305ldO+H2m7erFyvzIp4PIJC/dne3Rw=;
  b=lWfmWDe1uVtISUbhbJ8UqaWGN9/ekymjl6JmgibJFvJ/a0msOYClGzfB
   jLgH997zdon7yto4gJxJJGCxnwnHLAsEKSmmFKtq75FGKssnSTi7AYNA6
   IuD35YpPW1l/KNHb4/PTIMcRtSbQF9aL+4DXF0RWlkRkf5q4nNptlycr2
   fYwjujHg0epPhYNzpHZXLKLWNJxhBENW++5k1I3eDI3OSZe/BzmGfir0w
   9N00aTCjLubqv4ISsEKAslFThE4LENdtPN0jSKi1/bieM5hPsXm+/5qKj
   Am/hMejzL2PUiHc2Huc9U2Dc1Tcko5dBjEH+t9OQzM/5NYXk0jwk9qNyy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685840"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685840"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536857038"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:14 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 35/35] x86/cpufeatures: Limit shadow stack to Intel CPUs
Date:   Sun, 30 Jan 2022 13:18:38 -0800
Message-Id: <20220130211838.8382-36-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow stack is supported on newer AMD processors, but the kernel
implementation has not been tested on them. Prevent basic issues from
showing up for normal users by disabling shadow stack on all CPUs except
Intel until it has been tested. At which point the limitation should be
removed.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - New patch.

 arch/x86/kernel/cpu/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9ee339f5b8ca..7fbfe707a1db 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -517,6 +517,14 @@ __setup("nopku", setup_disable_pku);
 
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
+	/*
+	 * Shadow stack is supported on AMD processors, but has not been
+	 * tested. Only support it on Intel processors until this is done.
+	 * At which point, this vendor check should be removed.
+	 */
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
+
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
 		return;
 
-- 
2.17.1

