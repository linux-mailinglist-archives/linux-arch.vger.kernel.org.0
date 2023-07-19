Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525A5759FED
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jul 2023 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGSUhN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jul 2023 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGSUhL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jul 2023 16:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99554171E;
        Wed, 19 Jul 2023 13:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E1A261807;
        Wed, 19 Jul 2023 20:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BE5C433C8;
        Wed, 19 Jul 2023 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799021;
        bh=SL7k8eZ8nRbX0vwXOdVgFN2hRtqQGVAaTbvJqY57BEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BuvyrT061YUMSD8cNtGfuZUYzuxPpFcZw8zFsExRkWlWUhjNMtWkE7mxb2izkRBZ9
         O1WBwZ6bb8drf/uwk8Wa0VszOc7EqWwXPbEuhOssWsbLQP48hw/F10jMiOTwcXPOgD
         EpO9kWXvGYiD9ZFJolRqG+ZSTPWbFE4Ak23jeb1eBfxk7yZCM9F9dl45vayuudNpRz
         3lka10SYYniiqESB1Tx8VVwqa/QrJX4KG7lGdFRY2SN14mLkl0k9oEYjJU+zvtG0Cw
         2AS37/gepyGO5pHewv4AQ8sUuKpeu8scpNrKlFO90A8Nl2c2rIgIuO1PaB2FBj01XT
         CMknK6m3ulovw==
Date:   Wed, 19 Jul 2023 13:36:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20230719133659.5529729e@kernel.org>
In-Reply-To: <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
References: <20230710223304.1174642-1-almasrymina@google.com>
        <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
        <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
        <ZLbUpdNYvyvkD27P@ziepe.ca>
        <20230718111508.6f0b9a83@kernel.org>
        <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
        <20230718112940.2c126677@kernel.org>
        <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org>
        <20230718154503.0421b4cd@kernel.org>
        <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
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

On Wed, 19 Jul 2023 08:10:58 -0700 Mina Almasry wrote:
> From Jakub and David's comments it sounds (if I understood correctly),
> you'd like to tie the dma-buf bind/unbind functions to the lifetime of
> a netlink socket, rather than a struct file like I was thinking. That
> does sound cleaner, but I'm not sure how. Can you link me to any
> existing code examples? Or rough pointers to any existing code?

I don't have a strong preference whether the lifetime is bound to 
the socket or not. My main point was that if we're binding lifetimes
to processes, it should be done via netlink sockets, not special-
-purpose FDs. Inevitably more commands and info will be needed and
we'll start reinventing the uAPI wheel which is Netlink.

Currently adding state to netlink sockets is a bit raw. You can create
an Xarray which stores the per socket state using socket's portid
(genl_info->snd_portid) and use netlink_register_notifier() to get
notifications when sockets are closed.
