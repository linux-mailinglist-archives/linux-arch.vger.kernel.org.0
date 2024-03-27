Return-Path: <linux-arch+bounces-3220-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C4A88D90B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 09:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCFB1C270AA
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9862D60C;
	Wed, 27 Mar 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVQq5T7D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A32E84F
	for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527991; cv=none; b=GqvBq9gaJkEm1OtbNOG+j62yszbGxrLSFt7n+QI6ElPf8m4hCvbyifRnA0aoPmaI6OyxTKo4KeA0Ied8kexwuLTik0VCdEeBbkf42xz3I32yzcC9VrOqGkuO4Y9boAMYeDPuLhtgdZ8SbDgVf4b5XiRhLN9Am/qcTL4nPh0a1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527991; c=relaxed/simple;
	bh=3C82D8fQzuxMsIpMmROY6tapuBrTCnLxauDtUn+PloY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbl/+Slx6+SeBrHMpuTSeWUmDUF5qbRNG85Gtjzkx4GMi6kZvl+TNhLWOaAPfcmU4WnZPBqC6+nLfSz+DbExZCq2smGG/YYx9jOKISKAcinFzktrNuqK1cu6bVP7cuuDKEiRTrP0wEHy2kmPOOkgSUjvA0zWpHXa42xwVcPg3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVQq5T7D; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44f2d894b7so784057366b.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Mar 2024 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711527986; x=1712132786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpvizSH+ZSaDBljky7qIjMyPhQvjVnrZhS5XW0BMTHM=;
        b=sVQq5T7D8qhYIurL368fsq8pjJxn1X9wmL33PqZSqcfGBahpcOSp6sKwopr8FgBc3z
         MivKZCx+NU/U26mykF88eZmATR9k4ry3MR2j/Ak5vIE2bvR5EhHjD4+MOHZJ8q7EkzJC
         DydphZLh04cO2B7zuOgBYiKUppy/JA4laRekCkh4xWuWus2VN+bm1vsqPTa1lMU70kTS
         Z94bm71w9XjbSd3uo+QhSJGNAU8FDJnIJk2H0uGYNVCi87yX1AfXD7WLO4f06E9GjqZ/
         qJuo3JzGm1uNMHA5KppsoqPBNLS/pWkJOgLeeusyRtbCyT39s1+ilyDRWIm/WQ+zXcof
         M+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527986; x=1712132786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpvizSH+ZSaDBljky7qIjMyPhQvjVnrZhS5XW0BMTHM=;
        b=uQzLmy+OZ3o4HIiTX1pu6DQA36pxNJCOoApDdtx+BCwrYvqzEPcCYsMGZgcA6xby3R
         R6w7c2x44KdISLeMV/tZOSc7CF5v+576VAY4MpDyLOP6taE6eOIxMc3eg7SzvRRgbKiq
         c5AGSNVnyRM5kVFGAaIoatK+1TGKutQyAA/ikBiEyGcvMYAHLqfoLhN/GRc/7LVt/5s6
         g1hNLw6BYaJo8aQIN+Wp3OfbCtj8kA4Cvx1kQ+nF52gfDK6id7RRSyMqdL7GuWzL/A6h
         H7c//bwLHgRj8Hq08yc/gwp79Vn//nwAq9XpNPTcs7QSRYApg3JHLYlUa4LTJzK93WVf
         SSrg==
X-Forwarded-Encrypted: i=1; AJvYcCWTp4NARmcXP69BcLlD5YlmhlrpLUxHms2sS5uf5lgCQSbs/anXKxVwqTPLvnvI09t0TnjKEfP7Zxq0KAcCyvdPXEk1w0KA1PMICg==
X-Gm-Message-State: AOJu0YzBQWtSqV1hCYXv5syN9KKUgRBQhHznGkZ4Mjg5hW2NOvuw73YM
	ib2DpRGKV0cBJcm55yEKcZDe1pQzjac58QUh8CwiftNSr9A4JEQqsTkFLP5j2YQnDAJbZbrWMpW
	/g3bEHUMNk3dX52lrG8EyHlztdBkg+ugIhfZp
