Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C371041E
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 06:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEYErA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 00:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEYEq7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 00:46:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7F98B2;
        Wed, 24 May 2023 21:46:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96ECF1042;
        Wed, 24 May 2023 21:47:43 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 848443F67D;
        Wed, 24 May 2023 21:46:56 -0700 (PDT)
Message-ID: <61ee5151-4903-70bf-9f72-fe46123de68d@arm.com>
Date:   Thu, 25 May 2023 10:16:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 29/36] mm: Remove page_mapping_file()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-30-willy@infradead.org>
 <f428a035-4728-1007-e0d5-97988ffe33cc@arm.com>
 <ZG7eKgwn8LHsOn+I@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZG7eKgwn8LHsOn+I@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/25/23 09:33, Matthew Wilcox wrote:
> On Thu, May 25, 2023 at 09:20:47AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
>>> This function has no more users.
>>
>> On v6.4-rc3, there are still some users. Am I looking into a wrong
>> tree/branch/tag ?
> 
> Did you apply patches 1-28 before grepping?

Ahh, my bad. I had applied the generic MM ones and arm64 one to test.
