Return-Path: <linux-arch+bounces-9382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B396B9F06B8
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 09:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EED8281BD3
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47B7192B88;
	Fri, 13 Dec 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn1YkPgK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3B136352;
	Fri, 13 Dec 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079537; cv=none; b=tU62evSHLwoHiI+CG5DPUKXYVNLMSEOPGnnn70odcIwaUUKvo4KTi1wYb6LknsUjWTUnNotT0jGA1+oplShol8fW5UywTA05r6D9VhI/aLsdNGhItERXIp/PX8HFAjuyi9W+ld+oRJC0QJURgk5bqH383btsVV/I0cUp4h38LxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079537; c=relaxed/simple;
	bh=QPh03QEa0M8YEQs8GzmP3qJH+OhK905FKbbXXrN+B+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBsnThSavGXF+JzJi+RYh49hM9nr/huRJEZMrlk/C4QroaCTBpN5c4Ajsq4WRuKT8ADpHhMYVW7L30cxchRD2d5LgP6kX6cUqNIGZamD1CSTG0Xu/+m4cJu90RCEIJWdE7N/dwyQuNym+1czgQcARbCvOwORwGQK1jOM8ZpUK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn1YkPgK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43624b2d453so17629575e9.2;
        Fri, 13 Dec 2024 00:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079534; x=1734684334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=Fn1YkPgKusuosBcJOodl6OC90L+FFLcNbOKzxlpn+j+yLF80MqrLWZ1hnDROlvEtd7
         MHLUBkGDqx4y7av4ilIgcbz2ZpER240NXWGW6PMQd8UciwKQoAvP58h9u21nGvtg00VF
         gX9lBmgPIUwPmie8VHT8Yw3LJB+krke/E9KS+r/o6idLMj08jRcQCOvstsnvB+zOTRyA
         uXFMFxxrdrambJleSXutTBxJlfWa6wecpYY+LJHPyzFQdHhTMRGbzqoCB2XmDQPhnusK
         Uftklqtm9e07BLFMZVN/YFtNewt/Y/u1M87XXeg2V4fSW9xVfoXpyQ89q/iV7ddeqadX
         eigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079534; x=1734684334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNATByMEO9e+OmkVFZzCHZ/xIGul3/7QVkpEK0lUick=;
        b=X2V8k3A5TFMNZaDEXy1Qqg0t0uSbUOGdNuSAnNgcuiF3OdKOjjNTAtdkhi/gsV91uJ
         AyL8dXsDw1nXeciAL7pgcYsKlvmzLvetLhVoIoXzGblLCjQb/vGi1fxwFRVBz2+oF0AT
         hcKwU066NuEvyRk9dlf5AH6GerPuihTs041iKaD76NPluhEwSSlJKQf/pSvTvfOTw4/F
         tHGV4TyHT+IMM8yE77RURwrevXqcbBbm5HWvOyxrAJTXL4M8apL4j3dvYwwnz3EYCd3G
         jHBmvdOF9zIZtLt+G3p7jRzCXDvsvRdfZo09k+4FPD28MGibxShkLB7I2kqufVDqj290
         TYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/rzT3pgDgWm3/IMV8UcRNdWVvdOWo5RCUgeQ9ToovqIB7grLLsvLVmwL/l1aBk88GersKgpcCE/y@vger.kernel.org, AJvYcCUiiJktmN6xFlaDnsJZfgRs5dn+dNc6HxWPRAm5zzwD3XcYxYEHQBSsV85hqDnzQSy8oXVOnFBblhDxgw==@vger.kernel.org, AJvYcCV7X9ZVGA4uFFZeYSEw3kJX7BD/38B/koyiUlcUyba0BXX0Aj8/PVbTNMpiN7sGCESs0XGMvdIb8yIzsA==@vger.kernel.org, AJvYcCWFV6jJy0XVooUb0lTF4qJG2CL9K8pUeivdjxdkVDdBIJLAFOoxbOqXJwxgptkrfieoe6OGJcfXvm7gNw==@vger.kernel.org, AJvYcCWU76FNv5/+AW88cI6D/S2WwKELAHW3EWqxK9mY1daPvMoAmUboEJzW2zVOCtoGwL4BBV+XJ6IBMaJ3XVhu@vger.kernel.org, AJvYcCWuiPr8n56WfJm4/RGU+qhfe+sekrSuiw9z4piFNmA43d4x6SADpG7rim/BonxJa31I9i6O/mD1UnCAuw==@vger.kernel.org, AJvYcCXXo09cmB0YzVrKPnWY6siqAiLsLOOSjCc7LmBL+55GxEyyfjLLYNq39dYHOeQtVH4BHIVXyusAKj3AfeaSbZ5r@vger.kernel.org
