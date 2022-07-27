Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCD581CA4
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 02:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiG0ADD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 20:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG0ADC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 20:03:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF72527CDD;
        Tue, 26 Jul 2022 17:03:01 -0700 (PDT)
Received: from kbox (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4495320FE6C6;
        Tue, 26 Jul 2022 17:03:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4495320FE6C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658880181;
        bh=tYIAv6959uezVUZhDDpWD0miFdziwvMv1ths87GwnlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVf0QoqXQ/0KK3V3f20W7DxB48xmD4NADN/8ziur3QWSGw98Sw94PxfpFUBEAIVab
         rHCp51DmeekCIB5qSNGEOrbK7DC9yiZVb1cJ0Bdq4Jd1FaVAdwT0ugeY5aU/yRJuKz
         qSqOspxNsCiFPsgPO6C4UvFIPjD1nTr+YFr+NfmI=
Date:   Tue, 26 Jul 2022 17:02:49 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 6/7] tracing/user_events: Use bits vs bytes for
 enabled status page data
Message-ID: <20220727000249.GA2289@kbox>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
 <20220425184631.2068-7-beaub@linux.microsoft.com>
 <20220726180115.69320865@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726180115.69320865@gandalf.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 26, 2022 at 06:01:15PM -0400, Steven Rostedt wrote:
> On Mon, 25 Apr 2022 11:46:30 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 2bcae7abfa81..4afc41e321ac 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -40,17 +40,26 @@
> >   */
> >  #define MAX_PAGE_ORDER 0
> >  #define MAX_PAGES (1 << MAX_PAGE_ORDER)
> > -#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
> > +#define MAX_BYTES (MAX_PAGES * PAGE_SIZE)
> > +#define MAX_EVENTS (MAX_BYTES * 8)
> >  
> >  /* Limit how long of an event name plus args within the subsystem. */
> >  #define MAX_EVENT_DESC 512
> >  #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> >  #define MAX_FIELD_ARRAY_SIZE 1024
> >  
> > +#define STATUS_BYTE(bit) ((bit) >> 3)
> > +#define STATUS_MASK(bit) (1 << ((bit) & 7))
> > +
> > +/* Internal bits to keep track of connected probes */
> > +#define EVENT_STATUS_FTRACE (1 << 0)
> > +#define EVENT_STATUS_PERF (1 << 1)
> > +#define EVENT_STATUS_OTHER (1 << 7)
> 
> Did you mean to shift STATUS_OTHER by 7?
> 

Yes, it should be the value 128.

> Is EVENT_STATUS_OTHER suppose to be one of the flags within the 3 bits of
> the 7 in STATUS_MASK?
> 

My thought was that STATUS_OTHER would stay on the highest bit.
Then when we have other systems they would slot into (1 << 2), etc.

This may not be as important now since the byte is never given back to
the user and is only used when printing out status via the
user_events_status file in text form.

> -- Steve
> 

Thanks,
-Beau
