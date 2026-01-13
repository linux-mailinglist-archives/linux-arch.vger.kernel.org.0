Return-Path: <linux-arch+bounces-15785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 716ACD1B0A6
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2852030019EB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640436C0C7;
	Tue, 13 Jan 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNB74e70"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512535EDD8
	for <linux-arch@vger.kernel.org>; Tue, 13 Jan 2026 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332477; cv=pass; b=VItqQ2wf7WRYjsYDwqApVnlbtC3XuiWw0FnST0hpeQ9/m+hnsFyxCGdKoGPwh85udBiWlPCGFSYzIbw5lEmalGbn5YsHis0mbjhS7eoSFQQP2jyatgRv8Y+A520WvtKmQVKsMS5VTU83pEcTJmC5HKg+nUq0mNeryuJjBq7hFBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332477; c=relaxed/simple;
	bh=4IsCMfhRh/B9Uo22vqTMh0RfCe5SWivcBNwMbwhIlPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI/tociAb2cWLj3T9PPpweZQE13L/EZKD9ImT+cfZlXHF4g/V0J1CWM9msLGAsvNIvF5Vt0+M57B9k48rh3KyilEatLqO/vzzY9ibRSZ+PI1fuH1ePfdfwgvop9lIg7po3eNWEHetaB9WGfKfG0dItE6ZB/wdMwqv3/QPlrnR1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNB74e70; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6935a784so891e87.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Jan 2026 11:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768332472; cv=none;
        d=google.com; s=arc-20240605;
        b=gzdjVAFiYow1DbKi9T7JS2la68erpH88wkP/kXu+EffVPGfwlTuLIxYHAdQCGMktRY
         05X/EyXi3RMI/GMfucodJ69PIbtWyRl8qcjxy7tYmhjnV8aRycWxrIT+pRYC6LrXkX9i
         ZMNLKygmynZspRCm6TONB3TqRH1G8jykILchb9Gah/Spo2Q+GLn/LVnB6cqQcMlDh5FQ
         LUyk9A1KJ7WoQejfkBEb7tmWSFtyp9ciG1nTCMsAneC6QAit9uWS/Pr9mTbgmbA92Q9R
         uM2QgIrcNG2XGZmLM3ZbF4FagO9DkmXz0aRQtnVeOi5S9z/S4630B5lS1TKBDWK7c542
         4Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ggqQXbY7IAsfkyuOJ4yV4LBB5jDKVsMIo0IUUzoiRYg=;
        fh=9qXj5R8L7fYObvP9iy6/gURMCyQ1NbYUqNclDke0wBg=;
        b=e19KK9yDUx301owZvzJ9raQADw3ABg7QqYp8itdCFQOKm2xWVrSxIST3C5msdq1m3n
         Vaj2/ap7nAEgr2EldqQF9AwgOHbwJ2k+UhHNM0fRlIPGqEe9nJblQDL+9il7zSGns/Bm
         Ej6x3S1hvKycYiUyBiIB88cPtW2v1puOk9ZHEMcv4mU0Lh3XHJRlbFp1TYc6XJlY4UwT
         rK6sw5bRun+lmZdBnyvaYQMcYS3QyGXqXiWUntPqseM/DWja3H5YZa1AM2O/mBF/vbBc
         aDGaipdFqLpi6oyR2HrOzv/CVNrhf3tqwYITl2FgtAn0HqQqriJv4/DiCqpqKyOctx2R
         tB3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768332472; x=1768937272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggqQXbY7IAsfkyuOJ4yV4LBB5jDKVsMIo0IUUzoiRYg=;
        b=gNB74e70F2Uskl0dxaCS2XnitZijgVCYmrn0xKONoazj27M+jR/iS6nIkLDUcqyuzb
         uKQjjJZwm9B3AXzFnmTMMcs8ecV8dki6GAYSzGSJgUmsK6BQ57gUUSVYLeayLtChd0cU
         bEhtFwb6wW0WzFIvDbzCGyZ6HZxLlva8ZFEqaOeOxtnHUYHuOe1FxN9drstApsNGtAVB
         srdYVI3cxCsIAmpmWZepn0P7I7XfXyToNtYSXzlCx0WEuhSjUNjl9FxJ11VHy51bu3Uh
         pczwLwEJfghCtOuXQohKw7avT2eVPxYFlHpPxmRUbZV+7pH0cKeE8h6AU2vSzRpCR4gY
         ToVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332472; x=1768937272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggqQXbY7IAsfkyuOJ4yV4LBB5jDKVsMIo0IUUzoiRYg=;
        b=cv3ajxbphjDJgv5UFev0u+qswqvunnvpwdfgYRAV/xCAwGsCtAn/KQ/9wJ8Hh1UYA+
         Bzdo3XQLlMM2SDcPRtvf9nSe6eR5TsIqECivlKuMAwbE/Q5XqJS+f94Fp4yYdnTpMEWQ
         wi+eNEYXU3U9QA16KGO4lKKAWq5TN8SgqQm6+b6K26RULa7BhE+qrj7d/bCayiFEctrR
         ydiVuzjns5wfDriDqSAekDvmpTBtsor8yQ+9LDYVtK7uNHbLEZfd/GnSlsEwVVUX8/n2
         9vYAVvRTlZsl5qE/g/szv0CbKc8Zq3Yl4dfYrL/gYNiC9HsCFyBI4EIH8I1g0+BpeO7Q
         GvTA==
