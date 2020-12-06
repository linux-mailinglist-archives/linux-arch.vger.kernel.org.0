Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15E2D0159
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLFGvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLFGvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:51:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BBC0613D4;
        Sat,  5 Dec 2020 22:50:51 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 11so611892pfu.4;
        Sat, 05 Dec 2020 22:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FX0UailaNX0q+4Z+Y5R9hIxj0ArhyVPsbwe2N/jEEzM=;
        b=YQWA/4ZTe6M9q3MYP55f69EOLM9UY5efkxhwcV0Bwv0uj88o9COAFSRYJY7pBndWOd
         ICSlePTIlrnvZvMc1BR0pQbhhDfT2t/tVhNg55npDn98IUnh7g66B/u4Rl5adDmqosxM
         i1qELRcX1rtFXX82Kx8XZgTVDkz/FmxXPuPWXAgUxrOKXIvo/8n4IBLcVgC622HEdaDz
         BXkYhNG2in8wR9Fc5cucJEz1whldUnEfbeQvJrXpJxRU/ejdPOwZbwU40UULo6sqMUo2
         afDB43BYkRChqcE9zOkqCfJpXCiIEdBNU5KHxDAYEbckiluDwUL/90cImovoW6NdwASx
         f8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FX0UailaNX0q+4Z+Y5R9hIxj0ArhyVPsbwe2N/jEEzM=;
        b=QNadYS+ZKwtK2oViKiwsWN9KZgzXEW7kMnzaSqHSucH5MRH6VG+htFzL4f2FluGtrv
         iIBFvtaUU+Y3q2yc9UcTkKOH5fl1+4dMV/ChsU7jna3ZAPIhOoDidyyD0yduVHDnJjTj
         aByB/rqgIPL3Cm6W6+tuIOmve804qV+9ABhQdutMjMG1tom4pYvft9H+N0OzB3PTe64V
         TDCUyYobM7zLAPRdXQSI9trHch6dRjBbeAvRjaWvxr5qXm0+/KaER/DK+stqSgiZKb/3
         e37pwhAHp2IgFmDaqbA0foMnH28VCUnap4ow1NZ/pfMRHQOtEIq91iGSP35MyOCGMlsS
         nFeg==
X-Gm-Message-State: AOAM530Sc25VEHi4UmSE6FMQXl3nT11uGNJE1zkS/7f6/YL+05Ty36e9
        9O3ksjoPraGth2eap4eBYp8=
X-Google-Smtp-Source: ABdhPJzuwuSeBYeYRy4WQup+GzCaOHrHXR0vxzD0VDqSyoE/RH8FPQ1/Qdn7NdGJhugZrmwZ4HzhXQ==
X-Received: by 2002:a65:490c:: with SMTP id p12mr13995291pgs.98.1607237450811;
        Sat, 05 Dec 2020 22:50:50 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id z23sm2182499pfn.202.2020.12.05.22.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:50:50 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:50:40 +0900
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
Subject: [PATCH v2 8/8] ufs/util.h: Apply new find_last_zero_bit.
Message-ID: <20201206065040.GA6385@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Former find_last_zero_bit in ufs makes complie error when we add
find_last_zero_bit in lib/find_bit.c
We remove former find_last_zero_bit in ufs which iterates per char,
And apply new find_last_zero_bit in lib.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 fs/ufs/util.h | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 4931bec1a01c..3024f2076feb 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -413,29 +413,6 @@ static inline unsigned _ubh_find_next_zero_bit_(
 	return (base << uspi->s_bpfshift) + pos - begin;
 } 	
 
-static inline unsigned find_last_zero_bit (unsigned char * bitmap,
-	unsigned size, unsigned offset)
-{
-	unsigned bit, i;
-	unsigned char * mapp;
-	unsigned char map;
-
-	mapp = bitmap + (size >> 3);
-	map = *mapp--;
-	bit = 1 << (size & 7);
-	for (i = size; i > offset; i--) {
-		if ((map & bit) == 0)
-			break;
-		if ((i & 7) != 0) {
-			bit >>= 1;
-		} else {
-			map = *mapp--;
-			bit = 1 << 7;
-		}
-	}
-	return i;
-}
-
 #define ubh_find_last_zero_bit(ubh,begin,size,offset) _ubh_find_last_zero_bit_(uspi,ubh,begin,size,offset)
 static inline unsigned _ubh_find_last_zero_bit_(
 	struct ufs_sb_private_info * uspi, struct ufs_buffer_head * ubh,
@@ -453,15 +430,14 @@ static inline unsigned _ubh_find_last_zero_bit_(
 			    size + (uspi->s_bpf - start), uspi->s_bpf)
 			- (uspi->s_bpf - start);
 		size -= count;
-		pos = find_last_zero_bit (ubh->bh[base]->b_data,
-			start, start - count);
-		if (pos > start - count || !size)
+		pos = find_last_zero_bit_le(ubh->bh[base]->b_data, start + 1);
+		if ((pos < start + 1 && pos > start - count) || !size)
 			break;
 		base--;
 		start = uspi->s_bpf;
 	}
 	return (base << uspi->s_bpfshift) + pos - begin;
-} 	
+}
 
 #define ubh_isblockclear(ubh,begin,block) (!_ubh_isblockset_(uspi,ubh,begin,block))
 
-- 
2.27.0
