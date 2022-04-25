Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4350E8A4
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 20:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbiDYStv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbiDYSts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 14:49:48 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B9C6F49E;
        Mon, 25 Apr 2022 11:46:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id B9A2B20E8CA6;
        Mon, 25 Apr 2022 11:46:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9A2B20E8CA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650912403;
        bh=Oh80tgumXtzVzhggUEiO+Gt+FYTYz042ycLpTb3589E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMYMYZCUet8AdU+O5wAVlNQEAXDRLOGP+igAKz16cgji+xyP1PSxBBdYHzff18uiw
         N0SPsg+EYTgd2NrbUtQIcqCa/u97XnTKMi9pbqGhZVhGeCzRh0pT0AqEuH56/40BKk
         1c+i24K/5RPJr9YJwatz9Jr6ZWUakbRLdWU7b8XM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH v2 2/7] tracing/user_events: Use NULL for strstr checks
Date:   Mon, 25 Apr 2022 11:46:26 -0700
Message-Id: <20220425184631.2068-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425184631.2068-1-beaub@linux.microsoft.com>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
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

Trivial fix to ensure strstr checks use NULL instead of 0.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index a6621c52ce45..075d694d20e3 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -277,7 +277,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	goto add_field;
 
 add_validator:
-	if (strstr(type, "char") != 0)
+	if (strstr(type, "char") != NULL)
 		validator_flags |= VALIDATOR_ENSURE_NULL;
 
 	validator = kmalloc(sizeof(*validator), GFP_KERNEL);
@@ -458,7 +458,7 @@ static const char *user_field_format(const char *type)
 		return "%d";
 	if (strcmp(type, "unsigned char") == 0)
 		return "%u";
-	if (strstr(type, "char[") != 0)
+	if (strstr(type, "char[") != NULL)
 		return "%s";
 
 	/* Unknown, likely struct, allowed treat as 64-bit */
@@ -479,7 +479,7 @@ static bool user_field_is_dyn_string(const char *type, const char **str_func)
 
 	return false;
 check:
-	return strstr(type, "char") != 0;
+	return strstr(type, "char") != NULL;
 }
 
 #define LEN_OR_ZERO (len ? len - pos : 0)
-- 
2.25.1

