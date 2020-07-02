Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DD212599
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgGBOIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgGBOIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC9C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d194so10149915pga.13
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bfz1YZ5dIoN2aGR7YJ8XQT/WwiC9kxrzNC++l1jbOuI=;
        b=YDwkos8LleCOmOPe/U0+N+mFT9PRdHKRRV+ZDzhybm0Luk1vRh4AAKodqz0HR6NU5/
         ISaX1FvNVlfi33zqZe/LDhMaVihrWbgVjX4UJdNIVe273/CCL/ifIT6gYsolLOylKNa7
         LqXlO2/d6oBUjHpL51uVoGirv1dkPYzEGy7199AvDKnWeUj4+sfn4ovyn8Yl/uLcKIFV
         0XtnfRP/NZ4Uieg3J9tY7Vt9eHQVTxUuA+a6HZdLSmjQVRGJd55vjvyFdmrGTdl1LEK7
         IRVsvs4vJaqGXnmXUgMH/e9C4y4XQ3CLCB7TnP3xq07EvmvJCotY4z4i2m3MxWW2b0qU
         5WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bfz1YZ5dIoN2aGR7YJ8XQT/WwiC9kxrzNC++l1jbOuI=;
        b=BgfjzLe5ZnlOEbwvwk6B6N10ftqZo4jKpI3d4oBI37ejDaxkyj49uPr9EpmX3UnZDe
         UoME9cW3nmBqP0qTcIOpRebAof1iL2GJLMbXPCpmhvNuYsLFdubJiw17olGq2+4mAVg+
         asRarsrI67wvXncw4kwlCQXC9deu2W9XcDpb80VZPJFpfnRenrGM0cBfLQy9IGixEWmX
         jX5dItiASF3o6oOpHHyP4prcuiL8qry5w1sKA3adIVGhMTi3j1V6Cs5972kSVcozhf2M
         QzjXdQNb6irkJUu8woB4591RRqHp5j2XrQRspxv3C7xWe7+icBQfHRrHBJQacR0awah2
         4UDQ==
X-Gm-Message-State: AOAM533O+WiQHt/RbAK8JxTj/yUwPr9Qkt+V0LDd/SLAE0wJlpk4szkC
        isz5wWT6rpITBL+PC7pak+E=
X-Google-Smtp-Source: ABdhPJzE/EVJO1jdczzDxwkpPpM/Qi0clImGr1FMj4cMS9s70OPXQn3No2fW49gU3ld7EikPUthWIg==
X-Received: by 2002:a05:6a00:d:: with SMTP id h13mr22984991pfk.288.1593698900573;
        Thu, 02 Jul 2020 07:08:20 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id y7sm8638061pgk.93.2020.07.02.07.08.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:08:20 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 69BEB202D31CF9; Thu,  2 Jul 2020 23:08:17 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v5 04/21] um: host: implement os_initcalls and os_exitcalls
Date:   Thu,  2 Jul 2020 23:06:58 +0900
Message-Id: <9e12b717709d74821a1432467e6800d7741e35b9.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi@cs.pub.ro>

This patch implements the init and exit calls for host code. It uses
the automatic __start_<section> and __stop_<section> variables that
are defined by gcc / ld when using custom sections.

Note that this patch should be merged with "um: move arch/um/os-Linux
dir to tools/um" but for now it is separate to make the review easier.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 tools/um/uml/util.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/um/uml/util.c b/tools/um/uml/util.c
index ecf2f390fad2..4011b36fee7e 100644
--- a/tools/um/uml/util.c
+++ b/tools/um/uml/util.c
@@ -186,3 +186,29 @@ void os_warn(const char *fmt, ...)
 	vfprintf(stderr, fmt, list);
 	va_end(list);
 }
+
+extern void (*__start_os_exitcalls)(void);
+extern void (*__stop_os_exitcalls)(void);
+
+void os_exitcalls(void)
+{
+	exitcall_t *call;
+
+	call = &__stop_os_exitcalls;
+	while (--call >= &__start_os_exitcalls)
+		(*call)();
+}
+
+extern int (*__start_os_initcalls)(void);
+extern int (*__stop_os_initcalls)(void);
+
+int os_initcalls(void)
+{
+	initcall_t *call;
+
+	call = &__stop_os_initcalls;
+	while (--call >= &__start_os_initcalls)
+		(*call)();
+
+	return 0;
+}
-- 
2.21.0 (Apple Git-122.2)

