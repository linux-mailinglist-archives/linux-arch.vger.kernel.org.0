Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743770B5B8
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 09:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjEVHCH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 03:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjEVHBE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 03:01:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99C103
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 00:00:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af20198f20so41911601fa.0
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738848; x=1687330848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDtU5Jqmt1rhTrWGvrFpFNAhujSWuurCg4wxa03/anU=;
        b=EgeeaYxHiw9wjOAGc/5G+LN0c3KUHNjvlMLN8uS8AnOgASES7fyW/rsQOHqr9DJIm4
         Q8pNdnQ8gVkoZSj/+upHrsi/tavYgOTyzBUdlAtcr2Kh9ffmMPH4gQgxiD9jwMMKDMI+
         CuKr2WQEU8br9TaFssSRKesDxf+IahbGC5Zx0cbDL1B32MIMmQqJEpul0X/k5OkwgL/p
         biyoDSbwAxtoAdQjplEuS+uPbUVkhGZwVNA6jM4DVWvLhyshkUq3uEnshyu8D9Pr1j1Y
         dtZh4qZurb2FlkyA/lCRl9W6OQ/h4jDhIaJlJh3cxPH3CVc6wzd8qQhjtgUMnfkuf6pl
         /E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738848; x=1687330848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDtU5Jqmt1rhTrWGvrFpFNAhujSWuurCg4wxa03/anU=;
        b=dBgbFfsNEYGHrI//hKEeloaH8ZksVxeGMparKwuGC80SWFAD/iep6vsAOOfcwnK89d
         kh+oyqcwugBo6B0pk36Cp6yn8rgidKEbvDmsLDjUz1UXz4o8qtGh48U2QUNnHpHL6lQp
         Hmy5Dp7CbXRAPNlRO2JS2GqKPfceRxgOmJ8UapmNVXrXH/CGHg9v5mM98BdL32llcXaq
         n7t5Zx0n9m3wAgC9JfjrEjokyrjzBZuP4WE9S5TMobOKo4zKvILGt3R91aG/Rin+Cojb
         SJgtnyucPVDSV2TpALOcyk6YVpqtq4kUtNtU3BhIM4KPTStEcZ6wPsf32VY+PmGY0JPF
         mN6A==
X-Gm-Message-State: AC+VfDyJ2wN4YROSWVPt2Zmx9hQR7r9FB111KdpPbzi9gvBmtkcLSO7q
        AFFNnmfeuk4fSm7g96TI88OVuQ==
X-Google-Smtp-Source: ACHHUZ6ayjAtOwTfIDOzMqX5t+1QrYhY8xbXfr8AsE31hPYz8DEGnh0exphBKO7gszaQlURwHEoueQ==
X-Received: by 2002:a2e:9588:0:b0:2ad:aa42:8c0b with SMTP id w8-20020a2e9588000000b002adaa428c0bmr3570722ljh.35.1684738848500;
        Mon, 22 May 2023 00:00:48 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:00:44 +0200
Subject: [PATCH v2 09/12] asm-generic/page.h: Make pfn accessors static
 inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-9-0948d38bddab@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry we do the same change for pfn_to_virt.

Immediately define virt_to_pfn and pfn_to_virt to the static
inline after the static inline since this style of defining
functions is used for the generic helpers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/asm-generic/page.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index c0be2edeb484..9773582fd96e 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -74,8 +74,16 @@ extern unsigned long memory_end;
 #define __va(x) ((void *)((unsigned long) (x)))
 #define __pa(x) ((unsigned long) (x))
 
-#define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+#define virt_to_pfn virt_to_pfn
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn) << PAGE_SHIFT;
+}
+#define pfn_to_virt pfn_to_virt
 
 #define virt_to_page(addr)	pfn_to_page(virt_to_pfn(addr))
 #define page_to_virt(page)	pfn_to_virt(page_to_pfn(page))

-- 
2.34.1

