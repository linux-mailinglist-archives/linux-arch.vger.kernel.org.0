Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F368C2CF
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfHMVE3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:04:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:18664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfHMVDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="194275982"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2019 14:03:40 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 07/14] x86/cet/ibt: Add ENDBR to op-code-map
Date:   Tue, 13 Aug 2019 13:53:52 -0700
Message-Id: <20190813205359.12196-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205359.12196-1-yu-cheng.yu@intel.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add control transfer terminating instructions:

ENDBR64/ENDBR32:
    Mark a valid 64/32-bit control transfer endpoint.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt               | 13 +++++++++++--
 tools/objtool/arch/x86/lib/x86-opcode-map.txt | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index c5e825d44766..fbc53481bc59 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -620,7 +620,16 @@ ea: SAVEPREVSSP (f3)
 # Skip 0xeb-0xff
 EndTable
 
-Table: 3-byte opcode 2 (0x0f 0x38)
+Table: 3-byte opcode 2 (0x0f 0x1e)
+Referrer:
+AVXcode:
+# Skip 0x00-0xf9
+fa: ENDBR64 (f3)
+fb: ENDBR32 (f3)
+#skip 0xfc-0xff
+EndTable
+
+Table: 3-byte opcode 3 (0x0f 0x38)
 Referrer: 3-byte escape 1
 AVXcode: 2
 # 0x0f 0x38 0x00-0x0f
@@ -804,7 +813,7 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSS Pq,Qq
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 EndTable
 
-Table: 3-byte opcode 3 (0x0f 0x3a)
+Table: 3-byte opcode 4 (0x0f 0x3a)
 Referrer: 3-byte escape 2
 AVXcode: 3
 # 0x0f 0x3a 0x00-0xff
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
index c5e825d44766..fbc53481bc59 100644
--- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
@@ -620,7 +620,16 @@ ea: SAVEPREVSSP (f3)
 # Skip 0xeb-0xff
 EndTable
 
-Table: 3-byte opcode 2 (0x0f 0x38)
+Table: 3-byte opcode 2 (0x0f 0x1e)
+Referrer:
+AVXcode:
+# Skip 0x00-0xf9
+fa: ENDBR64 (f3)
+fb: ENDBR32 (f3)
+#skip 0xfc-0xff
+EndTable
+
+Table: 3-byte opcode 3 (0x0f 0x38)
 Referrer: 3-byte escape 1
 AVXcode: 2
 # 0x0f 0x38 0x00-0x0f
@@ -804,7 +813,7 @@ f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSS Pq,Qq
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 EndTable
 
-Table: 3-byte opcode 3 (0x0f 0x3a)
+Table: 3-byte opcode 4 (0x0f 0x3a)
 Referrer: 3-byte escape 2
 AVXcode: 3
 # 0x0f 0x3a 0x00-0xff
-- 
2.17.1

