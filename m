Return-Path: <linux-arch+bounces-5616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BB93B274
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A616285379
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866E158DA9;
	Wed, 24 Jul 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYGJd4Mw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528A613D;
	Wed, 24 Jul 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830313; cv=none; b=iF0ROX+ZoiXBNUXo6Ba4GR6zCU7263721jE3jUhoqnBFf1tFZc1h7iIF0dv9EvY2Roy2+blMF+D1xn/gAGtR+IzFA7hFoAEoWLOBdYGe9fS9d27FtTRnU4pyLTysT45oWL9rJGygEIrPFEp1lprk1hqTRgoWNzpz3SduIe0EQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830313; c=relaxed/simple;
	bh=2VH/lDRbPN4RINJJZ5hFdT7nrCTOneMqyfk6RFrnmxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgoo3/JnMxNTshqbxaduYG0KswXtAHk6yBTqh+KBCK96CpMvO/mvgHUwieEMwKwh7rxYQjJnmL4WSnNAsJbP8gNq86eEgHZCFd9VUN13hqTvDjejdbux7aTGEzKRhNY5jcLddABqvjG/PyeoGoAFVLPW2dejRixTaDA2HsWUk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYGJd4Mw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1710012a12.1;
        Wed, 24 Jul 2024 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721830310; x=1722435110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgUOovEPki3yBEx+HU/YvZISoKa1Q0srqrZyf9xBznA=;
        b=XYGJd4MwHTywVVp5oBH5bu9spsUAnyZ/+z/oKlLODDDYYF4jgqpGMBbuYUFm3JBMYS
         ZV3WcaXSMqY2ZiTCJhH65MGWnci/GTJNFPtK54l0s8azXmxDNi2Y168cKO7B8i4NeGD4
         N7RQtXbXdAnr8b0xGf6+Aa3GHkor083omgSYeIOq4Jgl7hTtmwnoJ26YfRAcQoiDXUXS
         PFEEXRZgZSp7LfRTV2rt6JzW9Yku8TiF02f0vvPgdORWtVd+ftmSTl5LJv3sFHtoxqbx
         ZfRqWh4i49Zw0p0iI8/f8fLmH1hAakwutKwbDplEhl88fmZ6jzmU+jd7Y+sEOCaGaYbB
         O3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830310; x=1722435110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgUOovEPki3yBEx+HU/YvZISoKa1Q0srqrZyf9xBznA=;
        b=sb1Jxx94I+43CwNESYbToMm3YcCf9fdUbh+7nBE7hPsqdri8H5Rx6zhINkQThIHxpG
         bbd5ToJqYY+BQ8fpFRzOkeH0ow41GaGB1jlwO4ogpy8C7k6vz6qDFbPJPLHuSO6GC6P8
         8l+1fP+qah4XCV2xxB10xOjSbF/35d6Dl4WwfJtCcFcnm9uGHi6vOwLSszIM3zCWimPx
         IywRpQxNUtWNI2295sWRNynHlrZzcluIJsmfnEGGcH61SpU3AgOemOREyzHn0/b/RzHN
         mp/cxYHX0Ai9O9j8rlCgrRBF3oLokHySRi27xNp5DZsUKQeWSY3vdPh3B7gQf5enZ5KW
         fJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVDgNCrU1umi43UTA6baTrl4Dk2yGds24bxpjjrktLeEbVZjwoh2QoM8twuNjO8X7GMHsNO/JOK5sFZIeXqc7fYoySk7tD5WtJmpfJxWUg9PkNAOIOanKbmTM0ArYTvgW7D1CJ7CQb02LCFdmtN73SJPNh/LCVg2Z/Y4jmvQyacYH9zMDB461g3gVSM/nIMQnyZBm7l7Fr1ysOgw0ZwyJ7c/ngaIahlXC0yCn1T/A4oNWVQ6ECxWwziPRYToqIvrIQjCBO9js87P57mJnSzdqmswf+5sSzRLL2M0Bq9fmaUTuabejpahy+2XJbwi+cRV5LOft0UOUfam58CwIT+vR8/GAkKW0M/ZPyk/aEMFEeTfJMzxiXUFyClwnEZidCS6dyz+lCM5gxGseKIGc3H4YQtW15pk780a0nwAe5E/Nn7PClCsHKiqgZcKjrIjdt++K+wHXe+6m/3ITlfmdBqupMPZ36JohqX+HzRM6Zjiw==
