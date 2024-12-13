Return-Path: <linux-arch+bounces-9381-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84A9F06B5
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 09:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391A0188441E
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269D1AB6FF;
	Fri, 13 Dec 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRNHKPLw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EE1AC8B9;
	Fri, 13 Dec 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079523; cv=none; b=F8uxFGsORjLIUDgj+LG32yZ4bq0LI09Xqi08OLMPtB5GDsKR/96Hg+QyBtxGhfjDtej4/52Wdb270z/G7Ki/2EPSXPBPfAnDE81S/0N2dic9hCsaO17QbeQ7CNsvulACv252z5ym1SgE8B6bLAnOOcrA2sydduPHd/+X4APC3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079523; c=relaxed/simple;
	bh=cUDGGHlAcANnbkREz4BenAsb8AnUdWV6Z0tCGCMyF7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppPJhu2D3lRD/gtl7vcEVCGNXe9guIZfbvAMtm4Lt1TnTDicGse+jFBvFPsLb+aBVygu90qpg7UXTfyJsSs0X10s+aEwljPaYTVbhi3rD4mntVLdmvC7K6cN5yBfMB37+reuSSNO51RjTQrpnO58Gb/YsBmyJF53q5bw0DAJaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRNHKPLw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso10519825e9.2;
        Fri, 13 Dec 2024 00:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079520; x=1734684320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VetYn5KXTAhUFkSOH7AIyNg/gzw7QS7WRyg3+1wl9dU=;
        b=aRNHKPLwNwyj0+M9AmcMKFlwRUNLMPsxAHTqDZ7K33mDXu69Tf8Tq7QSEdLaB8lPT2
         mVEDPwzLQFWs23Uja+6NeNK6k8hniYGhmbXiBqCsL3iAzqIzf8URVI0oGheLPhKKsWrB
         /L75hJ7nbnC1dVokir2ysSBNO4OjjmV2zQwD3b5TIHtDJw9zDk1WmCQzdcqOc1hINA6s
         OI63nL2fIpZnsQD5ck7LR3bC/TMLQMh6/8E6V3/zI/LuNi4Dhx3Amz4V943WnphQSb0r
         RKMPQC3TJVNKT2Elu1orAYcQHz1lIi9p3ZLjQwA2N7H+q5Oe9Rt7mHZgWORnluHMIHZh
         Cdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079520; x=1734684320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VetYn5KXTAhUFkSOH7AIyNg/gzw7QS7WRyg3+1wl9dU=;
        b=JshwFlA6KpEz06tLNubidPw/Q9GCmAdVJEG3aT29Wlr06yqv4R/xVZLeGOv6QWeJHq
         hutOt3L9syiUcsqPiApUK20pg36Pr4MlmLMgKj3LS7lgMdTzdYeVxZDashu0nZ8uJCyX
         Wt7ijXQ5CtCmCTXQtq7Bqobibfz5+NK2FX9f4fBIK3u+K3pMoizQopAI1N8AkIDtZsfY
         5Z3N1Pzas8V6sLEgtYJHQkYEdxmNlnJQ1yFnnLCRPHOqwpgtcLp2woSJR+OEl9N1MIMb
         l5zdWtlMetTF6nv1ut6HxU/TbklcZUJrLbDz4QRkZKRexANC1gOud7lzO1BSLhd+Xqv4
         VdHA==
X-Forwarded-Encrypted: i=1; AJvYcCU6cPcu4YFdfBT2V5/Ircu2O5o3fS1JK2RY9DfOiY/nZ3aUar9tVeaGUHi8vBWWONuLYnrCpE54hvWUwY8WjcyX@vger.kernel.org, AJvYcCUi8dwk+oInXfMJqQkwxw7wc6zI+bKpPDSzobxsNfg5vCTG7ZCIxB9Aha1oXVOf3qWQydvwUuWFNC/32Q==@vger.kernel.org, AJvYcCVnj7YU4VzFC6jWkdojn9vHeIYa23QfkDJEtkqz3DcvEqiAsZME4xb4hJHtL6RFFZRCBgmukHKMbWxXtXJu@vger.kernel.org, AJvYcCWnEj6RbQVGZSEblYq3KzULcpN8Bzn6x+RKDj58Qj9XHxtmv10IrvcuC1Zgk/Ok3eT5eERzmVEZSWIJ@vger.kernel.org, AJvYcCWqt1BIK27UVSqQ1c7wiOjcVEmAAgm7A5vnJhNt3KQBJVJ238G4k94wUvIHLkdivWdUhChGAAGzcm1tFw==@vger.kernel.org, AJvYcCWuk5LQAtfvnPwPjKXyemoue9zGm6CbqYvWP9Z+0XysJNKUQn5ewrRmXFdqEnbaZoj+ZWxW4wJTaw3Amw==@vger.kernel.org, AJvYcCXBZAoH9jVpWkjwobERivy9nG3znOyVIDtdJezbgASj9xT9ldpSMTdjPibkVcOGssyGGSzG6SKOEj35Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUnMTgCMxKdln/rJqKxzEZQYmYGPK+C3ySm8/l+3DumPYOKfH
	8OXWsIaiCgdeujSVhIQoMb5fXq8yIVO5Xy2MU7pO0kazvdqoGCvp92VPaL4nDmI=
