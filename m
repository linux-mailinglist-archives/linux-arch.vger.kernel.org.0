Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4659EA54
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiHWRyH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 13:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiHWRxq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 13:53:46 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653F697D6D;
        Tue, 23 Aug 2022 08:55:44 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9A5F341429;
        Tue, 23 Aug 2022 15:55:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7483F413B4;
        Tue, 23 Aug 2022 15:55:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661270142; a=rsa-sha256;
        cv=none;
        b=tWR7zJlwpdUe1PgWnq6tGe7di1qRVc4HEbWWjF9BbbgmXVDhB3mQ7uAml9+lCU0AZBwXUV
        Ee9cr5+GaDbYNTX3sjibJa4a0pj/CWujyIdl+VWoP3tdYsaTNBQn2cT6aTVt/h4Jmomzk/
        OJOX9vCyUhIR4nXrCYvUjB70GJqDkbw7fu+KGfYuePo90srhwv4LPbiHaJ/JBRZRTt+sii
        ZX6wTDRmelmNJUM9luCsixVBBrpUJhJWzFu+DmkqYRoy3jk56uL7g0rvPF4ew4NOLp8q+u
        UgbITHPEN7XXjBdWWlMI+CEYturIKOOQWdfSi4cg6xdC4NhK2KAuCfKOy+ntuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661270142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lZKDSV+E7ynTWKLviZO84iPiu4MCUkKGwpEEhIkNJco=;
        b=eoF5ry1FFWCjnKXIGVzlVwbL4CU4shaCoRDjE6+U2Bzk2eXPzcvxjeS9BrJouH1nPkIpVv
        J/90A5gBM6RUaTu+EMU3fbqqkr74BXAvDxmUvlt8zqPIyt9FDrsswcD3FCTpqNfs5qpDKu
        7vRW0uGJZnJV3MJZrLnsdj/gQBXt2309hcemfIseYICAv7DwMGD+pWcYwUAkmFKJp0RPsM
        OOxhOg3Ml1fsblkYxKvPGHR9Ste+IwmYEBe3A6yJ1ObKVigrxPujUg4il7tjH3MKIyc24I
        k16BpA+grlDrVr8BQc0z+6OwCbNmyMEepA7QqYSgGm/4Ccnc1SHQMY7R0GiEYA==
ARC-Authentication-Results: i=1;
        rspamd-76867cc9c5-7stgk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Absorbed: 39b91e9b7ba72029_1661270143073_3004066132
X-MC-Loop-Signature: 1661270143073:1865492383
X-MC-Ingress-Time: 1661270143073
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.219.74 (trex/6.7.1);
        Tue, 23 Aug 2022 15:55:43 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4MBv2h0t2wz21r;
        Tue, 23 Aug 2022 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661270142;
        bh=lZKDSV+E7ynTWKLviZO84iPiu4MCUkKGwpEEhIkNJco=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=AJHGVfu94PFauay51fxeIvfa82iJjBJ3Yl1oV40HVgqJ0PaUowcNGg2GAbQ+4AfvA
         HnL3rOP/06HODh1QuLx+WXdBXbjrO2vZS737xpfDIfPxvwCLvSGhXeZHlbRW3yobAE
         6vSWmwQk4jvIT//iTzZg2AdcaENs6Rl4uayWc38ub416cLlRnSLXfoisaomJCePK3h
         VUWlkp0hZRlgmwQodhNVAR7EBYMQ+q2KV9E1lcK3cvVrzDhPkKD1cmDD17r6EDrjZG
         cOg2EvjsLeQy0460/0R6o2VkKVWVYFRPB5oI/Jy7lG6zj5YJzW/hi5fZGCUjkbz0kx
         5+p3U+uDwZ5+w==
Date:   Tue, 23 Aug 2022 08:37:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        ira.weiny@intel.com, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/cacheflush: Introduce flush_all_caches()
Message-ID: <20220823153737.7p7lpkqsu4otraxh@offworld>
References: <20220819171024.1766857-1-dave@stgolabs.net>
 <YwMkUMiKf3ZyMDDF@infradead.org>
 <20220822133736.roxmpj6sfo6gsij2@offworld>
 <6303c7f4bb650_1b322947f@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6303c7f4bb650_1b322947f@dwillia2-xfh.jf.intel.com.notmuch>
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

On Mon, 22 Aug 2022, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> On Sun, 21 Aug 2022, Christoph Hellwig wrote:
>>
>> >On Fri, Aug 19, 2022 at 10:10:24AM -0700, Davidlohr Bueso wrote:
>> >> index b192d917a6d0..ac4d4fd4e508 100644
>> >> --- a/arch/x86/include/asm/cacheflush.h
>> >> +++ b/arch/x86/include/asm/cacheflush.h
>> >> @@ -10,4 +10,8 @@
>> >>
>> >>  void clflush_cache_range(void *addr, unsigned int size);
>> >>
>> >> +/* see comments in the stub version */
>> >> +#define flush_all_caches() \
>> >> +	do { wbinvd_on_all_cpus(); } while(0)
>> >
>> >Yikes.  This is just a horrible, horrible name and placement for a bad
>> >hack that should have no generic relevance.
>>
>> Why does this have no generic relevance? There's already been discussions
>> on how much wbinv is hated[0].
>>
>> >Please fix up the naming to make it clear that this function is for a
>> >very specific nvdimm use case, and move it to a nvdimm-specific header
>> >file.
>>
>> Do you have any suggestions for a name? And, as the changelog describes,
>> this is not nvdimm specific anymore, and the whole point of all this is
>> volatile memory components for cxl, hence nvdimm namespace is bogus.
>>
>> [0] https://lore.kernel.org/all/Yvtc2u1J%2Fqip8za9@worktop.programming.kicks-ass.net/
>
>While it is not nvdimm specific anymore, it's still specific to "memory
>devices that can bulk invalidate a physical address space". I.e. it's
>not as generic as its location in arch/x86/include/asm/cacheflush.h
>would imply. So, similar to arch_invalidate_pmem(), lets keep it in a
>device-driver-specific header file, because hch and peterz are right, we
>need to make this much more clear that it is not for general
>consumption.

Fine, I won't argue - although I don't particularly agree, at least wrt
the naming. Imo my naming does _exactly_ what it should do and is much
easier to read than arch_has_flush_memregion() which is counter intuitive
when we are in fact flushing everything. This does not either make it
any more clearer about virt vs physical mappings either (except that
it's no longer associated to cacheflush). But, excepting arm cacheflush.h's
rare arch with braino cache users get way too much credit in their namespace
usage.

But yes there is no doubt that my version is more inviting than it should be,
which made me think of naming it to flush_all_caches_careful() so the user
is forced to at least check the function (or one would hope).

Anyway, I'll send a new version based on the below - I particularly agree
with the hypervisor bits.

Thanks,
Davidlohr
