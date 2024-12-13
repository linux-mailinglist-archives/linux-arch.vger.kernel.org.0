Return-Path: <linux-arch+bounces-9383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A59F06C4
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 09:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB3C18828BB
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B0502B1;
	Fri, 13 Dec 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQKHfPy+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855251AC882;
	Fri, 13 Dec 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079540; cv=none; b=b2pDTtb2+WDmvuJAT9a1OeINmHhuXrxJYIW76PuTokM/TtbMipNyf30re9Zhu5dfLWJE6dRO8BjRcB3OWsqcEZtNJP0TQyOjyZopJl5JiATrbf9SmdNJbaC8ymfto7xv9Ty0THliarQbSh+7BpzAUx2/oCkd3nYK9mqDQbiFnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079540; c=relaxed/simple;
	bh=Sl6GRW5iCPIpRgCJflqImLWJSqpqskSMz6hDhNcVQ00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ0VPHuji10+7V/LEgH/Cf9wctUeaYLjqdV+IbnW9ZwkcSi5wWAkNy2PAWiB9BgPBYWGkNnKTzhqux9PflRuBDOJRb+w6w6EoBfeFr5k+lGKSbbdvdR61hqFlHEfymGiZ4CciV/iSr1IK5+AwUAB6YkGHGkPCmnK9O26nUTMBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQKHfPy+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso15025725e9.2;
        Fri, 13 Dec 2024 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079536; x=1734684336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhdEgZMIttJrwhWdkX71iUAWJ6QOVvPMGJLsgMmFF/o=;
        b=BQKHfPy+GW+LnDix0qN+fre5kdd3kJU1mylCPXvG3Kr17BJWVHRu4OUVWBYcroyfaB
         U/fIar7ipjzsgVI6PYvoIlVcwmcbG3cNoq39LvBOKyWgTnkyppIMgrCMI2uvScCCUXZO
         ZeDRw2gF/4nDW+NokRnNSqpDudhZWe+qpvALMgmAWRC24GpR10mBMWYViD1btaZLAirl
         qurF9/NKZfGR/c6nNe8JzjOyx9toaLo5qYoyKAa+VaeZQr9zlDD8U4vWwLvmSQlBsEtx
         MHL3p2KmO8ACN5IwweE1z2gH/wcXAwmWBrgpzkxTE8pi5GllDg5UgBhyff9lYeqY3KeW
         qH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079536; x=1734684336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhdEgZMIttJrwhWdkX71iUAWJ6QOVvPMGJLsgMmFF/o=;
        b=ojJfTOQ8Y5aeunR3dD0NSOyHIUc2/MlvddZryJJXNtjAQAwioTjE+vNwEA+HFxBuuZ
         XAzF21iDmZQuIdgT9AQT9Te5o5jEVjhnzyODFWf1mXOQ0VxqD2MclIKf4Jbb01fFahgO
         2Aa4AN0ow+StICRkOV80gLadnpzXkTtlGmwFS0V1HLIdYTIIfjWzIM5DfIqrP9ldedhN
         Dazoj4YkmlDt0Tds+RFxGjaS5DCB01xaQB8zG8UV6CdJbq6gx7l0Ow2L+kjLPPPT4idV
         FTldL0CC5FT0sbIPuLosDEZ4pLoar8ms1YVEz69SZ9QdIQ7HJxWwKnAYHZHiLbgvounG
         q0hw==
X-Forwarded-Encrypted: i=1; AJvYcCUBEPi+vf5YJgdQOiQvEfLXCWMrMbA4w6g1b/+e8OODzDdkN2NFitfuCrznyuZ9M3HbzbHjBGBNgPgAHf33ggyh@vger.kernel.org, AJvYcCUaDc39m1RjL8cS+Wa5Lz/qKMB0pRJ6oMrwekDK4Nc1bItVPIGbLZzGlTeWi/U4m/C5T1N1u6GteQximw==@vger.kernel.org, AJvYcCVqUx77kuZS0cge9xeV4k+YLkmxMb+ixi6xt/tQuoAGxmDDGd0AYUJe47zR4PNNdtVj/L6lMBZSK+11iA==@vger.kernel.org, AJvYcCWJ7wLy8dbFi0xaBzTbJv6NrY2dZHAXNGRqQnkDZnlmw21gC5vI13r0J3pEqrYfcf8G5GMuVWT9WuKbOA==@vger.kernel.org, AJvYcCWRR71SRuypNg/Sqs1KVouMpELPMwRM0yUtnv4zwZmaAyAxZwEQt1XD4tX27YakLAP2eqH8/haagWpQFSr2@vger.kernel.org, AJvYcCWWX3QncdtUXDr/m6gyW8VuvAmOEES/rpI5ev8eh0xezgxF7cf9i65NosEOMdEzCfui5FuUmU3rO2qWHQ==@vger.kernel.org, AJvYcCWhS352pYYlAwPC1sYx4AbSXw9joPBy9ehRAQ8Ih64EAzeflMOn30lpksw3cyLHGv4YTy4K7w1j+MKl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aVCa86cJYcKQj0COgGO4/2dov9+bMFEBQCSezE21IFQM9QuB
	c+X2/bQKnd9TUqZplgdTz240vT9i9pRk1xNZJn07b28vYVzd+hR3xfk8MZ9rt9Y=