X-Gm-Gg: ASbGncvO6yrR6t/kGCBF5c3ALjTwS7DH5fXoIuu6hyiMQkkmIsMGa22vTtekiepZskP
	7GLyJ/EkNZAoRfPCrYFlORwx2XFSwG+3y+Ig/spJ7dy9d/1WTuADNfF/IGl++BxHaBTtRLqb6ML
	4goLMMyEhVaocLNvvb1jhafea4W8WBo6253Ww7hTki75uVvHLCEpzKhduDw/1LqoSyatMT6f6O7
	/uC+aL2abSzCeMqU3EXWK2+GEf1UbDdQAugSjyVHeVfRwABh/glmtT00gSVM2PwSc9FPiS4xSJ6
	M9lprEjQo7DWrKoFIu2cmyHisOAggr/8qaIQkhjP26VQEmLIIA+UXlfugVeQHwM=
X-Google-Smtp-Source: AGHT+IE4xIW6iFPhke4CxIzbBIU919wJZzjxbPCtD9l0CtQ25hXXaWF5zL9Lx89GcXxeL0D1F6F1aA==
X-Received: by 2002:a05:600c:468b:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-4362aab4cb4mr11954865e9.29.1734079519697;
        Fri, 13 Dec 2024 00:45:19 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E9B09007B50BC12F2E5C1B6.dsl.pool.telekom.hu. [2001:4c4e:1e9b:900:7b50:bc12:f2e5:c1b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eaf6sm42487645e9.20.2024.12.13.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:45:19 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	horms@kernel.org,
	dsahern@kernel.org,
	linux-can@vger.kernel.org,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tsbogend@alpha.franken.de,
	kaiyuanz@google.com,
	James.Bottomley@HansenPartnership.com,
	richard.henderson@linaro.org,
	arnd@arndb.de,
	almasrymina@google.com,
	asml.silence@gmail.com,
	linux-mips@vger.kernel.org,
	andreas@gaisler.com,
	mattst88@gmail.com,
	kerneljasonxing@gmail.com,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	deller@gmx.de,
	vadim.fedorenko@linux.dev,
	linux-parisc@vger.kernel.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v7 0/4] Add support for SO_PRIORITY cmsg
Date: Fri, 13 Dec 2024 09:44:53 +0100
Message-ID: <20241213084457.45120-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new helper function, `sk_set_prio_allowed`,
to centralize the logic for validating priority settings.
Add support for the `SO_PRIORITY` control message,
enabling user-space applications to set socket priority
via control messages (cmsg).

Patch Overview:

Patch 1/4: Introduce 'sk_set_prio_allowed' helper function.
Patch 2/4: Add support for setting SO_PRIORITY via control messages
Patch 3/4: Add test for SO_PRIORITY setting via control messages
Patch 4/4: Add new socket option, SO_RCVPRIORITY

v7:

- Carry Eric's and Willem's "Reviewed-by" tags from v3 to
  patch 1/4 since that is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v4 in patch 2/4,
  as it is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v5 in patch 4/4,
  as it is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v6
  since it is resubmitted with minor cosmetic changes in
  patch 3/4.
- Carry Willem's "Acked-by" tag from v5 on FILTER_COUNTER
  (patch 3/4).
- Carry Ido's "Reviewed-by" and "Tested-by" tags from v6
  since it is resubmitted with minor cosmetic changes in
  patch 3/4.
- Align the code to the open parenthesis in cmsg_sender.c
  (patch 3/4).
