Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B0295BE
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbfEXK0f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 06:26:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39254 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390631AbfEXK0e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 06:26:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E3541682;
        Fri, 24 May 2019 03:26:34 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9DF43F703;
        Fri, 24 May 2019 03:26:31 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Andrew Jones <drjones@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Sudakshina Das <sudi.das@arm.com>,
        Paul Elliott <paul.elliott@arm.com>
Subject: [PATCH 5/8] elf: Parse program properties before destroying the old process
Date:   Fri, 24 May 2019 11:25:30 +0100
Message-Id: <1558693533-13465-6-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently we try to read program properties from
NT_GNU_PROPERTY_TYPE_0 ELF notes.  However, we do this too late to
either report failures cleanly or influence certain aspects of
process setup such as the default mmap permissions for the new
executable's pages (which will matter for arm64 for example).

So, split parsing of the notes from use: rename
arch_setup_property() to arch_parse_property() to make the intent
clear, and hoist it before flush_old_exec() so that we can still
bail out gracefully if needed.

Also propagate arch_state into the call so that the arch backend
has somewhere to stash information for later use.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 fs/binfmt_elf.c     | 26 +++++++++++++-------------
 include/linux/elf.h | 15 +++++++++++----
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 18015fc..32c9c13 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -851,6 +851,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 	}
 
+	if (interpreter) {
+		retval = arch_parse_property(&loc->interp_elf_ex,
+					     interp_elf_phdata,
+					     interpreter, true, &arch_state);
+	} else {
+		retval = arch_parse_property(&loc->elf_ex,
+					     elf_phdata,
+					     bprm->file, false, &arch_state);
+	}
+
+	if (retval < 0)
+		goto out_free_dentry;
+
 	/*
 	 * Allow arch code to reject the ELF at this point, whilst it's
 	 * still possible to return an error to the code that invoked
@@ -1080,19 +1093,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	}
 
 	if (interpreter) {
-		retval = arch_setup_property(&loc->interp_elf_ex,
-					     interp_elf_phdata,
-					     interpreter, true);
-	} else {
-		retval = arch_setup_property(&loc->elf_ex,
-					     elf_phdata,
-					     bprm->file, false);
-	}
-
-	if (retval < 0)
-		goto out_free_dentry;
-
-	if (interpreter) {
 		unsigned long interp_map_addr = 0;
 
 		elf_entry = load_elf_interp(&loc->interp_elf_ex,
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c15febe..cfcf154 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -57,14 +57,21 @@ extern int elf_coredump_extra_notes_size(void);
 extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
 #endif
 
+struct arch_elf_state;
+
 #ifdef CONFIG_ARCH_USE_GNU_PROPERTY
-extern int arch_setup_property(void *ehdr, void *phdr, struct file *f,
-			       bool interp);
+extern int arch_parse_property(void *ehdr, void *phdr, struct file *f,
+			       bool interp, struct arch_elf_state *arch_state);
 extern int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
 			    u32 pr_type, u32 *feature);
 #else
-static inline int arch_setup_property(void *ehdr, void *phdr, struct file *f,
-				      bool interp) { return 0; }
+static inline int arch_parse_property(void *ehdr, void *phdr, struct file *f,
+				      bool interp,
+				      struct arch_elf_state *arch_state)
+{
+	return 0;
+}
+
 static inline int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
 				   u32 pr_type, u32 *feature) { return 0; }
 #endif
-- 
2.1.4

