Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954EDF1830
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfKFOOA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:14:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45048 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbfKFONi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so17073754wrs.11
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fqzAPQhanx5lXrgKjEv9uTOrlBIqmOP4j8raLoO2k80=;
        b=I2POX88ZgDVEIXbxSVYMlxZS/dZ7L9KVhUwt+3VSv9oM/hQnoUVFd/6BdiDiRkN72e
         mb3HIJ8zn335Mrlnm7+1kBy52YQr8iVQF2Ja5iGFzC2aYsdzlXapp9hOL4hr/d25WSIb
         TLlS5LGfym6UNlJ25r+k4XhtiyR+AcOmsf8KxheDxTBSYyezHh6NYY+RQW8omSd+sxht
         EExXnP+uHJklWzU8BZnUIUTZqb1eV8tqpuILEWnzNrXEiuexc65TTdG06IsXsKChYaG2
         M8rk6v6P9kDamxYzI4+MMtDD4T8sy85hVCZM4ztqGTKQTpNvGNLVZNDmZx/i/SqHqgJj
         0d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fqzAPQhanx5lXrgKjEv9uTOrlBIqmOP4j8raLoO2k80=;
        b=OfVXC4Ckp4h6yelUkxKtHx0sUTFrBpFpkSQG4/TwJHx9AzivU0uFTP5TIbYJ0zEg7q
         fuscjFPF4855IEHAymbqQhX/iMXyIGnok+gjEiv8Ioom8TvtADSyCxpFQrMTvZ+tZDyu
         Ll6JtFOZE+UrlmeGDrIL3lNw71XMto8g+nFU5UU0da5I3GJjHmHsgVTPiRKNRmcUAe/A
         DEzCdQFKzvV80SAzglmmVJ2vHxZKlCVQD0EJNRnzqAkhC+rp/VBFeXJUvuVZj2234ZD3
         SCvsxN/g6/LZB9nrBylRIq9d2womdOZlMAZv/At/OTOrDlLFTIf4vhN0E91OOOaAzC36
         6jjw==
X-Gm-Message-State: APjAAAUvW8BDiI4D+iuCi9goO69a4ZxFEeHdVGzXm3C4/GdXr88QiTFi
        JiVkoRuoJ8/LymFJs7+yWC9oEZ+D7TMH7A==
X-Google-Smtp-Source: APXvYqx6m5i8d6WRVdHpkTE7+G9qJitHWAUl7IdCDvjMTeMctINMPoeFa1SZY80r+vkjd7EqisEAzw==
X-Received: by 2002:a05:6000:128c:: with SMTP id f12mr3122000wrx.279.1573049615963;
        Wed, 06 Nov 2019 06:13:35 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:35 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/10] powerpc: Use bool in archrandom.h
Date:   Wed,  6 Nov 2019 15:13:06 +0100
Message-Id: <20191106141308.30535-9-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generic interface uses bool not int; match that.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/powerpc/include/asm/archrandom.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index c2ed3b4681f5..7766812e2355 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -6,27 +6,28 @@
 
 #include <asm/machdep.h>
 
-static inline int arch_get_random_long(unsigned long *v)
+static inline bool arch_get_random_long(unsigned long *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_int(unsigned int *v)
+static inline bool arch_get_random_int(unsigned int *v)
 {
-	return 0;
+	return false;
 }
 
-static inline int arch_get_random_seed_long(unsigned long *v)
+static inline bool arch_get_random_seed_long(unsigned long *v)
 {
 	if (ppc_md.get_random_seed)
 		return ppc_md.get_random_seed(v);
 
-	return 0;
+	return false;
 }
-static inline int arch_get_random_seed_int(unsigned int *v)
+
+static inline bool arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
-	int rc;
+	bool rc;
 
 	rc = arch_get_random_long(&val);
 	if (rc)
-- 
2.17.1