X-Forwarded-Encrypted: i=1; AJvYcCWYT582eVEY9indg90zFa8qT6jmi7yd1rZe4gH8vyD/ElsYahR91s7/RG7DyyAKSBL4b5nAA7JqmKhy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9u1hqfNVL/qsH8IKxfxCHzG8s+Dzy/9/3e/FxBNQc3dm9BRTK
	FsYadMJCmU3+QTDIl9XqPHcflOpfsjhg2IyMa50wUTpqijCP9DGo+BUeTrffWNdAdB1CZkjR9Ge
	g3v5Gd3MRWoP7WpndK9cX6z3fptFoETS8TrVjExkv
X-Gm-Gg: AY/fxX5UQo1FSN4hQX+2jfbGwWakVeEWqFeZ17H1ZA9aO5RZ8pPdy7rMrLTk4jZhZ5N
	aJfuvpvebGcRQ1S7uLC+VgEaBnBDzRsNZprs3ZMFLZ8nfGfRd3Xns4NjfMLCjqUlmDJWzOXPdWj
	gXnvxAwlcmYBlGZRWpufUGrOjYlpQqk0LvstIeu7X/RGAbzTNyoqyPH65vzPk3vZ+/WgynPvI64
	cwyFK84sKh9mNU0bDRNkvdjjuV+SfM7FIAl1nOBl8KngsC+YNaBonDbx5y048e5eLWoba2F6N++
	JV36E36BfR+f7mod3SEwV5pj
X-Received: by 2002:ac2:50a3:0:b0:59b:575a:734e with SMTP id
 2adb3069b0e04-59ba0c20474mr11294e87.9.1768332471126; Tue, 13 Jan 2026
 11:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com> <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>
In-Reply-To: <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Jan 2026 11:27:38 -0800
X-Gm-Features: AZwV_Qh72XdPJ0Q75NEaLwmXlDEM3FmP8m-XvNun1YX56fFYinLxLpt6TBQb-mg
Message-ID: <CAHS8izMfw_m4ajVK-VHy-a4H4FXx45m33fP=vquHLGTJMX7aYA@mail.gmail.com>
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

