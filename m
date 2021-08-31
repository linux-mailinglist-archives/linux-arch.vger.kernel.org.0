Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B83FCA1D
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhHaOnW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:10940 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238353AbhHaOm7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:42:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218496805"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="218496805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="600974352"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2021 07:41:59 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfU002209;
        Tue, 31 Aug 2021 15:41:56 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org
Cc:     "Kristen C Accardi" <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        "Marta A Plantykow" <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v6 kspp-next 04/22] kbuild: merge vmlinux_link() between ARCH=um and other architectures
Date:   Tue, 31 Aug 2021 16:40:56 +0200
Message-Id: <20210831144114.154-5-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

For ARCH=um, ${CC} is used as the linker driver. Hence, the linker
options are prefixed with -Wl, .

Merge the similar code.

I replaced the -T option with the long option --script= so that it
works well with/without ${wl}.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 56 +++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 7b9c62e4d54a..d74cee5c4326 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -149,13 +149,12 @@ objtool_link()
 # ${2}, ${3}, ... - optional extra .o files
 vmlinux_link()
 {
-	local lds="${objtree}/${KBUILD_LDS}"
 	local output=${1}
-	local objects
-	local strip_debug
-	local map_option
 	local objs
 	local libs
+	local ld
+	local ldflags
+	local ldlibs
 
 	info LD ${output}
 
@@ -171,42 +170,33 @@ vmlinux_link()
 		libs="${KBUILD_VMLINUX_LIBS}"
 	fi
 
+	if [ "${SRCARCH}" = "um" ]; then
+		wl=-Wl,
+		ld="${CC}"
+		ldflags="${CFLAGS_vmlinux}"
+		ldlibs="-lutil -lrt -lpthread"
+	else
+		wl=
+		ld="${LD}"
+		ldflags="${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}"
+		ldlibs=
+	fi
+
+	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
+
 	# The kallsyms linking does not need debug symbols included.
 	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
-		strip_debug=-Wl,--strip-debug
+		ldflags="${ldflags} ${wl}--strip-debug"
 	fi
 
 	if [ -n "${CONFIG_VMLINUX_MAP}" ]; then
-		map_option="-Map=${output}.map"
+		ldflags="${ldflags} ${wl}-Map=${output}.map"
 	fi
 
-	if [ "${SRCARCH}" != "um" ]; then
-		objects="--whole-archive ${objs} --no-whole-archive	\
-			 --start-group ${libs} --end-group		\
-			 $@"
-
-		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
-			${strip_debug#-Wl,}			\
-			-o ${output}				\
-			${map_option}				\
-			-T ${lds} ${objects}
-	else
-		objects="-Wl,--whole-archive			\
-			${KBUILD_VMLINUX_OBJS}			\
-			-Wl,--no-whole-archive			\
-			-Wl,--start-group			\
-			${KBUILD_VMLINUX_LIBS}			\
-			-Wl,--end-group				\
-			${@}"
-
-		${CC} ${CFLAGS_vmlinux}				\
-			${strip_debug}				\
-			-o ${output}				\
-			${map_option:+-Wl,${map_option}}	\
-			-Wl,-T,${lds}				\
-			${objects}				\
-			-lutil -lrt -lpthread
-	fi
+	${ld} ${ldflags} -o ${output}					\
+		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
+		${wl}--start-group ${libs} ${wl}--end-group		\
+		$@ ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
-- 
2.31.1

