Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53274043C
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjF0UFe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjF0UFe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 16:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CB211B;
        Tue, 27 Jun 2023 13:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A5C61200;
        Tue, 27 Jun 2023 20:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7059C433C8;
        Tue, 27 Jun 2023 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687896331;
        bh=nxdHwM18qWYe/olgwzu19FISC5RuQmNbEVvkLxl2VBY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZjE+m6TsP7/JcneLIcHUQel0hil1iUviVqfTyM+RmrZXtI/kbVQFRNoD4ArZJbLU5
         4zXDW9VUtIBpTBpsYvBq5PnpEDQDOlXJKhHy+sm7jtZkBQvoQSE1wSsOzbpudlC+Pd
         sL4Mh0jQneg4s31yTcnwH46d5iOXHuw/38OyZqmz/LfqWaBAbJU7kwNjDJPcPN9MhY
         5TVIOZI5hoLTyoGuAsXGQTmXmS3NexTmFkWRmRChTwd7DACRyJXRXzGHrpU99Dq1ux
         qzo4guCFMo24k0Ik6ctKYSpdIkJqigF4j5lDwN6AneeMBgw/flE/ruM58JFYwrciDp
         T1OMj/Q26nvmA==
Message-ID: <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
Date:   Tue, 27 Jun 2023 15:05:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
 <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
 <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/27/23 14:56, Vishal Moola wrote:
> On Tue, Jun 27, 2023 at 12:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/27/23 12:10, Guenter Roeck wrote:
>>> On 6/27/23 10:42, Vishal Moola wrote:
>>>> On Mon, Jun 26, 2023 at 10:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> On Thu, Jun 22, 2023 at 01:57:38PM -0700, Vishal Moola (Oracle) wrote:
>>>>>> Part of the conversions to replace pgtable constructor/destructors with
>>>>>> ptdesc equivalents.
>>>>>>
>>>>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>>>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>>>>
>>>>> This patch causes all nios2 builds to fail.
>>>>
>>>> It looks like you tried to apply this patch on its own. This patch depends
>>>> on patches 01-12 of this patchset to compile properly. I've cross-compiled
>>>> this architecture and it worked, but let me know if something fails
>>>> when its applied on top of those patches (or the rest of the patchset).
>>>
>>>
>>> No, I did not try to apply this patch on its own. I tried to build yesterday's
>>> pending-fixes branch of linux-next.
>>>
>>
>> A quick check shows that the build fails with next-20230627. See log below.
> 
> Ah it looks like this one slipped into -next on its own somehow? Stephen, please
> drop this patch from -next; it shouldn't be in without the rest of the
> patchset which
> I intend to have Andrew take through the mm tree.
> 

I apologize, but I queue this patch up for Linus and it's been pulled 
for this merge window. I didn't realize you were going to take this 
patchset through another tree.

Sorry about that.

Dinh
