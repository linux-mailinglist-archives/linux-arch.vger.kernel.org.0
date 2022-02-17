Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC514BA8CC
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbiBQSu1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244632AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60F527D1;
        Thu, 17 Feb 2022 10:50:03 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lw4so9368369ejb.12;
        Thu, 17 Feb 2022 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2EDUr3xcd5mXkWQmbeSTJkbyfBykW87kRKEwtU/qi4=;
        b=KMhtZy1aw/g9aZk2dKJwQL+5I7qUzM9kmJTJZ67p5IR7ZCAUJ7h2I8tTGd3M/sknjm
         gi7SEe6J+b6Gn1l6vIe752TXM860itvoV6U2b+XDuotIxetF7l9JyCUyY5N68O2V/HnV
         LvBh5c1PFXGmkhWk2dHGOLbbFKdG+nlg302kC08igise0K2xFzjQe8pr/8GAgqsC/+tS
         1n0KzDTkPdlJbP29JODQLNf75LgvBVLrrUh5KYmL5aUF0XE/eOn+LWW6+fiVLsaU0tzX
         xWT1Wl7lg1sw0kNz/39GS03sETp0uIcZxWPbHEGEHz0HneUSxEZoKCjwRn4wBcGbhJur
         w6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2EDUr3xcd5mXkWQmbeSTJkbyfBykW87kRKEwtU/qi4=;
        b=CJI4MaEmBRDqflv3fxszJVDOfn0cVHQsI82vEpZs8cpkQuIA/Qx1PdlkvpiFVFfQcM
         Oy+Z6w92ekudbtAWZfoT5OJ2QbJF/zYeTj51v9PNenhET2ZZbPHykXm7r3doWs3U7kAg
         l4SQmwHh5nr+G032JWTwNdEiiBU3drislln95SGcvbSpc2VB9O7rYS1fLnuqXzYnzz5a
         CKiVAStFXZU8YnsQtD0r8psevJfnrkPt0NijrY/Fe5y2Y3Wb+sWupNEun6xkX/zNuN6u
         /6inRy8RMY71uIIlgQMqARiuBcg6kVPF3JUy52fnaUbNBz8lttzR7zD65XPmlJljBWbx
         DglQ==
X-Gm-Message-State: AOAM5323aYi7H4YlhuSy1Sh9ef6Uq1HKkNhDFtnuMk3UKfShucWcAucp
        ZoEN4AZ0oYo6Fe4O8A/ns9I=
X-Google-Smtp-Source: ABdhPJzTxZDIUqCgkh4rMHsmNsIMTp1nMdZ8ITZuVbR0PoJ9bbt1buiZMTtj+pfxqYHdC12tG5hM1A==
X-Received: by 2002:a17:907:1256:b0:6b0:5b4c:d855 with SMTP id wc22-20020a170907125600b006b05b4cd855mr3727693ejb.458.1645123801867;
        Thu, 17 Feb 2022 10:50:01 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:01 -0800 (PST)
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
Subject: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:20 +0100
Message-Id: <20220217184829.1991035-5-jakobkoschel@gmail.com>
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

It is unsafe to assume that tmp != mdev can only evaluate to false
if the break within the list iterator is hit.

When the break is not hit, tmp is set to an address derived from the
head element. If mdev would match with that value of tmp it would allow
continuing beyond the safety check even if mdev was never found within
the list

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/vfio/mdev/mdev_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b314101237fe..e646ba5036f4 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -339,14 +339,17 @@ int mdev_device_remove(struct mdev_device *mdev)
 {
 	struct mdev_device *tmp;
 	struct mdev_parent *parent = mdev->type->parent;
+	bool found = false;
 
 	mutex_lock(&mdev_list_lock);
 	list_for_each_entry(tmp, &mdev_list, next) {
-		if (tmp == mdev)
+		if (tmp == mdev) {
+			found = true;
 			break;
+		}
 	}
 
-	if (tmp != mdev) {
+	if (!found) {
 		mutex_unlock(&mdev_list_lock);
 		return -ENODEV;
 	}
-- 
2.25.1

