Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFAA6D10BD
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjC3VV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3VV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 17:21:58 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065810AB6;
        Thu, 30 Mar 2023 14:21:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id on15so1905864qvb.7;
        Thu, 30 Mar 2023 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680211311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYj8fcxQM5yL1WZ2W63Iadfn/xWimKUhnbecDRMVdY0=;
        b=nhBYHkahh/Luaib5FOIigmx2exL4hEml9T8eyq5N93fFGxBbClqfXTUG12zgJ8POIw
         8M/+1DEhrHK3Z2rwxUZvDopPXG0Tac74t8K/DAzuu/W83IInD/r503qHUOK3f2yNxDRW
         GzSrrc2AHqYSNGlm6WvKyZnWevWdaSHmX57eeo9uGPOSPXgQIdJ9pIicuuR5NKq7CAZa
         tHfWhyWgXi9kflXfOIIDnKbwjlOflbuqy32LQdC7VumyCX9v2jGQMcP19r0SoNJwmMk9
         GcGdV2jjwr6akgERXe8iiHK+V96vw8ex2JJ2chTq09FaxTwm28wZQFhocH4gL/4KVqxf
         RcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYj8fcxQM5yL1WZ2W63Iadfn/xWimKUhnbecDRMVdY0=;
        b=Bw0jrdue0sBnKd5rM2l+Ka01VSe8iLFn/mEE2FwleYpQAzSReumREZk/aYnmdLZZvq
         Ly2+xopUH9turzvvgStsbNkSS3+2JWG5Fo44QfXO5nTvH0QDdsmoZop4WAJUxBbrDn69
         WRjQaiyjtjCbDLX1Ya0AEynNLuewQnVd/fQ5LfRaQNtH/sCvySk3PWLIpMSapI/lcdnZ
         W6qOWZGijyPyJcyLVUEppVVLHH4vFbiR0UAP1zeiAjougod4mVMH0L0gBQrsLoAe9ale
         F4Kt6g/YhSBUCCMtLkdMjGMCW6eJLHTZTT7qO7EW2bYv3lRReu+MARyZO3U2Xd3waRkr
         6rfA==
X-Gm-Message-State: AAQBX9fEiYOx6RT4OaiemcGMiBB3etPaeCQBg2fAJbUSW/7vChJN6Y9q
        jC3g7rnWmgie0agOOHCpBHz/2lhaHZPxajU=
X-Google-Smtp-Source: AKy350bR9Bm0/UuEYAy15bFQDRdpjescA6AjtUoAK/PzxjtQ5JpwiYJFyPBJggL31vzGfEk2O2HV+g==
X-Received: by 2002:a05:6214:27ee:b0:5c8:b343:f749 with SMTP id jt14-20020a05621427ee00b005c8b343f749mr34557705qvb.22.1680211311468;
        Thu, 30 Mar 2023 14:21:51 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id mx5-20020a0562142e0500b005dd8b9345desm110761qvb.118.2023.03.30.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:21:51 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v15 2/4] syscall user dispatch: untag selector addresses before access_ok
Date:   Thu, 30 Mar 2023 17:21:22 -0400
Message-Id: <20230330212121.1688-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330212121.1688-1-gregory.price@memverge.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a preparatory patch for enabling checkpoint/restart of tasks
utilizing syscall user dispatch via ptrace.

To support checkpoint/restart, ptrace must be able to set the selector
of the tracee.  The selector is a user pointer that may be subject to
memory tagging extensions on some architectures (namely ARM MTE).

access_ok will clear memory tags for tagged addresses on tasks where
memory tagging is enabled.  However, to allow ptrace to set a task's
selector when tracer and tracee are not both tagged or untagged,
the selector address must be untagged when calling access_ok.

Since access_ok utilizes current to determine whether or not to untag
an address, an untagged tracer will always fail to restore a tagged
address in a tagged tracee.  This patch will resolve this issue.

The result of this is that a tagged tracer may be capable of setting
an invalid address, which will cause the tracee to SIGSEGV on next
syscall.  This is equivalent to the tracee setting a bad selector
address (such as selector=0x1).  This is preferable to the alternative
of creating a task_access_ok variant, and is consistent with other
operations which change tracee pointers via ptrace.

For more information, see:
https://lore.kernel.org/all/ZCWXE04nLZ4pXEtM@arm.com/

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
---
 kernel/entry/syscall_user_dispatch.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b234854..16086226b41c 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -87,7 +87,18 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 		if (offset && offset + len <= offset)
 			return -EINVAL;
 
-		if (selector && !access_ok(selector, sizeof(*selector)))
+		/*
+		 * access_ok will clear memory tags for tagged addresses on tasks where
+		 * memory tagging is enabled.  To enable a tracer to set a tracee's
+		 * selector not in the same tagging state, the selector address must be
+		 * untagged for access_ok, otherwise an untagged tracer will always fail
+		 * to set a tagged tracee's selector.
+		 *
+		 * The result of this is that a tagged tracer may be capable of setting
+		 * an invalid address, and the tracee will SIGSEGV on the next syscall.
+		 * This is equivalent to a task setting a bad selector (selector=0x1).
+		 */
+		if (selector && !access_ok(untagged_addr(selector), sizeof(*selector)))
 			return -EFAULT;
 
 		break;
-- 
2.39.1

