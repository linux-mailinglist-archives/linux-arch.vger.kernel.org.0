Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF34B57E07B
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGVLHa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVLHa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 07:07:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E2501B6;
        Fri, 22 Jul 2022 04:07:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z13so6006021wro.13;
        Fri, 22 Jul 2022 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=va9r0QVLDrzUBKfwOlAVVXjIk9+Gr+10/tXbE/MbkSw=;
        b=QJPSqQeNeUS/qsGSgTA78nYzcxlb9VFNzBc0ISV8jX262S799ScyRSkmFq3qyWKJd8
         Gkry15oWAYgGLktPECDR7KMNKw4AcYK1uUnC3Rf9se0aIuLJ/aUEAcuGtb5b6Mgb8t7F
         /q8g873gkB9cxZ5tgtlQ8poBpo4hNk8ht5AA0m3/OGy1JKO06w+zynAyaHpR5faO/whW
         acuyfJTlc71qKjZIWAehu5g1u/siHaTxJdvxr+xMHx3upMv/RAb7EpA285saZXr8BtXZ
         UPR7ampwTkXuxmuI323H2IR5KhcD3VujGAhMZ+4YyqG33NPUAWtq8FG8WQV9lrYOKJAM
         T8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=va9r0QVLDrzUBKfwOlAVVXjIk9+Gr+10/tXbE/MbkSw=;
        b=eAINoVQK19DGXIkAP1xdQh60C9gOWSoVDXHWjVu1PbAp3uoC24UVKR7D9KSMlSvrqC
         Ek/2iLaP+On3S0R55P4ZdyexwlmpmIlP/b9J2WzDtsQZ63s03E/Cb1bCDwY8QcHwIOA4
         5XS79G63HnlQ82vvg5RyH6srLEf6awnY3pUlgx4tB4FNY8GFFl3oxp6DkbRXEwlwEMEg
         X7ARCNaNQN664QwNvepksoFx0sS1q70BLTeRzqi+ZdZ+SCjjTQHjkhLnf5tzfxDySd7g
         bcBKAbg82l8JnSl8z1jtaId+MKefHjQWqD75sNsPQisnmxTzILbEOPLPDRTHzfo5DPGy
         jDoA==
X-Gm-Message-State: AJIora+i7oqPCuwwrGN7l0kK2n37cf8E6PM2PLOI3HYQ/wZIkGS+PquX
        zlQ3sYmo2X1epjojaajgm/gpvObzLEU=
X-Google-Smtp-Source: AGRyM1s1DyyQ730C8rTg4zM/Mx1fOod5LKx8nGSMzVjlSyMZyzOz3bay+m3QhU/YTH+4pBys4tClHQ==
X-Received: by 2002:a05:6000:1888:b0:21d:beeb:785c with SMTP id a8-20020a056000188800b0021dbeeb785cmr2188576wri.34.1658488047525;
        Fri, 22 Jul 2022 04:07:27 -0700 (PDT)
Received: from felia.fritz.box (200116b826e64200edeeb77a6a94b0d2.dip.versatel-1u1.de. [2001:16b8:26e6:4200:edee:b77a:6a94:b0d2])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b0021e4bc9edbfsm4248964wrw.112.2022.07.22.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 04:07:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] asm-generic: remove a broken and needless ifdef conditional
Date:   Fri, 22 Jul 2022 13:07:11 +0200
Message-Id: <20220722110711.16569-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
in the reference) in ./include/asm-generic/io.h.

Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:

GENERIC_DEVMEM_IS_ALLOWED
Referencing files: include/asm-generic/io.h

The actual fix, though, is simply to not to make this function declaration
dependent on any kernel config. For architectures that intend to use
the generic version, the arch's 'select GENERIC_LIB_DEVMEM_IS_ALLOWED' will
lead to picking the function definition, and for other architectures, this
function is simply defined elsewhere.

The wrong '#ifndef' on a non-existing config symbol also always had the
same effect (although more by mistake than by intent). So, there is no
functional change.

Remove this broken and needless ifdef conditional.

Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/all/20211006145859.9564-1-lukas.bulwahn@gmail.com/

Arnd, please pick this v2 for your asm-generic branch. 


 include/asm-generic/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index ce4c90601300..a68f8fbf423b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1221,9 +1221,7 @@ static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 }
 #endif
 
-#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
 extern int devmem_is_allowed(unsigned long pfn);
-#endif
 
 #endif /* __KERNEL__ */
 
-- 
2.17.1