X-Google-Smtp-Source: AGHT+IGImKja0cMVGG4Ytxw30THqGP1apyT6MfN65eDTe2m9pqFb33CWRFsiDBl9pNhB+4bc94ErH1NDW6DntKRmkuo=
X-Received: by 2002:a17:906:f2c4:b0:a46:d2eb:1792 with SMTP id
 gz4-20020a170906f2c400b00a46d2eb1792mr3491863ejb.65.1711527986130; Wed, 27
 Mar 2024 01:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326225048.785801-1-almasrymina@google.com> <20240326225048.785801-8-almasrymina@google.com>
In-Reply-To: <20240326225048.785801-8-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 27 Mar 2024 01:26:14 -0700
Message-ID: <CAHS8izMLY_bZhtUy8S5qz+F64qzO40rYa-3z+0xWhXx+2-KfMg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v7 07/14] page_pool: devmem support
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Linux-MM <linux-mm@kvack.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:51=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Convert netmem to be a union of struct page and struct netmem. Overload
> the LSB of struct netmem* to indicate that it's a net_iov, otherwise
> it's a page.
>
> Currently these entries in struct page are rented by the page_pool and
> used exclusively by the net stack:
>
> struct {
>         unsigned long pp_magic;
>         struct page_pool *pp;
>         unsigned long _pp_mapping_pad;
>         unsigned long dma_addr;
>         atomic_long_t pp_ref_count;
> };
>
> Mirror these (and only these) entries into struct net_iov and implement
> netmem helpers that can access these common fields regardless of
> whether the underlying type is page or net_iov.
>
> Implement checks for net_iov in netmem helpers which delegate to mm
> APIs, to ensure net_iov are never passed to the mm stack.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> v7:
> - Remove static_branch_unlikely from netmem_to_net_iov(). We're getting
>   better results from the fast path in bench_page_pool_simple tests
>   without the static_branch_unlikely, and the addition of
>   static_branch_unlikely doesn't improve performance of devmem TCP.
>
>   Additionally only check netmem_to_net_iov() if
>   CONFIG_DMA_SHARED_BUFFER is enabled, otherwise dmabuf net_iovs cannot
>   exist anyway.
>
>   net-next base: 8 cycle fast path.
>   with static_branch_unlikely: 10 cycle fast path.
>   without static_branch_unlikely: 9 cycle fast path.
>   CONFIG_DMA_SHARED_BUFFER disabled: 8 cycle fast path as baseline.
>
>   Performance of devmem TCP is at 95% line rate is regardless of
>   static_branch_unlikely or not.
>
> v6:
> - Rebased on top of the merged netmem_ref type.
> - Rebased on top of the merged skb_pp_frag_ref() changes.
>
> v5:
> - Use netmem instead of page* with LSB set.
> - Use pp_ref_count for refcounting net_iov.
> - Removed many of the custom checks for netmem.
>
> v1:
> - Disable fragmentation support for iov properly.
> - fix napi_pp_put_page() path (Yunsheng).
> - Use pp_frag_count for devmem refcounting.
>
> To: linux-mm@kvack.org

It looks like this tag to add linux-mm did not work as intended. CCing
linux-mm manually.

