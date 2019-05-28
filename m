Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6522C629
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfE1MIz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 08:08:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35306 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MIz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 08:08:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so9170649pfd.2
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTusNcynv/bdHJGyOGAguPJgIGBXkK8mZssjLj2XyYA=;
        b=gePFim6zy/Px8intSzG3g1lUm9vIEviqyResVqM6CMdmkHMLPZyzYcfuwwNOxWJfyT
         PrAf+88EhsQYxRofAWQhwIpvu02BtlRxH6B7y9bPp7IW4+Pw9hlXglaG+/T1Rl7dEf2c
         Ig3Z4yWui4X8BvFJKwhblZtN94P9o9ze/YWo3gZ4Y/oLOWaOth0PPKAWRL02FmRw+ZhO
         eCyYQZ5uc/WVq9pca8eZV/pt/jB5V+O/cby5U0eP2B94eRM+PQasAlPHQZ/0QI2iJOch
         MXkQGbR47WKp7efgV3Z9hfcGZr2aRt3ImGKBmxlbUwF+NHv7L3aSaV9JLouvyVVxraO8
         wbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTusNcynv/bdHJGyOGAguPJgIGBXkK8mZssjLj2XyYA=;
        b=boenxwcgzlUliekvpci/c0OxnUm57Kcak/RKZnsvuP+mpsI1UN4cfOMI+PJnfNTIUS
         vWW2T23gLKQf16NJGCVfS+Gl2wAAWIIzLPkagCQ4rlfUDGRWJgGnxyCnnBviy0Gf4LMq
         HtL6n6bFB21NA/9PeCU6oJu032FTjnsTCdHhF493di+45etiE+Muv12wMI+vo26CP7+b
         W3f8i1BDNv3hol5uPxD0rh+67LgPfkppxy/vA05Ir+0OUbbwIf1+Sj/ZK5Lq7ltOmads
         9x57hp3pesTHa8gAHqRvk7UU4m4Rkd2ns5YPXRUgCXGDi3A0ErKX1Y5XoO668tx7UiaZ
         4GHQ==
X-Gm-Message-State: APjAAAXlXD+AiFvIZROLt3eFHrXJdEsCiizCdXIystS1n0AEkMZsIlP/
        rxiFVxrMD0X3qNCisfj3j8s=
X-Google-Smtp-Source: APXvYqxouyX+FBCZ+/B4VzV3O/6LZwxnEZp2c8WyrjNaNIPzurMIp7er5TLrN3wxXTQP4ciUsmcvow==
X-Received: by 2002:a62:38d8:: with SMTP id f207mr82932613pfa.131.1559045334758;
        Tue, 28 May 2019 05:08:54 -0700 (PDT)
Received: from bobo.local0.net (193-116-79-40.tpgi.com.au. [193.116.79.40])
        by smtp.gmail.com with ESMTPSA id d15sm37463327pfm.186.2019.05.28.05.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:08:53 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Toshi Kani <toshi.kani@hp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 1/4] mm/large system hash: use vmalloc for size > MAX_ORDER when !hashdist
Date:   Tue, 28 May 2019 22:04:50 +1000
Message-Id: <20190528120453.27374-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel currently clamps large system hashes to MAX_ORDER when
hashdist is not set, which is rather arbitrary.

vmalloc space is limited on 32-bit machines, but this shouldn't
result in much more used because of small physical memory limiting
system hash sizes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8abe0af..dd419a074141 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8029,7 +8029,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (hashdist) {
+		} else if (get_order(size) >= MAX_ORDER || hashdist) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
 		} else {
 			/*
@@ -8037,10 +8037,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 			 * some pages at the end of hash table which
 			 * alloc_pages_exact() automatically does
 			 */
-			if (get_order(size) < MAX_ORDER) {
-				table = alloc_pages_exact(size, gfp_flags);
-				kmemleak_alloc(table, size, 1, gfp_flags);
-			}
+			table = alloc_pages_exact(size, gfp_flags);
+			kmemleak_alloc(table, size, 1, gfp_flags);
 		}
 	} while (!table && size > PAGE_SIZE && --log2qty);
 
-- 
2.20.1