- Remove unnecessary blank line in cmsg_so_priority.sh
  (patch 3/4).
- Remove unused delay variable from cmsg_so_priority.sh 
  (patch 3/4).
- Rebased on net-next.

v6:

https://lore.kernel.org/netdev/20241210191309.8681-1-annaemesenyiri@gmail.com/
- Carry Eric's and Willem's "Reviewed-by" tags from v3 to
  patch 1/4 since that is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v4 in patch 2/4,
  as it is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v5 in patch 4/4,
  as it is resubmitted without changes.
- Use KSFT_SKIP in jq installation test and
  add 'nodad' flag for IPv6 address in cmsg_so_priority.sh (patch 3/4).
- Rebased on net-next.

v5:

https://lore.kernel.org/netdev/20241205133112.17903-1-annaemesenyiri@gmail.com/

- Carry Eric's and Willem's "Reviewed-by" tags from v3 to
  patch 1/4 since that is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v4 in patch 2/4,
  as it is resubmitted without changes.
- Eliminate variable duplication, fix indentation, simplify cleanup,
  verify dependencies, separate setsockopt and control message 
  priority testing, and modify namespace setup 
  in patch 3/4 cmsg_so_priority.sh.
- Add cmsg_so_priority.sh to tools/testing/selftests/net/Makefile.
- Remove the unused variable, rename priority_cmsg to priority,
  and document the -P option in cmsg_sender.c in patch 3/4.
- New in v5: add new socket option, SO_RCVPRIORITY in patch 4/4.
- Rebased on net-next.

v4:

https://lore.kernel.org/netdev/20241118145147.56236-1-annaemesenyiri@gmail.com/
- Carry Eric's and Willem's "Reviewed-by" tags from v3 to 
  patch 1/3 since that is resubmitted without changes.
- Updated description in patch 2/3.
- Missing ipc6.sockc.priority field added in ping_v6_sendmsg()
  in patch 2/3.
- Update cmsg_so_priority.sh to test SO_PRIORITY sockopt and cmsg
  setting with VLAN priority tagging in patch 3/3. (Ido Schimmel) 
- Rebased on net-next.

v3:

https://lore.kernel.org/netdev/20241107132231.9271-1-annaemesenyiri@gmail.com/
- Updated cover letter text.
- Removed priority field from ipcm_cookie.
- Removed cork->tos value check from ip_setup_cork, so
  cork->priority will now take its value from ipc->sockc.priority.
- Replaced ipc->priority with ipc->sockc.priority
  in ip_cmsg_send().
- Modified the error handling for the SO_PRIORITY
  case in __sock_cmsg_send().
- Added missing initialization for ipc6.sockc.priority.
- Introduced cmsg_so_priority.sh test script.
- Modified cmsg_sender.c to set priority via control message (cmsg).
- Rebased on net-next.


v2:

https://lore.kernel.org/netdev/20241102125136.5030-1-annaemesenyiri@gmail.com/
- Introduced sk_set_prio_allowed helper to check capability
  for setting priority.
- Removed new fields and changed sockcm_cookie::priority
  from char to u32 to align with sk_buff::priority.
- Moved the cork->tos value check for priority setting
  from __ip_make_skb() to ip_setup_cork().
- Rebased on net-next.

v1:

https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@gmail.com/

Anna Emese Nyiri (4):
  Introduce sk_set_prio_allowed helper function
  support SO_PRIORITY cmsg
  test SO_PRIORITY ancillary data with cmsg_sender
  introduce SO_RCVPRIORITY socket option

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/net/inet_sock.h                       |   2 +-
 include/net/ip.h                              |   2 +-
 include/net/sock.h                            |   8 +-
 include/uapi/asm-generic/socket.h             |   2 +
 net/can/raw.c                                 |   2 +-
 net/core/sock.c                               |  26 ++-
 net/ipv4/ip_output.c                          |   4 +-
 net/ipv4/ip_sockglue.c                        |   2 +-
 net/ipv4/raw.c                                |   2 +-
 net/ipv6/ip6_output.c                         |   3 +-
 net/ipv6/ping.c                               |   1 +
 net/ipv6/raw.c                                |   3 +-
 net/ipv6/udp.c                                |   1 +
 net/packet/af_packet.c                        |   2 +-
 net/socket.c                                  |  11 ++
 tools/include/uapi/asm-generic/socket.h       |   2 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++++++
 23 files changed, 228 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

-- 
2.43.0


