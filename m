Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D454FC8E3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Apr 2022 01:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiDKXom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 19:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiDKXn7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 19:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF72980C;
        Mon, 11 Apr 2022 16:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A62A617A2;
        Mon, 11 Apr 2022 23:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82F8C385A4;
        Mon, 11 Apr 2022 23:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649720502;
        bh=PEQHj0ABD2UFUuM8DOQbLq2gwBnHLMWNFB0sN3kgmg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2cdcHPkmrB1uUABiGGzKj5AUVYKZ+MrGqU8b1+YzrdEPnwYoDQt+AuCw+oEEad8a
         a3F2rW67FfMynrBxJlqUd+w/uX5JjMdi3/SdEir2LbRohjTBYPFM6qXE1PCVF/STQm
         3SV5ZzT4T+75W3pfMhLbnVz9omHsV7oRdZvMaDwLelS3gW0u+IehHYHfXQlGCkIOex
         U/P+ZKx1StNt+iBEa+Nudcuj7jU4UCIHLfGWH+/yPCqgNacnVe1knYI/MWeykD8sPH
         qA6tzOTyE5ipMR+ZtG4oXvYEzfGA+7ASqX1ccFBcHbR0M7CTaM8d0LL6pNkxEQFfiX
         D4U+cIGJHqM1w==
Date:   Mon, 11 Apr 2022 17:41:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Alexander Lobakin <alobakin@pm.me>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix __get_unaligned_be48() on 32 bit
 platforms
Message-ID: <YlS8swz1QScWdpke@kbusch-mbp.dhcp.thefacebook.com>
References: <20220406233909.529613-1-alobakin@pm.me>
 <20220411195403.230899-1-alobakin@pm.me>
 <32c07164-ae1a-a135-2d1f-3b660cbcf107@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c07164-ae1a-a135-2d1f-3b660cbcf107@acm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 11, 2022 at 02:20:47PM -0700, Bart Van Assche wrote:
> On 4/11/22 13:00, Alexander Lobakin wrote:
> > Uhm, ping?
> 
> What happened with the plan to move this function into the block layer?
> I'm asking this because if that function is moved your patch will conflict
> with the patch that moves that function.

I believe you're thinking of lower_48_bits() instead of this unaligned
accessor. It appears that patch hasn't been picked up yet though, and I am
assuming it should go through block.
