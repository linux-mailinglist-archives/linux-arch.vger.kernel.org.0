Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1173A3097E6
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 20:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhA3TSH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 14:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhA3TSE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jan 2021 14:18:04 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72825C0613D6;
        Sat, 30 Jan 2021 11:17:24 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d85so12243737qkg.5;
        Sat, 30 Jan 2021 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYiQfFq/A5BR3ytboda9uqIsF/im+3k0MVGIuMp7ujI=;
        b=SWZHt8afF+bUg7hz5AK6ufFfR/vccmv++nacOxTzAUOWuHUzr0NxSRBZ7Nhqv0N/38
         wZFL9lKeCTHsPJiFWQRdv3PQ4q9CCJwbfTBMp33EfZyNA9kKR1NxspUzLVG2FjJ4/5sY
         /eV5UxIjMT6saqoPvlDv6q4y09iP8ysVL+YpPL7ipJf9bySlY5rfFqsozV1CVd6OOupP
         ogFa6HRyZO2UHtiS6ro+YxkKPkgjT7C9o5TCN/pkZ670dvwWf50TuY0i4NhXx/2A9Hwh
         88QRZm6qd8mdiZUDddvd582Qthaqc5245aK8eoJ4R+tuxIZJbZmekNW3ZcXOPUKpp/Es
         45Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYiQfFq/A5BR3ytboda9uqIsF/im+3k0MVGIuMp7ujI=;
        b=Myj8NQbLSRbADgFbWSz3NhF67djj6vMN6FSo1b8CFCnlcsk42RmTxbyePkKX0pnXjU
         kUpDr7WIfQlhwhxEE+ni0/DAD6hYyemirGmlfYdI+17CkbOCESZpjVi10RJtyBYUjiC3
         6+ji3OD6krnEEDXQm1mfCR7xpkrJjqZGZQAhZ3pUJ/hDBuEhtIwH4i2O5dBXNwFsioZp
         ccYoYIADIGxT3lV/I0YzArJbNSAdq74w/+p3VGh9KlGp4NC72gA3UNWuhoPzc5L16Hni
         15QYPzx5YhKnUpdxN5b5KHLPTWasCPICrRQ6PG9RC5x50GetSTj2kvXCWM2AsQ9vx5cq
         P7FQ==
X-Gm-Message-State: AOAM5313D/kZT4l+KdOw5kuWqm6SAwqg46cBWu3d3Ted4Derq9vM7O+T
        +XVOH9kEI9zdBq01HFXHoq0=
X-Google-Smtp-Source: ABdhPJyhF5sM0r3+bGB/gd20doSeBcG2SJucdkNA81U7bleGmrppTt6Gs7pR5c+MSjB/UgXRTINP7w==
X-Received: by 2002:a37:be04:: with SMTP id o4mr9686463qkf.336.1612034243691;
        Sat, 30 Jan 2021 11:17:23 -0800 (PST)
Received: from localhost (d27-96-190-162.evv.wideopenwest.com. [96.27.162.190])
        by smtp.gmail.com with ESMTPSA id t17sm9130830qtq.57.2021.01.30.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 11:17:23 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 1/8] tools: disable -Wno-type-limits
Date:   Sat, 30 Jan 2021 11:17:12 -0800
Message-Id: <20210130191719.7085-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130191719.7085-1-yury.norov@gmail.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GENMASK(h, l) may be passed with unsigned types. In such case,
this warning is generated for example in case GENMASK(h, 0)

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 tools/scripts/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 1358e89cdf7d..58bb319624f6 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -38,6 +38,7 @@ EXTRA_WARNINGS += -Wswitch-enum
 EXTRA_WARNINGS += -Wundef
 EXTRA_WARNINGS += -Wwrite-strings
 EXTRA_WARNINGS += -Wformat
+EXTRA_WARNINGS += -Wno-type-limits
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
-- 
2.25.1

