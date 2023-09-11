Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC08379B3FD
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjIKVGH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjIKMaA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 08:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F04AEE40
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694435349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHwDjcrul9YxmPEcQYx4HYVTPitVbFTJsMO8Jxfoen4=;
        b=cWkDpKIxPxttM0zBFXZVPzxmcZHmHZXAhDtBXKkPgA+TAO4UTC0KtQ5UctOCtzQVH/6vRb
        Esuj90lUWlVfPVgjTpDMQb3SoGuABNebT3wbBb+bbZ6Wwt+az3wcx6XbyhCim5rLzFdZXz
        xwa8Qa1XPPlI/nY1O+Mi+8s1EMGcMeI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-oYS03DeTPSifertlPVEZqw-1; Mon, 11 Sep 2023 08:29:07 -0400
X-MC-Unique: oYS03DeTPSifertlPVEZqw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4011fa32e99so32886205e9.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 05:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694435346; x=1695040146;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHwDjcrul9YxmPEcQYx4HYVTPitVbFTJsMO8Jxfoen4=;
        b=rBZsASQi7f1WJs73OPgI7cQqvNLa96u4N77U9aMWDwsP9n4cA6isZhpqP0MpSM4VlO
         +YEz7KmbjF5Vxr6Nn41JaJMZoBOKcHRT8OpzRR4bMcELDqmq46yMgNoJ+ohrtljcrehc
         GXpJEw/Z1p8eYXN0wOk+zZrB2zLK/8xwi0XVcnBaR2ucoNrX0T7nkPU0cNYzRupAW2Ft
         03nAXKWuAsZZuapiV2kRaOlyJy/jhtpFoXQlDg8JCjTyg1gkjx9lKHHTi3tuKMu1Evt0
         7eGh1baNfncbfNAWXQMjC6UJcAKF+6zX7gDzyMj26tWUukRRjm9JtbcrWtxxE5CnsikF
         +t3A==
X-Gm-Message-State: AOJu0Yx9QqD1BHWKEj1Tk/+M9aIKvgENVhZ6Z8tkTfSlM/k8yZpGThTh
        tCuUcFGcph0ncHbhYzXgQP00KPxYQ4hq+WhRJNx8qCn7Jn2WvhotROCEsBUgd1SwCLPhyjM8HeH
        pSwpOwN8E69dTz7VuDDfXSg==
X-Received: by 2002:a05:600c:2208:b0:3fe:f667:4e4c with SMTP id z8-20020a05600c220800b003fef6674e4cmr8229319wml.12.1694435346278;
        Mon, 11 Sep 2023 05:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0LpLhNizaUMU3zKfHh49aqw4McELTtqbEdG0mSCPhvh4bG6htIZyW8h2QYhMj39he9TwHvA==
X-Received: by 2002:a05:600c:2208:b0:3fe:f667:4e4c with SMTP id z8-20020a05600c220800b003fef6674e4cmr8229290wml.12.1694435345880;
        Mon, 11 Sep 2023 05:29:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003fedcd02e2asm9929615wmf.35.2023.09.11.05.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 05:29:05 -0700 (PDT)
Message-ID: <0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com>
Date:   Mon, 11 Sep 2023 14:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, pcc@google.com,
        steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com> <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
 <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com> <ZOd2LvUKMguWdlgq@arm.com>
 <ZPhfNVWXhabqnknK@monolith> <ZP7/e8YFiosElvTm@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
In-Reply-To: <ZP7/e8YFiosElvTm@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11.09.23 13:52, Catalin Marinas wrote:
> On Wed, Sep 06, 2023 at 12:23:21PM +0100, Alexandru Elisei wrote:
>> On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
>>> On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
>>>> On 24.08.23 13:06, David Hildenbrand wrote:
>>>>> Regarding one complication: "The kernel needs to know where to allocate
>>>>> a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
>>>>> (mprotect()) and the range it is in does not support tagging.",
>>>>> simplified handling would be if it's in a MIGRATE_CMA pageblock, it
>>>>> doesn't support tagging. You have to migrate to a !CMA page (for
>>>>> example, not specifying GFP_MOVABLE as a quick way to achieve that).
>>>>
>>>> Okay, I now realize that this patch set effectively duplicates some CMA
>>>> behavior using a new migrate-type.
> [...]
>> I considered mixing the tag storage memory memory with normal memory and
>> adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
>> this means that it's not enough anymore to have a __GFP_MOVABLE allocation
>> request to use MIGRATE_CMA.
>>
>> I considered two solutions to this problem:
>>
>> 1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
>> this effectively means transforming all memory from MIGRATE_CMA into the
>> MIGRATE_METADATA migratetype that the series introduces. Not very
>> appealing, because that means treating normal memory that is also on the
>> MIGRATE_CMA lists as tagged memory.
> 
> That's indeed not ideal. We could try this if it makes the patches
> significantly simpler, though I'm not so sure.
> 
> Allocating metadata is the easier part as we know the correspondence
> from the tagged pages (32 PROT_MTE page) to the metadata page (1 tag
> storage page), so alloc_contig_range() does this for us. Just adding it
> to the CMA range is sufficient.
> 
> However, making sure that we don't allocate PROT_MTE pages from the
> metadata range is what led us to another migrate type. I guess we could
> achieve something similar with a new zone or a CPU-less NUMA node,

Ideally, no significant core-mm changes to optimize for an architecture 
oddity. That implies, no new zones and no new migratetypes -- unless it 
is unavoidable and you are confident that you can convince core-MM 
people that the use case (giving back 3% of system RAM at max in some 
setups) is worth the trouble.

I also had CPU-less NUMA nodes in mind when thinking about that, but not 
sure how easy it would be to integrate it. If the tag memory has 
actually different performance characteristics as well, a NUMA node 
would be the right choice.

If we could find some way to easily support this either via CMA or 
CPU-less NUMA nodes, that would be much preferable; even if we cannot 
cover each and every future use case right now. I expect some issues 
with CXL+MTE either way , but are happy to be taught otherwise :)


Another thought I had was adding something like CMA memory 
characteristics. Like, asking if a given CMA area/page supports tagging 
(i.e., flag for the CMA area set?)?

When you need memory that supports tagging and have a page that does not 
support tagging (CMA && taggable), simply migrate to !MOVABLE memory 
(eventually we could also try adding !CMA).

Was that discussed and what would be the challenges with that? Page 
migration due to compaction comes to mind, but it might also be easy to 
handle if we can just avoid CMA memory for that.

> though the latter is not guaranteed not to allocate memory from the
> range, only make it less likely. Both these options are less flexible in
> terms of size/alignment/placement.
> 
> Maybe as a quick hack - only allow PROT_MTE from ZONE_NORMAL and
> configure the metadata range in ZONE_MOVABLE but at some point I'd
> expect some CXL-attached memory to support MTE with additional carveout
> reserved.

I have no idea how we could possibly cleanly support memory hotplug in 
virtual environments (virtual DIMMs, virtio-mem) with MTE. In contrast 
to s390x storage keys, the approach that arm64 with MTE took here 
(exposing tag memory to the VM) makes it rather hard and complicated.

-- 
Cheers,

David / dhildenb

