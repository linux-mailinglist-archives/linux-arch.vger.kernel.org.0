Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5995537AEC5
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhEKSxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhEKSwz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 14:52:55 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48547C06138C;
        Tue, 11 May 2021 11:51:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e2so18082913ilr.1;
        Tue, 11 May 2021 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zPO68rECc+Worbr8mpoHDMicmfWQWDsecrogWsDsoQ=;
        b=lUOzvKR7OcFpY3RFzFgr4FfdY+ltDTeD+w+XTPlSXAD60lNeu0OutmmA3OapNwiIOs
         iOGGjwpez+HzgWZKjsLeHv/b7ne6PJXQGzWgJEryLJMkUuLeRJDhkHtKfnfQN54XHv+t
         iWg5/I8gU7sXudG/yQXuwEKlLk5+RqDXvgIL23dhr63JSghTd4PPQBtoSPw88Xe0mYb1
         mdXZW4KQgIBgzqPRDkt46MQleqFIO14rbyTwJN77jc9KKKIJDnhc4K1S1qgtwqFK5cSI
         b5GCLFGyh7G5KxULcx9wtTmd/9ugmEXaDIcDl87WA3cq6Si7oKgmknwsAeKY6p7ODVW5
         koRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zPO68rECc+Worbr8mpoHDMicmfWQWDsecrogWsDsoQ=;
        b=l2PHr/r9fFo8He1VRsE4zTJH6bJGt/qoTIOSL8o2uk7WQBa17+hgJNg2Sw4w/8z11S
         dkNYd4xcRAlU/FY+tnl8qw9GKY+7IkoqWAqE0Hi9+F8di9lKSnxaua6ZSR+jwwzycWNH
         FA377/VH+TTGiIm0JTtmmz+QUGcn2YFrHZ0GrrUTuS/IGnpwgFf+wMCVtZ9cFaBHDmmc
         5En0YVyMsAGBM2NNbLpF0ygQreaMbRIWiF1vkLNjAKqsFhcl3oT/E1VYnvsPVTfRSWdh
         f+AecMcfI5mZz+XKbDUj2uQXNl3PJYwZLVhu6sVSh2VCwp/IZqyHceipeS3Q0l9F5D4c
         dMCQ==
X-Gm-Message-State: AOAM531biR2BtuloWr45wz9J6fKvBCXhTXWC9ziEH15I8UycdcXs9Pe9
        4EIzLRk2bA3HbN5gOqBW+EM=
X-Google-Smtp-Source: ABdhPJzgH2JupKPauvVNrxewRnPOgZT9DsS7spCYIvNf3mENzkbGKi8D+JbpvRz4e1wSrzR8pbrZeQ==
X-Received: by 2002:a92:cf05:: with SMTP id c5mr25905167ilo.225.1620759107543;
        Tue, 11 May 2021 11:51:47 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 19/28] dyndbg: RFC handle __dyndbg* sections in module.lds.h
Date:   Tue, 11 May 2021 12:50:48 -0600
Message-Id: <20210511185057.3815777-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Up until now, loadable modules have tacitly linked the 2 __dyndbg*
sections into the .ko, as observable in log by enabling module.c's
pr_debugs and loading a module.

But now, we need to explicitly place the header sections in front of
their respective __dyndbg* sections, so we reuse input section names
for the output.

This gives us the placement we need for the header record, which we
can see in the "add-module:"s and elements "0 0" below:

    "0 0" lines are headers: predicate (function==module && !lineno)
    "X debug prints in" are 1 too high, they count headers.
    we are adding tables for empty modules (1st 2 below)

