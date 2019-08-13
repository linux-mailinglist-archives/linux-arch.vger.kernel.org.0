Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24C48B840
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfHMMT2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:19:28 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:34137 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfHMMT1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:19:27 -0400
Received: by mail-vs1-f73.google.com with SMTP id l24so2315580vsq.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YYc16S6TtlY6DmQcUE3cXRCrWAP97wDS23cXhgLsgk=;
        b=Q3EMNPwo+C4R+ukcqh1LicHQAX96raDaDhMY4MmdRFTDeLddmcv2m7zx9cRgxwJpcY
         hcXiJVz4HNIelbYnSqDQtyHzp8gE3M9f+/WFeGvz2HtHGV0I6XwxHjDecZqZZi5aHNOb
         o4ahubSIhi+PAmIkYn5qjtiPUvOSEeQrWN9SI2D5cZU20Mnzuy437BwMQMP/0Lr3tMz4
         szlCfUelpHls+azukK4dUBWr5uJyN8m3TU8PpEnX7GfBQf2dkGsTLCGlCJb8UtVHFlJc
         0CtHeWYn+fMlyVQLUqkHmM8Wsq96xJzEeZNuCAL6xho2UJ9TI6OieZiuLGJ613r8mHxp
         kFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YYc16S6TtlY6DmQcUE3cXRCrWAP97wDS23cXhgLsgk=;
        b=aRyg2lj2OjoVvX6cKo4dDRp0PKImIkwRUiTjOXJcmJ85z+9AE1oMgoX0+fWgT6K20H
         B2GOJmy1Hk96vcJzRL2EpwPQsJrz3xo5tkdoNHYtxA8MgqSfYHTMJFwrYgynVUUrTGCH
         yq8dwywBOZF5zlOmOaBwK4t7PYHmemocsOiIeFN+kUwl1v/fYxWbq4PkdLf9I9+Mb5O8
         8mHKhCTWrNbh7fyxQOHy7qoMZtK7JplEVmXJxn116gSXru3sv+SHcryeCvo99rTvoK9a
         3LepFiVHOhnhsBDSH5iDk/yx5fOJIuMlAl4ktp96HhysM2cgTMJQbtnRlhutFiHAttRK
         ODHg==
X-Gm-Message-State: APjAAAWhCUcXM9VYKiZW67NxIJVCzgDN1m/Je3tFp+A/nO38H+kZzGib
        YmRSXelf74BHV/NlC5cv70Lhk0JXZGqjFg==
X-Google-Smtp-Source: APXvYqzCEstrhDpIdy3FOZ032oFTXz+VRy3pbyV2rfawsANSQxszqGzHRG9SAAhjciIykc36W/gzeVtTieEkYA==
X-Received: by 2002:a1f:7c0e:: with SMTP id x14mr3691831vkc.0.1565698766083;
 Tue, 13 Aug 2019 05:19:26 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:17:02 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-6-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 05/10] module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
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
        yamada.masahiro@socionext.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is enabled (default=n), the
requirement for modules to import all namespaces that are used by
the module is relaxed.

Enabling this option effectively allows (invalid) modules to be loaded
while only a warning is emitted.

Disabling this option keeps the enforcement at module loading time and
loading is denied if the module's imports are not satisfactory.

Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 init/Kconfig    | 14 ++++++++++++++
 kernel/module.c | 11 +++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..b3373334cdf1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2119,6 +2119,20 @@ config MODULE_COMPRESS_XZ
 
 endchoice
 
+config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+	bool "Allow loading of modules with missing namespace imports"
+	default n
+	help
+	  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
+	  a namespace. A module that makes use of a symbol exported with such a
+	  namespace is required to import the namespace via MODULE_IMPORT_NS().
+	  This option relaxes this requirement when loading a module. While
+	  technically there is no reason to enforce correct namespace imports,
+	  it creates consistency between symbols defining namespaces and users
+	  importing namespaces they make use of.
+
+	  If unsure, say N.
+
 config TRIM_UNUSED_KSYMS
 	bool "Trim unused exported kernel symbols"
 	depends on MODULES && !UNUSED_SYMBOLS
diff --git a/kernel/module.c b/kernel/module.c
index 57e8253f2251..7c934aaae2d3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1408,9 +1408,16 @@ static int verify_namespace_is_imported(const struct load_info *info,
 			imported_namespace = get_next_modinfo(
 				info, "import_ns", imported_namespace);
 		}
-		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
-		       mod->name, kernel_symbol_name(sym), namespace);
+#ifdef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+		pr_warn(
+#else
+		pr_err(
+#endif
+			"%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
+			mod->name, kernel_symbol_name(sym), namespace);
+#ifndef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 		return -EINVAL;
+#endif
 	}
 	return 0;
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