> Cc: Matthew Wilcox <willy@infradead.org>
>
> ---
>  include/net/netmem.h            | 143 ++++++++++++++++++++++++++++++--
>  include/net/page_pool/helpers.h |  25 +++---
>  include/net/page_pool/types.h   |   1 +
>  net/core/page_pool.c            |  26 +++---
>  net/core/skbuff.c               |  23 +++--
>  5 files changed, 171 insertions(+), 47 deletions(-)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 21f53b29e5fe..74eeaa34883e 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -9,14 +9,51 @@
>  #define _NET_NETMEM_H
>
>  #include <net/devmem.h>
> +#include <net/net_debug.h>
>
>  /* net_iov */
>
> +DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +
> +/*  We overload the LSB of the struct page pointer to indicate whether i=
t's
> + *  a page or net_iov.
> + */
> +#define NET_IOV 0x01UL
> +
>  struct net_iov {
> +       unsigned long __unused_padding;
> +       unsigned long pp_magic;
> +       struct page_pool *pp;
>         struct dmabuf_genpool_chunk_owner *owner;
>         unsigned long dma_addr;
> +       atomic_long_t pp_ref_count;
>  };
>
> +/* These fields in struct page are used by the page_pool and net stack:
> + *
> + *     struct {
> + *             unsigned long pp_magic;
> + *             struct page_pool *pp;
> + *             unsigned long _pp_mapping_pad;
> + *             unsigned long dma_addr;
> + *             atomic_long_t pp_ref_count;
> + *     };
> + *
> + * We mirror the page_pool fields here so the page_pool can access these=
 fields
> + * without worrying whether the underlying fields belong to a page or ne=
t_iov.
> + *
> + * The non-net stack fields of struct page are private to the mm stack a=
nd must
> + * never be mirrored to net_iov.
> + */
> +#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> +       static_assert(offsetof(struct page, pg) =3D=3D \
> +                     offsetof(struct net_iov, iov))
> +NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> +NET_IOV_ASSERT_OFFSET(pp, pp);
> +NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> +NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> +#undef NET_IOV_ASSERT_OFFSET
> +
>  static inline struct dmabuf_genpool_chunk_owner *
>  net_iov_owner(const struct net_iov *niov)
>  {
> @@ -50,7 +87,7 @@ static inline dma_addr_t net_iov_dma_addr(const struct =
net_iov *niov)
>                ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
>  }
>
> -static inline struct netdev_dmabuf_binding *
> +static inline struct net_devmem_dmabuf_binding *
>  net_iov_binding(const struct net_iov *niov)
>  {
>         return net_iov_owner(niov)->binding;
> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
>   */
>  typedef unsigned long __bitwise netmem_ref;
>
> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
> +{
> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
> +       return (__force unsigned long)netmem & NET_IOV;
> +#else
> +       return false;
> +#endif
> +}
> +
>  /* This conversion fails (returns NULL) if the netmem_ref is not struct =
page
>   * backed.
> - *
> - * Currently struct page is the only possible netmem, and this helper ne=
ver
> - * fails.
>   */
>  static inline struct page *netmem_to_page(netmem_ref netmem)
>  {
> +       if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
> +               return NULL;
> +
>         return (__force struct page *)netmem;
>  }
>
> -/* Converting from page to netmem is always safe, because a page can alw=
ays be
> - * a netmem.
> - */
>  static inline netmem_ref page_to_netmem(struct page *page)
>  {
>         return (__force netmem_ref)page;
> @@ -90,17 +133,103 @@ static inline netmem_ref page_to_netmem(struct page=
 *page)
>
>  static inline int netmem_ref_count(netmem_ref netmem)
>  {
> +       /* The non-pp refcount of net_iov is always 1. On net_iov, we onl=
y
> +        * support pp refcounting which uses the pp_ref_count field.
> +        */
> +       if (netmem_is_net_iov(netmem))
> +               return 1;
> +
>         return page_ref_count(netmem_to_page(netmem));
>  }
>
>  static inline unsigned long netmem_to_pfn(netmem_ref netmem)
>  {
> +       if (netmem_is_net_iov(netmem))
> +               return 0;
> +
>         return page_to_pfn(netmem_to_page(netmem));
>  }
>
> +static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> +{
> +       return (struct net_iov *)((__force unsigned long)netmem & ~NET_IO=
V);
> +}
> +
> +static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
> +{
> +       return __netmem_clear_lsb(netmem)->pp_magic;
> +}
> +
> +static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long p=
p_magic)
> +{
> +       __netmem_clear_lsb(netmem)->pp_magic |=3D pp_magic;
> +}
> +
> +static inline void netmem_clear_pp_magic(netmem_ref netmem)
> +{
> +       __netmem_clear_lsb(netmem)->pp_magic =3D 0;
> +}
> +
> +static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
> +{
> +       return __netmem_clear_lsb(netmem)->pp;
> +}
> +
> +static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *po=
ol)
> +{
> +       __netmem_clear_lsb(netmem)->pp =3D pool;
> +}
> +
> +static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
> +{
> +       return __netmem_clear_lsb(netmem)->dma_addr;
> +}
> +
> +static inline void netmem_set_dma_addr(netmem_ref netmem,
> +                                      unsigned long dma_addr)
> +{
> +       __netmem_clear_lsb(netmem)->dma_addr =3D dma_addr;
> +}
> +
> +static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netm=
em)
> +{
> +       return &__netmem_clear_lsb(netmem)->pp_ref_count;
> +}
> +
> +static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
> +{
> +       /* Assume net_iov are on the preferred node without actually
> +        * checking...
> +        *
> +        * This check is only used to check for recycling memory in the p=
age
> +        * pool's fast paths. Currently the only implementation of net_io=
v
> +        * is dmabuf device memory. It's a deliberate decision by the use=
r to
> +        * bind a certain dmabuf to a certain netdev, and the netdev rx q=
ueue
> +        * would not be able to reallocate memory from another dmabuf tha=
t
> +        * exists on the preferred node, so, this check doesn't make much=
 sense
> +        * in this case. Assume all net_iovs can be recycled for now.
> +        */
> +       if (netmem_is_net_iov(netmem))
> +               return true;
> +
> +       return page_to_nid(netmem_to_page(netmem)) =3D=3D pref_nid;
> +}
> +
>  static inline netmem_ref netmem_compound_head(netmem_ref netmem)
>  {
> +       /* niov are never compounded */
> +       if (netmem_is_net_iov(netmem))
> +               return netmem;
> +
>         return page_to_netmem(compound_head(netmem_to_page(netmem)));
>  }
>
> +static inline void *netmem_address(netmem_ref netmem)
> +{
> +       if (netmem_is_net_iov(netmem))
> +               return NULL;
> +
> +       return page_address(netmem_to_page(netmem));
> +}
> +
>  #endif /* _NET_NETMEM_H */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index 61814f91a458..c6a55eddefae 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -215,7 +215,7 @@ inline enum dma_data_direction page_pool_get_dma_dir(=
struct page_pool *pool)
>
>  static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
>  {
> -       atomic_long_set(&netmem_to_page(netmem)->pp_ref_count, nr);
> +       atomic_long_set(netmem_get_pp_ref_count_ref(netmem), nr);
>  }
>
>  /**
> @@ -243,7 +243,7 @@ static inline void page_pool_fragment_page(struct pag=
e *page, long nr)
>
>  static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
>  {
> -       struct page *page =3D netmem_to_page(netmem);
> +       atomic_long_t *pp_ref_count =3D netmem_get_pp_ref_count_ref(netme=
m);
>         long ret;
>
>         /* If nr =3D=3D pp_ref_count then we have cleared all remaining
> @@ -260,19 +260,19 @@ static inline long page_pool_unref_netmem(netmem_re=
f netmem, long nr)
>          * initially, and only overwrite it when the page is partitioned =
into
>          * more than one piece.
>          */
> -       if (atomic_long_read(&page->pp_ref_count) =3D=3D nr) {
> +       if (atomic_long_read(pp_ref_count) =3D=3D nr) {
>                 /* As we have ensured nr is always one for constant case =
using
>                  * the BUILD_BUG_ON(), only need to handle the non-consta=
nt case
>                  * here for pp_ref_count draining, which is a rare case.
>                  */
>                 BUILD_BUG_ON(__builtin_constant_p(nr) && nr !=3D 1);
>                 if (!__builtin_constant_p(nr))
> -                       atomic_long_set(&page->pp_ref_count, 1);
> +                       atomic_long_set(pp_ref_count, 1);
>
>                 return 0;
>         }
>
> -       ret =3D atomic_long_sub_return(nr, &page->pp_ref_count);
> +       ret =3D atomic_long_sub_return(nr, pp_ref_count);
>         WARN_ON(ret < 0);
>
>         /* We are the last user here too, reset pp_ref_count back to 1 to
> @@ -281,7 +281,7 @@ static inline long page_pool_unref_netmem(netmem_ref =
netmem, long nr)
>          * page_pool_unref_page() currently.
>          */
>         if (unlikely(!ret))
> -               atomic_long_set(&page->pp_ref_count, 1);
> +               atomic_long_set(pp_ref_count, 1);
>
>         return ret;
>  }
> @@ -400,9 +400,7 @@ static inline void page_pool_free_va(struct page_pool=
 *pool, void *va,
>
>  static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem=
)
>  {
> -       struct page *page =3D netmem_to_page(netmem);
> -
> -       dma_addr_t ret =3D page->dma_addr;
> +       dma_addr_t ret =3D netmem_get_dma_addr(netmem);
>
>         if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
>                 ret <<=3D PAGE_SHIFT;
> @@ -425,18 +423,17 @@ static inline dma_addr_t page_pool_get_dma_addr(str=
uct page *page)
>  static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
>                                                  dma_addr_t addr)
>  {
> -       struct page *page =3D netmem_to_page(netmem);
> -
>         if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
> -               page->dma_addr =3D addr >> PAGE_SHIFT;
> +               netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
>
>                 /* We assume page alignment to shave off bottom bits,
>                  * if this "compression" doesn't work we need to drop.
>                  */
> -               return addr !=3D (dma_addr_t)page->dma_addr << PAGE_SHIFT=
;
> +               return addr !=3D (dma_addr_t)netmem_get_dma_addr(netmem)
> +                                      << PAGE_SHIFT;
>         }
>
> -       page->dma_addr =3D addr;
> +       netmem_set_dma_addr(netmem, addr);
>         return false;
>  }
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 0d164624f16d..f04af1613f59 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -6,6 +6,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/ptr_ring.h>
>  #include <linux/types.h>
> +#include <net/netmem.h>
>
>  #define PP_FLAG_DMA_MAP                BIT(0) /* Should page_pool do the=
 DMA
