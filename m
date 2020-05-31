Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9771E9899
	for <lists+linux-arch@lfdr.de>; Sun, 31 May 2020 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgEaPh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 May 2020 11:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaPhZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 May 2020 11:37:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4968C061A0E;
        Sun, 31 May 2020 08:37:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so1161974pgo.9;
        Sun, 31 May 2020 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RaTO38o9otyhYtq1I6wSK46Ur78WV2gmS3uYSc0rOJo=;
        b=aQoWA365yhz+rJoQQtJnW+97BMhM2Y11i5nm/jMQ0/ZAlPMsE5CnR9BVmxARnmFr5A
         hZLJmjPNFF41fgmqUR+VT8spvER4bHSEfUTC8sPeQSiagOo/l944spzLT/3fAHEKrHMe
         ndpOBbvIyFb7R6ci8GTEXOyToWCGLb3zERup6DvnUlSJdaWAWVGhNuxU82bh0TDBKv4F
         EdsXvLW742dVFM33n3sQYqpVrmKRUNJF8MbES5JrdMbfAVIiK7Ea2zjQA2vKDbKp++Jk
         fnmHGLucCggg7NQGIo5G+JzDPDlmn21xPVGhiUxTJRKS/teZL0nfru6qIJV6//U22V0l
         9a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RaTO38o9otyhYtq1I6wSK46Ur78WV2gmS3uYSc0rOJo=;
        b=QCuHg19kMuQfdQWdrieciBSrsYApnIQGUZnQ1IgDhE5zemjjNn2zf2hm+0b9Yp3eX/
         5JCCvbK/eFt8zWRtoYStOuzyh22DCIKTT4o9GHVtvdSx6ciMDtmnd2VbMi2QzRTp1sGr
         rYxjpML8fIH5dvMZ9yTKJEijWDwC4SKNsYyVuwAlVwFczVsjwgPJsQoEEinrUbxZ9Div
         JiVJonMiJBt+ISQ5onqq8VJwnatD+acKvRcA3j88WSfseZiP5FYmZmdapgqaHZaZ4jWC
         hqyCnwbmGAmt6pH9jA9/3bts7ZKJAQcCbhn+bYW/ZG/56lb3wXY+rR27zqyBmLFUg+fE
         5WMA==
X-Gm-Message-State: AOAM531fTBfJEReJMMzm/lnhO22JCUuaIfn5wd4X7jNwOKt7npRLUteT
        qCNeIks6d5KDrC2xkPf/R+E=
X-Google-Smtp-Source: ABdhPJydC3neD6RHO7mbHQQLZqjcsbEtlUXPGAvXxXtwPZJMkMspaVnWd79MkaqZDLL6Y2m3HtOpbg==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr4385268pfa.54.1590939445243;
        Sun, 31 May 2020 08:37:25 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m2sm4976955pjk.52.2020.05.31.08.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 08:37:24 -0700 (PDT)
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <jade.alglave@arm.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [RFC PATCH -rcu lkmm] tools/memory-model/README: Expand dependency of
 klitmus7
Message-ID: <4a05e568-aa30-423a-badc-f79f0af815a0@gmail.com>
Date:   Mon, 1 Jun 2020 00:37:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 87048d7212f6cb16b0a2b85fa6d2f34c28b078c0 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 31 May 2020 20:04:32 +0900
Subject: [PATCH RFC] tools/memory-model/README: Expand dependency of klitmus7

klitmus7 is independent of the memory model but depends on the
build-target kernel release.
It occasionally lost compatibility due to kernel API changes [1, 2, 3].
It was remedied in a backwards-compatible manner respectively [4, 5, 6].

Reflect this fact in README.

[1]: b899a850431e ("compiler.h: Remove ACCESS_ONCE()")
[2]: 0bb95f80a38f ("Makefile: Globally enable VLA warning")
[3]: d56c0d45f0e2 ("proc: decouple proc from VFS with "struct proc_ops"")
[4]: https://github.com/herd/herdtools7/commit/e87d7f9287d1
     ("klitmus: Use WRITE_ONCE and READ_ONCE in place of deprecated ACCESS_ONCE")
[5]: https://github.com/herd/herdtools7/commit/a0cbb10d02be
     ("klitmus: Avoid variable length array")
[6]: https://github.com/herd/herdtools7/commit/46b9412d3a58
     ("klitmus: Linux kernel v5.6.x compat")

NOTE: [5] was ahead of herdtools7 7.53, which did not make an
official release.  Code generated by klitmus7 without [5] can still be
built targeting Linux 4.20--5.5 if you don't care VLA warnings.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi all,

Recent struggle of Andrii with the use of klitmus7 on an up-to-date
Linux system prompted me to add some explanation of klitmus7's dependency
in README.

As herdtools7 7.56 is still under development, I called out just HEAD
in the compatibility table.  Once 7.56 is released, the table can be
updated.

I'm not sure if this is the right place to carry such info.
Anyway, I'd be glad if this patch can trigger a meaningful update of
README.

        Thanks, Akira
--
 tools/memory-model/README | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index b9c562e92981..90af203c3cf1 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -28,8 +28,34 @@ downloaded separately:
 See "herdtools7/INSTALL.md" for installation instructions.
 
 Note that although these tools usually provide backwards compatibility,
-this is not absolutely guaranteed.  Therefore, if a later version does
-not work, please try using the exact version called out above.
+this is not absolutely guaranteed.
+
+For example, a future version of herd7 might not work with the model
+in this release.  A compatible model will likely be made available in
+a later release of Linux kernel.
+
+If you absolutely need to run the model in this particular release,
+please try using the exact version called out above.
+
+klitmus7 is independent of the model provided here.  It has its own
+dependency on a target kernel release where converted code is built
+and executed.  Any change in kernel APIs essential to klitmus7 will
+necessitate an upgrade of klitmus7.
+
+If you find any compatibility issues in klitmus7, please inform the
+memory model maintainers.
+
+klitmus7 Compatibility Table
+----------------------------
+
+	============  ==========
+	target Linux  herdtools7
+	------------  ----------
+	     -- 4.18  7.48 --
+	4.15 -- 4.19  7.49 --
+	4.20 -- 5.5   7.54 --
+	5.6  --       HEAD
+	============  ==========
 
 
 ==================
-- 
2.17.1