X-Gm-Gg: ASbGncv3dHJbz0hh1PzBRcLQWnNEFPDkHEjkkb81Lld/tv6y4sla1lUdEBfN9Yl/SNB
	FPTapMVbjPxCm/yEmQxLzzm2ONYmYJaLNJQM8D/LTpzm42NWUqfS9VdLhkmYMwRlip2zd7BQk9k
	inGt536KbxSlYlPht2obdHveJPZl/3FlHJDHWkWOGw+YeQN/66dluv94F5N1wvtXNHe/18KpkGD
	OmVBS00tfmOQfEVshuj1tFSmZzVopHpF9UtJ7uJO7GrkW25CRjmJgu+itFBkQNQPa0HGjiOKZxV
	i2bQs34WpI075wUMnj7TTq13Hur3r86FHkSJzXYDful7lpnW32F8JIbattfXKv8=
X-Google-Smtp-Source: AGHT+IGLCdYQdP51TjZUz59Ci9JhyjH2voEmX8kN0lUpbIanwox00zNpnNj0ALsCdgrFCv+aQlzKew==
X-Received: by 2002:a05:600c:350c:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-4362aa15448mr12172655e9.7.1734079536375;
        Fri, 13 Dec 2024 00:45:36 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E9B09007B50BC12F2E5C1B6.dsl.pool.telekom.hu. [2001:4c4e:1e9b:900:7b50:bc12:f2e5:c1b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eaf6sm42487645e9.20.2024.12.13.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:45:35 -0800 (PST)
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
Subject: [PATCH net-next v7 2/4] sock: support SO_PRIORITY cmsg
Date: Fri, 13 Dec 2024 09:44:55 +0100
Message-ID: <20241213084457.45120-3-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213084457.45120-1-annaemesenyiri@gmail.com>
References: <20241213084457.45120-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux socket API currently allows setting SO_PRIORITY at the
socket level, applying a uniform priority to all packets sent through
that socket. The exception to this is IP_TOS, when the priority value
is calculated during the handling of
ancillary data, as implemented in commit <f02db315b8d88>
("ipv4: IP_TOS and IP_TTL can be specified as ancillary data").
However, this is a computed
value, and there is currently no mechanism to set a custom priority
via control messages prior to this patch.

According to this patch, if SO_PRIORITY is specified as ancillary data,
the packet is sent with the priority value set through
sockc->priority, overriding the socket-level values
set via the traditional setsockopt() method. This is analogous to
the existing support for SO_MARK, as implemented in commit
<c6af0c227a22> ("ip: support SO_MARK cmsg").

If both cmsg SO_PRIORITY and IP_TOS are passed, then the one that
takes precedence is the last one in the cmsg list.

This patch has the side effect that raw_send_hdrinc now interprets cmsg
IP_TOS.

Reviewed-by: Willem de Bruijn <willemb@google.com>

Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 include/net/inet_sock.h | 2 +-
 include/net/ip.h        | 2 +-
 include/net/sock.h      | 4 +++-
 net/can/raw.c           | 2 +-
 net/core/sock.c         | 7 +++++++
 net/ipv4/ip_output.c    | 4 ++--
 net/ipv4/ip_sockglue.c  | 2 +-
 net/ipv4/raw.c          | 2 +-
 net/ipv6/ip6_output.c   | 3 ++-
 net/ipv6/ping.c         | 1 +
 net/ipv6/raw.c          | 3 ++-
 net/ipv6/udp.c          | 1 +
 net/packet/af_packet.c  | 2 +-
 13 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 56d8bc5593d3..3ccbad881d74 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -172,7 +172,7 @@ struct inet_cork {
 	u8			tx_flags;
 	__u8			ttl;
 	__s16			tos;
-	char			priority;
+	u32			priority;
 	__u16			gso_size;
 	u32			ts_opt_id;
 	u64			transmit_time;
diff --git a/include/net/ip.h b/include/net/ip.h
index 0e548c1f2a0e..9f5e33e371fc 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -81,7 +81,6 @@ struct ipcm_cookie {
 	__u8			protocol;
 	__u8			ttl;
 	__s16			tos;
-	char			priority;
 	__u16			gso_size;
 };
 
@@ -96,6 +95,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm_init(ipcm);
 
 	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
+	ipcm->sockc.priority = READ_ONCE(inet->sk.sk_priority);
 	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..316a34d6c48b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1814,13 +1814,15 @@ struct sockcm_cookie {
 	u32 mark;
 	u32 tsflags;
 	u32 ts_opt_id;
+	u32 priority;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
 	*sockc = (struct sockcm_cookie) {
-		.tsflags = READ_ONCE(sk->sk_tsflags)
+		.tsflags = READ_ONCE(sk->sk_tsflags),
+		.priority = READ_ONCE(sk->sk_priority),
 	};
 }
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 255c0a8f39d6..46e8ed9d64da 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -962,7 +962,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc.priority;
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 9016f984d44e..a3d9941c1d32 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2947,6 +2947,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SO_PRIORITY:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		if (!sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg)))
+			return -EPERM;
+		sockc->priority = *(u32 *)CMSG_DATA(cmsg);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a59204a8d850..f45a083f2c13 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1333,7 +1333,7 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	cork->ttl = ipc->ttl;
 	cork->tos = ipc->tos;
 	cork->mark = ipc->sockc.mark;
