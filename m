Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC172D0152
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 07:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgLFGuz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 01:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgLFGuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 01:50:54 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DECDC0613D1;
        Sat,  5 Dec 2020 22:50:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t7so6834790pfh.7;
        Sat, 05 Dec 2020 22:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ypwZ5TJczitF9QTNYb1eQHpigAlJXUjONalTOOQxjJo=;
        b=WrIclN8u3gJc5aASq2lzZyklgOq9xNWCLtUJH0+9GnBkfEdGqTX0/S1+JuClS02CvS
         VnTH8WxR0zfyPLUGvor+Gw2FatWRT7JIGjvd4q/YBySUzxX/Jdkm69wRWittEAviR/5c
         Dj77Jmx2plHcbkp/jr4LOH3ici6sKcY2Vg7oHiFfl2+vdQUiqCn9Qiiq0h8TyKB1P3ct
         25ACCGcJViDv08IPCroseyURIxZDB1q75qwFZaMyXyHl0UsxpfQssS8GxrKaT7iC4HRH
         zUgp7kTMOgc58s9KeS+/CUVqwxzsQWYhPXiZyuyvUDbRzvgl9pdUV3E2ux9F+i4guvJ5
         kMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ypwZ5TJczitF9QTNYb1eQHpigAlJXUjONalTOOQxjJo=;
        b=Z/r14tMAuS0SXRcIKyzYJlnh71PAEZjZQtJdJBBleeXnLnKaNhVWz5rNZDdFrJFo8i
         /dQmcZWgwYZmygL0tOvt6bvsBGbEoISJ4iPQT9AqbMRnrr+Y0XtzsiL0hfJ0XvZhcaEn
         jX0UnzEeMsSeQ1Rx4wCg7fNyM9yYIs2sZUKxOgYQdYlPQ4CDGuzLqc5Ow7Ka7qUndaWD
         vg2UK+5aTsKRveXBRUbkjUmAvOsO0cwVfs2TENij22DTbEBPrqM9srVRFYn64hXV8gJl
         2WFo0mleQ4F4XW2/lSCdQMFrJI+JhWnfvVEW58dQ79tpUyUIGeWih7XA2VxsXreMLXqt
         3Ufw==
X-Gm-Message-State: AOAM5326T+877Kd836gPqQVRMgDr+PtvFlts/x7WfDq1BknNbTujY0hM
        tMD4JqqrgplO+10q+YsW8oA=
X-Google-Smtp-Source: ABdhPJwBulqK1DTiwONOzE3GRKoeRWagxoYhjna5DIYLnkQmEJuCiRz78CSo06QnXZsvtjOefFw98w==
X-Received: by 2002:a63:1456:: with SMTP id 22mr14010264pgu.108.1607237413841;
        Sat, 05 Dec 2020 22:50:13 -0800 (PST)
Received: from ubuntu ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id 21sm2007441pfx.84.2020.12.05.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 22:50:13 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:50:04 +0900
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
Subject: [PATCH v2 7/8] btrfs/free-space-cache.c: Apply find_last_zero_bit
Message-ID: <20201206065004.GA6321@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In steal_from_bitmap_to_front function, it finds last_zero_bit from i
using for_each_clear_bit.
But this makes some overhead that it starts from the 0 bit.
By adding find_last_zero_bit, I try to remove this overhead and
improve readibility.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 fs/btrfs/free-space-cache.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af0013d3df63..6d393c834fdd 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2372,7 +2372,6 @@ static bool steal_from_bitmap_to_front(struct btrfs_free_space_ctl *ctl,
 	u64 bitmap_offset;
 	unsigned long i;
 	unsigned long j;
-	unsigned long prev_j;
 	u64 bytes;
 
 	bitmap_offset = offset_to_bitmap(ctl, info->offset);
@@ -2388,20 +2387,15 @@ static bool steal_from_bitmap_to_front(struct btrfs_free_space_ctl *ctl,
 		return false;
 
 	i = offset_to_bit(bitmap->offset, ctl->unit, info->offset) - 1;
-	j = 0;
-	prev_j = (unsigned long)-1;
-	for_each_clear_bit_from(j, bitmap->bitmap, BITS_PER_BITMAP) {
-		if (j > i)
-			break;
-		prev_j = j;
-	}
-	if (prev_j == i)
-		return false;
+	j = find_last_zero_bit(bitmap->bitmap, i);
 
-	if (prev_j == (unsigned long)-1)
-		bytes = (i + 1) * ctl->unit;
-	else
-		bytes = (i - prev_j) * ctl->unit;
+	if (j == i) {
+		if (!test_bit(i, bitmap->bitmap))
+			return false;
+		else
+			bytes = (i + 1) * ctl->unit;
+	} else
+		bytes = (i - j) * ctl->unit;
 
 	info->offset -= bytes;
 	info->bytes += bytes;
-- 
2.27.0