X-Gm-Message-State: AOJu0Yyg98PnVgrqEgFP+TaVBItjZhrkDJjTX6jWOmucoUd8F0FRZoQw
	dKRHS3v9W3LtMqwUa5caIO7EmBr982dkQAXTq+NNZ3Uli+3nEksmUuT11SJe4NA/52DtUEZ654t
	YHWZmXeZofrlFsB0TY5BefXhgw58=
X-Google-Smtp-Source: AGHT+IG/1TrYzfuz6s4kFpxFSpAieWqNsCB9Wez//cHoFLQxMdVPOa+ue/JHVhn9Ez2PRYWu7hG701fjzbR8kwC+GR4=
X-Received: by 2002:a05:6402:2788:b0:58c:77b4:404b with SMTP id
 4fb4d7f45d1cf-5ab1b167270mr2342309a12.15.1721830310221; Wed, 24 Jul 2024
 07:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-4-almasrymina@google.com> <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
 <CAHS8izNS5jZjPfc-sARbHV7mzqzH+UhHfAtCTKRRTfSAdhY4Cw@mail.gmail.com>
 <CAMArcTUdCxOBYGF3vpbq=eBvqZfnc44KBaQTN7H-wqdUxZdziw@mail.gmail.com> <CAHS8izMTGgZ+4fOKegUDLqAoxrdVEb+nqjQEt8bP0WLBV=FfrQ@mail.gmail.com>
In-Reply-To: <CAHS8izMTGgZ+4fOKegUDLqAoxrdVEb+nqjQEt8bP0WLBV=FfrQ@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 24 Jul 2024 23:11:38 +0900
Message-ID: <CAMArcTUC2q-SEcc4FP8Rnz8goroXj52FWThX4O4C2R1uPW_VHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 6:49=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Jul 9, 2024 at 8:37=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
> ...
> > Reproducer:
> > ./ncdevmem -f <interface name> -l -p 5201 -v 7 -t 0 -q 2 &
> > sleep 10
> > modprobe -rv bnxt_en
> > killall ncdevmem
> >
> > I think it's a devmemTCP core bug so this issue would be reproduced
> > with other drivers.
>
> Sorry for the late reply. I was out at netdev.
>
> I'm also having trouble reproducing this, not because the bug doesn't
> exist, but quirks with my test setup that I need to figure out. AFAICT
> this diff should fix the issue. If you have time to confirm, let me
> know if it doesn't work for you. It should apply on top of v16:
>
> commit 795b8ff01906d ("fix for release issue")
> Author: Mina Almasry <almasrymina@google.com>
> Date:   Tue Jul 23 00:18:23 2024 +0000
>
>     fix for release issue
>
>     Change-Id: Ib45a0aa6cba2918db5f7ba535414ffa860911fa4
>
>
>
> diff --git a/include/net/devmem.h b/include/net/devmem.h
> index 51b25ba193c96..df52526bb516a 100644
> --- a/include/net/devmem.h
> +++ b/include/net/devmem.h
> @@ -68,6 +68,9 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> unsigned int dmabuf_fd);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>                                     struct net_devmem_dmabuf_binding *bin=
ding);
> +
> +void dev_dmabuf_uninstall(struct net_device *dev);
> +
>  struct net_iov *
>  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  void net_devmem_free_dmabuf(struct net_iov *ppiov);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5882ddc3f8592..7be084e4936e4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11320,6 +11320,7 @@ void unregister_netdevice_many_notify(struct
> list_head *head,
>                 dev_tcx_uninstall(dev);
>                 dev_xdp_uninstall(dev);
>                 bpf_dev_bound_netdev_unregister(dev);
> +               dev_dmabuf_uninstall(dev);
>
>                 netdev_offload_xstats_disable_all(dev);
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index e75057ecfa6de..227bcb1070ec0 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -362,4 +362,20 @@ bool mp_dmabuf_devmem_release_page(struct
> page_pool *pool, netmem_ref netmem)
>         return false;
>  }
>
> +void dev_dmabuf_uninstall(struct net_device *dev)
> +{
> +       unsigned int i, count =3D dev->num_rx_queues;
> +       struct net_devmem_dmabuf_binding *binding;
> +       struct netdev_rx_queue *rxq;
> +       unsigned long xa_idx;
> +
> +       for (i =3D 0; i < count; i++) {
> +               binding =3D dev->_rx[i].mp_params.mp_priv;
> +               if (binding)
> +                       xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
> +                               if (rxq =3D=3D &dev->_rx[i])
> +                                       xa_erase(&binding->bound_rxqs, xa=
_idx);
> +       }
> +}
> +
>  #endif
>

I tested this patch and it works well.
Thanks a lot for this work!

Thanks a lot!
Taehee Yoo

> --
> Thanks,
> Mina

