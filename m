Return-Path: <linux-arch+bounces-805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A0380A820
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7572281138
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD23715B;
	Fri,  8 Dec 2023 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjS8h8+0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2101989
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 08:05:36 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b9d009df75so1465529b6e.2
        for <linux-arch@vger.kernel.org>; Fri, 08 Dec 2023 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702051536; x=1702656336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5hzJO8yTOOmWqcY0MuzAVnhi+7X/9ZZXmPHeSk3Rcw=;
        b=XjS8h8+0Z6me/RkQTkZkgWazG13QaKJ0M1GGalcb9UYTUVGOXLnSVgf9jMfr/fhYUk
         7/QKZKSyRKz5dHoEaZmAveim1EMi/OG6AnDtze458ascuU+yF7Vu3mesjaigx2nPxKNH
         QQi8lPRq8Np89Zu0cRFV8TTv0014ynCA/UZ9eTtK7phWXzd/68uyAdE8cxwnszH3e5xo
         CfHce664Wk5G7/HXyn9gnYTh+ELdyTxn9CU+VGN4uaJoPGWJFRqSgHV6eVIBbpOmIHJr
         pgk8yKtomYXNjE3X3a44PL6Bl9tNttonD9HFJUWTGgb1Sm5YevnSgI587l//yscygL3W
         Bv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702051536; x=1702656336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5hzJO8yTOOmWqcY0MuzAVnhi+7X/9ZZXmPHeSk3Rcw=;
        b=YKvADe0A+kaoUmtiHuGdiIGjMf2LKE9LS6W2vnESuhoy9QeFiSF8LYoZqo0jKqBE69
         mwV8T7GUDPmlpbClcvIRiCq9YpodBnemVXxzmJ83K7qwh8cWOHW5HMi3cZu9DgkFVwgK
         Sgp4Xpibw9goz7C8i6QxajcF8TnrYevygWvJm2r0e4zkqO38WfExrJTdtIMuf77uEtek
         p64CcqGEK3n8ztKfrDWL1nCyfLst4MvqOIBdP0aZNcexd8C1LDoAM1XYz8nNtarZ10sR
         T03bSVxxgM7UvYGkwsOSVJJjSO5mtR0q4HUdT6M7Y+BBsCuPqJ9ojqpc/yNMPYVbaO+E
         ageg==
X-Gm-Message-State: AOJu0YylOxrAaPEcSpzCwulZOlArT8REwNG61cNJPmyvXRoDprRmLB3k
	JqCnqZlV+0mA0Zhyl21gF2zuczw7RM5g89GhFW9MvA==
X-Google-Smtp-Source: AGHT+IHGL9I69KlXE84BwGl5GPy9pGIJCFOfAY8CuVMTHvJTVezRqKK9zxZSLL0J2ODaF4dUlwCbTKVYsFtIXkR7BGM=
X-Received: by 2002:a05:6358:60c1:b0:16c:4fe:7bfc with SMTP id
 i1-20020a05635860c100b0016c04fe7bfcmr109970rwi.22.1702051535503; Fri, 08 Dec
 2023 08:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com> <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
In-Reply-To: <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Dec 2023 08:05:22 -0800
Message-ID: <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 1:30=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
>
> As mentioned before, it seems we need to have the above checking every
> time we need to do some per-page handling in page_pool core, is there
> a plan in your mind how to remove those kind of checking in the future?
>

I see 2 ways to remove the checking, both infeasible:

1. Allocate a wrapper struct that pulls out all the fields the page pool ne=
eds:

struct netmem {
        /* common fields */
        refcount_t refcount;
        bool is_pfmemalloc;
        int nid;
        ...
        union {
                struct dmabuf_genpool_chunk_owner *owner;
                struct page * page;
        };
};

The page pool can then not care if the underlying memory is iov or
page. However this introduces significant memory bloat as this struct
needs to be allocated for each page or ppiov, which I imagine is not
acceptable for the upside of removing a few static_branch'd if
statements with no performance cost.

2. Create a unified struct for page and dmabuf memory, which the mm
folks have repeatedly nacked, and I imagine will repeatedly nack in
the future.

So I imagine the special handling of ppiov in some form is critical
and the checking may not be removable.

> Even though a static_branch check is added in page_is_page_pool_iov(), it
> does not make much sense that a core has tow different 'struct' for its
> most basic data.
>
> IMHO, the ppiov for dmabuf is forced fitting into page_pool without much
> design consideration at this point.
>
...
>
> For now, the above may work for the the rx part as it seems that you are
> only enabling rx for dmabuf for now.
>
> What is the plan to enable tx for dmabuf? If it is also intergrated into
> page_pool? There was a attempt to enable page_pool for tx, Eric seemed to
> have some comment about this:
> https://lkml.kernel.org/netdev/2cf4b672-d7dc-db3d-ce90-15b4e91c4005@huawe=
i.com/T/#mb6ab62dc22f38ec621d516259c56dd66353e24a2
>
> If tx is not intergrated into page_pool, do we need to create a new layer=
 for
> the tx dmabuf?
>

I imagine the TX path will reuse page_pool_iov, page_pool_iov_*()
helpers, and page_pool_page_*() helpers, but will not need any core
page_pool changes. This is because the TX path will have to piggyback
on MSG_ZEROCOPY (devmem is not copyable), so no memory allocation from
the page_pool (or otherwise) is needed or possible. RFCv1 had a TX
implementation based on dmabuf pages without page_pool involvement, I
imagine I'll do something similar.

--=20
Thanks,
Mina