On Mon, Jan 12, 2026 at 8:24=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Sun, Jan 11, 2026 at 11:12:19AM -0800, Mina Almasry wrote:
> > On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gm=
ail.com> wrote:
> > >
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> > > Add support for autorelease toggling of tokens using a static branch =
to
> > > control system-wide behavior. This allows applications to choose betw=
een
> > > two memory management modes:
> > >
> > > 1. Autorelease on: Leaked tokens are automatically released when the
> > >    socket closes.
> > >
> > > 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
> > >
> > > The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> > > attribute of the NETDEV_CMD_BIND_RX message. Having separate modes pe=
r
> > > binding is disallowed and is rejected by netlink. The system will be
> > > "locked" into the mode that the first binding is set to. It can only =
be
> > > changed again once there are zero bindings on the system.
> > >
> > > Disabling autorelease offers ~13% improvement in CPU utilization.
> > >
> > > Static branching is used to limit the system to one mode or the other=
.
> > >
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > ---
> > > Changes in v9:
> > > - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVME=
M=3Dn
> > > - Add wrapper around tcp_devmem_ar_key accesses so that it may be
> > >   stubbed out when NET_DEVMEM=3Dn
> > > - only dec rx binding count for rx bindings in free (v8 did not exclu=
de
> > >   TX bindings)
> > >
> > > Changes in v8:
> > > - Only reset static key when bindings go to zero, defaulting back to
> > >   disabled (Stan).
> > > - Fix bad usage of xarray spinlock for sleepy static branch switching=
,
> > >   use mutex instead.
> > > - Access pp_ref_count via niov->desc instead of niov directly.
> > > - Move reset of static key to __net_devmem_dmabuf_binding_free() so t=
hat
> > >   the static key can not be changed while there are outstanding token=
s
> > >   (free is only called when reference count reaches zero).
> > > - Add net_devmem_dmabuf_rx_bindings_count because tokens may be activ=
e
> > >   even after xa_erase(), so static key changes must wait until all
> > >   RX bindings are finally freed (not just when xarray is empty). A
> > >   counter is a simple way to track this.
> > > - socket takes reference on the binding, to avoid use-after-free on
> > >   sk_devmem_info.binding in the case that user releases all tokens,
> > >   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> > > - removed some comments that were unnecessary
> > >
> > > Changes in v7:
> > > - implement autorelease with static branch (Stan)
> > > - use netlink instead of sockopt (Stan)
> > > - merge uAPI and implementation patches into one patch (seemed less
> > >   confusing)
> > >
> > > Changes in v6:
> > > - remove sk_devmem_info.autorelease, using binding->autorelease inste=
ad
> > > - move binding->autorelease check to outside of
> > >   net_devmem_dmabuf_binding_put_urefs() (Mina)
> > > - remove overly defensive net_is_devmem_iov() (Mina)
> > > - add comment about multiple urefs mapping to a single netmem ref (Mi=
na)
> > > - remove overly defense netmem NULL and netmem_is_net_iov checks (Min=
a)
> > > - use niov without casting back and forth with netmem (Mina)
> > > - move the autorelease flag from per-binding to per-socket (Mina)
> > > - remove the batching logic in sock_devmem_dontneed_manual_release()
> > >   (Mina)
> > > - move autorelease check inside tcp_xa_pool_commit() (Mina)
> > > - remove single-binding restriction for autorelease mode (Mina)
> > > - unbind always checks for leaked urefs
> > >
> > > Changes in v5:
> > > - remove unused variables
> > > - introduce autorelease flag, preparing for future patch toggle new
> > >   behavior
> > >
> > > Changes in v3:
> > > - make urefs per-binding instead of per-socket, reducing memory
> > >   footprint
> > > - fallback to cleaning up references in dmabuf unbind if socket leake=
d
> > >   tokens
> > > - drop ethtool patch
> > >
> > > Changes in v2:
> > > - always use GFP_ZERO for binding->vec (Mina)
> > > - remove WARN for changed binding (Mina)
> > > - remove extraneous binding ref get (Mina)
> > > - remove WARNs on invalid user input (Mina)
> > > - pre-assign niovs in binding->vec for RX case (Mina)
> > > - use atomic_set(, 0) to initialize sk_user_frags.urefs
> > > - fix length of alloc for urefs
> > > ---
> > >  Documentation/netlink/specs/netdev.yaml |  12 ++++
> > >  include/net/netmem.h                    |   1 +
> > >  include/net/sock.h                      |   7 ++-
> > >  include/uapi/linux/netdev.h             |   1 +
> > >  net/core/devmem.c                       | 104 ++++++++++++++++++++++=
++++++----
> > >  net/core/devmem.h                       |  27 ++++++++-
> > >  net/core/netdev-genl-gen.c              |   5 +-
> > >  net/core/netdev-genl.c                  |  10 ++-
> > >  net/core/sock.c                         |  57 +++++++++++++++--
> > >  net/ipv4/tcp.c                          |  76 ++++++++++++++++++----=
-
> > >  net/ipv4/tcp_ipv4.c                     |  11 +++-
> > >  net/ipv4/tcp_minisocks.c                |   3 +-
> > >  tools/include/uapi/linux/netdev.h       |   1 +
> > >  13 files changed, 269 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/=
netlink/specs/netdev.yaml
> > > index 596c306ce52b..7cbe9e7b9ee5 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -562,6 +562,17 @@ attribute-sets:
> > >          type: u32
> > >          checks:
> > >            min: 1
> > > +      -
> > > +        name: autorelease
> > > +        doc: |
> > > +          Token autorelease mode. If true (1), leaked tokens are aut=
omatically
> > > +          released when the socket closes. If false (0), leaked toke=
ns are only
> > > +          released when the dmabuf is unbound. Once a binding is cre=
ated with a
> > > +          specific mode, all subsequent bindings system-wide must us=
e the same
> > > +          mode.
> > > +
> > > +          Optional. Defaults to false if not specified.
> > > +        type: u8
> > >
> > >  operations:
> > >    list:
> > > @@ -769,6 +780,7 @@ operations:
> > >              - ifindex
> > >              - fd
> > >              - queues
> > > +            - autorelease
> > >          reply:
> > >            attributes:
> > >              - id
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index 9e10f4ac50c3..80d2263ba4ed 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -112,6 +112,7 @@ struct net_iov {
> > >         };
> > >         struct net_iov_area *owner;
> > >         enum net_iov_type type;
> > > +       atomic_t uref;
> > >  };
> > >
> > >  struct net_iov_area {
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index aafe8bdb2c0f..9d3d5bde15e9 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -352,7 +352,7 @@ struct sk_filter;
> > >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> > >    *    @sk_scm_unused: unused flags for scm_recv()
> > >    *    @ns_tracker: tracker for netns reference
> > > -  *    @sk_user_frags: xarray of pages the user is holding a referen=
ce on.
> > > +  *    @sk_devmem_info: the devmem binding information for the socke=
t
> > >    *    @sk_owner: reference to the real owner of the socket that cal=
ls
> > >    *               sock_lock_init_class_and_name().
> > >    */
> > > @@ -584,7 +584,10 @@ struct sock {
> > >         struct numa_drop_counters *sk_drop_counters;
> > >         struct rcu_head         sk_rcu;
> > >         netns_tracker           ns_tracker;
> > > -       struct xarray           sk_user_frags;
> > > +       struct {
> > > +               struct xarray                           frags;
> > > +               struct net_devmem_dmabuf_binding        *binding;
> > > +       } sk_devmem_info;
> > >
> > >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> > >         struct module           *sk_owner;
> > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.=
h
> > > index e0b579a1df4f..1e5c209cb998 100644
> > > --- a/include/uapi/linux/netdev.h
> > > +++ b/include/uapi/linux/netdev.h
> > > @@ -207,6 +207,7 @@ enum {
> > >         NETDEV_A_DMABUF_QUEUES,
> > >         NETDEV_A_DMABUF_FD,
> > >         NETDEV_A_DMABUF_ID,
> > > +       NETDEV_A_DMABUF_AUTORELEASE,
> > >
> > >         __NETDEV_A_DMABUF_MAX,
> > >         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 05a9a9e7abb9..05c16df657c7 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/genalloc.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/netdevice.h>
> > > +#include <linux/skbuff_ref.h>
> > >  #include <linux/types.h>
> > >  #include <net/netdev_queues.h>
> > >  #include <net/netdev_rx_queue.h>
> > > @@ -28,6 +29,19 @@
> > >
> > >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLO=
C1);
> > >
> > > +/* If the user unbinds before releasing all tokens, the static key m=
ust not
> > > + * change until all tokens have been released (to avoid calling the =
wrong
> > > + * SO_DEVMEM_DONTNEED handler). We prevent this by making static key=
 changes
> > > + * and binding alloc/free atomic with regards to each other, using t=
he
> > > + * devmem_ar_lock. This works because binding free does not occur un=
til all of
> > > + * the outstanding token's references on the binding are dropped.
> > > + */
> > > +static DEFINE_MUTEX(devmem_ar_lock);
> > > +
> > > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > > +static int net_devmem_dmabuf_rx_bindings_count;
> > > +
> > >  static const struct memory_provider_ops dmabuf_devmem_ops;
> > >
> > >  bool net_is_devmem_iov(struct net_iov *niov)
> > > @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_=
struct *wq)
> > >
> > >         size_t size, avail;
> > >
> > > +       if (binding->direction =3D=3D DMA_FROM_DEVICE) {
> > > +               mutex_lock(&devmem_ar_lock);
> > > +               net_devmem_dmabuf_rx_bindings_count--;
> > > +               if (net_devmem_dmabuf_rx_bindings_count =3D=3D 0)
> > > +                       static_branch_disable(&tcp_devmem_ar_key);
> > > +               mutex_unlock(&devmem_ar_lock);
> > > +       }
> > > +
> >
> > I find this loging with devmem_ar_lock and
> > net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if we
> > can do another simplification here? Can we have it such that the first
> > binding sets the system in autorelease on or autorelease off mode, and
> > all future bindings maintain this state? We already don't support
> > autorelease on/off mix.
>
> I think that would greatly simplify things. We would still need a lock
> to make the static branch change and first release mode setting atomic WR=
T
> each other, but the other parts (like the one above) can be
> removed.
>
> >
> >
> > >         gen_pool_for_each_chunk(binding->chunk_pool,
> > >                                 net_devmem_dmabuf_free_chunk_owner, N=
ULL);
> > >
> > > @@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov=
)
> > >         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> > >  }
> > >
> > > +static void
> > > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding=
 *binding)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> > > +               struct net_iov *niov;
