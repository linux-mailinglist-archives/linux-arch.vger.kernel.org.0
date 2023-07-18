Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C287584C9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGRS3o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGRS3n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 14:29:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7DF0;
        Tue, 18 Jul 2023 11:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41822616AD;
        Tue, 18 Jul 2023 18:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0789CC433C7;
        Tue, 18 Jul 2023 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689704981;
        bh=mZVev6Chb/FEkhGNNxmMJ4Z4XBKzCjBKm3JCVUTRO9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+I2qLxnV2nwCe87SLiOEw1Jweg0OeZD2j/yRxQDVNt+14Rkac1VIizQXx4i7k1N5
         JJdwT1mpdkgkgjv+Ir/3tfmttDP0b6kit9SFW571v7DByXjGPkrXy8Ykc2SVE+anJm
         3dswwmPZu1wb0OaUflN6gL8hAq2rntRM7gbj42WAHOUFfXQsunJ2AUzJr3XQJjpGZt
         DTC4uKP7RBUU6jrpn+QuQlkeRHQZ5oSsJ9PyggwH7aPORRAfp1blBskG12UY7BpibD
         RfIKKGf+dvfNZ5/X+eVvGF46ewYCWaMr/DK1htsGhNS0jcZe6MOxxl9FBOBiKVdvqK
         Kwj+Z7IDVEvXw==
Date:   Tue, 18 Jul 2023 11:29:40 -0700
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
Message-ID: <20230718112940.2c126677@kernel.org>
In-Reply-To: <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
References: <20230710223304.1174642-1-almasrymina@google.com>
        <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
        <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
        <ZLbUpdNYvyvkD27P@ziepe.ca>
        <20230718111508.6f0b9a83@kernel.org>
        <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Jul 2023 12:20:59 -0600 David Ahern wrote:
> On 7/18/23 12:15 PM, Jakub Kicinski wrote:
> > On Tue, 18 Jul 2023 15:06:29 -0300 Jason Gunthorpe wrote:  
> >> netlink feels like a weird API choice for that, in particular it would
> >> be really wrong to somehow bind the lifecycle of a netlink object to a
> >> process.  
> > 
> > Netlink is the right API, life cycle of objects can be easily tied to
> > a netlink socket.  
> 
> That is an untuitive connection -- memory references, h/w queues, flow
> steering should be tied to the datapath socket, not a control plane socket.

There's one RSS context for may datapath sockets. Plus a lot of the
APIs already exist, and it's more of a question of packaging them up 
at the user space level. For things which do not have an API, however,
netlink, please.
