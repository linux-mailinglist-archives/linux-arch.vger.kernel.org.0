Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554117D533B
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjJXNwc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbjJXNu3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 09:50:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEF2123
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da04776a869so499111276.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2023 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698155288; x=1698760088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5iA9XL/oyX6Tyl0rnn5vdBOVip3jqaNokzkLete42fs=;
        b=SzE1AUc4BKZmpNvrK36+SD3sWBCP8XLcqDoSN7SaMr2sU/BG1aGfkwvE/f4JQXF1Ni
         hMF1o0lNDayxObo0C0wjdTZL8vll7r8pHHyLG7ycDypgWlfcaIqRWfAtBLLsA0BrpBju
         FzAAj+z5fJfNRaY9+A3lV6zqMBZMFytgHluIRpWvQ3sZxRKVk0/VlTAtIhv1vlgDxCFT
         1X0QR2xi2xN0sadEGLcjq9JrBII48akc5UqV38dawVcqLr033J2tJARubY1zouO5IWW8
         ObNjzyLUon3FC8l21rKOSCG4nSNGOECtt/Pzik0zSbCvIpn6JtaWo302ot6QhuiBaU7v
         3hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155288; x=1698760088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iA9XL/oyX6Tyl0rnn5vdBOVip3jqaNokzkLete42fs=;
        b=SeZXHilmttV8g6g1R4oeVNOe6rednwqZGoI9szXbKuK7oVXOP7ug5LeL++zK484/MP
         WWVwPuNLRYAZVgCtkbSi+ht4tRm487rUsq7+k6deHye2hup0fuw0fwM09gyVTAufZtB/
         0xIDYjA4iVo2vFPTD+1AGJfkrwT0ElT6M+/2hlm+W/YGEfMrXXyCiATs3/8d0ugMMm7u
         nGozHlFF0x5c6QL60RsMnlIVN9MBv3YCSnCv1n5n5h3wI2tmYue+4ZwgByWaE9MyUebQ
         sPL/TKhiOoXP3ku1hfct5oJxtyvonwz9Vr2+I7LJcLaepGQYRwz7icvsT/M6FGplIxkW
         cB2Q==
X-Gm-Message-State: AOJu0Yyl24vM+3Ho8i9t+ymz1b0hcxaAdpizNyfB9V9NtZSp2+DoFhV9
        +Y/tPfonjtKzM5CFwvlE34si0qWqkHo=
X-Google-Smtp-Source: AGHT+IG2dGz7nkvTfdEUK5vnzGjBRQVPkaal0DQpTev0jCoT6FkWge7pFcsduGaJ7nCMKZx++nF8KYSK16A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:45ba:3318:d7a5:336a])
 (user=surenb job=sendgmr) by 2002:a25:ade8:0:b0:d89:dd12:163d with SMTP id
 d40-20020a25ade8000000b00d89dd12163dmr222107ybe.1.1698155288323; Tue, 24 Oct
 2023 06:48:08 -0700 (PDT)
Date:   Tue, 24 Oct 2023 06:46:36 -0700
In-Reply-To: <20231024134637.3120277-1-surenb@google.com>
Mime-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024134637.3120277-40-surenb@google.com>
Subject: [PATCH v2 39/39] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2894f0777537..22e51de42131 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5118,6 +5118,13 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+CODE TAGGING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/codetag.h
+F:	lib/codetag.c
+
 COMEDI DRIVERS
 M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -13708,6 +13715,15 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/alloc_tag.h
+F:	include/linux/codetag_ctx.h
+F:	lib/alloc_tag.c
+F:	lib/pgalloc_tag.c
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.42.0.758.gaed0368e0e-goog

