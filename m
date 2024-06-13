Return-Path: <linux-arch+bounces-4878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4E906704
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 10:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C22284A05
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2024 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE62513F452;
	Thu, 13 Jun 2024 08:36:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3413D523;
	Thu, 13 Jun 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267796; cv=none; b=XgqrWfWk/XX93h5daw2VrEPSJg9MTLgABEoNm/OxxpyWtcP0QqLFAafGCkJf+Tzl680GUPaGQBWcFF659gTIhJH3xTUrI/xQ8gWD828Ag0ZLuAJJTPOLc5bp5BA5S/zyfWU8uupR5VJ9Fn8VmkdWOSRvybRjoHRRBzziMhZhpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267796; c=relaxed/simple;
	bh=a09l5h73FaDd7vlH/86BhnM3rl737CKNI/vH4xhurWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3xYxf9gK6xC3N5Mpz4HeWQCx4Mq7mSpbPgx0IrKmY3bKrG+NpG9iEnvEgBHZaleLt1rz0AsoXeeJ1tb0awTiwCvkyPZb6dmfjPefIWBSIUmRgG2WjtjIZvK0SEiXPxvPDvV4a17DRKwn5MuWtS0Xu2ksJ4J4TigY0A4Ir2bycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="asc'?scan'208";a="207767857"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2024 17:36:22 +0900
