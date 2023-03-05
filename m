Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51306AB236
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCEU5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCEU5B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B59196B7;
        Sun,  5 Mar 2023 12:56:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cw28so30809318edb.5;
        Sun, 05 Mar 2023 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dp+002KTo48dpecC7Fg4F0z+wg/mF+qKQ/rqBRLLmU=;
        b=FJhdq7LVPwcBcvn6/riybPaEEFIp0/r+l4uien9VYX13snE+6dd2SRb+yMPMDhYYbM
         3AUs+n1H+CpJ8GDv0U77dUTxE8RjQ1eWXLj+bg/IVt1gChmG7p7sJb2ClN5MKQVBKiHA
         NH0EMDT03tcy/lSh5xX41OU6Nskj9OCGpTzoieRFH24h3GENB49/lgCnuichf7wUhvLm
         YsQlX9dGfnwd59NipJUQH4HuchN0vUmHSZ5pwgrti5UGvSZ3bP144EUY6UqvAOkml+nl
         yVef/gktEHzCBna7fndw2/uQjOF0b5Chrheidug0MCn0y1l15A0pcTSH9l17N70mnuzK
         JNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dp+002KTo48dpecC7Fg4F0z+wg/mF+qKQ/rqBRLLmU=;
        b=A15NtYaONuuw+77B8rdT8ddb9DA2G6SneCVDBShxAgVSKLx+5/e1FyKxD+v1b6khjj
         oAhg4FeXG0ACbK0JIeLwGXYDARsboPZoKQ2oS9h1phvoxjno5gKIS2gpxqANzngxAxRY
         +QteVVAW3CyH0hBTdxO7RKc0hA3/fWEwNjddmjGD7MAt61a1u8wUTpmLCaMnYemBQhXy
         IXKlQuNWN0ch1geNYE5vi6bflMQrfQU3e9IbdLos3ePg2IY58t26Gf554IHxWAgqUk+U
         cygyuTPfau43rMggK62xLyNVEeiAma0iqwgE9oXDWScTOK7GYQF3+6l5ZMJFRNlaYZ1G
         2KxQ==
X-Gm-Message-State: AO0yUKV8Hj46UG3INUB9fQVGie6/eX7agqjyCK8U8SI+2NBxZFklB0Ws
        tgQ/HKszXt5G3CuezCq3sPifb1dKu1/X7adC
X-Google-Smtp-Source: AK7set9JJNLz1ulU/hVH+IH7j0C6i0gQzHulORbRJDsCWP1JV2FwRUAnR4ik5vqV9X6krnih1Xg2WA==
X-Received: by 2002:a17:906:33d1:b0:8b1:7ae8:ba79 with SMTP id w17-20020a17090633d100b008b17ae8ba79mr8537582eja.30.1678049817877;
        Sun, 05 Mar 2023 12:56:57 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:56:57 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 03/10] locking/alpha: Wire up local_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:21 +0100
Message-Id: <20230305205628.27385-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305205628.27385-1-ubizjak@gmail.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement target specific support for local_try_cmpxchg.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/alpha/include/asm/local.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index fab26a1c93d5..7eef027e0dde 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -54,6 +54,8 @@ static __inline__ long local_sub_return(long i, local_t * l)
 
 #define local_cmpxchg(l, o, n) \
 	(cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_try_cmpxchg(l, po, n) \
+	(try_cmpxchg_local(&((l)->a.counter), (po), (n)))
 #define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
 
 /**
-- 
2.39.2

