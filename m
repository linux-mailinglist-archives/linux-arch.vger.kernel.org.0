Return-Path: <linux-arch+bounces-15822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29BD2BBF4
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 06:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C98302C4F7
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 05:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ADF34D91C;
	Fri, 16 Jan 2026 05:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJvglZt2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822F34C83C
	for <linux-arch@vger.kernel.org>; Fri, 16 Jan 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768539812; cv=none; b=a8iQZhegSr2N3W0UIA+1INw87+Z1hqEaVD1EVViwy1wB+TJWACV/LWBvVnYtVs6EsWeVAQqxpH4/44lLaLIdDel6e7ensc5TfB4JHFxbWcgBzBFiuCqRwRyIhHrFbr0f6+b7e2whiYVzKn64Q1cMFLwewJMnNSM2ix7MEdHzh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768539812; c=relaxed/simple;
	bh=s3BhnRo4qYeui2ODW6ff8S6N7tSfK9I74K29oR3s67M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWfP/Qa0CfHQ30HksbFIULwUOOKpELA9pD8Eg0yNLSDhhFnp/ivSkQfMA+tZfJsRpDAIh/iZAqNgNXDbcUyn7ij5xwt5AoE6KApdPXuLuAXCFgiSU075A1wNpaHDFdh9qaJnTUOqyJc3DoaJ2SpczXW70mmezi8BbAlnIOBiryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJvglZt2; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64669a2ecb5so1877134d50.1
        for <linux-arch@vger.kernel.org>; Thu, 15 Jan 2026 21:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768539801; x=1769144601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+I56CVp15hcfRzFNLZYMGassuBp58/sVTYq1ymlLks=;
        b=BJvglZt2EHUWZv3P2Z5dXbAAF5ohuFFr0vlbMVfB/ewM9z6S95XtSXAU5S+hjlaneV
         w6mNPh2RPODTngH1nCrwsSNqIzeZ/KQMfZc9+jNlrV9Gag06Koqafxzs6V7EB83c65S7
         0iXs95woS82onCi+0K70TfBTZ8ngPh0vf5oOzLfA3f26SiuG0UPg1zkX7TvqmvnL8Z9s
         oUgiQGYSaCkYc2zwzFHkvA3AIvXPHp433pPVg754O7vUElhH3oJiiER6widNMLlwIEy0
         Iej+iKBAofWwGA0pR8ky/DzgrFzk++1p3TlOAUsUC2N3/lzrMbfi0CanUZ7H7CWDg1Jh
         UvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768539801; x=1769144601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K+I56CVp15hcfRzFNLZYMGassuBp58/sVTYq1ymlLks=;
        b=TaNcHQUhvrBG1tdDJaxFz5YLsNmTJ1V6E/IqXZABDz716N4gWuhfExbxifggsDTq8m
         4gjLMVK5Tcj04/t9iD40l0nbZNgl7tcdlaUOm3f0mOJmQB/02h9/w3NBUHMggj/cYGSj
         oqYFcBCPCiE45R7gCdi4/YoHRh52niu0ByKqk/V9kvLLnJYImnl8VCmJtr/70Nmvcueb
         +oVkTO2ITzlkpM8MyC/cWLS8QyKtwusDRfeKVkRUx7WF4b+nC+hwHNp3VVGLNata39N1
         lvx+NGxjWArlgSeTLr2a0OI8BD97J35E4HsFzdz5+rVwDFzvqGliUYRZseMRZ6lpSJUF
         1juw==
X-Forwarded-Encrypted: i=1; AJvYcCU94Npms9NmFPPpZt2OLlGfy24tlA6JidvmsooOzX0ny50myCq6/iGpTTITbnqTk5bdI5XQFlxpiBcS@vger.kernel.org
X-Gm-Message-State: AOJu0YwGl/sCT3QinN2g7LaANTp9bpaTim1JoDvflE4iozusxqXnhKEx
	AlZZ+3wdEwmmfMEf0g45Mzrz1ZdIwu3LZVgIQZHEDFz+Rw84rS1vXMBu
