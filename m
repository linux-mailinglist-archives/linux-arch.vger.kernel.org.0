Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF80254385
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgH0KSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgH0KOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 06:14:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E943C06121B;
        Thu, 27 Aug 2020 03:14:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so2421209pjq.1;
        Thu, 27 Aug 2020 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Tgn7BmW3UPf15RTWedDiK9MChZ5JohXLdpQM+uE2unw=;
        b=fkq7wTcI2hdpMWXDTKYB9kp8LfDRzvSbQowxElzqU60rMF4ksVtrDw64SlvcQc6aWm
         KgMUlZIvoIeAaC9FuM5CiSFrMmKuoQ6sppieERWBB6I4J72Aniwc98hPItJAe8EZE7Om
         2tEy1VQFHIGbRwtebNdnv0YSFnBDIBfSXlnT19XicdYzWDyqLr7/HFFAqfFpJ9BygjAu
         naTG4fCN6hoPztvIo83+OfS88EvSJtKblKqR/PoZlcAKVb9Bggy0Tg3tjhOp2Jj657IN
         uSOGvIz0fi+a5I0iRPLpxDna64zwvIz34693xRm24ObyzAjiPa762Qll+zzCOa4BnYzI
         owEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Tgn7BmW3UPf15RTWedDiK9MChZ5JohXLdpQM+uE2unw=;
        b=RKERjVfBkVpL8wdnbpx3B/5he5vf43L8BKk4SN4onVd9vdPhjpftlIQHZ2h8MaW0fv
         na/wxWdc4nu8LbQ50C1GJZGzPP1J6+gYlIkwFNbQSMnjBEuhTzirYfMPBY7PksBX8JuD
         px28+ACImZnPJcLKwf57+tSwbI+JLQiBD5yKIJZAyF8WeJzuwBGQCk6aocOMnjpljBTz
         E2Vc7ZcLBylSkRbzD8/g8apPQzST7Ls4MfRby8uotS85eVBgNENKlcBM2X54v4kOya8x
         vC53Us+F6g1IbDSCkObW1wZE1bK0GEv85dKCoXuiomj1P10z++wvG+dxr0cOvfK6LmRS
         I8pQ==
X-Gm-Message-State: AOAM5300t+g3NR8DWl4w6pYaUobSfEbNu5bFwgBJLwU1AIY1we9AUqet
        Au3YI4dhktCEudgDY1GEf3IQaEo4bjXj+w==
X-Google-Smtp-Source: ABdhPJxmx7ggkgIHpl14X0JPM+SSOy88CiwxOTN2G/YFZCuiBPOs97aBZCfHrC4OV2yRd9YSYT1h3A==
X-Received: by 2002:a17:90b:b18:: with SMTP id bf24mr9219665pjb.223.1598523278208;
        Thu, 27 Aug 2020 03:14:38 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t10sm2333434pfq.52.2020.08.27.03.14.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 03:14:37 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/23] scsi: use ASSERT_FAIL()/ASSERT_WARN() to cleanup some code
Date:   Thu, 27 Aug 2020 18:14:10 +0800
Message-Id: <fa349cd3d02a3f3e6baff774146dd29ceee77077.1598518912.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
In-Reply-To: <cover.1598518912.git.brookxu@tencent.com>
References: <cover.1598518912.git.brookxu@tencent.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since ASSERT_FAIL() and ASSERT_WARN() have been provided, ASSERT()
may be realized through them, thus reducing code redundancy and
facilitating problem analysis.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 drivers/scsi/megaraid/mega_common.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/mega_common.h b/drivers/scsi/megaraid/mega_common.h
index 3a7596e..ba3007d 100644
--- a/drivers/scsi/megaraid/mega_common.h
+++ b/drivers/scsi/megaraid/mega_common.h
@@ -253,16 +253,10 @@
 
 #ifdef DEBUG
 #if defined (_ASSERT_PANIC)
-#define ASSERT_ACTION	panic
+#define ASSERT(expression)	ASSERT_FAIL(expression)
 #else
-#define ASSERT_ACTION	printk
+#define ASSERT(expression)	ASSERT_WARN(expression)
 #endif
-
-#define ASSERT(expression)						\
-	if (!(expression)) {						\
-	ASSERT_ACTION("assertion failed:(%s), file: %s, line: %d:%s\n",	\
-			#expression, __FILE__, __LINE__, __func__);	\
-	}
 #else
 #define ASSERT(expression)
 #endif
-- 
1.8.3.1

