Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D97E2E77
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 21:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjKFU4q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 15:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjKFU4o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 15:56:44 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE8D7B
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 12:56:41 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1682607eso39816325ad.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 12:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699304201; x=1699909001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=arPwDeCFdRaC5606yGK22eodQyXfqpKFdElw4+wOp+Y=;
        b=ziHh/aIFvo6N6MyxzgNXH375xkB1tWcG5/44kFckWODsyRclFzTa0ua5XlrUwZw+9E
         N0P299UgahHVOJk8//C/BKlpneMw6foUl+DV+KKPnMUrxUKffVwHYW2XJwEwdqsTSn6o
         hRd+NvDO1nV2wrVay+S+M6U0mpVX5uCrbx0aFCvZuVIY6l78swB9jMdh4s94o+R2514k
         zzEJdNlaQyk4rUsJLidfY0Y2uMiynwmnyYOjAiXbDYlBb9aPchZSLAcH7TUf+j9LSwYK
         quNVP0iNH/YHDUJTW2+mN3UPEbUXIc0tBJi+dQ5tKuzFag7JaN6xpsosAxfV/s2w84Bx
         s6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304201; x=1699909001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arPwDeCFdRaC5606yGK22eodQyXfqpKFdElw4+wOp+Y=;
        b=CDQOeRD/At8aQKeu9V9f06Wutwsh93H2nXd7pr7oav+1Jdp4y86uMFebAtF5iNrque
         HpS/w7xcptp8T8COEfqOYHoSkbu+Gm0XAqeLXJoXY5xJHz8w5cijl2e2//ujOrCKjgkK
         dk0NgBJF7Pkyd4nxm5OIlTK6Yjvkije11qo/DqHv6i3OayElX3zj47jATXHDZCin3UoO
         sAkOxVy+FIZ1lMvb7H5JzQtaK7rU+vKTsmnjNOz8vnHpnH4Fc9KyHcBHp9a9U3xiYB33
         BKoS+uhj89ibOfcvGQ0j81Oc67t2fn0NAFByx24AxYkueq+4YPO1HHL7r3Yww9HniauL
         oTuA==
X-Gm-Message-State: AOJu0Yxgg0DOXXTz75j0mmOfB8lQKpumDFcO0GBHCPnLhsIpS7J5T70y
        A0oXfNvaGFoqtdK5TtH8vRZf72I=
X-Google-Smtp-Source: AGHT+IH5YcYILA3SRp5xgCugD4rJNBs/UUciPiEsDuN9TZoTiWvh1fdpijNAL37ojAOMtIu1NnLdA0s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ed42:b0:1cc:446c:7701 with SMTP id
 y2-20020a170902ed4200b001cc446c7701mr419825plb.12.1699304201375; Mon, 06 Nov
 2023 12:56:41 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:56:39 -0800
In-Reply-To: <20231106024413.2801438-10-almasrymina@google.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com> <20231106024413.2801438-10-almasrymina@google.com>
Message-ID: <ZUlTB5diiytEK-Mh@google.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
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

[..]
 
> -	snaplen = skb->len;
> +	snaplen = skb_frags_not_readable(skb) ? skb_headlen(skb) : skb->len;
>  
>  	res = run_filter(skb, sk, snaplen);
>  	if (!res)
> @@ -2279,7 +2279,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		}
>  	}
>  
> -	snaplen = skb->len;
> +	snaplen = skb_frags_not_readable(skb) ? skb_headlen(skb) : skb->len;
>  
>  	res = run_filter(skb, sk, snaplen);
>  	if (!res)

Not sure it covers 100% of bpf. We might need to double-check bpf_xdp_copy_buf
which is having its own, non-skb shinfo and frags. And in general, xdp
can reference those shinfo frags early... (xdp part happens
before we create an skb with all devmem association)