[    7.578873] dyndbg: add-module: ghash_clmulni_intel
[    7.579716] dyndbg:  0 0 ghash_clmulni_intel.ghash_clmulni_intel.0
[    7.608995] dyndbg:   1 debug prints in module ghash_clmulni_intel
[    8.078085] dyndbg: add-module: rapl
[    8.078977] dyndbg:  0 0 rapl.rapl.0
[    8.079584] dyndbg:   1 debug prints in module rapl
[    8.082009] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    8.099294] dyndbg: add-module: intel_rapl_common
[    8.100177] dyndbg:  0 0 intel_rapl_common.intel_rapl_common.0
[    8.101026] dyndbg:  1 1 intel_rapl_common.rapl_remove_package.1279
[    8.101931] dyndbg:  2 2 intel_rapl_common.rapl_detect_domains.1245
[    8.102836] dyndbg:  3 3 intel_rapl_common.rapl_detect_domains.1242
[    8.103778] dyndbg:  4 4 intel_rapl_common.rapl_package_register_powercap.1159
[    8.104960] dyndbg:  5 5 intel_rapl_common.rapl_package_register_powercap.1145
[    8.106246] dyndbg:  6 6 intel_rapl_common.rapl_package_register_powercap.1114
[    8.107302] dyndbg:  7 7 intel_rapl_common.rapl_package_register_powercap.1108
[    8.108338] dyndbg:  8 8 intel_rapl_common.rapl_update_domain_data.1083
[    8.109278] dyndbg:  9 9 intel_rapl_common.rapl_check_unit_atom.824
[    8.110255] dyndbg:  10 10 intel_rapl_common.rapl_check_unit_core.796
[    8.111361] dyndbg:  11 11 intel_rapl_common.rapl_read_data_raw.722
[    8.112301] dyndbg:  12 12 intel_rapl_common.contraint_to_pl.303
[    8.113276] dyndbg:  13 debug prints in module intel_rapl_common
[    8.130452] dyndbg: add-module: intel_rapl_msr
[    8.131140] dyndbg:  0 0 intel_rapl_msr.intel_rapl_msr.0
[    8.132026] dyndbg:  1 1 intel_rapl_msr.rapl_msr_probe.172
[    8.132818] dyndbg:  2 2 intel_rapl_msr.rapl_msr_read_raw.104
[    8.133794] dyndbg:   3 debug prints in module intel_rapl_msr

This gives us the property we need:

   fixed offset from &__dyndbg[N] to &__dyndbg[0]
   container_of gets &header
   header has ptr to __dyndbg_sites[]
   we can (in principle) drop __dyndbg.site ptr
   (after we adapt header to keep it)

TODO:

At this point, for loaded modules, ddebug_add_module() sees the header
as 0'th element, as we need in order to drop site (and regain worst
case footprint parity).

It could/should properly init this header to support the _sites[n]
lookup for loaded mods.  Or at least handle it explicitly.  Or at
least see what proc-show does with it currently.

Note that for builtins, decided by (__start <= dp < __stop), we use
__start___dyndbg_sites[N] directly, and dont need the header.

But maybe we should use it anyway, double-checking/BUGing when wrong.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/module.lds.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/module.lds.h b/include/asm-generic/module.lds.h
index f210d5c1b78b..328c48dfc88c 100644
--- a/include/asm-generic/module.lds.h
+++ b/include/asm-generic/module.lds.h
@@ -4,7 +4,17 @@
 
 /*
  * <asm/module.lds.h> can specify arch-specific sections for linking modules.
- * Empty for the asm-generic header.
+ *
+ * For loadable modules with CONFIG_DYNAMIC_DEBUG, we need to keep the
+ * 2 __dyndbg* ELF sections, which are loaded by module.c
+ *
+ * Pack the 2 __dyndbg* input sections with their respective
+ * .gnu.linkonce. header records into 2 output sections, with those
+ * header records in the 0th element.
  */
+SECTIONS {
+__dyndbg_sites	: ALIGN(8) { *(.gnu.linkonce.dyndbg_site) *(__dyndbg_sites) }
+__dyndbg	: ALIGN(8) { *(.gnu.linkonce.dyndbg)	  *(__dyndbg) }
+}
 
 #endif /* __ASM_GENERIC_MODULE_LDS_H */
-- 
2.31.1