>                                         * map/unmap
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index c8125be3a6e2..c7bffd08218b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -25,7 +25,7 @@
>
>  #include "page_pool_priv.h"
>
> -static DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
>
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
> @@ -359,7 +359,7 @@ static noinline netmem_ref page_pool_refill_alloc_cac=
he(struct page_pool *pool)
>                 if (unlikely(!netmem))
>                         break;
>
> -               if (likely(page_to_nid(netmem_to_page(netmem)) =3D=3D pre=
f_nid)) {
> +               if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
>                         pool->alloc.cache[pool->alloc.count++] =3D netmem=
;
>                 } else {
>                         /* NUMA mismatch;
> @@ -446,10 +446,8 @@ static bool page_pool_dma_map(struct page_pool *pool=
, netmem_ref netmem)
>
>  static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref net=
mem)
>  {
> -       struct page *page =3D netmem_to_page(netmem);
> -
> -       page->pp =3D pool;
> -       page->pp_magic |=3D PP_SIGNATURE;
> +       netmem_set_pp(netmem, pool);
> +       netmem_or_pp_magic(netmem, PP_SIGNATURE);
>
>         /* Ensuring all pages have been split into one fragment initially=
:
>          * page_pool_set_pp_info() is only called once for every page whe=
n it
> @@ -464,10 +462,8 @@ static void page_pool_set_pp_info(struct page_pool *=
pool, netmem_ref netmem)
>
>  static void page_pool_clear_pp_info(netmem_ref netmem)
>  {
> -       struct page *page =3D netmem_to_page(netmem);
> -
> -       page->pp_magic =3D 0;
> -       page->pp =3D NULL;
> +       netmem_clear_pp_magic(netmem);
> +       netmem_set_pp(netmem, NULL);
>  }
>
>  static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
> @@ -695,8 +691,9 @@ static bool page_pool_recycle_in_cache(netmem_ref net=
mem,
>
>  static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
>  {
> -       return page_ref_count(netmem_to_page(netmem)) =3D=3D 1 &&
> -              !page_is_pfmemalloc(netmem_to_page(netmem));
> +       return netmem_is_net_iov(netmem) ||
> +              (page_ref_count(netmem_to_page(netmem)) =3D=3D 1 &&
> +               !page_is_pfmemalloc(netmem_to_page(netmem)));
>  }
>
>  /* If the page refcnt =3D=3D 1, this will try to recycle the page.
> @@ -718,7 +715,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_r=
ef netmem,
>          * refcnt =3D=3D 1 means page_pool owns page, and can recycle it.
>          *
>          * page is NOT reusable when allocated when system is under
> -        * some pressure. (page_is_pfmemalloc)
> +        * some pressure. (page_pool_page_is_pfmemalloc)
>          */
>         if (likely(__page_pool_page_can_be_recycled(netmem))) {
>                 /* Read barrier done in page_ref_count / READ_ONCE */
> @@ -734,6 +731,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_r=
ef netmem,
>                 /* Page found as candidate for recycling */
>                 return netmem;
>         }
> +
>         /* Fallback/non-XDP mode: API user have elevated refcnt.
>          *
>          * Many drivers split up the page into fragments, and some
> @@ -928,7 +926,7 @@ static void page_pool_empty_ring(struct page_pool *po=
ol)
>         /* Empty recycle ring */
>         while ((netmem =3D (__force netmem_ref)ptr_ring_consume_bh(&pool-=
>ring))) {
>                 /* Verify the refcnt invariant of cached pages */
> -               if (!(page_ref_count(netmem_to_page(netmem)) =3D=3D 1))
> +               if (!(netmem_ref_count(netmem) =3D=3D 1))
>                         pr_crit("%s() page_pool refcnt %d violation\n",
>                                 __func__, netmem_ref_count(netmem));
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7193ee9737a0..b7e974f0ae51 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -907,9 +907,9 @@ static void skb_clone_fraglist(struct sk_buff *skb)
>                 skb_get(list);
>  }
>
> -static bool is_pp_page(struct page *page)
> +static bool is_pp_netmem(netmem_ref netmem)
>  {
> -       return (page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE;
> +       return (netmem_get_pp_magic(netmem) & ~0x3UL) =3D=3D PP_SIGNATURE=
;
>  }
>
>  int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
> @@ -1007,11 +1007,10 @@ EXPORT_SYMBOL(skb_cow_data_for_xdp);
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
>  bool napi_pp_put_page(netmem_ref netmem, bool napi_safe)
>  {
> -       struct page *page =3D netmem_to_page(netmem);
>         bool allow_direct =3D false;
>         struct page_pool *pp;
>
> -       page =3D compound_head(page);
> +       netmem =3D netmem_compound_head(netmem);
>
>         /* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
>          * in order to preserve any existing bits, such as bit 0 for the
> @@ -1020,10 +1019,10 @@ bool napi_pp_put_page(netmem_ref netmem, bool nap=
i_safe)
>          * and page_is_pfmemalloc() is checked in __page_pool_put_page()
>          * to avoid recycling the pfmemalloc page.
>          */
> -       if (unlikely(!is_pp_page(page)))
> +       if (unlikely(!is_pp_netmem(netmem)))
>                 return false;
>
> -       pp =3D page->pp;
> +       pp =3D netmem_get_pp(netmem);
>
>         /* Allow direct recycle if we have reasons to believe that we are
>          * in the same context as the consumer would run, so there's
> @@ -1044,7 +1043,7 @@ bool napi_pp_put_page(netmem_ref netmem, bool napi_=
safe)
>          * The page will be returned to the pool here regardless of the
>          * 'flipped' fragment being in use or not.
>          */
> -       page_pool_put_full_netmem(pp, page_to_netmem(page), allow_direct)=
;
> +       page_pool_put_full_netmem(pp, netmem, allow_direct);
>
>         return true;
>  }
> @@ -1071,7 +1070,7 @@ static bool skb_pp_recycle(struct sk_buff *skb, voi=
d *data, bool napi_safe)
>  static int skb_pp_frag_ref(struct sk_buff *skb)
>  {
>         struct skb_shared_info *shinfo;
> -       struct page *head_page;
> +       netmem_ref head_netmem;
>         int i;
>
>         if (!skb->pp_recycle)
> @@ -1080,11 +1079,11 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
>         shinfo =3D skb_shinfo(skb);
>
>         for (i =3D 0; i < shinfo->nr_frags; i++) {
> -               head_page =3D compound_head(skb_frag_page(&shinfo->frags[=
i]));
> -               if (likely(is_pp_page(head_page)))
> -                       page_pool_ref_page(head_page);
> +               head_netmem =3D netmem_compound_head(shinfo->frags[i].net=
mem);
> +               if (likely(is_pp_netmem(head_netmem)))
> +                       page_pool_ref_netmem(head_netmem);
>                 else
> -                       page_ref_inc(head_page);
> +                       page_ref_inc(netmem_to_page(head_netmem));
>         }
>         return 0;
>  }
> --
> 2.44.0.396.g6e790dbe36-goog
>


--=20
Thanks,
Mina

