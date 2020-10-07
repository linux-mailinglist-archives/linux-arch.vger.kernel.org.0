Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7034D2861D6
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJGPK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 11:10:29 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:38138 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgJGPK3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 11:10:29 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kQB5F-00031P-Jo; Wed, 07 Oct 2020 15:10:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kQB5D-0001fp-IC; Wed, 07 Oct 2020 16:10:25 +0100
Subject: Re: [RFC v7 18/21] um: host: add utilities functions
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hajime Tazaki <thehajime@gmail.com>,
        linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        retrage01@gmail.com, linux-arch@vger.kernel.org
References: <cover.1601960644.git.thehajime@gmail.com>
 <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
 <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com>
 <6d8dd929722e419894824a07792ac8c5b2659de9.camel@sipsolutions.net>
 <3f0aab8f38971360240e1e04bd6b90a8dcadec86.camel@sipsolutions.net>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <2f3c3a54-7d68-6dc9-a65a-37fb4599b194@cambridgegreys.com>
Date:   Wed, 7 Oct 2020 16:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3f0aab8f38971360240e1e04bd6b90a8dcadec86.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 07/10/2020 16:03, Johannes Berg wrote:
> On Wed, 2020-10-07 at 17:02 +0200, Johannes Berg wrote:
>> On Wed, 2020-10-07 at 15:53 +0100, Anton Ivanov wrote:
>>> These are actually different on different architectures. These look
>>> like the x86 values.
>>>
>>> IMHO a kernel strerror() would be the right way of dealing with this
>>> in the long term (i understand that we cannot call the platform one,
>>> because it may be different from the internal Linux errors). It will
>>> be useful in a lot of other places.
>>>
>>> If we leave it as is, we need to make this arch specific at some
>>> point.
>>>
>>>> +
>>>> +static const char * const lkl_err_strings[] = {
>>>> +	"Success",
>>>> +	"Operation not permitted",
>> Might be possible to more or less address this (except for arch-specific
>> errors that don't always exist) but using C99 initializers?
>>
>> [0] = "Success",
>> [EPERM] = "Operation not permitted",
>> ..
> But, on the other hand, is it needed at all? I don't think the kernel
> ever prints out the actual string ...

I can see the use case for a library in a multi-arch environment (which IMHO is the intended use case). It saves the user the effort of digging into the build and figuring out what does this error mean today :)

It is nice to have :)

If we will have it, however, it should be done as you suggested - C99 or some other way where it maps correctly to actual underlying error codes as they may end up being different depending on build config.

> johannes
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

