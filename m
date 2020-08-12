Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708C5242F84
	for <lists+linux-arch@lfdr.de>; Wed, 12 Aug 2020 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHLToz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Aug 2020 15:44:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:39788 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgHLToy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2020 15:44:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AAD4D2D929D;
        Wed, 12 Aug 2020 15:44:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bWQ-UzXqrOsE; Wed, 12 Aug 2020 15:44:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 53F4A2D8FC5;
        Wed, 12 Aug 2020 15:44:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 53F4A2D8FC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597261492;
        bh=27YeVv9LTcVA+WNghyxUs9/L79lcl7/RQBwB643XlH4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jLSBTUeSs5464E1gkJ7QKLaFNrvqBwdGbt3JW6cy9SfDaU4jyVeRyYVrxQnhggOdq
         lZzrsKW5ajM3NqhdFDeUi+xelAR+1D5jP+E9NPTK7PjIMZXnEOvUQOhp8xDPFB/efF
         RBnd+RsXExk7vuVbGWk1j2hxrVyvZN7ZV73hGM2zZAxOtYuVEFNq6dxZbnZirEc2N2
         YgedSJ7TFC7cs2o7cncM0vIVnQ07Lttfwc6iAFcrokUZA5SQVTtAA24MDiU+q76q8y
         7ht7Uju5f511xLBnhoC/v5D8JopPzrI3I/J7W8I/2CVAAe+8t6qmTCl1dnNzVAPOPF
         0L0f9BTkww9xQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xo32z08Mecvr; Wed, 12 Aug 2020 15:44:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 461DF2D906D;
        Wed, 12 Aug 2020 15:44:52 -0400 (EDT)
Date:   Wed, 12 Aug 2020 15:44:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1477195446.6156.1597261492255.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51XJhKXn7M2U2dZpFRsTrog4juy=UQfbtcdJfOj5TUSbqQ@mail.gmail.com>
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net> <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com> <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com> <CAFTs51XJhKXn7M2U2dZpFRsTrog4juy=UQfbtcdJfOj5TUSbqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: PhnLhe0vwNWrPvX80tp/NjrejyMQtA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Aug 12, 2020, at 2:48 PM, Peter Oskolkov posk@posk.io wrote:

> On Wed, Aug 12, 2020 at 11:30 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> 
> [...]
> 
>> "flags" is there to allow extensibility without requiring to add new
>> membarrier commands for every change. Even though it is not used now,
>> I don't think re-purposing it is a good idea. What is wrong with just
>> adding an additional "cpu" parameter to the system call ?
> 
> Can we do that? I thought adding an additional parameter means adding
> another syscall (ABI => parameter types/count cannot change?)

I was under the impression that adding parameters to a system call
for new flags (or commands) was not an issue. One example is the
clone system call which expects the ctid argument if the
CLONE_CHILD_CLEARTID flag is set. But maybe it was OK at some earlier
point in time, but it's not OK anymore ? (CCing linux-arch to ask for
advice)

> 
>> A "flags" parameter is very common for system calls. I don't see why
>> we should change its name, especially given it is already exposed and
>> documented as "flags" in man pages.
>>
> 
> [...]
> 
>> We basically have the following feature matrix:
>>
>> - private / global
>> - expedited / non-expedited
>> - sync-core / non-sync-core
>> - rseq-fence / non-rseq-fence
>>
>> For a total of about 16 combinations in total if we want to support them
>> all.
>>
>> We can continue to add separate commands for new combinations, but if we
>> want to allow them to be combined, using flags rather than adding extra
>> commands would have the advantage of keeping the number of commands
>> manageable.
>>
>> However, if there is no actual use-case for combining a membarrier sync-core
>> and a membarrier rseq-fence, then it limits the number of commands and maybe
>> then it's acceptable to add the rseq-fence as a separate membarrier command.
>>
>> I prefer to have this discussion now rather than once we get to the point of
>> having 40 membarrier commands for all possible combinations.
> 
> All commands are currently distinct bits, but are treated as separate commands.

Indeed! I forgot about that. It was done so we can return a mask of supported
commands with the MEMBARRIER_CMD_QUERY for feature discoverability. Those were
never meant to be OR'd though, because then it's hard for user-space to discover
what are the allowed command combinations.

> One way of doing what you suggest is to allow some commands to be bitwise-ORed.
> 
> So, for example, the user could call
> 
> membarrier(CMD_PRIVATE_EXPEDITED_SYNC_CORE | CMD_PRIVATE_EXPEDITED_RSEQ, cpu_id)
> 
> Is this what you have in mind?

Not really. This would not take care of the fact that we would end up multiplying
the number of commands as we allow combinations. E.g. if we ever want to have RSEQ
work in private and global, and in non-expedited and expedited, we end up needing:

- CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
- CMD_PRIVATE_EXPEDITED_RSEQ
- CMD_PRIVATE_RSEQ
- CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ
- CMD_GLOBAL_EXPEDITED_RSEQ
- CMD_GLOBAL_RSEQ

The only thing we would save by OR'ing it with the SYNC_CORE command is the additional
list:

- CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_SYNC_CORE
- CMD_PRIVATE_EXPEDITED_RSEQ_SYNC_CORE
- CMD_PRIVATE_RSEQ_SYNC_CORE
- CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ_SYNC_CORE
- CMD_GLOBAL_EXPEDITED_RSEQ_SYNC_CORE
- CMD_GLOBAL_RSEQ_SYNC_CORE

But unless we receive feedback that doing a membarrier with RSEQ+sync_core all in
one go is a significant use-case, I am tempted to leave out that scenario for now.
If we go for new commands, this means we could add (for private-expedited-rseq):

- MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ,
- MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,

I do however have use-cases for using RSEQ across shared memory (between
processes). Not currently for a rseq-fence, but for rseq acting as per-cpu
atomic operations. If I ever end up needing rseq-fence across shared memory,
that would result in the following new commands:

- MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ,
- MEMBARRIER_CMD_GLOBAL_EXPEDITED_RSEQ,

The remaining open question is whether it would be OK to define a new
membarrier flag=MEMBARRIER_FLAG_CPU, which would expect an additional
@cpu parameter.

Thanks,

Mathieu

> 
> [...]
> 
> Thanks,
> Peter

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
