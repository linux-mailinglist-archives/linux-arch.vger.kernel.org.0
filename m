Return-Path: <linux-arch+bounces-14512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC10C33A5B
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69C118C66AB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CD26FDA6;
	Wed,  5 Nov 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs9ugeJJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BF24C077
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305811; cv=none; b=N/dx0lV2XsK8tfG2/pSnC7hi/SgbzVuhGjYxvFYnd9ZF1h3eJPZ8Joum2E4iQkG+At+WavQ/0LPN/AcIHF2PNt7/PgcQSc/1fiZjiRR1pu2turZddYU2BFay9m6KY7y4SRggX9cwChw6QndLWDMmfqUtDsOy8kHtPsa+weE4NMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305811; c=relaxed/simple;
	bh=9ZdVGaIt/OvZxDjCG8t0f5xRJnb5qgTQFaBNuCOVr0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5IzbH/M1agaSmCI7GuJSAaDcGiG9YlJIIDyDzXhghnydv36p0wgF/nrWDNSVA9GJQ81fyX82cnu4I1ACzC1pCgjkGPVaGaqn1rcBVUC0sK8wW96xWSiOdrVo9ZBYWo5/j7FgmubzW4O5jC9otsLXDEhchyVkrwIRYLOvroL0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs9ugeJJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786a85a68c6so1218797b3.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 17:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305808; x=1762910608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXQPAkEgQbO8euIcwuGERIBFcD6kBEPGrPcFSGxSLm8=;
        b=cs9ugeJJrOPiGhprQlaFybPw90yy1tKkHgTW4e2KCR4YsIyQEVt96vg/NXcY6lihGc
         Ag4CZaDgiBu9IYRtlgOvW60JEyl+7OdB+52qv3Dhmh1gqM9n7OIAc1e51qmaqe0OM/Jl
         cAOgPDsxcV04FsI4KPeX/gu5W7QEw3rZ64Syn4YItgFYRQRsUGst7BKOk+AosltjfkZ8
         OZ4sbaYO8iVfv8Q8QMn+39OKujZCUrI2GGP6WP6iJxu5Ia7e15+GTfJNQkya+OxYgdp6
         ST9Q8GD4g76No5HggNmx+3NWbXfi6RwJhMxWlwUkQZnULPp4YjTq0hZ1DpnfkWteCiHo
         Ip9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305808; x=1762910608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXQPAkEgQbO8euIcwuGERIBFcD6kBEPGrPcFSGxSLm8=;
        b=TBUH4D7sPp4Tz7cbKjudsVTlKF5EqkcuEDBh4+f45WWbpXjRoeCStWPaW02UPth7ou
         m/1qGj1EYzMsP7HAVxLrbi/73+17vUJJcE/Yk5ILYsTGA89mbxDAcDEizyvwNDqJvKaB
         PVRXxyLqWRMfzND52AVvdkINn/4d1vr7y/StI7Uuk07iifP2HB1iYFOJUlHVDQ3p5N02
         OCAVvBgH8/J8Z3e8tQs2VUMTsutezFUhFEq5AHtBnyuGsHyaZCv0IZMPJvlqWAmRWMJY
         iJHfrvBTtZYCwufUOkgijz0UGWmSqZ2wCy/eha22tcqXhWW6P66y8dRAWyH7J+5xnKdx
         VCcg==
X-Forwarded-Encrypted: i=1; AJvYcCWtuOFDxyJ01AVq3ONgFpWbOIv4gViJJw+Mwil4qvjTfwpLNAQ8UB2i6uVPmnijIfoKQZqaWTxX5+73@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYp4BlkgRyiCMuhBsyY77yMbBMglJvhqEuJ+IDM0YDrD6dLF4
	QTkbb23e4nMKkaKlzNGf8IYOzyV1DrYvcbJbpGmkzoGiJgIz2bJ7aKcP
X-Gm-Gg: ASbGncsN6xZxrBLrfBcoaLv1ePssVcm6hN6wrgtelG7g0jgBvlBfYHVrDTXSy8gkbpr
	Ko45TquNaIci8/eA4jYpIuhMkxbMQA7NG9pMIkCh0QsR3fgE9lcJQ9S+pLHF6EOO6lZW4L8xMuo
	BkpJdyp0tza+tyt0JiTO5yNTbMc+ZCIP2PQYibY1ydXuZBKOJSd5o+GkOyjKnH5WBCQaGu2LaS8
	pB80H1BzrqRVkFlq2WdsoyXSZjknSWna1MSX5+lzJRIZKCzE79FpqdaDD0H+bQjt5+VtYWtZjOp
	zVQdOEr2U5lQPbvv75CMppO+S3NmNzlXLMfPTN4nNpEoOOFynCiXLkXBmVRh32MoYp72ISjQRZo
	fElJ70ThzhD9qj6Pox3wk+UaLDglT1ME1Mv8zoOofeePWGo4O2BRijM+K+J+ylwJvRV/OLzDzB2
	fsq5AKkmWXboA=
