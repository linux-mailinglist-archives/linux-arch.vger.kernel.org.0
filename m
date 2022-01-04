Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E34484070
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 12:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiADLCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 06:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiADLCi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 06:02:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D39C061761;
        Tue,  4 Jan 2022 03:02:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so146981035edb.5;
        Tue, 04 Jan 2022 03:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rRDBA6dGfnGP5OAkgHem6ju0LPPyWJk+kpQ57nDCkIM=;
        b=BZKJpmtqW8JYm0lVrL8ScDrDKgMpiIg/aCQiAR1xe0mm/rAdkNovCx7RWmBeRYAjJB
         eh3CguKWPaRsFodhRl6uI6ChL1cDUwd6WBb3vTWQhFzis8J4cDN/SfIuThhXCT2WsgeB
         655rbG1pSX86HudA4oXdFsgmM4buBJzNN+JAa9qG0roEVTGA2EMrgIUDJwEwCIljqQq6
         OuIlYANbu7FKUcDKVurXA68P7X71B07X6s12Xjkb7JERos6wBwLt9QLo7GfZ0acAcKBP
         wGbmJlGb3WstFW+BPIhPVksynSyKweIE+bG0Ib3bW6vt2z9b6uk3PjvLvj9iFIqUBACS
         lZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=rRDBA6dGfnGP5OAkgHem6ju0LPPyWJk+kpQ57nDCkIM=;
        b=Yk1gyx8tTNfnegnZPOv4L55KpzTJTF9ufJelDxh9femZdIllbBhuz/WHsUtLfimz4O
         LWasCEfxWWH6ZhRuZjoMr1kmQ8R7qz4GEdb4d9gP8Run84livynOb4NW3sblraAsZpOY
         +ah8uMF8dmMeULBgk19sYdyDWH2ufTofMqWZvaj0Kp82HrZqjstuXUSMyPH9xUTtAm8W
         cKvQ50JCCVBsOHuwBvpbchC9Ctl/Orby6Tg0sejDxMVvml1B4w5Q5XSxp/hFl8AnSb3P
         Tb1VXHDNCZxXZbRvNhy159APY9EH9GH16rh+VuBXykWMicscYWmCJM7QauOJfrT0jM1V
         D5Bg==
X-Gm-Message-State: AOAM531kF26IVPjAksu3bILabHljL9sN0vY6F3tKv0l7gzD33a4L5/cL
        v0bjMPNfJi3T5uvA/78Tp9g=
X-Google-Smtp-Source: ABdhPJykDklM7AOsIrxJTs6xjJJgzSwnifoTQQG2u9q2STn1UF9zNoe6v4jxr90Y650YtXI2n5pQVQ==
X-Received: by 2002:a05:6402:5190:: with SMTP id q16mr48587736edd.332.1641294156592;
        Tue, 04 Jan 2022 03:02:36 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id sb7sm7624638ejc.203.2022.01.04.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:02:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 12:02:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: [PATCH] headers/deps: dcache: Move the ____cacheline_aligned
 attribute to the head of the definition
