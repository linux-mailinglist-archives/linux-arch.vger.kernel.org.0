Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5987588A9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jul 2023 00:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGRWpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGRWpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 18:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D91993;
        Tue, 18 Jul 2023 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBC8612D2;
        Tue, 18 Jul 2023 22:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73956C433C9;
        Tue, 18 Jul 2023 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689720305;
        bh=QPRDZN417wjG3/qI9dDTrKSyuqoeFrA3S2sudllzHvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I7ocP0MTAirrwG4O3BO3sgJtAZf1AJsUW77twR7BAnv8XpKWfEiykdbxMVfJitMQz
         wsO9R5ARS30sZ610w8glfUqSp2ATk8XKuYDTOzbCrBdafDcnsXZAs1mURzqD6ROGQS
         oC/bzDXWaeXLzVz14Pz2NEZwox6r1Jq4t4LrfLeMLvi2XoFw7Fyi4DlO0VaF4qdICI
         BzPyOlM+XEviMn/WFmV6C00aKMV99Sqm/uyXjIqhbqAEJ8BLdzqi0fVaFTXzBJshI6
         Zs4+zXH8p0XWCVCAu77Oj41p/FZCoid5iSNxgf4LxA128Zmt79ALiEDRVuAms9Zzam
         lCnJHtFJp0Rqg==
Date:   Tue, 18 Jul 2023 15:45:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mina Almasry <almasrymina@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <20230718154503.0421b4cd@kernel.org>
In-Reply-To: <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org>
References: <20230710223304.1174642-1-almasrymina@google.com>
        <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
        <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
        <ZLbUpdNYvyvkD27P@ziepe.ca>
        <20230718111508.6f0b9a83@kernel.org>
        <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
        <20230718112940.2c126677@kernel.org>
        <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Jul 2023 16:35:17 -0600 David Ahern wrote:
> I do not see how 1 RSS context (or more specifically a h/w Rx queue) can
> be used properly with memory from different processes (or dma-buf
> references). When the process dies, that memory needs to be flushed from
> the H/W queues. Queues with interlaced submissions make that more
> complicated.

Agreed, one process, one control path socket.

FWIW the rtnetlink use of netlink is very basic. genetlink already has
some infra which allows associate state with a user socket and cleaning
it up when the socket gets closed. This needs some improvements. A bit
of a chicken and egg problem, I can't make the improvements until there
are families making use of it, and nobody will make use of it until
it's in tree... But the basics are already in place and I can help with
building it out.

> I guess the devil is in the details; I look forward to the evolution of
> the patches.

+1