-	cork->priority = ipc->priority;
+	cork->priority = ipc->sockc.priority;
 	cork->transmit_time = ipc->sockc.transmit_time;
 	cork->tx_flags = 0;
 	sock_tx_timestamp(sk, &ipc->sockc, &cork->tx_flags);
@@ -1470,7 +1470,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		ip_options_build(skb, opt, cork->addr, rt);
 	}
 
-	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
+	skb->priority = cork->priority;
 	skb->mark = cork->mark;
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->transmit_time, SKB_CLOCK_MONOTONIC);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..f6a03b418dde 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -315,7 +315,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			if (val < 0 || val > 255)
 				return -EINVAL;
 			ipc->tos = val;
-			ipc->priority = rt_tos2priority(ipc->tos);
+			ipc->sockc.priority = rt_tos2priority(ipc->tos);
 			break;
 		case IP_PROTOCOL:
 			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 0e9e01967ec9..4304a68d1db0 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -358,7 +358,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IP);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 	skb_dst_set(skb, &rt->dst);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3d672dea9f56..993106876604 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1401,6 +1401,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
 	cork->base.mark = ipc6->sockc.mark;
+	cork->base.priority = ipc6->sockc.priority;
 	sock_tx_timestamp(sk, &ipc6->sockc, &cork->base.tx_flags);
 	if (ipc6->sockc.tsflags & SOCKCM_FLAG_TS_OPT_ID) {
 		cork->base.flags |= IPCORK_TS_OPT_ID;
@@ -1942,7 +1943,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	hdr->saddr = fl6->saddr;
 	hdr->daddr = *final_dst;
 
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = cork->base.priority;
 	skb->mark = cork->base.mark;
 	if (sk_is_tcp(sk))
 		skb_set_delivery_time(skb, cork->base.transmit_time, SKB_CLOCK_MONOTONIC);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 88b3fcacd4f9..46b8adf6e7f8 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,6 +119,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, sk);
+	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 8476a3944a88..a45aba090aa4 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -619,7 +619,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb_reserve(skb, hlen);
 
 	skb->protocol = htons(ETH_P_IPV6);
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc->priority;
 	skb->mark = sockc->mark;
 	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 
@@ -780,6 +780,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipcm6_init(&ipc6);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = fl6.flowi6_mark;
+	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 
 	if (sin6) {
 		if (addr_len < SIN6_LEN_RFC2133)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d766fd798ecf..7c14c449804c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1448,6 +1448,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
+	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
 
 	/* destination address check */
 	if (sin6) {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 886c0dd47b66..f8d87d622699 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3126,7 +3126,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 
 	skb->protocol = proto;
 	skb->dev = dev;
-	skb->priority = READ_ONCE(sk->sk_priority);
+	skb->priority = sockc.priority;
 	skb->mark = sockc.mark;
 	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 
-- 
2.43.0


