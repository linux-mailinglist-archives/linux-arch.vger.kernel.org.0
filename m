Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6215874E1E3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 01:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjGJXIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJXIK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 19:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB6DF9;
        Mon, 10 Jul 2023 16:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2665361244;
        Mon, 10 Jul 2023 23:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D6AC433C8;
        Mon, 10 Jul 2023 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689030488;
        bh=/+/mo50P3YzuhfQUO0wBMnfHSErcc9lar/pMEhlSinw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JHoPuG+lkzkhNmeWotYumgN4znGHxSuxQXbzFb6JLqlmMMnbUFS8EJwVQ3iMiaQ+w
         RhprYrn0fLAr9SCuQteKzaZVzxI0QJ2xkJHWmB8+GB7w0fPd2S2Jpl92md4PPnhf0F
         PTkuFjI7S2l2HfA4wnU45Pimhb9fj1ItbLGTxs0uYUsDdC8GS4gO/TxtskTwjbiYqt
         FKJlMdBhp/DQa4Oan/AqO6tnmGn75Mx1Rg4xhWIQYgXnguecMOTB2l45TerwDCLh6l
         pC4tFdUqO6rIHtttUm9GBIDBxrvMJIvecYAfvl1Mx7XVHndMeCUxQivkdpMtKMVy5Y
         3BF9iVKLUetCw==
Message-ID: <3491974a-b246-1ef7-8198-abb1e7ec101d@kernel.org>
Date:   Mon, 10 Jul 2023 18:08:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 18/38] nios2: Implement the new page table range API
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-19-willy@infradead.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230710204339.3554919-19-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/10/23 15:43, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
> from being per-page to per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> ---
>   arch/nios2/include/asm/cacheflush.h |  6 ++-
>   arch/nios2/include/asm/pgtable.h    | 28 ++++++----
>   arch/nios2/mm/cacheflush.c          | 79 ++++++++++++++++-------------
>   3 files changed, 67 insertions(+), 46 deletions(-)
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
