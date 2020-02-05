Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727D01530BC
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 13:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgBEM3u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 07:29:50 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:58010 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBEM3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 07:29:50 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1izJoM-000183-TC; Wed, 05 Feb 2020 12:29:43 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1izJoK-0002JU-Q5; Wed, 05 Feb 2020 12:29:42 +0000
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
To:     Octavian Purdila <tavi.purdila@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        Will Deacon <will@kernel.org>,
        Hajime Tazaki <thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
 <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
 <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <a5b6cdbb-2eef-9e84-4ae0-13aad9d1466a@kot-begemot.co.uk>
Date:   Wed, 5 Feb 2020 12:29:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/02/2020 12:24, Octavian Purdila wrote:
> On Wed, Feb 5, 2020 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Feb 05, 2020 at 04:30:10PM +0900, Hajime Tazaki wrote:
>>> From: Octavian Purdila <tavi.purdila@gmail.com>
>>>
>>> With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
>>> are not compiled due to type conflict of atomic64_t defined in
>>> linux/type.h.
>>>
>>> This commit fixes the issue and allow using generic atomic64 ops.
>>>
>>> Currently, LKL is only the user which defines GENERIC_ATOMIC64
>>> (lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
>>> issues before this commit.
>>
>> Uhhhhh, no.
>>
>> Not allowing GENERIC_ATOMIC64 on 64BIT is a *feature*.
>>
>> Any 64bit arch that needs GENERIC_ATOMIC64 is an utter piece of crap.
>>
>> Please explain more.
>>
> 
> Hi Peter,
> 
> I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
> understand your point that a 64 bit architecture that can't handle 64
> bit atomic operation is broken.
> 
> One way to deal with this in LKL would be to use GCC atomic builtins
> or if that doesn't work expose them as host operations. This would
> keep LKL as a meta-arch that can run on multiple physical
> architectures. I'll give it a try.
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


You can lift a set of defines which do that for most compilers/arches 
out of OVS code.

Have a look at lib/ovs-atomic*.h

It should do exactly what you want (+/- cutting it down to things you need).

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