X-Google-Smtp-Source: AGHT+IGmZcasptx2/HU85kDuwAXzBhZHQkoteu1oE0YpB1MwZKyvKWzYVmBym2flQTEn3Ob02W1r2A==
X-Received: by 2002:a05:690c:6311:b0:786:652d:50e with SMTP id 00721157ae682-786a419d7d6mr14885297b3.37.1762305807568;
        Tue, 04 Nov 2025 17:23:27 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691db1369sm15259657b3.16.2025.11.04.17.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:27 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 17:23:24 -0800
Subject: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update devmem.rst documentation to describe the new SO_DEVMEM_AUTORELEASE
socket option and its usage.

Document the following:
- The two token release modes (automatic vs manual)
- How to use SO_DEVMEM_AUTORELEASE to control the behavior
- Performance benefits of disabling autorelease (~10% CPU reduction)
- Restrictions and caveats of manual token release
- Usage examples for both getsockopt and setsockopt

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/networking/devmem.rst | 70 +++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a6cd7236bfbd..1bfce686dce6 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -215,8 +215,8 @@ Freeing frags
 -------------
 
 Frags received via SCM_DEVMEM_DMABUF are pinned by the kernel while the user
-processes the frag. The user must return the frag to the kernel via
-SO_DEVMEM_DONTNEED::
+processes the frag. Users should return tokens to the kernel via
+SO_DEVMEM_DONTNEED when they are done processing the data::
 
 	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_DONTNEED, &token,
 			 sizeof(token));
@@ -235,6 +235,72 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+
+Autorelease Control
+~~~~~~~~~~~~~~~~~~~
+
+The SO_DEVMEM_AUTORELEASE socket option controls what happens to outstanding
+tokens (tokens not released via SO_DEVMEM_DONTNEED) when the socket closes::
+
+	int autorelease = 0;  /* 0 = manual release, 1 = automatic release */
+	ret = setsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_AUTORELEASE,
+			 &autorelease, sizeof(autorelease));
+
+	/* Query current setting */
+	int current_val;
+	socklen_t len = sizeof(current_val);
+	ret = getsockopt(client_fd, SOL_SOCKET, SO_DEVMEM_AUTORELEASE,
+			 &current_val, &len);
+
+When autorelease is disabled (default):
+
+- Outstanding tokens are NOT released when the socket closes
+- Outstanding tokens are only released when the dmabuf is unbound
+- Provides better performance by eliminating xarray overhead (~10% CPU reduction)
+- Kernel tracks tokens via atomic reference counters in net_iov structures
+
+When autorelease is enabled:
+
+- Outstanding tokens are automatically released when the socket closes
+- Backwards compatible behavior
+- Kernel tracks tokens in an xarray per socket
+
+Important: In both modes, applications should call SO_DEVMEM_DONTNEED to
+return tokens as soon as they are done processing. The autorelease setting only
+affects what happens to tokens that are still outstanding when close() is called.
+
+The autorelease setting can only be changed when the socket has no outstanding
+tokens. If tokens are present, setsockopt returns -EBUSY.
+
+
+Performance Considerations
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Disabling autorelease provides approximately ~10% CPU utilization improvement in
+RX workloads by:
+
+- Eliminating xarray allocations and lookups for token tracking
+- Using atomic reference counters instead
+- Reducing lock contention on the xarray spinlock
+
+However, applications must ensure all tokens are released via
+SO_DEVMEM_DONTNEED before closing the socket, otherwise the backing pages will
+remain pinned until the dmabuf is unbound.
+
+
+Caveats
+~~~~~~~
+
+- With autorelease disabled, sockets cannot switch between different dmabuf
+  bindings. This restriction exists because tokens in this mode do not encode
+  the binding information necessary to perform the token release.
+
+- Applications using manual release mode (autorelease=0) must ensure all tokens
+  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
+  leaks during the lifetime of the dmabuf binding. Tokens not released before
+  close() will only be freed when the dmabuf is unbound.
+
+
 TX Interface
 ============
 

-- 
2.47.3


