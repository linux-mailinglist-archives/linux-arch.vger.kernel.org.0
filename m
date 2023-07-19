Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3009759931
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jul 2023 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGSPLN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jul 2023 11:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGSPLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jul 2023 11:11:12 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497DC1
        for <linux-arch@vger.kernel.org>; Wed, 19 Jul 2023 08:11:11 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48137084a84so2474560e0c.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Jul 2023 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689779470; x=1690384270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13/AwMP/8TITI/rLzUID1fTbfxpoHhwYclFZUG18RHI=;
        b=W9ugJhbZzcOHBcK1ryGKNlMvfaR4eWFGClQmFa2DEuQjWBhQ6kKehpd1BqB++U5hgw
         3TWXC4fD7TCBkoX1R5UZTE2yJt6ER7ceOa34DwcVaieTCFsfXsMO7ebD1kKBgUVll/il
         T5l+Tk+DvcinG+V75/JSeoIsCFQ8k6ObjIad/1StTlViDKPCllGsT3b32oMukAxIX4KN
         BOqJKyr8il3GkecRMqZu5HqHgWgyu4a5TW8UHq9CwM7tE1s4Y8N0BkYwnbOJf9wDlic2
         T4I8G+BDJNbgq81Uhd6KHKUJLUl1eRoasPEOq2yCOXKm9K6XKz8GISCzVknnORxoJzmR
         xWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689779470; x=1690384270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13/AwMP/8TITI/rLzUID1fTbfxpoHhwYclFZUG18RHI=;
        b=OaxBS2USzRqVL6f3J1b+JIUNEvt8Zk7Urj/uXUqSpCCJyf6/At6Ii7Q74lKQD70Vi/
         rR5LeeF8187NzpQuKpLRRbiQ9R9jgXiAAqHE6psXAPSmLldAsfdoUyvsS0OcZX6BPa2q
         mTIGIFJfOjKeXhNG7gkI+ytaCAE3GgOQG1tJ+J7aWjZMlFsPoZ5l696srWtlhvgbl92M
         pBChPoqQFt87dJxVMuXs2GGDkBFgzNqG7Zf3XAtu5j7DykMbwryZSBHun0foG5I3xkZG
         wTcm9/ct2qes8ShQuzZhtqR/8Niulnc4x/+GAjwOMIfV/GMditnPszW6N2NuUi/uBXFA
         NJvg==
X-Gm-Message-State: ABy/qLZWz/jYBWTY9PzVmCgQNtO4s1Qi/ABCCjiiWjN1HNNExXjQ+tba
        KMnPAjNY9ULRER0RfYc2yzTBUbqqo+0MxNdrORTBdA==
X-Google-Smtp-Source: APBJJlGxQbcOy4ic7AA7A/45OA6HThArnJbsgb00HIZBBJVKBGnUSyKbwhuM+G0qPaAvZZrzdRo6tS+WQiuUsv4/hcs=
X-Received: by 2002:a67:f60d:0:b0:443:5d85:99f3 with SMTP id
 k13-20020a67f60d000000b004435d8599f3mr10644906vso.7.1689779470214; Wed, 19
 Jul 2023 08:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230710223304.1174642-1-almasrymina@google.com>
 <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org> <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
 <ZLbUpdNYvyvkD27P@ziepe.ca> <20230718111508.6f0b9a83@kernel.org>
 <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org> <20230718112940.2c126677@kernel.org>
 <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org> <20230718154503.0421b4cd@kernel.org>
In-Reply-To: <20230718154503.0421b4cd@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Jul 2023 08:10:58 -0700
Message-ID: <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 18, 2023 at 3:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jul 2023 16:35:17 -0600 David Ahern wrote:
> > I do not see how 1 RSS context (or more specifically a h/w Rx queue) ca=
n
> > be used properly with memory from different processes (or dma-buf
> > references).

Right, my experience with dma-bufs from GPUs are that they're
allocated from the userspace and owned by the process that allocated
the backing GPU memory and generated the dma-buf from it. I.e., we're
limited to 1 dma-buf per RX queue. If we enable binding multiple
dma-bufs to the same RX queue, we have a problem, because AFAIU the
NIC can't decide which dma-buf to put the packet into (it hasn't
parsed the packet's destination yet).

> > When the process dies, that memory needs to be flushed from
> > the H/W queues. Queues with interlaced submissions make that more
> > complicated.
>

When the process dies, do we really want to flush the memory from the
hardware queues? The drivers I looked at don't seem to have a function
to flush the rx queues alone, they usually do an entire driver reset
to achieve that. Not sure if that's just convenience or there is some
technical limitation there. Do we really want  to trigger a driver
reset at the event a userspace process crashes?

> Agreed, one process, one control path socket.
>
> FWIW the rtnetlink use of netlink is very basic. genetlink already has
> some infra which allows associate state with a user socket and cleaning
> it up when the socket gets closed. This needs some improvements. A bit
> of a chicken and egg problem, I can't make the improvements until there
> are families making use of it, and nobody will make use of it until
> it's in tree... But the basics are already in place and I can help with
> building it out.
>

I had this approach in mind (which doesn't need netlink improvements)
for the next POC. It's mostly inspired by the comments from the cover
letter of Jakub's memory-provider RFC, if I understood it correctly.
I'm sure there's going to be some iteration, but roughly:

1. A netlink CAP_NET_ADMIN API which binds the dma-buf to any number
of rx queues on 1 NIC. It will do the dma_buf_attach() and
dma_buf_map_attachment() and leave some indicator in the struct
net_device to tell the NIC that it's bound to a dma-buf. The actual
binding doesn't actuate until the next driver reset. The API, I guess,
can cause a driver reset (or just a refill of the rx queues, if you
think that's feasible) as well to streamline things a bit. The API
returns a file handle to the user representing that binding.

2. On the driver reset, the driver notices that its struct net_device
is bound to a dma-buf, and sets up the dma-buf memory-provider instead
of the basic one which provides host memory.

3. The user can close the file handle received in #1 to unbind the
dma-buf from the rx queues. Or if the user crashes, the kernel closes
the handle for us. The unbind doesn't take effect until the next
flushing or rx queues, or the next driver reset (not sure the former
is feasible).

4. The dma-buf memory provider keeps the dma buf mapping alive until
the next driver reset, where all the dma-buf slices are freed, and the
dma buf attachment mapping can be unmapped.

I'm thinking the user sets up RSS and flow steering outside this API
using existing ethtool APIs, but things can be streamlined a bit by
doing some of these RSS/flow steering steps in cohesion with the
dma-buf binding/unbinding. The complication with setting up flow
steering in cohesion with dma-buf bind unbind is that the application
may start more connections after the bind, and it will need to install
flow steering rules for those too, and use the ethtool api for that.
May as well use the ethtool apis for all of it...?

From Jakub and David's comments it sounds (if I understood correctly),
you'd like to tie the dma-buf bind/unbind functions to the lifetime of
a netlink socket, rather than a struct file like I was thinking. That
does sound cleaner, but I'm not sure how. Can you link me to any
existing code examples? Or rough pointers to any existing code?

> > I guess the devil is in the details; I look forward to the evolution of
> > the patches.
>
> +1



--=20
Thanks,
Mina
