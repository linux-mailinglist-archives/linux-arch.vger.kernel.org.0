Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD43F686D
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhHXRzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240263AbhHXRzg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Aug 2021 13:55:36 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09DC061146
        for <linux-arch@vger.kernel.org>; Tue, 24 Aug 2021 10:25:27 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so14829104qkd.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Aug 2021 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PyPyoQ1Y/vEaAdOthKoeZXWHDoxb0qT1TuN9oYnPBQI=;
        b=h+z6Loajqhrn8HSErPRwJYnI/+inKFY98+8bBTTxs3X5Z/9UyGGcgfxsnVnZqi9adG
         +YBh8ix6JOoWG5kdKy7bPE6pLDW9V4A4kroXhwNCSHX/oFzfEUnHdFyCnnDb0yYmXQQ9
         BQjxyGRlgPd+Tf8YRGvHokYMJmFdl4evWWgL0TuXb4n8mJk6R6o+z+aieC+4URdYpFor
         0gfdMZmQu4Qu9NCpYp0JjjNhw8mkzSi2uQjWDxMJktVNXc4ijBS2WY2wtnuh/fyDNysN
         +6PZWw6cpfesqFg4HnE7l0vkMqnC3yeU/dLwtm9LFe4QH1brC0PLbB+37REAX5PjBSa8
         daYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PyPyoQ1Y/vEaAdOthKoeZXWHDoxb0qT1TuN9oYnPBQI=;
        b=ToQMIKYWFvuvH/fWcofck7Wq8i0BoH+a5HntQjKgCil2PBG5LZ3kcGLz9wE4ARkJb2
         NpCPrncGukBv1JpXPPtuyS2UrIHrj3cNizupmLTK2iCeU9uoJXZ+DNRKacSGADzZxqE1
         5k9p9ishVUEoJJ2wrHjnM3ODfI/YM/VllcMiJTNWVfnwFMghtSjFpUaQdAi6Lzi0HrbT
         rRbugZofCZDQSSBZVef3dRAkA/RCsrryEf4eQu84UmTfmRL1inetfrPYxNL4tQ/g9LYA
         imefCn0RhN9Z65Qdm8h7x8sHc/llT6H9zrMoz5/1WipO+Mpi0Ft19MnjAuySDitZGeRY
         O/1Q==
X-Gm-Message-State: AOAM532WBfi4FcUeZk2U/ACCZDLLg/ZII2GucM1umu+xxaxl6XVD7MPq
        lp4ckFZeuAvOci+EnMP0xJU13MFrdmF1aiY=
X-Google-Smtp-Source: ABdhPJxM/8EOtFkSe4GDPRUMyhOAPeoIDeN1pVC9NRMDi06tinxv4FzPxBlDGiaQ/CwffoFKykMxDCKk1xVCuDo=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:ad4:5b8b:: with SMTP id
 11mr5938631qvp.51.1629825926578; Tue, 24 Aug 2021 10:25:26 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:25:20 +0000
Message-Id: <20210824172520.2284531-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [RFC PATCH v1] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ramji Jiyani <ramjiyani@google.com>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit f5cb779ba163 ("ANDROID: binder: remove waitqueue when thread
exits.") fixed the use-after-free in eventpoll but aio still has the
same issue because it doesn't honor the POLLFREE flag.

Add support for the POLLFREE flag to force complete iocb inline in
aio_poll_wake(). A thread may use it to signal it's exit and/or request
to cleanup while pending poll request. In this case, aio_poll_wake()
needs to make sure it doesn't keep any reference to the queue entry
before returning from wake to avoid possible use after free via
poll_cancel() path.

The POLLFREE flag is no more exclusive to the epoll and is being
shared with the aio. Remove comment from poll.h to avoid confusion.
Also enclosed the POLLFREE macro definition in parentheses to fix
checkpatch error.

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
---
 fs/aio.c                        | 45 ++++++++++++++++++---------------
 include/uapi/asm-generic/poll.h |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 76ce0cc3ee4e..2c432cbb38e5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1674,6 +1674,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
 	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
+	struct kioctx *ctx = iocb->ki_ctx;
 	__poll_t mask = key_to_poll(key);
 	unsigned long flags;
 
@@ -1683,29 +1684,33 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&req->wait.entry);
 
-	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
-		struct kioctx *ctx = iocb->ki_ctx;
+	/*
+	 * Use irqsave/irqrestore because not all filesystems (e.g. fuse)
+	 * call this function with IRQs disabled and because IRQs have to
+	 * be disabled before ctx_lock is obtained.
+	 */
+	if (mask & POLLFREE) {
+		/* Force complete iocb inline to remove refs to deleted entry */
+		spin_lock_irqsave(&ctx->ctx_lock, flags);
+	} else if (!(mask && spin_trylock_irqsave(&ctx->ctx_lock, flags))) {
+		/* Can't complete iocb inline; schedule for later */
+		schedule_work(&req->work);
+		return 1;
+	}
 
-		/*
-		 * Try to complete the iocb inline if we can. Use
-		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
-		 * call this function with IRQs disabled and because IRQs
-		 * have to be disabled before ctx_lock is obtained.
-		 */
-		list_del(&iocb->ki_list);
-		iocb->ki_res.res = mangle_poll(mask);
-		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
-			iocb = NULL;
-			INIT_WORK(&req->work, aio_poll_put_work);
-			schedule_work(&req->work);
-		}
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		if (iocb)
-			iocb_put(iocb);
-	} else {
+	/* complete iocb inline */
+	list_del(&iocb->ki_list);
+	iocb->ki_res.res = mangle_poll(mask);
+	req->done = true;
+	if (iocb->ki_eventfd && eventfd_signal_count()) {
+		iocb = NULL;
+		INIT_WORK(&req->work, aio_poll_put_work);
 		schedule_work(&req->work);
 	}
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (iocb)
+		iocb_put(iocb);
+
 	return 1;
 }
 
diff --git a/include/uapi/asm-generic/poll.h b/include/uapi/asm-generic/poll.h
index 41b509f410bf..35b1b69af729 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -29,7 +29,7 @@
 #define POLLRDHUP       0x2000
 #endif
 
-#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
+#define POLLFREE	((__force __poll_t)0x4000)
 
 #define POLL_BUSY_LOOP	(__force __poll_t)0x8000
 
-- 
2.33.0.rc2.250.ged5fa647cd-goog

