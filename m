Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE5251DAF
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYQ6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 12:58:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:54230 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgHYQ62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 12:58:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F41EB25E13D;
        Tue, 25 Aug 2020 12:58:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ddEiH_vdZ8LL; Tue, 25 Aug 2020 12:58:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 834F825DE54;
        Tue, 25 Aug 2020 12:58:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 834F825DE54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1598374701;
        bh=8pMBOx23pCf5NPePNYDHmUZ9AoEDhBHlY2NFid2+VHU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ADy/ab3jRq6H7i/k9KwCApzr/+L46USCep1xAaAOZAwMlaiqaPHFobZ6fcMjZ3D2Q
         q9F4MiDMBRBjFr6+YDUCRLL2v0z/DgHoHiTNDHvSPt2fyV9tfcpLFBJiMTGOue4Q8L
         ufV2D2etAJUeI4mJh5Ow/ol4Ro5W2Y1iq++LFNcQ2W8q4zl7JwsrX4Zmv9HMRMcasH
         Nw9hW9t2b2NRpzKwDkb/0UJoLw2DaJpWX40k5Sv5/C1f4NdgC+OtG319AvE71AmMdy
         xuZkcaWirWirakU75EFZLeQJwIy8F9yDjiOGg3Zhn5b7uUySk/vitfVY8ssFsDQokE
         Zg8XrO5g5XmAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0y5gHkg6pdUQ; Tue, 25 Aug 2020 12:58:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 73A5F25DE53;
        Tue, 25 Aug 2020 12:58:21 -0400 (EDT)
Date:   Tue, 25 Aug 2020 12:58:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Message-ID: <1336467655.17779.1598374701401.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51Uwf7+Vs+Mbf=LZxoytFA+3WEtRB5zUanatxgk272MP7Q@mail.gmail.com>
References: <20200811000959.2486636-1-posk@google.com> <20200811062733.GP3982@worktop.programming.kicks-ass.net> <CAFTs51XK0HLwCCvXCcfE5P7a4ExANPNPw7UvNigwHZ8sZVP+nQ@mail.gmail.com> <1003774683.6088.1597257002027.JavaMail.zimbra@efficios.com> <CAFTs51XJhKXn7M2U2dZpFRsTrog4juy=UQfbtcdJfOj5TUSbqQ@mail.gmail.com> <1477195446.6156.1597261492255.JavaMail.zimbra@efficios.com> <CAFTs51Uwf7+Vs+Mbf=LZxoytFA+3WEtRB5zUanatxgk272MP7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: /ve+w4rUgTPRRwn+aSBECFJ4/3Rgfw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Aug 20, 2020, at 1:42 PM, Peter Oskolkov posk@posk.io wrote:

> On Wed, Aug 12, 2020 at 12:44 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
> [...]
>>
>> > One way of doing what you suggest is to allow some commands to be bitwise-ORed.
>> >
>> > So, for example, the user could call
>> >
>> > membarrier(CMD_PRIVATE_EXPEDITED_SYNC_CORE | CMD_PRIVATE_EXPEDITED_RSEQ, cpu_id)
>> >
>> > Is this what you have in mind?
>>
>> Not really. This would not take care of the fact that we would end up
>> multiplying
>> the number of commands as we allow combinations. E.g. if we ever want to have
>> RSEQ
>> work in private and global, and in non-expedited and expedited, we end up
>> needing:
>>
>> - CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
>> - CMD_PRIVATE_EXPEDITED_RSEQ
>> - CMD_PRIVATE_RSEQ
>> - CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ
>> - CMD_GLOBAL_EXPEDITED_RSEQ
>> - CMD_GLOBAL_RSEQ
>>
>> The only thing we would save by OR'ing it with the SYNC_CORE command is the
>> additional
>> list:
>>
>> - CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_SYNC_CORE
>> - CMD_PRIVATE_EXPEDITED_RSEQ_SYNC_CORE
>> - CMD_PRIVATE_RSEQ_SYNC_CORE
>> - CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ_SYNC_CORE
>> - CMD_GLOBAL_EXPEDITED_RSEQ_SYNC_CORE
>> - CMD_GLOBAL_RSEQ_SYNC_CORE
>>
>> But unless we receive feedback that doing a membarrier with RSEQ+sync_core all
>> in
>> one go is a significant use-case, I am tempted to leave out that scenario for
>> now.
>> If we go for new commands, this means we could add (for private-expedited-rseq):
>>
>> - MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ,
>> - MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
>>
>> I do however have use-cases for using RSEQ across shared memory (between
>> processes). Not currently for a rseq-fence, but for rseq acting as per-cpu
>> atomic operations. If I ever end up needing rseq-fence across shared memory,
>> that would result in the following new commands:
>>
>> - MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED_RSEQ,
>> - MEMBARRIER_CMD_GLOBAL_EXPEDITED_RSEQ,
>>
>> The remaining open question is whether it would be OK to define a new
>> membarrier flag=MEMBARRIER_FLAG_CPU, which would expect an additional
>> @cpu parameter.
> 
> Hi  Mathieu,
> 
> I do not think there is any reason to wait for additional feedback, so I believe
> we should finalize the API/ABI.
> 
> I see two issues to resolve:
> 1: how to combine commands:
>  - you do not like adding new commands that are combinations of existing ones;
>  - you do not like ORing.
> => I'm not sure what other options we have here?

Concretely speaking, let's just add a new membarrier command for the use-case
at hand. All other ways of doing things we have discussed are tricky to expose
in a way that is discoverable by user-space through the QUERY command. (using
a flag, or OR'ing many commands together)

> 
> 2: should @flags be repurposed for cpu_id, or MEMBARRIER_FLAG_CPU
>   added with a new syscall parameter.
> => I'm still not sure a new parameter can be cleanly added, but I can try
>   it in the next patchset if you prefer it this way.

Yes please, it's easy to implement and we'll quickly see if anyone yells. If
it turns out to be a bad idea, you can always blame me. ;-)

In summary:

- We add 2 new membarrier commands:
  - MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
  - MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ

- We reserve a membarrier flag:

enum membarrier_flag {
  MEMBARRIER_FLAG_CPU = (1 << 0),
}

So for CMD_PRIVATE_EXPEDITED_RSEQ, if flags & MEMBARRIER_FLAG_CPU is true,
then we expect the additional "int cpu" parameter (3rd parameter). Else the cpu
parameter is unused.

Are you OK with this approach ?

Thanks,

Mathieu

> 
> Please let me know your thoughts.
> 
> Thanks,
> Peter

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
