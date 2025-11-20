Return-Path: <linux-arch+bounces-14972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78078C7200C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 04:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 331FD2C5AA
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 03:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B832F6169;
	Thu, 20 Nov 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsxa+VKd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA82E7F00
	for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2025 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609833; cv=none; b=CXWD33bb684fKtxE7W0njILmM56JzkcLmQIegDrbepM/u44hLlAXr7tmHeP9XmxzRURRZ883zNL9MSmTM0XSZbLg4MiNGoIk7hx0vQWKt/0Kf6hi2VQfaOlr+389Bi4OSVnhDJrkHW/bzVA5Tz6ObYPAgN6Wz455pTyquyZYOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609833; c=relaxed/simple;
	bh=ECDBbREziOCBdmljpaOyZYKnPyj7Q88QKnhf5KEHVVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=itgA9srPgYVk5FWDiyd5F1oajJCnNURROrl9lzIoxVvkZrolextKhJxKFqMD8ZoO7+qjaoWrUEg7OptPzUnOkl+bNQRYIPs6vL/sDKarnP0VLAS+FYBWXwL3nkr8WxaDvrKOOG4KUDHcAaK9WZUjXs6zuJGDPGPkwHlZ40NYgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsxa+VKd; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640daf41b19so554400d50.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 19:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763609831; x=1764214631; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIkiaMiVquFyiirALpYhy26Yx4mEN1PZCumzzoxIfHM=;
        b=Qsxa+VKd1mpF7UMBzUypqSeI2fpL9oercFH36BLY0JFDDSV1v6mzYlAvlrroyjRbw7
         I/gd8y4I1aOQuqt89THFWvvobEQt6MjyL2cSH67gw6shL07YZaHBehY8b1UAcxooTtah
         kHGDLiRh3BGI1WbaiJaq8yrqgu3aQ4gSRH5B35xbheyVT6GvSdVZT/T2opISaSr04BhS
         s2SXG+j9E6ksMjKkWQz+Xwo2WeKSbaQRDmO+Sn4ajetlbrnhuv5qaB7Lr7mnvwFqFw6O
         UftCsGlJ8Uj45P34gk0OkTjJEaEIhbw0OvMnLxiu1/0j3qSSH3LTD03EhQf4PSCqICTW
         fYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609831; x=1764214631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIkiaMiVquFyiirALpYhy26Yx4mEN1PZCumzzoxIfHM=;
        b=cgvdQQbmB4WzLPycT39CbU0R2vmNCDGrvREN1xFOffAOYuka6Vn82gPq07t22uPKeL
         wQilJqXjYZJbON0kfDkloya9cyefYPVgUqJPzXiDmt1ZNW52PcRmCXBR71zipfV9N6V9
         SaRRZKTIO/p9mYTQQQgIs4tj3vilXPLmDJOKKdlh1Xs9gW0joOwzCZy7hw2TKnLrLQXk
         t8BNTtEwnS3/HGR7nq/HRCB+4es/aJKUBcGRsZXdmE9w4XMYpccgFrY0rTkJp1Lj/lK+
         2dZiVv70p7kxXmmzY1wokFCNq/8WmM04E5376e3zxOOEM+XSxznc2feNabSb9r9Z6OZy
         s4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgXJazW6aVDtEzHhY6XcQ63frysC2dQ4UgcQpeIKSokuJ+YB3vCnN3eFiUC6j04v5m+B/Jqq7IE9iO@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXxT3DTW9ChukCXEgiAe09UT/Ad7qwMtzAepklOWhKpOy7xXu
	hPp6dZ1y9WYOyE1sR4f+0wYfzqqLk1h7fQyHN0BEqklAt7wkGsqDftJD
X-Gm-Gg: ASbGncu+Rsfd3YyA9ZM8+5QpPiZ0+HWvYLeJr0hertLM/0N/O8/udsPO1DSeNVEt+6y
	ucuddtl5HV5JHhyKJQ4I5k8goizkO5ucqOVpTq3jqklwwU7DsYz+O+e2hd9BhfpTQQnQq4Bw5GG
	gtXX9lRg6EJZhGgXH4H7PNGepuAwzQcp7IBgTroZ+LFfRbXzrJjHpYEf2tASSkpvGFlLXVqbAKW
	IUHomhQxYek+YXQtkhAR9tyt8x7uQCIVZATpwWYXdrTQ3gOC69+9XohpOBP2xbhVm0UgG4/sGJe
	Zi2dK/p5v0ymi+GKKmEbmreF21bv39F+PKVNQDdLCDNf2W/C1lMZu/pZYtRWyx1X1CM9r7EWkhn
	aXMjbnhKuZPb99X2nEPMI93QdbW+LSx6e2cje7Ps0J+wvzeFeM4XBcVP0Hfw9ggKE0yStlkibny
	Glf2KL31fjvz43qSNyoCvLRQ==
