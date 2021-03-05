Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9632E659
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEK2t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCEK2i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:28:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2EC061574;
        Fri,  5 Mar 2021 02:28:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v5so2689366lft.13;
        Fri, 05 Mar 2021 02:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lohA4EAhnKvORqBTm17jF+zgv1GBl3VnSdz9E+BCZqQ=;
        b=jP1XdJ2e/b33xyaFN4vZtHmqFEN4O7u6IkgMpAgJaCnY8pf78+fnhsKUeEb147yS9x
         h3e7FEYVHDoyupjg6S8rtWJVjuoqj7tnkdakWxGulIalrOOtzBOPgrqEUBgoCizvRyQi
         ldg7ca/C+5N/NHNY8X8Q7eXVX5+WNGYiyXguTSG0QqJVpmCS+e8jotX6ZrpH+Ylj7xlZ
         iTyNNiV7LsnEM6yEWom2NJkW1DRswqgUOJDl39mrb8Pg55lpt33Hz8GTUU7+1mwKyAbP
         xnnen4dPrew55V4d3esSzgMgTs2XYSfYaAy7D3ZHf5ri38Nq31lX0mbtactSX7flxPMC
         WGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lohA4EAhnKvORqBTm17jF+zgv1GBl3VnSdz9E+BCZqQ=;
        b=Jdh7GZJGuIB1pCCqwzpAxZHL4ChFV+idjsxotrlGH65eMWCAM+SvPZVKyAd45dMfvM
         BW+xofTd7qMfDBsje61AvAJf0ocjfzMzaADpwMVoY7ml7889UC8YRtNoswDx3xUIhIbs
         Ajroe2FF3XG8EV0YlnNz0tX2bbpCCcYgOYASjxNRFpU2+uRWwL9SMGUu5I/hEIE3pvZK
         NeBx88qIfXevynr7N9onAl0dgWZOH2EV1q7OhiRmIec+aAXqyOHsSuNf2scy9KAracJc
         qoEqrlJR4s8N8IA4tGKZb+Doc/KmIpUn1UpGa8hXZDlrc4NcIjnmFBh3pYKCU/TJoM4w
         jzgg==
X-Gm-Message-State: AOAM53332n/IxzfveaabwhABV9/Yp3R4lK0I9vbBEbHJ5rEWHe9hW7Al
        6GTOhDPqHPS3ge0fYGnBxGcS4FoJV7m4+9Eb
X-Google-Smtp-Source: ABdhPJxOZHpm52FZMehbZ7KHsHxfo8iEBxwQCPShVF+gMUD3I2qWH2xNs1BvcBGfzJbUMXQGlR/WdQ==
X-Received: by 2002:ac2:5228:: with SMTP id i8mr5036707lfl.59.1614940116069;
        Fri, 05 Mar 2021 02:28:36 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (c213-102-90-208.bredband.comhem.se. [213.102.90.208])
        by smtp.gmail.com with ESMTPSA id a10sm250472lfu.263.2021.03.05.02.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 02:28:35 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
Date:   Fri,  5 Mar 2021 11:28:23 +0100
Message-Id: <20210305102823.415900-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

A misspelled invokation of git-grep, revealed that
smp_mb__after_spinlock() was misspelled in explaination.txt.

Add missing "_" to smp_mb__after_spinlock().

Fixes: 1c27b644c0fd ("Automate memory-barriers.txt; provide Linux-kernel memory model")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
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
 

base-commit: 7f58c0fb9238abaa3997185ceec319201b6f5a94
-- 
2.27.0

