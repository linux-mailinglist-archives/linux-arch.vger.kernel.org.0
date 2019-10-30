Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4AE967D
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2019 07:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJ3GkA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 02:40:00 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:61857 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfJ3GkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 02:40:00 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x9U6d6lw008465;
        Wed, 30 Oct 2019 15:39:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x9U6d6lw008465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572417549;
        bh=iWfwrkLnJw9f051ci1qoVF6YYPkEv18Rb84fKuOp9+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxQDYGDKj8kELAyO+Kg1OLi3ibM8mnnEFLu13XD5s1Rg8tvPK+vRKhjeki00taZwW
         PEJPfxq1TXEAKMTymfAlfi/SMw//cI5lA0HKUAENK0laBCT1LlMi5vA+cfKkW+sFq0
         A6Sq+MM5TP7LFseOHFBiALS8CMXXn/rTfWgxkrtgKoFaJgW+IQG+CZTAWTjU1VXs7k
         Htow4cGQb/N34CB9FjJzlr6CCajmKx8CJjDANnwMYsoRTkGByufw6D1e+K3tqcJjpR
         7qvwzzeK38N6BTFRIwHbPk+uK2XZCp6QddApCCrUQzhB1TIBV5e89m7WpwnHa+1Pdf
         WtbWumY9/TpZw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] arch: sembuf.h: make uapi asm/sembuf.h self-contained
Date:   Wed, 30 Oct 2019 15:38:55 +0900
Message-Id: <20191030063855.9989-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030063855.9989-1-yamada.masahiro@socionext.com>
References: <20191030063855.9989-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The user-space cannot compile <asm/sembuf.h> due to some missing type
definitions. For example, building it for x86 fails as follows:

  CC      usr/include/asm/sembuf.h.s
In file included from <command-line>:32:0:
./usr/include/asm/sembuf.h:17:20: error: field ‘sem_perm’ has incomplete type
  struct ipc64_perm sem_perm; /* permissions .. see ipc.h */
                    ^~~~~~~~
./usr/include/asm/sembuf.h:24:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t sem_otime; /* last semop time */
  ^~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:25:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused1;
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:26:2: error: unknown type name ‘__kernel_time_t’
  __kernel_time_t sem_ctime; /* last change time */
  ^~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:27:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused2;
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:29:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t sem_nsems; /* no. of semaphores in array */
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:30:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused3;
  ^~~~~~~~~~~~~~~~
./usr/include/asm/sembuf.h:31:2: error: unknown type name ‘__kernel_ulong_t’
  __kernel_ulong_t __unused4;
  ^~~~~~~~~~~~~~~~

It is just a matter of missing include directive.

Include <asm/ipcbuf.h> to make it self-contained, and add it to
the compile-test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/uapi/asm/sembuf.h    | 2 ++
 arch/parisc/include/uapi/asm/sembuf.h  | 1 +
 arch/powerpc/include/uapi/asm/sembuf.h | 2 ++
 arch/sparc/include/uapi/asm/sembuf.h   | 2 ++
 arch/x86/include/uapi/asm/sembuf.h     | 2 ++
 arch/xtensa/include/uapi/asm/sembuf.h  | 1 +
 include/uapi/asm-generic/sembuf.h      | 1 +
 usr/include/Makefile                   | 1 -
 8 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi/asm/sembuf.h
index 60c89e6cb25b..7d135b93bebd 100644
--- a/arch/mips/include/uapi/asm/sembuf.h
+++ b/arch/mips/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_SEMBUF_H
 #define _ASM_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The semid64_ds structure for the MIPS architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 3c31163b1241..b17a2460b184 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -3,6 +3,7 @@
 #define _PARISC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /* 
  * The semid64_ds structure for parisc architecture.
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 3f60946f77e3..f42c9c3502c7 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_SEMBUF_H
 #define _ASM_POWERPC_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/sparc/include/uapi/asm/sembuf.h b/arch/sparc/include/uapi/asm/sembuf.h
index f3d309c2e1cd..5d7764cdf80f 100644
--- a/arch/sparc/include/uapi/asm/sembuf.h
+++ b/arch/sparc/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_SEMBUF_H
 #define _SPARC_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The semid64_ds structure for sparc architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index 89de6cd9f0a7..da0464af7aa6 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_SEMBUF_H
 #define _ASM_X86_SEMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The semid64_ds structure for x86 architecture.
  * Note extra padding because this structure is passed back and forth
diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/uapi/asm/sembuf.h
index 09f348d643f1..3b9cdd406dfe 100644
--- a/arch/xtensa/include/uapi/asm/sembuf.h
+++ b/arch/xtensa/include/uapi/asm/sembuf.h
@@ -22,6 +22,7 @@
 #define _XTENSA_SEMBUF_H
 
 #include <asm/byteorder.h>
+#include <asm/ipcbuf.h>
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index 0bae010f1b64..5807fcd643ba 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_SEMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /*
  * The semid64_ds structure for x86 architecture.
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 099d7401aa23..107d04bd5ee3 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -16,7 +16,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-header-test- += asm/sembuf.h
 header-test- += asm/shmbuf.h
 header-test- += asm/signal.h
 header-test- += asm/ucontext.h
-- 
2.17.1

