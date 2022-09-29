Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0737C5F00B4
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiI2Whf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiI2Wga (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBF25581;
        Thu, 29 Sep 2022 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490738; x=1696026738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eB1cPNZIwM/4vJ9UX4P/L+g239SirPcbtbxQL47/qDg=;
  b=WlCe4mTY7W1XN0onNHE9J56gS8kSWYnUrRRAYftyt93su08kfp9Diorn
   KujuRuuC3aJgnc2WJn9xZwMO4tWuDCYVdHqwx9GJMujdZQkJHSH4cAp8q
   +t5Xb+kcxuVLzxYux+s8qICgMm/4yVCTQCAOT5bx4azs5rZj4V8/NSdt9
   e5Xd5/gxj0eRJieWFHkKKNOAFoTcZBbURTC03xRXY1SALmXZqkOva8q3Q
   EFViBi0vpHVfrn+E1b2Q0XF3xk6oocjmEgpAy0h6E2tDqropdRxEj91JO
   txgiokohs7OA4oK9w9DCBtM5poaA6zJDSgo5+tvsHyrBR+bsbOioxWwVD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182195"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182195"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016373"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016373"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:57 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com
Subject: [OPTIONAL/CLEANUP v2 35/39] x86: Improve formatting of user_regset arrays
Date:   Thu, 29 Sep 2022 15:29:32 -0700
Message-Id: <20220929222936.14584-36-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Back in 2018, Ingo Molnar suggested[0] to improve the formatting of the
struct user_regset arrays. They have multiple member initializations per
line and some lines exceed 100 chars. Reformat them like he suggested.

[0] https://lore.kernel.org/lkml/20180711102035.GB8574@gmail.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - New patch

 arch/x86/kernel/ptrace.c | 107 ++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 1a4df5fbc5e9..eed8a65d335d 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1235,28 +1235,37 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
 	[REGSET_GENERAL64] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.regset_get = genregs_get, .set = genregs_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.regset_get	= genregs_get,
+		.set		= genregs_set
 	},
 	[REGSET_FP64] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(long),
-		.size = sizeof(long), .align = sizeof(long),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(long),
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET_XSTATE64] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET_IOPERM64] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_LONGS,
-		.size = sizeof(long), .align = sizeof(long),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_LONGS,
+		.size		= sizeof(long),
+		.align		= sizeof(long),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
@@ -1276,42 +1285,56 @@ static const struct user_regset_view user_x86_64_view = {
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
 	[REGSET_GENERAL32] = {
-		.core_note_type = NT_PRSTATUS,
-		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.regset_get = genregs32_get, .set = genregs32_set
+		.core_note_type	= NT_PRSTATUS,
+		.n		= sizeof(struct user_regs_struct32) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.regset_get	= genregs32_get,
+		.set		= genregs32_set
 	},
 	[REGSET_FP32] = {
-		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
+		.core_note_type	= NT_PRFPREG,
+		.n		= sizeof(struct user_i387_ia32_struct) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_fpregs_active,
+		.regset_get	= fpregs_get,
+		.set		= fpregs_set
 	},
 	[REGSET_XFP32] = {
-		.core_note_type = NT_PRXFPREG,
-		.n = sizeof(struct fxregs_state) / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
+		.core_note_type	= NT_PRXFPREG,
+		.n		= sizeof(struct fxregs_state) / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= regset_xregset_fpregs_active,
+		.regset_get	= xfpregs_get,
+		.set		= xfpregs_set
 	},
 	[REGSET_XSTATE32] = {
-		.core_note_type = NT_X86_XSTATE,
-		.size = sizeof(u64), .align = sizeof(u64),
-		.active = xstateregs_active, .regset_get = xstateregs_get,
-		.set = xstateregs_set
+		.core_note_type	= NT_X86_XSTATE,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= xstateregs_active,
+		.regset_get	= xstateregs_get,
+		.set		= xstateregs_set
 	},
 	[REGSET_TLS32] = {
-		.core_note_type = NT_386_TLS,
-		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
-		.size = sizeof(struct user_desc),
-		.align = sizeof(struct user_desc),
-		.active = regset_tls_active,
-		.regset_get = regset_tls_get, .set = regset_tls_set
+		.core_note_type	= NT_386_TLS,
+		.n		= GDT_ENTRY_TLS_ENTRIES,
+		.bias		= GDT_ENTRY_TLS_MIN,
+		.size		= sizeof(struct user_desc),
+		.align		= sizeof(struct user_desc),
+		.active		= regset_tls_active,
+		.regset_get	= regset_tls_get,
+		.set		= regset_tls_set
 	},
 	[REGSET_IOPERM32] = {
-		.core_note_type = NT_386_IOPERM,
-		.n = IO_BITMAP_BYTES / sizeof(u32),
-		.size = sizeof(u32), .align = sizeof(u32),
-		.active = ioperm_active, .regset_get = ioperm_get
+		.core_note_type	= NT_386_IOPERM,
+		.n		= IO_BITMAP_BYTES / sizeof(u32),
+		.size		= sizeof(u32),
+		.align		= sizeof(u32),
+		.active		= ioperm_active,
+		.regset_get	= ioperm_get
 	},
 };
 
-- 
2.17.1

