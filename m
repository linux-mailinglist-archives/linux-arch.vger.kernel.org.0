Return-Path: <linux-arch+bounces-15787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA0D1B479
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 21:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D2CC30C36F8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 20:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372B3128D2;
	Tue, 13 Jan 2026 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJclDuSq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9DE3101BC
	for <linux-arch@vger.kernel.org>; Tue, 13 Jan 2026 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336987; cv=pass; b=cdOlhJNnuRNqj8YJJ6ymVsHO/tMg3MxX1Ou4HyvOVobPjJMxGm3IfQXSvUp1AmWncLWU4gtVg7ZyvBLdWpU6/xY3OkVDSADQpzih+ZI1hCrerkwZ4cB4aY5Z+wICFJfmv/EexNmHSIGroDeXBl8UrjaK5LwFyEUCrD7UaC1WUTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336987; c=relaxed/simple;
	bh=hSf3R/YVk//+ujbhyN+bD/qV4nruZvODNEYfVDWxeb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhFPFjcx8U9NNZrKjqS6oDbbbT2PjadKj/LSZ7BaAzOiDf0pUkzucoIdYD6g0KiY+oPkPOjnP9rq2ZRkvt6wtY6i/DXw/ha1FSXwHtpd+7GhOFUBRfQMxsd0DZULuLdXVtaMEqa6KqtALM0sB2DOvT5nGxR8NE56GvyC9aQYXFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJclDuSq; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b737450f6so1418e87.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Jan 2026 12:43:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768336984; cv=none;
        d=google.com; s=arc-20240605;
        b=ZcJAnUAx3t7vxVwFe9GyafMD8j2GYO15dX5LPV4EJ7hYri23nEpqFTHrBNfnAv///l
         3Nspse24Wbgq990zHx3zMqFdZWgkMGOccIzERewgEP4T5ddV7NQwRG6R3LTtuwBfyn8w
         r/6Pb3LOH98nMEU3lGqyKiHuelogr1PcM5Ye6ZHnlPqHOcTUZpFB7Vl0jOrgbmRF6+KJ
         IqeQkHC9A8kViU2gLv/qLkCLV+4yDWOo497DX4jzGMm1ioHq1QBD+F0G7PohFbWMPBdX
         Trq7RXLWPXTrODwwdyc/GQE1zPCptvK1eMcTmGb3YUkdsNcKx67fb85jQekMKh66rWmZ
         47QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7rZQoaFWDVZHnj6smUs01byVX9zqt9iWxrOQ24b43U=;
        fh=FZOGC15mORCvbRP+1nJn01YAJN3VJEHs2fr0h0NOBTs=;
        b=d+RPjGIxQdlYjPGnQk0/ZVb1JI1EY4pF1iraKL7f1ZxxUa2+yfcWSk/luRUil1rr10
         M6sETOOfVnYfq+Q2R7WipJD8u2Ky5AVRVSV+Dk1wVth8wXKmAK2jV04EQEffHROJuM0j
         HNwlO2P2sXW+mETwfvr5Rk7jRJDzjSlbeidL8p8DZgsg5P49XrawgLL2amaE0EXNPss4
         piixN4Ld1faefsbB1Bh9YFPDw9VXxoanEjZIDILtFWTQAm/iCSri0nPdhN2LePdJvZnt
         Cp6Q8vGbJ/fO3GHMzpFVYY/brvsHcWV/iV4jreISIEyBAPaIidWi6UHcR+zNpZa7y9Jw
         A6ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768336984; x=1768941784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7rZQoaFWDVZHnj6smUs01byVX9zqt9iWxrOQ24b43U=;
        b=JJclDuSqvR0pHlmRizqPmASUySRZo0wIIfHwKMK687d6kT6b8o1i94GahusEYD7CjN
         Jv6lhOWIcbjZVabFGYowp6laShlXLoksYDtxlIQr3kC9D1JqPcJSdqftnvEPa29Jg1Je
         xIuvOo76W1Kyf3oSmFWNCjGBNdBG+HyHVEh48tg/leNKswtl3tN/NDQLFIfXvQHyH2bj
         oF1GsOPaAZj8GBJptA3Lj1vJEM/I860tfrPZM1Onwmx93UiUuRnC1jWGVr9nstLhmufI
         FhVKsk+kBXntYy4u2y2LVroojde6dG2dnnPPqTvCCwxJepOePAwns+hQMFMy7GbYiHQq
         IGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768336984; x=1768941784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x7rZQoaFWDVZHnj6smUs01byVX9zqt9iWxrOQ24b43U=;
        b=j3qCDk3MnWFP5KecO6vG78DRHuDW9CP6X5HlvMJEoYUFNjKcDi6/xig60/qt0Q+YMI
         8RH0FiQCj9UAYBE69S1V59LkDpOwMIzzX8zKqr0/Y6JxE4XelXzcMFu664GexMi2Q0wY
         lp6RtNTMg0FAc2kLNbJmx4yRQO0MCFM0+utxO/h5jd4qWowfWf1ksDwSGjr97U2uE+8b
         p2zUIlyDN5OuBvh55genlil//ZaUPQq6ZhW8xRFBxGmQbh5B6kzBFYvJRs7gJ5TLKqOx
         lMkcQEp6bKUDRZrwYFekVEiWYP/q3RTr93IWXeR6Un0OHc+Nr+hc7UXRuf/qIB0j+Swd
         b3ig==
