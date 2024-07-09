Return-Path: <linux-arch+bounces-5322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A77B92C2B7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2024 19:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E03D1C21300
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2024 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2AE1B86F4;
	Tue,  9 Jul 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewCWYayD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58C17B023
	for <linux-arch@vger.kernel.org>; Tue,  9 Jul 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547074; cv=none; b=f5cjlwUASn6SSh9WHR0PrucngR/xXF/BplIOkf/kVML5EmGOL7zfU7uiH/8+T3IewSqhq1ShSHjLQKQ4n3AEJFROrJOiYMv1TPoZfjIAV1RYGaIYESorC7yks+JHVkwzGa/BcPiY4llOW0dEZV5wPsIGDTDOU+s5HVzLzFj22M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547074; c=relaxed/simple;
	bh=aAZTQ+YpAmM8VeJ2gdCT0fdALP/HckVt+0zF9zwIYKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnwOrvgQqLbbxYsdzIrTra5HiDvW0vXxej22c4P+o/5zE2ku+TyceuoS7ErCeB1WZNQgtaHt7mH88EFTqrAEKbxyHld0+iHdCVicBweqBvTYSVabaePTW9n87zB2fgwK/gLQO3FAjNsPtXfp/ypRx34QJNaNn8slvbfGKbTQJYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewCWYayD; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b5f2ac0fb9so23990596d6.2
        for <linux-arch@vger.kernel.org>; Tue, 09 Jul 2024 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720547071; x=1721151871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAZTQ+YpAmM8VeJ2gdCT0fdALP/HckVt+0zF9zwIYKM=;
        b=ewCWYayDHVUQdeU7eo2bk/WEAaCcmScYF5VGMzYJUNAEQIDrbdFRnBatWQWtFxwVeN
         dbU9TtoCuHjCskHM7K6E3cikXg840iI3fIc1GdPIjyEmdqsOorJb9au7N62m6+cL1V06
         das8EpWHOh5cWQCzX2BzZRLDb+qFqumYiZWj2rJLiIx39U5/FJoyBQ0Fsv2tMon6l9r8
         e9tDwkMGjXGga07LvbQGEIK5lDW6EU8IX8I2ma5niR0188M3D0Y0hswlzKoW6OF0C+Jg
         qVUOuYrfQbb5lsxNwOG1C3loL+HLND7P+o+dAPoWt9cq6+QcyHCN40Wsb8AQdRbdKnQp
         Uztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547071; x=1721151871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAZTQ+YpAmM8VeJ2gdCT0fdALP/HckVt+0zF9zwIYKM=;
        b=SPK4Zp0EU/QG1gaJXXooFZ6kNjGKOW2eV+RdwintoUZvxzs3ORXLtLerSSXuj/U+Sx
         ksxp2LRjfqhGs0SHOk7udgizP3qaIVeibve5yhwaBGsk+Vein5jLoqLc0bgx+5ukeC+H
         1QoSzQw0s4W5Z4EwvkxNcCIoRS7vF6p5gdqRIMwkPQASMv42BoG+XzgWdKREYXB4haIK
         NDld0D2jHVwBX0UpGUNZh4l+JyAWTBwd2pf6BY5+X6mdnJFTmMgV9xcPF9S2xDPxlXOp
         XvRlwE1BuQmbDR3NfQZP/M27cpMQbJ7GyNKr+fpXEkS6CGVcwqJKKmGSkrFTC4sri+4O
         6GWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfqZR63GoAULkwmYf1BFazLpeGgmTaLVc0j2zr5juq2ZZvAqZjk41CeIlSR66BUqhd20PidJCQ1NlKwt7ponmTMh8o0Ehl68SHAg==
X-Gm-Message-State: AOJu0Yyn0KPoOU2HVIdiqt50kBZ7mp9Bgv/HNBkS0XtxeasYmo8U8Jm3
	UmKtJiQqFMrJYeSGRgAZXf0nxhtW11FEcL8DIqeqVN1dnutBSv3k2W5V47PalyIX19BKEeu1+FG
	yWMHB6NTs98YLzTVMOSRL02zoF24gvBpg83ge
X-Google-Smtp-Source: AGHT+IH16U57va8G1AYAXy2voaQ3uaav9TjEwbgydjk5ADdt1gmfzeqqJI7aDLdE+wjZ6VeQ0SWzZOZUCWRm4uKL9HM=
X-Received: by 2002:a05:6214:c23:b0:6b5:752e:a33a with SMTP id
 6a1803df08f44-6b61c212bf8mr38578236d6.57.1720547071067; Tue, 09 Jul 2024
 10:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-4-almasrymina@google.com> <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
 <CAHS8izNS5jZjPfc-sARbHV7mzqzH+UhHfAtCTKRRTfSAdhY4Cw@mail.gmail.com> <CAMArcTUdCxOBYGF3vpbq=eBvqZfnc44KBaQTN7H-wqdUxZdziw@mail.gmail.com>
In-Reply-To: <CAMArcTUdCxOBYGF3vpbq=eBvqZfnc44KBaQTN7H-wqdUxZdziw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 9 Jul 2024 10:44:16 -0700
Message-ID: <CAHS8izNgaqC--GGE2xd85QB=utUnOHmioCsDd1TNxJWKemaD_g@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to netdevice
To: Taehee Yoo <ap420073@gmail.com>
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

On Tue, Jul 9, 2024 at 8:37=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
...
> And I found another bug.
>
> [ 236.625141] BUG: KASAN: slab-use-after-free in
> net_devmem_unbind_dmabuf+0x364/0x440
...
> Reproducer:
> ./ncdevmem -f <interface name> -l -p 5201 -v 7 -t 0 -q 2 &
> sleep 10
> modprobe -rv bnxt_en
> killall ncdevmem
>
> I think it's a devmemTCP core bug so this issue would be reproduced
> with other drivers.
>

Thanks again for testing Taehee. I haven't looked into reproducing yet
but the issue seems obvious from the repro and the trace. What happens
is that when we bind an rxq we add it to bound_rxq_list, and then when
we unbind we access the rxq in the list, without checking if it's
still alive. With your sequence, the rxq is freed before the unbind
happens, I think, so we hit a use-after-free.

The fix, I think, should be simple, we need to remember to remove the
rxq from bound_rxq_list as it is deallocated so there is no access
after free.

Btw, I have all the rest of the feedback addressed (including netlink
introspection) and I was in the process of rebasing and build-testing
a new version, to try to get in before net-next closes if at all
possible. I don't think I'll be able to fix this particular issue in
time, but I should be able to submit a fix targeting the net tree
during the merged window, if that's OK. If folks feel this issue is
blocking, please let me know so I don't send another version before
net-next reopens.

--=20
Thanks,
Mina

