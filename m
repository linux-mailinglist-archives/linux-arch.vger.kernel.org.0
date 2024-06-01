Return-Path: <linux-arch+bounces-4641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043178D6FEC
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2024 15:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3393B220E1
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B21509AC;
	Sat,  1 Jun 2024 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK+toAIN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99412FB34;
	Sat,  1 Jun 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247351; cv=none; b=R3Q51BL6JEI6Omgp8nwceETtxU83cO/5UMRjnXP5ad0GqG93Zwluz/NgOZKPGJ6Vn1+O8Hhdu/ei8n2nNvJIa5OlGiN6YTFFd+6mWFJWcASHiHTy/56xA9O4o8xaG2z4pYMQrk6bcN2PpIL6Rm+TvgkvqHHBShHpeWAcv+jRGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247351; c=relaxed/simple;
	bh=JeCV8WyWwZWgsRBoBsXvODv76tCrqrpoTPjcXqyhaow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4JE/cPlbdfXEZc7eWNN3ckQSVLOig2VDk4AFk8gaz9q/hj8vLloWO3bTMxvoPR9xx+Q9wW3ffdjgSClrcG6MTScG6PXztxsrJU5ARNj3yqCRq4Dtxl4iaYFAuTJTLtA44gkvYDbYWsmfeyDVljzvmDVDH4qeLdOzDd0OVwNbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK+toAIN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f480624d10so23883935ad.1;
        Sat, 01 Jun 2024 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717247349; x=1717852149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeCV8WyWwZWgsRBoBsXvODv76tCrqrpoTPjcXqyhaow=;
        b=XK+toAINfJVGtTmUD3Soy0vZsJyLB8cubuJe/oohosJE2IaO7hXTeDKjcG9hNos62f
         GJyptL3LNYxldQS3PWjxKnVoONl/DcgWoivTLhiCf8MJwquaGfIx1+g28tsf5TnrcAXt
         fcNA1NdeyxXUHba0NrCYx5W3sUMwNejEysDA/iTRVdVLisVjYmp30WtRwT4k8NipW/ME
         0drREBCxR0emIhka6DiTUPv5kg6pe/qxH+AqefRsu7GY79OKUwy40EaqFaVsapp5AiaI
         V70SSn/KVtxFC8XCcqvioQacmZMftg3asl7k1QEBNqT4rv/DN3rNTxPvYLvAD+tM5+/z
         SXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717247349; x=1717852149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeCV8WyWwZWgsRBoBsXvODv76tCrqrpoTPjcXqyhaow=;
        b=mupf7dbpkqcr2BPc2+heTZBijVidN6ng2Quj0GtUTQZrHwszyit75IbOlH+VFWgmki
         mnqqMvSL5gqqLrl5rOxjNZyPprSryhxaAiCRAiTDSVU3nuGP6gmrmZNr0LOpaoyaQ9nk
         y/Fg+Xoo2R6rVom+Oe5V4zt3lODm23VoPJWDObB1INKnWj+dVJIK85Y7N5mpeIZjs7ph
         ra3jmOcFMeErpagEdOUycLhsgITfVKS9jyCee/GyuEzT89xVQLl7B0Xi/ZhTr+FgB/8u
         ESXlyLnlhKptDbvHfyukGCFdEs+QHAJqUBgMRpvc0P9BqoNdSg4rHH4xFAXUGqZJtt4s
         G3XA==
X-Forwarded-Encrypted: i=1; AJvYcCXsDpo+RVKG33/tJ8B2nSqKJjAo1fE5UyixihAQfJyfstahQQdZ98IgGaSXh/WOPmQfBsG+wUsAE60iAffF1iuw+YNNab4chkoaQwj6KVjshlUVCboxjDqvA/sZAbSNCo42nBsgotRNb1KIqq/Nkwh4e/G32hi6ZSExVMFNJ73SmwzOXyid+ed47S2T0SPJvN8ocQpopjAk7ujPGD44PHD4jF6G9z0Y0GPtZNkglZ8nnBaVtX6UTlDMeo6pgMqBcc26xgeqv9OuVdNxuNNSK3dkvV331S5HTQHByrX4NKwXiRExtdw2O6y6U8nCTXzWVQBnCdhN9xsr8/s66bg+QgpKeEioCh8caFlyCG7XTj2quynZe/1LQ1l5TrwvR9VBK4EJViRtZ68adA1HbkoR9VfCPo8+cr+CQ5WT4I3ycUzaa/RKtakCVdFDV4CSnzWC4RRRsmZSHwLgMKqRB0PwnYK+uYQNFCHPcsK4mcyt6BFgG/GDhNmJngp/kSehLtlKSk2GGmK/Fg==
X-Gm-Message-State: AOJu0YxlpxYMMmDiIQZDSJutOxeVxlxT7Tzqckmx691LsIRcQIFd0xGf
	au+Un04HmZjznlSwpaTdoUJ0bMe/vuOnUpOvOF6lpLCoNjtzTEgl
X-Google-Smtp-Source: AGHT+IFMrqly2po5FAbpY8Ll75+7jqZGxykv2GKZgaeba5l+UFazICmi5KDmbbiaIzRe6tWODUDHbA==
X-Received: by 2002:a17:902:c412:b0:1f6:310b:a3cd with SMTP id d9443c01a7336-1f637018d0dmr55346295ad.20.1717247349084;
        Sat, 01 Jun 2024 06:09:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632338afbsm33014155ad.47.2024.06.01.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:09:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B7AAC186E1EBA; Sat, 01 Jun 2024 20:09:03 +0700 (WIB)
Date: Sat, 1 Jun 2024 20:09:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>, LihaSika <lihasika@gmail.com>
Subject: Re: [PATCH net-next v10 13/14] net: add devmem TCP documentation
Message-ID: <Zlsdb05xe4EnIXmq@archie.me>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-14-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aC8Ai/5tbLCsiak5"
Content-Disposition: inline
In-Reply-To: <20240530201616.1316526-14-almasrymina@google.com>


--aC8Ai/5tbLCsiak5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 08:16:12PM +0000, Mina Almasry wrote:
> Add documentation outlining the usage and details of devmem TCP.
>=20
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--aC8Ai/5tbLCsiak5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZlsdaQAKCRD2uYlJVVFO
o0YSAP9oUIejut2Xeqpj9kDBtkMcGA4Nf4zKVIgKdapDIWoSMAEA/6GrjlpUnXa2
aFvYS6BFsRnMWpsP7c/bQ/LplabX6wM=
=YUa0
-----END PGP SIGNATURE-----

--aC8Ai/5tbLCsiak5--

