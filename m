Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB579EF13
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfH0Phb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 11:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfH0Pha (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Aug 2019 11:37:30 -0400
Received: from linux-8ccs.fritz.box (unknown [92.117.134.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C4C20828;
        Tue, 27 Aug 2019 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566920248;
        bh=EVLmA6X4q3kOLjr2Olj2VbvDBZBfODkjU6EBVbbEqIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffw9NlrvdkKNxlnJcMdUOeNFtEAX8rVktWxtJ1w/nI69cL1ujixJHyZGlNU8Kwtsk
         dMTGNRAK07vybtYjIA6VoDyyfMpgBgZKCaSP8q2GY43c5YixEH9Fq5i7C315W8rlLK
         Jp60s9VfT2H9aX6E+cqI+zfjukN8pavP4+5/OhBk=
Date:   Tue, 27 Aug 2019 17:37:18 +0200
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
        x86@kernel.org, yamada.masahiro@socionext.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 03/11] module: add support for symbol namespaces.
Message-ID: <20190827153717.GA20822@linux-8ccs.fritz.box>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-4-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821114955.12788-4-maennich@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Matthias Maennich [21/08/19 12:49 +0100]:
>The EXPORT_SYMBOL_NS() and EXPORT_SYMBOL_NS_GPL() macros can be used to
>export a symbol to a specific namespace.  There are no _GPL_FUTURE and
>_UNUSED variants because these are currently unused, and I'm not sure
>they are necessary.
>
>I didn't add EXPORT_SYMBOL_NS() for ASM exports; this patch sets the
>namespace of ASM exports to NULL by default. In case of relative
>references, it will be relocatable to NULL. If there's a need, this
>should be pretty easy to add.
>
>A module that wants to use a symbol exported to a namespace must add a
>MODULE_IMPORT_NS() statement to their module code; otherwise, modpost
>will complain when building the module, and the kernel module loader
>will emit an error and fail when loading the module.
>
>MODULE_IMPORT_NS() adds a modinfo tag 'import_ns' to the module. That
>tag can be observed by the modinfo command, modpost and kernel/module.c
>at the time of loading the module.
>
>The ELF symbols are renamed to include the namespace with an asm label;
>for example, symbol 'usb_stor_suspend' in namespace USB_STORAGE becomes
>'usb_stor_suspend.USB_STORAGE'.  This allows modpost to do namespace
>checking, without having to go through all the effort of parsing ELF and
>relocation records just to get to the struct kernel_symbols.
>
>On x86_64 I saw no difference in binary size (compression), but at
>runtime this will require a word of memory per export to hold the
>namespace. An alternative could be to store namespaced symbols in their
>own section and use a separate 'struct namespaced_kernel_symbol' for
>that section, at the cost of making the module loader more complex.
>
>Co-developed-by: Martijn Coenen <maco@android.com>
>Signed-off-by: Martijn Coenen <maco@android.com>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Matthias Maennich <maennich@google.com>
>---
> include/asm-generic/export.h |  6 +--
> include/linux/export.h       | 85 ++++++++++++++++++++++++++++++------
> include/linux/module.h       |  2 +
> kernel/module.c              | 43 ++++++++++++++++++
> 4 files changed, 120 insertions(+), 16 deletions(-)
>
>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>index 63f54907317b..e2b5d0f569d3 100644
>--- a/include/asm-generic/export.h
>+++ b/include/asm-generic/export.h
>@@ -17,11 +17,11 @@
>
> .macro __put, val, name
> #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>-	.long	\val - ., \name - .
>+	.long	\val - ., \name - ., 0 - .
> #elif defined(CONFIG_64BIT)
>-	.quad	\val, \name
>+	.quad	\val, \name, 0
> #else
>-	.long	\val, \name
>+	.long	\val, \name, 0
> #endif
> .endm
>
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 28a4d2150689..8e12e05444d1 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -20,6 +20,8 @@ extern struct module __this_module;
>
> #ifdef CONFIG_MODULES
>
>+#define NS_SEPARATOR "."
>+
> #if defined(__KERNEL__) && !defined(__GENKSYMS__)
> #ifdef CONFIG_MODVERSIONS
> /* Mark the CRC weak since genksyms apparently decides not to
>@@ -49,6 +51,16 @@ extern struct module __this_module;
>  * absolute relocations that require runtime processing on relocatable
>  * kernels.
>  */
>+#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
>+	__ADDRESSABLE(sym)						\
>+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
>+	    "	.balign	4					\n"	\
>+	    "__ksymtab_" #sym NS_SEPARATOR #ns ":		\n"	\
>+	    "	.long	" #sym "- .				\n"	\
>+	    "	.long	__kstrtab_" #sym "- .			\n"	\
>+	    "	.long	__kstrtab_ns_" #sym "- .		\n"	\
>+	    "	.previous					\n")
>+
> #define __KSYMTAB_ENTRY(sym, sec)					\
> 	__ADDRESSABLE(sym)						\
> 	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
>@@ -56,32 +68,53 @@ extern struct module __this_module;
> 	    "__ksymtab_" #sym ":				\n"	\
> 	    "	.long	" #sym "- .				\n"	\
> 	    "	.long	__kstrtab_" #sym "- .			\n"	\
>+	    "	.long	0 - .					\n"	\
> 	    "	.previous					\n")
>
> struct kernel_symbol {
> 	int value_offset;
> 	int name_offset;
>+	int namespace_offset;
> };
> #else
>+#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
>+	static const struct kernel_symbol __ksymtab_##sym##__##ns	\
>+	asm("__ksymtab_" #sym NS_SEPARATOR #ns)				\
>+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
>+	__aligned(sizeof(void *))					\
>+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtab_ns_##sym}

Style nit: missing space after __kstrtab_ns_##sym.

>+
> #define __KSYMTAB_ENTRY(sym, sec)					\
> 	static const struct kernel_symbol __ksymtab_##sym		\
>+	asm("__ksymtab_" #sym)						\
> 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
> 	__aligned(sizeof(void *))					\
>-	= { (unsigned long)&sym, __kstrtab_##sym }
>+	= { (unsigned long)&sym, __kstrtab_##sym, NULL }
>
> struct kernel_symbol {
> 	unsigned long value;
> 	const char *name;
>+	const char *namespace;
> };
> #endif
>
>-/* For every exported symbol, place a struct in the __ksymtab section */
>-#define ___EXPORT_SYMBOL(sym, sec)					\
>+#define ___export_symbol_common(sym, sec)				\
> 	extern typeof(sym) sym;						\
> 	__CRC_SYMBOL(sym, sec)						\
> 	static const char __kstrtab_##sym[]				\
> 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
>-	= #sym;								\
>+	= #sym								\

Any particular reason for this change? Not that it's important, just
noticing the inconsistent inclusion of the semicolon in some of the
macros (e.g. __CRC_SYMBOL includes it but __export_symbol_common doesn't).

>+
>+/* For every exported symbol, place a struct in the __ksymtab section */
>+#define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
>+	___export_symbol_common(sym, sec);			\
>+	static const char __kstrtab_ns_##sym[]				\
>+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
>+	= #ns;								\
>+	__KSYMTAB_ENTRY_NS(sym, sec, ns)
>+
>+#define ___EXPORT_SYMBOL(sym, sec)					\
>+	___export_symbol_common(sym, sec);				\
> 	__KSYMTAB_ENTRY(sym, sec)
>
> #if defined(__DISABLE_EXPORTS)
>@@ -91,6 +124,7 @@ struct kernel_symbol {
>  * be reused in other execution contexts such as the UEFI stub or the
>  * decompressor.
>  */
>+#define __EXPORT_SYMBOL_NS(sym, sec, ns)
> #define __EXPORT_SYMBOL(sym, sec)
>
> #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
>@@ -117,18 +151,26 @@ struct kernel_symbol {
> #define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
> #define __cond_export_sym_0(sym, sec) /* nothing */
>
>+#define __EXPORT_SYMBOL_NS(sym, sec, ns)				\
>+	__ksym_marker(sym);						\
>+	__cond_export_ns_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
>+#define __cond_export_ns_sym(sym, sec, ns, conf)			\
>+	___cond_export_ns_sym(sym, sec, ns, conf)
>+#define ___cond_export_ns_sym(sym, sec, ns, enabled)			\
>+	__cond_export_ns_sym_##enabled(sym, sec, ns)
>+#define __cond_export_ns_sym_1(sym, sec, ns) ___EXPORT_SYMBOL_NS(sym, sec, ns)
>+#define __cond_export_ns_sym_0(sym, sec, ns) /* nothing */
>+
> #else
>+#define __EXPORT_SYMBOL_NS ___EXPORT_SYMBOL_NS
> #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
> #endif
>
>-#define EXPORT_SYMBOL(sym)					\
>-	__EXPORT_SYMBOL(sym, "")
>-
>-#define EXPORT_SYMBOL_GPL(sym)					\
>-	__EXPORT_SYMBOL(sym, "_gpl")
>-
>-#define EXPORT_SYMBOL_GPL_FUTURE(sym)				\
>-	__EXPORT_SYMBOL(sym, "_gpl_future")
>+#define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
>+#define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
>+#define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
>+#define EXPORT_SYMBOL_NS(sym, ns) __EXPORT_SYMBOL_NS(sym, "", ns)
>+#define EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL_NS(sym, "_gpl", ns)
>
> #ifdef CONFIG_UNUSED_SYMBOLS
> #define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
>@@ -138,11 +180,28 @@ struct kernel_symbol {
> #define EXPORT_UNUSED_SYMBOL_GPL(sym)
> #endif
>
>-#endif	/* __GENKSYMS__ */
>+#endif	/* __KERNEL__ && !__GENKSYMS__ */
>+
>+#if defined(__GENKSYMS__)
>+/*
>+ * When we're running genksyms, ignore the namespace and make the _NS
>+ * variants look like the normal ones. There are two reasons for this:
>+ * 1) In the normal definition of EXPORT_SYMBOL_NS, the 'ns' macro
>+ *    argument is itself not expanded because it's always tokenized or
>+ *    concatenated; but when running genksyms, a blank definition of the
>+ *    macro does allow the argument to be expanded; if a namespace
>+ *    happens to collide with a #define, this can cause issues.
>+ * 2) There's no need to modify genksyms to deal with the _NS variants
>+ */
>+#define EXPORT_SYMBOL_NS(sym, ns) EXPORT_SYMBOL(sym)
>+#define EXPORT_SYMBOL_NS_GPL(sym, ns) EXPORT_SYMBOL_GPL(sym)
>+#endif
>
> #else /* !CONFIG_MODULES... */
>
> #define EXPORT_SYMBOL(sym)
>+#define EXPORT_SYMBOL_NS(sym, ns)
>+#define EXPORT_SYMBOL_NS_GPL(sym, ns)
> #define EXPORT_SYMBOL_GPL(sym)
> #define EXPORT_SYMBOL_GPL_FUTURE(sym)
> #define EXPORT_UNUSED_SYMBOL(sym)
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 1455812dd325..b3611e749f72 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -280,6 +280,8 @@ struct notifier_block;
>
> #ifdef CONFIG_MODULES
>
>+#define MODULE_IMPORT_NS(ns) MODULE_INFO(import_ns, #ns)
>+
> extern int modules_disabled; /* for sysctl */
> /* Get/put a kernel symbol (calls must be symmetric) */
> void *__symbol_get(const char *symbol);
>diff --git a/kernel/module.c b/kernel/module.c
>index a23067907169..57e8253f2251 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -544,6 +544,15 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
> #endif
> }
>
>+static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
>+{
>+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>+	return offset_to_ptr(&sym->namespace_offset);
>+#else
>+	return sym->namespace;
>+#endif
>+}
>+
> static int cmp_name(const void *va, const void *vb)
> {
> 	const char *a;
>@@ -1379,6 +1388,34 @@ static inline int same_magic(const char *amagic, const char *bmagic,
> }
> #endif /* CONFIG_MODVERSIONS */
>
>+static char *get_modinfo(const struct load_info *info, const char *tag);
>+static char *get_next_modinfo(const struct load_info *info, const char *tag,
>+			      char *prev);
>+
>+static int verify_namespace_is_imported(const struct load_info *info,
>+					const struct kernel_symbol *sym,
>+					struct module *mod)
>+{
>+	const char *namespace;
>+	char *imported_namespace;
>+
>+	namespace = kernel_symbol_namespace(sym);
>+	if (namespace) {
>+		imported_namespace = get_modinfo(info, "import_ns");
>+		while (imported_namespace) {
>+			if (strcmp(namespace, imported_namespace) == 0)
>+				return 0;
>+			imported_namespace = get_next_modinfo(
>+				info, "import_ns", imported_namespace);
>+		}
>+		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
>+		       mod->name, kernel_symbol_name(sym), namespace);
>+		return -EINVAL;
>+	}
>+	return 0;
>+}
>+
>+
> /* Resolve a symbol for this module.  I.e. if we find one, record usage. */
> static const struct kernel_symbol *resolve_symbol(struct module *mod,
> 						  const struct load_info *info,
>@@ -1413,6 +1450,12 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
> 		goto getname;
> 	}
>
>+	err = verify_namespace_is_imported(info, sym, mod);
>+	if (err) {
>+		sym = ERR_PTR(err);
>+		goto getname;
>+	}

I think we should verify the namespace before taking a reference to
the owner module (just swap the verify_namespace_is_imported() and
ref_module() calls here).

Other than that, this patch looks good. Thanks!

>+
> getname:
> 	/* We must make copy under the lock if we failed to get ref. */
> 	strncpy(ownername, module_name(owner), MODULE_NAME_LEN);
>-- 
>2.23.0.rc1.153.gdeed80330f-goog
>
