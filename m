Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9991A769F3C
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjGaRSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjGaRSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:18:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0EC3C2F;
        Mon, 31 Jul 2023 10:16:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690823790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GfWIocfTZiQHj6G3Mhtqo2RpmiVraR74yBaysrJkTOs=;
        b=4Hjb5UWSWPhvFnRfqwvguW8HYeyWkLb7/CcmdubaY+th+qcieNv/eekrVnssRfjQPfbopO
        MCG5+XcndAu+g5VCLp4VLcX7m4Pg6yY19/v3DWNMhBTvGXrJ/fjlmZthAoABcgYZf9ul7P
        YBDOPDek7DGarO2sm+ZT/XG472+hRojiXr5OYeJDKi7vKgyMtwUQIE9h5CqTrIduTtpEBt
        dgepI2gk+xGg1zDaob6+ScqygSC1YkRAEL7IhSAKe0NvkAmdDsVltkgAyXkhHrKDpAgkPR
        xl5LmhbdUA7aU902SGN3jg32VOixRxLSNCrKzptn8aMblO3LKm+bmXyjPDqzRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690823790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GfWIocfTZiQHj6G3Mhtqo2RpmiVraR74yBaysrJkTOs=;
        b=AbsubkRPktsSbvKN5/0NyM/XHjXjQpjPByPzQkNSecLckXI9QGcekkY2CpduxxaB/oL8V3
        SF5GOLvUwdqXhvAw==
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
Date:   Mon, 31 Jul 2023 19:16:29 +0200
Message-ID: <87v8e0m26q.ffs@tglx>
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

Also if you allow 64bit wide futexes, how is that supposed to work with
the existing code, which clearly expects a 32bit uval throughout the
place?

Thanks,

        tglx


