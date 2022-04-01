Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBA4EFD35
	for <lists+linux-arch@lfdr.de>; Sat,  2 Apr 2022 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353472AbiDAXpV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Apr 2022 19:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353444AbiDAXpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Apr 2022 19:45:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA093273A;
        Fri,  1 Apr 2022 16:43:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5E78720DF569;
        Fri,  1 Apr 2022 16:43:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E78720DF569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648856604;
        bh=xWZo/CSo22CarPEM9asusj2BEE04dwPEtFudHgCqIKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBVlKsuFxgDzIokj4+PST2th9lP6GYCYMjZCT1Wapb3ytXbu8vjajqLIMRvI101QP
         37QUXO9TQ8S6SMxC0Hx362lAyWheunrWa4bmJ5ULLJB+FUoCx+URJM9srdUVmTlvUS
         sIkV/BYY0Z3PdMIL6tIwubcHEriHDzLPnXzT2QO8=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, beaub@linux.microsoft.com
Subject: [PATCH 4/7] tracing/user_events: Ensure user provided strings are safely formatted
Date:   Fri,  1 Apr 2022 16:43:06 -0700
Message-Id: <20220401234309.21252-5-beaub@linux.microsoft.com>
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

User processes can provide bad strings that may cause issues or leak
kernel details back out. Don't trust the content of these strings
when formatting strings for matching.

This also moves to a consistent dynamic length string creation model.

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 91 +++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 15edbf6b1e2e..f9bb7d37d76f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -45,7 +45,6 @@
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE 1024
-#define MAX_FIELD_ARG_NAME 256
 
 static char *register_page_data;
 
@@ -483,6 +482,48 @@ static bool user_field_is_dyn_string(const char *type, const char **str_func)
 }
 
 #define LEN_OR_ZERO (len ? len - pos : 0)
+static int user_dyn_field_set_string(int argc, const char **argv, int *iout,
+				     char *buf, int len, bool *colon)
+{
+	int pos = 0, i = *iout;
+
+	*colon = false;
+
+	for (; i < argc; ++i) {
+		if (i != *iout)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
+
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", argv[i]);
+
+		if (strchr(argv[i], ';')) {
+			++i;
+			*colon = true;
+			break;
+		}
+	}
+
+	/* Actual set, advance i */
+	if (len != 0)
+		*iout = i;
+
+	return pos + 1;
+}
+
+static int user_field_set_string(struct ftrace_event_field *field,
+				 char *buf, int len, bool colon)
+{
+	int pos = 0;
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->type);
+	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
+
+	if (colon)
+		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
+
+	return pos + 1;
+}
+
 static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
 {
 	struct ftrace_event_field *field, *next;
@@ -926,49 +967,35 @@ static int user_event_free(struct dyn_event *ev)
 static bool user_field_match(struct ftrace_event_field *field, int argc,
 			     const char **argv, int *iout)
 {
-	char *field_name, *arg_name;
-	int len, pos, i = *iout;
+	char *field_name = NULL, *dyn_field_name = NULL;
 	bool colon = false, match = false;
+	int dyn_len, len;
 
-	if (i >= argc)
+	if (*iout >= argc)
 		return false;
 
-	len = MAX_FIELD_ARG_NAME;
-	field_name = kmalloc(len, GFP_KERNEL);
-	arg_name = kmalloc(len, GFP_KERNEL);
+	dyn_len = user_dyn_field_set_string(argc, argv, iout, dyn_field_name,
+					    0, &colon);
 
-	if (!arg_name || !field_name)
-		goto out;
-
-	pos = 0;
-
-	for (; i < argc; ++i) {
-		if (i != *iout)
-			pos += snprintf(arg_name + pos, len - pos, " ");
+	len = user_field_set_string(field, field_name, 0, colon);
 
-		pos += snprintf(arg_name + pos, len - pos, argv[i]);
-
-		if (strchr(argv[i], ';')) {
-			++i;
-			colon = true;
-			break;
-		}
-	}
+	if (dyn_len != len)
+		return false;
 
-	pos = 0;
+	dyn_field_name = kmalloc(dyn_len, GFP_KERNEL);
+	field_name = kmalloc(len, GFP_KERNEL);
 
-	pos += snprintf(field_name + pos, len - pos, field->type);
-	pos += snprintf(field_name + pos, len - pos, " ");
-	pos += snprintf(field_name + pos, len - pos, field->name);
+	if (!dyn_field_name || !field_name)
+		goto out;
 
-	if (colon)
-		pos += snprintf(field_name + pos, len - pos, ";");
+	user_dyn_field_set_string(argc, argv, iout, dyn_field_name,
+				  dyn_len, &colon);
 
-	*iout = i;
+	user_field_set_string(field, field_name, len, colon);
 
-	match = strcmp(arg_name, field_name) == 0;
+	match = strcmp(dyn_field_name, field_name) == 0;
 out:
-	kfree(arg_name);
+	kfree(dyn_field_name);
 	kfree(field_name);
 
 	return match;
-- 
2.25.1

