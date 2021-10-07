Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072DF424B15
	for <lists+linux-arch@lfdr.de>; Thu,  7 Oct 2021 02:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhJGA1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Oct 2021 20:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbhJGA1G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2021 20:27:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA912C061746
        for <linux-arch@vger.kernel.org>; Wed,  6 Oct 2021 17:25:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso2428245pgv.22
        for <linux-arch@vger.kernel.org>; Wed, 06 Oct 2021 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7Ja3a3I+8c/EKROv5jASLlm7Xu+rNzxKS6xpAGRef0U=;
        b=kjyFL9j9zVP1x2XbWEFzkEe955xziyCeATWIBzI7CYQ7+JHl3B8L+4jW1iRs0ID269
         MAVNpBIfGsGfsPB/Ce75xoR7WIud5sx8ZrFs2hK65z41WqAG3rmLaokrkoKGDZ38cXcc
         vBOerOGAN9NixyF46PdqExDNzn+ljNEz1AcEMq6LA5tqxPAHvszFgWdItwQgME3jWleQ
         9/bE/PtKF7nUSS8JibfKUif/BvR4H+i8Lvf0pD1AicPP7CdGnVHQP6Nb76vlM4rQ0Ala
         d0Dz/6Yr/jCj8h4YTEUMDd958LC+YMikXYQ5MP6ZrSwtksDWoJyF+HF1810V+udRqTgb
         9gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7Ja3a3I+8c/EKROv5jASLlm7Xu+rNzxKS6xpAGRef0U=;
        b=LKbU1HL4jah+OBMPy6Xs7k37+/HQVJcFGsDF3OrsU8lR91DMWN+Ah3kL35K76F1XiS
         IbtqUKa8X/hxEuON5Rtbr07s3uK2La6ei8ZjvZK6opI8pm4oHDftWxGSNq5cGcFmhOAh
         mXNz1a7+impSfy1m5DMhKbmCgqMMfXm1wDMFuteLOD6c4CW9O33Rmjaw71YKtkOJXil9
         GpA2K9nm/nn6pARs/4iDhSU/BesgAqZPWOXKVOEs4Yal8+CCr50kUGe5m0rseHpAhsd8
         Yzh6XQWKqKs8nwNIHwVxXvBpf+XzQBkyTt30zKTxXohhBfdqYUcHUQ/9RZZX+wvAiRSj
         lYiw==
X-Gm-Message-State: AOAM533MokOp/6dwpq2FZHdBRKmqKIK1cD8Ah4Z68HUyK+ku3y4XHMiu
        HLy8olYacZFgxDlPCZ8QuYj8fSS0CWw+aC0=
X-Google-Smtp-Source: ABdhPJw2y8gkHLZpXISHlXjQTpFGbls2wfalhOcdz3QO9CAc3o6xV7wI77ALfwgRxMNjw3+agg09ZLYLKQEHAs0=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:a17:902:d203:b0:13e:d053:1aa8 with SMTP
 id t3-20020a170902d20300b0013ed0531aa8mr1023678ply.40.1633566313287; Wed, 06
 Oct 2021 17:25:13 -0700 (PDT)
Date:   Thu,  7 Oct 2021 00:25:07 +0000
Message-Id: <20211007002507.42501-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc:     hch@lst.de, kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, ebiggers@kernel.org,
        Ramji Jiyani <ramjiyani@google.com>,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for the POLLFREE flag to force complete iocb inline in
aio_poll_wake(). A thread may use it to signal it's exit and/or request
to cleanup while pending poll request. In this case, aio_poll_wake()
needs to make sure it doesn't keep any reference to the queue entry
before returning from wake to avoid possible use after free via
poll_cancel() path.

UAF issue was found during binder and aio interactions in certain
sequence of events [1].

The POLLFREE flag is no more exclusive to the epoll and is being
shared with the aio. Remove comment from poll.h to avoid confusion.

[1] https://lore.kernel.org/r/CAKUd0B_TCXRY4h1hTztfwWbNSFQqsudDLn2S_28csgWZmZAG3Q@mail.gmail.com/

Fixes: af5c72b1fc7a ("Fix aio_poll() races")
Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Cc: stable@vger.kernel.org # 4.19+
---
Changes since v1:
- Removed parenthesis around POLLFREE macro definition as per review.
- Updated description to refer UAF issue discussion this patch fixes.
- Updated description to remove reference to parenthesis change.
- Added Reviewed-by

Changes since v2:
- Added Fixes tag.
- Added stable tag for backporting on 4.19+ LTS releases

Changes since v3:
- Updated patch description
- Updated Fixes tag to issue manifestation origin
---
 fs/aio.c                        | 45 ++++++++++++++++++---------------
 include/uapi/asm-generic/poll.h |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..5d539c05df42 100644
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
-		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
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
+	if (iocb->ki_eventfd && eventfd_signal_allowed()) {
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
index 41b509f410bf..f9c520ce4bf4 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -29,7 +29,7 @@
 #define POLLRDHUP       0x2000
 #endif
 
-#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
+#define POLLFREE	(__force __poll_t)0x4000
 
 #define POLL_BUSY_LOOP	(__force __poll_t)0x8000
 
-- 
2.33.0.800.g4c38ced690-goog