> > > +               netmem_ref netmem;
> > > +
> > > +               niov =3D binding->vec[i];
> > > +               netmem =3D net_iov_to_netmem(niov);
> > > +
> > > +               /* Multiple urefs map to only a single netmem ref. */
> > > +               if (atomic_xchg(&niov->uref, 0) > 0)
> > > +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > > +       }
> > > +}
> > > +
> > >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *bind=
ing)
> > >  {
> > >         struct netdev_rx_queue *rxq;
> > > @@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_d=
mabuf_binding *binding)
> > >                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params)=
;
> > >         }
> > >
> > > +       net_devmem_dmabuf_binding_put_urefs(binding);
> >
> > Sigh, I think what you're trying to do here is very complicated. You
> > need to think about this scenario:
> >
> > 1. user binds dmabuf and opens a autorelease=3Doff socket.
> > 2. Data arrives on these sockets, and sits in the receive queues,
> > recvmsg has not been called yet by the user.
> > 3. User unbinds the dma-buff, netmems are still in the receive queues.
> > 4. User calls recvmsg on one of these sockets, which obtains a uref on
> > the netmems in the receive queues.
> > 5. user closes the socket.
> >
> > With autorelease=3Don, this works, because the binding remains alive
> > until step 5 (even though it's unbound from the queue,
> > ..._binding_free has not been called yet) and step 5 cleans up all
> > references, even if the binding is unbound but alive, and
> >
> > calling net_devmem_dmabuf_binding_put_urefs here is weird.
> > Autorelease=3Doff implies the user must clean their urefs themselves,
> > but we have this here in the unbind path, and it doesn't even
> > guarantee that the urefs are free at this point because it may race
> > with a recvmsg.
> >
> > Should we delete this uref cleanup here, and enforce that
> > autorelease=3Doff means that the user cleans up the references (the
> > kernel never cleans them up on unbind or socket close)? The dontneed
> > path needs to work whether the binding is active or unbound.
> >
>
> I agree, I think we can do away with the "unbind drops references" idea.
> A counter argument could be that it introduces the ability for one
> process to interfere with another, but in fact that is already possible
> with autorelease=3Don by not issuing dontneed and starving the other of
> tokens.
>

On second thought I don't think we can remove the references drop
completely. AFAIU if the userspace misbehaves and doens't dontneed the
netmems in this setup, then the binding will leak forever, which is
really not great.

I think what may work is having a refcount on the binding for each
rxqueue it's bound to and each socket that's using it. Once that
refcount drops to 0, then we can be sure that the urefs in the binding
are not in use anymore, and we can drop the urefs, which should make
the binding refcount to hit 0 and the _binding_free() function to be
called.

--=20
Thanks,
Mina