Message-ID: <YdQpSigW9X224obC@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdQlwnDs2N9a5Reh@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > 1. Position of certain attributes
> > 
> > In some commits, you move the cacheline_aligned attributes from after
> > the closing brace on structures to before the struct keyword, which
> > causes clang to warn (and error with CONFIG_WERROR):
> > 
> > In file included from arch/arm64/kernel/asm-offsets.c:9:
> > In file included from arch/arm64/kernel/../../../kernel/sched/per_task_area_struct.h:33:
> > In file included from ./include/linux/perf_event_api.h:17:
> > In file included from ./include/linux/perf_event_types.h:41:
> > In file included from ./include/linux/ftrace.h:18:
> > In file included from ./arch/arm64/include/asm/ftrace.h:53:
> > In file included from ./include/linux/compat.h:11:
> > ./include/linux/fs_types.h:997:1: error: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Werror,-Wignored-attributes]
> > ____cacheline_aligned
> > ^
> > ./include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
> > #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
> 
> Yeah, so this is a *really* stupid warning from Clang.
> 
> Putting the attribute after 'struct' risks the hard to track down bugs when 
> a <linux/cache.h> inclusion is missing, which scenario I pointed out in 
> this commit:
> 
>     headers/deps: dcache: Move the ____cacheline_aligned attribute to the head of the definition
>     
>     When changing <linux/dcache.h> I removed the <linux/spinlock_api.h> header,
>     which caused a couple of hundred of mysterious, somewhat obscure link time errors:
>     
>       ld: net/sctp/tsnmap.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>       ld: net/sctp/tsnmap.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>       ld: net/sctp/debug.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>       ld: net/sctp/debug.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>     
>     After a bit of head-scratching, what happened is that 'struct dentry_operations'
>     has the ____cacheline_aligned attribute at the tail of the type definition -
>     which turned into a local variable definition when <linux/cache.h> was not
>     included - which <linux/spinlock_api.h> includes into <linux/dcache.h> indirectly.
>     
>     There were no compile time errors, only link time errors.
>     
>     Move the attribute to the head of the definition, in which case
>     a missing <linux/cache.h> inclusion creates an immediate build failure:
>     
>       In file included from ./include/linux/fs.h:9,
>                        from ./include/linux/fsverity.h:14,
>                        from fs/verity/fsverity_private.h:18,
>                        from fs/verity/read_metadata.c:8:
>       ./include/linux/dcache.h:132:22: error: expected ‘;’ before ‘struct’
>         132 | ____cacheline_aligned
>             |                      ^
>             |                      ;
>         133 | struct dentry_operations {
>             | ~~~~~~
>     
>     No change in functionality.
>     
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Can this Clang warning be disabled?

Ok, broke out this issue into its own thread, in form of a patch submission 
- so that others don't have to wade through a massive tree to find a single 
commit ...

I'll of course drop these (non-essential) cleanups if the upstream policy 
is to follow Clang's quirk/convention, but I find the forced attribute 
tail-position a sad misfeature, due to the reasons outlined in this patch: 
a straightforward build failure in case an attribute is not defined is far 
preferable to spurious creation of variables with link-time warnings that 
don't actually highlight the exact nature of the bug ...

Thanks,

	Ingo

=====================>
Date: Sun, 20 Jun 2021 09:41:45 +0200
Subject: [PATCH] headers/deps: dcache: Move the ____cacheline_aligned attribute to the head of the definition

When changing <linux/dcache.h> I removed the <linux/spinlock_api.h> header,
which caused a couple of hundred of mysterious, somewhat obscure link time errors:

  ld: net/sctp/tsnmap.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
  ld: net/sctp/tsnmap.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
  ld: net/sctp/debug.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
  ld: net/sctp/debug.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here

After a bit of head-scratching, what happened is that 'struct dentry_operations'
has the ____cacheline_aligned attribute at the tail of the type definition -
which turned into a local variable definition when <linux/cache.h> was not
included - which <linux/spinlock_api.h> includes into <linux/dcache.h> indirectly.

There were no compile time errors, only link time errors.

Move the attribute to the head of the definition, in which case
a missing <linux/cache.h> inclusion creates an immediate build failure:

  In file included from ./include/linux/fs.h:9,
                   from ./include/linux/fsverity.h:14,
                   from fs/verity/fsverity_private.h:18,
                   from fs/verity/read_metadata.c:8:
  ./include/linux/dcache.h:132:22: error: expected ‘;’ before ‘struct’
    132 | ____cacheline_aligned
        |                      ^
        |                      ;
    133 | struct dentry_operations {
        | ~~~~~~

No change in functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/dcache.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 41062093ec9b..0482c3d6f1ce 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -129,6 +129,7 @@ enum dentry_d_lock_class
 	DENTRY_D_LOCK_NESTED
 };
 
+____cacheline_aligned
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, unsigned int);
 	int (*d_weak_revalidate)(struct dentry *, unsigned int);
@@ -144,7 +145,7 @@ struct dentry_operations {
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *);
-} ____cacheline_aligned;
+};
 
 /*
  * Locking rules for dentry_operations callbacks are to be found in
