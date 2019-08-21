Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5439788F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfHULyh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 07:54:37 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37148 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfHULyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Aug 2019 07:54:36 -0400
Received: by mail-qk1-f201.google.com with SMTP id d203so1861705qke.4
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 04:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5nLAsIhJbjXo3VLybDaau5r86S2zgpwtcdZcq2nr7TM=;
        b=ofPA9IRiVhyIh53f5vISfHZyhvH6qgMnojeSLjY9diLbyNWRtny94Rgs5bClOj45Pi
         t52mQtFq60jfVmtGGmR5jS+9ulfKctN55o3yjyx8fOMcLxsS1M6KtYEu5/fyhyy78xRY
         LmRa3ix37ByN0gk28Luhq9qzHcM0P0Mjn6ugeUfoon235lLIlB1qG3DAZ5ex2J/VNDcN
         iHJlxVYT6K3Ngbmk5aYh7WN56moRi4RoLEwhQAag60sINlWlDojx9nQvU/QTWSTSHYIr
         rHk3tIBGXhDM2LdE7iv/G82BXkI5Pl38r9Pe3MCy0/dPwjYhZ7Xb2LufLAyBP1sfJSUz
         4ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5nLAsIhJbjXo3VLybDaau5r86S2zgpwtcdZcq2nr7TM=;
        b=kfvyBcmjB0OUMO8fFkipjE2CGbVw+dDxstDSVGFBRQbARCccYoZspjpCYi/SG3hvXU
         A1woLOSi5b708xVjatIR/xXYIBR4WQQDdAW7A02fnXO42dr/QWKcovI0uOyyWyNomsWu
         cJ87imSDlWYjJhzECYmq5+ZQ5BUfjzTxC2HxCZF6FOpY0IQ2pKfm8wpdjruAl3MIUgzU
         eOtna87l8b6/IdvoE7hmULnfGBDs0uiUcud9yFsQoX8m9WXUqrHeUA225z78LQWx15cT
         sQRpZMNWBc8WLYAqT0EsQFv3T+QVpjF7SNBzB+SHjGGmB2xTwc5H3fpikTrGzNvIFeny
         N61Q==
X-Gm-Message-State: APjAAAVujD7EPxxwTcZhS13X35fRkAKmUTwzbbybcJ9m+otjxOuZHWUW
        wK4lJFkSuTO3Fifc2qZCW0OHMa0nzDNbfQ==
X-Google-Smtp-Source: APXvYqwq4dDAYCVXMv3VyClmlSqdgrtcMn9LH+SbrvjJb6bgTG/ujDjbA6EgPkHkugCHjJkqrsMLB2P1todTxg==
X-Received: by 2002:a0c:b209:: with SMTP id x9mr7843206qvd.217.1566388474954;
 Wed, 21 Aug 2019 04:54:34 -0700 (PDT)
Date:   Wed, 21 Aug 2019 12:49:22 +0100
In-Reply-To: <20190821114955.12788-1-maennich@google.com>
Message-Id: <20190821114955.12788-8-maennich@google.com>
Mime-Version: 1.0
References: <20190813121733.52480-1-maennich@google.com> <20190821114955.12788-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v3 07/11] modpost: add support for generating namespace dependencies
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>, Toru Komatsu <k0ma@utam0k.jp>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds an option to modpost to generate a <module>.ns_deps file
per module, containing the namespace dependencies for that module.

E.g. if the linked module my-module.ko would depend on the symbol
myfunc.MY_NS in the namespace MY_NS, the my-module.ns_deps file created
by modpost would contain the entry MY_NS to express the namespace
dependency of my-module imposed by using the symbol myfunc.

These files can subsequently be used by static analysis tools (like
coccinelle scripts) to address issues with missing namespace imports. A
later patch of this series will introduce such a script 'nsdeps' and a
corresponding make target to automatically add missing
MODULE_IMPORT_NS() definitions to the module's sources. For that it uses
the information provided in the generated .ns_deps files.