X-Gm-Gg: AY/fxX4Hl4ReatDCtHArVQs2iDbwpKxKG5n3/W0MFIQ726QbGGqqcA5jBx31GfC3uaT
	d19trT85RdJErBFfnIT/6MzztCTpx5yqu2K8xfeulrFUSR3PSwwbMthK5GSzHAEImC59EhB/6az
	22b0ZlXshThZgRAi/C+96LeBAo07k6SWqeuLKKzSBAYRYgn5PLrReIQiVDj1v3l9Chrs7YT8nI2
	Vrf7ILoycsU0VMEWOJ4lfVvEkhQuHRIQxZPM2NZwG6AQe6eoM/TheR9hTDrB++s3co5gjqTpT34
	wACZ2XGUBK7o1NtlQa1EOoX3JL2Q+qlWt83alKMRilywWFPrKCyKTTWZBz+VWL6v0IlQij3wdrw
	5VF9lbxLSPuB4Cc5FgottTKqdFfg+CbIsSjeFjN+Y8Uu3muzRay4Ny87i1BHndkFbJwIgSS+dVc
	QGj4DeKzYy
X-Received: by 2002:a53:ac89:0:b0:645:5ac1:8ca with SMTP id 956f58d0204a3-6491691b79amr1489058d50.11.1768539800827;
        Thu, 15 Jan 2026 21:03:20 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170be5desm713936d50.19.2026.01.15.21.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:03:20 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 15 Jan 2026 21:02:15 -0800
Subject: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
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

Update devmem.rst documentation to describe the autorelease netlink
attribute used during RX dmabuf binding.

The autorelease attribute is specified at bind-time via the netlink API
(NETDEV_CMD_BIND_RX) and controls what happens to outstanding tokens
when the socket closes.

Document the two token release modes (automatic vs manual), how to
configure the binding for autorelease, the perf benefits, new caveats
and restrictions, and the way the mode is enforced system-wide.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- Document netlink instead of sockopt
- Mention system-wide locked to one mode
---
 Documentation/networking/devmem.rst | 73 +++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
index a6cd7236bfbd..f85f1dcc9621 100644
--- a/Documentation/networking/devmem.rst
+++ b/Documentation/networking/devmem.rst
@@ -235,6 +235,79 @@ can be less than the tokens provided by the user in case of:
 (a) an internal kernel leak bug.
 (b) the user passed more than 1024 frags.
 
+
+Autorelease Control
+~~~~~~~~~~~~~~~~~~~
+
+The autorelease mode controls what happens to outstanding tokens (tokens not
+released via SO_DEVMEM_DONTNEED) when the socket closes. Autorelease is
+configured per-binding at binding creation time via the netlink API::
+
+	struct netdev_bind_rx_req *req;
+	struct netdev_bind_rx_rsp *rsp;
+	struct ynl_sock *ys;
+	struct ynl_error yerr;
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+
+	req = netdev_bind_rx_req_alloc();
+	netdev_bind_rx_req_set_ifindex(req, ifindex);
+	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
+	netdev_bind_rx_req_set_autorelease(req, 0); /* 0 = manual, 1 = auto */
+	__netdev_bind_rx_req_set_queues(req, queues, n_queues);
+
+	rsp = netdev_bind_rx(ys, req);
+
+	dmabuf_id = rsp->id;
+
+When autorelease is disabled (0):
+
+- Outstanding tokens are NOT released when the socket closes
+- Outstanding tokens are only released when all RX queues are unbound AND all
+  sockets that called recvmsg() are closed
+- Provides better performance by eliminating xarray overhead (~13% CPU reduction)
+- Kernel tracks tokens via atomic reference counters in net_iov structures
+
+When autorelease is enabled (1):
+
+- Outstanding tokens are automatically released when the socket closes
+- Backwards compatible behavior
+- Kernel tracks tokens in an xarray per socket
+
+The default is autorelease disabled.
+
+Important: In both modes, applications should call SO_DEVMEM_DONTNEED to
+return tokens as soon as they are done processing. The autorelease setting only
+affects what happens to tokens that are still outstanding when close() is called.
+
+The mode is enforced system-wide. Once a binding is created with a specific
+autorelease mode, all subsequent bindings system-wide must use the same mode.
+
+
+Performance Considerations
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Disabling autorelease provides approximately ~13% CPU utilization improvement
+in RX workloads. That said, applications must ensure all tokens are released
+via SO_DEVMEM_DONTNEED before closing the socket, otherwise the backing pages
+will remain pinned until all RX queues are unbound AND all sockets that called
+recvmsg() are closed.
+
+
+Caveats
+~~~~~~~
+
+- Once a system-wide autorelease mode is selected (via the first binding),
+  all subsequent bindings must use the same mode. Attempts to create bindings
+  with a different mode will be rejected with -EBUSY.
+
+- Applications using manual release mode (autorelease=0) must ensure all tokens
+  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
+  leaks during the lifetime of the dmabuf binding. Tokens not released before
+  close() will only be freed when all RX queues are unbound AND all sockets
+  that called recvmsg() are closed.
+
+
 TX Interface
 ============
 

-- 
2.47.3


