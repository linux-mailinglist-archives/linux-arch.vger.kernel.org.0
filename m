Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14714581BE6
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGZWBV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZWBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 18:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B732DAF;
        Tue, 26 Jul 2022 15:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD24616E1;
        Tue, 26 Jul 2022 22:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B814C433C1;
        Tue, 26 Jul 2022 22:01:17 +0000 (UTC)
Date:   Tue, 26 Jul 2022 18:01:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 6/7] tracing/user_events: Use bits vs bytes for
 enabled status page data
Message-ID: <20220726180115.69320865@gandalf.local.home>
In-Reply-To: <20220425184631.2068-7-beaub@linux.microsoft.com>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
        <20220425184631.2068-7-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 25 Apr 2022 11:46:30 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 2bcae7abfa81..4afc41e321ac 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -40,17 +40,26 @@
>   */
>  #define MAX_PAGE_ORDER 0
>  #define MAX_PAGES (1 << MAX_PAGE_ORDER)
> -#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
> +#define MAX_BYTES (MAX_PAGES * PAGE_SIZE)
> +#define MAX_EVENTS (MAX_BYTES * 8)
>  
>  /* Limit how long of an event name plus args within the subsystem. */
>  #define MAX_EVENT_DESC 512
>  #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
>  #define MAX_FIELD_ARRAY_SIZE 1024
>  
> +#define STATUS_BYTE(bit) ((bit) >> 3)
> +#define STATUS_MASK(bit) (1 << ((bit) & 7))
> +
> +/* Internal bits to keep track of connected probes */
> +#define EVENT_STATUS_FTRACE (1 << 0)
> +#define EVENT_STATUS_PERF (1 << 1)
> +#define EVENT_STATUS_OTHER (1 << 7)

Did you mean to shift STATUS_OTHER by 7?

Is EVENT_STATUS_OTHER suppose to be one of the flags within the 3 bits of
the 7 in STATUS_MASK?

-- Steve

> +
>  static char *register_page_data;
>  
>  static DEFINE_MUTEX(reg_mutex);
> -static DEFINE_HASHTABLE(register_table, 4);
> +static DEFINE_HASHTABLE(register_table, 8);
>  static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
>  
>  /*
> @@ -72,6 +81,7 @@ struct user_event {
>  	int index;
>  	int flags;
>  	int min_size;
> +	char status;
>  };