X-Forwarded-Encrypted: i=1; AJvYcCWPDARCzBtn+LaL9QmAQof8b8OuniVomfsA1yVikf069OmayjJfJuC8CeckzY2s+a3Bt6SHnjD3TO3r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GiVC14eIRsySIl3yp8pAIAqLgwJkkyduEXQInVuk2xKwprfk
	2DprDjbRb5rm27oKxCCC60k3MzVQoIjEehmYhqmVwyx1/E9sWVw4ZYwy/RpCaRw38w95oORbFLH
	UNrhbgUFJkH+BNlwr2epTuz9SAb4Mtvj8c640/lCq
X-Gm-Gg: AY/fxX6obyXgASebe4bFTMJ35QjMI7ayPNIl4g+zDzIEKeHA440QNH30eo9OTXxqP0Q
	FHhp6aSM6mPi3tSkL6pFsOJWHlxINwZPFrPj1na3Heu1wk71vxYDmRFqhNPzSyVVf1WU2v5WgUM
	89CyxRn+5XQa7PdexEyConsvoiWtVi5vOP3sDpCHVJlskZkX6unNeoiaaVNPsvUlxFyS6zT8Zrh
	1QxenJ6ve6N/uOpiIXJMUqrGuYeENfnMZcRFeNe2R0uAiTo6X80C033Eb31qP3hZ0P5SJemiEsy
	lv5FsnVRJ6epOV+Yi7x2eIXe42A3DtWrlnE=
X-Received: by 2002:a05:6512:1c6:b0:595:7664:56b with SMTP id
 2adb3069b0e04-59ba0c12542mr23823e87.11.1768336983053; Tue, 13 Jan 2026
 12:43:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
 <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com> <CAHS8izMfw_m4ajVK-VHy-a4H4FXx45m33fP=vquHLGTJMX7aYA@mail.gmail.com>
 <aWar7n5vOptzQpeC@devvm11784.nha0.facebook.com>
In-Reply-To: <aWar7n5vOptzQpeC@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Jan 2026 12:42:50 -0800
X-Gm-Features: AZwV_QhxzKVuyytHoPIBscDcgUiz1NX8yMIvNyoCUU6iZ0ewG1voO5edpP3yUTA
Message-ID: <CAHS8izOjORbGYYtVxcQ6ycN6LXP241qSLmgKddEZvopGO7pKqA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/5] net: devmem: implement autorelease token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:32=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
>
> On Tue, Jan 13, 2026 at 11:27:38AM -0800, Mina Almasry wrote:
> > On Mon, Jan 12, 2026 at 8:24=E2=80=AFAM Bobby Eshleman <bobbyeshleman@g=
mail.com> wrote:
> > >
> > > On Sun, Jan 11, 2026 at 11:12:19AM -0800, Mina Almasry wrote:
> > > > On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshlema=
n@gmail.com> wrote:
> > > > >
> > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > >
> > > > > Add support for autorelease toggling of tokens using a static bra=
nch to
> > > > > control system-wide behavior. This allows applications to choose =
between
> > > > > two memory management modes:
> > > > >
> > > > > 1. Autorelease on: Leaked tokens are automatically released when =
the
> > > > >    socket closes.
> > > > >
> > > > > 2. Autorelease off: Leaked tokens are released during dmabuf unbi=
nd.
> > > > >
> > > > > The autorelease mode is requested via the NETDEV_A_DMABUF_AUTOREL=
EASE
> > > > > attribute of the NETDEV_CMD_BIND_RX message. Having separate mode=
s per
> > > > > binding is disallowed and is rejected by netlink. The system will=
 be
