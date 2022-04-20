Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D9508EE7
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiDTR4h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 13:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381298AbiDTR4h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 13:56:37 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580243DA46;
        Wed, 20 Apr 2022 10:53:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 14ACA3D0069;
        Wed, 20 Apr 2022 13:53:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mGcMI48_ih4O; Wed, 20 Apr 2022 13:53:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4BDD23D02E0;
        Wed, 20 Apr 2022 13:53:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4BDD23D02E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1650477227;
        bh=NH3eElMnuNmGgWaWAOZdaMAOe1XdqcV8YtS5lvgIzgY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qU6qUg9qAyuGFwTRySowJsa7LWK78nHIx9mmAtZ/XZzJTwn7Jmk6hGPHuKPDqxdfH
         1z8QSFQNP8574BGL6Znmva8RrpWdxaEirzoIsuLqU/hLDWei20moHeXN6ReKqCGcw9
         UbleNO6rP7osERsblIdwWQeNtQ2KUtRclTTl4cTV+pD51uVsDxm+Vj7kyvfCkMx13y
         2tFV7g2gFyEvYNXCSvQnvGfnbPID57ry/Kac/Sf8Th7FA9ybsYFIoGDbFkizaK29rH
         uxb1gVA1fXgKGUZzNuxRfnV/u7BGoXFjaP+XOHOVoR2U/+WVjp4CqYvh+3kdBGqPRH
         VcEqZWGoKvXpw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dwnR1Q2zacEs; Wed, 20 Apr 2022 13:53:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3DA573D046E;
        Wed, 20 Apr 2022 13:53:47 -0400 (EDT)
Date:   Wed, 20 Apr 2022 13:53:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <580163630.28705.1650477227106.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220419234845.GA1805@kbox>
References: <20220401234309.21252-1-beaub@linux.microsoft.com> <20220401234309.21252-7-beaub@linux.microsoft.com> <337584634.26921.1650378945485.JavaMail.zimbra@efficios.com> <20220419185708.GA1908@kbox> <1722727424.27500.1650403580798.JavaMail.zimbra@efficios.com> <20220419234845.GA1805@kbox>
Subject: Re: [PATCH 6/7] tracing/user_events: Use bits vs bytes for enabled
 status page data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF99 (Linux)/8.8.15_GA_4257)
Thread-Topic: tracing/user_events: Use bits vs bytes for enabled status page data
Thread-Index: 8J92siFMwIQNblKmIaHIWTTXYFwqhw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



----- On Apr 19, 2022, at 7:48 PM, Beau Belgrave beaub@linux.microsoft.com wrote:

> On Tue, Apr 19, 2022 at 05:26:20PM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 19, 2022, at 2:57 PM, Beau Belgrave beaub@linux.microsoft.com
>> wrote:
>> 
>> > On Tue, Apr 19, 2022 at 10:35:45AM -0400, Mathieu Desnoyers wrote:
>> >> ----- On Apr 1, 2022, at 7:43 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
>> >> 
>> >> > User processes may require many events and when they do the cache
>> >> > performance of a byte index status check is less ideal than a bit index.
>> >> > The previous event limit per-page was 4096, the new limit is 32,768.
>> >> > 
>> >> > This change adds a mask property to the user_reg struct. Programs check
>> >> > that the byte at status_index has a bit set by ANDing the status_mask.
>> >> > 
>> >> > Link:
>> >> > https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
>> >> > 
>> >> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> >> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
>> >> 
>> >> Hi Beau,
>> >> 
>> >> Considering this will be used in a fast-path, why choose bytewise
>> >> loads for the byte at status_index and the status_mask ?
>> >> 
>> > 
>> > First, thanks for the review!
>> > 
>> > Which loads are you concerned about? The user programs can store the
>> > index and mask in another type after registration instead of an int.
>> 
>> I'm concerned about the loads from user-space, considering that
>> those are on the fast-path.
>> 
>> Indeed user programs will need to copy the status index and mask
>> returned in struct user_reg, so adapting the indexing and mask to
>> deal with an array of unsigned long rather than bytes can be done
>> at that point, but I wonder how many users will go through that
>> extra trouble unless there are helpers to convert the status index
>> from byte-wise to long-wise, and convert the status mask from a
>> byte-wise mask to a long-wise mask (and associated documentation).
>> 
> 
> Yeah, do you think it's wise to maybe add inline functions in
> user_events.h to do this conversion? I could then add them to our
> documentation.
> 
> Hopefully this would make more APIs/people do the better approach?
> 
>> 
>> > 
>> > However, you may be referring to something on the kernel side?
>> 
>> No.
>> 
> 
> [..]
> 
>> >> Ideally I would be tempted to use "unsigned long" type (32-bit on 32-bit
>> >> binaries and 64-bit on 64-bit binaries) for both the array access
>> >> and the status mask, but this brings extra complexity for 32-bit compat
>> >> handling.
>> >> 
>> > 
>> > User programs can store the index and mask returned into better value
>> > types for their architecture.
>> > 
>> > I agree it will cause compat handling issues if it's put into the user
>> > facing header as a long.
>> > 
>> > I was hoping APIs, like libtracefs, could abstract many callers from how
>> > best to use the returned values. For example, it could save the index
>> > and mask as unsigned long for the callers and use those for the
>> > enablement checks.
>> > 
>> > Do you think there is a way to enable these native types in the ABI
>> > without causing compat handling issues? I used ints to prevent compat
>> > issues between 32-bit user mode and 64-bit kernel mode.
>> 
>> I think you are right: this is not an ABI issue, but rather a usability
>> issue that can be solved by implementing and documenting user-space library
>> helpers to help user applications index the array and apply the mask to an
>> unsigned long type.
>> 
> 
> Great. Let me know if updating user_events.h to do the conversion is a
> good idea or not, or if you have other thoughts how to make more people
> do the best thing.

Usually uapi headers are reserved for exposing the kernel ABI to user-space.
I think the helpers we are discussing here do not belong to the uapi because they
do not define the ABI, and should probably sit elsewhere in a proper library.

If the status_mask is meant to be modified in some ways by user-space before it can
be used as a mask, I wonder why it is exposed as a byte-wise mask at all ?

Rather than exposing a byte-wise index and single-byte mask as ABI, the kernel could
simply expose a bit-wise index, which can then be used by the application to calculate
index and mask, which it should interpret in little endian if it wants to apply the
mask on types larger than a single byte.

Thoughts ?

Thanks,

Mathieu

> 
>> Thanks,
>> 
>> Mathieu
>> 
>> > 
>> >> Thanks,
>> >> 
>> >> Mathieu
>> >> 
>> >> --
>> >> Mathieu Desnoyers
>> >> EfficiOS Inc.
>> >> http://www.efficios.com
>> > 
>> > Thanks,
>> > -Beau
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
> 
> Thanks,
> -Beau

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
