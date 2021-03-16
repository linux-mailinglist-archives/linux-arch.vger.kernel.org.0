Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5AD33CB10
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhCPBzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbhCPByg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:54:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03EC061756;
        Mon, 15 Mar 2021 18:54:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m186so17165163qke.12;
        Mon, 15 Mar 2021 18:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vsxq/BYaOhXRPMajeTvCxxHfGiz3cCtVlQm39yRChI0=;
        b=MnzpENMqXJpH+a4c9YRKsAwFANMQocDPdu29xsKPDZ1sdtFP8Gk6H/Y4XUFJcTWOXH
         h9hzseuLwPcuTWibwZjsOXrz9FIDHe4nhpfPDo3uV4nbmCaqhAOClJyqooTQT/bgrXxX
         gBfrCzckrIMcCdA/by+rK1XwHn2NrR2HBHM6ITp0iKdf+QRwcb8qqd/vs9teI2EC+bfc
         BuvLJlm0qBsifU2emYLG9nC65VC8FSGY9Rup49Li7jY6NckTWE+qWrIp3Cbw/J+JHIaI
         EpPlzt9pF9eKKiA640pPvdkK+pSp3RyZdjbyZsNOglaYsTiWWHoiiltWeSIupuFzenfh
         hcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vsxq/BYaOhXRPMajeTvCxxHfGiz3cCtVlQm39yRChI0=;
        b=YwlbRPnZ1stYea2fcqotX9/mTRJtMllsTwIjy0OyOy2QAGtnu70nhXd/rkFKrNKPDK
         jhpuAHLkQvv4zgs0IjKgsQCAAHQyubIUb/EtzyRoo2Gw7Umsw4ooXnocyZn40+kDBD+O
         d2etUTl53HawqzLLq9VpKQxA+ow9fw7v/ZGXQO8CoWXJun3hz0+E0ApbeFiPA69S48mg
         raPA8ft9r5XlQRIKcdhmT9w3jbhSIX5F4bBN/qV4yWrqDqIcE5YTeQF3YkoNbz75g7FH
         SqZNHjgLqIVmBinHB00mg0A0BZw6Orp+wSyl+sPNHKQDIl2psc6rjbazsDeonk5UFbnB
         kmmA==
X-Gm-Message-State: AOAM530R3pKqS+RqDLwE6pT88I9CQiLmgHGBZBz/Q+ckmeMHCjHT6QZ2
        liZZl3IoSojO1EcX7ak5ypIlxcHx1fA=
X-Google-Smtp-Source: ABdhPJy7Zki7/iEadALFBHbY1VHsTMZue5e1t84X+gn2LOTHSvMfe5UBxoyfCkUsZLZHAcwmJQn0qQ==
X-Received: by 2002:a37:274f:: with SMTP id n76mr28133907qkn.15.1615859675140;
        Mon, 15 Mar 2021 18:54:35 -0700 (PDT)
Received: from localhost ([76.73.146.210])
        by smtp.gmail.com with ESMTPSA id c19sm13862587qkl.78.2021.03.15.18.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:54:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 06/13] lib: extend the scope of small_const_nbits() macro
Date:   Mon, 15 Mar 2021 18:54:17 -0700
Message-Id: <20210316015424.1999082-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210316015424.1999082-1-yury.norov@gmail.com>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

find_bit would also benefit from small_const_nbits() optimizations.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/asm-generic/bitsperlong.h | 9 +++++++++
 include/linux/bitmap.h            | 3 ---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 3905c1c93dc2..96032f4f908f 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -23,4 +23,13 @@
 #define BITS_PER_LONG_LONG 64
 #endif
 
+#define SMALL_CONST(n) (__builtin_constant_p(n) && (unsigned long)(n) < BITS_PER_LONG)
+
+/*
+ * The valid number of bits for a bitmap to be small enough, or in other words,
+ * fit into a single machine word is 1 to BITS_PER_LONG inclusively. 0 is not a
+ * valid number for size, and most probably a sing of error.
+ */
+#define small_const_nbits(n) SMALL_CONST((n) - 1)
+
 #endif /* __ASM_GENERIC_BITS_PER_LONG */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index adf7bd9f0467..bc13a890ecc1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -224,9 +224,6 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
  * so make such users (should any ever turn up) call the out-of-line
  * versions.
  */
-#define small_const_nbits(nbits) \
-	(__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && (nbits) > 0)
-
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-- 
2.25.1