X-Gm-Message-State: AOJu0YzXc7qD4giSI8Wrvq0Xb9uuKaUiAUFMW8tntsUEynsjG7pJ2Aox
	TO4v6XLNlSGPXfh8TTTlzt1t19pPiToFR83EIsYIVxg0kLNpTCWBl9zjTzGjL1k=
X-Gm-Gg: ASbGnct5G/CsntuXApx4scJfBAXswjHvDCFUUqm5ZLvEqNwhan8jkXuniOimu0szTwT
	D3Fo9dbIdeMtIseH6Xdv32yjfGyv7LNgQ3toutBgJRREVZBYRyafE3+mZ0dzp9xqadxyImgOuwY
	NdjVOeP8U6KlhdgBtg6odVeTvOdTfSWFjHFWxX4xYUZQe4SV6lD2HDkAQg8PMnlBnHCtDjxoAcH
	ZXFCIEk1TtqrRRpnHadrKyrsO5vpXG0B0LZ5X40jN7l/Q/lYS0/brhUKl1byYcsaNGgZiTA4wZ1
	yaVEJC/AUTDJvvGqVTFjNG0NE98NozFHEOmJ1JBNH8C8QQQQWNR/nIvxNd0yBf4=
X-Google-Smtp-Source: AGHT+IGvZ46F4y7GsgwRtao3zQ76bY3tw4SGo8pyxYF9lkLcVpC0qsmeBDijswvA1DK5T7GpHdGkkA==
X-Received: by 2002:a05:600c:3b9c:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-4362aa362e5mr14019765e9.9.1734079533683;
        Fri, 13 Dec 2024 00:45:33 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E9B09007B50BC12F2E5C1B6.dsl.pool.telekom.hu. [2001:4c4e:1e9b:900:7b50:bc12:f2e5:c1b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559eaf6sm42487645e9.20.2024.12.13.00.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:45:33 -0800 (PST)
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
Subject: [PATCH net-next v7 1/4] sock: Introduce sk_set_prio_allowed helper function
Date: Fri, 13 Dec 2024 09:44:54 +0100
Message-ID: <20241213084457.45120-2-annaemesenyiri@gmail.com>
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

Simplify priority setting permissions with the 'sk_set_prio_allowed'
function, centralizing the validation logic. This change is made in
anticipation of a second caller in a following patch.
No functional changes.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
---
 net/core/sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..9016f984d44e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -454,6 +454,13 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	return 0;
 }
 
+static bool sk_set_prio_allowed(const struct sock *sk, int val)
+{
+	return ((val >= TC_PRIO_BESTEFFORT && val <= TC_PRIO_INTERACTIVE) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN));
+}
+
 static bool sock_needs_netstamp(const struct sock *sk)
 {
 	switch (sk->sk_family) {
@@ -1193,9 +1200,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	/* handle options which do not require locking the socket. */
 	switch (optname) {
 	case SO_PRIORITY:
-		if ((val >= 0 && val <= 6) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (sk_set_prio_allowed(sk, val)) {
 			sock_set_priority(sk, val);
 			return 0;
 		}
-- 
2.43.0


