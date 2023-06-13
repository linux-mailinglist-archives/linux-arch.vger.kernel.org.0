Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43872EFA0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFMWp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFMWp5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 18:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59CAB5;
        Tue, 13 Jun 2023 15:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4CF63687;
        Tue, 13 Jun 2023 22:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B97C433C0;
        Tue, 13 Jun 2023 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686696355;
        bh=IsAiqctBIMcXl7f74f8xEBeQuYnl2XwOPPSHm+HEdDc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aoxMJHqXhW1hH9q9WjjPa3PDa1Y/WJxK5k2qmXIvnSDL7LgnkPKLh3lDRzKR9cvD6
         OccsASo4ttelM1HG6lSB4Nx5cIWYIeYsckO5ouN7x1eWhgzf+Sl0kGqxwAj3RnYfxz
         gvVf9YiT675gX4yBPtq/G77mKNqHKVvWnDo8Il46JBshLGdZG1hI29SpN4OsPbzFqG
         FxF/1j9OZkk78qLpOJXNFuPLbIR0N2Eig3cEAF6wzjbIW9qyfBFt9BOBcUWwmB8lDx
         i1VD2gT+sucfzLTsnvy0uVTVwHDdAbMAvjOdqWDfiUN+8gWndqlltiUP8/yES17CCr
         U/y1QPLpPM6KQ==
Message-ID: <ce464a86-b75e-3488-bab0-cbea1b3e2572@kernel.org>
Date:   Tue, 13 Jun 2023 17:45:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 17/36] nios2: Implement the new page table range API
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-18-willy@infradead.org> <ZBGZKTP7BGhvS9Oo@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <ZBGZKTP7BGhvS9Oo@kernel.org>
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



On 3/15/23 05:08, Mike Rapoport wrote:
> On Wed, Mar 15, 2023 at 05:14:25AM +0000, Matthew Wilcox (Oracle) wrote:
>> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
>> flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
>> from being per-page to per-folio.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
> 
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> 

Applied!

Thanks,
Dinh
