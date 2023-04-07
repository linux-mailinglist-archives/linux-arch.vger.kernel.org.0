Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D666DB17A
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDGRTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDGRS4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:18:56 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C646BF;
        Fri,  7 Apr 2023 10:18:49 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id r17-20020a05683002f100b006a131458abfso19775320ote.2;
        Fri, 07 Apr 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680887928; x=1683479928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rMtfFsP4cn7PRc7thWyRT6kVwkZQ9lV5jy6inZiGMQ=;
        b=oKXezr1ZuTmKBFv3swmWuVW5y40pO2HvL0gyj+yk7DSdGd2t+VnK5VF/JG/e04hRuO
         KzYDSpFGPsUMootKeCu/3+xLy1tvnhlwcRfEjUT3bnpLvtX4I67AkEyFnqF2vR/4nzKO
         BNQHboMDs9wwSM4Ok7gojHynr1YBO4KJ3jYiD46owcDQBmuIN/k5bP1JzOReZa7cNSgy
         p9LMq5rE6jk95BWIMhBAUcu8qgx7PPd1GmUrZo7KFhALaElKvMRxKm+G3ZLV4Sp/193w
         ApQsObHY3jBLeRfmjuJLeL6l+EH8xLDAZiRQXSEIBZqI0wNYvx9Ywg3poiLXE5TEhmU9
         3PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887928; x=1683479928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rMtfFsP4cn7PRc7thWyRT6kVwkZQ9lV5jy6inZiGMQ=;
        b=NuA+3Hv9K6mV+7mKoYhQT5Qj3hYhKgeXjhr1nJWwAt0tMWA87/VnwGKIHBiXnSsO28
         fzo5oar6GKp4MH52A2VV5MBgXDkj82eiSvFV7LYLq7qbZ2qk7oy/FSvVLQMVSfaH+7zH
         L3eeX/nEJ4jtNhtYrwBp6TM5FqzmP61b2QDBxwF+1u2ur1+uUUj1W5+jaX/8xlp6BYxg
         pPIlIyZP+N88ZhUhC3FpHgVTcXEgM0glGsaXkRYNLGeUMm28mmJBqLJFyZJwaThXC+8P
         QLemVJawyP1DLK7N/IsJKZg2nDgqUdGvDCMzCX39IKfJlFFdNsbkx+kb7pzbF50O7nOs
         6Hzg==
X-Gm-Message-State: AAQBX9cnAVFH5/fukWQ4K02R/+4Ok+ylsF9Q7EmVYaDGzWI7xL1O5Wgg
        UoKNd+gO7n/KTARQdFAU4w2pRi4r9d9HVIs=
X-Google-Smtp-Source: AKy350YSP92/WnkPS9LaeaoxkBx6hyts4ztLayrTjNIuPBBCgITCfGDZsxE0GVLxlWRLrHO/nXHvkA==
X-Received: by 2002:a9d:77c3:0:b0:6a3:8c3d:80e7 with SMTP id w3-20020a9d77c3000000b006a38c3d80e7mr1313926otl.6.1680887928559;
        Fri, 07 Apr 2023 10:18:48 -0700 (PDT)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d7349000000b006a2ddc13c46sm1816730otk.78.2023.04.07.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:18:48 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v16 2/4] syscall user dispatch: untag selector addresses before access_ok
Date:   Fri,  7 Apr 2023 13:18:32 -0400
Message-Id: <20230407171834.3558-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230407171834.3558-1-gregory.price@memverge.com>
References: <20230407171834.3558-1-gregory.price@memverge.com>
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
Acked-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 kernel/entry/syscall_user_dispatch.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b234854..424f24350f8b 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -87,7 +87,14 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 		if (offset && offset + len <= offset)
 			return -EINVAL;
 
-		if (selector && !access_ok(selector, sizeof(*selector)))
+		/*
+		 * access_ok will clear memory tags for tagged addresses on tasks where
+		 * memory tagging is enabled.  To enable a tracer to set a tracee's
+		 * selector not in the same tagging state, the selector address must be
+		 * untagged for access_ok, otherwise an untagged tracer will always fail
+		 * to set a tagged tracee's selector.
+		 */
+		if (selector && !access_ok(untagged_addr(selector), sizeof(*selector)))
 			return -EFAULT;
 
 		break;
-- 
2.39.1

