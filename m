Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B064369DD7
	for <lists+linux-arch@lfdr.de>; Sat, 24 Apr 2021 02:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhDXAb2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 20:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbhDXAb0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 20:31:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4BC06174A
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 17:30:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so5255428pjb.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 17:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=guSSRx65IripoYc8dsOm6JI430Ep/aIkyxlfSlPeaA8=;
        b=IB00by7h6dymC8ZKL8amoE0YgUaKyWHVx6TLwSUhxXu/tEakwqd8LM3mPK8pAxQ5TH
         mzdBEjNvt4M/1w/MJA/GYiupuELZS9Y5IqWiwuzY1W7Z6XnPXHOyAD9ChiE4I/pRgRRY
         Unp90I5iviDab4Nz+nAadLFr+JgB9KPzCVhfIK7ZU5bAE3h48KDynKHvB6ARIFKrVS70
         vExerh6n5VrHVFnVKfS3cK1rWNdjq1pFOzw0YLLEWI7orx2FRyYcBq0LwBxPSfShrr4Q
         97shPWCY+sNlJRLdKvVXw/N1jNcvVN1l15KjnfY4Vbsx/+gYd5Pj3G6qTGYBkKyIQedr
         Q7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=guSSRx65IripoYc8dsOm6JI430Ep/aIkyxlfSlPeaA8=;
        b=ZZTDJwLPdCa4KA6PVtMDzb9yN22GTPJgh7pjA+VQ/3EBl4ujwzhE9+Y8G0aB3tJtrn
         HOWYn1KdyZrDaWf9fQra4cNpvF6MAn47UuEa6CV5w/T7X0utLvdkrjsX2SSV6B8kpYOr
         vqqHYhj11ix87iUSjrYUTKfVVEN8E3R+ooxhBdcas94F13MrRRRv//Pzw9w1d71OtyFq
         WZgpm3tMEIuOYpiwLn0EKp5oXPdIDdlVNA6XHeV5ewiaC7mqylyLoYFs86xKGZ3ahSad
         0IlLTtV4bstMkbT8u9SPYnRgIiq8LRLQpLKZDMlBLLm0dRyCZ+jex80VuNjsxHx76toM
         6zgQ==
X-Gm-Message-State: AOAM531wKaajvZPaxKvgrzCvcNiLcpB90wnRiVHpp0+el14dKDcp8I3y
        Vsl3RXeHZnkmtkh9Hfvrsu3oXw==
X-Google-Smtp-Source: ABdhPJzmaUZNjFhvN7BPTb5VybKl4vJlX5CTqmcac0oPUJitgQ87Hn0K91tX3GuaHuoWjlkXGj/jtw==
X-Received: by 2002:a17:902:b117:b029:e6:81ed:8044 with SMTP id q23-20020a170902b117b02900e681ed8044mr6399499plr.13.1619224246844;
        Fri, 23 Apr 2021 17:30:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lt11sm8733662pjb.23.2021.04.23.17.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 17:30:46 -0700 (PDT)
Subject: [PATCH] tools/memory-model: Correct the name of smp_mb__after_spinlock()
Date:   Fri, 23 Apr 2021 17:25:09 -0700
Message-Id: <20210424002509.797308-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@kernel.org, akiyks@gmail.com,
        Daniel Lustig <dlustig@nvidia.com>, joel@joelfernandes.org,
        elver@google.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mingo@kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This was missing one of the double _s.  I only found it because I
mis-typed the name myself.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index f9d610d5a1a4..5d72f3112e56 100644
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
2.31.1.498.g6c1eba8ee3d-goog

