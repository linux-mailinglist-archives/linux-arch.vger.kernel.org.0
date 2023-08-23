Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74205786421
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 01:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbjHWXye (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 19:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbjHWXyF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 19:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7968510E3;
        Wed, 23 Aug 2023 16:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F6A60F1B;
        Wed, 23 Aug 2023 23:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AC4C433C7;
        Wed, 23 Aug 2023 23:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692834842;
        bh=0QqeR1Lq7+F+rfZm2YiAD6B8qn3qmIFq6Njtx7qgkQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J3z97XbgN0Boa6lUTELS56Hxyl1Vjj9RYLruRdnwKVLH0QvdOxo3g1tF83Jer2l+X
         IrQapRFHeZj8SQp1PXkTWO+ByFRN+i4zwZHBPtWdp04jdeikPrd7qNMvjt24Pgrd0O
         iWrgx2T8pvC6mTQx/mO3Drve3DGX89hpPwSmACXHOEhMp+KmY1iTEysRVKeiHznI/Y
         GTbGvbOs50mTVh2p/fwOmwqQa5AP1nSUnOeUySq9TsDFKF0tf3u9bpYA6OJGpfe+ev
         A3gCD6DIhIUEJb0w0uRnKd3o0xXtihcTnsjcZ0FF2mzsXnxvK6SZQgaeTGQHnkLGgN
         zqi9GJDUuHsMw==
Date:   Thu, 24 Aug 2023 08:53:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobes: Return ENAMESVRLSYMS when
 func matches several symbols
Message-Id: <20230824085355.4fdd6215f71b0fa5f443d76d@kernel.org>
In-Reply-To: <20230823161410.103489-2-flaniel@linux.microsoft.com>
References: <20230823161410.103489-1-flaniel@linux.microsoft.com>
        <20230823161410.103489-2-flaniel@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Francis,

On Wed, 23 Aug 2023 18:14:10 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Previously to this commit, if func matches several symbols, a PMU kprobe would
> be installed for the first matching address.
> This could lead to some misunderstanding when some BPF code was never called
> because it was attached to a function which was indeed not call, because the
> effectively called one has no kprobes.
> 
> So, this commit introduces ENAMESVRLSYMS which is returned when func matches
> several symbols.

The trace_kprobe part looks good to me.
But sorry, I mislead you. I meant using an existing error code as a metaphor.
EINVAL is used everywhere, so choose another error code, e.g. EADDRNOTAVAIL.

Also, can you add this check in __trace_kprobe_create()?
I think right before below code, at that point, 'symbol' has the symbol name.

        trace_probe_log_set_index(0);
        if (event) {
                ret = traceprobe_parse_event_name(&event, &group, gbuf,
                                                  event - argv[0]);
                if (ret)
                        goto parse_error;
        }


Thank you,

> This way, user needs to use addr to remove the ambiguity.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
> ---
>  arch/alpha/include/uapi/asm/errno.h        |  2 ++
>  arch/mips/include/uapi/asm/errno.h         |  2 ++
>  arch/parisc/include/uapi/asm/errno.h       |  2 ++
>  arch/sparc/include/uapi/asm/errno.h        |  2 ++
>  include/uapi/asm-generic/errno.h           |  2 ++
>  kernel/trace/trace_kprobe.c                | 26 ++++++++++++++++++++++
>  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
>  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
>  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
>  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
>  tools/include/uapi/asm-generic/errno.h     |  2 ++
>  11 files changed, 46 insertions(+)
> 
> diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/uapi/asm/errno.h
> index 3d265f6babaf..3d9686d915f9 100644
> --- a/arch/alpha/include/uapi/asm/errno.h
> +++ b/arch/alpha/include/uapi/asm/errno.h
> @@ -125,4 +125,6 @@
> 
>  #define EHWPOISON	139	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	140	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uapi/asm/errno.h
> index 2fb714e2d6d8..1fd64ee7b629 100644
> --- a/arch/mips/include/uapi/asm/errno.h
> +++ b/arch/mips/include/uapi/asm/errno.h
> @@ -124,6 +124,8 @@
> 
>  #define EHWPOISON	168	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	169	/* Name correspond to several symbols */
> +
>  #define EDQUOT		1133	/* Quota exceeded */
> 
> 
> diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
> index 87245c584784..c7845ceece26 100644
> --- a/arch/parisc/include/uapi/asm/errno.h
> +++ b/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
> 
>  #define EHWPOISON	257	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	258	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/uapi/asm/errno.h
> index 81a732b902ee..1ed065943bab 100644
> --- a/arch/sparc/include/uapi/asm/errno.h
> +++ b/arch/sparc/include/uapi/asm/errno.h
> @@ -115,4 +115,6 @@
> 
>  #define EHWPOISON	135	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	136	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> index cf9c51ac49f9..3d5d5740c8da 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -120,4 +120,6 @@
> 
>  #define EHWPOISON	133	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	134	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 23dba01831f7..53b66db1ff53 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1699,6 +1699,16 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
>  }
> 
>  #ifdef CONFIG_PERF_EVENTS
> +
> +static int count_symbols(void *data, unsigned long unused)
> +{
> +	unsigned int *count = data;
> +
> +	(*count)++;
> +
> +	return 0;
> +}
> +
>  /* create a trace_kprobe, but don't add it to global lists */
>  struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> @@ -1709,6 +1719,22 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	int ret;
>  	char *event;
> 
> +	/*
> +	 * If user specifies func, we check that the function name does not
> +	 * correspond to several symbols.
> +	 * If this is the case, we return with error code ENAMESVRLSYMS to
> +	 * indicate the user he/she should use addr and offs rather than func to
> +	 * remove the ambiguity.
> +	 */
> +	if (func) {
> +		unsigned int count;
> +
> +		count = 0;
> +		kallsyms_on_each_match_symbol(count_symbols, func, &count);
> +		if (count > 1)
> +			return ERR_PTR(-ENAMESVRLSYMS);
> +	}
> +
>  	/*
>  	 * local trace_kprobes are not added to dyn_event, so they are never
>  	 * searched in find_trace_kprobe(). Therefore, there is no concern of
> diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alpha/include/uapi/asm/errno.h
> index 3d265f6babaf..3d9686d915f9 100644
> --- a/tools/arch/alpha/include/uapi/asm/errno.h
> +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> @@ -125,4 +125,6 @@
> 
>  #define EHWPOISON	139	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	140	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips/include/uapi/asm/errno.h
> index 2fb714e2d6d8..1fd64ee7b629 100644
> --- a/tools/arch/mips/include/uapi/asm/errno.h
> +++ b/tools/arch/mips/include/uapi/asm/errno.h
> @@ -124,6 +124,8 @@
> 
>  #define EHWPOISON	168	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	169	/* Name correspond to several symbols */
> +
>  #define EDQUOT		1133	/* Quota exceeded */
> 
> 
> diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
> index 87245c584784..c7845ceece26 100644
> --- a/tools/arch/parisc/include/uapi/asm/errno.h
> +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> @@ -124,4 +124,6 @@
> 
>  #define EHWPOISON	257	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	258	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/sparc/include/uapi/asm/errno.h
> index 81a732b902ee..1ed065943bab 100644
> --- a/tools/arch/sparc/include/uapi/asm/errno.h
> +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> @@ -115,4 +115,6 @@
> 
>  #define EHWPOISON	135	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	136	/* Name correspond to several symbols */
> +
>  #endif
> diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uapi/asm-generic/errno.h
> index cf9c51ac49f9..3d5d5740c8da 100644
> --- a/tools/include/uapi/asm-generic/errno.h
> +++ b/tools/include/uapi/asm-generic/errno.h
> @@ -120,4 +120,6 @@
> 
>  #define EHWPOISON	133	/* Memory page has hardware error */
> 
> +#define ENAMESVRLSYMS	134	/* Name correspond to several symbols */
> +
>  #endif
> --
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
