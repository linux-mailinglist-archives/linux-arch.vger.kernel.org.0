Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E82D0143
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgLFGsk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLFGsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:48:39 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE0C0613D1;
        Sat,  5 Dec 2020 22:47:59 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id lb18so2992763pjb.5;
        Sat, 05 Dec 2020 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZWfo4LRU9rmSY/q/C6F3vJReUbd7Kg5Z+IjcutjFQrk=;
        b=mFzjkfqwVzDaTJSAaHPXe4EbeW1vABRipaj8sZ94I3NTjvmLb1FehrUUBbJKyPMiNP
         8Wxa8dJgShHMf9T5DHOxWCbmay3E0D9r/BnAMvO1fbBZkuMwuoR1P9SVlldNFi0UNKU+
         hHvK3+MZgORJSB7FJIJlihpgLAlN0ig1nDWWNdvskWr8lWALW7ijQKk+Nlg4ECvC+aIs
         0HpgQV9OOz2Q4OnVLPQs7doUTU3zcxlCShkFx9vSWtMaHlT+oV5bbu4580n0MeF9ihwm
         eMD7bQZllzUEEYFXsd9RkiBJi2j6zWpa/rBWQm+zSSGQ/R0YFaIeSeGy2upRRgF4TqEw
         JfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZWfo4LRU9rmSY/q/C6F3vJReUbd7Kg5Z+IjcutjFQrk=;
        b=BLL3YHwfRxmswDyttDiEPrKRnGcI+/Vli3ltPY9MUB0TPCyowr/rU0b3hHP+Kuwh1X
         bzKGbDOUNrQXvAhE7dofcUKB0zAf528cvV1BKT65cwdXDNLH0e7ZMFRcCsjNiSXjpedd
         q7sWPhEperSRLUu43yIjVhiTVIOp7hOVPVSzCSajoA2NvAvfyxmnnBKEgwSH0XdyvIZw
         UE+D9wMiQ/g3NiO3Qcq2UCaWs6zB6ZFLOcV/oKkNHXEouKAEII0xXCQwNKr9KT+eMKvS
         KysawuZiCMxGDyeExmZzcdXk9dPA9bSXEfwLCMAhQDWET28EhPcyAkY/AxoYKwJKGiAC
         Xqew==
X-Gm-Message-State: AOAM530W3C3SFA1kYqtM3CGdjHcrtJXy1blGuE9Pz9RS2sCKZMbDSCsO
        0o3qMsdUCVPKjSy/gCEpin8=
X-Google-Smtp-Source: ABdhPJz/NUGVOeST7QTKajRSwp9huVV7+yfaVo/YgFYaQ4WjG0T50pualk1jw8qdmd5RMYJjJGj5MQ==
X-Received: by 2002:a17:90b:4b11:: with SMTP id lx17mr11391016pjb.154.1607237279376;
        Sat, 05 Dec 2020 22:47:59 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id i10sm10562393pfq.189.2020.12.05.22.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:47:58 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:47:49 +0900
From:   Levi Yun <ppbuk5246@gmail.com>
To:     akpm@linux-foundation.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        arnd@arndb.de, jpoimboe@redhat.com, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        mhiramat@kernel.org, jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        glider@google.com, orson.zhai@unisoc.com,
        takahiro.akashi@linaro.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/8] bitops/find.h: Add declaration find_last_zero_bit
Message-ID: <20201206064749.GA6042@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Inspired find_next_*_bit function series, add find_last_zero_bit.
These patch adds declarations for find_last_zero_bit.
Also, I move declaration of find_last_bit to asm-generic/bitops/find.h
Because:
I think its declaration need not to in __KERNEL__ macro compared to
find_next_*_bit and find_first_*_bit.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 include/asm-generic/bitops/find.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 9fdf21302fdf..eeb2d6669f83 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -80,6 +80,31 @@ extern unsigned long find_first_zero_bit(const unsigned long *addr,
 
 #endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
 
+#ifndef find_last_bit
+/**
+ * find_last_bit - find the last set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The number of bits to search
+ *
+ * Returns the bit number of the last set bit, or size.
+ */
+extern unsigned long find_last_bit(const unsigned long *addr,
+				   unsigned long size);
+#endif
+
+#ifndef find_last_zero_bit
+/**
+ * find_last_zero_bit - find the last cleared bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ *
+ * Returns the bit number of the first cleared bit.
+ * If no bits are zero, returns @size.
+ */
+extern unsigned long find_last_zero_bit(const unsigned long *addr,
+					 unsigned long size);
+#endif
+
 /**
  * find_next_clump8 - find next 8-bit clump with set bits in a memory region
  * @clump: location to store copy of found clump
-- 
2.27.0
