Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C16AB247
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCEU5U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCEU5L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFC199EF;
        Sun,  5 Mar 2023 12:57:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id k10so6899960edk.13;
        Sun, 05 Mar 2023 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGKYuc2vAADzU7zrublYEPfm3g/rR/f1WGM6/LkI/sI=;
        b=Kyfi0rKd//Upk3aCZ6+jEG9xTzcSdlW+B4Aq9cgOCJ266SK3vfnm1tkdI2RPt7pXRd
         /5aOeEcgds2MgdAfgu2vZ1D4O2oNH7M5sa2NOtN4h/AkNwUegzm7gLjpT0kO6pcW6qkN
         jUlWXb9vbFEAS8p5MHABZ051K4kPPEz7uW/XkPkwfrldKLKAK3VUxzQ76PP6WuUmbCo4
         W4owoRB/SZcwmYTEwgauoIzzd9uD4xjahT3Oy+xbDxewMszjPaqvxoA5P3DQ83osbq3B
         o/ohA5FKrX/NeY3inuy+snM+9n/GXWddpPIah/eoPJbvAxP7nmH97DSy2iKSgiLWiKT5
         xnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGKYuc2vAADzU7zrublYEPfm3g/rR/f1WGM6/LkI/sI=;
        b=wmg3sWQ0YAi2DY7gJFqtOugnIg2ULDspCjUafeGMaDoCA+2gGGHSX244GBmRlG8MZh
         WgFfW/GFAAko7xjI2zmLX3X8OqCO5ZeJxs5D9n+QkXO+NvcFlyw0b4BP4Qyi15Anj3Hy
         mTNMmOmPc9QsuhnF7emYti/fvlrvN0WeI2nQ1HcNhsQ6NTfY+KerRs0z2HttbB0u5SM+
         MOI+71++n8S4IBL77ijI/BdxtbWF0/Glo5bwg4gLYMz3SF5rnTYTWJ2CTj0sSHKWmkL0
         SZU2RvaBNywpGUCcwDuJw8ekuCCR1q8uXwj3eynOLXqnjLKHOBnvwuJYL2C5tuBdqhTc
         JuVA==
X-Gm-Message-State: AO0yUKWzizQJjKlHFbZK0a9au3wULXQLECoCV78WvxX6ZNWCPE57ryq4
        mivu+jG6Rm3wjZW4e87qNyfGx2ZvS05t4Fu/
X-Google-Smtp-Source: AK7set8Lt+GpLOMrecu3JmpD5k2zZkktGUUIlGi4aPXwTlL56+J+rJ7Pb8VCnD8RZciPK4neeAqKzA==
X-Received: by 2002:aa7:c408:0:b0:4bb:f229:9431 with SMTP id j8-20020aa7c408000000b004bbf2299431mr8871097edq.19.1678049824164;
        Sun, 05 Mar 2023 12:57:04 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:57:03 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 07/10] locking/x86: Wire up local_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:25 +0100
Message-Id: <20230305205628.27385-8-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement target specific support for local_try_cmpxchg.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/local.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 349a47acaa4a..4bcc72906524 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -122,6 +122,8 @@ static inline long local_sub_return(long i, local_t *l)
 
 #define local_cmpxchg(l, o, n) \
 	(cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_try_cmpxchg(l, po, n) \
+	(try_cmpxchg_local(&((l)->a.counter), (po), (n)))
 /* Always has a lock prefix */
 #define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
 
-- 
2.39.2

