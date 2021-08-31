Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78E3FC9FE
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhHaOnG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:10930 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238280AbhHaOmz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:42:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218496782"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="218496782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="600974331"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2021 07:41:55 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfS002209;
        Tue, 31 Aug 2021 15:41:53 +0100
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
Subject: [PATCH v6 kspp-next 02/22] kbuild: merge vmlinux_link() between the ordinary link and Clang LTO
Date:   Tue, 31 Aug 2021 16:40:54 +0200
Message-Id: <20210831144114.154-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

When Clang LTO is enabled, vmlinux_link() reuses vmlinux.o instead of
re-linking ${KBUILD_VMLINUX_OBJS} and ${KBUILD_VMLINUX_LIBS}.

That is the only difference here, so merge the similar code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 36ef7b37fc5d..a6c4d0bce3ba 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -154,12 +154,23 @@ vmlinux_link()
 	local objects
 	local strip_debug
 	local map_option
+	local objs
+	local libs
 
 	info LD ${output}
 
 	# skip output file argument
 	shift
 
+	if [ -n "${CONFIG_LTO_CLANG}" ]; then
+		# Use vmlinux.o instead of performing the slow LTO link again.
+		objs=vmlinux.o
+		libs=
+	else
+		objs="${KBUILD_VMLINUX_OBJS}"
+		libs="${KBUILD_VMLINUX_LIBS}"
+	fi
+
 	# The kallsyms linking does not need debug symbols included.
 	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
 		strip_debug=-Wl,--strip-debug
@@ -170,22 +181,9 @@ vmlinux_link()
 	fi
 
 	if [ "${SRCARCH}" != "um" ]; then
-		if [ -n "${CONFIG_LTO_CLANG}" ]; then
-			# Use vmlinux.o instead of performing the slow LTO
-			# link again.
-			objects="--whole-archive		\
-				vmlinux.o 			\
-				--no-whole-archive		\
-				${@}"
-		else
-			objects="--whole-archive		\
-				${KBUILD_VMLINUX_OBJS}		\
-				--no-whole-archive		\
-				--start-group			\
-				${KBUILD_VMLINUX_LIBS}		\
-				--end-group			\
-				${@}"
-		fi
+		objects="--whole-archive ${objs} --no-whole-archive	\
+			 --start-group ${libs} --end-group		\
+			 $@"
 
 		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
 			${strip_debug#-Wl,}			\
-- 
2.31.1

