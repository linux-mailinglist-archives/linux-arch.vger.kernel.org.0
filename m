Return-Path: <linux-arch+bounces-15735-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9ABD0CCE0
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 03:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 374EA3029C07
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE12580D7;
	Sat, 10 Jan 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmh4gQv6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB1227BB9
	for <linux-arch@vger.kernel.org>; Sat, 10 Jan 2026 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011544; cv=none; b=e1Dl124qXcPjqHR5r3X0/w3yH2B2MVEVSK+CtuOewd3Qc7ipwPuOxF7e+abJoMLl358xc3gHKJLNwSwn85u8UVsmvsdX7EgKLjhuwCWoLZ7HhMz3F5E+/tDV9oYdNL/zWwv8u0bbGds3asTwTNUfxt8hvu2R9vLJkd/jaGEROSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011544; c=relaxed/simple;
	bh=/8irlWx212MZNFNuTQquG/o/4qXs4GzUcqgDeIkWkeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSDyfvOK3D3CvnqaVHtSdRMdAviTTagmC2VoVtfoEzaViPFKrJwetkZhuas1J7qn5Eoqt5V6FYCUmOmJC6n38ZyBXQ8n2ZdkEtbWeY/nyCkmqHeeQPKGuvb2yta5wiiiMS/7iP22YVioup+Oz2pjtvz6kOf6Xic6oLdqd/8brGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmh4gQv6; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6467ac59e16so3585760d50.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Jan 2026 18:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768011542; x=1768616342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJwRH55S+4zS4rc7LIeDbyFWVKjFx7zOxvxC4DTtZFU=;
        b=Pmh4gQv6CDB0sn4MOfoJNJplhGdYkdl806mn+HX/jQdzPnHdNtrmIAkAo6WQeipPFj
         q9IP8/gve/ApA78ioiaTE2hknb/mgSj2O66aYQia5uxObrhYl3SKgYdWUGtyM9GUoHIp
         YgdmgchvIoPttlKzKoVZXqls4rg02rtkJuweYqJSeD2oyD5i2I82qZhEKy6Mczv/KMBl
         CFkzK0QFpNV2jpONeDQsqjBid0Eclzv7/ESnvQriZUGTGIez7szNmuh+x3NKf5eGMRyC
         bntgEz+0P95+q2V4sfu5TeyGDkHRG9/cwbCJXisuHKvThcw/lwl+Y9e8bkDwUdV2KN07
         GNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768011542; x=1768616342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJwRH55S+4zS4rc7LIeDbyFWVKjFx7zOxvxC4DTtZFU=;
        b=KFIxeH0CA2TrJG1sidFeTO8KlbbSeXjNP4VzXydtvzHOceVRkRehgW01HBwTNgLB/t
         9osXJA2kCC0J9ycx9ne5VbYpHK9DNBp8z5sE4RD6jTUO51RLDMXt9tIde2bVmru1801t
         XtClT4141mA7jDK6ZMzTK8fhs+xi/6lpu9SmgK70zYwsuQme3WI3b1fbHD13+Q7ddJ0s
         93aJxapxKe7jTek9NuleTjWrk4j/yKsCISyrlqn4ZPDnm0Ze3hXUOB2uwThSHl1vxUDg
         fgfUbi+bYdeAkZFdSl75AJ1QGmx9p5Tku/QYB/xJ4GeklsLQ0OLdPzZD5fIE1ziDDCdi
         2mLw==
X-Forwarded-Encrypted: i=1; AJvYcCXO6yoymOoIyJtKPnV1OKDRvebs9Ng1xz0fP+osGgw+gjRQRGbTaQ8IBPDyqKc0acfwvkIdmVxe04gu@vger.kernel.org
X-Gm-Message-State: AOJu0YwraVrEEn7tWa+4mQtkZttpdGhMpdC7idGWgHEC95FzL52R/oQ7
	ztqbrhnBqwM7j9YcCWLTQI7qfv1O3CACOlpNS1y+j1EXW7HhCmPm3y6C
