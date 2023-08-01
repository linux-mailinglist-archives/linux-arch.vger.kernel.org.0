Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49B76A989
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 08:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjHAGxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Aug 2023 02:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHAGxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2023 02:53:10 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8DC1;
        Mon, 31 Jul 2023 23:53:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VonXRf3_1690872783;
Received: from 30.240.106.99(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VonXRf3_1690872783)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 14:53:05 +0800
Message-ID: <dcf5dbff-df95-0b5e-964e-6e55c843d977@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 14:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
 <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
 <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
 <ZMfjmhaqVZyZNNMW@casper.infradead.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <ZMfjmhaqVZyZNNMW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2023/8/1 00:38, Matthew Wilcox wrote:
> On Mon, Jul 31, 2023 at 06:30:22PM +0200, David Hildenbrand wrote:
>> Assume we do do the page table sharing at mmap time, if the flags are right.
>> Let's focus on the most common:
>>
>> mmap(memfd, PROT_READ | PROT_WRITE, MAP_SHARED)
>>
>> And doing the same in each and every process.
> That may be the most common in your usage, but for a database, you're
> looking at two usage scenarios.  Postgres calls mmap() on the database
> file itself so that all processes share the kernel page cache.
> Some Commercial Databases call mmap() on a hugetlbfs file so that all
> processes share the same userspace buffer cache.  Other Commecial
> Databases call shmget() / shmat() with SHM_HUGETLB for the exact
> same reason.
>
> This is why I proposed mshare().  Anyone can use it for anything.

Hi Matthew

I'm a little confused about this mshare(). Which one is the mshare() you 
refer to here, previous mshare() based on filesystem or this RFC v2 
posted by Khalid?

IMHO, they have much difference between previously mshare() and 
MAP_SHARED_PT now.

> We have such a diverse set of users who want to do stuff with shared
> page tables that we should not be tying it to memfd or any other
> filesystem.  Not to mention that it's more flexible; you can map
> individual 4kB files into it and still get page table sharing.
