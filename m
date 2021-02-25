Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89049325307
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 17:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBYQFb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 11:05:31 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53233 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhBYQFB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 11:05:01 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 11PG2sqH028425;
        Fri, 26 Feb 2021 01:02:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11PG2sqH028425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614268975;
        bh=kD6YYQcfazkFFrleiT3XOphcGqp8KWUK68CUpacxPEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FH+djl+aoq0KwOxV5O+3XLczQhmeYEdHT+Rapnrd04mkFZGwsg1Qd9Co+eCE7sRD1
         NEK5pEpGaq679ElSocJZSnj+Dy4HfnmFC1VFyYVok2BZDwfXhmXZJHlY7BQEeWpcfA
         tIdRxYq/DI9OHfG1EwnVf33iHbGHMK3tJqCYSJW7XKuDP41caqlTuIAttYSg+pZ3nd
         CZC2ycG83FHq8Fue19zcn6ZPWRhm4LOxgSRXq/5Bgq4WfKxzSSQusZx1mR8hpinKa5
         46zsngJALHGMOS5xQtffu6ev/dAOVwEdDuwPIZR9cvgFL0+F3m8OeZ4AhlduthkY/J
         e9a+KmHYLJ81A==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/4] kbuild: fix UNUSED_KSYMS_WHITELIST for Clang LTO
Date:   Fri, 26 Feb 2021 01:02:43 +0900
Message-Id: <20210225160247.2959903-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210225160247.2959903-1-masahiroy@kernel.org>
References: <20210225160247.2959903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
does not work as expected if the .config file has already specified
CONFIG_UNUSED_KSYMS_WHITELIST="my/own/white/list" before enabling
CONFIG_LTO_CLANG.

So, the user-supplied whitelist and LTO-specific white list must be
independent of each other.

I refactored the shell script so CONFIG_MODVERSIONS and CONFIG_CLANG_LTO
handle whitelists in the same way.

Fixes: fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/Kconfig                    |  1 -
 scripts/gen_autoksyms.sh        | 33 ++++++++++++++++++++++++---------
 scripts/lto-used-symbollist.txt |  5 -----
 3 files changed, 24 insertions(+), 15 deletions(-)
 delete mode 100644 scripts/lto-used-symbollist.txt

diff --git a/init/Kconfig b/init/Kconfig
index 0bf5b340b80e..351161326e3c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2277,7 +2277,6 @@ config TRIM_UNUSED_KSYMS
 config UNUSED_KSYMS_WHITELIST
 	string "Whitelist of symbols to keep in ksymtab"
 	depends on TRIM_UNUSED_KSYMS
-	default "scripts/lto-used-symbollist.txt" if LTO_CLANG
 	help
 	  By default, all unused exported symbols will be un-exported from the
 	  build when TRIM_UNUSED_KSYMS is selected.
diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index d54dfba15bf2..b74d5949fea6 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -19,7 +19,24 @@ esac
 # We need access to CONFIG_ symbols
 . include/config/auto.conf
 
-ksym_wl=/dev/null
+needed_symbols=
+
+# Special case for modversions (see modpost.c)
+if [ -n "$CONFIG_MODVERSIONS" ]; then
+	needed_symbols="$needed_symbols module_layout"
+fi
+
+# With CONFIG_LTO_CLANG, LLVM bitcode has not yet been compiled into a binary
+# when the .mod files are generated, which means they don't yet contain
+# references to certain symbols that will be present in the final binaries.
+if [ -n "$CONFIG_LTO_CLANG" ]; then
+	# intrinsic functions
+	needed_symbols="$needed_symbols memcpy memmove memset"
+	# stack protector symbols
+	needed_symbols="$needed_symbols __stack_chk_fail __stack_chk_guard"
+fi
+
+ksym_wl=
 if [ -n "$CONFIG_UNUSED_KSYMS_WHITELIST" ]; then
 	# Use 'eval' to expand the whitelist path and check if it is relative
 	eval ksym_wl="$CONFIG_UNUSED_KSYMS_WHITELIST"
@@ -40,16 +57,14 @@ cat > "$output_file" << EOT
 EOT
 
 [ -f modules.order ] && modlist=modules.order || modlist=/dev/null
-sed 's/ko$/mod/' $modlist |
-xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
-cat - "$ksym_wl" |
+
+{
+	sed 's/ko$/mod/' $modlist | xargs -n1 sed -n -e '2p'
+	echo "$needed_symbols"
+	[ -n "$ksym_wl" ] && cat "$ksym_wl"
+} | sed -e 's/ /\n/g' | sed -n -e '/^$/!p' |
 # Remove the dot prefix for ppc64; symbol names with a dot (.) hold entry
 # point addresses.
 sed -e 's/^\.//' |
 sort -u |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
-
-# Special case for modversions (see modpost.c)
-if [ -n "$CONFIG_MODVERSIONS" ]; then
-	echo "#define __KSYM_module_layout 1" >> "$output_file"
-fi
diff --git a/scripts/lto-used-symbollist.txt b/scripts/lto-used-symbollist.txt
deleted file mode 100644
index 38e7bb9ebaae..000000000000
--- a/scripts/lto-used-symbollist.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-memcpy
-memmove
-memset
-__stack_chk_fail
-__stack_chk_guard
-- 
2.27.0

