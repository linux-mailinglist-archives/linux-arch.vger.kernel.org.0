Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB3B2045E7
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 02:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbgFWAkP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 20:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbgFWAkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 20:40:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D28C061795;
        Mon, 22 Jun 2020 17:39:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l63so138294oih.13;
        Mon, 22 Jun 2020 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68GP117GFRUsx6QpEeOc82reTKVBWwmz16vEIsvU5G4=;
        b=gmta/vZGc8pQNwndeUZSBEuYDUhotgIBPf7X5ZvRpmklWY2K8gINbs+jySCeUE2nC2
         Yqk/WGvdHJfIT3634Lxi3hX7KTOPzvm3eitow6IQwwD0mwkfrh6vZhy2JvLVNmAYIce0
         7uh5OGP9Sf28c10JfHn7VlATpBKZRcod48KbG0O0T4Vimb7aPQSWPbreT7NjTfikH5NG
         yTkdUaNB057OVAKh6yB5V/K20AzqE4Zgud+IB5xKV3l98uUJZeDjvf5mg/Xcb/5R+brM
         zDJYeM4kDanPSnMH+RiQgzFK8KvNwVQ7ViETmlQHxJQIfggL81fdYQyS4lOG7hSmDwf2
         KVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68GP117GFRUsx6QpEeOc82reTKVBWwmz16vEIsvU5G4=;
        b=IDy/OwqfYMg40AyM6veAxuH9OaRnDN04Q4CPuGFdEm26ZmkeefbYSUiD5Zdte7dJlA
         sjYojSw8aplBjAhxnfOaTzxxEumcHgnDdhoDG7jwhdD3Qs8kbvmmu7bMzbvQgtzOWel4
         0WbM5wP7HHYTJ6cUiKICoIJEg5pzG+ZHTUybdlvbnNabkE+DuBSVwdsSiLZ3udnZiQ1A
         uqwlCKOQcXEa4Y/ujOnE53midoCi67thDC4nY3dWt/aJCopca7rhru1LfnEVy5+D+YjT
         L07ynI4mCE4rpjJkd+qff1eJ6yMvYAfIe3h9Zt76x/H3RbKFJbDALZyL2iiWsV6nAhoZ
         DxfQ==
X-Gm-Message-State: AOAM533ffLVZEq/CK7T1xMWfph2lOr9dXM7eR84El+WBHYJwvnqyxwQY
        BtqMsdr8rxUTf94Wv9WpOKk=
X-Google-Smtp-Source: ABdhPJx+RrYbJfFiUi0YzMQpliOjObSZz4xZivexdIDBHV5ROsp9MKcr19adXrjBQNGDfBB5c4pbkg==
X-Received: by 2002:aca:5c1:: with SMTP id 184mr13713429oif.119.1592872773768;
        Mon, 22 Jun 2020 17:39:33 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id y31sm3677828otb.41.2020.06.22.17.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:39:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/2] media: omap3isp: Remove cacheflush.h
Date:   Mon, 22 Jun 2020 16:47:39 -0700
Message-Id: <20200622234740.72825-2-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234740.72825-1-natechancellor@gmail.com>
References: <20200622234740.72825-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After mm.h was removed from the asm-generic version of cacheflush.h,
s390 allyesconfig shows several warnings of the following nature:

In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
                 from drivers/media/platform/omap3isp/isp.c:42:
./include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct'
declared inside parameter list will not be visible outside of this
definition or declaration

As Geert and Laurent point out, this driver does not need this header in
the two files that include it. Remove it so there are no warnings.

Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/platform/omap3isp/isp.c      | 2 --
 drivers/media/platform/omap3isp/ispvideo.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index a4ee6b86663e..b91e472ee764 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -39,8 +39,6 @@
  *	Troy Laramy <t-laramy@ti.com>
  */
 
-#include <asm/cacheflush.h>
-
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/omap3isp/ispvideo.c
index 10c214bd0903..1ac9aef70dff 100644
--- a/drivers/media/platform/omap3isp/ispvideo.c
+++ b/drivers/media/platform/omap3isp/ispvideo.c
@@ -18,7 +18,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
 
 #include <media/v4l2-dev.h>
 #include <media/v4l2-ioctl.h>

base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821
-- 
2.27.0

