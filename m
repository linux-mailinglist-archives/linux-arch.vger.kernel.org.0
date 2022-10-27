Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CA60EF19
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 06:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiJ0EiY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 00:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ0EiS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 00:38:18 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE714D1CE;
        Wed, 26 Oct 2022 21:38:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i12so315710qvs.2;
        Wed, 26 Oct 2022 21:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAVctpr4Foqzwmq/8lLQnNPWsibHQgV5zVJ+LmSnobA=;
        b=UuKCjQP8ZW2SctP3nvJFTdHPIXTKXnnE2JToPG+a2xe0a4lwOJgzOjMtrgtjey9okJ
         o6s21sWcrOnFCLGGiYX1Ud+t8lXJkemF9z2Mj1oAIppGpLhPBdENsIn/7wmu9Ik4Tdpj
         ZaGFg8S465UtnH7PQWbUfW4AkkSzBa2eWbSAjIzglg6a03Q6TaRv5aSPXX5fE0WHh2A/
         +Uou7NuqMw4b2f9WcloBTWC+cyo8ELT2mXUl/YYDO04ihDGDsUHxJyZFLpwi8tvd3uI6
         Ho1ui6UrnwdwKC4bV/ungur9LNFFvnLpphxhLxf5R1lQFfREE+i1LS7Y4QLk5oSWKxMz
         2CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAVctpr4Foqzwmq/8lLQnNPWsibHQgV5zVJ+LmSnobA=;
        b=6JV8GOqxOHdUJzWh7v7FxoqVPFJpq+Ca6IZlgSz/SkXQ2BlmR23uB6a/E+3ckqEfnC
         4D+7Bn5g2kUGiAayeApWOzIA4Tahj7WkKrUYQPrtAMYpVeNt0rySelb6nDiGdbMktRaH
         pqNdGbnkZQAiw9DbBDRYZ4/l8OlfKiDWr6l/eSlCOUWMeouZb170piibXdNq/fM33wEE
         JpYnRN6T5ug8zEFUNNQa77xBOnKnglLpPMwV3tS97LhashG9D9lkPr6VMZkSJMuCk92G
         z5UYzVSMiOW6cHy3g/7ukmcXhYzlEhn3MVk9mwh/1oiNMti1rF11sU5DcCxeYUDbOa84
         q5YQ==
X-Gm-Message-State: ACrzQf0lF+nMaOxLyQlQ7ieffIFItq59kMffObwiZzw8XhwaAIXm1euG
        D7H51EpBYBJnNgjl+IWTkH5Y11duJ7U=
X-Google-Smtp-Source: AMsMyM4YBwpuDAiofyXBx6bu71A8JyAwOkUf9hqrUE204qUMiDenNd3IFrAbX4IZ8HBBnPBn6BXkGA==
X-Received: by 2002:a05:6214:21ae:b0:4b4:3c9:71f6 with SMTP id t14-20020a05621421ae00b004b403c971f6mr39868870qvc.17.1666845496972;
        Wed, 26 Oct 2022 21:38:16 -0700 (PDT)
Received: from localhost ([2601:589:4102:7400:ade5:9c32:44f6:bc7d])
        by smtp.gmail.com with ESMTPSA id q68-20020a378e47000000b006b929a56a2bsm358504qkd.3.2022.10.26.21.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:38:16 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/3] bitmap: add tests for find_next_bit()
Date:   Wed, 26 Oct 2022 21:38:10 -0700
Message-Id: <20221027043810.350460-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027043810.350460-1-yury.norov@gmail.com>
References: <20221027043810.350460-1-yury.norov@gmail.com>
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

Test out-of-line and inline paths of find_next_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index a8005ad3bd58..becf9c7a95a1 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -221,7 +221,7 @@ static void __init test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
-static void __init test_find_nth_bit(void)
+static void __init test_find_bit(void)
 {
 	unsigned long b, bit, cnt = 0;
 	DECLARE_BITMAP(bmap, 64 * 3);
@@ -236,6 +236,25 @@ static void __init test_find_nth_bit(void)
 	__set_bit(80, bmap);
 	__set_bit(123, bmap);
 
+	expect_eq_uint(10,  find_next_bit(bmap, 64 * 3, 0));
+	expect_eq_uint(20,  find_next_bit(bmap, 64 * 3, 11));
+	expect_eq_uint(30,  find_next_bit(bmap, 64 * 3, 21));
+	expect_eq_uint(40,  find_next_bit(bmap, 64 * 3, 31));
+	expect_eq_uint(50,  find_next_bit(bmap, 64 * 3, 41));
+	expect_eq_uint(60,  find_next_bit(bmap, 64 * 3, 51));
+	expect_eq_uint(80,  find_next_bit(bmap, 64 * 3, 61));
+	expect_eq_uint(123, find_next_bit(bmap, 64 * 3, 81));
+
+	/* Test small_const_nbits_off() optimization path */
+	expect_eq_uint(10,  find_next_bit(bmap, 20 + 0,  0));
+	expect_eq_uint(20,  find_next_bit(bmap, 20 + 11, 11));
+	expect_eq_uint(30,  find_next_bit(bmap, 20 + 21, 21));
+	expect_eq_uint(40,  find_next_bit(bmap, 20 + 31, 31));
+	expect_eq_uint(50,  find_next_bit(bmap, 20 + 41, 41));
+	expect_eq_uint(60,  find_next_bit(bmap, 20 + 51, 51));
+	expect_eq_uint(80,  find_next_bit(bmap, 20 + 61, 61));
+	expect_eq_uint(90,  find_next_bit(bmap, 20 + 70, 81));
+
 	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3, 0));
 	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3, 1));
 	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3, 2));
@@ -1226,7 +1245,7 @@ static void __init selftest(void)
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
 
-	test_find_nth_bit();
+	test_find_bit();
 	test_for_each_set_bit();
 	test_for_each_set_bit_from();
 	test_for_each_clear_bit();
-- 
2.34.1

