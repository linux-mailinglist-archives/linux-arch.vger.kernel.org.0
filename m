Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B765AC906
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiIEDTO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 23:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiIEDTN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 23:19:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CE2CCB7
        for <linux-arch@vger.kernel.org>; Sun,  4 Sep 2022 20:19:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p18so7281271plr.8
        for <linux-arch@vger.kernel.org>; Sun, 04 Sep 2022 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PEBNU+8s+VnALvQ6Q/IzE/cDD6Z9rPpGFYpAvTluUdA=;
        b=F0+uNGBvE+2CtGsEqZT0AF8jPuu+opDZBImWfimmC+VQHNjroxwPmQC2MJTHqbCgvi
         BkvPcEKFZfLNYpnPvjwzfREuRTo6F1LYaLV6s8376xQHZ3pgv3oyS880MaJmSD80ZAC+
         mRK3M9dPkIooWaWspTsgh4vbSlcM2F+THaI6LeZcn4wU0KIr2BjplXA82lRwVGkSDw6B
         x0KIKFdMt7ZDlLuSB35nkCgXh0ZObbsOOIjobt/StnDhUG9G+RBT+mYjxa3nCKoS7RIE
         uLa2esHslmqAOBbXSQjPkc1QX2UPTtUsKalWMOROUIM3aSk0ZcJIF6yL0eUMmQurA91r
         ga3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PEBNU+8s+VnALvQ6Q/IzE/cDD6Z9rPpGFYpAvTluUdA=;
        b=guLsB/E40KJUweE4IVAN7ViKa7d7A01UVTcDMicz+yFOV+xj5lNXOacNLdqiLp0OQW
         sZYg5IQNT7x04pLy0mOkYWiQEzPLSNrIG53A1ygusLnIfZ4PD/Iww5rU8C5VyFX0wgR3
         tkp4qOmeRWbEDl+TO/lJTtHnEdZw2QJw9guADu9QtFtF0Ko9P6Up3mqx9cOIESv5BilR
         WF1Vbbj8MlaZNxButcfLXIpC435u95Pjy/Ynevi9DXhkjFnuzdY2CZKxiZnVuu8l/Wlc
         yOBVNVV+nJCil7CDNiZHHlkvg8AhhCWWZdwoCzt31sdKT24bKByo8bm1/Eh+OL3zN5fz
         32fg==
X-Gm-Message-State: ACgBeo1AU+hA8ZmZZWo4YpDSmutOoTLW2WoLwdD92nCe/pOtflnyTk0t
        fFv9viRdIydw1Swhc0cO3OMHsTFNq58=
X-Google-Smtp-Source: AA6agR43w+NDYUTnu61XS+s5J66CM61nmSKR7p14TTvmFwfyqp9XVpoGl4hr68Biep46zEq0EzAoHw==
X-Received: by 2002:a17:90b:1bc4:b0:1fd:b913:ef58 with SMTP id oa4-20020a17090b1bc400b001fdb913ef58mr16797701pjb.220.1662347949665;
        Sun, 04 Sep 2022 20:19:09 -0700 (PDT)
Received: from localhost.localdomain ([202.133.199.56])
        by smtp.gmail.com with ESMTPSA id az11-20020a056a02004b00b004296719538esm5366901pgb.40.2022.09.04.20.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:19:09 -0700 (PDT)
From:   Matthias Goergens <matthias.goergens@gmail.com>
To:     linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] tools/headers: Fix undefined behaviour (34 << 26)
Date:   Mon,  5 Sep 2022 11:19:04 +0800
Message-Id: <20220905031904.150925-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <a8f4cf90-8ae7-0542-8363-d425dfdecb0a@infradead.org>
References: <a8f4cf90-8ae7-0542-8363-d425dfdecb0a@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Left-shifting past the size of your datatype is undefined behaviour in
C.  The literal 34 gets the type `int`, and that one is not big enough
to be left shifted by 26 bits.

An `unsigned` is long enough (on any machine that has at least 32 bits
for their ints.)

For uniformity, we mark all the literals as unsigned.  But it's only
really needed for HUGETLB_FLAG_ENCODE_16GB.

Thanks to Randy Dunlap for an initial review and suggestion.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 include/uapi/asm-generic/hugetlb_encode.h  | 26 +++++++++++-----------
 tools/include/asm-generic/hugetlb_encode.h | 26 +++++++++++-----------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/uapi/asm-generic/hugetlb_encode.h b/include/uapi/asm-generic/hugetlb_encode.h
index 4f3d5aaa11f5..de687009bfe5 100644
--- a/include/uapi/asm-generic/hugetlb_encode.h
+++ b/include/uapi/asm-generic/hugetlb_encode.h
@@ -20,18 +20,18 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16KB	(14U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
diff --git a/tools/include/asm-generic/hugetlb_encode.h b/tools/include/asm-generic/hugetlb_encode.h
index 4f3d5aaa11f5..de687009bfe5 100644
--- a/tools/include/asm-generic/hugetlb_encode.h
+++ b/tools/include/asm-generic/hugetlb_encode.h
@@ -20,18 +20,18 @@
 #define HUGETLB_FLAG_ENCODE_SHIFT	26
 #define HUGETLB_FLAG_ENCODE_MASK	0x3f
 
-#define HUGETLB_FLAG_ENCODE_16KB	(14 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_64KB	(16 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512KB	(19 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1MB		(20 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2MB		(21 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_8MB		(23 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16MB	(24 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_32MB	(25 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_256MB	(28 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_512MB	(29 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_1GB		(30 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_2GB		(31 << HUGETLB_FLAG_ENCODE_SHIFT)
-#define HUGETLB_FLAG_ENCODE_16GB	(34 << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16KB	(14U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_64KB	(16U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512KB	(19U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1MB		(20U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2MB		(21U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_8MB		(23U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16MB	(24U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_32MB	(25U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_256MB	(28U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_512MB	(29U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_1GB		(30U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_2GB		(31U << HUGETLB_FLAG_ENCODE_SHIFT)
+#define HUGETLB_FLAG_ENCODE_16GB	(34U << HUGETLB_FLAG_ENCODE_SHIFT)
 
 #endif /* _ASM_GENERIC_HUGETLB_ENCODE_H_ */
-- 
2.37.3

