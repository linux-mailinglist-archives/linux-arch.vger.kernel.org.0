Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A719769FA0
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGaRmP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGaRmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:42:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD91AD;
        Mon, 31 Jul 2023 10:42:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690825331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uM5FAWSraTF9ANkM/RUmC/VT5LAIL5f6xuNyR6CtXc=;
        b=wLX5xXa3KKs4oWRl7RM9tDekVld4fxYHH+Z0whYiiVmHaDEsEllfAXbyWJphyeg5+HPds/
        nLQlnCCzdLLgEJqjARagiUXRSTyiVtq43iwdHHIvFLhXPkHkGK1+E7zmXcmyRxFZtm35DA
        k6MoXYwE5oRD1yqXJ+zuIBW+mP8s7fNs6piPVn5A6UQml3ALhY8TkBCnuqvxCadSYBHG4g
        Z2E3jdv431oHpf1zA0809fJPbLq3bBOX66prnGyv3XsHoKzdBtwx9eGM1huKHt+/VmvkpN
        7aekZoy8gyMuQKkiAV2XteDD9zY6sac92NBwkWG5DuntmNE/E0h4eEXZALMfAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690825331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6uM5FAWSraTF9ANkM/RUmC/VT5LAIL5f6xuNyR6CtXc=;
        b=0qUHJK4AU408x6a0y+G2L9DA0OvkZEV/pL8k3VSHNHWY2v93IvUv/Q51lk2G4v2dDi11w2
        //lPmALRQigWJ0Dw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <87edkonjrk.ffs@tglx>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org> <87edkonjrk.ffs@tglx>
Date:   Mon, 31 Jul 2023 19:42:11 +0200
Message-ID: <87mszcm0zw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31 2023 at 18:11, Thomas Gleixner wrote:

> On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
>> +#define FUTEX2_8		0x00
>> +#define FUTEX2_16		0x01
>>  #define FUTEX2_32		0x02
>> -			/*	0x04 */
>> +#define FUTEX2_64		0x03
>> +#define FUTEX2_NUMA		0x04
>>  			/*	0x08 */
>>  			/*	0x10 */
>>  			/*	0x20 */
>> --- a/kernel/futex/syscalls.c
>> +++ b/kernel/futex/syscalls.c
>> @@ -183,7 +183,7 @@ SYSCALL_DEFINE6(futex, u32 __user *, uad
>>  	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
>>  }
>>  
>> -#define FUTEX2_MASK (FUTEX2_32 | FUTEX2_PRIVATE)
>> +#define FUTEX2_MASK (FUTEX2_64 | FUTEX2_PRIVATE)
>>  
>>  /**
>>   * futex_parse_waitv - Parse a waitv array from userspace
>> @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
>>  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
>>  			return -EINVAL;
>
> With the above aux.flags with FUTEX2_32 set will result in -EINVAL. I
> don't think that's intentional.

Aargh. This is really nasty to make FUTEX2_64 0x3 and abuse it to test
the flags for validity. Intuitive and obvious is something else.

