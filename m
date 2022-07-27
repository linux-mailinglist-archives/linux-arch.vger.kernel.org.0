Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCB581CB6
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiG0AOX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 20:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiG0AOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 20:14:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C023AB11;
        Tue, 26 Jul 2022 17:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB056B818CC;
        Wed, 27 Jul 2022 00:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A698C433D6;
        Wed, 27 Jul 2022 00:14:18 +0000 (UTC)
Date:   Tue, 26 Jul 2022 20:14:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 6/7] tracing/user_events: Use bits vs bytes for
 enabled status page data
Message-ID: <20220726201412.7fbd3b1f@rorschach.local.home>
In-Reply-To: <20220727000249.GA2289@kbox>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
        <20220425184631.2068-7-beaub@linux.microsoft.com>
        <20220726180115.69320865@gandalf.local.home>
        <20220727000249.GA2289@kbox>
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

On Tue, 26 Jul 2022 17:02:49 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > >  /* Limit how long of an event name plus args within the subsystem. */
> > >  #define MAX_EVENT_DESC 512
> > >  #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> > >  #define MAX_FIELD_ARRAY_SIZE 1024
> > >  
> > > +#define STATUS_BYTE(bit) ((bit) >> 3)
> > > +#define STATUS_MASK(bit) (1 << ((bit) & 7))
> > > +
> > > +/* Internal bits to keep track of connected probes */
> > > +#define EVENT_STATUS_FTRACE (1 << 0)
> > > +#define EVENT_STATUS_PERF (1 << 1)
> > > +#define EVENT_STATUS_OTHER (1 << 7)  
> > 
> > Did you mean to shift STATUS_OTHER by 7?
> >   
> 
> Yes, it should be the value 128.
> 
> > Is EVENT_STATUS_OTHER suppose to be one of the flags within the 3 bits of
> > the 7 in STATUS_MASK?
> >   
> 
> My thought was that STATUS_OTHER would stay on the highest bit.
> Then when we have other systems they would slot into (1 << 2), etc.
> 
> This may not be as important now since the byte is never given back to
> the user and is only used when printing out status via the
> user_events_status file in text form.

So, it is confusing because of STATUS_MASK() is bits 0,1,2 and we are
only using bits 0 and 1, with a OTHER bit at bit 7. And it would be
good to use the BIT() macro.

Is STATUS_OTHER suppose to be part of STATUS_MASK()?

-- Steve
