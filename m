Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE953484314
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 15:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiADOK4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 09:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiADOKz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 09:10:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA45C061761;
        Tue,  4 Jan 2022 06:10:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j21so148867155edt.9;
        Tue, 04 Jan 2022 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8if7WEaBEhVlQbuJ+SPa04Tu8qGjQYQiEyoCGpJscs=;
        b=LlMTUeV/9GIKARbHsb3fpZpO0RUVzh7cOSPcOjKUP6hxa24CW+QglTS5ELhP4Ory3F
         rMs47ZKsA//4iiLpvwYoNxDDKW3cVFQ2ur3BDpGDoZp5IeJIrs+DSmNkgMEG80YeInBn
         Mwkrnv13plWBsLFv5CF9LlC7Lpc+KgrNq2cU5+Tg/9G5pTPfkWHoqwWP+aUgaWhb9+I8
         UVcFc3p386b+xnAxCMtzmXGWBmiaSge/t7tj7EvXQUhIyqt5vpX39HeYgO6SUkFT7LFr
         J/0H2jVLu7/6wz1Fo7h2tmP6zlrWQWxieVohfQsidgYVajc7aRnowFstHbeyQL7RW9UP
         AbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a8if7WEaBEhVlQbuJ+SPa04Tu8qGjQYQiEyoCGpJscs=;
        b=ZacVRp8UJOIcc4JXJPubYN2IhBv0afZrG3gaNiULmeiwHPqARyGU2AJAKmkl/Q01Iv
         jmNIgEoe13bbZIwa6gz0IiYSM4PIFdR73XKniK8flLPzpbHNE0UdSTXqF52FUV18qh2b
         RoRzFtvXP6GCOv/Ve2nMFSK7YevSFdeCqY4h4OFmNUDqUx/QI5DG6Iih5g79Pl5hM74D
         /CGZtPzGT9kmPdamChB6RCf6QvutbNXXd6njlN+eG0MWjQ00OuvQJK9RCdRXzoLgNMpb
         XWo9P9XOZ7OY3cdxQKYoJ3PcYn2pir+reepfIdDKnDE/KWACHxG1pFVZMUioYF4iX1Sn
         S2Xg==
X-Gm-Message-State: AOAM533Bsate3HKVN3K4Y9TbRdwKmk5ERoz2WenPTuQE29t6/e+Uo0/0
        TcYepYAGU35vWURWazaAqbXYHhjDvq4=
X-Google-Smtp-Source: ABdhPJw/QS1Tmzi9VOiAvjVnenf6NETBIc1gct9VYJv38pQPfzEwAIuhrsH2fjMJdY2vR9uY2qZLLQ==
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr38346721ejy.229.1641305454089;
        Tue, 04 Jan 2022 06:10:54 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id u1sm14770112edp.19.2022.01.04.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:10:53 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 15:10:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] per_task: Remove the PER_TASK_BYTES hard-coded constant
Message-ID: <YdRVawyDbHvI01uV@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdLaMvaM9vq4W6f1@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> There's one thing ugly about it, the fixed PER_TASK_BYTES limit, I plan 
> to make ->per_task_array[] the last field of task_struct, i.e. change it 
> to:
> 
>         u8                              per_task_area[];
> 
> This actually became possible through the fixing of the x86 FPU code in the 
> following fast-headers commit:
> 
>    4ae0f28bc1c8 headers/deps: x86/fpu: Make task_struct::thread constant size

So I implemented this approach - the patch below removes the PER_TASK_BYTES 
hard-coded limit.

( Didn't make it variable size via per_task_area[] though - we *do* know 
  its size after all at build time already, and known-size structures are 
  better in general than tail-variable-array solutions:

   - They work better with static checkers,
   - and we actually want the offsets into thread_info to be small on embedded platforms

  etc. )

Thanks,

	Ingo

============================>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 4 Jan 2022 13:48:05 +0100
Subject: [PATCH] per_task: Remove the PER_TASK_BYTES hard-coded constant

- Also remove the unnecessary <linux/sched/per_task_types.h> header.

Not-Signed-off-by-yet: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/per_task.h       | 3 ++-
 include/linux/sched/per_task_types.h | 7 -------
 kernel/sched/core.c                  | 4 ++++
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/per_task.h b/include/linux/sched/per_task.h
index e20837e82681..a10538713a26 100644
--- a/include/linux/sched/per_task.h
+++ b/include/linux/sched/per_task.h
@@ -37,7 +37,6 @@
  * A build-time check ensures that we haven't run out of available space.
  */
 
-#include <linux/sched/per_task_types.h>
 #include <linux/compiler.h>
 
 #ifndef __PER_TASK_GEN
@@ -61,4 +60,6 @@
 
 #define per_task_container_of(var, name)	container_of((void *)(var) - per_task_offset(name), struct task_struct, per_task_area[0])
 
+#define PER_TASK_BYTES				(per_task_offset(_end))
+
 #endif /* _LINUX_SCHED_PER_TASK_H */
diff --git a/include/linux/sched/per_task_types.h b/include/linux/sched/per_task_types.h
deleted file mode 100644
index 8af8c10f8dae..000000000000
--- a/include/linux/sched/per_task_types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_SCHED_PER_TASK_TYPES_H
-#define _LINUX_SCHED_PER_TASK_TYPES_H
-
-#define PER_TASK_BYTES 8192
-
-#endif /* _LINUX_SCHED_PER_TASK_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bc38b19f6398..fdb5b99ae6e0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -89,6 +89,8 @@
 #include "../../fs/io-wq.h"
 #include "../smpboot.h"
 
+#include "../../../kernel/sched/per_task_area_struct.h"
+
 DEFINE_PER_TASK(unsigned int,				flags);
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
@@ -9481,6 +9483,8 @@ void __init per_task_init(void)
 {
 	unsigned long per_task_bytes = per_task_offset(_end);
 
+	printk("per_task: sizeof(struct task_struct):          %ld bytes\n", sizeof(struct task_struct));
+	printk("per_task: sizeof(struct task_struct_per_task): %ld bytes\n", sizeof(struct task_struct_per_task));
 	printk("per_task: Using %ld per_task bytes, %ld bytes available\n", per_task_bytes, (long)PER_TASK_BYTES);
 
 	BUG_ON(per_task_offset(_end) > PER_TASK_BYTES);
