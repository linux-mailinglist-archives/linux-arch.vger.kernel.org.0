Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED93A34773A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 12:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhCXL0I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbhCXLZp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 07:25:45 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5959BC0613E0
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 04:25:44 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k132so382080wma.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2021 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I1KbrT5XqAYTtTHNgD870993nANc6M+4kCGSgsFMdj8=;
        b=kv7CiN8WLQeD9YBtQEq/IUrwhwfOlyPRjhC+7uZhS0eOc9J0GCtpI4ekgSvOQQxk/m
         Y//oNUJZoYgphvbAsAlJeIdEwxPfDRXzY1Lcz4BaqzPRW9scBwvqiUE+YcGHVmixcYbX
         Q176uhojSLJ4wQ7K48QCcPkSNXw+j0oCEV2eV1pMGqwpEvlnr5tj9lrs5cT2wKtESGnh
         C4cKTZSuIxUNVnJ3ZhHNKYJOLRjRq3LjkEb/o1YOB3scaqNFigpBiSXIW9Vj90serHEa
         S3I8BPELfEhnKc3jpd6JF+qSwrISOWQ5thyCcb9gM2QNFWwiF8WxtuCosf3VqM35moVm
         yEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I1KbrT5XqAYTtTHNgD870993nANc6M+4kCGSgsFMdj8=;
        b=GCzXcO4i7n70RUY5FlpTE3uGZw7fGMZ146zXkisyPv/CM2nIYZIg4lXm/K2KgEpbDM
         YPUmMXVV/p+/BO9s7SRGCI235WjJJzrOuapOd5ik2Jigg72jL7Rpej2MQd3YilyEkyHr
         D7o5SHiPzokyv2A8/R3qZRYPQ/8FgfJmXesF0GB4A5Zsr6L0xJWTvwNWabBRX71FOSjj
         vvZD2MeR8n9yzTPIrukazNMzxl2sGaL8+D/RQnsdw7KODc6E5LeF1ktmjGfmlPmx4wJc
         HSzZd8zQO5xRfTN4Vo9kLeCCZfp5+5j82/KpE0c94Q9o6Ks3kEPX4utB2j8/hKaBnugU
         PiuQ==
X-Gm-Message-State: AOAM532RBIVO+1aREs9wwdqPBNRVjr+hsbyxxDhj80SauFP3C4ZZN/AI
        HQq2koFvPslHxLDfcimOG1Ew+0L4Rg==
X-Google-Smtp-Source: ABdhPJyvcllZQkcVrgWo840xh+92r48rFYvtuXR+4aUKlIHYNDB1geLImfEttmHlibsGQ+Yp/jLW4hd5qA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:a1c:bc56:: with SMTP id m83mr2462445wmf.174.1616585143013;
 Wed, 24 Mar 2021 04:25:43 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:25:02 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-11-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 10/11] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sync tool's uapi to pick up the changes adding inherit_thread,
remove_on_exec, and sigtrap fields to perf_event_attr.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Added to series.
---
 tools/include/uapi/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ad15e40d7f5d..3a4dbb1688f0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -389,7 +389,10 @@ struct perf_event_attr {
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
-				__reserved_1   : 29;
+				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
+				remove_on_exec :  1, /* event is removed from task on exec */
+				sigtrap        :  1, /* send synchronous SIGTRAP on event */
+				__reserved_1   : 26;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
-- 
2.31.0.291.g576ba9dcdaf-goog

