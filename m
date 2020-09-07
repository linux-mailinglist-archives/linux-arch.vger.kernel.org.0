Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537F825F15B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 03:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIGBMi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Sep 2020 21:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgIGBMh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Sep 2020 21:12:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6EA82080A;
        Mon,  7 Sep 2020 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599441156;
        bh=xyTSMPG3pyBCZv5zMohBYPXtrUS10O0YxLED9qNXz1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z4ctw8TGu/NMj1f6Hv2KXkrBHHa+hL7RZJDYAkBwkP7Zi0ELinKFYmIOB4m2bj+Br
         REdUI3oczw2sfJo0SbI9XIY3sEtUK+33VKxfvPvGwHzxwMucx5Nbb4xzObhrn0k+Zq
         pn0XJDjrIvvplQXYJSINInsZBA/KoOuJSe+bM3zE=
Date:   Mon, 7 Sep 2020 10:12:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hewllig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 08/11] kprobes: switch to kernel_clone()
Message-Id: <20200907101226.ab0d00639be953e81d4576c2@kernel.org>
In-Reply-To: <20200819104655.436656-9-christian.brauner@ubuntu.com>
References: <20200819104655.436656-1-christian.brauner@ubuntu.com>
        <20200819104655.436656-9-christian.brauner@ubuntu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Wed, 19 Aug 2020 12:46:52 +0200
Christian Brauner <christian.brauner@ubuntu.com> wrote:

> The old _do_fork() helper is removed in favor of the new kernel_clone() helper.
> The latter adheres to naming conventions for kernel internal syscall helpers.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
> ---
>  samples/kprobes/kprobe_example.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 240f2435ce6f..a02f53836ee1 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -2,13 +2,13 @@
>  /*
>   * NOTE: This example is works on x86 and powerpc.
>   * Here's a sample kernel module showing the use of kprobes to dump a
> - * stack trace and selected registers when _do_fork() is called.
> + * stack trace and selected registers when kernel_clone() is called.
>   *
>   * For more information on theory of operation of kprobes, see
>   * Documentation/staging/kprobes.rst
>   *
>   * You will see the trace data in /var/log/messages and on the console
> - * whenever _do_fork() is invoked to create a new process.
> + * whenever kernel_clone() is invoked to create a new process.
>   */
>  
>  #include <linux/kernel.h>
> @@ -16,7 +16,7 @@
>  #include <linux/kprobes.h>
>  
>  #define MAX_SYMBOL_LEN	64
> -static char symbol[MAX_SYMBOL_LEN] = "_do_fork";
> +static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
>  module_param_string(symbol, symbol, sizeof(symbol), 0644);
>  
>  /* For each probe you need to allocate a kprobe structure */
> -- 
> 2.28.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
