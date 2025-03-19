Return-Path: <linux-arch+bounces-10942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F8A68135
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 01:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A902A7A854A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF641922F5;
	Wed, 19 Mar 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gIVpTV15"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E4DDC5
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343345; cv=none; b=LiZ2NvKSJarPDgXYMp9yFWX9Vf90W0yWN9OSf/qDjrUpZXDgwSBk4ND8B0N5KBvCoqTOVmVElk2DGTmIa54rl8zebdQ+8qWDUdWmC3ajunUf0i9X4PdKDZFt7IsWFOtR41YwZ+rmr4k0N6Rm15jUXYeEnbpfRvCa1t1VxwUsvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343345; c=relaxed/simple;
	bh=SowAWf3suxdJmhbIj/+rpT/CNsAYNCCACOuR5s/3LGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgCd0DEr7npH688DR6JwUCmbcxkJmOZPZnWHfpFESIVf0XIuJRczXrHxhf6FOYuT4l3dSnpiLJjltjuOk1IqShrP/Nx96+7JM7U/6vAxvOONShHkqFj8YDZgEO7E89r2HFwflOdEY48gBMhGCiJlYZngzh0hmPGVWn2DjJk6wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gIVpTV15; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22409077c06so157974855ad.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343343; x=1742948143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=gIVpTV15hhkkYilj5BypVWGWlzUL3CqQ72S1nz2FWsVuUY16SNpf5KQkU11mnaTAKn
         1WaoeJcNBjDgCS32IwIWKfkUfCs3oFZs0wmmQtBRsXJzqoJr4KgKFKcmXmUWyDSv1UL4
         BoqqJF1llr2ptP6/5CELh0Zkw4SLxiefAIwMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343343; x=1742948143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=RD4x6qcr8Lz3oKAB/Qul+0+sUhBpcKtsMLOReTcXlavPZfPy28byXJacTczBdULoqo
         fLYCwnShfehKotWFZ3oUJInff3KvO6Nejaa2T7r6175KkdnZFS0jEICcqS/+QBn9E73r
         sjbtsILaqtXXu3VMHM7X4QGe63xP6TG6zAz+oZS6IKm/WxwYf2OSdtZQPNLQ5i71RYMU
         6RvkYQpCuXTLKBSORYnNmvxL0tOhjfowJKsbTqa3gNt+ellAQHoJbOYpiDrBMeDsnQIt
         BBZNnFSzuqeAEeFDZUXRl7LESWZ3JN5YfM8WuGh4OOziVcCPF6DsRnL2QZVPNKXF7lcc
         0LWg==
X-Forwarded-Encrypted: i=1; AJvYcCVihHgJCdFFxSosLIE2Rsv/f3ylj51OzfUZ135Pod4pwRrWHpt5OQiOEFT2Z+vMvyGy9JqyIXvKwIxq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6f9stxYZgJcgijTo2rP+RJ4s8SdrLPnlElyOlPphljQYdhAD4
	hZUT6mfnUF6QqzDTw4ze/sjczwbVu0J3SHsjC2VqDu2ROCKzlmA2HDYuT0axK8E=
X-Gm-Gg: ASbGncsm3B3AURq9+LpbxOv5/ERiI+r9Dv67H+tI0ngOm+yX3Nmll9D+FpGn+RqlSuS
	PJ0sLpuAnaFBaEQodjAZbDZhvohjiQfgA0IOhilLxVzLBdZl4AKgLyO3QHcvnVubDZPXDaurj1+
	90XwmTGdiO3hf3LvaWJ4yNaQ/bOloe2/3ZG4NVlWchny9kNbyD5nIbOVH6S8bTUPl9gaGXwEuom
	o5+uty9dcW5Mnn01k32vIBLy42avduE5k/Q2LL8fYv27LfwwhyQoPh9AbW2GsA8r7EJxjNaFbIb
	4VIZ6mx1pB3RuEcRLobVGoNbExHAwh2aRC0F/RdWsmy8rU8tqAjE
X-Google-Smtp-Source: AGHT+IFxyw3nvWmVaD9tl0lJBbbnI8q3NC7K/P2umCsKr9U07OgWwl21w/NuymcNKusQI296uT0O6g==
X-Received: by 2002:a17:903:1cb:b0:224:76f:9e45 with SMTP id d9443c01a7336-22649a3476fmr9616615ad.21.1742343343024;
        Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:42 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 04/10] splice: Add SPLICE_F_ZC and attach ubuf
Date: Wed, 19 Mar 2025 00:15:15 +0000
Message-ID: <20250319001521.53249-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SPLICE_F_ZC flag and when it is set, allocate a ubuf and attach
it to generate zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c            | 20 ++++++++++++++++++++
 include/linux/splice.h |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 1f27ce6d1c34..6dc60f47f84e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -875,6 +875,11 @@ static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
 		if (out->f_flags & O_NONBLOCK)
 			msg.msg_flags |= MSG_DONTWAIT;
 
+		if (unlikely(flags & SPLICE_F_ZC) && ubuf_info) {
+			msg.msg_flags = MSG_ZEROCOPY;
+			msg.msg_ubuf = ubuf_info;
+		}
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
 		ret = sock_sendmsg(sock, &msg);
@@ -1223,12 +1228,27 @@ static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
+	if (unlikely(flags & SPLICE_F_ZC)) {
+		struct socket *sock = sock_from_file(out);
+		struct sock *sk = sock->sk;
+		struct ubuf_info *ubuf_info;
+
+		ubuf_info = msg_zerocopy_realloc(sk, len, NULL);
+		if (!ubuf_info)
+			return -ENOMEM;
+		sd.ubuf_info = ubuf_info;
+	}
+
 	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
+	if (unlikely(flags & SPLICE_F_ZC))
+		refcount_dec(&sd.ubuf_info->refcnt);
+
 	return ret;
 }
+
 /**
  * do_splice_direct - splices data directly between two files
  * @in:		file to splice from
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 7477df3916e2..a88588cf2754 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -21,8 +21,9 @@
 				 /* from/to, of course */
 #define SPLICE_F_MORE	(0x04)	/* expect more data */
 #define SPLICE_F_GIFT	(0x08)	/* pages passed in are a gift */
+#define SPLICE_F_ZC	(0x10)  /* generate zero copy notifications */
 
-#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
+#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|SPLICE_F_ZC)
 
 /*
  * Passed to the actors
-- 
2.43.0


