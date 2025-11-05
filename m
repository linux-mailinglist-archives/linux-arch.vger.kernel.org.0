Return-Path: <linux-arch+bounces-14507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E3C33A24
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 02:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D54C14F2D8E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 01:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDAB24E4D4;
	Wed,  5 Nov 2025 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7lqQxG+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32122D4DC
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305806; cv=none; b=Umzm69ow7qbCiTqpSonYcMCAXEajx3GUIQAvZFhx5C2beNXXioOaVn8TbXm3qdVN3hz0W7UiJTfrLwGX5J1tNFCdjmXRlemtPE4OudaWOYCCvUNrqf7b05fgyeZMEhBgZu9VKhAJrESbH+q+3mslpSZFh6DWsxWk3INJ+ecW1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305806; c=relaxed/simple;
	bh=RXbqfHG0a+IQy/+y+sqBKa7OAoDAqPEMrICB9KPpae0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FhsGXaPeejHmaW7dC7OJ5UOquSVO//CB+SOPD6kt6QG0pkboJlsci4Rz9KKuAR1n+vI/pjSA6/Izh4h7zF7dVHg94z9VoVyB2hzEnNy/49TxlOFIBy0l0p45Tl8BR31x/VCnLpkK8tgFqCzI2j/FrBlRwbWGLqfZ9+3QWtVdWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7lqQxG+; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso5878098d50.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 17:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305803; x=1762910603; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9tMn1p2M/t5PL7qcirjOW1xEAHgQ7w+UJZU99+MumE=;
        b=Q7lqQxG+zDpZdDWuuOc3XJlQ+Dt2a5TeScHwinKT3fRkI/mLUtLfKl+O7+BrNEb1wP
         gCnVIJHpBShWpwqobWK7TCE21Ml2zGWMxQonpObByg0VkeSbgUzYY4jkDKXzplOj+86L
         1DeaJSlpBMgTGoHuhxZR8Yr1JyOPSp77znz0NgwYJ1gwaPo7bm06Bvj/1yNHmazkfnxs
         0MQBD3OtxxQNi4RdqbxyNjevkk5Ph+o0IMgCD0xCmHYhqYgbpyUtHgS3Y5WFpxmHF1ZE
         SsAndwTDQqFnyL/aozooFgdELuV7Ay8nlpHamWDtkHzEKx1uOLbPJr05iW2wWOpgOaRf
         Xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305803; x=1762910603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9tMn1p2M/t5PL7qcirjOW1xEAHgQ7w+UJZU99+MumE=;
        b=MoNxYSf9/lPkXHE9BCDDlAOX0XcV4SrYe1DTtO1qG51Sllu4tJAeWhy8pMyQrYA2FP
         +qXEP4A4Rlh1oTWgVmZTQZsu7m0oJ8L3TWEI2aA94NQQ5TNiSgZHoTaDy6akU1bw163L
         VmIbLnWd/wzikhMLG+pMZQonk5PrcTH7FDg8AFfO+h8Gteb3DkTXk61uDFWYzuefn1DK
         jZ/A17h3nXryxkRQEsAAhSHLw5yg0UH/iUXsPB4T2eloAzPTicKVz7o+a2rba3Gb4ofC
         GsJhKEwHXGnw4XpBrtdfhYKbzygMKd3+RwQzdqINEUer+PyLTIJYdBPGAdms8MYpmN67
         TvOA==
X-Forwarded-Encrypted: i=1; AJvYcCWCwmgF7ZCIUSiRvuU2QKEhtZysnwTRV234joW3CeIigxtnPRNQDxighJ8JXSomxmrM5Taia9Al8SqX@vger.kernel.org
X-Gm-Message-State: AOJu0YzVNa3n20ZBX0RMDCFyI32fJzeS9Ms4YZRqgbzubI+rHdumahEQ
	BTlwNTe/hNzwtOr5+YOyNhgS/wbSXk47fpxdbkapc4SU58vilRRn4W6i
