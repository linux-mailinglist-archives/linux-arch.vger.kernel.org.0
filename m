Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543D975848F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 20:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGRSVI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jul 2023 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGRSVG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2023 14:21:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22994B6;
        Tue, 18 Jul 2023 11:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4AB0616AF;
        Tue, 18 Jul 2023 18:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53795C433C8;
        Tue, 18 Jul 2023 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689704461;
        bh=3FpetCvZbbcCl2/n3R3+Fi+awrw/7SJjS0am3/4WDVM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pf57YBI319TjSa6UdgcJVOWOTlRAztiD3yo6PD8hehnt65sGwpA1/vT9ljpawxCW5
         fMeHtFOrE123MsPIWNyokLRCZR87Ro5QZoioK+wC06wGF0s00mvFuQQAKz6jQtdH0h
         mbq5e4/ZMJxcbt/7pdjAigRdAHIqMlD/cTA7hyNdzCCkfge9qJSS9TPfANUK/xfNq6
         fL8/Pj/ihkWO/XwAv7J9G983bpRqTTCpKg1dZZrOVg1xFl12oojb3McruJqzldJVb2
         mB5JfoqtrIkLnTjiPwjIfZYf8wvVAxq40FosgtpbIomeKTbQx3WE4Xfrbn/L9dgT/T
         cozltHy/MCSDg==
Message-ID: <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
Date:   Tue, 18 Jul 2023 12:20:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mina Almasry <almasrymina@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230710223304.1174642-1-almasrymina@google.com>
 <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
 <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
 <ZLbUpdNYvyvkD27P@ziepe.ca> <20230718111508.6f0b9a83@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230718111508.6f0b9a83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/18/23 12:15 PM, Jakub Kicinski wrote:
> On Tue, 18 Jul 2023 15:06:29 -0300 Jason Gunthorpe wrote:
>> netlink feels like a weird API choice for that, in particular it would
>> be really wrong to somehow bind the lifecycle of a netlink object to a
>> process.
> 
> Netlink is the right API, life cycle of objects can be easily tied to
> a netlink socket.

That is an untuitive connection -- memory references, h/w queues, flow
steering should be tied to the datapath socket, not a control plane socket.
