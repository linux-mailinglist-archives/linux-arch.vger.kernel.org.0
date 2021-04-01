Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFA350B3F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhDAAck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhDAAcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:32:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F9C06175F;
        Wed, 31 Mar 2021 17:32:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v70so646451qkb.8;
        Wed, 31 Mar 2021 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5eR+cvpKZq1WYNNc805w7v5z1Gu54WewjgBw3zPSZw=;
        b=eG+/eqlEB+D/yCNe7zlVJgHe15xLKvk+EdruRzRsHl8qL/OhqO2s4dBJBxM54EXgOO
         sCApJaxsKTtoojPLbTTSpuKyrigZD5/pmm9f7gujpq1eFmjn9AjMqHAclzQy+wdv/GxB
         4wIWcjcGJff8bilTKqOLXpVLeDm1tNLF3MKReIcz0PpZ8BNPVGTJCvMsK2VIfftig54u
         0fem+lyi70p1L/YcNcsux7loTpIg2DBQOuDqIMMEi9FFRdmLfiiJz8Fgf/O3TK414z5o
         AmFmvH0rye2Uc2Vggamo66a6V0KRyb6Mtfm4M9V743MNySC13rw8n+2qN2nyjdZq19eQ
         VOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5eR+cvpKZq1WYNNc805w7v5z1Gu54WewjgBw3zPSZw=;
        b=oV7RaU0hwnNM5VdEiLE8dlxtzNmrJGywCidJSHQgl/RJChpEhWHBU7RLv00it6BIAr
         lS5cDPPaXOhhPL4UaPr/S33b1actGMkNCjnLPHAACyBgfspJxPCDbYBUbINXknqE80uJ
         zrkcnOUkMW+8pbuGGBVpNgtt9czkursAic3YPbUnaRSNibg1RCWn82AxelY+ZiBpoE0V
         cALnWd1aDH1UKy9MRx57IbS22Rg95DGv61I+l519zkd9zH0VeTe1o69Kuln+IqdOc8Ss
         Asht2UQ/9yxQPVknyDK+ukbMek7rqyzKsAEh7ggYfqFPUO5wauqVTVM+FIj594OlJNy2
         uFiw==
X-Gm-Message-State: AOAM533mOU9lEzjr3DMOZclNVQg/HpCj0Pt1L1UbbJpk/6u7bjZgMJ43
        sAFfhlxwWmMtgdjhQu0OQb4PntNtvkS3fw==
X-Google-Smtp-Source: ABdhPJwZYb/UGumLv+aImCXZA08eHtGRinQM4tEe5XNBd32JW273HOB7CohLCLtXAs7On6YDaUZKOQ==
X-Received: by 2002:a05:620a:1353:: with SMTP id c19mr6046144qkl.392.1617237128944;
        Wed, 31 Mar 2021 17:32:08 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id d24sm2655513qko.54.2021.03.31.17.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:32:08 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
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
Subject: [PATCH 12/12] MAINTAINERS: Add entry for the bitmap API
Date:   Wed, 31 Mar 2021 17:31:53 -0700
Message-Id: <20210401003153.97325-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add myself as maintainer for bitmap API and Andy and Rasmus as reviewers.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bbd4484b5ba6..fcf89f8cbb6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3172,6 +3172,22 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BITMAP API
+M:	Yury Norov <yury.norov@gmail.com>
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
+S:	Maintained
+F:	include/asm-generic/bitops/find.h
+F:	include/linux/bitmap.h
+F:	lib/bitmap.c
+F:	lib/find_bit.c
+F:	lib/find_bit_benchmark.c
+F:	lib/test_bitmap.c
+F:	tools/include/asm-generic/bitops/find.h
+F:	tools/include/linux/bitmap.h
+F:	tools/lib/bitmap.c
+F:	tools/lib/find_bit.c
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
-- 
2.25.1

