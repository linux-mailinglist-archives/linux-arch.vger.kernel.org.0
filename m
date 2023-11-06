Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B647E2C43
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 19:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjKFSsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 13:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjKFSsD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 13:48:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6478BB
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 10:47:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daa2684f67eso1467426276.0
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699296478; x=1699901278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfYGvt6skLkznGwiqZd9de4cpoKtWczhZA3SDzBtHOk=;
        b=a0aFkRbtVsZ+9weBVWl18mtKRU+MNbVC2hH62bBUxUtHDLF8FSq+8VWpUzh50tN0wk
         zcP+5Fnk57gItAbOzC7pmbc/7I+oYIwJDh6EbbaY/Flu7JqdQh5fX/JNk3FQx07wO8lT
         QFf99PlNgx2AZo1ntdedlSJEmUkQ9d96Ud3/ZBp61Nj+goZpZwhSoXnEwFfSrkX91KJz
         2UJoMFX5kq5o3wxxtNLJjRhL7Z9zociCvwvVkn92v+Gg7J+wlPsVaAFFYOUF+PHMshFR
         nTB5456B/mD2lLHdWZI9/xylUVcpkmJcm78im/pgB3NL/PbkmUKNuWdljfQJI97Eq06U
         2qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296478; x=1699901278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfYGvt6skLkznGwiqZd9de4cpoKtWczhZA3SDzBtHOk=;
        b=ZfOOmqVMtT5SOEsD97VetmLldxMcCuGbrOapbBLNV2ukACZZy+N0BO0vqZt6cINZhF
         oQTEi/lfNFAoE3e42V6OYI+IdMpkCGNtiWrMgVVWScZXhGPTjxpHgQlhY+x/2sgYjcn1
         k1jVhowq69/Wm7CjojAE1ElHsd+REAfP0zK+XtDWCDSea+wycfN9mbj8BdcG+kCOpMyr
         G7eNczkSmNMxlbyBNNYnt2BZBTfWqE7XANAP3RtxDvQjuYtT2afe1ZPaJuTZdlOs5uSy
         T2yZV3k5QAL0k5yvvI3RBc2+0FKgnhZORn17CEAsHeWRi3i8RS86DNhjawCoBE6srnXt
         o/5A==
X-Gm-Message-State: AOJu0Yz5samWlrt8+U2emcUO2jQTNk2vy7LkOUbgTud26HPvGYzfpFdQ
        qgKoE0HYAKbF6j1ZgUbs79cEBPg=
X-Google-Smtp-Source: AGHT+IGUJ2l90Skjb6Eo4Ej5QS91AxRpSBX/C4tSPBp5d8CEeFQv1G9sZ0kIa3LYlCMauqPUFev8brw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d308:0:b0:da0:c924:4fdc with SMTP id
 e8-20020a25d308000000b00da0c9244fdcmr7631ybf.6.1699296478090; Mon, 06 Nov
 2023 10:47:58 -0800 (PST)
Date:   Mon, 6 Nov 2023 10:47:56 -0800
In-Reply-To: <20231106024413.2801438-10-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com> <20231106024413.2801438-10-almasrymina@google.com>
Message-ID: <ZUk03DhWxV-bOFJL@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
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
> For device memory TCP, we expect the skb headers to be available in host
> memory for access, and we expect the skb frags to be in device memory
> and unaccessible to the host. We expect there to be no mixing and
> matching of device memory frags (unaccessible) with host memory frags
> (accessible) in the same skb.
> 
> Add a skb->devmem flag which indicates whether the frags in this skb
> are device memory frags or not.
> 
> __skb_fill_page_desc() now checks frags added to skbs for page_pool_iovs,
> and marks the skb as skb->devmem accordingly.
> 
> Add checks through the network stack to avoid accessing the frags of
> devmem skbs and avoid coalescing devmem skbs with non devmem skbs.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/linux/skbuff.h | 14 +++++++-
>  include/net/tcp.h      |  5 +--
>  net/core/datagram.c    |  6 ++++
>  net/core/gro.c         |  5 ++-
>  net/core/skbuff.c      | 77 ++++++++++++++++++++++++++++++++++++------
>  net/ipv4/tcp.c         |  6 ++++
>  net/ipv4/tcp_input.c   | 13 +++++--
>  net/ipv4/tcp_output.c  |  5 ++-
>  net/packet/af_packet.c |  4 +--
>  9 files changed, 115 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 1fae276c1353..8fb468ff8115 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
>   *	@csum_level: indicates the number of consecutive checksums found in
>   *		the packet minus one that have been verified as
>   *		CHECKSUM_UNNECESSARY (max 3)
> + *	@devmem: indicates that all the fragments in this skb are backed by
> + *		device memory.
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> @@ -991,7 +993,7 @@ struct sk_buff {
>  #if IS_ENABLED(CONFIG_IP_SCTP)
>  	__u8			csum_not_inet:1;
>  #endif
> -
> +	__u8			devmem:1;
>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>  	__u16			tc_index;	/* traffic control index */
>  #endif
> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
>  		__skb_zcopy_downgrade_managed(skb);
>  }
>  
> +/* Return true if frags in this skb are not readable by the host. */
> +static inline bool skb_frags_not_readable(const struct sk_buff *skb)
> +{
> +	return skb->devmem;

bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_readable'?
It better communicates the fact that the stack shouldn't dereference the
frags (because it has 'devmem' fragments or for some other potential
future reason).
