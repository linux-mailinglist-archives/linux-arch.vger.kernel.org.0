Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8842066EA
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 00:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbgFWWJK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 18:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbgFWWJG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 18:09:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FCC061573;
        Tue, 23 Jun 2020 15:09:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b5so233922pgm.8;
        Tue, 23 Jun 2020 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xyA4lLNJRkTcM7jGcZx6caF2sIXBOMEy60Y5SBlTMAk=;
        b=pcii6dySMmrvPeG2RJQSNs6/F1VyuS6miy4TO2rAbkFymvbpTfCdmkXbDlWERuww5i
         PKmPBdPC0UAZBZz/BX2HOG7rD7NBVtASGs6XbNVSc/GNtEnBzn23WI18U8zPCCQWkC07
         Y8ZFIlUVG4ODqxgfkgzoqIZYDnuEamAdzchiLwVxZzjiEaI+IWjHFD8Z7vXPep2cgw8s
         3WAsz651pvQ9ijkTGDqI/FltIryiNyfRxv6YhYo8BY993nvzuE1CyPu26T6hBcC7WJZm
         yDEAWvHlQEEwJjii/4NV0hJ3stwZYNT3i7FuMuuEdCviMLRHZCVVtJytjmXRZDHNHPkg
         NDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyA4lLNJRkTcM7jGcZx6caF2sIXBOMEy60Y5SBlTMAk=;
        b=plhXWMnOg9r7O0yVdLpataQzq8siC+KBL20lW164mBPgvKZj+vgYXKwT5bPSd/3J3T
         6VdQPnh4V7KtJghrCJdbLILKUAaJtcYcPRhPdQqaMJnpQ/wZQcci3T1iMgHLCZ8raeeU
         WdfU/8tQ4BVTOTFzLiSlvS9C52CG5b0HcMnxhlifktvGpdvzoDuBf10CF/c2klR47asx
         k8ctDVRkDlHd+zxxEyflL27W1zuomYi74YkHdVy4dAxN9S6nIMYXe2GrsKOBp9rQtLIA
         UKOKfcDSYDGWqLdCE3nr68ufU4Esxhc8UH6hMMgWcABkimJlf4eB/+9rfOoFzPdyZlF1
         Z0Dg==
X-Gm-Message-State: AOAM532d5M14OVA/y3jambqNC59dtd+XPKyg1bFYLxEvyVr6Y9gxAE9A
        aSaaXgLn/fKU68/kNsq+eM4=
X-Google-Smtp-Source: ABdhPJx2n72G0/vt5ZYqg2QYNMMl4G+WIn6kzvmddeg4hWo894IJe+i2qQlgKt3ltsCOLrS3twd45A==
X-Received: by 2002:aa7:97bd:: with SMTP id d29mr25217184pfq.262.1592950146124;
        Tue, 23 Jun 2020 15:09:06 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b14sm17474956pft.23.2020.06.23.15.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 15:09:05 -0700 (PDT)
Subject: [PATCH 2/2] Documentation/litmus-tests: Add note on herd7 7.56 in
 atomic litmus test
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
 <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
 <20200623155419.GI9247@paulmck-ThinkPad-P72>
 <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <9e1d448a-cf3c-523d-e0a6-f46ac4706c48@gmail.com>
Date:   Wed, 24 Jun 2020 07:09:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From f808c371075d2f92b955da1a83ecb3828db1972e Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Wed, 24 Jun 2020 06:59:26 +0900
Subject: [PATCH 2/2] Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test

herdtools 7.56 has enhanced herd7's C parser so that the "(void)expr"
construct in Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus is
accepted.

This is independent of LKMM's cat model, so mention the required
version in the header of the litmus test and its entry in README.

CC: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/litmus-tests/README                                | 1 +
 .../atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index b79e640214b9..7f5c6c3ed6c3 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -19,6 +19,7 @@ Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
 
 Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
     Test that atomic_set() cannot break the atomicity of atomic RMWs.
+    NOTE: Require herd7 7.56 or later which supports "(void)expr".
 
 
 RCU (/rcu directory)
diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
index 49385314d911..ffd4d3e79c4a 100644
--- a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
+++ b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
@@ -4,6 +4,7 @@ C Atomic-RMW-ops-are-atomic-WRT-atomic_set
  * Result: Never
  *
  * Test that atomic_set() cannot break the atomicity of atomic RMWs.
+ * NOTE: This requires herd7 7.56 or later which supports "(void)expr".
  *)
 
 {
-- 
2.17.1


