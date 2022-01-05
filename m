Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E56484BAB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiAEA0h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAEA0h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:26:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD86C061761;
        Tue,  4 Jan 2022 16:26:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z9so85071113edm.10;
        Tue, 04 Jan 2022 16:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9qf9XO8NxG0l0bIiDjeze9dZjS/TBrojHszc0FCGLoo=;
        b=ZOh7dbhGAkLF/DC+vGwz/AcyvHD68rMTsoe/QgGGxh3N/xi0qyytI3vM/M9wXWN2yz
         5CgXM/absvvVtTlJEgHg3CKY2czD/d/Yyi60JDA92D06BSiFHiYH4pTOpsX1R7e9cE0N
         qlW2EFSbarTHt0plLA4edzp0eZHzJwgT2aSYprSeHNcE5PRLZz9w2oKTp6a6xkHuupmT
         v7OT/yVKAPzM5Dzed+S6SNml4CpttMNtVUIUMv4f8h8mLC9zeH9ONQ3c18LjRndDWwyd
         3cJr/8ukGESXmHdh/R7+CzrUlLdQq+yy1cUcbOTYXJF2KMKHYediTXTYgfb5ET66GDZR
         cIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9qf9XO8NxG0l0bIiDjeze9dZjS/TBrojHszc0FCGLoo=;
        b=2h/KpTrVnDJmBSq69J6AqgSO6sPQiflvqvbZ8Q3bxBgUU5E1NexZ40iKhW9K71MOTb
         7KoZOUl/KrYkXmyb+sJPL7TvxDdmPQ5CwEBTMXwEpIO7nKPBWMzZny/UfwgSlhj5kt+k
         ATfhko/70DCaNfe7xrxqlpSkB9JpQZUOft8hqIbWTQwk51iMjpTmPGPwqBVgo2Bw7jVR
         m4E2/RRpzTFoyev2amWw78WLhXkoSP7UyXRwxxlNduFy31dz22PJVxP0jDF8LvKGyghP
         BOwqg7k5SbyYFp/VtT1KmzwqtijWYZMNCGkWB+L+CDSVHUR92bbzAQUKwmzak/QYKINw
         yPTw==
X-Gm-Message-State: AOAM533frn+fVWYM+Wb312lFGDvxzspfFaOJXbil7cJUYxLHdp1aOtfu
        4NoFw4EtvcYrQT9DOqHwkIc=
X-Google-Smtp-Source: ABdhPJyN3XcWdnT9FolZZDyOc5hXd550GJzQEd2qLyVe4iakA0ZZvKSB9lRBXnrGv/Op6p030ehFng==
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr40380177ejc.118.1641342395159;
        Tue, 04 Jan 2022 16:26:35 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id he13sm11767980ejc.221.2022.01.04.16.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:26:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:26:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev
Subject: [PATCH] headers/deps: Attribute placement fixes for Clang & GCC
Message-ID: <YdTluAiCo1DIaItf@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdQpSigW9X224obC@gmail.com>
 <YdSJH7empIUq9vbE@archlinux-ax161>
 <YdTkUBSLCQv7++FN@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdTkUBSLCQv7++FN@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Ugh - so my changes there are outright buggy.
> 
> I'm reverting all those attribute position changes as we speak ...
> 
> I'm actually happy about this in a way, as it settles the issue nicely. 
> :-)

And, by the way - by putting the attribute after the 'struct' keyword we 
get the best of the two worlds: accidentally non-defined attribute 
shortcuts will still result in a build error.

Below is the fix - should be identical to yours (which was whitespace 
mangled).

I'll backmerge these fixes to the originating commits & push out -v2 later 
today.

Thanks,

	Ingo
---
 include/linux/dcache.h        | 3 +--
 include/linux/fs_types.h      | 3 +--
 include/linux/netdevice_api.h | 2 +-
 include/net/xdp_types.h       | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 520daf638d06..da7e77a7cede 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -127,8 +127,7 @@ enum dentry_d_lock_class
 	DENTRY_D_LOCK_NESTED
 };
 
-____cacheline_aligned
-struct dentry_operations {
+struct ____cacheline_aligned dentry_operations {
 	int (*d_revalidate)(struct dentry *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
 	int (*d_hash)(const struct dentry *, struct qstr *);
diff --git a/include/linux/fs_types.h b/include/linux/fs_types.h
index b53aadafab1b..e2e1c0827183 100644
--- a/include/linux/fs_types.h
+++ b/include/linux/fs_types.h
@@ -994,8 +994,7 @@ struct file_operations {
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 } __randomize_layout;
 
-____cacheline_aligned
-struct inode_operations {
+struct ____cacheline_aligned inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct user_namespace *, struct inode *, int);
diff --git a/include/linux/netdevice_api.h b/include/linux/netdevice_api.h
index 4a8d7688e148..0e5e08dcbb2a 100644
--- a/include/linux/netdevice_api.h
+++ b/include/linux/netdevice_api.h
@@ -49,7 +49,7 @@
 #endif
 
 /* This structure contains an instance of an RX queue. */
-____cacheline_aligned_in_smp struct netdev_rx_queue {
+struct ____cacheline_aligned_in_smp netdev_rx_queue {
 	struct xdp_rxq_info		xdp_rxq;
 #ifdef CONFIG_RPS
 	struct rps_map __rcu		*rps_map;
diff --git a/include/net/xdp_types.h b/include/net/xdp_types.h
index 442028626b35..accc12372bca 100644
--- a/include/net/xdp_types.h
+++ b/include/net/xdp_types.h
@@ -56,7 +56,7 @@ struct xdp_mem_info {
 struct page_pool;
 
 /* perf critical, avoid false-sharing */
-____cacheline_aligned struct xdp_rxq_info {
+struct ____cacheline_aligned xdp_rxq_info {
 	struct net_device *dev;
 	u32 queue_index;
 	u32 reg_state;

