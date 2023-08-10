Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1F3777EB4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjHJRBe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHJRBd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 13:01:33 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211EC268E;
        Thu, 10 Aug 2023 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+8cb/lhV+x8UwVjoJQYGCnkcCuUk06gy5cDVFa9lP4Y=; b=hsrqEwj5uFEl/A5N0NsIkOKko7
        VBHWm8seX0TywTYIz6PrrK4tDN+b292bTV8mrnhY9V9o2xntn1fKqNdnx9TfNCnjRf7bW5kNVHpwL
        lTSU5/Icyjn9S1KEQxca+JR/WtQFa1Ifc+UH3LC/DEzrKTtHDpIG5ciNNwrrV37wPVduwRvFMxDFf
        WMwxsAeXae6gquIRGZKoL1wWIBeM5LvnbdvjoOUfvvZEg0NKD+hH5K6TFs7Moe+a9qOEaurTJYWSy
        ItDAauA5HLg82zjn6oOGfImeRSP1QTlzDYJ83GceVZKFr4w3G7hTmHfNSMtLyrUcp8fVHbYOBgFqy
        lVrrCDEA==;
Received: from [191.193.179.209] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qU92L-00Gl8h-Vp; Thu, 10 Aug 2023 19:01:26 +0200
Message-ID: <3bcdb026-8558-43ca-80c1-776216dcd86c@igalia.com>
Date:   Thu, 10 Aug 2023 14:01:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] futex: Add sys_futex_wake()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, tglx@linutronix.de,
        axboe@kernel.dk, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.090897260@infradead.org>
 <071c02ae-a74d-46d8-990b-262264b62caf@igalia.com>
 <20230810121341.GX212435@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230810121341.GX212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Em 10/08/2023 09:13, Peter Zijlstra escreveu:
> On Wed, Aug 09, 2023 at 07:25:19PM -0300, André Almeida wrote:
>> Hi Peter,
>>
>> Em 07/08/2023 09:18, Peter Zijlstra escreveu:
>>> To complement sys_futex_waitv() add sys_futex_wake(). This syscall
>>> implements what was previously known as FUTEX_WAKE_BITSET except it
>>> uses 'unsigned long' for the bitmask and takes FUTEX2 flags.
>>>
>>> The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> ---
>>
>> [...]
>>
>>> +/*
>>> + * sys_futex_wake - Wake a number of futexes
>>> + * @uaddr:	Address of the futex(es) to wake
>>> + * @mask:	bitmask
>>> + * @nr:		Number of the futexes to wake
>>> + * @flags:	FUTEX2 flags
>>> + *
>>> + * Identical to the traditional FUTEX_WAKE_BITSET op, except it is part of the
>>> + * futex2 family of calls.
>>> + */
>>> +
>>> +SYSCALL_DEFINE4(futex_wake,
>>> +		void __user *, uaddr,
>>> +		unsigned long, mask,
>>> +		int, nr,
>>> +		unsigned int, flags)
>>> +{
>>
>> Do you think we could have a
>>
>> 	if (!nr)
>> 		return 0;
>>
>> here? Otherwise, calling futex_wake(&f, 0, flags) will wake 1 futex (if
>> available), which is a strange undocumented behavior in my opinion.
> 
> Oh 'cute' that.. yeah, but how about I put it ...
> 
>>> +	if (flags & ~FUTEX2_VALID_MASK)
>>> +		return -EINVAL;
>>> +
>>> +	flags = futex2_to_flags(flags);
>>> +	if (!futex_flags_valid(flags))
>>> +		return -EINVAL;
>>> +
>>> +	if (!futex_validate_input(flags, mask))
>>> +		return -EINVAL;
> 
> here, because otherwise we get:
> 
> 	sys_futex_wake(&f, 0xFFFF, 0, FUTEX2_SIZE_U8)
> 
> to return 0, even though that is 'obviously' nonsensical and should
> return -EINVAL. Or even garbage flags would be 'accepted'.
> 
> (because 0xFFFF is larger than U8 can accomodate)
> 

That make sense to me, but we would also want to validate the value of 
f, if it's NULL or something strange to return -EINVAL... but this 
happens only inside get_futex_key()...

To make this right, I think we would need to move this verification to 
the syscall validation part:

	if (unlikely((address % sizeof(u32)) != 0))
		return -EINVAL;

	if (unlikely(!access_ok(uaddr, sizeof(u32))))
		return -EFAULT;

And have u32 replaced with the proper size being used.

>>> +
>>> +	return futex_wake(uaddr, flags, nr, mask);
>>> +}
