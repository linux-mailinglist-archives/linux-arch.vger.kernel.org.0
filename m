Return-Path: <linux-arch+bounces-131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73537E8835
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 03:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A64281136
	for <lists+linux-arch@lfdr.de>; Sat, 11 Nov 2023 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE14405;
	Sat, 11 Nov 2023 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZhxsfs5"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF04432
	for <linux-arch@vger.kernel.org>; Sat, 11 Nov 2023 02:27:22 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EB3C2F
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 18:27:20 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-589d4033e84so1322969eaf.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 18:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699669640; x=1700274440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHEiP3XV2uBmn0PqLRLjX42b0E6uQ7KYb1D3uUIKBZU=;
        b=IZhxsfs5YKWAQW/Z7SCoQQOHlrNh4j+rbUcdeInCDPNrWLclz0nTfh6/5vxijKdpru
         o7nRt1tAsysA0Kfcy2I3VGIoOrAdHgPKQ7K2vrne1fZUm5ufyP4E39tq5x7/WbcjSCcH
         jO1/eMXLBVc+uI7fx6UZ/hYV3bFwfIG0l7jUsv5XP1arCNecZOL5Ci/N0w3vgDI9RhWL
         b2ViPqs6LlDJod1b0eK89EnLibkzVoVgYm/G20PUiSv+gTfrPncN4PGWJpa57IO+g54v
         sl2WPWtOFew1bg22qyiF4HAlsJG4OkvpTKfD2Do4oyhcLqoten466DTsAhosWHYwxvGj
         WzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699669640; x=1700274440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHEiP3XV2uBmn0PqLRLjX42b0E6uQ7KYb1D3uUIKBZU=;
        b=n0KUrX4/BwFQDg1zMWUmkWZy+uIQMonPZoRniP1vwG5zD2CqNC4H9K47iSfZsfYOsb
         qJviSsB0FT6P+pL/3vNPfNj9ajPGL1kndvhgmXFFrJrMQpCtEdX4MwM3yOmT65AyrlrH
         +aEieIZ5BLBZjZcUHjRS9+a5K2urtAi6Mf2dQ8Bwz4GeHxx1JDAUDuymwdMkrFYEhrQy
         riKbNePdpoj17qSrTXHmf8PVp/9t+VKaozLvpnlVOyp0X0HGeaSqgK2uC62A+njehki9
         DIehtKkaFrjtTAyKVS8eGXq+YOssWE7mAwvpWXRkYCgUkWVn4WO59k/+yB5N+DhSIGaz
         gkbw==
X-Gm-Message-State: AOJu0YznufuVlshFM+HIbjUX4Vy3ARjmO+KsltjvdOVoYlBL5MG7S8sv
	UZVSIlCHAfKCwz2RBtMsDdzHm9oXCliS8RN49CBzyA==
X-Google-Smtp-Source: AGHT+IGyBV+nVxcKXqDhr/jOsghB7xKbBgit+rRkn7+/EmvaA+hI7Vwg9695v7Wh5I5Hq/ZuyDfKvkdxmxTKCmeUs+M=
X-Received: by 2002:a05:6358:7f1b:b0:16b:b980:d84b with SMTP id
 p27-20020a0563587f1b00b0016bb980d84bmr742598rwn.11.1699669639815; Fri, 10 Nov
 2023 18:27:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-13-almasrymina@google.com> <20231110151335.38a1c6ec@kernel.org>
In-Reply-To: <20231110151335.38a1c6ec@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 10 Nov 2023 18:27:08 -0800
Message-ID: <CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> My brain is slightly fried after trying to catch up on the thread
> for close to 2h. So forgive me if I'm missing something.
> This applies to all emails I'm about to send :)
>
> On Sun,  5 Nov 2023 18:44:11 -0800 Mina Almasry wrote:
> > +     trigger_device_reset();
>
> The user space must not be responsible for the reset.
> We can add some temporary "recreate page pools" ndo
> until the queue API is ready.
>

Thanks for the clear requirement. I clearly had something different in mind=
.

Might be dumb suggestions, but instead of creating a new ndo that we
maybe end up wanting to deprecate once the queue API is ready, how
about we use either of those existing APIs?

+void netdev_reset(struct net_device *dev)
+{
+       int flags =3D ETH_RESET_ALL;
+       int err;
+
+#if 1
+       __dev_close(dev);
+       err =3D __dev_open(dev, NULL);
+#else
+       err =3D dev->ethtool_ops->reset(dev, &flags);
+#endif
+}
+

I've tested both of these to work with GVE on both bind via the
netlink API and unbind via the netlink socket close, but I'm not
enough of an expert to tell if there is some bad side effect that can
happen or something.

> But it should not be visible to the user in any way.
>
> And then the kernel can issue the same reset when the netlink
> socket dies to flush device free lists.
>

Sure thing, I can do that.

> Maybe we should also add a "allow device/all-queues reload" flag
> to the netlink API to differentiate drivers which can't implement
> full queue API later on. We want to make sure the defaults work well
> in our "target design", rather than at the first stage. And target
> design will reload queues one by one.

I can add a flag, yes.

--=20
Thanks,
Mina

