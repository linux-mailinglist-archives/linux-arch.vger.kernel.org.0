Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4250913B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348651AbiDTUPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiDTUPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 16:15:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B43BC3EAB5;
        Wed, 20 Apr 2022 13:12:51 -0700 (PDT)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F0CB20E2D0B;
        Wed, 20 Apr 2022 13:12:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F0CB20E2D0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650485571;
        bh=MDhA/ZAoV0EVezZuKhr9gsvqOEuaEbb4xLsvMqvOxYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9QaK7FfpU3QnoJikpUobgKHlvcfDJUYyp4GP3095vq1/lELGBZsJaBik0L6Y7nXt
         Mw+D7+4q1eJ4iO/bLo0spFBGwzeM1nCUY+t7m7JNXLPGXicQPHjfzuNwqsNIjYco4L
         paUJUC9J8a4RrKhiVB+R+66XsBpoE5dNqCh92M5Q=
Date:   Wed, 20 Apr 2022 13:12:42 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 6/7] tracing/user_events: Use bits vs bytes for enabled
 status page data
Message-ID: <20220420201242.GA2091@kbox>
References: <20220401234309.21252-1-beaub@linux.microsoft.com>
 <20220401234309.21252-7-beaub@linux.microsoft.com>
 <337584634.26921.1650378945485.JavaMail.zimbra@efficios.com>
 <20220419185708.GA1908@kbox>
 <1722727424.27500.1650403580798.JavaMail.zimbra@efficios.com>
 <20220419234845.GA1805@kbox>
 <580163630.28705.1650477227106.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580163630.28705.1650477227106.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 20, 2022 at 01:53:47PM -0400, Mathieu Desnoyers wrote:
> 
> 
> ----- On Apr 19, 2022, at 7:48 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> 
> > On Tue, Apr 19, 2022 at 05:26:20PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 19, 2022, at 2:57 PM, Beau Belgrave beaub@linux.microsoft.com
> >> wrote:
> >> 
> >> > On Tue, Apr 19, 2022 at 10:35:45AM -0400, Mathieu Desnoyers wrote:
> >> >> ----- On Apr 1, 2022, at 7:43 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
> >> >> 
> >> >> > User processes may require many events and when they do the cache
> >> >> > performance of a byte index status check is less ideal than a bit index.
> >> >> > The previous event limit per-page was 4096, the new limit is 32,768.
> >> >> > 
> >> >> > This change adds a mask property to the user_reg struct. Programs check
> >> >> > that the byte at status_index has a bit set by ANDing the status_mask.
> >> >> > 
> >> >> > Link:
> >> >> > https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
> >> >> > 
> >> >> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> >> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> >> >> 
> >> >> Hi Beau,
> >> >> 
> >> >> Considering this will be used in a fast-path, why choose bytewise
> >> >> loads for the byte at status_index and the status_mask ?
> >> >> 
> >> > 
> >> > First, thanks for the review!
> >> > 
> >> > Which loads are you concerned about? The user programs can store the
> >> > index and mask in another type after registration instead of an int.
> >> 
> >> I'm concerned about the loads from user-space, considering that
> >> those are on the fast-path.
> >> 
> >> Indeed user programs will need to copy the status index and mask
> >> returned in struct user_reg, so adapting the indexing and mask to
> >> deal with an array of unsigned long rather than bytes can be done
> >> at that point, but I wonder how many users will go through that
> >> extra trouble unless there are helpers to convert the status index
> >> from byte-wise to long-wise, and convert the status mask from a
> >> byte-wise mask to a long-wise mask (and associated documentation).
> >> 
> > 
> > Yeah, do you think it's wise to maybe add inline functions in
> > user_events.h to do this conversion? I could then add them to our
> > documentation.
> > 
> > Hopefully this would make more APIs/people do the better approach?
> > 
> >> 
> >> > 
> >> > However, you may be referring to something on the kernel side?
> >> 
> >> No.
> >> 
> > 
> > [..]
> > 
> >> >> Ideally I would be tempted to use "unsigned long" type (32-bit on 32-bit
> >> >> binaries and 64-bit on 64-bit binaries) for both the array access
> >> >> and the status mask, but this brings extra complexity for 32-bit compat
> >> >> handling.
> >> >> 
> >> > 
> >> > User programs can store the index and mask returned into better value
> >> > types for their architecture.
> >> > 
> >> > I agree it will cause compat handling issues if it's put into the user
> >> > facing header as a long.
> >> > 
> >> > I was hoping APIs, like libtracefs, could abstract many callers from how
> >> > best to use the returned values. For example, it could save the index
> >> > and mask as unsigned long for the callers and use those for the
> >> > enablement checks.
> >> > 
> >> > Do you think there is a way to enable these native types in the ABI
> >> > without causing compat handling issues? I used ints to prevent compat
> >> > issues between 32-bit user mode and 64-bit kernel mode.
> >> 
> >> I think you are right: this is not an ABI issue, but rather a usability
> >> issue that can be solved by implementing and documenting user-space library
> >> helpers to help user applications index the array and apply the mask to an
> >> unsigned long type.
> >> 
> > 
> > Great. Let me know if updating user_events.h to do the conversion is a
> > good idea or not, or if you have other thoughts how to make more people
> > do the best thing.
> 
> Usually uapi headers are reserved for exposing the kernel ABI to user-space.
> I think the helpers we are discussing here do not belong to the uapi because they
> do not define the ABI, and should probably sit elsewhere in a proper library.
> 

Makes sense.

That likely means I should remove the enablement helper check from
user_events.h, right?

> If the status_mask is meant to be modified in some ways by user-space before it can
> be used as a mask, I wonder why it is exposed as a byte-wise mask at all ?
> 
> Rather than exposing a byte-wise index and single-byte mask as ABI, the kernel could
> simply expose a bit-wise index, which can then be used by the application to calculate
> index and mask, which it should interpret in little endian if it wants to apply the
> mask on types larger than a single byte.
> 
> Thoughts ?
> 

Yeah, you're right, we can just expose out the bit-wise index at the
ABI.

I'll switch over to that model in the next version.

Thanks,
-Beau

> Thanks,
> 
> Mathieu
> 

[..]
