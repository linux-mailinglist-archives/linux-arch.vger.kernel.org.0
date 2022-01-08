Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4141488309
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 11:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiAHKci (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 05:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiAHKci (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 05:32:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D7C061574;
        Sat,  8 Jan 2022 02:32:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so15995246wrg.11;
        Sat, 08 Jan 2022 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ncm4vmIPrAny4fGOw23lDSiniXeSKXz2SDH9h4DiGpQ=;
        b=pQKGP4xhv2CT1d4x871Y4t7neNth9UmkrfMmE9N+lgS0o+4gh/xxpUG7B2xORbN9nN
         8qisKFePxYHrlI8AhVdagU1jZfR8JvJ/fuLyESZqDm2dtv7pMktpp9dHjerRnoeKfVd/
         EfbCgNnhHdlpBuu7qrsCNIR5qi5LiPr/QHQdCHME1EzEiQl9IzScw/jDPh2puf8qdp97
         y0pnphQjBT+I3E0wqZMEG78B8+7vFjOUPqjK/PsgajLMIWR+opVUao+v4IheS0LFWbfg
         5hXpL9PaUnqYwufkXHDyQjI00SoBDIZu5R1cZ1qvQMOMkcvGDSd7Qlmv06o+kyZx/hLc
         OEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Ncm4vmIPrAny4fGOw23lDSiniXeSKXz2SDH9h4DiGpQ=;
        b=ZQ+fnHyxdZ2TUmIXl4qjHDj/GDHZcVfmx4g7JArSSUz1XwFm29bYFRF5ZEx94gI0PM
         h8pX/0reTFxJRUzRO/Jsee58VuqBwm0shGjZeeRR1pWtaxM47k5wnl7sfx8MS0tbRu2s
         FFxXWaPalJaQYOkr6E5qVIF8xLDdwy/e8y8aSgILJWNLRlUpGbauFgK55MFo8iNR6WNf
         Bz9jG9gCiAJgIENw7h7+iq99pTmILqBetwifS3a/OZ8Je7+7sBleyHomkX0iUQ2v5fCi
         J6eFCIf1K9Vy/wOdxHROGVDA//JzVeFD727bb3tEMp11+HRHQn2VESHvvFhyuWKqvZ/L
         LpbQ==
X-Gm-Message-State: AOAM5326TT7P4HM0Knj6p7gpDTKNqlzrMwQn1nndtm3QQn+Lquk/tg14
        80i3PuDXSshBxeexQq+xS/E=
X-Google-Smtp-Source: ABdhPJxXWLbG3api22n+vh1gpH2oSN+reaVhu6VdmRxg5GCcIzVKg9VGsTEE8dzOa8JYR4B/M/c2nw==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr4510251wro.270.1641637954786;
        Sat, 08 Jan 2022 02:32:34 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id l8sm1264937wrv.25.2022.01.08.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 02:32:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 11:32:31 +0100
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
Subject: [PATCH] headers/deps: Add header dependencies to .c files:
 <linux/ptrace_api.h>
Message-ID: <YdloP5TfDSTURAh3@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
 <YdTvXkKFzA0pOjFf@gmail.com>
 <YdYQu9YxNw0CxJRn@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdYQu9YxNw0CxJRn@archlinux-ax161>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> 1. kernel/stackleak.c build failure:
> 
> $ make -skj"$(nproc)" ARCH=x86_64 allmodconfig kernel/stackleak.o
> kernel/stackleak.c: In function ‘stackleak_erase’:
> kernel/stackleak.c:92:13: error: implicit declaration of function ‘on_thread_stack’; did you mean ‘setup_thread_stack’? [-Werror=implicit-function-declaration]

So it turns out that my build environment didn't have the stackleak code 
enabled at all:

  kepler:~/mingo.tip.git> make ARCH=x86_64 allmodconfig
  #
  # configuration written to .config
  #
  kepler:~/mingo.tip.git> grep -E 'STACKLEAK|GCC_PLUGIN' .config
  CONFIG_HAVE_ARCH_STACKLEAK=y
  CONFIG_HAVE_GCC_PLUGINS=y

... because it failed this condition:

 menuconfig GCC_PLUGINS
 ...
        depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)

... because there were no plugin headers:

  kepler:~/mingo.tip.git> gcc -print-file-name=plugin
  /usr/lib/gcc/x86_64-linux-gnu/10/plugin

  kepler:~/mingo.tip.git> ls $(gcc -print-file-name=plugin)/include/
  ls: cannot access '/usr/lib/gcc/x86_64-linux-gnu/10/plugin/include/': No such file or directory

... because I needed to install the plugin-development packages for gcc-10.

After installing those I have stackleak:

  kepler:~/mingo.tip.git> grep STACKLEAK .config
  CONFIG_HAVE_ARCH_STACKLEAK=y
  CONFIG_GCC_PLUGIN_STACKLEAK=y
  CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
  CONFIG_STACKLEAK_METRICS=y
  CONFIG_STACKLEAK_RUNTIME_DISABLE=y

and was able to reproduce your build failure. :-)

> This is fixed with the following diff although I am unsure if that is as
> minimal as it should be.
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index ce161a8e8d97..d67c5475183b 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -10,8 +10,10 @@
>   * reveal and blocks some uninitialized stack variable attacks.
>   */
>  
> +#include <asm/processor_api.h>
>  #include <linux/stackleak.h>
>  #include <linux/kprobes.h>
> +#include <linux/align.h>

Yeah - I used a simpler & more generic header: <linux/ptrace_api.h> - see 
the patch below.

But your solution is functionally equivalent. This fix will be included in 
-v2, hopefully released later today.

Thanks,

	Ingo

===============>
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 8 Jan 2022 11:29:17 +0100
Subject: [PATCH] headers/deps: Add header dependencies to .c files: <linux/ptrace_api.h>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/stackleak.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ce161a8e8d97..fde49e2f209a 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -10,6 +10,7 @@
  * reveal and blocks some uninitialized stack variable attacks.
  */
 
+#include <linux/ptrace_api.h>
 #include <linux/stackleak.h>
 #include <linux/kprobes.h>
 
