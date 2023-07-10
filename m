Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3397574E210
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 01:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGJXLA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 19:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjGJXK6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 19:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641C10D;
        Mon, 10 Jul 2023 16:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8979C61259;
        Mon, 10 Jul 2023 23:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C7C433C8;
        Mon, 10 Jul 2023 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689030651;
        bh=aM5buVVOq2kRFVuMvF8C3QRzb/ywr1e8PEniwg01lE8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CBmnOE47fPWH6cpLW8yHxaD0ha04n73NeRbdLxSADYxjIGiNcafCDm1fSXGoNM6+d
         Bk2HF9rBYm5ogM3SoTqZTccVuqDdl2Dsm/PirB13/Aeu/CdL8AYE/rwe3f1zvi2uaN
         aNw3aVQVIryJiUNCPq90HlqPCFSpUaRTXahBR3dhuHU8ZwlwD9Pus+Y7k1t8kKPm1Z
         +Xs9+70QFxSYI1UKAyIoJaxdFqjdQZZrgNQ4FPrllNt/OYxmrrDZAnR6Q4sB14+6s2
         cCxtJJxh2Kcd2jFD64jPEBrg3EwMSe7lAjWqI0j9abVn6lE+XrxMFvB/QRimzgN0u4
         rl7Kw58QAlL9Q==
Message-ID: <70d603e5-69c1-20f8-ad0a-e7ef02244cde@kernel.org>
Date:   Mon, 10 Jul 2023 18:10:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 17/36] nios2: Implement the new page table range API
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-18-willy@infradead.org> <ZBGZKTP7BGhvS9Oo@kernel.org>
 <ce464a86-b75e-3488-bab0-cbea1b3e2572@kernel.org>
 <ZKxnqmk3sstOtDZQ@casper.infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <ZKxnqmk3sstOtDZQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/10/23 15:18, Matthew Wilcox wrote:
> On Tue, Jun 13, 2023 at 05:45:54PM -0500, Dinh Nguyen wrote:
>>
>>
>> On 3/15/23 05:08, Mike Rapoport wrote:
>>> On Wed, Mar 15, 2023 at 05:14:25AM +0000, Matthew Wilcox (Oracle) wrote:
>>>> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
>>>> flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
>>>> from being per-page to per-folio.
>>>>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>
>>> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>>
>>
>> Applied!
> 
> Sorry, what?  You can't pick this patch out of the middle of a series
> and apply it!  This needs various earlier patches to work.  And then
> later patches depend on this one having been applied, so if we were to
> go the route of "please arch maintainers apply each of these patches",
> it'd take over a year to get them all in.
> 
> As I said in the cover letter, this will all go in through the mm tree.
> So what I want from arch maintainers is an Acked-by/Reviewed-by/Tested-by,
> and then Andrew will apply the whole set.

Apologies, I realized that after replying.

Dinh
