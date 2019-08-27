Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2579EFA4
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfH0QEV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 12:04:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37851 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfH0QET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Aug 2019 12:04:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so19395521wrt.4
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2019 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ljo8vajhU+W+Ukm/1s/QogI8ChcEKwBtMF+HxQ/PSw4=;
        b=pT3W2hD1RvsxoHm+zEZ/U6mTjDjviLu6X1btSRz1uz2E9GHokFjUxdkKJCkelWSu1u
         bpsj+wb5B6JYz//IC3AJ6ouZyEZgJdlwwF6WDqsHH3ahgA8vcdWT4W/9xu7zdEG9s8qw
         6YYPisKqXJMWOxmAPFSpZbqj3Mqo6VgzJLMoNoUPgAsdZy50h91qvJUGl+EWU6seNtoE
         7XxfupdQWUnuD+7YbCsN8fUevv8I+NVGUpKV1eowgsWqw/lXmQJFsTn2+I7V+UXJ8PvZ
         bC5kOIFz6/b3Rl9M6hYx1ow323QKUjSZBAJCIxSLL+RwJ2YznMMzYF/epQHhNd/rqDV1
         yA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ljo8vajhU+W+Ukm/1s/QogI8ChcEKwBtMF+HxQ/PSw4=;
        b=aXNJxE9X1fmUiygu1i/CEdZ1lqzlQ5/Ivu71NjNHqwoJvc6LkEP3/2LVUn5D8jG2Za
         XrD/BJkG7FDGMkKtXAp26o0vk1KbbNYHibXh4sL+q/+Sa/QQQHdGzCNxhFQocQLGIzuJ
         r7AaMp7BIRjoCc4RDly6RJSP/cNrz+x3rEXdZdZzKButxKMYot9+cRjVUP2g1b23E9Gk
         pDVZprY0WUSFELIeNWZdoMrEIjw1NSRQXl/ScjbnezVG5TmrrIv83gXKwKy7YlmInFva
         CHudBqAWIqYqirJKm864zvwzWCrkEFMzGOSK7hmyzfMkMKOp3BpXJFM5lKoLDObz9jMa
         sSfg==
X-Gm-Message-State: APjAAAXpWJNbiRVt6IAsT15kas/QwFLjSBM0GI+Ap2EfQWTl61koHnrG
        vImYv+TS5uhBEla90e7uJkRpOg==
X-Google-Smtp-Source: APXvYqyCAay58gtSIUr78MGmhxH+wCfTtE99gWMRLBFHY3CeeAgj7Z5U0wI2K44F8jvEfOo444iNTA==
X-Received: by 2002:a5d:50cb:: with SMTP id f11mr30096307wrt.277.1566921857187;
        Tue, 27 Aug 2019 09:04:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id i93sm32304192wri.57.2019.08.27.09.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:04:16 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:04:13 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
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
Message-ID: <20190827160413.GA148206@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-4-maennich@google.com>
 <20190827153717.GA20822@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190827153717.GA20822@linux-8ccs.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 27, 2019 at 05:37:18PM +0200, Jessica Yu wrote:
>+++ Matthias Maennich [21/08/19 12:49 +0100]:
>>The EXPORT_SYMBOL_NS() and EXPORT_SYMBOL_NS_GPL() macros can be used to
>>export a symbol to a specific namespace.  There are no _GPL_FUTURE and
>>_UNUSED variants because these are currently unused, and I'm not sure
>>they are necessary.
>>
>>I didn't add EXPORT_SYMBOL_NS() for ASM exports; this patch sets the
>>namespace of ASM exports to NULL by default. In case of relative
>>references, it will be relocatable to NULL. If there's a need, this
>>should be pretty easy to add.
>>
>>A module that wants to use a symbol exported to a namespace must add a
>>MODULE_IMPORT_NS() statement to their module code; otherwise, modpost
>>will complain when building the module, and the kernel module loader
>>will emit an error and fail when loading the module.
>>
>>MODULE_IMPORT_NS() adds a modinfo tag 'import_ns' to the module. That
>>tag can be observed by the modinfo command, modpost and kernel/module.c
>>at the time of loading the module.
>>
>>The ELF symbols are renamed to include the namespace with an asm label;
>>for example, symbol 'usb_stor_suspend' in namespace USB_STORAGE becomes
>>'usb_stor_suspend.USB_STORAGE'.  This allows modpost to do namespace
>>checking, without having to go through all the effort of parsing ELF and
>>relocation records just to get to the struct kernel_symbols.
>>
>>On x86_64 I saw no difference in binary size (compression), but at
>>runtime this will require a word of memory per export to hold the
>>namespace. An alternative could be to store namespaced symbols in their
>>own section and use a separate 'struct namespaced_kernel_symbol' for
>>that section, at the cost of making the module loader more complex.
>>
>>Co-developed-by: Martijn Coenen <maco@android.com>
>>Signed-off-by: Martijn Coenen <maco@android.com>
>>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>Signed-off-by: Matthias Maennich <maennich@google.com>
>>---
>>include/asm-generic/export.h |  6 +--
>>include/linux/export.h       | 85 ++++++++++++++++++++++++++++++------
>>include/linux/module.h       |  2 +
>>kernel/module.c              | 43 ++++++++++++++++++
>>4 files changed, 120 insertions(+), 16 deletions(-)
>>
>>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>>index 63f54907317b..e2b5d0f569d3 100644
>>--- a/include/asm-generic/export.h
>>+++ b/include/asm-generic/export.h
>>@@ -17,11 +17,11 @@
>>
>>.macro __put, val, name
>>#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>-	.long	\val - ., \name - .
>>+	.long	\val - ., \name - ., 0 - .
>>#elif defined(CONFIG_64BIT)
>>-	.quad	\val, \name
>>+	.quad	\val, \name, 0
>>#else
>>-	.long	\val, \name
>>+	.long	\val, \name, 0
>>#endif
>>.endm
>>
>>diff --git a/include/linux/export.h b/include/linux/export.h
>>index 28a4d2150689..8e12e05444d1 100644
>>--- a/include/linux/export.h
>>+++ b/include/linux/export.h
>>@@ -20,6 +20,8 @@ extern struct module __this_module;
>>
>>#ifdef CONFIG_MODULES
>>
>>+#define NS_SEPARATOR "."
>>+
>>#if defined(__KERNEL__) && !defined(__GENKSYMS__)
>>#ifdef CONFIG_MODVERSIONS
>>/* Mark the CRC weak since genksyms apparently decides not to
>>@@ -49,6 +51,16 @@ extern struct module __this_module;
>> * absolute relocations that require runtime processing on relocatable
>> * kernels.
>> */
>>+#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
>>+	__ADDRESSABLE(sym)						\
>>+	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
>>+	    "	.balign	4					\n"	\
>>+	    "__ksymtab_" #sym NS_SEPARATOR #ns ":		\n"	\
>>+	    "	.long	" #sym "- .				\n"	\
>>+	    "	.long	__kstrtab_" #sym "- .			\n"	\
>>+	    "	.long	__kstrtab_ns_" #sym "- .		\n"	\
>>+	    "	.previous					\n")
>>+
>>#define __KSYMTAB_ENTRY(sym, sec)					\
>>	__ADDRESSABLE(sym)						\
>>	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
>>@@ -56,32 +68,53 @@ extern struct module __this_module;
>>	    "__ksymtab_" #sym ":				\n"	\
>>	    "	.long	" #sym "- .				\n"	\
>>	    "	.long	__kstrtab_" #sym "- .			\n"	\
>>+	    "	.long	0 - .					\n"	\
>>	    "	.previous					\n")
>>
>>struct kernel_symbol {
>>	int value_offset;
>>	int name_offset;
>>+	int namespace_offset;
>>};
>>#else
>>+#define __KSYMTAB_ENTRY_NS(sym, sec, ns)				\
>>+	static const struct kernel_symbol __ksymtab_##sym##__##ns	\
>>+	asm("__ksymtab_" #sym NS_SEPARATOR #ns)				\
>>+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
>>+	__aligned(sizeof(void *))					\
>>+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtab_ns_##sym}
>
>Style nit: missing space after __kstrtab_ns_##sym.
>
>>+
>>#define __KSYMTAB_ENTRY(sym, sec)					\
>>	static const struct kernel_symbol __ksymtab_##sym		\
>>+	asm("__ksymtab_" #sym)						\
>>	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
>>	__aligned(sizeof(void *))					\
>>-	= { (unsigned long)&sym, __kstrtab_##sym }
>>+	= { (unsigned long)&sym, __kstrtab_##sym, NULL }
>>
>>struct kernel_symbol {
>>	unsigned long value;
>>	const char *name;
>>+	const char *namespace;
>>};
>>#endif
>>
>>-/* For every exported symbol, place a struct in the __ksymtab section */
>>-#define ___EXPORT_SYMBOL(sym, sec)					\
>>+#define ___export_symbol_common(sym, sec)				\
>>	extern typeof(sym) sym;						\
>>	__CRC_SYMBOL(sym, sec)						\
>>	static const char __kstrtab_##sym[]				\
>>	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
>>-	= #sym;								\
>>+	= #sym								\
>
>Any particular reason for this change? Not that it's important, just
>noticing the inconsistent inclusion of the semicolon in some of the
>macros (e.g. __CRC_SYMBOL includes it but __export_symbol_common doesn't).
>

I tried to be consistent to let the macro "call site" provide the final
semicolon. And you are right, I could have adjusted __CRC_SYMBOL as
well. I will adjust this for the next version.

>>+
>>+/* For every exported symbol, place a struct in the __ksymtab section */
>>+#define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
>>+	___export_symbol_common(sym, sec);			\
>>+	static const char __kstrtab_ns_##sym[]				\
>>+	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
>>+	= #ns;								\
>>+	__KSYMTAB_ENTRY_NS(sym, sec, ns)
>>+
>>+#define ___EXPORT_SYMBOL(sym, sec)					\
>>+	___export_symbol_common(sym, sec);				\
>>	__KSYMTAB_ENTRY(sym, sec)
>>
>>#if defined(__DISABLE_EXPORTS)
>>@@ -91,6 +124,7 @@ struct kernel_symbol {
>> * be reused in other execution contexts such as the UEFI stub or the
>> * decompressor.
>> */
>>+#define __EXPORT_SYMBOL_NS(sym, sec, ns)
>>#define __EXPORT_SYMBOL(sym, sec)
>>
>>#elif defined(CONFIG_TRIM_UNUSED_KSYMS)
>>@@ -117,18 +151,26 @@ struct kernel_symbol {
>>#define __cond_export_sym_1(sym, sec) ___EXPORT_SYMBOL(sym, sec)
>>#define __cond_export_sym_0(sym, sec) /* nothing */
>>
>>+#define __EXPORT_SYMBOL_NS(sym, sec, ns)				\
>>+	__ksym_marker(sym);						\
>>+	__cond_export_ns_sym(sym, sec, ns, __is_defined(__KSYM_##sym))
>>+#define __cond_export_ns_sym(sym, sec, ns, conf)			\
>>+	___cond_export_ns_sym(sym, sec, ns, conf)
>>+#define ___cond_export_ns_sym(sym, sec, ns, enabled)			\
>>+	__cond_export_ns_sym_##enabled(sym, sec, ns)
>>+#define __cond_export_ns_sym_1(sym, sec, ns) ___EXPORT_SYMBOL_NS(sym, sec, ns)
>>+#define __cond_export_ns_sym_0(sym, sec, ns) /* nothing */
>>+
>>#else
>>+#define __EXPORT_SYMBOL_NS ___EXPORT_SYMBOL_NS
>>#define __EXPORT_SYMBOL ___EXPORT_SYMBOL
>>#endif
>>
>>-#define EXPORT_SYMBOL(sym)					\
>>-	__EXPORT_SYMBOL(sym, "")
>>-
>>-#define EXPORT_SYMBOL_GPL(sym)					\
>>-	__EXPORT_SYMBOL(sym, "_gpl")
>>-
>>-#define EXPORT_SYMBOL_GPL_FUTURE(sym)				\
>>-	__EXPORT_SYMBOL(sym, "_gpl_future")
>>+#define EXPORT_SYMBOL(sym) __EXPORT_SYMBOL(sym, "")
>>+#define EXPORT_SYMBOL_GPL(sym) __EXPORT_SYMBOL(sym, "_gpl")
>>+#define EXPORT_SYMBOL_GPL_FUTURE(sym) __EXPORT_SYMBOL(sym, "_gpl_future")
>>+#define EXPORT_SYMBOL_NS(sym, ns) __EXPORT_SYMBOL_NS(sym, "", ns)
>>+#define EXPORT_SYMBOL_NS_GPL(sym, ns) __EXPORT_SYMBOL_NS(sym, "_gpl", ns)
>>
>>#ifdef CONFIG_UNUSED_SYMBOLS
>>#define EXPORT_UNUSED_SYMBOL(sym) __EXPORT_SYMBOL(sym, "_unused")
>>@@ -138,11 +180,28 @@ struct kernel_symbol {
>>#define EXPORT_UNUSED_SYMBOL_GPL(sym)
>>#endif
>>
>>-#endif	/* __GENKSYMS__ */
>>+#endif	/* __KERNEL__ && !__GENKSYMS__ */
>>+
>>+#if defined(__GENKSYMS__)
>>+/*
>>+ * When we're running genksyms, ignore the namespace and make the _NS
>>+ * variants look like the normal ones. There are two reasons for this:
>>+ * 1) In the normal definition of EXPORT_SYMBOL_NS, the 'ns' macro
>>+ *    argument is itself not expanded because it's always tokenized or
>>+ *    concatenated; but when running genksyms, a blank definition of the
>>+ *    macro does allow the argument to be expanded; if a namespace
>>+ *    happens to collide with a #define, this can cause issues.
>>+ * 2) There's no need to modify genksyms to deal with the _NS variants
>>+ */
>>+#define EXPORT_SYMBOL_NS(sym, ns) EXPORT_SYMBOL(sym)
>>+#define EXPORT_SYMBOL_NS_GPL(sym, ns) EXPORT_SYMBOL_GPL(sym)
>>+#endif
>>
>>#else /* !CONFIG_MODULES... */
>>
>>#define EXPORT_SYMBOL(sym)
>>+#define EXPORT_SYMBOL_NS(sym, ns)
>>+#define EXPORT_SYMBOL_NS_GPL(sym, ns)
>>#define EXPORT_SYMBOL_GPL(sym)
>>#define EXPORT_SYMBOL_GPL_FUTURE(sym)
>>#define EXPORT_UNUSED_SYMBOL(sym)
>>diff --git a/include/linux/module.h b/include/linux/module.h
>>index 1455812dd325..b3611e749f72 100644
>>--- a/include/linux/module.h
>>+++ b/include/linux/module.h
>>@@ -280,6 +280,8 @@ struct notifier_block;
>>
>>#ifdef CONFIG_MODULES
>>
>>+#define MODULE_IMPORT_NS(ns) MODULE_INFO(import_ns, #ns)
>>+
>>extern int modules_disabled; /* for sysctl */
>>/* Get/put a kernel symbol (calls must be symmetric) */
>>void *__symbol_get(const char *symbol);
>>diff --git a/kernel/module.c b/kernel/module.c
>>index a23067907169..57e8253f2251 100644
>>--- a/kernel/module.c
>>+++ b/kernel/module.c
>>@@ -544,6 +544,15 @@ static const char *kernel_symbol_name(const struct kernel_symbol *sym)
>>#endif
>>}
>>
>>+static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
>>+{
>>+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>+	return offset_to_ptr(&sym->namespace_offset);
>>+#else
>>+	return sym->namespace;
>>+#endif
>>+}
>>+
>>static int cmp_name(const void *va, const void *vb)
>>{
>>	const char *a;
>>@@ -1379,6 +1388,34 @@ static inline int same_magic(const char *amagic, const char *bmagic,
>>}
>>#endif /* CONFIG_MODVERSIONS */
>>
>>+static char *get_modinfo(const struct load_info *info, const char *tag);
>>+static char *get_next_modinfo(const struct load_info *info, const char *tag,
>>+			      char *prev);
>>+
>>+static int verify_namespace_is_imported(const struct load_info *info,
>>+					const struct kernel_symbol *sym,
>>+					struct module *mod)
>>+{
>>+	const char *namespace;
>>+	char *imported_namespace;
>>+
>>+	namespace = kernel_symbol_namespace(sym);
>>+	if (namespace) {
>>+		imported_namespace = get_modinfo(info, "import_ns");
>>+		while (imported_namespace) {
>>+			if (strcmp(namespace, imported_namespace) == 0)
>>+				return 0;
>>+			imported_namespace = get_next_modinfo(
>>+				info, "import_ns", imported_namespace);
>>+		}
>>+		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
>>+		       mod->name, kernel_symbol_name(sym), namespace);
>>+		return -EINVAL;
>>+	}
>>+	return 0;
>>+}
>>+
>>+
>>/* Resolve a symbol for this module.  I.e. if we find one, record usage. */
>>static const struct kernel_symbol *resolve_symbol(struct module *mod,
>>						  const struct load_info *info,
>>@@ -1413,6 +1450,12 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
>>		goto getname;
>>	}
>>
>>+	err = verify_namespace_is_imported(info, sym, mod);
>>+	if (err) {
>>+		sym = ERR_PTR(err);
>>+		goto getname;
>>+	}
>
>I think we should verify the namespace before taking a reference to
>the owner module (just swap the verify_namespace_is_imported() and
>ref_module() calls here).
>
>Other than that, this patch looks good. Thanks!
>

Thanks! I will address the points above.

Cheers,
Matthias

>>+
>>getname:
>>	/* We must make copy under the lock if we failed to get ref. */
>>	strncpy(ownername, module_name(owner), MODULE_NAME_LEN);
>>-- 
>>2.23.0.rc1.153.gdeed80330f-goog
>>