> > > > > "locked" into the mode that the first binding is set to. It can o=
nly be
> > > > > changed again once there are zero bindings on the system.
> > > > >
> > > > > Disabling autorelease offers ~13% improvement in CPU utilization.
> > > > >
> > > > > Static branching is used to limit the system to one mode or the o=
ther.
> > > > >
> > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > > ---
> > > > > Changes in v9:
> > > > > - Add missing stub for net_devmem_dmabuf_binding_get() when NET_D=
EVMEM=3Dn
> > > > > - Add wrapper around tcp_devmem_ar_key accesses so that it may be
> > > > >   stubbed out when NET_DEVMEM=3Dn
> > > > > - only dec rx binding count for rx bindings in free (v8 did not e=
xclude
> > > > >   TX bindings)
> > > > >
> > > > > Changes in v8:
> > > > > - Only reset static key when bindings go to zero, defaulting back=
 to
> > > > >   disabled (Stan).
> > > > > - Fix bad usage of xarray spinlock for sleepy static branch switc=
hing,
> > > > >   use mutex instead.
> > > > > - Access pp_ref_count via niov->desc instead of niov directly.
> > > > > - Move reset of static key to __net_devmem_dmabuf_binding_free() =
so that
> > > > >   the static key can not be changed while there are outstanding t=
okens
> > > > >   (free is only called when reference count reaches zero).
> > > > > - Add net_devmem_dmabuf_rx_bindings_count because tokens may be a=
ctive
> > > > >   even after xa_erase(), so static key changes must wait until al=
l
> > > > >   RX bindings are finally freed (not just when xarray is empty). =
A
> > > > >   counter is a simple way to track this.
> > > > > - socket takes reference on the binding, to avoid use-after-free =
on
> > > > >   sk_devmem_info.binding in the case that user releases all token=
s,
> > > > >   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> > > > > - removed some comments that were unnecessary
> > > > >
> > > > > Changes in v7:
> > > > > - implement autorelease with static branch (Stan)
> > > > > - use netlink instead of sockopt (Stan)
> > > > > - merge uAPI and implementation patches into one patch (seemed le=
ss
> > > > >   confusing)
> > > > >
> > > > > Changes in v6:
> > > > > - remove sk_devmem_info.autorelease, using binding->autorelease i=
nstead
> > > > > - move binding->autorelease check to outside of
> > > > >   net_devmem_dmabuf_binding_put_urefs() (Mina)
> > > > > - remove overly defensive net_is_devmem_iov() (Mina)
> > > > > - add comment about multiple urefs mapping to a single netmem ref=
 (Mina)
