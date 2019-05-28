Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB52C62A
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 14:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE1MI7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 08:08:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43393 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 08:08:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so11355652pfa.10
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ebFdeU/x57ZdMACMC1qwFSZewCnBUbRvAij1iV66B8w=;
        b=rzjb4ij10+/XxoGw4xo1USbcEjpbBtBE67CAkFvaT9rnRvwjnReaCSNwGBTafidpDd
         N2KAZFQmrx3PSfEKRlrzktw3gmIH2OmNKm0hzSG9LR5hM4Eo2CbGrIT8u0BJh/qQBmZR
         QTDWfDr+Ze3TiRRx/z9qozasTMLZECBVBvKtz3g9LsN14GkjdFgbcSwqBPrnbWSFdk4z
         YLILvXkBDdmuFtLGN8yh1V+5gfjBWhFxxxJQ96oOe3WwUrH8xJ4cOCm3K7SmegRz/WJm
         NwPVC/RjxwaMlySFNSNpGXbpE496iOnPSzMUcVJ/ZHkVFLCYpebb8OAaA+R92Of82ReU
         CuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ebFdeU/x57ZdMACMC1qwFSZewCnBUbRvAij1iV66B8w=;
        b=U2MOGtnO8N0exINpXazqkZ/dqIOFMCYt0S6oYyUYcHXZZUkONK4cf3vVngylVywxcf
         X7wBQoqahU1s8MlAlr6B+8uZdlbpyLG4I5YNM6Bai2mO8r78+rwoieI0Cn3AYmuwBq+K
         mJk2fvdYaa+DeZrofswwvVJxf5+dToaeyuip3eOJnyOCDNtMkcJkY9ucvriR/f+zU8/7
         C/EiVpUu57qRcLq0pPQ/b+AYD3tQDGHK61Gh5e/X3XH0OZRK9pIU0iM8ZzWgIAIFZ0JH
         m2nafQgeAg3HbJViUlt9lzoVJFPKbTM2fCZZcYFx7fgz9gVXeBf/o2aTFq9qkbiISWu+
         vo1g==
X-Gm-Message-State: APjAAAX8sR2UlobBiA/6KjwfKqTgPbWy+dRcMCahpH46reFgeR3fCW7b
        +rtANMnQSvGbX3QrnbuY4qI=
X-Google-Smtp-Source: APXvYqxWlHJ6CGIXx8iWA545z8hn9HZiC2rBd/N0Q5OS/i01zrRYILt795J+oHF1Ho4PVBFyoRgN2g==
X-Received: by 2002:a63:ee0b:: with SMTP id e11mr80785802pgi.453.1559045339023;
        Tue, 28 May 2019 05:08:59 -0700 (PDT)
Received: from bobo.local0.net (193-116-79-40.tpgi.com.au. [193.116.79.40])
        by smtp.gmail.com with ESMTPSA id d15sm37463327pfm.186.2019.05.28.05.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:08:58 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Toshi Kani <toshi.kani@hp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 2/4] mm/large system hash: avoid vmap for non-NUMA machines when hashdist
Date:   Tue, 28 May 2019 22:04:51 +1000
Message-Id: <20190528120453.27374-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528120453.27374-1-npiggin@gmail.com>
References: <20190528120453.27374-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

hashdist currently always uses vmalloc when hashdist is true. When
there is only 1 online node and size <= MAX_ORDER, vmalloc can be
avoided.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dd419a074141..15478dba1144 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8029,7 +8029,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (get_order(size) >= MAX_ORDER || hashdist) {
+		} else if (get_order(size) >= MAX_ORDER ||
+				(hashdist && num_online_nodes() > 1)) {
 			table = __vmalloc(size, gfp_flags, PAGE_KERNEL);
 		} else {
 			/*
-- 
2.20.1

