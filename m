Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B4BF823
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfIZR4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:56:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37900 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfIZR4f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so1964203pgi.5
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7AxBS2UV+sou48Vy6Kv2h9T7DXggZ06m6xu8Azn3KL4=;
        b=CyY/fdEzQgm0TyKUDxy3G75sTcbk4Yw8tvueMHwbpgUZtbJ0Xvon+CXNyKvyrH1BQL
         u5o6uFwm+e/OcHUC7jySe7aCPARo15vlMXuk5vFXe2FB4K6jNA/Eh3EruiLhkgWYgaHg
         gq6pWp7Ua54wgWact2q/huVGG+j/PtSDlqWQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7AxBS2UV+sou48Vy6Kv2h9T7DXggZ06m6xu8Azn3KL4=;
        b=SZgQkpW26NjoSba+SLFaqd5gbTsIR70FKldA7/Kvx7LKFIE8IeS/KM0nZcYhXE8XzI
         nsD7g7IgWS+fMEGRD25SqZovEKltyFVzIwOsrmUOa6oEHH+ptdkxhgPDNxk3bOXe74Uy
         SG6cnmkJnIxSijltZkYnOb7p5KFQYWSWuuA/AyDQxURgCY4jC9io6IbXm55Kr58VW1rP
         PKm8UcVxvqxuXwpAd0srAjn44tviOu4PbYCmYDsYm3s5hRu+CAwf7qI32A6qxiB3Flw0
         H+CtK2qpc/m2oAU+2qMlkk6vELhTgbao4p5M5iIP69EhdI4uALNfVqFxBf3IetkibJSZ
         3k6A==
X-Gm-Message-State: APjAAAWMgl2L8XmNKWiD8NGQV4f/BfExQ5dudB/nj0t6Sb0Z51NTkBcl
        K/+HEmFlzE48eXv2/Wpl7OF3dA==
X-Google-Smtp-Source: APXvYqxknkDJzH/r0j7lYxibttZvFSpKr+f+b+F+1vun52i5pglb7KvJVrIclOAHVzYu0ZWp0UtBWA==
X-Received: by 2002:a63:5050:: with SMTP id q16mr4553788pgl.451.1569520594732;
        Thu, 26 Sep 2019 10:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i126sm3220459pfc.29.2019.09.26.10.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] x86/mm: Report actual image regions in /proc/iomem
Date:   Thu, 26 Sep 2019 10:56:01 -0700
Message-Id: <20190926175602.33098-29-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The resource reservations in made for the kernel image did not reflect
the gaps between text, rodata, and data. This adds the rodata resource
and updates the start/end calculations to match the respective calls to
free_kernel_image_pages().

Before (booted with "nokaslr" for easier comparison):

00100000-bffd9fff : System RAM
  01000000-01e011d0 : Kernel code
  01e011d1-025619bf : Kernel data
  02a95000-035fffff : Kernel bss

After:

00100000-bffd9fff : System RAM
  01000000-01e011d0 : Kernel code
  02000000-023d4fff : Kernel rodata
  02400000-025619ff : Kernel data
  02a95000-035fffff : Kernel bss

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/setup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf879f5..0bc71ee3a9c3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -143,6 +143,13 @@ struct boot_params boot_params;
 /*
  * Machine setup..
  */
+static struct resource rodata_resource = {
+	.name	= "Kernel rodata",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
+};
+
 static struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
@@ -951,7 +958,9 @@ void __init setup_arch(char **cmdline_p)
 
 	code_resource.start = __pa_symbol(_text);
 	code_resource.end = __pa_symbol(_etext)-1;
-	data_resource.start = __pa_symbol(_etext);
+	rodata_resource.start = __pa_symbol(__start_rodata);
+	rodata_resource.end = __pa_symbol(__end_rodata)-1;
+	data_resource.start = __pa_symbol(_sdata);
 	data_resource.end = __pa_symbol(_edata)-1;
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
@@ -1040,6 +1049,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* after parse_early_param, so could debug it */
 	insert_resource(&iomem_resource, &code_resource);
+	insert_resource(&iomem_resource, &rodata_resource);
 	insert_resource(&iomem_resource, &data_resource);
 	insert_resource(&iomem_resource, &bss_resource);
 
-- 
2.17.1