> > > > > - remove overly defense netmem NULL and netmem_is_net_iov checks =
(Mina)
> > > > > - use niov without casting back and forth with netmem (Mina)
> > > > > - move the autorelease flag from per-binding to per-socket (Mina)
> > > > > - remove the batching logic in sock_devmem_dontneed_manual_releas=
e()
> > > > >   (Mina)
> > > > > - move autorelease check inside tcp_xa_pool_commit() (Mina)
> > > > > - remove single-binding restriction for autorelease mode (Mina)
> > > > > - unbind always checks for leaked urefs
> > > > >
> > > > > Changes in v5:
> > > > > - remove unused variables
> > > > > - introduce autorelease flag, preparing for future patch toggle n=
ew
> > > > >   behavior
> > > > >
> > > > > Changes in v3:
> > > > > - make urefs per-binding instead of per-socket, reducing memory
> > > > >   footprint
> > > > > - fallback to cleaning up references in dmabuf unbind if socket l=
eaked
> > > > >   tokens
> > > > > - drop ethtool patch
> > > > >
> > > > > Changes in v2:
> > > > > - always use GFP_ZERO for binding->vec (Mina)
> > > > > - remove WARN for changed binding (Mina)
> > > > > - remove extraneous binding ref get (Mina)
> > > > > - remove WARNs on invalid user input (Mina)
> > > > > - pre-assign niovs in binding->vec for RX case (Mina)
> > > > > - use atomic_set(, 0) to initialize sk_user_frags.urefs
> > > > > - fix length of alloc for urefs
> > > > > ---
> > > > >  Documentation/netlink/specs/netdev.yaml |  12 ++++
> > > > >  include/net/netmem.h                    |   1 +
> > > > >  include/net/sock.h                      |   7 ++-
> > > > >  include/uapi/linux/netdev.h             |   1 +
> > > > >  net/core/devmem.c                       | 104 ++++++++++++++++++=
++++++++++----
> > > > >  net/core/devmem.h                       |  27 ++++++++-
> > > > >  net/core/netdev-genl-gen.c              |   5 +-
> > > > >  net/core/netdev-genl.c                  |  10 ++-
> > > > >  net/core/sock.c                         |  57 +++++++++++++++--
> > > > >  net/ipv4/tcp.c                          |  76 ++++++++++++++++++=
-----
> > > > >  net/ipv4/tcp_ipv4.c                     |  11 +++-
> > > > >  net/ipv4/tcp_minisocks.c                |   3 +-
> > > > >  tools/include/uapi/linux/netdev.h       |   1 +
> > > > >  13 files changed, 269 insertions(+), 46 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentat=
ion/netlink/specs/netdev.yaml
> > > > > index 596c306ce52b..7cbe9e7b9ee5 100644
> > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > @@ -562,6 +562,17 @@ attribute-sets:
> > > > >          type: u32
> > > > >          checks:
> > > > >            min: 1
> > > > > +      -
> > > > > +        name: autorelease
> > > > > +        doc: |
> > > > > +          Token autorelease mode. If true (1), leaked tokens are=
 automatically
> > > > > +          released when the socket closes. If false (0), leaked =
tokens are only
> > > > > +          released when the dmabuf is unbound. Once a binding is=
 created with a
