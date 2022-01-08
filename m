Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389BC488321
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 12:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiAHLIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 06:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiAHLIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 06:08:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D0C061574;
        Sat,  8 Jan 2022 03:08:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so16201674wra.6;
        Sat, 08 Jan 2022 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QEd7jShQk1ml/OyAi/kpMudTLo3rO1TWVpy7f9K8afc=;
        b=bMgpN08rni6AurnSOUKC9hTpgCbtphQymgTmu+WqvnMnSiD88yJYICu51fRcP6Q5LU
         ZeLmWdmsQcj71iv//LrobynxxsVgN88HwmnvHu9ZuK744sikFEKVvoCpGe/gESYJflAg
         3kZK/W9LumTPVAgLJ9xK40y4MoYEZuepKrzS9SYbfuwk+JKIY8LeoRPDiuIdD6p7y4i/
         MFnsXgM9McX3pHsHZ0TcRLdQOuSD8GYoq+1zsVGNifB7vkpvKdMHIPApQ5MkGuiNnh6v
         L+9lOoTJi4+15cvANwgqCloJQPRUwY5iE3oq3tBfdZmKZN/O5iYZ1EvXWtEpX7bzQ3A7
         3IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QEd7jShQk1ml/OyAi/kpMudTLo3rO1TWVpy7f9K8afc=;
        b=HXlhIc7jiozBk6DWJsr+ZKCywKYvEv3UZn32CrI4tKJ0WRx4dsaaCDij6r2VWzrbKE
         B3wfSoQ/rGI16vdDB3NOt59oK+yizsvH/QEHe+ZqNSYVofBXhWpbGYrYwmHLIKq0RWtb
         jgkLk1aTweWzvG6wXywotHJAQUS2Pl7+rfBmBiOv33nxq8yuVyENHX/KXdgiLPzjK64F
         xI34gOAL7Ocg8kfrX1tShbgVURmNPzvutXv3ku3/1gcaLrX0zWmEX0ng8rPuqAiPcO5V
         JslPS5Gky14HPc3K4H4ig5JFA7g1CT7VuCcnECRsxZr8mi5Pqp39tLia1hInPzL2X6Ly
         u8+A==
X-Gm-Message-State: AOAM530Xew8H9Lxg2xtT43A9RTipWxkrlfkTjkp4sMz9i4UrtjpZ4iQH
        3Tk5jCX+at/LutKsFtEbtNs=
X-Google-Smtp-Source: ABdhPJwnsz6GcODYiRzSMmaPUkZdoCsUYOGKtkSZsehdoKS7bUE4455GcXP3luYqUcXtqbLpkH0DPA==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr13050516wrw.154.1641640107930;
        Sat, 08 Jan 2022 03:08:27 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id m6sm1535455wrx.36.2022.01.08.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 03:08:27 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 12:08:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
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
Subject: [PATCH] FIX: headers/deps: uapi/headers: Create usr/include/uapi
 symbolic link
Message-ID: <YdlwqFQCJpYiDfRR@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
 <YdTvXkKFzA0pOjFf@gmail.com>
 <YdYQu9YxNw0CxJRn@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdYQu9YxNw0CxJRn@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> 2. Build failures with CONFIG_UAPI_HEADER_TEST=y and O=...
> 
> This was originally reproduced with allmodconfig but this is a simpler
> reproducer I think.
> 
> $ make -skj"$(nproc)" ARCH=x86_64 O=.build/x86_64 defconfig
> 
> $ scripts/config --file .build/x86_64/.config -e HEADERS_INSTALL -e UAPI_HEADER_TEST
> 
> $ make -skj"$(nproc)" ARCH=x86_64 O=.build/x86_64 olddefconfig usr/

The simplified & scripted reproducer is very useful, thanks a ton!

> In file included from <command-line>:
> ./usr/include/linux/rds.h:38:10: fatal error: uapi/linux/sockios.h: No such file or directory
>    38 | #include <uapi/linux/sockios.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[4]: *** [/home/nathan/cbl/src/linux-fast-headers/usr/include/Makefile:106: usr/include/linux/rds.hdrtest] Error 1
> In file included from ./usr/include/linux/qrtr.h:5,
>                  from <command-line>:
> ./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
>     5 | #include <uapi/linux/socket_types.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from ./usr/include/linux/in.h:24,
>                  from ./usr/include/linux/nfs_mount.h:12,
>                  from <command-line>:
> ./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
>     5 | #include <uapi/linux/socket_types.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[4]: *** [/home/nathan/cbl/src/linux-fast-headers/usr/include/Makefile:106: usr/include/linux/qrtr.hdrtest] Error 1
> make[4]: *** [/home/nathan/cbl/src/linux-fast-headers/usr/include/Makefile:106: usr/include/linux/nfs_mount.hdrtest] Error 1
> ...
> 
> I don't see this when just building in the tree. I am guessing that
> commit f989e243f1f4 ("headers/deps: uapi/headers: Create
> usr/include/uapi symbolic link") needs to account for this?

Yeah. Here's my second attempt that creates the symlink as the 
header-install make process, as it should - also pushed out into 
sched/headers.

(My Makefile-fu isn't overly powerful though, so this is just an attempt.)

This fix will be backmerged into f989e243f1f4 in -v2.

Thanks,

	Ingo

=========================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 8 Jan 2022 12:05:57 +0100
Subject: [PATCH] FIX: f989e243f1f4 headers/deps: uapi/headers: Create usr/include/uapi symbolic link

---
 scripts/Makefile.headersinst | 3 +++
 usr/include/uapi             | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 029d85bb0b23..8ac831458143 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -78,6 +78,9 @@ existing-headers := $(filter $(old-headers), $(all-headers))
 
 -include $(foreach f,$(existing-headers),$(dir $(f)).$(notdir $(f)).cmd)
 
+# link the <uapi/*> namespace:
+LINK := $(shell ln -sf ../include $(objtree)/$(dst)/uapi)
+
 PHONY += FORCE
 FORCE:
 
diff --git a/usr/include/uapi b/usr/include/uapi
deleted file mode 120000
index f5030fe88998..000000000000
--- a/usr/include/uapi
+++ /dev/null
@@ -1 +0,0 @@
-../include
\ No newline at end of file
