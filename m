Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5EE7E2E88
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjKFVCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 16:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFVCo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 16:02:44 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0BD78
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 13:02:41 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b62a669d61so3003455a12.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 13:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699304560; x=1699909360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YVT/6GQJuQ7TjvhzDWajYThozSBRZLd2V3VGmhBHao=;
        b=Vv8kFQiunIrTYiM6C/oHgHrTapbPb7JHDyQy8sV+NGrJVj1vpNrYPabj6l1M/3k/pe
         0KSaaQUhg/ZcT1F6kyHn9rRU9tsCGw6mAcPy1W2Muj+zT0GcbkKhL4D8SwhyL48Uj4UZ
         rFF1SSEqPu+xI1Kekzu58oyXrQ4wUJNx/0fMnKc1m487QZyiAIBOoj05pUveCBtBrMxk
         eFetU/y0BG/3cbcuiXHfrCIGHvvDBx7MW7aUUulBj/sRFKx8ycriSAw+tMYWERMHyG1E
         N4TWBgSpWVRrFhtU7AKB35RgNVw2OAXLY9vuE+BX0uGx/b73D3X4to8/XWfcxOmD2Pvf
         dqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304560; x=1699909360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YVT/6GQJuQ7TjvhzDWajYThozSBRZLd2V3VGmhBHao=;
        b=Azy6hakqu1MD+DXr1WSUVr7fgfhvNnVJzcjAHS4S3uX3ikiDYKJnCrb7vBK+x0GiqG
         EJzr/hsn/LtwMBzAdLltwwF+5hmkHZ432/VwlMzKZYLOfWmLd71/B1u5rlUTV64EqFxb
         Zg1taH3Gb198a2uZfYT6/DStbiDWZte+hWWtEoG6WOSfoeiW8rqUKtKulnBEpqq9/MeF
         IlwdXZxHWPSnVPSGozb0Pw1sXNjnc23z143ydzqbDcAKkF6UQD0dZfIWC8izKtSQ8KnB
         EXkWlYtg2k9izAOf8Dc4l33AM0gGE/ba2aPoMYhLMZS1dkd5APuZmxJ7PJRHrw24hHXG
         9CUA==
X-Gm-Message-State: AOJu0YzxHa5Dbd45b4VFm4iO7ubnE4IuP2Ib2hF4Nr1lRGMo+ArrY/+n
        edxMZcFiKCWk1w66NGOK0jtBaAc=
X-Google-Smtp-Source: AGHT+IFMk9K2QPc1yRl8QNToni4u3wTj7lMIW1WMnLhrEu9KTQ1j0Kkg7CJFxK+wf+6qBsS5/cJoFOo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ee14:b0:1ca:b952:f5fa with SMTP id
 z20-20020a170902ee1400b001cab952f5famr509511plb.5.1699304560650; Mon, 06 Nov
 2023 13:02:40 -0800 (PST)
Date:   Mon, 6 Nov 2023 13:02:39 -0800
In-Reply-To: <20231106024413.2801438-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com> <20231106024413.2801438-7-almasrymina@google.com>
Message-ID: <ZUlUb93BFbPBRJFm@google.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory provider
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/05, Mina Almasry wrote:
> Implement a memory provider that allocates dmabuf devmem page_pool_iovs.
> 
> Support of PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV is omitted for
> simplicity.
> 
> The provider receives a reference to the struct netdev_dmabuf_binding
> via the pool->mp_priv pointer. The driver needs to set this pointer for
> the provider in the page_pool_params.
> 
> The provider obtains a reference on the netdev_dmabuf_binding which
> guarantees the binding and the underlying mapping remains alive until
> the provider is destroyed.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/net/page_pool/helpers.h | 40 +++++++++++++++++
>  include/net/page_pool/types.h   | 10 +++++
>  net/core/page_pool.c            | 76 +++++++++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 78cbb040af94..b93243c2a640 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -53,6 +53,7 @@
>  #define _NET_PAGE_POOL_HELPERS_H
>  
>  #include <net/page_pool/types.h>
> +#include <net/net_debug.h>
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
>  int page_pool_ethtool_stats_get_count(void);
> @@ -111,6 +112,45 @@ page_pool_iov_binding(const struct page_pool_iov *ppiov)
>  	return page_pool_iov_owner(ppiov)->binding;
>  }
>  
> +static inline int page_pool_iov_refcount(const struct page_pool_iov *ppiov)
> +{
> +	return refcount_read(&ppiov->refcount);
> +}
> +
> +static inline void page_pool_iov_get_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	refcount_add(count, &ppiov->refcount);
> +}
> +
> +void __page_pool_iov_free(struct page_pool_iov *ppiov);
> +
> +static inline void page_pool_iov_put_many(struct page_pool_iov *ppiov,
> +					  unsigned int count)
> +{
> +	if (!refcount_sub_and_test(count, &ppiov->refcount))
> +		return;
> +
> +	__page_pool_iov_free(ppiov);
> +}
> +
> +/* page pool mm helpers */
> +
> +static inline bool page_is_page_pool_iov(const struct page *page)
> +{
> +	return (unsigned long)page & PP_DEVMEM;
> +}

Speaking of bpf: one thing that might be problematic with this PP_DEVMEM
bit is that it will make debugging with bpftrace a bit (more)
complicated. If somebody were trying to get to that page_pool_iov from
the frags, they will have to do the equivalent of page_is_page_pool_iov,
but probably not a big deal? (thinking out loud)
