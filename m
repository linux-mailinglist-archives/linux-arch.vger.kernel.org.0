Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72CF7A207F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 16:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjIOOIu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 10:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjIOOIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 10:08:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B561FCC;
        Fri, 15 Sep 2023 07:08:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1c364fb8a4cso20014515ad.1;
        Fri, 15 Sep 2023 07:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694786924; x=1695391724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NDJ58ec50IQsUHGc8bDLmZWjrMQrltSqdri1VsBajU=;
        b=NG0s6OMtiX+RCUZvaSq7fSQmQpexu3slqEedtJapmcdRrt/+4Bs7znbpMKp+/RM11u
         AN2OwgLxxYY9mPqu3xvfCqHtJ7naZLif04aN5il5SwZKJVrP7ldLUVHEsz4OLLKkSiaJ
         hL41AxhTuyRB1jMJGjOE55kRMiVARt8HopHgJktlt6jCqwizNJ6grmZGm0KwWtNerseW
         6kGOKQv01NLgk+VzKdkK9aoxtoE9KzlhdLZtieO/Lgljf9GnyrLBq4+xcB/ZmXOsYwbO
         HaxHSNN3naBSRqRs1+aY1SyVqzCf+QQLsyc+ftJ9l054+zVKnK7oAxbOlCmnFoaw3MPU
         oA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694786924; x=1695391724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NDJ58ec50IQsUHGc8bDLmZWjrMQrltSqdri1VsBajU=;
        b=tSOAHBwZnHBw/ad2EHhKYiKJYAimYeKdTd6xEQ2vjfWoDvTNNXkeP+JgTOFuBvu77b
         t3WVc2P1IETi3lhFImZEeRViacMlM0Tn2yfXfChavT1+kGC5Ggc5JOivQ4+oqxLVIkoZ
         jXPhZXG4oTqb326YkfwwduTsR/ljIT2eQO2Zizvzaa285Du8Szn/+FRxE1yKVtx6EYk1
         o25YTz7dNpfCMGqP5LjynefxcrxknpdIw7gK2hJRWQFGuykDlx6e9OBe6VMXPDC3efx1
         +a4S6L3Ws+U9c+G2+AhbQEaX5mkMiuX/SuuW5elvq2d5dflAWWimcpERZNMzasH/8Wfj
         8pPg==
X-Gm-Message-State: AOJu0YyBXk4+4UI+Ss8NTkrAO1AvrBJ8h7ttE5RxtxhsbWq7gTzrZsqN
        2TjGAz2ghHaXO7lFCEgSPAg=
X-Google-Smtp-Source: AGHT+IFghbrUNgchmUKvHdeCDgfHoRzvBZZQffZ0F9OCDvCdZo1SCQvxRq3RqfFm+uCk3eUxEgMEEw==
X-Received: by 2002:a17:903:4288:b0:1c3:2dcb:25c9 with SMTP id ju8-20020a170903428800b001c32dcb25c9mr1627294plb.40.1694786924235;
        Fri, 15 Sep 2023 07:08:44 -0700 (PDT)
Received: from localhost ([2409:8a3c:3645:83a1:1b76:f2f8:95d1:4704])
        by smtp.gmail.com with ESMTPSA id jc12-20020a17090325cc00b001bf574dd1fesm194580plb.141.2023.09.15.07.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:08:37 -0700 (PDT)
From:   John Sanpe <sanpeqf@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, xuwei5@hisilicon.com,
        lorenzo.pieralisi@arm.com, helgaas@kernel.org,
        jiaxun.yang@flygoat.com, song.bao.hua@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@openeuler.org,
        John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] logic_pio: remove duplicate declarations of function
Date:   Fri, 15 Sep 2023 22:06:50 +0800
Message-ID: <20230915140650.3562504-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Remove duplicate declarations of logic_out* functions.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 include/linux/logic_pio.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index 54945aa824b4..babf4e3c28ba 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -39,9 +39,6 @@ struct logic_pio_host_ops {
 
 #ifdef CONFIG_INDIRECT_PIO
 u8 logic_inb(unsigned long addr);
-void logic_outb(u8 value, unsigned long addr);
-void logic_outw(u16 value, unsigned long addr);
-void logic_outl(u32 value, unsigned long addr);
 u16 logic_inw(unsigned long addr);
 u32 logic_inl(unsigned long addr);
 void logic_outb(u8 value, unsigned long addr);
-- 
2.41.0

