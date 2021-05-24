Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1637A38E073
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 06:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhEXEps (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 00:45:48 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38727 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhEXEps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2021 00:45:48 -0400
Received: by mail-pf1-f174.google.com with SMTP id e17so9226267pfl.5
        for <linux-arch@vger.kernel.org>; Sun, 23 May 2021 21:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXabgE//Aut4OEXbzns/8XFzawRXQ+GpKZv9mrx3gTY=;
        b=YJGnPEw1K9fJFtL83aok+WFaP+/pwqU+IybdAGr0tiiQVlEmxYHfWkQHnfBU8YnkHn
         aF6rpqwyNBFaabiSy7A4yyNIzMl3pikqGmQvypIKswsXtqt9YNNDOYKb2n7F3ZRJIvEh
         0Dd9KlKwbRaSQ9Cjh92TJION6YyZlZ7dqJWZDuWvTnT1Ywwp37AgBntyv1LrtqCH02lG
         0AOS7FCQgfPp/fEaXK0bJ+VVENZaxnEpDcJJNFQoHu74k6h7KPOXonZu0lVcm/UuDuNq
         RnWqRTHQDciceFGz2Oj96YXCcje+R532woUKS3suZ5UJPQ6VHP5Pklsubi7kTiPseGf+
         JWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXabgE//Aut4OEXbzns/8XFzawRXQ+GpKZv9mrx3gTY=;
        b=oMPCXv7bVmzrKOvOK3K9ELwSJmnaj5cen397y8ysqt0q+wTJBuQ202WW4DW6uquZAN
         zrGkswegjapke+jXgXUFBaJTZEqzy9IeYWqET1RjXzCmWp5MjjEb0H9jH6ybrHxfMD8W
         P0akO5hzgEh425oSUK8p5QIQ4JMOTkcz8ZyomYA37EISSsT9PuuKyPGoUsd8CiwpW6s9
         aMW6+vYgX2GRKSUgAc+vdq1PGerhN7zOZh9jcuNUROTTIKuZT6dtjyCCVjK5CYIP6c8I
         oi2rFd2vStOQqQLQKRDSsom4N/4BTEVywG49sIs2elC5WJGx8GE7a82NAB8FPQgHMwsG
         Ssow==
X-Gm-Message-State: AOAM530wPT6/YiDL8EBXYG59UEAD/tGpYLtS8cXkeOQbgcavtSCuf0AU
        FSUF+WRcTqw+rAszBckSCPYe50lwtphXGGOWeRtRSw==
X-Google-Smtp-Source: ABdhPJywA6uB35xOC8mQX2+FgwdbfGx1997bj/CT3WSlyBn5jvMwGyKRR/pJUvcQ4dUd73EO0Bvsfg==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr11608689pgs.206.1621831400115;
        Sun, 23 May 2021 21:43:20 -0700 (PDT)
Received: from ZHIJIEZHANG-MB2.tencent.com ([183.8.137.199])
        by smtp.googlemail.com with ESMTPSA id a23sm8443611pjo.21.2021.05.23.21.43.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 May 2021 21:43:19 -0700 (PDT)
From:   hitzhangjie <hit.zhangjie@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     hit.zhangjie@gmail.com
Subject: [PATCH] fix typo of documentation.
Date:   Mon, 24 May 2021 12:43:10 +0800
Message-Id: <20210524044310.46113-1-hit.zhangjie@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

the function `smp_mb_after_spinlock` should be `smp_mb__after_spinlock`.

Signed-off-by: hitzhangjie <hit.zhangjie@gmail.com>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index f9d610d5a..5d72f3112 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2510,7 +2510,7 @@ they behave as follows:
 	smp_mb__after_atomic() orders po-earlier atomic updates and
 	the events preceding them against all po-later events;
 
-	smp_mb_after_spinlock() orders po-earlier lock acquisition
+	smp_mb__after_spinlock() orders po-earlier lock acquisition
 	events and the events preceding them against all po-later
 	events.
 
-- 
2.30.1

