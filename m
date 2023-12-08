Return-Path: <linux-arch+bounces-816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DAA80ACE5
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EC91C20BC2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D84CB44;
	Fri,  8 Dec 2023 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puGdxYqA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C8199B
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 11:23:16 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4648495a842so606912137.2
        for <linux-arch@vger.kernel.org>; Fri, 08 Dec 2023 11:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702063396; x=1702668196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNuhxRDBfdQenk+uC5+I+2o2Yad/2wCHUso1pH85sfo=;
        b=puGdxYqAoQo3bHG294LrXUJmKf0r2uufNMehZOj/ib8lgIMoVsopaKC4B4b6fUFyya
         +B9rAwaP7t2N4ealA6hhXjhKtZfHcQqR6mND4Wm8Bn+OcwAWZPIz8cpOBRc9eMDbClhr
         m0HzrbjSOx0Odg45PVXWbTCRw/nXU3Cn7nmp3mL+o1poKncrgSXhF/YFLuLQHGoSStQf
         RrJGwyuzvUNDUEsmKjSD2uxYZ/BCYB8G86AaueFaliWGMcb/21OR7QeKm0LdzJc1VKhI
         29fSLZU9MNVBk7gsWs++emPmOErx0U5NoIpQDDk2xKmI0xt174+doddUkTq2O/QdtbwO
         qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063396; x=1702668196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNuhxRDBfdQenk+uC5+I+2o2Yad/2wCHUso1pH85sfo=;
        b=XUjsR8CneRBVm1nfBbIr6NMFK26Rq4h84ge1uKGPulr6qTXwgX4FfjGji4xQa7z4ee
         1uRPETgWcu2v30fJ5dRe06EgUa6HermsiW+UrN0jPhOnpcmFAf6f38m2ETDx0LXLIx9y
         tSuQfheZnWiQ5X9LdfNEEXtcQtEGRDQpWbok2F1spnCGgsdnSXi/1BNHlNxV1D6HWMnH
         a+uvvlYU14EGVruBOHQXrCOJUo7wYn8YO+7mhA9/m4Kg+/YlzjYm0jprTGLVc6RkGf0M
         C/+GOlnf585c+HZU7tN9EQvwKGuJjGxWl2xWbGCnGRAve1tNo8q9VMoZFFGDhx0jW+f8
         Djcw==
X-Gm-Message-State: AOJu0YxQ5m97PBDwBx8bAZf4TVkNPKDs0p3Yn5g3gsKg10+OCp8+da3q
	fyYrtyNw1SJ0l1E8djTg29P72CSjyNaVQo5ahg4hLA==
X-Google-Smtp-Source: AGHT+IHb22ZjibDls1yBkhF7QNEaIMpgDSaJZ0OHWa3jb0vnzr6qisUp6akF/Nl59oBqhH37DmVgAI0o7BDgdz/1wpc=
X-Received: by 2002:a05:6102:38ce:b0:465:e3df:13a with SMTP id
 k14-20020a05610238ce00b00465e3df013amr837357vst.9.1702063395773; Fri, 08 Dec
 2023 11:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-14-almasrymina@google.com> <dd47a2a4-cb80-4164-8855-045999931a8e@kernel.org>
In-Reply-To: <dd47a2a4-cb80-4164-8855-045999931a8e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Dec 2023 11:23:04 -0800
Message-ID: <CAHS8izPwkARkYjPYPY2t-5H=XFTdn=NcWk0EwiCycThR5xFmtg@mail.gmail.com>
Subject: Re: [net-next v1 13/16] tcp: RX path for devmem TCP
To: David Ahern <dsahern@kernel.org>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:55=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/7/23 5:52 PM, Mina Almasry wrote:
> > In tcp_recvmsg_locked(), detect if the skb being received by the user
> > is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVME=
M
> > flag - pass it to tcp_recvmsg_devmem() for custom handling.
> >
> > tcp_recvmsg_devmem() copies any data in the skb header to the linear
> > buffer, and returns a cmsg to the user indicating the number of bytes
> > returned in the linear buffer.
> >
> > tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> > and returns to the user a cmsg_devmem indicating the location of the
> > data in the dmabuf device memory. cmsg_devmem contains this information=
:
> >
> > 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> > 2. the size of the frag. 'frag_size'.
> > 3. an opaque token 'frag_token' to return to the kernel when the buffer
> > is to be released.
> >
> > The pages awaiting freeing are stored in the newly added
> > sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> > This reference is dropped once the userspace indicates that it is
> > done reading this page.  All pages are released when the socket is
> > destroyed.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v1:
> > - Added dmabuf_id to dmabuf_cmsg (David/Stan).
> > - Devmem -> dmabuf (David).
> > - Change tcp_recvmsg_dmabuf() check to skb->dmabuf (Paolo).
> > - Use __skb_frag_ref() & napi_pp_put_page() for refcounting (Yunsheng).
> >
> > RFC v3:
> > - Fixed issue with put_cmsg() failing silently.
> >
>
> What happens if a retransmitted packet is received or an rx window is
> closed and a probe is received where the kernel drops the skb - is the
> iov reference(s) in the skb returned to the pool by the stack and ready
> for use again?

When an skb is dropped, skb_frag_unref() is called on the frags, which
calls napi_pp_put_page(), drops the references, and the iov is
recycled, yes.

--=20
Thanks,
Mina

