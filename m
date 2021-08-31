Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44A3FCA02
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhHaOnI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:36529 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhHaOm5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:42:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205616977"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205616977"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="446126105"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2021 07:41:57 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfT002209;
        Tue, 31 Aug 2021 15:41:54 +0100
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
Subject: [PATCH v6 kspp-next 03/22] kbuild: do not remove 'linux' link in scripts/link-vmlinux.sh
Date:   Tue, 31 Aug 2021 16:40:55 +0200
Message-Id: <20210831144114.154-4-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

arch/um/Makefile passes the -f option to the ln command:

  linux: vmlinux
          @echo '  LINK $@'
          $(Q)ln -f $< $@

So, the hard link is always re-created, and the old one is removed
anyway.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a6c4d0bce3ba..7b9c62e4d54a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -206,7 +206,6 @@ vmlinux_link()
 			-Wl,-T,${lds}				\
 			${objects}				\
 			-lutil -lrt -lpthread
-		rm -f linux
 	fi
 }
 
-- 
2.31.1

