Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A311C7D5233
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjJXNrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjJXNq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:46:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7840910C6
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:46:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7cf717bacso62025147b3.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155212; x=1698760012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ZaCKU38kmyhI7VEwX4KjtHXLgRMjapTHFgQ9SG6t0=;
        b=mdQU02L1CvfERziAV1S4IWGZDX7irUzrH657u0xJG/54by6a1PhBxsUviX5Pwjua/T
         tyX9oRC7TJS1/NjrQVkH2nEgsfpx1CADvuBwn9rmhdGH32e419ZbVLElz2vF7W3PzB/0
         wGACZwKxOG0lbxY6tgKksbxYI5qC4gKYNecyeBklDKUcA5HA0g5v9hWgSXg2KtLeQm7n
         vRt2tiqzDBTxDPdAhfQ0TO87X+AvbN61YbzpDPWOBQCokVInUWM4EbBMbG0vl1CUfoOG
         Ph4KI8dy0JXLh6ycauQ1HOyH+AF3xuT/aVX18YoM0St6IHTjmP0OR/HnLbDMkTt2f40p
         auRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155212; x=1698760012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ZaCKU38kmyhI7VEwX4KjtHXLgRMjapTHFgQ9SG6t0=;
        b=kooTAI+aJPHKcxGse7D+HY9wlyLIaPhZCtDYGZNuNsw9VClI0nJB584bOwz6S+M/zR
         wsiIhPNe1S7YDrYMyGltpNsvblHteFHeleINRbLSNOb/m4tpKK90bbc5L03jMQDY25g+
         FnM57uJgPg7Fyp5ntEOMKkr0Awhci2IEimCjWiPh7ho2sfRGjCjXTHhvJBocGOBm8W5A
         0sPGoksEXVyfzWkH0XpELRCS3IugC4yaX07D4kqaOh2FapI4f2CiOlh1VjzinYA/1a/n
         nSBLUEmHNn4ySpvpSdrEhZ6I6OtJPtVuQW5oG5a/43QLwo20ZUXLe4RtZrTE41596hq8
         kvZw==
X-Gm-Message-State: AOJu0YzHPPJYM41TDj6Q6aMpLWUgUOPlfuYpwbqWcJbUVvZRHzU87RbD
        E4s+Oce5vMmS4Cg0J5uGjqbKbSccoT4=
X-Google-Smtp-Source: AGHT+IFUpFLBsDMNDQVhWCjHvEp+oEK06bmA8hZB4NpLCdYe9bJ3XL90v8R51rmnjDRHAZifNxDo+IuLmGU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a0d:dfd0:0:b0:5a7:ad67:b4b6 with SMTP id
 i199-20020a0ddfd0000000b005a7ad67b4b6mr254303ywe.2.1698155212529; Tue, 24 Oct
 2023 06:46:52 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:02 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-6-surenb@google.com>
Subject: [PATCH v2 05/39] prandom: Remove unused include
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, vvvvvv@google.com,
        gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com, surenb@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

prandom.h doesn't use percpu.h - this fixes some circular header issues.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/prandom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..f7f1e5251c67 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.42.0.758.gaed0368e0e-goog

