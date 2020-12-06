Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD042D013F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgLFGsD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLFGsC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:48:02 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2180C0613D0;
        Sat,  5 Dec 2020 22:47:22 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b5so1721254pjl.0;
        Sat, 05 Dec 2020 22:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HigwzuIkd2mgtCXhNqT5DjNxRNzKxVeBqvUWRjiFTO8=;
        b=qT6PuKUnakUjvBPGR2Zp/38SINruBNsnINkPkqbaPOEvGr9u42YP7+Q3PhV0ozHNoi
         ezq9SXEZoIO8YnR9F0JGKnqGRxdOQBbIFPSB2pRdIcpXGI+cxB1tV3R57NEWbqa6nQBE
         f5C62KIcjfQ9D82gnqGJEtLmKw7cOmfh9xsO/N7VCkhp0O1G9pvdPeTm/EcBnAyiVN93
         86p+46irVclqrjRNRpZd+zLhQaqEjOvmPt1WVNzyZeXmlkDkpDjdi7iuv0GfJqLmE3z4
         h+kAQmogF0AzPRxXgird0S2+e25c7A8vTCcwLSynAWW0VaVExhH+oEGDicacGUfUE3e/
         LHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HigwzuIkd2mgtCXhNqT5DjNxRNzKxVeBqvUWRjiFTO8=;
        b=TLHdtHUjr9C2Bu+zudLrDMbNRyj7F9Mrf7AcqHKaBzerxMhfG8G9V+BM4Yg2BeXmC0
         TbfFH29h2zKTY8dEJ0amm6/IX8nCJG2EzYLJB/nRN+jVw6tcBGvVZ9qrVZl0aCiS/+iI
         sSpt5wf++LJFp7Jm9xbhwL2obh+ztpBdpjWSrcLec8iqpuS+Xg2urInjlEMH7WuWCabN
         EwvZ6FelKmGaYT3PhS17Fcx9r4DbJhjrozQd/7aceIg3ZCyeq216aAQmX+SQuPsupnkX
         xM9mCV8aB1+NnDf4lY66DuWbccOpi9/RrokOObZt/j+MNm2MAN5WIeYH+dSiG/v5nG9T
         H30Q==
X-Gm-Message-State: AOAM531GfQFtAdmvYNYfVBwXnzqgEhbsbsrtpmEkSk8vOFrO8Lzu/a9/
        jXViNnE1QpNlSfUiLWooks8=
X-Google-Smtp-Source: ABdhPJw7DTk/uokh2EGb/RaGa9whxkc0K4uqC9bhZyMW6QOfRKDM1uMgQW8DkuiYXVn8FnnrP+2CCg==
X-Received: by 2002:a17:902:6803:b029:da:1469:8945 with SMTP id h3-20020a1709026803b02900da14698945mr10845900plk.15.1607237242208;
        Sat, 05 Dec 2020 22:47:22 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id mr7sm6805206pjb.31.2020.12.05.22.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:47:21 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:47:11 +0900
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
Subject: [PATCH v2 2/8] linux/bitops.h: Add find_each_*_bit_reverse macros
Message-ID: <20201206064711.GA5941@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add reverse routine for find_each_*_bit using find_last_bit and
find_last_zero_bit.
for correspondant usage wtih find_each_*_bit macros we use same
parameters,
But when we use these macro different from find_each_*_bit,
@size should be a variable NOT constants.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 include/linux/bitops.h | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5b74bdf159d6..f6ab611ca732 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -50,6 +50,31 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+/**
+ * find_each_*_reverse's @size should be variable NOT constant.
+ */
+#define for_each_set_bit_reverse(bit, addr, size) \
+	for ((bit) = find_last_bit((addr), (size));		\
+	     (bit) < (size) && (size);					\
+	     (size) = (bit), (bit) = find_last_bit((addr), (size)))
+
+/* same as for_each_set_bit_reverse() but use bit as value to start with */
+#define for_each_set_bit_from_reverse(bit, addr, size) \
+	for ((size) = (bit + 1), (bit) = find_last_bit((addr), (size));	\
+	     (bit) < (size) && (size);					\
+	     (size) = (bit), (bit) = find_last_bit((addr), (size)))
+
+#define for_each_clear_bit_reverse(bit, addr, size) \
+	for ((bit) = find_last_zero_bit((addr), (size));	\
+	     (bit) < (size) && (size);					\
+	     (size) = (bit), (bit) = find_last_zero_bit((addr), (size)))
+
+/* same as for_each_clear_bit_reverse() but use bit as value to start with */
+#define for_each_clear_bit_from_reverse(bit, addr, size) \
+	for ((size) = (bit + 1), (bit) = find_last_zero_bit((addr), (size));	\
+	     (bit) < (size) && (size);					\
+	     (size) = (bit), (bit) = find_last_zero_bit((addr), (size)))
+
 /**
  * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
  * @start: bit offset to start search and to store the current iteration offset
@@ -283,17 +308,5 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
 })
 #endif
 
-#ifndef find_last_bit
-/**
- * find_last_bit - find the last set bit in a memory region
- * @addr: The address to start the search at
- * @size: The number of bits to search
- *
- * Returns the bit number of the last set bit, or size.
- */
-extern unsigned long find_last_bit(const unsigned long *addr,
-				   unsigned long size);
-#endif
-
 #endif /* __KERNEL__ */
 #endif
-- 
2.27.0
