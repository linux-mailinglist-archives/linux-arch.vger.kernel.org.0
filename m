Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222036BD097
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 14:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCPNRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCPNRb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 09:17:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C348CC309
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 06:17:09 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 04F0A4460C
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678972627;
        bh=TIeBauVImjPXzYAvRcfNoVw+yoh5HGBy0fsQQgD7rqw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=v4NqjHj4vQtMvb9kBDCnXFISl7X34j04GEY5FUdntK+j0LvR3G7Ty/fbjfXFM0yB2
         SVFssw5JcYMBt/yOq8ie8w7RmlFQxXfRqL8FHQccnDQW0YowGra0yuJ2Bi2LzKzod9
         YFuZm/JHMTwl4/EXHjXAv1Ql4ccwGmcQp7taDJPb7hBEGdTereIyYVmEnSwjAeuTC/
         f9rAOTVYZl8soxe0+FnhnguYUSmmI4nbSadAeGzfWdQGUoQRv3pEqiNk0r0Z6RSCQ9
         vJ2uaXFqG2BwFhFlytIXyv3jnOiuYkujf94ttZjQO89wK2k2j9s63JkFafEzLbxBiw
         a0Vk628x2kJQQ==
Received: by mail-ed1-f71.google.com with SMTP id z14-20020a05640235ce00b004e07ddbc2f8so3009340edc.7
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2023 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIeBauVImjPXzYAvRcfNoVw+yoh5HGBy0fsQQgD7rqw=;
        b=hjxS98npQdlS7tN36+MWYBfWr51UeiUiwgnEJjahsi1VAjyxCJxQ0SxNpAgiq+qx3E
         grjrxAYIv9qPWC+9PFLsEloEYqCjg+drTCsMEFN5+l6HnXeqmU3vAlvSs2QCtexts+F0
         yHZH9TGDU1LL1QFde3FYbxnD+EtxWFhSZyujbLw9qLd8MpKZHZ0QsvI5pQavXud8frbA
         Q40rOU070gNcxMqVoT1vHJOaHUGVOdLSS0cDd6dZ9SfX1Wmyu6MxRKTxhS9v9LtnOBED
         5AU9S7P7QSLRybNE/YtewJ6RlZVznajVAHGs+1lnEse+SLfqwY32pdrXFZNMGRpv5Y0/
         ItYA==
X-Gm-Message-State: AO0yUKVpDw5cO2rmRM0VajeZ8d2b2n36VmPg0g0ApnqxqzCbB9Hgv5MI
        SAwtbLvHtJ9MRlRzkE2RzdYTtq3XE808Om2EpmFFr6W0W3AO6DJM99ov2Z97+qmcnnaUQuCztyU
        kDa1XBJ3WG/H5OZh0JhcTud3LoY002I+JwOAP2ho=
X-Received: by 2002:a05:6402:10d3:b0:4fd:8333:e29f with SMTP id p19-20020a05640210d300b004fd8333e29fmr6590982edu.41.1678972625681;
        Thu, 16 Mar 2023 06:17:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set/d6Gqh8ZNR1f9QpudCgLyrB70ZekM7LGV0RQ4Y3rmXQsXKlMCP87/MWnPkD7pWqvlcSjtrbA==
X-Received: by 2002:a05:6402:10d3:b0:4fd:8333:e29f with SMTP id p19-20020a05640210d300b004fd8333e29fmr6590950edu.41.1678972625375;
        Thu, 16 Mar 2023 06:17:05 -0700 (PDT)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:5e7c:880e:420d:8cc7])
        by smtp.gmail.com with ESMTPSA id d20-20020a50cd54000000b004fd1ee3f723sm3812336edj.67.2023.03.16.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:17:04 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH net-next 2/3] net: core: add getsockopt SO_PEERPIDFD
Date:   Thu, 16 Mar 2023 14:15:25 +0100
Message-Id: <20230316131526.283569-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316131526.283569-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230316131526.283569-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
This thing is direct analog of SO_PEERCRED which allows to get plain PID.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 arch/alpha/include/uapi/asm/socket.h    |  1 +
 arch/mips/include/uapi/asm/socket.h     |  1 +
 arch/parisc/include/uapi/asm/socket.h   |  1 +
 arch/sparc/include/uapi/asm/socket.h    |  1 +
 include/uapi/asm-generic/socket.h       |  1 +
 net/core/sock.c                         | 24 ++++++++++++++++++++++++
 tools/include/uapi/asm-generic/socket.h |  1 +
 7 files changed, 30 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index ff310613ae64..e94f621903fe 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -138,6 +138,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 762dcb80e4ec..60ebaed28a4c 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -149,6 +149,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index df16a3e16d64..be264c2b1a11 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -130,6 +130,7 @@
 #define SO_RCVMARK		0x4049
 
 #define SO_PASSPIDFD		0x404A
+#define SO_PEERPIDFD		0x404B
 
 #if !defined(__KERNEL__)
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 6e2847804fea..682da3714686 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -131,6 +131,7 @@
 #define SO_RCVMARK               0x0054
 
 #define SO_PASSPIDFD             0x0055
+#define SO_PEERPIDFD             0x0056
 
 #if !defined(__KERNEL__)
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index b76169fdb80b..8ce8a39a1e5f 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -133,6 +133,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 3f974246ba3e..3aa1ccd4bcf3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1763,6 +1763,30 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		goto lenout;
 	}
 
+	case SO_PEERPIDFD:
+	{
+		struct pid *peer_pid;
+		int pidfd;
+		if (len > sizeof(pidfd))
+			len = sizeof(pidfd);
+
+		spin_lock(&sk->sk_peer_lock);
+		peer_pid = get_pid(sk->sk_peer_pid);
+		spin_unlock(&sk->sk_peer_lock);
+
+		if (!peer_pid ||
+		    !pid_has_task(peer_pid, PIDTYPE_TGID))
+			pidfd = -ESRCH;
+		else
+			pidfd = pidfd_create(peer_pid, 0);
+
+		put_pid(peer_pid);
+
+		if (copy_to_sockptr(optval, &pidfd, len))
+			return -EFAULT;
+		goto lenout;
+	}
+
 	case SO_PEERGROUPS:
 	{
 		const struct cred *cred;
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index fbbc4bf53ee3..54d9c8bf7c55 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -122,6 +122,7 @@
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
+#define SO_PEERPIDFD		77
 
 #if !defined(__KERNEL__)
 
-- 
2.34.1