Co-developed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 .gitignore            |  1 +
 Makefile              |  2 +-
 scripts/mod/modpost.c | 54 +++++++++++++++++++++++++++++++++++++++----
 scripts/mod/modpost.h |  2 ++
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2030c7a4d2f8..9ee63aa2a3fb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@
 *.lzo
 *.mod
 *.mod.c
+*.ns_deps
 *.o
 *.o.*
 *.order
diff --git a/Makefile b/Makefile
index 9fa18613566f..a89870188c09 100644
--- a/Makefile
+++ b/Makefile
@@ -1669,7 +1669,7 @@ clean: $(clean-dirs)
 		-o -name '*.ko.*' \
 		-o -name '*.dtb' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
 		-o -name '*.dwo' -o -name '*.lst' \
-		-o -name '*.su' -o -name '*.mod' \
+		-o -name '*.su' -o -name '*.mod' -o -name '*.ns_deps' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 538bb24ffee3..81eeec063709 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -38,6 +38,8 @@ static int sec_mismatch_count = 0;
 static int sec_mismatch_fatal = 0;
 /* ignore missing files */
 static int ignore_missing_files;
+/* write namespace dependencies */
+static int write_namespace_deps;
 
 enum export {
 	export_plain,      export_unused,     export_gpl,
@@ -2176,10 +2178,15 @@ static int check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->namespace &&
-		    !module_imports_namespace(mod, exp->namespace)) {
-			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
-			     basename, exp->name, exp->namespace);
+		if (exp->namespace) {
+			add_namespace(&mod->required_namespaces,
+				      exp->namespace);
+
+			if (!write_namespace_deps &&
+			    !module_imports_namespace(mod, exp->namespace)) {
+				warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
+				     basename, exp->name, exp->namespace);
+			}
 		}
 
 		if (!mod->gpl_compatible)
@@ -2481,6 +2488,31 @@ static void write_dump(const char *fname)
 	free(buf.p);
 }
 
+static void write_namespace_deps_files(void)
+{
+	struct module *mod;
+	struct namespace_list *ns;
+	struct buffer ns_deps_buf = {};
+
+	for (mod = modules; mod; mod = mod->next) {
+		char fname[PATH_MAX];
+
+		if (mod->skip)
+			continue;
+
+		ns_deps_buf.pos = 0;
+
+		for (ns = mod->required_namespaces; ns; ns = ns->next)
+			buf_printf(&ns_deps_buf, "%s\n", ns->namespace);
+
+		if (ns_deps_buf.pos == 0)
+			continue;
+
+		sprintf(fname, "%s.ns_deps", mod->name);
+		write_if_changed(&ns_deps_buf, fname);
+	}
+}
+
 struct ext_sym_list {
 	struct ext_sym_list *next;
 	const char *file;
@@ -2497,7 +2529,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:I:e:mnsT:o:awE")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:e:mnsT:o:awEd")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2538,6 +2570,9 @@ int main(int argc, char **argv)
 		case 'E':
 			sec_mismatch_fatal = 1;
 			break;
+		case 'd':
+			write_namespace_deps = 1;
+			break;
 		default:
 			exit(1);
 		}
@@ -2572,6 +2607,9 @@ int main(int argc, char **argv)
 
 		err |= check_modname_len(mod);
 		err |= check_exports(mod);
+		if (write_namespace_deps)
+			continue;
+
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
 		add_retpoline(&buf);
@@ -2584,6 +2622,12 @@ int main(int argc, char **argv)
 		sprintf(fname, "%s.mod.c", mod->name);
 		write_if_changed(&buf, fname);
 	}
+
+	if (write_namespace_deps) {
+		write_namespace_deps_files();
+		return 0;
+	}
+
 	if (dump_write)
 		write_dump(dump_write);
 	if (sec_mismatch_count && sec_mismatch_fatal)
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 9626bf3e7424..92a926d375d2 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -126,6 +126,8 @@ struct module {
 	struct buffer dev_table_buf;
 	char	     srcversion[25];
 	int is_dot_o;
+	// Required namespace dependencies
+	struct namespace_list *required_namespaces;
 	// Actual imported namespaces
 	struct namespace_list *imported_namespaces;
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

