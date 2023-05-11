Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15A6FF0D3
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbjEKMAG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbjEKL74 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 07:59:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7249E9
        for <linux-arch@vger.kernel.org>; Thu, 11 May 2023 04:59:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f26f437b30so501131e87.1
        for <linux-arch@vger.kernel.org>; Thu, 11 May 2023 04:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806389; x=1686398389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CPc/Vm/Ur0JOy8kF/L6fs0qWXc+VKBrwCqiZQE3hiQ=;
        b=us1qr2gpwQ3bBAky0xvbHlSTRCtb1nydasm8z39XkazIJzESLaqNzEYvSDrqWvBqBX
         4xcES64hit/N9fYugYwoV5W3g4eBVSitwsbnnifZ0lNM9KhPgKlQsFulFvXvE2t+KR4U
         ORQ5OFqloYcfrHKwTO12OVVscWtd5hVcDmECRKCgjTthI9wyAS5zhkAj5RdT8DId2mTE
         5+ejX9H2q5kq1KWIA7iOUhoaa7GyZwuQHvQ3gEGe/NTiXYuogO2QROPtUakEjm0CnwbK
         kvsZHLKeUbzU9xoleFgHTrQZPpPyif74SXwCAcrOuKmxwemz6uMXGapYyPfo5nL/aCgI
         pNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806389; x=1686398389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CPc/Vm/Ur0JOy8kF/L6fs0qWXc+VKBrwCqiZQE3hiQ=;
        b=HFqn8tR4U1qQDD8uj6m1DAdRR1FtKaCqgeloXavwkCpLebp3bBCTL9FFR3stFaQRHK
         uR8yEoaKV9/kroH/cx46QocYBdb30OXJi2SqaHAFXBwB/vphALq+R1k9YMrRcVDrv29C
         I8BUnRQHHkOlg6Rj5qvXLb2zRfKTbMqEpOF3pgd4XiknB3WjYUfQfOk8GzARN+9wod2b
         qqZKGDpOgQRNAS17s7TY9EpUJYMZiCocp9uR572yf4aJhtemUYuHQpwfazF1VTeAz4nx
         QfkxggHB3dsLnRLJ41fVeLCzRo5Kw8inYQvzHMmvJFDrei5eOi6svbmKXYRb7Y16GBI1
         9EGA==
X-Gm-Message-State: AC+VfDyYqkqYWHhSfQK/WBEc0vqp75Nk/VD8Mj/FRVlAZPYE+BJJNTKi
        9EjmsG1oNR4fJlpBiS59fWUF7w==
X-Google-Smtp-Source: ACHHUZ4QkE8eS3TpZoQ27rQu2+0fhZ0L6/1Hi4I8nOp2Q9+9XqczCBc3KV8aWbi1HyhYGQflHWz/3A==
X-Received: by 2002:ac2:5fae:0:b0:4ea:fa07:1182 with SMTP id s14-20020ac25fae000000b004eafa071182mr2670102lfe.14.1683806389365;
        Thu, 11 May 2023 04:59:49 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:20 +0200
Subject: [PATCH 03/12] ARC: init: Pass a pointer to virt_to_pfn() in init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-3-6c4698dcf9c8@linaro.org>
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

Functions that work on a pointer to virtual memory such as
virt_to_pfn() and users of that function such as
virt_to_page() are supposed to pass a pointer to virtual
memory, ideally a (void *) or other pointer. However since
many architectures implement virt_to_pfn() as a macro,
this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix up the offending call in arch/arc with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 2b89b6c53801..9f64d729c9f8 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -87,7 +87,7 @@ void __init setup_arch_memory(void)
 	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	/* first page of system - kernel .vector starts here */
-	min_low_pfn = virt_to_pfn(CONFIG_LINUX_RAM_BASE);
+	min_low_pfn = virt_to_pfn((void *)CONFIG_LINUX_RAM_BASE);
 
 	/* Last usable page of low mem */
 	max_low_pfn = max_pfn = PFN_DOWN(low_mem_start + low_mem_sz);

-- 
2.34.1