X-Gm-Gg: ASbGncvyOQI69eu3sWh1EYYxhxz8DacjiiYbsRfxOrkMPPjehrsJRXtEaLBLoCJYqYd
	rM9FeSp5i/X1Q/ict8XoxrIWGR7qkgUM4zzhKXEoQO/pMM5l7XAmm1+NH1+mIhJiw7qU9xKw+wO
	5QiGdyCIxC6CNWGy5tPEsEU5opkOf5YrGHolpfqliA5nwRi2dYDXUQcfPbYpDaH3TV0oibjfq6R
	YI8E+y093JPg6SktgZE9MZh+y+qrNQe24uIQ+fp/LnJdO89ufhGpgySOsgK2f/XTtS40TWOtM5+
	S8orpfzqcrvGuB69i5ZGpe1kuQ5x2tQ+fGo9a3ChWkaNL96GSDZukNS80rrXkUqJwJyKgHBghzK
	3/mGA0o6boON7wZT1/rP7pYg+YWqYJ8tuOezsa1j136rvSGMLqcW2nFHcSScGrNErjFzV6d0137
	zhlEujjus6vg==
X-Google-Smtp-Source: AGHT+IE0LIRLznkQNnvceo02Dvgp5yqa0t710bCiAdIPw+Fl4wFqN5N+gSlsnaiGqNY/5wP/Y1I7mw==
X-Received: by 2002:a53:d007:0:b0:63f:b444:da92 with SMTP id 956f58d0204a3-63fd3571a70mr1136853d50.31.1762305803173;
        Tue, 04 Nov 2025 17:23:23 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc95a3ae1sm1285712d50.16.2025.11.04.17.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:22 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v6 0/6] net: devmem: improve cpu cost of RX token
 management
Date: Tue, 04 Nov 2025 17:23:19 -0800
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAenCmkC/5XOO2rEMBSF4a0I1XODnrbkKvsIKfS4jkVi2UiKm
 WHw3gMugpnO9YHvP09asSSsdCBPWnBLNS2ZDqS7ERoml78QUqQDoYIJzYywUENxLUzgF+8fWKc
 fnF2GiNuMM7SwQlu+McPvWltBN4OwwiPvVdRM0huha8Ex3Y/iB83YIOO90c8boVOqbSmP48rGj
 /2oWiYuVzcODKJVHe+s11qz9xmbewvLfKQ2ceI5v84LYBAMi73UPiotX3h54kV3nZfAgBnlVee
 jM2Z84fU/z5mQ13kNDFQfvNGjFtriid/3/Q+WGmxbFAIAAA==
X-Change-ID: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series improves the CPU cost of RX token management by adding a
socket option that configures the socket to avoid the xarray allocator
and instead use an niov array and a uref field in niov.

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

The sockopt SO_DEVMEM_AUTORELEASE is added to toggle the optimization.
It defaults to 0 (i.e., optimization on).

Note that prior revs reported only a 5% gain. This lower gain was
measured with cpu frequency boosting (unknowingly) disabled. A
consistent ~13% is measured for both kperf and nccl workloads with cpu
frequency boosting on.

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
Bobby Eshleman (6):
      net: devmem: rename tx_vec to vec in dmabuf binding
      net: devmem: refactor sock_devmem_dontneed for autorelease split
      net: devmem: prepare for autorelease rx token management
      net: devmem: add SO_DEVMEM_AUTORELEASE for autorelease control
      net: devmem: document SO_DEVMEM_AUTORELEASE socket option
      net: devmem: add tests for SO_DEVMEM_AUTORELEASE socket option

 Documentation/networking/devmem.rst               |  70 +++++++++-
 include/net/netmem.h                              |   1 +
 include/net/sock.h                                |  13 +-
 include/uapi/asm-generic/socket.h                 |   2 +
 net/core/devmem.c                                 |  54 +++++---
 net/core/devmem.h                                 |   4 +-
 net/core/sock.c                                   | 152 ++++++++++++++++++----
 net/ipv4/tcp.c                                    |  69 ++++++++--
 net/ipv4/tcp_ipv4.c                               |  11 +-
 net/ipv4/tcp_minisocks.c                          |   5 +-
 tools/include/uapi/asm-generic/socket.h           |   2 +
 tools/testing/selftests/drivers/net/hw/devmem.py  | 115 +++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c |  20 ++-
 13 files changed, 453 insertions(+), 65 deletions(-)
---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20250829-scratch-bobbyeshleman-devmem-tcp-token-upstream-292be174d503

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


