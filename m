Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B40507BE3
	for <lists+linux-arch@lfdr.de>; Tue, 19 Apr 2022 23:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244913AbiDSV3I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Apr 2022 17:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbiDSV3H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2022 17:29:07 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC9B3981F;
        Tue, 19 Apr 2022 14:26:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D568E3C89C5;
        Tue, 19 Apr 2022 17:26:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OyKI6kFpPNva; Tue, 19 Apr 2022 17:26:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 04D7E3C8C12;
        Tue, 19 Apr 2022 17:26:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 04D7E3C8C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1650403581;
        bh=UR+UDh2sgxq34JRYliBR33Jj3EfVuOgsHDPy0KtKMGQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VIE3dfXU+70Ns1aylu+dKPNEmjySJkDsrj8dD0dhIoZnuHDnkZnT8rr6SRbTkzlJW
         mYefpC4iZMWthoBvRRzv3wsIM9jkY7f6o+u1uYwrIdglfiAFuSIg6f2f+qNMTsV/gD
         G6diyQ3ChLVCHUOii00yuWevMiwxLFLVJMjWgg0ToCvebSl8qind4B+1Yx6fjlHNL+
         1ALUMZddEvDiA0p7X3yHidQ5Hc10GKuARoYu3xiJzvSuX64kKn2Z7/PC0nhwyBoIwt
         fjUjmjWwiYN9nwGdjLOHqY81o5JZa1xA0Ldzlv1w+b0gZl8od6kmxQ7nNkWfjkl507
         d6zzsASh7le0A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lil2_ulIHs2V; Tue, 19 Apr 2022 17:26:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EAA343C8A36;
        Tue, 19 Apr 2022 17:26:20 -0400 (EDT)
Date:   Tue, 19 Apr 2022 17:26:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1722727424.27500.1650403580798.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220419185708.GA1908@kbox>
References: <20220401234309.21252-1-beaub@linux.microsoft.com> <20220401234309.21252-7-beaub@linux.microsoft.com> <337584634.26921.1650378945485.JavaMail.zimbra@efficios.com> <20220419185708.GA1908@kbox>
Subject: Re: [PATCH 6/7] tracing/user_events: Use bits vs bytes for enabled
 status page data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4257 (ZimbraWebClient - FF99 (Linux)/8.8.15_GA_4257)
Thread-Topic: tracing/user_events: Use bits vs bytes for enabled status page data
Thread-Index: umKKHV9H1CdGeD2oHITNA+YxDqlQNg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Apr 19, 2022, at 2:57 PM, Beau Belgrave beaub@linux.microsoft.com wrote:

> On Tue, Apr 19, 2022 at 10:35:45AM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 1, 2022, at 7:43 PM, Beau Belgrave beaub@linux.microsoft.com wrote:
>> 
>> > User processes may require many events and when they do the cache
>> > performance of a byte index status check is less ideal than a bit index.
>> > The previous event limit per-page was 4096, the new limit is 32,768.
>> > 
>> > This change adds a mask property to the user_reg struct. Programs check
>> > that the byte at status_index has a bit set by ANDing the status_mask.
>> > 
>> > Link:
>> > https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
>> > 
>> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
>> 
>> Hi Beau,
>> 
>> Considering this will be used in a fast-path, why choose bytewise
>> loads for the byte at status_index and the status_mask ?
>> 
> 
> First, thanks for the review!
> 
> Which loads are you concerned about? The user programs can store the
> index and mask in another type after registration instead of an int.

I'm concerned about the loads from user-space, considering that
those are on the fast-path.

Indeed user programs will need to copy the status index and mask
returned in struct user_reg, so adapting the indexing and mask to
deal with an array of unsigned long rather than bytes can be done
at that point, but I wonder how many users will go through that
extra trouble unless there are helpers to convert the status index
from byte-wise to long-wise, and convert the status mask from a
byte-wise mask to a long-wise mask (and associated documentation).


> 
> However, you may be referring to something on the kernel side?

No.

> 
>> I'm concerned about the performance penalty associated with partial
>> register stalls when working with bytewise ALU operations rather than
>> operations using the entire registers.
>> 
> 
> On the kernel side these only occur when a registration happens (pretty
> rare compared to enabled checks) or a delete (even rarer). But I have
> the feeling you are more concerned about the user side, right?

Right.

> 
>> Ideally I would be tempted to use "unsigned long" type (32-bit on 32-bit
>> binaries and 64-bit on 64-bit binaries) for both the array access
>> and the status mask, but this brings extra complexity for 32-bit compat
>> handling.
>> 
> 
> User programs can store the index and mask returned into better value
> types for their architecture.
> 
> I agree it will cause compat handling issues if it's put into the user
> facing header as a long.
> 
> I was hoping APIs, like libtracefs, could abstract many callers from how
> best to use the returned values. For example, it could save the index
> and mask as unsigned long for the callers and use those for the
> enablement checks.
> 
> Do you think there is a way to enable these native types in the ABI
> without causing compat handling issues? I used ints to prevent compat
> issues between 32-bit user mode and 64-bit kernel mode.

I think you are right: this is not an ABI issue, but rather a usability
issue that can be solved by implementing and documenting user-space library
helpers to help user applications index the array and apply the mask to an
unsigned long type.

Thanks,

Mathieu

> 
>> Thanks,
>> 
>> Mathieu
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
