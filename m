Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63531E504
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 05:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBREJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 23:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBREHG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2021 23:07:06 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39421C0611C3;
        Wed, 17 Feb 2021 20:05:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f17so525096qth.7;
        Wed, 17 Feb 2021 20:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84gBY6rinb7deZXraCF0UsTbJivw5Olo0gL8/eJ63tU=;
        b=KxfSS6niVzijRzEtdP/DC9eQUkwlu1PvxSxEgcuFub2GuTOz4WaJzl7H/fCoy3S4+a
         eY4RldJTLxIdrBcLG0vRW7OXyBIjEZFa7saILAydNPEBgUNEHizOdS7B/TEiEx0rbstR
         rev03iKVpZhbH2hPkQYiQIqUWyIcgRFiVWM1RG12hesTBatJevDd7loVlToiG+B1atGS
         rGcBdPLVhqF6B8ANXWe6OR4SLeGgwF4iP707XgAkmtbFwUetmpHypCVFnhwUR5kfALT5
         tlH5Sd+YLHI0F27k+7ecClMw1Obo98OnA0M042LYX8TCbWfoaLW7/YKRMUA+KYUrLYwI
         MPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84gBY6rinb7deZXraCF0UsTbJivw5Olo0gL8/eJ63tU=;
        b=Wc8ZQJ0jPvOcl+LG0wzPl4ISJmS6kNHMtELuDmslnDuDzhK0ptsp5NEb/8fs1td6xN
         YfRTg2TnrtVgOdhd1VOZBSvwgHI4t6mUh3zIpddiAUqfCbaZuLZopBVA5kw2dFzvqvQ6
         XrMb/gZ13i15ABOT61fGqgIFXGQ97BT+SIU81U8a/0wMaPcKjnM73wn8nZ73dHZrwKTI
         0wahFeM94f0XCmSTCJBlvxCxvQhwskhxBXVNc7xGyZmUFlg26vA1Ltc9rVYl8QvkmdbX
         UCS1pq0rgXJ3VHkTcU0w6c0eVJV07fsASeRXDwqTabkQsXbtci8PRgudltgr2kSx41Hh
         dfkg==
X-Gm-Message-State: AOAM531by5KdfynW+pi0UFePdp8Hb5qVH1GH1UU2vghBBpBjs4vkRBX4
        bpNYXaRDsbXU/ODuUm6Be7v01vpI2RCHhg==
X-Google-Smtp-Source: ABdhPJwZifiZxE3P8q/lcvCbxJp+cC2M2zwuZmUjKMFL5WEt9kpRarYcAFb6PR4VznGQdSPl6yydfw==
X-Received: by 2002:ac8:5d44:: with SMTP id g4mr2660798qtx.93.1613621131027;
        Wed, 17 Feb 2021 20:05:31 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id b20sm2748495qto.45.2021.02.17.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 20:05:30 -0800 (PST)
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
Subject: [PATCH 14/14] MAINTAINERS: Add entry for the bitmap API
Date:   Wed, 17 Feb 2021 20:05:12 -0800
Message-Id: <20210218040512.709186-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218040512.709186-1-yury.norov@gmail.com>
References: <20210218040512.709186-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add myself as maintainer for bitmap API.

I'm an author of current implementation of lib/find_bit and an
active contributor to lib/bitmap. It was spotted that there's no
maintainer for bitmap API. I'm willing to maintain it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7bdf12d3e0a8..9f8540a9dabf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3146,6 +3146,20 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BITMAP API
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	include/asm-generic/bitops/find.h
+F:	include/linux/bitmap.h
+F:	lib/bitmap.c
+F:	lib/find_bit.c
+F:	lib/find_find_bit_benchmark.c
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