X-Gm-Gg: AY/fxX70M6RdKA3e0dsBKn16xbOyG5KplvuYXSOQFiTq2a3yi5pf1lBIndDOcfOEnAl
	5XzGaj1iugtItY43o005PXZx43JLOXhv4CwV+dGqfB9M/oYRSRUbP/rIKHdZkkGo8Mk/7OvaPFu
	GZmZlTWAffv5ARiAE7rusojIIoShAj40xMN8s5T3FWzklprhKr4bVBG83yOhOaaBDuUtGE8FcA/
	wJYRQsA0ZVZ+LqUro7DcEEoCQbTy9TVWvk+AiKIWLjY+ztHe37pGFQfRddxBziuv9wroU1/RGFa
	Z9WU6OdJ3GL3mbgIo1RoqpBp73dg3gIIF3AMDdpE7tHLnvqlT2me05lWymMraZ0OsejWvlhNWGb
	J98N4UA2pA36nUU5xsEMQVtw3UBx1zWnw5UVwLww3eGkJkz2Gb9enSEHqTybEh0moxDw3k88HKU
	PTJhGzd9C6vw==
X-Google-Smtp-Source: AGHT+IFOmZSfq1+B/UIacsFnpLVgmv9FPVdwArttfHVymmNEdJMthIaDrn+0zcXw3EHB1ioYKpS2zw==
X-Received: by 2002:a53:e319:0:b0:644:7b34:7bd2 with SMTP id 956f58d0204a3-64716c804d2mr7062728d50.75.1768011541886;
        Fri, 09 Jan 2026 18:19:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b241csm5204761d50.19.2026.01.09.18.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:19:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 09 Jan 2026 18:18:16 -0800
Subject: [PATCH net-next v9 2/5] net: devmem: refactor sock_devmem_dontneed
 for autorelease split
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-2-8042930d00d7@meta.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Refactor sock_devmem_dontneed() in preparation for supporting both
autorelease and manual token release modes.

Split the function into two parts:
- sock_devmem_dontneed(): handles input validation, token allocation,
  and copying from userspace
- sock_devmem_dontneed_autorelease(): performs the actual token release
  via xarray lookup and page pool put

This separation allows a future commit to add a parallel
sock_devmem_dontneed_manual_release() function that uses a different
token tracking mechanism (per-niov reference counting) without
duplicating the input validation logic.

The refactoring is purely mechanical with no functional change. Only
intended to minimize the noise in subsequent patches.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/core/sock.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index a1c8b47b0d56..f6526f43aa6e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1082,30 +1082,13 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_FRAGS 1024
 
 static noinline_for_stack int
-sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
+				 unsigned int num_tokens)
 {
-	unsigned int num_tokens, i, j, k, netmem_num = 0;
-	struct dmabuf_token *tokens;
+	unsigned int i, j, k, netmem_num = 0;
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
 
-	if (!sk_is_tcp(sk))
-		return -EBADF;
-
-	if (optlen % sizeof(*tokens) ||
-	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
-		return -EINVAL;
-
-	num_tokens = optlen / sizeof(*tokens);
-	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
-	if (!tokens)
-		return -ENOMEM;
-
-	if (copy_from_sockptr(tokens, optval, optlen)) {
-		kvfree(tokens);
-		return -EFAULT;
-	}
-
 	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
@@ -1135,6 +1118,35 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
+	return ret;
+}
+
+static noinline_for_stack int
+sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
+{
+	struct dmabuf_token *tokens;
+	unsigned int num_tokens;
+	int ret;
+
+	if (!sk_is_tcp(sk))
+		return -EBADF;
+
+	if (optlen % sizeof(*tokens) ||
+	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
+		return -EINVAL;
+
+	num_tokens = optlen / sizeof(*tokens);
+	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
+	if (!tokens)
+		return -ENOMEM;
+
+	if (copy_from_sockptr(tokens, optval, optlen)) {
+		kvfree(tokens);
+		return -EFAULT;
+	}
+
+	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+
 	kvfree(tokens);
 	return ret;
 }

-- 
2.47.3


