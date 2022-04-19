Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6B507D54
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiDSXvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Apr 2022 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiDSXvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2022 19:51:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E25C5255A1;
        Tue, 19 Apr 2022 16:48:50 -0700 (PDT)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 54C2420E1A87;
        Tue, 19 Apr 2022 16:48:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54C2420E1A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650412130;
        bh=TgE2RkLoKlP0AOkm6pT73qsCntJomvvFr5kNNc+lHpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Djqi0s03kbM+XqKx6YwXkplhlSB6f94pAk+/lJawbTRFHYG+zS6v5U75u7hfs/B3F
         2LD6MpBT51MHc+cZYykq9BKy00eKZ1M4ItoAN3a9lpdngmzOWmyRLeLV62O+cYscUD
         JsTpuX74BRo4t9jguZ2EuastdR9jS6XjIqRh7VMQ=
Date:   Tue, 19 Apr 2022 16:48:45 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 6/7] tracing/user_events: Use bits vs bytes for enabled
 status page data
Message-ID: <20220419234845.GA1805@kbox>
References: <20220401234309.21252-1-beaub@linux.microsoft.com>
 <20220401234309.21252-7-beaub@linux.microsoft.com>
 <337584634.26921.1650378945485.JavaMail.zimbra@efficios.com>
 <20220419185708.GA1908@kbox>
 <1722727424.27500.1650403580798.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722727424.27500.1650403580798.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 19, 2022 at 05:26:20PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 19, 2022, at 2:57 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> 
> > On Tue, Apr 19, 2022 at 10:35:45AM -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 1, 2022, at 7:43 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> >> 
> >> > User processes may require many events and when they do the cache
> >> > performance of a byte index status check is less ideal than a bit index.
> >> > The previous event limit per-page was 4096, the new limit is 32,768.
> >> > 
> >> > This change adds a mask property to the user_reg struct. Programs check
> >> > that the byte at status_index has a bit set by ANDing the status_mask.
> >> > 
> >> > Link:
> >> > https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
> >> > 
> >> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> >> 
> >> Hi Beau,
> >> 
> >> Considering this will be used in a fast-path, why choose bytewise
> >> loads for the byte at status_index and the status_mask ?
> >> 
> > 
> > First, thanks for the review!
> > 
> > Which loads are you concerned about? The user programs can store the
> > index and mask in another type after registration instead of an int.
> 
> I'm concerned about the loads from user-space, considering that
> those are on the fast-path.
> 
> Indeed user programs will need to copy the status index and mask
> returned in struct user_reg, so adapting the indexing and mask to
> deal with an array of unsigned long rather than bytes can be done
> at that point, but I wonder how many users will go through that
> extra trouble unless there are helpers to convert the status index
> from byte-wise to long-wise, and convert the status mask from a
> byte-wise mask to a long-wise mask (and associated documentation).
> 

Yeah, do you think it's wise to maybe add inline functions in
user_events.h to do this conversion? I could then add them to our
documentation.

Hopefully this would make more APIs/people do the better approach?

> 
> > 
> > However, you may be referring to something on the kernel side?
> 
> No.
> 

[..]

> >> Ideally I would be tempted to use "unsigned long" type (32-bit on 32-bit
> >> binaries and 64-bit on 64-bit binaries) for both the array access
> >> and the status mask, but this brings extra complexity for 32-bit compat
> >> handling.
> >> 
> > 
> > User programs can store the index and mask returned into better value
> > types for their architecture.
> > 
> > I agree it will cause compat handling issues if it's put into the user
> > facing header as a long.
> > 
> > I was hoping APIs, like libtracefs, could abstract many callers from how
> > best to use the returned values. For example, it could save the index
> > and mask as unsigned long for the callers and use those for the
> > enablement checks.
> > 
> > Do you think there is a way to enable these native types in the ABI
> > without causing compat handling issues? I used ints to prevent compat
> > issues between 32-bit user mode and 64-bit kernel mode.
> 
> I think you are right: this is not an ABI issue, but rather a usability
> issue that can be solved by implementing and documenting user-space library
> helpers to help user applications index the array and apply the mask to an
> unsigned long type.
> 

Great. Let me know if updating user_events.h to do the conversion is a
good idea or not, or if you have other thoughts how to make more people
do the best thing.

> Thanks,
> 
> Mathieu
> 
> > 
> >> Thanks,
> >> 
> >> Mathieu
> >> 
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> > 
> > Thanks,
> > -Beau
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

Thanks,
-Beau
