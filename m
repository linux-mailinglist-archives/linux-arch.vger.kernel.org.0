Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F645581D5F
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 04:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiG0CB5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 22:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiG0CB4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 22:01:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2F2817AA4;
        Tue, 26 Jul 2022 19:01:52 -0700 (PDT)
Received: from kbox (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6716D20FE6C1;
        Tue, 26 Jul 2022 19:01:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6716D20FE6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1658887312;
        bh=bBfPFoDBhzmxwWOcOsa+z7Vs0VyW7iTOA0R6DE9Yyms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFFxRF/PnYQsSn3oCSPsQZmGeL0kCooqNIjdot8w5AJi5JGzdtSyzo3Oan93RRhM7
         0UyRz9AZA3/EUmEM6LOFa7vbxRBgcvezp6+BYEqzg1477+FLI+IVbKsMhzHzAvDus8
         BHjcoEX9A3CnrOn+jrx04Ou+0i4+//as7gRchHE8=
Date:   Tue, 26 Jul 2022 19:01:47 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 6/7] tracing/user_events: Use bits vs bytes for
 enabled status page data
Message-ID: <20220727020147.GA1705@kbox>
References: <20220425184631.2068-1-beaub@linux.microsoft.com>
 <20220425184631.2068-7-beaub@linux.microsoft.com>
 <20220726180115.69320865@gandalf.local.home>
 <20220727000249.GA2289@kbox>
 <20220726201412.7fbd3b1f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726201412.7fbd3b1f@rorschach.local.home>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 26, 2022 at 08:14:12PM -0400, Steven Rostedt wrote:
> On Tue, 26 Jul 2022 17:02:49 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > > >  /* Limit how long of an event name plus args within the subsystem. */
> > > >  #define MAX_EVENT_DESC 512
> > > >  #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
> > > >  #define MAX_FIELD_ARRAY_SIZE 1024
> > > >  
> > > > +#define STATUS_BYTE(bit) ((bit) >> 3)
> > > > +#define STATUS_MASK(bit) (1 << ((bit) & 7))
> > > > +
> > > > +/* Internal bits to keep track of connected probes */
> > > > +#define EVENT_STATUS_FTRACE (1 << 0)
> > > > +#define EVENT_STATUS_PERF (1 << 1)
> > > > +#define EVENT_STATUS_OTHER (1 << 7)  
> > > 
> > > Did you mean to shift STATUS_OTHER by 7?
> > >   
> > 
> > Yes, it should be the value 128.
> > 
> > > Is EVENT_STATUS_OTHER suppose to be one of the flags within the 3 bits of
> > > the 7 in STATUS_MASK?
> > >   
> > 
> > My thought was that STATUS_OTHER would stay on the highest bit.
> > Then when we have other systems they would slot into (1 << 2), etc.
> > 
> > This may not be as important now since the byte is never given back to
> > the user and is only used when printing out status via the
> > user_events_status file in text form.
> 
> So, it is confusing because of STATUS_MASK() is bits 0,1,2 and we are
> only using bits 0 and 1, with a OTHER bit at bit 7. And it would be
> good to use the BIT() macro.
> 

Ah, I see the confusion. Sorry.  

EVENT_STATUS_* are internal bits that aren't used with STATUS_MASK or
STATUS_BYTE. It's only used to set and check the user event status byte
for checking if anything is attached and outputting which probe is
connected within the kernel side.

STATUS_BYTE and STATUS_MASK take a bit in a bitmap and figure out which
byte in the status mapping should be used and which bit in that byte
should be set/reset (mask) when it's enabled/disabled via a probe. Both
the user and kernel need to align on this logic.

IE: Bits above the lower 3 of the index/bit of the event to enable is the byte
and the lower 3 bits (& 7) is the actual bit to set.

For example if the user_event with the index 1024 is enabled, we need to
figure out which byte and bit represents that event when a probe is
attached.

I got into detail of this in the documentation for both a byte and long
wise checking of these values.

Hope that helps explain it.

> Is STATUS_OTHER suppose to be part of STATUS_MASK()?
> 
> -- Steve

Thanks,
-Beau
