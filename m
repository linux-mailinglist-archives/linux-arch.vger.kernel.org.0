Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D22D0146
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLFGtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLFGtZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:49:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C642C0613D0;
        Sat,  5 Dec 2020 22:48:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id iq13so5526034pjb.3;
        Sat, 05 Dec 2020 22:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BSumPRorxhYM+yM2n0c7LX3KunZP5zaLLWlWEG1gKAk=;
        b=q7hcXkt4db0YUyJbU8dEm8m4wT7h2tRSIWGRqBYhrvUqDCa2tCD90naJVOmzv8TSgj
         L+I+Jqe5jDBdkZwCToRXr3FBBH4Wu0os8eqOmF+ndusd7kLuznDpt1jlggxqqyw2lR/m
         As41sw2wmx3+OAonQHF03m2n+X7g5x63cO30N7gGJ4LqQEy9yqgOQnXwYQU2qODC1ucO
         wYFI2KsFpZRseWtwa7eZkePDLhYpFVoXJcJGBNO1ZOZN5fGoEG4So5vteLuCCa2nAOCu
         X0i/+ler0oQ1CMi8IcaWTWF9Q6Bhr3WtFKJUdoa6diYPRX7dt75byiCni1Uwxfce4dw7
         2diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BSumPRorxhYM+yM2n0c7LX3KunZP5zaLLWlWEG1gKAk=;
        b=KbahLEsJ6onKSx7riqn6Ij19UxNOx3GhG0rc1QpZYuOPRZGuY0MzGQNQXGbaim4j/6
         QVLZc16bCt++xTkfNP5ruGGdv8mEFjytT0LKURet2JlhGMjsi+l3ZEjVMGQ/tPTPwgC5
         c6nyKMf7uC+WRTDaE7UI6PTj4L02d9D7lB8Ku24V181Q7aPOTQ/tiFU6uSHN1fBKXP6z
         5JHrz+XR3+U1D4i+RzD2y1YvaW0qPVGcBzZZQ87d69MJOVNixNcyWd1mZVKbW8VMHeXP
         xsYRcQXNRloCCHFMCq1/8FsokvBO6MvjxgcomPOxCYAt6vWZ0L73SMbrPtkZke4IwgCu
         qicw==
X-Gm-Message-State: AOAM532rMD9Pw1s+jNyqEUOwj20E5Z11sbZDrEbkzaWth+ISpLpMACNU
        yQyFXTQdBnHDRsxr13LEmgk=
X-Google-Smtp-Source: ABdhPJwoTpJ4E5tf2AAjNZ5yNQ4XDM1kCtaz8oOOtskM/DFoBKee2KyV2dbt2mFnleoPZ8dqI9UQjg==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr11572479pjp.86.1607237324441;
        Sat, 05 Dec 2020 22:48:44 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id gm2sm7009349pjb.35.2020.12.05.22.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:48:43 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:48:32 +0900
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
Subject: [PATCH v2 4/8] bitops/le.h: Add le support for find_last_bit
Message-ID: <20201206064832.GA6114@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Inspired find_next_*_bit function series, add find_last_zero_bit.
These patch adds declarations for find_last_zero_bit.
This patch is for le support of find_last_bit and find_last_bit_zero.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 include/asm-generic/bitops/le.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
index 188d3eba3ace..3d6661cc8077 100644
--- a/include/asm-generic/bitops/le.h
+++ b/include/asm-generic/bitops/le.h
@@ -27,6 +27,18 @@ static inline unsigned long find_first_zero_bit_le(const void *addr,
 	return find_first_zero_bit(addr, size);
 }
 
+static inline unsigned long find_last_bit_le(const void *addr,
+		unsigned long size)
+{
+	return find_last_bit(addr, size);
+}
+
+static inline unsigned long find_last_zero_bit_le(const void *addr,
+		unsigned long size)
+{
+	return find_last_zero_bit(addr, size);
+}
+
 #elif defined(__BIG_ENDIAN)
 
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
@@ -46,6 +58,14 @@ extern unsigned long find_next_bit_le(const void *addr,
 	find_next_zero_bit_le((addr), (size), 0)
 #endif
 
+#ifndef find_last_zero_bit_le
+extern unsigned long find_last_zero_bit_le(const void *addr, unsigned long size);
+#endif
+
+#ifndef find_last_bit_le
+extern unsigned long find_last_bit_le(const void *addr, unsigned long size);
+#endif
+
 #else
 #error "Please fix <asm/byteorder.h>"
 #endif
-- 
2.27.0
