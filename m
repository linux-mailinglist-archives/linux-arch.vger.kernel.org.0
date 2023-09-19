Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61D7A6F35
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjISXKD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 19:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjISXJj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 19:09:39 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B8192;
        Tue, 19 Sep 2023 16:09:25 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-59e7fb87f1cso34133367b3.2;
        Tue, 19 Sep 2023 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695164965; x=1695769765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7GJ9wPpso5luu9UJg5nCytl1V4NyUk99h1NLHwPaTY=;
        b=mJJeUQL4UPIJeXYloDFf/a65FjxYe29oFakTUy+PmB+o5Idzni6+MpoqlB3Kg6ksAN
         FwU1v9G4KZuRMYNJu0+B4WTYiAhhBoVj89NTPV6zeq0KLzLiidscAl9qrFy0Z9b+1dNc
         8bWqyd2rzGqzpU71CE3RNP4Bu9LHbNlunmkY6revONmvRQ5CLR8V7FlPwJPxoeUXk5re
         ATUy/bOuP6j6+f1Hz8S6LJocZec5syTjJQbW6LuEGeZtOURLkT+VRm1O4fFIYMYcxVsc
         fGuiYCagjuLAsC8QdUZ0oFLQZ5DFswARcYFYQWnSZM+HmG/FRLOEwG5jg8Ppb/agTtpw
         k8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695164965; x=1695769765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7GJ9wPpso5luu9UJg5nCytl1V4NyUk99h1NLHwPaTY=;
        b=sNJaA1IGIBwrp0hCkd0xzf+Adh5BTnihOmnnDbwhC9R9QZQgtTBQdpWkJHRMr/92PK
         P3NW1TA+szYbbdK9MiCdK3i11YlMivWSEaJJHNorRgjtkxa9qP9rMF9/51fFKRdeKni7
         Ok5N98ZPFrpa5CPcVwvzGbN6EwV7X4T5UtcrmYDg6I5qxPSjqM1ugtvmlysFV3/pp8js
         O/3VYwIP8KK7PC2LpOY5p2c6xnCCzczOWdVyBCdwN08q/CNyi41hmfm9w6aVlf2TUEtg
         G6RIchP5mZNL0Afwzu8U+f7PdL8FGBJMqFA71V2qdta4aj4rcdmsaakcSAn6ysTi/sC0
         CXMA==
X-Gm-Message-State: AOJu0YzTvN6pHK0BtnwqtrksbLjsDbIYJc7pmLrqNfPTKF5Gg0iDm0vV
        VQfaYRtNQOwgsgSkptKid8Dwa28RGxim
X-Google-Smtp-Source: AGHT+IHiLoInbbhr1x+Eyf/Q7rjl4gnHdTM14EuewXrOpJrVqDZ3walBWmHdRGD6TgQ1epsNl/x4IQ==
X-Received: by 2002:a81:9e49:0:b0:59b:2458:f608 with SMTP id n9-20020a819e49000000b0059b2458f608mr777300ywj.30.1695164964975;
        Tue, 19 Sep 2023 16:09:24 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d128-20020a0df486000000b005925765aa30sm3476327ywf.135.2023.09.19.16.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:09:24 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC v2 1/5] mm/migrate: fix do_pages_move for compat pointers
Date:   Tue, 19 Sep 2023 19:09:04 -0400
Message-Id: <20230919230909.530174-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230919230909.530174-1-gregory.price@memverge.com>
References: <20230919230909.530174-1-gregory.price@memverge.com>
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

do_pages_move does not handle compat pointers for the page list.
correctly.  Add in_compat_syscall check and appropriate get_user
fetch when iterating the page list.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/migrate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b7fa020003f3..a0b0c5a7f8a5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2159,6 +2159,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			 const int __user *nodes,
 			 int __user *status, int flags)
 {
+	compat_uptr_t __user *compat_pages = (void __user *)pages;
 	int current_node = NUMA_NO_NODE;
 	LIST_HEAD(pagelist);
 	int start, i;
@@ -2171,8 +2172,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		int node;
 
 		err = -EFAULT;
-		if (get_user(p, pages + i))
-			goto out_flush;
+		if (in_compat_syscall()) {
+			compat_uptr_t cp;
+
+			if (get_user(cp, compat_pages + i))
+				goto out_flush;
+
+			p = compat_ptr(cp);
+		} else {
+			if (get_user(p, pages + i))
+				goto out_flush;
+		}
 		if (get_user(node, nodes + i))
 			goto out_flush;
 
-- 
2.39.1