> > > > > +          specific mode, all subsequent bindings system-wide mus=
t use the same
> > > > > +          mode.
> > > > > +
> > > > > +          Optional. Defaults to false if not specified.
> > > > > +        type: u8
> > > > >
> > > > >  operations:
> > > > >    list:
> > > > > @@ -769,6 +780,7 @@ operations:
> > > > >              - ifindex
> > > > >              - fd
> > > > >              - queues
> > > > > +            - autorelease
> > > > >          reply:
> > > > >            attributes:
> > > > >              - id
> > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > index 9e10f4ac50c3..80d2263ba4ed 100644
> > > > > --- a/include/net/netmem.h
> > > > > +++ b/include/net/netmem.h
> > > > > @@ -112,6 +112,7 @@ struct net_iov {
> > > > >         };
> > > > >         struct net_iov_area *owner;
> > > > >         enum net_iov_type type;
> > > > > +       atomic_t uref;
> > > > >  };
> > > > >
> > > > >  struct net_iov_area {
> > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > index aafe8bdb2c0f..9d3d5bde15e9 100644
> > > > > --- a/include/net/sock.h
> > > > > +++ b/include/net/sock.h
> > > > > @@ -352,7 +352,7 @@ struct sk_filter;
> > > > >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGH=
TS
> > > > >    *    @sk_scm_unused: unused flags for scm_recv()
> > > > >    *    @ns_tracker: tracker for netns reference
> > > > > -  *    @sk_user_frags: xarray of pages the user is holding a ref=
erence on.
> > > > > +  *    @sk_devmem_info: the devmem binding information for the s=
ocket
> > > > >    *    @sk_owner: reference to the real owner of the socket that=
 calls
> > > > >    *               sock_lock_init_class_and_name().
> > > > >    */
> > > > > @@ -584,7 +584,10 @@ struct sock {
> > > > >         struct numa_drop_counters *sk_drop_counters;
> > > > >         struct rcu_head         sk_rcu;
> > > > >         netns_tracker           ns_tracker;
> > > > > -       struct xarray           sk_user_frags;
> > > > > +       struct {
> > > > > +               struct xarray                           frags;
> > > > > +               struct net_devmem_dmabuf_binding        *binding;
> > > > > +       } sk_devmem_info;
> > > > >
> > > > >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULE=
S)
> > > > >         struct module           *sk_owner;
> > > > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/net=
dev.h
> > > > > index e0b579a1df4f..1e5c209cb998 100644
> > > > > --- a/include/uapi/linux/netdev.h
> > > > > +++ b/include/uapi/linux/netdev.h
> > > > > @@ -207,6 +207,7 @@ enum {
> > > > >         NETDEV_A_DMABUF_QUEUES,
> > > > >         NETDEV_A_DMABUF_FD,
> > > > >         NETDEV_A_DMABUF_ID,
> > > > > +       NETDEV_A_DMABUF_AUTORELEASE,
> > > > >
> > > > >         __NETDEV_A_DMABUF_MAX,
> > > > >         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> > > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > > index 05a9a9e7abb9..05c16df657c7 100644
> > > > > --- a/net/core/devmem.c
> > > > > +++ b/net/core/devmem.c
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include <linux/genalloc.h>
> > > > >  #include <linux/mm.h>
> > > > >  #include <linux/netdevice.h>
> > > > > +#include <linux/skbuff_ref.h>
> > > > >  #include <linux/types.h>
> > > > >  #include <net/netdev_queues.h>
> > > > >  #include <net/netdev_rx_queue.h>
> > > > > @@ -28,6 +29,19 @@
> > > > >
> > > > >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_=
ALLOC1);
> > > > >
> > > > > +/* If the user unbinds before releasing all tokens, the static k=
ey must not
> > > > > + * change until all tokens have been released (to avoid calling =
the wrong
> > > > > + * SO_DEVMEM_DONTNEED handler). We prevent this by making static=
 key changes
> > > > > + * and binding alloc/free atomic with regards to each other, usi=
ng the
> > > > > + * devmem_ar_lock. This works because binding free does not occu=
r until all of
> > > > > + * the outstanding token's references on the binding are dropped=
.
> > > > > + */
> > > > > +static DEFINE_MUTEX(devmem_ar_lock);
> > > > > +
> > > > > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > > > > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > > > > +static int net_devmem_dmabuf_rx_bindings_count;
> > > > > +
> > > > >  static const struct memory_provider_ops dmabuf_devmem_ops;
> > > > >
> > > > >  bool net_is_devmem_iov(struct net_iov *niov)
> > > > > @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct w=
ork_struct *wq)
> > > > >
> > > > >         size_t size, avail;
> > > > >
> > > > > +       if (binding->direction =3D=3D DMA_FROM_DEVICE) {
> > > > > +               mutex_lock(&devmem_ar_lock);
> > > > > +               net_devmem_dmabuf_rx_bindings_count--;
> > > > > +               if (net_devmem_dmabuf_rx_bindings_count =3D=3D 0)
> > > > > +                       static_branch_disable(&tcp_devmem_ar_key)=
;
> > > > > +               mutex_unlock(&devmem_ar_lock);
> > > > > +       }
> > > > > +
> > > >
> > > > I find this loging with devmem_ar_lock and
> > > > net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if w=
e
> > > > can do another simplification here? Can we have it such that the fi=
rst
> > > > binding sets the system in autorelease on or autorelease off mode, =
and
> > > > all future bindings maintain this state? We already don't support
> > > > autorelease on/off mix.
> > >
> > > I think that would greatly simplify things. We would still need a loc=
k
> > > to make the static branch change and first release mode setting atomi=
c WRT
> > > each other, but the other parts (like the one above) can be
> > > removed.
> > >
> > > >
> > > >
> > > > >         gen_pool_for_each_chunk(binding->chunk_pool,
> > > > >                                 net_devmem_dmabuf_free_chunk_owne=
r, NULL);
> > > > >
> > > > > @@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *=
niov)
> > > > >         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> > > > >  }
> > > > >
> > > > > +static void
> > > > > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_bin=
ding *binding)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++)=
 {
> > > > > +               struct net_iov *niov;
> > > > > +               netmem_ref netmem;
> > > > > +
> > > > > +               niov =3D binding->vec[i];
> > > > > +               netmem =3D net_iov_to_netmem(niov);
> > > > > +
> > > > > +               /* Multiple urefs map to only a single netmem ref=
. */
> > > > > +               if (atomic_xchg(&niov->uref, 0) > 0)
> > > > > +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *=
binding)
> > > > >  {
> > > > >         struct netdev_rx_queue *rxq;
> > > > > @@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devm=
em_dmabuf_binding *binding)
> > > > >                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_par=
ams);
> > > > >         }
> > > > >
> > > > > +       net_devmem_dmabuf_binding_put_urefs(binding);
> > > >
> > > > Sigh, I think what you're trying to do here is very complicated. Yo=
u
> > > > need to think about this scenario:
> > > >
> > > > 1. user binds dmabuf and opens a autorelease=3Doff socket.
> > > > 2. Data arrives on these sockets, and sits in the receive queues,
> > > > recvmsg has not been called yet by the user.
> > > > 3. User unbinds the dma-buff, netmems are still in the receive queu=
es.
> > > > 4. User calls recvmsg on one of these sockets, which obtains a uref=
 on
