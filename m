Return-Path: <linux-arch+bounces-4165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD708BAD46
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12536281F46
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997D15383F;
	Fri,  3 May 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcauIy26"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8215358B;
	Fri,  3 May 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742048; cv=none; b=fiybGIh0WBX0bRyQbxo1cmcVUgNJHxr+k75ANuGHDk7iViQo5jyd9Q6VeK6GWx6FMp/X6iQHEJ29nrS+Rit93+fzbE2maVHDlpq6VCQpn0aRopoj3twk51aNaYw2Ko0a3WblSn8rScpgxO9MGX4pt9OE7oWy+nF+rM0m2zVKjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742048; c=relaxed/simple;
	bh=emDrdx6WOkQnF2Eso3DR0P187wYGRr+WTfcYUP8aUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFXxjxIXve9tB75TqzA1vNN7p1ZU5NDyFqcopoA0UUVfvFh1JS/nMk3ot7qef24ngbQ2n4pmTs+DAMMeRmnMpMzJeVPMb6hApDjw+5Kkz/K+wFS/+9iHnupJ9J3qE+gTXxDy7nljRkmNzUGN9Vz3vgKH6DzhoQSrEPGwoTNjwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcauIy26; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f44ed6e82fso314106b3a.3;
        Fri, 03 May 2024 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714742046; x=1715346846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6Kz22nN7XZpw5/QYn8eU3Vl5d2ZzmTa9J6l4Ufw1zs=;
        b=gcauIy26MtzJYA8Gns6kXZilBsGTzVoH5HBE70noznhGOD4euDnekA10A01JhJPaLO
         3g/gVlbyt0HrO4AS2vlEUGm9fP40LfNNZhe05qHmQQDDTXbdlsjL6mGTAhieH0jEnWuf
         2UXYKRmnjAejy9goG3wES6Ad1+iG+/facnZgyyouKsCRo2hXWbGOu9VtEEfnnefyPTSW
         7iMwwes0uuOIIV/vYUUhSG5tqOsagJyJGfgu3ygTA3yLrrmBgMDFctfaUxslbfdu6TXe
         7IgKNvm5WAWO0WLGUO0ftNS79LC27eJf2MhdRHCgpdbxC0N19AnVU+8e/hJVtiOaJ5Cd
         29Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714742046; x=1715346846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6Kz22nN7XZpw5/QYn8eU3Vl5d2ZzmTa9J6l4Ufw1zs=;
        b=Q5uGiD4D6J/PrQvGzWl+iPWr35x9BFY32I3uffYTmLVU2gJccyoYKYOihx6Fucj+B2
         gA9t9O9JpEcUdshqKBBY3YCp0zSPaM3r3ggiRYt5d2a9tFWwBJysy/QI1VF2ZIdh/kqB
         A/9K4Iba1nfp9IQNqChm4DMSW+jJQFBInncsAwtQzpGZfpG4qVrw7aJAnBg9AhKTNzyJ
         CvJJNDlUZJhFLk8OtF++fxDILWOYY7glkSaunLgvoUQ8H7V/vnzoma6qsa9Oq4WR37v3
         k1r2JE9Ti1N+wYw4p0cPfi5eCPspBIp8y5CqBJuaZT6vG4MvG9ej9DIo+7PWdwc/GODd
         6v+w==
X-Forwarded-Encrypted: i=1; AJvYcCVILL6wtpyjp9AhtO3obmCsPN3ndhJIKkDpP0EPmFncQvyR/Krsp4rbEJ1jlY3jNJys+oXkf0RSHkgUMRCcecEATmVTc8kc/SRJU3HPnjLguE9vdE6uLjh53jSmXZ2MKaq/VnlNFdZ5DIwROEPEe96L/QUYjImbzgkZsUyKoZBxz1NA8JaCYGyjt5tdyIVPi97Oublw5HQ+zpiA9zKv86vL1l68FUcazL/PG2xQp0i4poNkbUioC9mTRE3VcTwJBq9Rl+Vkmzd/fcpEaT8aPn6FSeOm5TShzeECXsf3O3G8vwrzHoicyoBNXwlrmfKz3sWspenNHP1fv5grRcEa7yRbL3HruID7AYjsySZj4ntgyGwixOYBAZQcOjAoqD3lOiCr7HpZSQ3Gsa/+mJjUtR+RiVCqV8kn6cGhYgf9W12xfI0LMH/hkK06p7fNn16Zygg23SlxfvDBE/Qgc1uf1zwru5rc3ua53X6Dyudnn3XWunVjFj1GemFEY89xD+ymFrqlAuUu3w==
X-Gm-Message-State: AOJu0YxrOPSFGgA0SvXlclJbHO9actMARbcZeqFgnXwjiekXoN7gsQcY
	eOQa9hGvHl7K5jXKPV9hHKiye5303LSuvCHluvvjR8nW59v/1Zny
X-Google-Smtp-Source: AGHT+IGAxZcx6M5jku9xJQNGsk1mq4nfDpmBwjTTeZ5TRCe/HqThlL4pFRsVfzRAFzuWYWRs0QPHbQ==
X-Received: by 2002:a05:6a20:3cac:b0:1ac:c8dc:3e5e with SMTP id b44-20020a056a203cac00b001acc8dc3e5emr3146813pzj.24.1714742046301;
        Fri, 03 May 2024 06:14:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b001e509d4d6ddsm3203863plx.1.2024.05.03.06.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:14:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C0EA918462B27; Fri, 03 May 2024 20:14:03 +0700 (WIB)
Date: Fri, 3 May 2024 20:14:03 +0700
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
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v8 13/14] net: add devmem TCP documentation
Message-ID: <ZjTjG_INUM4G1Pf5@archie.me>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-14-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p760D9CQLIFGzr8t"
Content-Disposition: inline
In-Reply-To: <20240403002053.2376017-14-almasrymina@google.com>


--p760D9CQLIFGzr8t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 05:20:50PM -0700, Mina Almasry wrote:
> +ncdevmem has a validation mode as well that expects a repeating pattern =
of
> +incoming data and validates it as such::
> +
> +	# On server:
> +	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
> +		 -p 5201 -v 7
> +
> +	# On client:
> +	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
> +		tr \\n \\0 | head -c 5G | nc <server IP> 5201 -p 5201

What about splitting server and client usage?

---- >8 ----
diff --git a/Documentation/networking/devmem.rst b/Documentation/networking=
/devmem.rst
index e4e978fbcdbd5f..f32acfd62075d2 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -245,12 +245,14 @@ To run ncdevmem, you need to run it on a server on th=
e machine under test, and
 you need to run netcat on a peer to provide the TX data.
=20
 ncdevmem has a validation mode as well that expects a repeating pattern of
-incoming data and validates it as such::
+incoming data and validates it as such. For example, you can launch
+ncdevmem on the server by::
=20
-	# On server:
 	ncdevmem -s <server IP> -c <client IP> -f eth1 -d 3 -n 0000:06:00.0 -l \
 		 -p 5201 -v 7
=20
-	# On client:
+On client side, use regular netcat to send TX data to ncdevmem process
+on the server::
+
 	yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | \
 		tr \\n \\0 | head -c 5G | nc <server IP> 5201 -p 5201

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--p760D9CQLIFGzr8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjTjFwAKCRD2uYlJVVFO
o9RPAQCNza/o9eilURPtLMgckHLWGXSLgl+m05JS4n+5eQOBfAEAuaR+vADZuSKC
PnV18jn47Aqz1SmrD+MDjjeFy4rw0gM=
=E6BN
-----END PGP SIGNATURE-----

--p760D9CQLIFGzr8t--

