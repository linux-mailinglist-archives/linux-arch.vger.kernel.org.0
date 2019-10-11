Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70E5D34E0
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 02:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJKAGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 20:06:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45452 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfJKAGi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 20:06:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so4924013pfb.12
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZBHIZP91az7zFwublbVFIxiUPIvhqcpifj2fGv96nM4=;
        b=V5SSXiOU/2LqW+YWMWv2g8oE+O+8OqaVciMsltfBT6XAT+UmV5TNibrJhEtO410tXb
         /OnY7p2PJHhLZDVx/eoiV5CS19ovJ8wYT+GUzFT433OArvUWowNhqhNxhPEcl3xsRkLc
         lb2h6DldDdTdhb4T8VOEQWN9DqKeDub1PenXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZBHIZP91az7zFwublbVFIxiUPIvhqcpifj2fGv96nM4=;
        b=o15lOXqMbm8NGOCnp4YDztcQHTnCgUAYPaGlFKydUwjRe4YN+PwuCmLwFK6dfA58Uf
         25lRvlDqt/saqgd18cQMuTtl3Cod6YvMLqlzqW6F4bJvprCqAmuAdTRNDQAU37PKb3vH
         BfpdCaUJdWFyDIfkB8E4pzKVBqL/k1mRCkpdZKvWo/gMamok52zw16ZD+TQ+UQplagek
         Oh8JNaiDlg/2ihz1dSlSNqTgnCaOdfT8HcyfgG6FdLf5XPJlkix91bQpkNuhyQf0w5KN
         R5sV1phhQLE4q9SWXoOZOJSbe5ZCHKSSrWhumm8bIdCTSvt4JrfZ4WO8hqeqYaU4kIFK
         j/wg==
X-Gm-Message-State: APjAAAV9Cvv0iWu/nsU4IFb5W81x9GnsXPhXiPZ9l4YKZes6PX4dEa6r
        mlVn4bYiSyVwhN1cHFdns/xuiw==
X-Google-Smtp-Source: APXvYqxIURRErEoWhZaXwUViGgbdz47KTCDz+s6x66JTdawkgAKVzwgCcLp2sAcohHOnlA3CSEfhcA==
X-Received: by 2002:aa7:9157:: with SMTP id 23mr13458255pfi.73.1570752397032;
        Thu, 10 Oct 2019 17:06:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15sm5864975pjt.13.2019.10.10.17.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/29] x86/mm: Report actual image regions in /proc/iomem
Date:   Thu, 10 Oct 2019 17:06:08 -0700
Message-Id: <20191011000609.29728-29-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The resource reservations in /proc/iomem made for the kernel image did
not reflect the gaps between text, rodata, and data. Add the "rodata"
resource and update the start/end calculations to match the respective
calls to free_kernel_image_pages().

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
index 77ea96b794bd..591e885a852e 100644
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

