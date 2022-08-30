Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC65A6F7F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiH3Vtf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiH3Vt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:49:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4168F94A
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:49:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dbfb6d2a3so188936187b3.11
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=b8cpW+nrR3APd+B9XZ294x5uN/r70qZMashrRw3GaA8=;
        b=B8JrbzRleZqubdBWO9KwQObWYBUFN1DEZsbcRMc0ufm/mVUktKeZg8X1kQOqUZzy93
         ncNLrZU8nPu7KazqAMAyKJcikXtJLfl/reW5WBaXn80mOydYU5Xs8aKPQyLo7ErwCgSR
         6vTq/fkGb/bg91DRTJvbM/ZhewoDhk6Fzi5TAqWRXDZK39lE+mcUdSuOiAqs+pSJsWjQ
         9uZPxBCGuZMakiTU63KXQhu+wIJ9wLTXQN/A1wLZlo6tR7q0gp+RObUZBUjYJR6H/wFq
         J6OY9ufTA18je5eH0c2mEH8FL4dZmNwHh7WEfnbxz8VCQJOnaA1LbLkW+QDP3I4yxqae
         dF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=b8cpW+nrR3APd+B9XZ294x5uN/r70qZMashrRw3GaA8=;
        b=Y0su56xCwnMAY3tGA2lYZdIbcbK89lXbLvD+IYgne9iZFPbWRKb5uhR9QMSQQHPiTA
         8aA3luBaLNRXQq4xYTJnpg6JC924SSv6vF5fiFI1BA8FEzhgmaO3Jc7myzTdVV3PnFkB
         VCoBLUwOhLctDTYVQHtSncJMmnE4R7rXA7clmYwqvzv6WfG71UbuKVl2YPuj/5up71Mu
         b1r2/LajsergND/PHkFLzz3skb4CjvXdiyyGVYbEGhyaLXxm05Uw8Pv4B9YIpDDnxxDX
         ssxSj/UQrVZprZh1MWvuYThjkU6LUUzU3nXawbRjcwdTiVlqErsCDc63DtJ7wltY2Fzh
         RXwA==
X-Gm-Message-State: ACgBeo1Ek+TR627IGs8Jh7+mGnv8AyTgO4AZrcnM0rW40AA95kfli5T7
        6XtgZj6qs3eVLU9rpoJxtgDjvlwpP6g=
X-Google-Smtp-Source: AA6agR57tRpK3lCbg8ALQyLqVk3+SD8j/eJQxhkloYdEQAGMf1mIZU8UNti5rfc/2ao5N+5wkH06z2emEi0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a0d:e650:0:b0:341:85d:f480 with SMTP id
 p77-20020a0de650000000b00341085df480mr9713169ywe.161.1661896166926; Tue, 30
 Aug 2022 14:49:26 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:48:50 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-2-surenb@google.com>
Subject: [RFC PATCH 01/30] kernel/module: move find_kallsyms_symbol_value declaration
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        iommu@lists.linux.dev, kasan-dev@googlegroups.com,
        io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow find_kallsyms_symbol_value to be called by code outside of
kernel/module. It will be used for code tagging module support.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/module.h   | 1 +
 kernel/module/internal.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 518296ea7f73..563d38ad84ed 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -605,6 +605,7 @@ struct module *find_module(const char *name);
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			char *name, char *module_name, int *exported);
 
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
 /* Look for this name: can be of form module:name. */
 unsigned long module_kallsyms_lookup_name(const char *name);
 
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 680d980a4fb2..f1b6c477bd93 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -246,7 +246,6 @@ static inline void kmemleak_load_module(const struct module *mod,
 void init_build_id(struct module *mod, const struct load_info *info);
 void layout_symtab(struct module *mod, struct load_info *info);
 void add_kallsyms(struct module *mod, const struct load_info *info);
-unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
 
 static inline bool sect_empty(const Elf_Shdr *sect)
 {
-- 
2.37.2.672.g94769d06f0-goog