X-Google-Smtp-Source: AGHT+IFKpR/FkxuF8iJIp+zHB2TEb80Y93lcc8kYP3bFlmrPbGL1JL+3IZD61Ppr98fvNX1s6GOhrQ==
X-Received: by 2002:a05:690e:4009:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-642f8e16330mr648848d50.33.1763609830900;
        Wed, 19 Nov 2025 19:37:10 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798bd22fsm4151977b3.25.2025.11.19.19.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:37:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v7 0/5] net: devmem: improve cpu cost of RX token
 management
Date: Wed, 19 Nov 2025 19:37:07 -0800
Message-Id: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOMHmkC/5XQu26EMBCF4VexXO9EY2ODTbXvEaXwZQhWwkXYQ
 bta8e6RKBJERz3S9x/Ni2daEmXeshdfaE05TSNvWXNjPPRu/CRIkbeMS5QajbSQw+JK6MFP3j8
 p9980uBEirQMNUMIMZfqiEX7mXBZyA0grPYlGRY0VvzE+L9Slx1585yMVGOlR+MeN8T7lMi3Pf
 coq9vtetSgvV1cBCNGqWtTWa63xPlBxb2Ea9tQqD7wQ13kJCMFgbCrto9LVia8OvKyv8xUgoFF
 e1T46Y7oTr/94gbK6zmtAUE3wRndaaksnvv7nBarrfA0I5KwJnYoK/fE527b9Ahk4QLRzAgAA
X-Change-ID: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series improves the CPU cost of RX token management by adding an
attribute to NETDEV_CMD_BIND_RX that configures sockets using the
binding to avoid the xarray allocator and instead use a per-binding niov
array and a uref field in niov.

Improvement is ~13% cpu util per RX user thread.
    
Using kperf, the following results were observed:

Before:
	Average RX worker idle %: 13.13, flows 4, test runs 11
After:
	Average RX worker idle %: 26.32, flows 4, test runs 11

Two other approaches were tested, but with no improvement. Namely, 1)
using a hashmap for tokens and 2) keeping an xarray of atomic counters
but using RCU so that the hotpath could be mostly lockless. Neither of
these approaches proved better than the simple array in terms of CPU.

The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
optimization. It is an optional attribute and defaults to 0 (i.e.,
optimization on).

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemb@google.com>
To: Neal Cardwell <ncardwell@google.com>
To: David Ahern <dsahern@kernel.org>
To: Mina Almasry <almasrymina@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Corbet <corbet@lwn.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Changes in v7:
- use netlink instead of sockopt (Stan)
- restrict system to only one mode, dmabuf bindings can not co-exist
  with different modes (Stan)
- use static branching to enforce single system-wide mode (Stan)
- Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com

Changes in v6:
- renamed 'net: devmem: use niov array for token management' to refer to
  optionality of new config
- added documentation and tests
- make autorelease flag per-socket sockopt instead of binding
  field / sysctl
- many per-patch changes (see Changes sections per-patch)
- Link to v5: https://lore.kernel.org/r/20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com

Changes in v5:
- add sysctl to opt-out of performance benefit, back to old token release
- Link to v4: https://lore.kernel.org/all/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com

Changes in v4:
- rebase to net-next
- Link to v3: https://lore.kernel.org/r/20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com

Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket
  leaked tokens
- drop ethtool patch
- Link to v2: https://lore.kernel.org/r/20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com

Changes in v2:
- net: ethtool: prevent user from breaking devmem single-binding rule
  (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- remove WARNs on invalid user input (Mina)
- remove extraneous binding ref get (Mina)
- remove WARN for changed binding (Mina)
- always use GFP_ZERO for binding->vec (Mina)
- fix length of alloc for urefs
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- Link to v1: https://lore.kernel.org/r/20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com

---
Bobby Eshleman (5):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: refactor sock_devmem_dontneed for autorelease split
      net: devmem: implement autorelease token management
      net: devmem: document NETDEV_A_DMABUF_AUTORELEASE netlink attribute
      selftests: drv-net: devmem: add autorelease tests

 Documentation/netlink/specs/netdev.yaml           |  12 +++
 Documentation/networking/devmem.rst               |  70 +++++++++++++
 include/net/netmem.h                              |   1 +
 include/net/sock.h                                |   7 +-
 include/uapi/linux/netdev.h                       |   1 +
 net/core/devmem.c                                 | 121 ++++++++++++++++++----
 net/core/devmem.h                                 |  13 ++-
 net/core/netdev-genl-gen.c                        |   5 +-
 net/core/netdev-genl.c                            |  13 ++-
 net/core/sock.c                                   | 103 ++++++++++++++----
 net/ipv4/tcp.c                                    |  78 +++++++++++---
 net/ipv4/tcp_ipv4.c                               |  13 ++-
 net/ipv4/tcp_minisocks.c                          |   3 +-
 tools/include/uapi/linux/netdev.h                 |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py  |  22 +++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  19 ++--
 16 files changed, 401 insertions(+), 81 deletions(-)
---
base-commit: 4c52142904b33b41c3ff7ee58670b4e3b3bf1120
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


