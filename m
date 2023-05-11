Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2506FF0DB
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 14:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjEKMA1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbjEKMAB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 08:00:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326589001
        for <linux-arch@vger.kernel.org>; Thu, 11 May 2023 04:59:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f14f266b72so7347865e87.1
        for <linux-arch@vger.kernel.org>; Thu, 11 May 2023 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806391; x=1686398391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKz9AzIS+RysB0OU8OUcujwHN84YucEXXNOUbLloVVs=;
        b=yiGUAJSVd27ej3NuIk3vnvK3fS1qO3n93XWDO7/QSlEw5RHl7TlckkvSbtgAGMT7rs
         8gcQLXhS79sxLG00vev3Tm+FL9DZK5f2fjYO2/9Es7JV+ZV8EPjwXP4D0JU15a2xS+1A
         jqCUYx4wQDDuhH0tj93gaLE2O4RLjJkMa8aSjU9Ljzc00Ea6CAC5lgOQ8Gs28oI/UYpG
         DmkJW9Uw1afeErc6qgHpSrInmF3KaA9OR4no4iWYo/uDwZIfqMxDi6oFiLi1PWZfKQr2
         u9TrLhqEgUGyGiPpMj49YARpaWJ9QLLB5f4psSVnHsptmTvb1WU9bQQ+74/xGlNqIVr1
         gQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806391; x=1686398391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKz9AzIS+RysB0OU8OUcujwHN84YucEXXNOUbLloVVs=;
        b=HJHd6tLMKxHqzpbv0UKQHer7Vs8rhzauZu3ZyT8zaYa/c7Eso2YvHkVAIQKbaRPixt
         N68Js5+9AEt1SKyl/N7cavS373qlCukINCpkFRhqbZoM1A0g5wMdC8c0jHG5kYfgmhsh
         x4VsViKPNx13XPTpuYu0JeoCaQ5TJ2C1nUQQJKsnO75iCMK4B2tRF17vT33y7ZmENd1N
         pNweaKcz67roMJ01A2ufzy5Lbv+NITWf8C/s0J4NldlGHAiaXF36ZJnepJS9Pha1YihN
         aRFDXHPUVQ9FmqITz/tuiwDhi9fa5jyuEexO+18p6tCMTJmPz0n+u6mjrBSCi5lXGROO
         fFkg==
X-Gm-Message-State: AC+VfDwqoAl00VubNE8icVuOpSjQ2vI2FfnW+2HowILL+fcXMH/aCwop
        XaTkLmw559gHb9208D3JAKpNZA==
X-Google-Smtp-Source: ACHHUZ6oDkafp6RNma4b/blEY3A9k2zKUGZwC+dKiYwvUH5MmrRALfBC+Lhl+x+E1iIOKclp+sZWBA==
X-Received: by 2002:ac2:46d4:0:b0:4dd:ac8d:671f with SMTP id p20-20020ac246d4000000b004ddac8d671fmr2858782lfo.34.1683806391327;
        Thu, 11 May 2023 04:59:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:22 +0200
Subject: [PATCH 05/12] cifs: Pass a pointer to virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-5-6c4698dcf9c8@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/cifs/smbdirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 0362ebd4fa0f..964f07375a8d 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2500,7 +2500,7 @@ static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
 			if (is_vmalloc_or_module_addr((void *)kaddr))
 				page = vmalloc_to_page((void *)kaddr);
 			else
-				page = virt_to_page(kaddr);
+				page = virt_to_page((void *)kaddr);
 
 			if (!smb_set_sge(rdma, page, off, seg))
 				return -EIO;

-- 
2.34.1