> > > > the netmems in the receive queues.
> > > > 5. user closes the socket.
> > > >
> > > > With autorelease=3Don, this works, because the binding remains aliv=
e
> > > > until step 5 (even though it's unbound from the queue,
> > > > ..._binding_free has not been called yet) and step 5 cleans up all
> > > > references, even if the binding is unbound but alive, and
> > > >
> > > > calling net_devmem_dmabuf_binding_put_urefs here is weird.
> > > > Autorelease=3Doff implies the user must clean their urefs themselve=
s,
> > > > but we have this here in the unbind path, and it doesn't even
> > > > guarantee that the urefs are free at this point because it may race
> > > > with a recvmsg.
> > > >
> > > > Should we delete this uref cleanup here, and enforce that
> > > > autorelease=3Doff means that the user cleans up the references (the
> > > > kernel never cleans them up on unbind or socket close)? The dontnee=
d
> > > > path needs to work whether the binding is active or unbound.
> > > >
> > >
> > > I agree, I think we can do away with the "unbind drops references" id=
ea.
> > > A counter argument could be that it introduces the ability for one
> > > process to interfere with another, but in fact that is already possib=
le
> > > with autorelease=3Don by not issuing dontneed and starving the other =
of
> > > tokens.
> > >
> >
> > On second thought I don't think we can remove the references drop
> > completely. AFAIU if the userspace misbehaves and doens't dontneed the
> > netmems in this setup, then the binding will leak forever, which is
> > really not great.
> >
> > I think what may work is having a refcount on the binding for each
> > rxqueue it's bound to and each socket that's using it. Once that
> > refcount drops to 0, then we can be sure that the urefs in the binding
> > are not in use anymore, and we can drop the urefs, which should make
> > the binding refcount to hit 0 and the _binding_free() function to be
> > called.
> >
>
> That checks out. I guess a reasonable name to differentiate with
> binding->ref might be binding->users?
>

I was turning that exact same question in my head. It would be nice to
reuse binding->ref somehow, but without deep thinking I'm not sure
that's possible. It seems that binding->ref should guard
*_binding_free() being called when the binding is not used by anything
(remember that each netmem allocated from the binding has effectively
a ref on the page_pool it belong too, and the page_pool has a ref on
the binding, so effectively the binding never goes away until all the
netmems are returned to the pool).

and seemingly binding->users should guard *_put_urefs() being called
when we're user there is no userspace refs outstanding (no sockets
open and no rx queues active).


--=20
Thanks,
Mina