Received: from [10.226.93.204] (unknown [10.226.93.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 422B94203313;
	Thu, 13 Jun 2024 17:36:00 +0900 (JST)
Message-ID: <322e7317-61dc-4f1e-8706-7db6f5f7a030@bp.renesas.com>
Date: Thu, 13 Jun 2024 09:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/13] page_pool: convert to use netmem
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-6-almasrymina@google.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240613013557.1169171-6-almasrymina@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2BCbfj48rMDr1Ni41u40ZNJI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2BCbfj48rMDr1Ni41u40ZNJI
Content-Type: multipart/mixed; boundary="------------GGmF9Y2iOanb3ZPuNcD0T337";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Message-ID: <322e7317-61dc-4f1e-8706-7db6f5f7a030@bp.renesas.com>
Subject: Re: [PATCH net-next v12 05/13] page_pool: convert to use netmem
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-6-almasrymina@google.com>
In-Reply-To: <20240613013557.1169171-6-almasrymina@google.com>

--------------GGmF9Y2iOanb3ZPuNcD0T337
Content-Type: multipart/mixed; boundary="------------VLyD3IZiBv1Y2W5pY0JQYGkf"

--------------VLyD3IZiBv1Y2W5pY0JQYGkf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13/06/2024 02:35, Mina Almasry wrote:
> Abstrace the memory type from the page_pool so we can later add support=


s/Abstrace/Abstract/

> for new memory types. Convert the page_pool to use the new netmem type
> abstraction, rather than use struct page directly.
>=20
> As of this patch the netmem type is a no-op abstraction: it's always a
> struct page underneath. All the page pool internals are converted to
> use struct netmem instead of struct page, and the page pool now exports=

> 2 APIs:
>=20
> 1. The existing struct page API.
> 2. The new struct netmem API.
>=20
> Keeping the existing API is transitional; we do not want to refactor al=
l
> the current drivers using the page pool at once.
>=20
> The netmem abstraction is currently a no-op. The page_pool uses
> page_to_netmem() to convert allocated pages to netmem, and uses
> netmem_to_page() to convert the netmem back to pages to pass to mm APIs=
,
>=20
> Follow up patches to this series add non-paged netmem support to the
> page_pool. This change is factored out on its own to limit the code
> churn to this 1 patch, for ease of code review.
>=20
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>=20
> ---
>=20
> v12:
> - Fix allmodconfig build error. Very recently renesas/ravb_main.c added=

>   a dependency on page_pool that I missed in my rebase. The dependency
>   calls page_pool_alloc() directly as it wants to set a custom gfp_mask=
,
>   which is unique as all other drivers call a wrapper to that function.=

>   Fix it by adding netmem_to_page() in the driver.> - Fix printing netm=
em trace printing (Pavel).
>=20
> v11:
> - Fix typing to remove sparse warning. (Paolo/Steven)
>=20
> v9:
> - Fix sparse error (Simon).
>=20
> v8:
> - Fix napi_pp_put_page() taking netmem instead of page to fix
>   patch-by-patch build error.
> - Add net/netmem.h include in this patch to fix patch-by-patch build
>   error.
>=20
> v6:
>=20
> - Rebased on top of the merged netmem_ref type.
>=20
> Cc: linux-mm@kvack.org
> Cc: Matthew Wilcox <willy@infradead.org>
>=20
> ---
>  drivers/net/ethernet/renesas/ravb_main.c |   5 +-
>  include/linux/skbuff_ref.h               |   4 +-
>  include/net/netmem.h                     |  15 ++
>  include/net/page_pool/helpers.h          | 120 ++++++---
>  include/net/page_pool/types.h            |  14 +-
>  include/trace/events/page_pool.h         |  30 +--
>  net/bpf/test_run.c                       |   5 +-
>  net/core/page_pool.c                     | 304 ++++++++++++-----------=

>  net/core/skbuff.c                        |   8 +-
>  9 files changed, 305 insertions(+), 200 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> index c1546b916e4ef..093236ebfeecb 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -303,8 +303,9 @@ ravb_alloc_rx_buffer(struct net_device *ndev, int q=
, u32 entry, gfp_t gfp_mask,
> =20
>  	rx_buff =3D &priv->rx_buffers[q][entry];
>  	size =3D info->rx_buffer_size;
> -	rx_buff->page =3D page_pool_alloc(priv->rx_pool[q], &rx_buff->offset,=

> -					&size, gfp_mask);
> +	rx_buff->page =3D netmem_to_page(page_pool_alloc(priv->rx_pool[q],
> +						       &rx_buff->offset,
> +						       &size, gfp_mask));
>  	if (unlikely(!rx_buff->page)) {
>  		/* We just set the data size to 0 for a failed mapping which
>  		 * should prevent DMA from happening...

[snip]

> =20
> -static inline struct page *page_pool_alloc(struct page_pool *pool,
> -					   unsigned int *offset,
> -					   unsigned int *size, gfp_t gfp)
> +static inline netmem_ref page_pool_alloc(struct page_pool *pool,
> +					 unsigned int *offset,
> +					 unsigned int *size, gfp_t gfp)
>  {
>  	unsigned int max_size =3D PAGE_SIZE << pool->p.order;
> -	struct page *page;
> +	netmem_ref netmem;
> =20
>  	if ((*size << 1) > max_size) {
>  		*size =3D max_size;
>  		*offset =3D 0;
> -		return page_pool_alloc_pages(pool, gfp);
> +		return page_pool_alloc_netmem(pool, gfp);
>  	}
> =20
> -	page =3D page_pool_alloc_frag(pool, offset, *size, gfp);
> -	if (unlikely(!page))
> -		return NULL;
> +	netmem =3D page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
> +	if (unlikely(!netmem))
> +		return 0;
> =20
>  	/* There is very likely not enough space for another fragment, so app=
end
>  	 * the remaining size to the current fragment to avoid truesize
> @@ -140,7 +142,7 @@ static inline struct page *page_pool_alloc(struct p=
age_pool *pool,
>  		pool->frag_offset =3D max_size;
>  	}
> =20
> -	return page;
> +	return netmem;
>  }
> =20
>  /**
> @@ -154,7 +156,7 @@ static inline struct page *page_pool_alloc(struct p=
age_pool *pool,
>   * utilization and performance penalty.
>   *
>   * Return:
> - * Return allocated page or page fragment, otherwise return NULL.
> + * Return allocated page or page fragment, otherwise return 0.
>   */
>  static inline struct page *page_pool_dev_alloc(struct page_pool *pool,=

>  					       unsigned int *offset,
> @@ -162,7 +164,7 @@ static inline struct page *page_pool_dev_alloc(stru=
ct page_pool *pool,
>  {
>  	gfp_t gfp =3D (GFP_ATOMIC | __GFP_NOWARN);
> =20
> -	return page_pool_alloc(pool, offset, size, gfp);
> +	return netmem_to_page(page_pool_alloc(pool, offset, size, gfp));
>  }

I find this API change confusing - why should page_pool_alloc() return a
netmem_ref but page_pool_dev_alloc() return a struct page *?

Is there any reason to change page_pool_alloc() anyway? It calls
page_pool_alloc_pages() or page_pool_alloc_frag() as appropriate, both
of which your patch already converts to wrappers around the appropriate
_netmem() functions. In all instances where page_pool_alloc() is called
in this patch, you wrap it with netmem_to_page() anyway, there are no
calls to page_pool_alloc() added which actually want a netmem_ref.

Thanks,

--=20
Paul Barker
--------------VLyD3IZiBv1Y2W5pY0JQYGkf
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------VLyD3IZiBv1Y2W5pY0JQYGkf--

--------------GGmF9Y2iOanb3ZPuNcD0T337--

--------------2BCbfj48rMDr1Ni41u40ZNJI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZmqvcAUDAAAAAAAKCRDbaV4Vf/JGvUxW
AP4uKbMQBWqrwm4N0a12WI8fJo+BUUCc25C9JJxwln5cIQEAkBtvIuJdTLFRhcetWpSP/iJbKgG5
snTgszJnAOLlDAE=
=U1fu
-----END PGP SIGNATURE-----

--------------2BCbfj48rMDr1Ni41u40ZNJI--

