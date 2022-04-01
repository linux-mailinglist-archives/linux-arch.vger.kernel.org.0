Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8C4EFD2E
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353452AbiDAXpR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Apr 2022 19:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353442AbiDAXpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2022 19:45:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0351010A3;
        Fri,  1 Apr 2022 16:43:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CDDF20DF564;
        Fri,  1 Apr 2022 16:43:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CDDF20DF564
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648856603;
        bh=naE2yWyZaQaNiMnDIQWiov5WR90Psm2QKZv45rv75Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmiuJaa2xPPy2t/Dv9Z1nsbu3f1AtYgsKkp8vW/UuVk868xl4JR6DtuSaaa5eTtQ+
         cpUBQ4/7kqfujkyB5lFYPbHGCXVJZa+RtRP2VOioMyUx3kX4td/pCgZHooMT3i9C6a
         ibmDaxHI6Tl/fUSi+4L04XPv5mHAmYr6dj3vuKyk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH 1/7] tracing/user_events: Fix repeated word in comments
Date:   Fri,  1 Apr 2022 16:43:03 -0700
Message-Id: <20220401234309.21252-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401234309.21252-1-beaub@linux.microsoft.com>
References: <20220401234309.21252-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Trivial fix to remove accidental double wording of have in comments.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 706e1686b5eb..a6621c52ce45 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -567,7 +567,7 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 	 * to allow user_event files to be less locked down. The extreme case
 	 * being "other" has read/write access to user_events_data/status.
 	 *
-	 * When not locked down, processes may not have have permissions to
+	 * When not locked down, processes may not have permissions to
 	 * add/remove calls themselves to tracefs. We need to temporarily
 	 * switch to root file permission to allow for this scenario.
 	 */
-- 
2.25.1

