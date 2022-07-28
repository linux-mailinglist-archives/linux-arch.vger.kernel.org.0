Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C96D5848B3
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jul 2022 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiG1XdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jul 2022 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiG1XdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2022 19:33:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8B3178DCC;
        Thu, 28 Jul 2022 16:33:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 79BB120FE9AA;
        Thu, 28 Jul 2022 16:33:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79BB120FE9AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659051193;
        bh=ZmUiorrcv4hSBgHHc4SmHe16T+eq+bKCUHOlyXmVWb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D34PSA0OpGx0aTGf6sUC0qJHYL+fdisIxIb1Psqr27KM+t5KLgS+10rwtOuzlmzIM
         CmwvmF7HxeWZAYLWObExpl2QA1ThpJ3NCD4wiNWJ4jvevmoO+j+Mi+Hc9EkZjH2XbX
         m4I7b1YMv7VB7hkaKoW1ZLX6Q+aaoyfjm9LvJFLY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v3 2/6] tracing/user_events: Use WRITE instead of READ for io vector import
Date:   Thu, 28 Jul 2022 16:33:05 -0700
Message-Id: <20220728233309.1896-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728233309.1896-1-beaub@linux.microsoft.com>
References: <20220728233309.1896-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

import_single_range expects the direction/rw to be where it came from,
not the protection/limit. Since the import is in a write path use WRITE.

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 075d694d20e3..15edbf6b1e2e 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1245,7 +1245,8 @@ static ssize_t user_events_write(struct file *file, const char __user *ubuf,
 	if (unlikely(*ppos != 0))
 		return -EFAULT;
 
-	if (unlikely(import_single_range(READ, (char *)ubuf, count, &iov, &i)))
+	if (unlikely(import_single_range(WRITE, (char __user *)ubuf,
+					 count, &iov, &i)))
 		return -EFAULT;
 
 	return user_events_write_core(file, &i);
-- 
2.25.1

