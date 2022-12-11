Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABE6492DB
	for <lists+linux-arch@lfdr.de>; Sun, 11 Dec 2022 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLKGUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Dec 2022 01:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiLKGT1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:19:27 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2613D45
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t2so5966479ply.2
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMolVTy8VjYCulGuPzNEcIDf7wRZrcWr/05oT34qMBQ=;
        b=kpyeP8aUm6xVt1LsT26WIX4xh6T28WcuzsV9t55O76ufNdykQHSMbYpLaYWnWmgnMd
         ig5UFg9Yoa+OaO/0ER9jFVHQeP0JB48EmWhJ2oYXulFZYC5hBjUC2VuD/wHTDdVal0oL
         6rm51pToRKQgSBMHRESnNuzargdTiA4KZHORSEJAZGtFUUqQfk12kRpvfpHSSN4ylLsS
         ISWWxbnu02P6CY5IT0Tkp9JHiyP1SOa5FPdQF56drBBY5nTt0tm/3Y+m/lYHlVscQgjD
         EiE5LhogYoio7cbYC2QvkLmapccXM7ofpniBioHjNqt/EX+7X5vlPsWIekQ8K7VaIgFh
         Z9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMolVTy8VjYCulGuPzNEcIDf7wRZrcWr/05oT34qMBQ=;
        b=jDh0HhvNHwVfnCJf6W22ZatJNvgwm/pdz089rGW0EebxDrQZ4K/va/xJcbD3Ka3znp
         JSZwrLzsqI+qYqH9Qf0ccZfplQ89HRAVBNOttl7l7C7pGET8KxYxbRNflyKMUwz7U6ZI
         bAaEgIk4AZzeQKoppWb+wnopRB1OL0hZA8PedCqZ/cniW1dYknmc8V3+yTIZgS146bAP
         2wcqgjkoBDg9+pmZMyIXGeBFX0ObmyqRxtKgn9LKwDat7NVUoOlOS1OSvmTtzuJrobk2
         psuYPpWrTqv7Oh9vGuY1qHaWqpp5LM1JjbgljX0CajQ/68Hb5qGXuLqplsVlUiuMjJqj
         +aUg==
X-Gm-Message-State: ANoB5plrpWyg8c9PN4gkG7FI6+dPJaPMOFfwM2eG/hBXKxW2aozXKXOV
        D0SDFvGpPqaFWDPn0Trm8ligHQ==
X-Google-Smtp-Source: AA0mqf4eqLju67UY1h3Fm9nSfjRejCvxuaPwfc8MIcoBf7UVFcjtvbl3sk+taoOJ0P8MRfR+wGUNcQ==
X-Received: by 2002:a17:902:7c87:b0:188:bed6:3fbc with SMTP id y7-20020a1709027c8700b00188bed63fbcmr11875991pll.19.1670739471059;
        Sat, 10 Dec 2022 22:17:51 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b001788ccecbf5sm3826922pla.31.2022.12.10.22.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:50 -0800 (PST)
Subject: [PATCH v2 18/24] mips: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:52 -0800
Message-Id: <20221211061358.28035-19-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/mips/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/mips/include/uapi/asm/setup.h

diff --git a/arch/mips/include/uapi/asm/setup.h b/arch/mips/include/uapi/asm/setup.h
deleted file mode 100644
index 157c3c392fb4..000000000000
--- a/arch/mips/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_MIPS_SETUP_H
-#define _UAPI_MIPS_SETUP_H
-
-#endif /* _UAPI_MIPS_SETUP_H */
-- 
2.38.1

