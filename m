Return-Path: <linux-arch+bounces-6405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071F95988E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D721C214F3
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140991C9437;
	Wed, 21 Aug 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcX4fXY2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179301C9427;
	Wed, 21 Aug 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231707; cv=none; b=B3KJ5qNa92kSPLF7snYRBcac4tJM9HWW+7t8O/9Ubt7i/UD3cjSefuQ7axfd0LGAm7fIw3ChG782oBcHSlAOon4yGzBYIea/9Qy+mjh31kuG2BT5NO9JjMH3SGrgsWJbmDOzQIdLX9PIawGXs0WjGN0SFwLrHtxUYZaPI3VKIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231707; c=relaxed/simple;
	bh=OUtYB2xd9RpqA6sX0X5lJPKnbZ+idsBu0nLIl8hmY9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1WB+Yp7vynVFpJ9uDIsEgznIFkkds6AWD0mq+HS5kA99irk3RtWXKN27PIZASOklQDILznFgOFLsweDjSiUFIUiiCJ0I/jdCkiQxGiipBe3RBe79Ejte5j8KE0B4Mw4UB4m1zFz2Y0E5pCOlvQa7kxs2KteRc59MG6MWudyOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcX4fXY2; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so22267341fa.2;
        Wed, 21 Aug 2024 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231703; x=1724836503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/AL1OeL8iYesAGF2KkaZ/rqFlEZKCDby71JmQLIyGU=;
        b=lcX4fXY2dpb4CJMjztNS4v+DHkQeF80bKCENOg70xN5mnOZ9FeBrsHzAbdrI3bkiH6
         cr+p4K5rZ0WKNAt4poVZZIx06DM4QWdaeu4JwmVnZo+BOEeQyef+yV5KL0uTZYufYOrx
         68VUNxKwyizp1Yq2LNQUNRhvmMJI6Gn5ljSjj3rv2gNEBmeFpFezikHrwZK2gVWAxUgX
         +6J6KImsq4O9DWOOn6NxZp4W+UPP7HBD9YTk5VfkdwZ5aY/tCseUS+acYwQb0mEc2weB
         q6R8oGPzsulSmb3dVmOrxV3cKsMHxbeskqXcE/ucizQzAYySwKiWvRWgVPspYjBJZLiL
         3+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231703; x=1724836503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/AL1OeL8iYesAGF2KkaZ/rqFlEZKCDby71JmQLIyGU=;
        b=kn3jR7mpCN7Uuh8jGoIR1x/xKvbeoxq2EM17NeyY+Pp9h55vm0QSBB4zwfU+O26FgS
         mYnI9GBMNvCgwxZKxUg8VVgubBkqhGgH0KJZPemYZj6GTrdYaNKbqITMbzObHrtHfX1Z
         D5xsH+BChs7JAbJy8gSygPQs214wFLBkyTJyzOOmYHTi0uUefeGYQsXG8ZDT1gXA4S0X
         HNP4YX6LKVLBD5HpQbl8kH4MsiaLa/eyIq3EfpN1qJbqnaqG9lKC9uv/Mdx7iMnrkUNL
         hD0lSHYcb1Dm3D/Hqw3OGwNhIapKmI9IgAI5UK7eNqnlsKtriQpT81txzkFYmlLU3TA9
         pBug==
