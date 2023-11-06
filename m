Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6787E2C38
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 19:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjKFSoo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 13:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjKFSom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 13:44:42 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60783BB
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 10:44:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afc00161daso55053067b3.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699296277; x=1699901077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=unAu3rVdKljQQL2turiQBdlprjhTErZk5t5fH6+DkH4=;
        b=EBrZgWzb8ptjn5alHcyp6K67Z9HV1e8gx3PBLZVj8KVwDJon61QOiBhbCgCoO4n77y
         eniFWQiSk8Iqp+BuU6iOd9OixJdyeQDUhssJFMkcdy3D1JOjSrvYhoA6/E4sAzYeAaI8
         dOwkG0pucxs42L1gWcxcdN/yPIxvczn8hSai9H+THPyjhVEh3p39SFwRxlSXLxWt26Zk
         sJa2WY2RhLl2USXpSXlDb4oaLG9XEfJ1W6Yibo0XFjkJhJ12Vyh8QKXxXMKfPZ32Q9Db
         79+e9uzVsDLsyVVI/mEwM3aZuMYw5NeNGA6cEPt81ZvrVsSNu6imlIbukhMHKLOe81DF
         o10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296277; x=1699901077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unAu3rVdKljQQL2turiQBdlprjhTErZk5t5fH6+DkH4=;
        b=Xg8J2ICRb6EGN4uLmoUCXxLtJMsjAVQ7QSbRbpbSFVpe+gUU8kSfNN4oV7UiQtld1x
         d2kPja6WTDRbl6srCIXGNx8n6PeQOXo30oIDT2Hce2wtft/y+79q3N0dk7Nj3oXlNXHG
         V6RIRplHiwHv4yYBTShVTbdhtbvkF5zpfnDK3MjTFxbgg6gjdW8nj29Zvdkl+Lnv0YRB
         fVdCf8gw6A65XlfjelfxfNYTaR/Yb1Cma2GhiKFJvklQ3cFQx6RF1XLajfUYwoW3mvfJ
         YJQ24QcDp52EWN7wInR+o+XY76tHgVLhaQKmbuJZCXSdb5nnmagBEot8Zw+YA0sdTRvi
         S25g==
X-Gm-Message-State: AOJu0YzKUQFGPiuLy/5MMlxqLqAMf4k3HIGKlqt/dj/aM3RW6RYDO9p2
        rhEMO+tijnSlm3skTsOY+3ml3iA=
X-Google-Smtp-Source: AGHT+IEPymksCe+J/GlG9UX+jCVEkLe44ItRkLzMmMlfrHbtUb58+EI2rBGvjINzoBfcVB6u0nFDhYI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:7702:0:b0:d9a:6007:223a with SMTP id
 s2-20020a257702000000b00d9a6007223amr558822ybc.8.1699296277518; Mon, 06 Nov
 2023 10:44:37 -0800 (PST)
Date:   Mon, 6 Nov 2023 10:44:36 -0800
In-Reply-To: <20231106024413.2801438-11-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com> <20231106024413.2801438-11-almasrymina@google.com>
Message-ID: <ZUk0FGuJ28s1d9OX@google.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
From:   Stanislav Fomichev <sdf@google.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/05, Mina Almasry wrote:
> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
> 
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
> 
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
> 
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
> 
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> RFC v3:
> - Fixed issue with put_cmsg() failing silently.
> 
> ---
>  include/linux/socket.h            |   1 +
>  include/net/page_pool/helpers.h   |   9 ++
>  include/net/sock.h                |   2 +
>  include/uapi/asm-generic/socket.h |   5 +
>  include/uapi/linux/uio.h          |   6 +
>  net/ipv4/tcp.c                    | 189 +++++++++++++++++++++++++++++-
>  net/ipv4/tcp_ipv4.c               |   7 ++
>  7 files changed, 214 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index cfcb7e2c3813..fe2b9e2081bb 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -326,6 +326,7 @@ struct ucred {
>  					  * plain text and require encryption
>  					  */
>  
> +#define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */

Sharing the feedback that I've been providing internally on the public list:

IMHO, we need a better UAPI to receive the tokens and give them back to
the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
but look dated and hacky :-(

We should either do some kind of user/kernel shared memory queue to
receive/return the tokens (similar to what Jonathan was doing in his
proposal?) or bite the bullet and switch to io_uring.

I was also suggesting to do it via netlink initially, but it's probably
a bit slow for these purpose, idk.
