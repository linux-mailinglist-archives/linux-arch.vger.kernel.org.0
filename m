Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0186AB23B
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCEU5F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCEU5D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:57:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47009126E0;
        Sun,  5 Mar 2023 12:57:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so30677814edb.10;
        Sun, 05 Mar 2023 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INU9jJ8LcpbE/5gpRgMDZ5idqPx3BDVeD3nCNohGOeo=;
        b=XQpvMIoVY1hfPz50zOJm8ImET2/qnDz8SzbExbEMhUpoAodDU9gmRVk+gVHTjV41Qg
         fsT4F1FRmF7A4S+XdrFIPtysZCRa/bTQR+mMVthHRql0ddWfAaVTRndhUu4LdjaH5a/h
         8KlHG0B61wz2981K4TkkdR2V4hn2+MJRKkT7gP/CSVcvH9wb87scRgrWmAfF44CyLv0C
         7KQ7gdJyK4GAYKjVQrHW+G411c1hcshd/R81Awwd24z4tDzJctUfj7n2uU8/Xl1RWLms
         kVMS9xMW8nxmto2+YnnTqTHjSpJ0KGd7UBOnX+ozZ0yXsIGoN96WVnz3t7OZeXCDkIHx
         zcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INU9jJ8LcpbE/5gpRgMDZ5idqPx3BDVeD3nCNohGOeo=;
        b=fGo6l91d53QTU5toj1/JYLUNvRIDyMZMuZXyZK8CkdapZtfcU9M8qj1XDQV993JlLG
         7bjM0zqgfTvf28EyrY+X1xPRPTPJsrmqey7XQBSon4nRSI9ZBMSAYiUXsPKrYp4aijJh
         GtPJwZed7LsiYPMuRZu51WTIsW04wLwUsdVDzGsS5fqg7i8LKCKzpDvQeeJ8k+n00Sr8
         RAdY9Ujt+i7zpdLgGDpi4euO9q8RYg1IPD9MpAfmhstmhl3kVamxaoRBNuxICoSDicn2
         7BAhU5Aj0ku/QrVvlP48ORIYp+JTPhbGdr5d3NQK1XCNqdoQ2F7ofszR6F927tEbIysL
         PiGw==
X-Gm-Message-State: AO0yUKUvPjT4ntim7KWSWOgmr8SSY6FezAB9AbLNwfos+me3rGMbmCGf
        WaAKBbrN7Bq5fjEmYpEeBkdqDcUk+DrFHlTB
X-Google-Smtp-Source: AK7set8kiCd/dK0DxHq2OpPRZXV2eyPLGAkRkDs+9TZ48CcB6LDL0aHpg5qt4ZJLjrVLWS/LXgLw5A==
X-Received: by 2002:a05:6402:184a:b0:4a2:588f:b3c5 with SMTP id v10-20020a056402184a00b004a2588fb3c5mr8020962edy.21.1678049819467;
        Sun, 05 Mar 2023 12:56:59 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:56:59 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
Subject: [PATCH 04/10] locking/loongarch: Wire up local_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:22 +0100
Message-Id: <20230305205628.27385-5-ubizjak@gmail.com>
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

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jun Yi <yijun@loongson.cn>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/loongarch/include/asm/local.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
index 65fbbae9fc4d..dff6bcbe4821 100644
--- a/arch/loongarch/include/asm/local.h
+++ b/arch/loongarch/include/asm/local.h
@@ -58,6 +58,8 @@ static inline long local_sub_return(long i, local_t *l)
 
 #define local_cmpxchg(l, o, n) \
 	((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_try_cmpxchg(l, po, n) \
+	(try_cmpxchg_local(&((l)->a.counter), (po), (n)))
 #define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
 
 /**
-- 
2.39.2