X-Forwarded-Encrypted: i=1; AJvYcCUNdu0NS8GjuuOgc7yuulU9m+s3K2a2sSlU67C/UTli3I478FsGeo5wTPHacicI1uDr/Is5N7i6RMfid5w=@vger.kernel.org, AJvYcCUVg9e8mkl7G2Xzkr8ULMHpWUM+Cr/lCe/VdZIidl4ncnf16QyfC6E3agpobFdi0Xey7cPNL6RjnhLwvQU=@vger.kernel.org, AJvYcCUrwckdgYEPwrinxcKd0Ydq08fFkUfK06Gqib7HFRHIScLra6MVsk8d9dbnhLx7mAKMeLNSFgG6g7Zcbw==@vger.kernel.org, AJvYcCV+akLaGSXr5Ms64cPqjo3sWiqJMi+CvFR91nsmCM/XrvUUjynWXizaeJ82MY8oWIqusICISnvkf9wnSw==@vger.kernel.org, AJvYcCVTjL6EmzkzmA8NPGBu9dplSQvfK5isFjPUSf//4jgn0yvM58dEPF78rViZIc8bzdFeWliUkH20opVwL+0WPccW@vger.kernel.org, AJvYcCVV1XA0O+SDluYpL2kZChb2SUQd4/h17LBIrE8Lm6598uRM9awY+ywo6hQIACaP5lwrLZ40Ay4JZ3mm@vger.kernel.org, AJvYcCVW7tinhvb3G51XM4cuyUDlUnuWI+0Ly/CzZyVnnyzY7p62nHq0P67+xyiiexX2poD3rN8fflkq@vger.kernel.org, AJvYcCVkdwS/pLx5seY0ddYWyCxMdwKHi421qtL810+hy1moVBsXgme0w414RrrtEDgEo2wG334G7mW/cAT5SmZGPtTjuvtg@vger.kernel.org, AJvYcCWpoPejCrONPV4gYi0wujwxmtYsjQApe5fMQKX33TgOJgAzptTciVvOmaAHL/WF0/03vkM3nYxHduCgBA==@vger.kernel.org, AJvYcCXJCMCqmfcT
 BIU9ljsUHV1A4yn3JPcQpEzq0JsvJgS0qlgyYDJ6k120BPL1hefaKk2FWNjpdpeOb3hjzALL@vger.kernel.org, AJvYcCXNA8Z9LklYfZY6BhXACmP2+yqgjjB7p7Vnrjfp1HZhyaoXp6exQsNGmRqcSuZqfrROC7c=@vger.kernel.org, AJvYcCXx7Ng0houwH3QEYn33UK4dE4MQV5vxk7AHd/MrD7wJTrvrqbbAP9Yg5A67o0aa4+XiTEB71tPDzuisCjdU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7u4AjcR+5o0GpEJ2rr1gT6f+Xppeec+QSz1XlG3SzGdLp9p4E
	TualB3jGdnPkG/YTUi32Zb+PYGSbTJbneLnCOJM5SdQvTQiLHKKs5PgJGX9I6QRuDGEjsUvBMo+
	uZYHeRxKqBx5Xu1AN7s/Wi7xyL34=
X-Google-Smtp-Source: AGHT+IGLGfjw+Fjk2rSsSnYZ7V+bLHHFrxyDZsACc2hqiPsKgWXLHNd/EC/FWx9bAUeST6qbartz/G3Ry9JaBMthtOI=
X-Received: by 2002:a2e:988a:0:b0:2ef:2f17:9ede with SMTP id
 38308e7fff4ca-2f3f8b600a8mr8953001fa.49.1724231702724; Wed, 21 Aug 2024
 02:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-4-almasrymina@google.com>
 <CAMArcTWWxjsg_zwS6waWkLpyHhwdXDm_NJeVGm_dr+eT5QDZiA@mail.gmail.com>
 <20240819155257.1148e869@kernel.org> <CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
