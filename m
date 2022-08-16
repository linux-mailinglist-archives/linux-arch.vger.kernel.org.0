Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3485596213
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbiHPSLb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbiHPSLP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 14:11:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9DB24940;
        Tue, 16 Aug 2022 11:10:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DC55D4C134E;
        Tue, 16 Aug 2022 18:10:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a314.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E08AA4C25AB;
        Tue, 16 Aug 2022 18:10:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660673441; a=rsa-sha256;
        cv=none;
        b=M0b2IKzrAAOPQITbh7iytw6ce/vPhrfa7pp5GRBFWU1T1NeZPvBtMvvKEXWBMc7Vb+2St6
        QnPLQGnf9zq2LVX8ZE+qD/JEHcnmVPAA7E1KETEt99Hkfg16k3ZR6VBfasEnPH3wly14RS
        FJyPuDfUmT/hauLOkzj6ufT0gRP0lfHYi5umz0ruqO5GmHlnoK//1u9eR/+AJotMyIYcXR
        1nFzL4ghI80JhF/+rg1z9lmuibmuXAhD16Rx6O2AfVfjwuoIm5GqHIOV+2PTOv+Hz53Y08
        sLHJP2qdeuBrepPN1ibi2qRi698CNgWvNn5q13B/1aZcPuxEQMxdhWfMwusTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660673441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=I06/ecHUnT7zHJJuTwo7ZmgJud65PxCU9WXUPwrIBaQ=;
        b=Jc5cJzdkgjrR8AA1cBgaJ7s60oN4UNv0gLEySENW4creNrvZKWfzYlkEtkri7idtY4kS2F
        w/Uep2hurOZRzFTituEadVbugDDfxrI7d6cqBNv9tBKzgm/alOEw8aPOEYMHUM0ldT3cyD
        Eprs8Kh5N7TWe0I6IvIQ798b/trPu8YznwHGhUXwU6nK3bWdkepYDcEaojIcOl0I06ZYGL
        8BDgp0yA+EeeXQo5aXtLIDpT9SYDNvw4G+833jtFJY/XgcKuPqRYEHB07u54sHJjqF1Mml
        Vk2iBGwPTTCf3L0JclrSy1XAW8GBFa0kLGBgqyiUQr4H22awZpkGwDJKxnGGng==
ARC-Authentication-Results: i=1;
        rspamd-7697cc766f-9rx62;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Rock: 02ee42c1152eaacb_1660673441497_3181699394
X-MC-Loop-Signature: 1660673441497:3222038149
X-MC-Ingress-Time: 1660673441497
Received: from pdx1-sub0-mail-a314.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.28.254 (trex/6.7.1);
        Tue, 16 Aug 2022 18:10:41 +0000
Received: from offworld (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a314.dreamhost.com (Postfix) with ESMTPSA id 4M6fMg1vT2zF1;
        Tue, 16 Aug 2022 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1660673440;
        bh=I06/ecHUnT7zHJJuTwo7ZmgJud65PxCU9WXUPwrIBaQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=VbXvJHvNVTgML/Vi2Xzn9FVbgGkc7dXYyKl1bUJv0Ja4nIaHHN3gzyVfyhk+zwJ5B
         TD/Q49GkQIumI6/TXj6i85nLbJipITDDOitrbVF5YvIDO7C+z1hhfdBLYW1ilhIZUO
         +HtNsN4hBOgoagNOtsGaDOp5pVqv66Y2g6wMILpTY04oC+R9Plh6JfdTPgiE/pgJSW
         1Ly6s88hI95jSQ2gb/NMM9w5vqJCgFfk37lKd7meKs430vKwr50QrTnf8IgJCl4GZL
         mEl5SjC0Zcg7ZhW1FTbirTL+KPuc2CLssRW1LCk9qstOU5Zpan3DfkE8vrvl5llHXO
         k+s6laKDg1ZcQ==
Date:   Tue, 16 Aug 2022 10:52:59 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <20220816175259.o5h5wv23rs2bvcu6@offworld>
References: <4bedc81d-62fa-7091-029e-a2e56b4f8f7a@intel.com>
 <20220803183729.00002183@huawei.com>
 <9f3705e1-de21-0f3c-12af-fd011b6d613d@intel.com>
 <YvO8pP7NUOdH17MM@FVFF77S0Q05N>
 <62f40fba338af_3ce6829466@dwillia2-xfh.jf.intel.com.notmuch>
 <20220815160706.tqd42dv24tgb7x7y@offworld>
 <Yvtc2u1J/qip8za9@worktop.programming.kicks-ass.net>
 <62fbcae511ec1_dfbc129453@dwillia2-xfh.jf.intel.com.notmuch>
 <20220816165301.4m4w6zsse62z4hxz@offworld>
 <CAA9_cmfBubQe6EGk5+wjotvofZavfjFud-JMPW13Au0gpAcWog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAA9_cmfBubQe6EGk5+wjotvofZavfjFud-JMPW13Au0gpAcWog@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 16 Aug 2022, Dan Williams wrote:

>On Tue, Aug 16, 2022 at 10:30 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> On Tue, 16 Aug 2022, Dan Williams wrote:
>>
>> >Peter Zijlstra wrote:
>> >> On Mon, Aug 15, 2022 at 09:07:06AM -0700, Davidlohr Bueso wrote:
>> >> > diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
>> >> > index b192d917a6d0..ce2ec9556093 100644
>> >> > --- a/arch/x86/include/asm/cacheflush.h
>> >> > +++ b/arch/x86/include/asm/cacheflush.h
>> >> > @@ -10,4 +10,7 @@
>> >> >
>> >> >  void clflush_cache_range(void *addr, unsigned int size);
>> >> >
>> >> > +#define flush_all_caches() \
>> >> > +  do { wbinvd_on_all_cpus(); } while(0)
>> >> > +
>> >>
>> >> This is horrific... we've done our utmost best to remove all WBINVD
>> >> usage and here you're adding it back in the most horrible form possible
>> >> ?!?
>> >>
>> >> Please don't do this, do *NOT* use WBINVD.
>> >
>> >Unfortunately there are a few good options here, and the changelog did
>> >not make clear that this is continuing legacy [1], not adding new wbinvd
>> >usage.
>>
>> While I was hoping that it was obvious from the intel.c changes that this
>> was not a new wbinvd, I can certainly improve the changelog with the below.
>
>I also think this cache_flush_region() API wants a prominent comment
>clarifying the limited applicability of this API. I.e. that it is not
>for general purpose usage, not for VMs, and only for select bare metal
>scenarios that instantaneously invalidate wide swaths of memory.
>Otherwise, I can now see how this looks like a potentially scary
>expansion of the usage of wbinvd.

Sure.

Also, in the future we might be able to bypass this hammer in the presence
of persistent cpu caches.

Thanks,
Davidlohr
