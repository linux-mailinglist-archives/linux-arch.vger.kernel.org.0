Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED90484BD4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiAEAnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiAEAnk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:43:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD15C061761;
        Tue,  4 Jan 2022 16:43:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j6so155029437edw.12;
        Tue, 04 Jan 2022 16:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZsER8dwM6Zj8zfdZ7MJqQNqpLImA5s2mJr5orsE/+Bk=;
        b=ZhvMcWxgJor4nybVVrUbIe5NBi5OKCxqmARkFVb5Rorit+kIiFmb4Y3/Jy9UpfHXEW
         NpEOr01dKcg/4AaUdaAXRgozlZ3/AbywrnV/O4J4XuIfao/vg6FylL0//PiTy+7KC5B+
         o4vfZ/9b8bypNFiysKhKD+Fg+VqvLXwJbU9eYhnpRPCODW2mush8yhAPzcDDereAtjiS
         YUFd70AFAb777UTf3tiZ+fATKqj6NpcwaAuGVqQaYasAdheGMd8tvnB4r5lf5UJbRGMq
         +4UVW+csoEOon7832sAqoYfx/+RTT4uLAbYjjMD1HQQWz63AKFZg+NZAMZaHzpAWUsuF
         kGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZsER8dwM6Zj8zfdZ7MJqQNqpLImA5s2mJr5orsE/+Bk=;
        b=OX9imp/U/5ZUnEB/IkAEdTROAh9Zwtka7wzXD3/qC7C3uKrR/bEqF7q9x10vggj4SF
         dy9v5eqxZGII0rK3PKfmo8zgI+RhdLACHQ8J4nVmATMhe8xodyNzVci/pH8fXriXXthz
         NgHx6Rpg9SFqJctp6l0BmLdW6KLYM3i1WYbwQN1F6BchZtGzVDpSIsKGnL6ipXLPh1Z7
         vo7y65NM8Tidx4vd1kdf3JruNI/DfuNqMXHSIQev+ulzWpCacCgP9alI+KVPMoUZt13Y
         zgI/RIZ3qfQ+MgM/anBdxIFUAmq1Hi3xbqCehFgJkxLmm8Uq51rhgSBi2ikS8knSoPr0
         MXXA==
X-Gm-Message-State: AOAM532U+c6ZHzCdXC+PByXvuBi5dKIaOg7REvwlFa01tHrvgC3Phlej
        rPVmTTNs5wEjqufXlNBi4MI=
X-Google-Smtp-Source: ABdhPJw3I9BUZcOKnkxGmUz3P2/vk0P4+LzIfz/TxlqdZXCA/+6DM99o8TqM6SLPv7NxMJbXPx8sfA==
X-Received: by 2002:a05:6402:b18:: with SMTP id bm24mr49783061edb.324.1641343419119;
        Tue, 04 Jan 2022 16:43:39 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id p7sm15196127edu.84.2022.01.04.16.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:43:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:43:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev,
        ashimida <ashimida@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdTpuNrF2QxRzszb@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <CAKwvOdmCgBKiikP2Ja4PfJmVEnzNPGYe19MNd++a5D-asCBG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmCgBKiikP2Ja4PfJmVEnzNPGYe19MNd++a5D-asCBG2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> > Can this Clang warning be disabled?
> 
> Clang is warning that the attribute will be ignored because of that 
> positioning. If you disable the warning, code will probably stop working 
> as intended.  This warning has at least been helping us make the kernel 
> coding style more consistent.

Yeah, indeed, Clang is fully correct to warn here, and these changes in my 
tree are outright bugs (which bugs Clang found & reported :-).

See the fixes below - by doing it this way the 'spurious link failure' 
problem when a header include is missing should be fixed as well.

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