In-Reply-To: <CAHS8izPL4YdqFjkTpYavdxQn816=kkUv0xravQJF4Uno7Bn3ZQ@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 21 Aug 2024 18:14:50 +0900
Message-ID: <CAMArcTXvccYBPZTEuW-z=uTK7W67utd9-xjPzfxEOvUWhPS7bg@mail.gmail.com>
Subject: Re: [PATCH net-next v19 03/13] netdev: support binding dma-buf to netdevice
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Mon, Aug 19, 2024 at 6:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 19 Aug 2024 00:44:27 +0900 Taehee Yoo wrote:
> > > > @@ -9537,6 +9540,10 @@ static int dev_xdp_attach(struct net_device =
*dev, struct netlink_ext_ack *extack
> > > >                         NL_SET_ERR_MSG(extack, "Native and generic =
XDP can't be active at the same time");
> > > >                         return -EEXIST;
> > > >                 }
> > > > +               if (dev_get_max_mp_channel(dev) !=3D -1) {
> > > > +                       NL_SET_ERR_MSG(extack, "XDP can't be instal=
led on a netdev using memory providers");
> > > > +                       return -EINVAL;
> > > > +               }
> > >
> > > Should we consider virtual interfaces like bonding, bridge, etc?
> > > Virtual interfaces as an upper interface of physical interfaces can
> > > still install XDP prog.
> > >
> > > # ip link add bond0 type bond
> > > # ip link set eth0 master bond0
> > > # ip link set bond0 xdp pin /sys/fs/bpf/x/y
> > > and
> > > # ip link set bond0 xdpgeneric pin /sys/fs/bpf/x/y
> > >
> > > All virtual interfaces can install generic XDP prog.
> > > The bonding interface can install native XDP prog.
> >
> > Good point. We may need some common helpers to place the checks for XDP=
.
> > They are spread all over the place now.
>
> Took a bit of a look here. Forgive me, I'm not that familiar with XDP
> and virtual interfaces, so I'm a bit unsure what to do here.
>
> For veth, it seems, the device behind the veth is stored in
> veth_priv->peer, so it seems maybe a dev_get_max_mp_channel() check on
> veth_priv->peer is the way to go to disable this for veth? I think we
> need to do this check on creation of the veth and on the ndo_bpf of
> veth.
>
> For bonding, it seems we need to add mp channel check in bond_xdp_set,
> and bond_enslave?
>
> There are a few other drivers that define ndo_add_slave, seems a check
> in br_add_slave is needed as well.
>
> This seems like a potentially deep rabbit hole with a few checks to
> add all of the place. Is this blocking the series? AFAICT if XDP fails
> with mp-bound queues with a benign error, that seems fine to me; I
> don't have a use case for memory providers + xdp yet. This should only
> be blocking if someone can repro a very serious error (kernel crash)
> or something with this combination.
>
> I can try to add these checks locally and propose as a follow up
> series. Let me know if I'm on the right track with figuring out how to
> implement this, and, if you feel like it's blocking.
>
> --
> Thanks,
> Mina

I agree with the current approach, which uses the
dev_get_min_mp_channel_count() in the dev_xdp_attach().
The only problem that I am concerned about is the
dev_get_min_mp_channel_count() can't check lower interfaces.
So, how about just making the current code to be able to check lower
interfaces?
Here is a rough modification and I tested it. it works well.
Please look into this code.

diff --git a/net/core/dev.c b/net/core/dev.c
index f6f40c682b83..87c7985cb242 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6989,6 +6989,27 @@ static __latent_entropy void
net_rx_action(struct softirq_action *h)
        bpf_net_ctx_clear(bpf_net_ctx);
 }

+static int __dev_get_min_mp_channel_count(struct net_device *dev,
+                                         struct netdev_nested_priv *priv)
+{
+       int i, max =3D 0;
+
+       ASSERT_RTNL();
+
+       for (i =3D 0; i < dev->real_num_rx_queues; i++)
+               if (dev->_rx[i].mp_params.mp_priv)
+                       /* The channel count is the idx plus 1. */
+                       max =3D i + 1;
+
+       return max;
+}
+
+u32 dev_get_min_mp_channel_count(const struct net_device *dev)
+{
+       return (u32)__dev_get_min_mp_channel_count((struct net_device *)dev=
,
+                                                  NULL);
+}
+
 struct netdev_adjacent {
        struct net_device *dev;
        netdevice_tracker dev_tracker;
@@ -9538,7 +9559,10 @@ static int dev_xdp_attach(struct net_device
*dev, struct netlink_ext_ack *extack
                        NL_SET_ERR_MSG(extack, "Native and generic XDP
can't be active at the same time");
                        return -EEXIST;
                }
-               if (dev_get_min_mp_channel_count(dev)) {
+
+               if (netdev_walk_all_lower_dev(dev,
+                                             __dev_get_min_mp_channel_coun=
t,
+                                             NULL)) {
                        NL_SET_ERR_MSG(extack, "XDP can't be installed
on a netdev using memory providers");
                        return -EINVAL;
                }
@@ -9826,20 +9850,6 @@ int dev_change_xdp_fd(struct net_device *dev,
struct netlink_ext_ack *extack,
        return err;
 }

-u32 dev_get_min_mp_channel_count(const struct net_device *dev)
-{
-       u32 i, max =3D 0;
-
-       ASSERT_RTNL();
-
-       for (i =3D 0; i < dev->real_num_rx_queues; i++)
-               if (dev->_rx[i].mp_params.mp_priv)
-                       /* The channel count is the idx plus 1. */
-                       max =3D i + 1;
-
-       return max;
-}
-
 /**
  * dev_index_reserve() - allocate an ifindex in a namespace
  * @net: the applicable net namespace

How to test:
ip link add bond2 type bond
ip link add bond1 master bond2 type bond
ip link add bond0 master bond1 type bond
ip link set eth0 master bond0
ip link set eth0 up
ip link set bond0 up
ip link set bond1 up
ip link set bond2 up

ip link set bond2 xdp pin /sys/fs/bpf/x/y

./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f eth0 -l -p 5201 -v 7 -t 0 -q 1

# bond2 <-- xdp should not be installed.
#   |
# bond1 <-- xdp should not be installed.
#   |
# bond0 <-- xdp should not be installed.
#   |
# eth0 <--memory provider is used.

The netdev_walk_all_lower_dev() calls the callback function
(__dev_get_min_mp_channel_count) while it walks its own all lower
interfaces recursively.
If we want to check more conditions, we can just add checks in
__dev_get_min_mp_channel_count() or change the callback function.

Note that currently dev_xdp_attach() checks upper interfaces with
netdev_for_each_upper_dev_rcu() but it doesn't work recursively.
I think It should be fixed to check upper interfaces recursively in a
separate patch.

Thanks a lot!
Taehee Yoo

