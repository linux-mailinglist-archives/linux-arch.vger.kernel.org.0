Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A914507981
	for <lists+linux-arch@lfdr.de>; Tue, 19 Apr 2022 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243488AbiDSS77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Apr 2022 14:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiDSS76 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2022 14:59:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B25633B;
        Tue, 19 Apr 2022 11:57:15 -0700 (PDT)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5542D20E1A7F;
        Tue, 19 Apr 2022 11:57:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5542D20E1A7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650394634;
        bh=1xNKG1fM8YQNLY3HXkQavqzQsj2uT3iyFwC11lzWWJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E49U5AUgtuDooLtNKXln9Uquk5N8njYn/p8Jn0+jlAPvoqQ81HqWPop36YDzCT+TR
         lqwYq3NAWO41MAmse7ju1fSZke6kHpsi4LYP5bkB2hoHpfiw/7/9JMUvAGvSaNtCxL
         Zh4so0YKfKMEr9gV2odjiQYCWk0hGGD50tj0eK9A=
Date:   Tue, 19 Apr 2022 11:57:08 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 6/7] tracing/user_events: Use bits vs bytes for enabled
 status page data
Message-ID: <20220419185708.GA1908@kbox>
References: <20220401234309.21252-1-beaub@linux.microsoft.com>
 <20220401234309.21252-7-beaub@linux.microsoft.com>
 <337584634.26921.1650378945485.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <337584634.26921.1650378945485.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 19, 2022 at 10:35:45AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 1, 2022, at 7:43 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> 
> > User processes may require many events and when they do the cache
> > performance of a byte index status check is less ideal than a bit index.
> > The previous event limit per-page was 4096, the new limit is 32,768.
> > 
> > This change adds a mask property to the user_reg struct. Programs check
> > that the byte at status_index has a bit set by ANDing the status_mask.
> > 
> > Link:
> > https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
> > 
> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> 
> Hi Beau,
> 
> Considering this will be used in a fast-path, why choose bytewise
> loads for the byte at status_index and the status_mask ?
> 

First, thanks for the review!

Which loads are you concerned about? The user programs can store the
index and mask in another type after registration instead of an int.

However, you may be referring to something on the kernel side?

> I'm concerned about the performance penalty associated with partial
> register stalls when working with bytewise ALU operations rather than
> operations using the entire registers.
> 

On the kernel side these only occur when a registration happens (pretty
rare compared to enabled checks) or a delete (even rarer). But I have
the feeling you are more concerned about the user side, right?

> Ideally I would be tempted to use "unsigned long" type (32-bit on 32-bit
> binaries and 64-bit on 64-bit binaries) for both the array access
> and the status mask, but this brings extra complexity for 32-bit compat
> handling.
> 

User programs can store the index and mask returned into better value
types for their architecture.

I agree it will cause compat handling issues if it's put into the user
facing header as a long.

I was hoping APIs, like libtracefs, could abstract many callers from how
best to use the returned values. For example, it could save the index
and mask as unsigned long for the callers and use those for the
enablement checks.

Do you think there is a way to enable these native types in the ABI
without causing compat handling issues? I used ints to prevent compat
issues between 32-bit user mode and 64-bit kernel mode.

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

Thanks,
-Beau
