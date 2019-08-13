Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1A8B847
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfHMMTg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:19:36 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:52805 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbfHMMTf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:19:35 -0400
Received: by mail-qt1-f202.google.com with SMTP id e2so16936765qtm.19
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=suSCW+i7r8fLZkX8SIzkhSnBqWVbrjIKRYeVO6hPkeY=;
        b=jvjNRqGMIUmBvtS/0MJrxiJu3qNpVN8iEqXfR2TqIAEeOFfzn/2r2Lo5GOVx7CdDSd
         r1vZK+HfXj20rzOcUa3LFLXUQvH4VT8GVGNavOTLgEiQYmiGmj4RIROKJqiyUe401t4Z
         RYDL0bSP/98T3q9VvYfCygVClLZ/OjelY03qKSueV0aomfHkwZ6JT47g2eeGLqs0mvNM
         BtZockUYDc0cOpsQdV4wU3WGJC01I8TSW2J8LKOZx0gOp+2FCgOBW8zTcXZHjpgI5St7
         nvGI3USlamMIielikX/E3MDGfwNfWvROXe2p3ZjVxi55wNtiaBZzHmr7BOaAvsuebiu/
         XEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=suSCW+i7r8fLZkX8SIzkhSnBqWVbrjIKRYeVO6hPkeY=;
        b=s+eBIJutnxxTyL6BxSbmYLVtYGGVFHgI3ZNeWNUrlK+rZDC6GuACmfzuvO0orlLAbe
         019gJcdezNB4fSFvgCosUHvSKgr7zLiVH7Y+oAoimeJE7FFE/om1qRwxTF1SD1ZeGVxB
         8CSsmx5PK5hy58VmDTnL3SxTIomc2w/guKSgVS9d5WQ1Gk5GLxTVl2ROff/ve0QeGjpn
         GdMrt6cRwYNPEZBpQ0vG1nnnRm1K0XkRhA6RJpyayY5Z5XXFS4MWAo9fxbooA2o5RH1D
         vyI7I/rOb14f0NBxitxhw1yLOualxDNN0jZgdAMfAFMwCs9WgPSYsjeDYXav4fXLSYSz
         U/xg==
X-Gm-Message-State: APjAAAWl+lI5YBU7VefcniPceEc1nMZCceoacdUyXbAnuVAzgdVpUDC1
        u1FvB/noPlpbszzDvV2hEtsLzrp/8VmYQQ==
X-Google-Smtp-Source: APXvYqz0jwZkmy0W6g9uENPXy/ZLQA++gDNN+yoANsAtQ9Xi0Xi3LQ86n1y/uKsnYiTAd8ykfykOGHQvGCd2XA==
X-Received: by 2002:a05:620a:1659:: with SMTP id c25mr18463612qko.306.1565698774148;
 Tue, 13 Aug 2019 05:19:34 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:17:04 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-8-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 07/10] modpost: add support for generating namespace dependencies
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com
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
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/mod/modpost.c | 61 +++++++++++++++++++++++++++++++++++++++----
 scripts/mod/modpost.h |  2 ++
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 538bb24ffee3..833a7e1bcbb5 100644
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
@@ -2481,6 +2488,38 @@ static void write_dump(const char *fname)
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
+		const char *basename;
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
+		basename = strrchr(mod->name, '/');
+		if (basename)
+			basename++;
+		else
+			basename = mod->name;
+
+		sprintf(fname, ".tmp_versions/%s.ns_deps", basename);
+		write_if_changed(&ns_deps_buf, fname);
+	}
+}
+
 struct ext_sym_list {
 	struct ext_sym_list *next;
 	const char *file;
@@ -2497,7 +2536,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:I:e:mnsT:o:awE")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:e:mnsT:o:awEd")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
@@ -2538,6 +2577,9 @@ int main(int argc, char **argv)
 		case 'E':
 			sec_mismatch_fatal = 1;
 			break;
+		case 'd':
+			write_namespace_deps = 1;
+			break;
 		default:
 			exit(1);
 		}
@@ -2572,6 +2614,9 @@ int main(int argc, char **argv)
 
 		err |= check_modname_len(mod);
 		err |= check_exports(mod);
+		if (write_namespace_deps)
+			continue;
+
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
 		add_retpoline(&buf);
@@ -2584,6 +2629,12 @@ int main(int argc, char **argv)
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

