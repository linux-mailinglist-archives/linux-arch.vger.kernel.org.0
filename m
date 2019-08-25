Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621F09C39A
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHYNYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:24:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41096 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfHYNYU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:24:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so8749156pgg.8;
        Sun, 25 Aug 2019 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBMOYzu8UIu95lP7jXMjUUnVweWqbQKsr6KxrGRBejY=;
        b=sHDg4LdFrZLoGW/ZYspHbC6si5YKDLezCKJyEjDpI/sdIE9awBNr91t8Vhfot9Jkv/
         eY42rNW+4SWG7yComJVhrM6XBby3bfRflTU3gZKNvI3LyaamRH5OjwxcYHOm09dbfmNI
         t1ix14MoqSf120rnu5QbAzkF79vwWQKxhqXPBnXMc0lOXCWJtyvXsI0kTP/MMPNK1JUo
         cLZ9SKjeQoOaWjCl1i2knVrN+R/+widRkHLHIBuvg3Dms/8DumzuWQnRndvA3vlc2ra+
         VjSjvDvL9QH/d9g3AYDaj60J1P/SBbs+EHTE1BskRsNLdUgHaE7p93H+uAyK0UdkBANy
         EYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBMOYzu8UIu95lP7jXMjUUnVweWqbQKsr6KxrGRBejY=;
        b=R1jQtq/T04FKoBPCSK/UIXlfjzrFQk4oncRsuJyYQ1F6zDiI/SmXywlH0NszpzHoIF
         n2ihC6DP7ZzHx4/15p1fz+J0J+FmJJ5N7v/IzTmbtwhzzPtBcWTK1fkI9HilGNoG6hoQ
         YOsDAlyRE5EXjU2xmUez0I5JM9TPipTDqZwnTyG63oDLXGMZLr6y5xS6+4dXRiwNuZUW
         /RewUyO0yBEVt0M6rp311zoFD6pvFbXYSyLC92a6gxM1xbQF2skZyfUb+u2vD/RRJ1j3
         hWSKhGnzAJMI6XqgWfjSyGf/9+qP3FgTD6Y2P1lZL4rAxatLbGoh53MG31/0bnwzbOVn
         1WKw==
X-Gm-Message-State: APjAAAUTqs5CBYwdnSJeWrRvhO0u5sUW3GOO6J4AJscII3GEgrSIGGxZ
        B6QkrvShCSOuKO0UIN+J/cU=
X-Google-Smtp-Source: APXvYqxpYPr/pKADhj70YxFWPqP5/wYXfBY0LpRYX2aLllbJNw9nnJFrJ+KG+/AqWzkmIcaviruEwA==
X-Received: by 2002:aa7:93aa:: with SMTP id x10mr15472120pff.83.1566739459240;
        Sun, 25 Aug 2019 06:24:19 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:24:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 04/11] ftrace/hash: add private data field
Date:   Sun, 25 Aug 2019 21:23:23 +0800
Message-Id: <20190825132330.5015-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We will reuse ftrace_hash to lookup function prototype information. So
we need an additional field to bind ftrace_func_entry to prototype
information.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/ftrace.c | 17 +++++++----------
 kernel/trace/trace.h  |  6 ++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eca34503f178..a314f0768b2c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1017,11 +1017,6 @@ static bool update_all_ops;
 # error Dynamic ftrace depends on MCOUNT_RECORD
 #endif
 
-struct ftrace_func_entry {
-	struct hlist_node hlist;
-	unsigned long ip;
-};
-
 struct ftrace_func_probe {
 	struct ftrace_probe_ops	*probe_ops;
 	struct ftrace_ops	ops;
@@ -1169,7 +1164,8 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip,
+			  void *priv)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1178,6 +1174,7 @@ static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 		return -ENOMEM;
 
 	entry->ip = ip;
+	entry->priv = priv;
 	__add_hash_entry(hash, entry);
 
 	return 0;
@@ -1346,7 +1343,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			ret = add_hash_entry(new_hash, entry->ip);
+			ret = add_hash_entry(new_hash, entry->ip, NULL);
 			if (ret < 0)
 				goto free_hash;
 		}
@@ -3694,7 +3691,7 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
 		if (entry)
 			return 0;
 
-		ret = add_hash_entry(hash, rec->ip);
+		ret = add_hash_entry(hash, rec->ip, NULL);
 	}
 	return ret;
 }
@@ -4700,7 +4697,7 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 		return 0;
 	}
 
-	return add_hash_entry(hash, ip);
+	return add_hash_entry(hash, ip, NULL);
 }
 
 static int
@@ -5380,7 +5377,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 				if (entry)
 					continue;
-				if (add_hash_entry(hash, rec->ip) < 0)
+				if (add_hash_entry(hash, rec->ip, NULL) < 0)
 					goto out;
 			} else {
 				if (entry) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..ad619c73a505 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -882,6 +882,12 @@ struct ftrace_hash {
 	struct rcu_head		rcu;
 };
 
+struct ftrace_func_entry {
+	struct hlist_node hlist;
+	unsigned long ip;
+	void *priv;
+};
+
 struct ftrace_func_entry *
 ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip);
 
-- 
2.20.1

