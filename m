Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A369D3E7
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfHZQVs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 12:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfHZQVs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 12:21:48 -0400
Received: from linux-8ccs (unknown [92.117.241.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1927E2173E;
        Mon, 26 Aug 2019 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566836507;
        bh=m4XKgSxewkwMJcvHgcYRs3HGBgA+LZEaGyuDJG5PqT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnCkPbWFLILW2QetAMWRNFN1wJ6osogrEWa7m+hF7CHkvo1b3Y6pCk4/pA+pu08rC
         WEgFusvmwMANzv2SQGBXQz+vE86sMqYPMDoSnLlSRsJh0JX4pAkZt+te/udOZGXCTi
         y0rU1Gp4BpS+6qHRQZ45htF8i6L/nNVifWKbYE2E=
Date:   Mon, 26 Aug 2019 18:21:38 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 04/11] modpost: add support for symbol namespaces
Message-ID: <20190826162138.GA31739@linux-8ccs>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-5-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821114955.12788-5-maennich@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Matthias Maennich [21/08/19 12:49 +0100]:
>Add support for symbols that are exported into namespaces. For that,
>extract any namespace suffix from the symbol name. In addition, emit a
>warning whenever a module refers to an exported symbol without
>explicitly importing the namespace that it is defined in. This patch
>consistently adds the namespace suffix to symbol names exported into
>Module.symvers.
>
>Example warning emitted by modpost in case of the above violation:
>
> WARNING: module ums-usbat uses symbol usb_stor_resume from namespace
> USB_STORAGE, but does not import it.
>
>Co-developed-by: Martijn Coenen <maco@android.com>
>Signed-off-by: Martijn Coenen <maco@android.com>
>Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Matthias Maennich <maennich@google.com>
>---
> scripts/mod/modpost.c | 91 +++++++++++++++++++++++++++++++++++++------
> scripts/mod/modpost.h |  7 ++++
> 2 files changed, 87 insertions(+), 11 deletions(-)
>
>diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>index f277e116e0eb..538bb24ffee3 100644
>--- a/scripts/mod/modpost.c
>+++ b/scripts/mod/modpost.c
>@@ -164,6 +164,7 @@ struct symbol {
> 	struct module *module;
> 	unsigned int crc;
> 	int crc_valid;
>+	const char *namespace;
> 	unsigned int weak:1;
> 	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
> 	unsigned int kernel:1;     /* 1 if symbol is from kernel
>@@ -233,6 +234,37 @@ static struct symbol *find_symbol(const char *name)
> 	return NULL;
> }
>
>+static bool contains_namespace(struct namespace_list *list,
>+			       const char *namespace)
>+{
>+	struct namespace_list *ns_entry;
>+
>+	for (ns_entry = list; ns_entry != NULL; ns_entry = ns_entry->next)
>+		if (strcmp(ns_entry->namespace, namespace) == 0)
>+			return true;
>+
>+	return false;
>+}
>+
>+static void add_namespace(struct namespace_list **list, const char *namespace)
>+{
>+	struct namespace_list *ns_entry;
>+
>+	if (!contains_namespace(*list, namespace)) {
>+		ns_entry = NOFAIL(malloc(sizeof(struct namespace_list) +
>+					 strlen(namespace) + 1));
>+		strcpy(ns_entry->namespace, namespace);
>+		ns_entry->next = *list;
>+		*list = ns_entry;
>+	}
>+}
>+
>+static bool module_imports_namespace(struct module *module,
>+				     const char *namespace)
>+{
>+	return contains_namespace(module->imported_namespaces, namespace);
>+}
>+
> static const struct {
> 	const char *str;
> 	enum export export;
>@@ -312,6 +344,22 @@ static enum export export_from_sec(struct elf_info *elf, unsigned int sec)
> 		return export_unknown;
> }
>
>+static const char *sym_extract_namespace(const char **symname)
>+{
>+	size_t n;
>+	char *dupsymname;
>+
>+	n = strcspn(*symname, ".");
>+	if (n < strlen(*symname) - 1) {
>+		dupsymname = NOFAIL(strdup(*symname));
>+		dupsymname[n] = '\0';
>+		*symname = dupsymname;
>+		return dupsymname + n + 1;
>+	}
>+
>+	return NULL;
>+}
>+
> /**
>  * Add an exported symbol - it may have already been added without a
>  * CRC, in this case just update the CRC
>@@ -319,16 +367,18 @@ static enum export export_from_sec(struct elf_info *elf, unsigned int sec)
> static struct symbol *sym_add_exported(const char *name, struct module *mod,
> 				       enum export export)
> {
>-	struct symbol *s = find_symbol(name);
>+	const char *symbol_name = name;
>+	const char *namespace = sym_extract_namespace(&symbol_name);
>+	struct symbol *s = find_symbol(symbol_name);
>
> 	if (!s) {
>-		s = new_symbol(name, mod, export);
>+		s = new_symbol(symbol_name, mod, export);
>+		s->namespace = namespace;
> 	} else {
> 		if (!s->preloaded) {
>-			warn("%s: '%s' exported twice. Previous export "
>-			     "was in %s%s\n", mod->name, name,
>-			     s->module->name,
>-			     is_vmlinux(s->module->name) ?"":".ko");
>+			warn("%s: '%s' exported twice. Previous export was in %s%s\n",
>+			     mod->name, symbol_name, s->module->name,
>+			     is_vmlinux(s->module->name) ? "" : ".ko");
> 		} else {
> 			/* In case Module.symvers was out of date */
> 			s->module = mod;
>@@ -1943,6 +1993,7 @@ static void read_symbols(const char *modname)
> 	const char *symname;
> 	char *version;
> 	char *license;
>+	char *namespace;
> 	struct module *mod;
> 	struct elf_info info = { };
> 	Elf_Sym *sym;
>@@ -1974,6 +2025,12 @@ static void read_symbols(const char *modname)
> 		license = get_next_modinfo(&info, "license", license);
> 	}
>
>+	namespace = get_modinfo(&info, "import_ns");
>+	while (namespace) {
>+		add_namespace(&mod->imported_namespaces, namespace);
>+		namespace = get_next_modinfo(&info, "import_ns", namespace);
>+	}
>+
> 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
> 		symname = remove_dot(info.strtab + sym->st_name);
>
>@@ -2118,6 +2175,13 @@ static int check_exports(struct module *mod)
> 			basename++;
> 		else
> 			basename = mod->name;
>+
>+		if (exp->namespace &&
>+		    !module_imports_namespace(mod, exp->namespace)) {
>+			warn("module %s uses symbol %s from namespace %s, but does not import it.\n",
>+			     basename, exp->name, exp->namespace);
>+		}
>+
> 		if (!mod->gpl_compatible)
> 			check_for_gpl_usage(exp->export, basename, exp->name);
> 		check_for_unused(exp->export, basename, exp->name);
>@@ -2395,16 +2459,21 @@ static void write_dump(const char *fname)
> {
> 	struct buffer buf = { };
> 	struct symbol *symbol;
>+	const char *namespace;
> 	int n;
>
> 	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
> 		symbol = symbolhash[n];
> 		while (symbol) {
>-			if (dump_sym(symbol))
>-				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\n",
>-					symbol->crc, symbol->name,
>-					symbol->module->name,
>-					export_str(symbol->export));
>+			if (dump_sym(symbol)) {
>+				namespace = symbol->namespace;
>+				buf_printf(&buf, "0x%08x\t%s%s%s\t%s\t%s\n",
>+					   symbol->crc, symbol->name,
>+					   namespace ? "." : "",
>+					   namespace ? namespace : "",

I think it might be cleaner to just have namespace be a separate
field in Module.symvers, rather than appending a dot and the
namespace at the end of a symbol name. Maybe something like

    <crc> <symbol_name> <namespace> <module>

For symbols without a namespace, we could just have "", with all
fields delimited by tabs. This is just a stylistic suggestion, what do
you think?

Regardless of the chosen format, I think we need to document how
namespaces are represented in Documentation/kbuild/modules.rst, where
it describes the Module.symvers format.

Thanks!

Jessica

>+					   symbol->module->name,
>+					   export_str(symbol->export));
>+			}
> 			symbol = symbol->next;
> 		}
> 	}
>diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
>index 8453d6ac2f77..9626bf3e7424 100644
>--- a/scripts/mod/modpost.h
>+++ b/scripts/mod/modpost.h
>@@ -109,6 +109,11 @@ buf_printf(struct buffer *buf, const char *fmt, ...);
> void
> buf_write(struct buffer *buf, const char *s, int len);
>
>+struct namespace_list {
>+	struct namespace_list *next;
>+	char namespace[0];
>+};
>+
> struct module {
> 	struct module *next;
> 	const char *name;
>@@ -121,6 +126,8 @@ struct module {
> 	struct buffer dev_table_buf;
> 	char	     srcversion[25];
> 	int is_dot_o;
>+	// Actual imported namespaces
>+	struct namespace_list *imported_namespaces;
> };
>
> struct elf_info {
>-- 
>2.23.0.rc1.153.gdeed80330f-goog
>
