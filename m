Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EF24BA8BF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbiBQSuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244625AbiBQSuP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17E522D8;
        Thu, 17 Feb 2022 10:50:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so8586271edk.12;
        Thu, 17 Feb 2022 10:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/tXywgWcjoxJRzGsDhwx7/PqgtdIxpeFw3OBwiMgEc=;
        b=jVT3FGeUaE5POK128yREy9rdStZKFkWoseVl4YdjXSw2oknas7UyHZ4Jwvd00EphbP
         ERTV9ZvJRIhcYqdZ3TVstkPJZG5/vSrK+XpVEMvUwpBwghKQbkUhm+wS1UPA8uuV0AoP
         k76sGspPlQFHmgoH1ifBieex58D/FIKTgYSsxICgS6gEXznNTQxmJxzXzSX2xibEroTs
         h/dhmorYNdk4UX6e5hacSnkuJutn1IFVfiNUp392baUowYsXn9kDgM2AkGKffGow3and
         e0nEp/yJWNy0jJPqeShfbW1b2gM/CgD59Ncu23uR46uibxVF6j5UM+N6S5/NkwghZjC3
         3fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/tXywgWcjoxJRzGsDhwx7/PqgtdIxpeFw3OBwiMgEc=;
        b=4IKNKuJwWvcu9TvfaDqa+nyji3MPQuR/2FeZ/fILkz7rhA25YvxbjBlJjEznntPmR1
         xIlWde+nuYN7j9IMufQFHT88wEmWP4jhn04lS9cDLy5KjcfndtlOIonumQRa3UK4CHlN
         SBUhKRpWU2DSCvAbrBxdFc/ON0F81YwBcX+/PCNtA38tnRg4N7uMpHq1CfpWlpmDWx32
         8ohdVqZadyh1ZeHihIvPnTvxRxCGvV9cCwNay82LFyywXquBIveHXnEBc2Yzt8dnuRDU
         OSJxUVFp7rfi6WhlWLqZOo9SDSw9F8WFmn2XB1rFTq0FooP4Kv2mGN6VuRkuGIlX7dmj
         mUWg==
X-Gm-Message-State: AOAM533d9Ed7HJcN3YgMxDSjeIgMVLHUjmILnMB5o8pQCOmut6meGOw0
        nVTh5odLi2IQr8pANSH1sfM=
X-Google-Smtp-Source: ABdhPJyQxLL5ymfvMWl7ULAGVOQiuETx992R3qYTUkxbRt2G2dqEkaOz6h5A/3+oGeweBcwqtSfICQ==
X-Received: by 2002:a05:6402:3691:b0:410:a178:6be1 with SMTP id ej17-20020a056402369100b00410a1786be1mr4173352edb.287.1645123799786;
        Thu, 17 Feb 2022 10:49:59 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:49:59 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 02/13] scripts: coccinelle: adapt to find list_for_each_entry nospec issues
Date:   Thu, 17 Feb 2022 19:48:18 +0100
Message-Id: <20220217184829.1991035-3-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217184829.1991035-1-jakobkoschel@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These changes are just temporary to illustrate how I composed the list
of code locations mentioned here.
While for example the usage of &c->member is currently safe to use,
it is an issue if c is set to NULL when the terminating condition is
met.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 .../coccinelle/iterators/use_after_iter.cocci | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
index 676edd562eef..01563a242f00 100644
--- a/scripts/coccinelle/iterators/use_after_iter.cocci
+++ b/scripts/coccinelle/iterators/use_after_iter.cocci
@@ -91,43 +91,19 @@ list_for_each_entry(c,...) S
 |
 list_for_each_entry_reverse(c,...) S
 |
-list_for_each_entry_continue(c,...) S
-|
-list_for_each_entry_continue_reverse(c,...) S
-|
-list_for_each_entry_from(c,...) S
-|
 list_for_each_entry_safe(c,...) S
 |
 list_for_each_entry_safe(x,c,...) S
 |
-list_for_each_entry_safe_continue(c,...) S
-|
-list_for_each_entry_safe_continue(x,c,...) S
-|
-list_for_each_entry_safe_from(c,...) S
-|
-list_for_each_entry_safe_from(x,c,...) S
-|
 list_for_each_entry_safe_reverse(c,...) S
 |
 list_for_each_entry_safe_reverse(x,c,...) S
 |
 hlist_for_each_entry(c,...) S
 |
-hlist_for_each_entry_continue(c,...) S
-|
-hlist_for_each_entry_from(c,...) S
-|
 hlist_for_each_entry_safe(c,...) S
 |
-list_remove_head(x,c,...)
-|
-list_entry_is_head(c,...)
-|
 sizeof(<+...c...+>)
-|
- &c->member
 |
 T c;
 |
-- 
2.25.1

