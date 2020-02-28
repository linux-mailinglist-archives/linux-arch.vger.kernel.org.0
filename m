Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28CF172F2D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 04:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgB1DLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 22:11:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgB1DLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 22:11:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so660768plb.0;
        Thu, 27 Feb 2020 19:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eB1vvqIqQQMx5GjUi6UwwjoWmVq67cb1g3NN4JBn8/A=;
        b=t8gVKHYG8CqkBzOoYKVBon4w2SJ1FgqUO5ln+3z0ycf60e3zDIY6YeCb9l0VW4KICA
         JwSo8+JLhXk7n7nsqit8M1iy08/5wbhVm8cJTrYwNRNMJmN2edkiKshAzEgLUB5+MpyO
         HaDJ7iiBfMY0CwHTdEoEQcR9OzMg7h72Ds2DT0mHbXWn1I+P7M90TOYxsSQLreMr7s2n
         Kbut/NUjjhX6+9rN+vfuJT3Zpp+jY7r4zwy9eUtzllhxiLrqKvuIQB8kJcEiNEl4jwzr
         PqKhsfn1gtRP5pYkvaMJ8JZteMmrjzaeE2ju2of2o/WP9u8ZV8/2G9BkttcUzt1IQ/SJ
         1d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eB1vvqIqQQMx5GjUi6UwwjoWmVq67cb1g3NN4JBn8/A=;
        b=h9/NhX5sTXymsQI7+OgnsePZZ5EFM2CmHP8zD2+t1YNeYtjPUzkKE7qmPk0TXW//tW
         mGBa8Rv9LvSkDaxNFUjcnZC0e0O5I4ck7gyklsrjRAb6HtFw6Zing5zLSQFxSdGM+T/P
         ITzu0Wshfvj94Jv9l32Mj3Rr7ly90Es2swwxqGzVEFWvI/pALn1FLmb6T0bJeiDXV+Iu
         UDQctGPV2rJzrCztch8g+7unYgZPpuEhO+AfhQG5fudl7n5KlNQiEjejgwOZ5gw61Zjq
         rKPRJ0GrKPqioUGPZjqmH/Gb/JKdF58RtQo9gfEWlO7FSiPdPlg334cgGipgTTMCplwd
         I3mA==
X-Gm-Message-State: APjAAAWwUvOMKJfA7ERZkG7nsvST9ckKbJuIEfQlYA0j/geDugF7fTxM
        i0Fb763Hdf1YmFtCP0vVzBA=
X-Google-Smtp-Source: APXvYqwgewphAFbQqViCJyfFArIgtR+B+xkBHqyxL/JO2XHNqZ3UfhfcGrT/0mLGXrhO4oQihbNHrw==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr2016678plo.259.1582859479289;
        Thu, 27 Feb 2020 19:11:19 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-109-34.tpgi.com.au. [193.116.109.34])
        by smtp.gmail.com with ESMTPSA id a17sm8132185pgv.11.2020.02.27.19.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 19:11:18 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, skiboot@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/2] kallsyms: architecture specific symbol lookups
Date:   Fri, 28 Feb 2020 13:10:26 +1000
Message-Id: <20200228031027.271510-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide CONFIG_ARCH_HAS_ADDRESS_LOOKUP which allows architectures to
do their own symbol/address lookup if kernel and module lookups miss.

powerpc will use this to deal with firmware symbols.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/kallsyms.h | 20 ++++++++++++++++++++
 kernel/kallsyms.c        | 13 ++++++++++++-
 lib/Kconfig              |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 657a83b943f0..8fdd44873373 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -83,6 +83,26 @@ extern int kallsyms_lookup_size_offset(unsigned long addr,
 				  unsigned long *symbolsize,
 				  unsigned long *offset);
 
+#ifdef CONFIG_ARCH_HAS_ADDRESS_LOOKUP
+const char *arch_address_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, char *namebuf);
+unsigned long arch_address_lookup_name(const char *name);
+#else
+static inline const char *arch_address_lookup(unsigned long addr,
+			    unsigned long *symbolsize,
+			    unsigned long *offset,
+			    char **modname, char *namebuf)
+{
+	return NULL;
+}
+static inline unsigned long arch_address_lookup_name(const char *name)
+{
+	return 0;
+}
+#endif
+
 /* Lookup an address.  modname is set to NULL if it's in the kernel. */
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9b3f660dee7..580c762fadd8 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -164,6 +164,7 @@ static unsigned long kallsyms_sym_address(int idx)
 unsigned long kallsyms_lookup_name(const char *name)
 {
 	char namebuf[KSYM_NAME_LEN];
+	unsigned long ret;
 	unsigned long i;
 	unsigned int off;
 
@@ -173,7 +174,12 @@ unsigned long kallsyms_lookup_name(const char *name)
 		if (strcmp(namebuf, name) == 0)
 			return kallsyms_sym_address(i);
 	}
-	return module_kallsyms_lookup_name(name);
+
+	ret = module_kallsyms_lookup_name(name);
+	if (ret)
+		return ret;
+
+	return arch_address_lookup_name(name);
 }
 EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
@@ -311,6 +317,11 @@ const char *kallsyms_lookup(unsigned long addr,
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
 						offset, modname, namebuf);
+
+	if (!ret)
+		ret = arch_address_lookup(addr, symbolsize,
+						offset, modname, namebuf);
+
 	return ret;
 }
 
diff --git a/lib/Kconfig b/lib/Kconfig
index bc7e56370129..16d3b8dbcadf 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -80,6 +80,9 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config ARCH_HAS_ADDRESS_LOOKUP
+	bool
+
 config INDIRECT_PIO
 	bool "Access I/O in non-MMIO mode"
 	depends on ARM64
-- 
2.23.0

