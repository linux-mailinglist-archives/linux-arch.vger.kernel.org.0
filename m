Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C95227BD0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGUJev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 05:34:51 -0400
Received: from 8bytes.org ([81.169.241.247]:58308 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGUJev (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 05:34:51 -0400
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 906BB1DB;
        Tue, 21 Jul 2020 11:34:49 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned sections
Date:   Tue, 21 Jul 2020 11:34:48 +0200
Message-Id: <20200721093448.10417-1-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Align the end of the .bss..page_aligned and .data..page_aligned section
on page-size too. Otherwise the linker might place other objects on the
page of the last ..page_aligned object. This is inconsistent with other
objects in those sections, which all have their own page.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/vmlinux.lds.S     | 1 +
 include/asm-generic/vmlinux.lds.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..9a03e5b23135 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -358,6 +358,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
+		. = ALIGN(PAGE_SIZE);
 		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3ceb4b7279ec..bd6302bd1d0f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -360,7 +360,8 @@
 
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
-	*(.data..page_aligned)
+	*(.data..page_aligned)						\
+	. = ALIGN(page_align);
 
 #define READ_MOSTLY_DATA(align)						\
 	. = ALIGN(align);						\
@@ -758,6 +759,7 @@
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
 		BSS_FIRST_SECTIONS					\
 		*(.bss..page_aligned)					\
+		. = ALIGN(PAGE_SIZE);					\
 		*(.dynbss)						\
 		*(BSS_MAIN)						\
 		*(COMMON)						\
-- 
2.27.0

