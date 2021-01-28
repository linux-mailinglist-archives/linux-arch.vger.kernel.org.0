Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13038306924
	for <lists+linux-arch@lfdr.de>; Thu, 28 Jan 2021 02:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhA1A6y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 19:58:54 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29067 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhA1A4t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2021 19:56:49 -0500
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 10S0pjIg024172;
        Thu, 28 Jan 2021 09:51:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 10S0pjIg024172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1611795120;
        bh=XJNJuhno9hAT3A1JjMh+5bcCus6LxY/fFlHwK/0rN8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8t54K8bjMUZ1YiPCOg1Zhg8Iy8nbJVUqpQKRgj9PKl9Z66UZ2oglg4Mr1EJ8hZ0b
         fqf3myOakclryZLYupXCDAZyZ1oBWLbn+BKoWjqN5ggkBUtwsum8ITFK1hgeJA5NsF
         OcOb+IcS8z3j7iheSOsJu79obFQVL04EtKev8wcFmxJ+l/EUP/CeC5gL23KgNgx7cJ
         tz/F1nbXVGkOmKba5TyTHtr8gTe9h3pLy0pW588S7ev1SayhuFdT2MkyXosIiWdgcI
         eDT3D3mi3oAzWwfcdaTAZhW8thR1nJ1ystk6VrmWC/rlK7k19rIPlKvQwZZ//I0FKi
         UhyiZ6UOs5hfw==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arch@vger.kernel.org, x86@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 11/27] m68k: add missing FORCE and fix 'targets' to make if_changed work
Date:   Thu, 28 Jan 2021 09:50:53 +0900
Message-Id: <20210128005110.2613902-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128005110.2613902-1-masahiroy@kernel.org>
References: <20210128005110.2613902-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The rules in this Makefile cannot detect the command line change because
the prerequisite 'FORCE' is missing.

Adding 'FORCE' will result in the headers being rebuilt every time
because the 'targets' addition is also wrong; the file paths in
'targets' must be relative to the current Makefile.

Fix all of them so the if_changed rules work correctly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/kernel/syscalls/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/kernel/syscalls/Makefile b/arch/m68k/kernel/syscalls/Makefile
index 659faefdcb1d..1c42d2d2926d 100644
--- a/arch/m68k/kernel/syscalls/Makefile
+++ b/arch/m68k/kernel/syscalls/Makefile
@@ -21,18 +21,19 @@ quiet_cmd_systbl = SYSTBL  $@
 		   '$(systbl_abi_$(basetarget))'		\
 		   '$(systbl_offset_$(basetarget))'
 
-$(uapi)/unistd_32.h: $(syscall) $(syshdr)
+$(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(kapi)/syscall_table.h: $(syscall) $(systbl)
+$(kapi)/syscall_table.h: $(syscall) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h
 kapisyshdr-y		+= syscall_table.h
 
-targets	+= $(uapisyshdr-y) $(kapisyshdr-y)
+uapisyshdr-y	:= $(addprefix $(uapi)/, $(uapisyshdr-y))
+kapisyshdr-y	:= $(addprefix $(kapi)/, $(kapisyshdr-y))
+targets		+= $(addprefix ../../../../, $(uapisyshdr-y) $(kapisyshdr-y))
 
 PHONY += all
-all: $(addprefix $(uapi)/,$(uapisyshdr-y))
-all: $(addprefix $(kapi)/,$(kapisyshdr-y))
+all: $(uapisyshdr-y) $(kapisyshdr-y)
 	@:
-- 
2.27.0

