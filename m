Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52928350B2A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 02:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDAAc1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 20:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhDAAb6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 20:31:58 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF25C061761;
        Wed, 31 Mar 2021 17:31:58 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t5so249973qvs.5;
        Wed, 31 Mar 2021 17:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaWFnvO5mlS7gtqbzZ/Rzs0v3x5NZRxF7C+mMsnpKHk=;
        b=uPbjMAV4Y2EBSJ+JfaHmNGDYq5zqdqKOAZHbsb0VSPsGNd+nTGfoYrf1P5k0poyuPw
         tpXpTqMoGwF7zx1knsS0ta5QmIUHxI1FN0437vyb7HR5bPI6WkQfADd/aLuXjYWQM7ZA
         3Ka68CkZN0/ZcSMGzk4H4PNwVn/vc1/0YH8FpDTEBAlosT9aFdk6iNcIHQuegLwYVeMH
         xI8ImgUTUgpmN0rhJhAh7UDzyUvdCpilKdzP9dCajfj4Wzo3xj2oLaH6i6VOqW/3M4EJ
         OrXxIW+Ur2NKaxX/swQTPQcfFlSgXp3UDdZWJ2CUCkYHJBRs596j6K99oqbRTXTmMY+R
         TSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaWFnvO5mlS7gtqbzZ/Rzs0v3x5NZRxF7C+mMsnpKHk=;
        b=szQIKd4fb1/DJI/acOL3IlDOyv4HldAT8usBrZzvTybr0uNrs70fngRhvExNM3xdq2
         JNELR1L3DZH0yMKDw73i/59OrSXfy4P2dJK8CzUthUD5rLbEmZtD3d3a3Te6IyRKr/RY
         cKJGsQ4ZilehfyWbwtQ9omALF9boTUkkmlq01v8zopNK9BwVqndPTkOdDr95MoP/j9mI
         /otPCmi8vQuTLFp0qW89udKNpfoKA/8hwjWAvN3PhKCRnOKrhJN7ZUit9MfSnZUkOSdW
         AgUmVqn+eee7iDM20ariwsJy7DLkq1zT+dcASRtsvsmsPT7yYuOay9c00AvgA8wlqB1j
         qzXQ==
X-Gm-Message-State: AOAM531FWTYIt6H/d/Z1WisbKNTfiNE8SrZSEEtMBF02WG3KdDMFN13W
        bLkIXm28diidbLhuvjMw9+DTMJ4FwdF1QQ==
X-Google-Smtp-Source: ABdhPJx3TATPye1tKmcmsqyRcYujzF4mgS5d9QwIHuUiHq4KtN5wUxqV7hHXZewX29Hk2iSsHq6Ckg==
X-Received: by 2002:a0c:f54d:: with SMTP id p13mr5641362qvm.32.1617237116796;
        Wed, 31 Mar 2021 17:31:56 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id j6sm2771537qkl.84.2021.03.31.17.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 17:31:56 -0700 (PDT)
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
Subject: [PATCH 01/12] tools: disable -Wno-type-limits
Date:   Wed, 31 Mar 2021 17:31:42 -0700
Message-Id: <20210401003153.97325-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401003153.97325-1-yury.norov@gmail.com>
References: <20210401003153.97325-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GENMASK(h, l) may be passed with unsigned types. In such case, type-limits
warning is generated for example in case of GENMASK(h, 0).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/scripts/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 84dbf61a7eca..15e99905cb7d 100644
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

