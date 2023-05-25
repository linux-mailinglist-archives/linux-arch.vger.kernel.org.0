Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA771041A
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 06:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjEYEna (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 00:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEYEn3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 00:43:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 233DA83;
        Wed, 24 May 2023 21:43:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA3831042;
        Wed, 24 May 2023 21:44:11 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 856FA3F67D;
        Wed, 24 May 2023 21:43:24 -0700 (PDT)
Message-ID: <61ac4856-d7a9-6620-8fb2-47a77191c440@arm.com>
Date:   Thu, 25 May 2023 10:13:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 09/36] arm64: Implement the new page table range API
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-10-willy@infradead.org>
 <592942c0-00dc-0317-0411-f9e17870fb11@arm.com>
 <ZG7edJ+ovIqiULj+@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZG7edJ+ovIqiULj+@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/25/23 09:35, Matthew Wilcox wrote:
> On Thu, May 25, 2023 at 09:05:35AM +0530, Anshuman Khandual wrote:
>>> @@ -127,6 +127,8 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
>>>   */
>>>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>>>  extern void flush_dcache_page(struct page *);
>>> +void flush_dcache_folio(struct folio *);
>>
>> This is giving a checkpatch.pl warning
>>
>> WARNING: function definition argument 'struct folio *' should also have an identifier name
>> #36: FILE: arch/arm64/include/asm/cacheflush.h:130:
>> +void flush_dcache_folio(struct folio *);
> 
> Yes, but checkpatch is *stupid*.  Don't just follow tools blindly.
> How is naming the parameter here helping anyone?

Agreed, it seemed bit weird. Never mind.
