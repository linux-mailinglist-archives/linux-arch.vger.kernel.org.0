Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0F6DD81C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDKKnb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDKKnZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 06:43:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50B3588
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 03:43:21 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9CBC43F23C
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681209800;
        bh=a+6gxbvn4hYwO5enGV6t44vz4Ixp1BNaXg7ewl6XAKs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=etClHLvaMSvWEG3YGfzCx9n/Y5As7kOUXYqQM2/azBQTR2sPDf0jt2pJuvqiCHelQ
         hRoc4N3yUnb68JEi1DoAAxhoimj2XPsAhbHmRnua0o2M1gme7nESODcznW1cAn760F
         Dd2BOD4dSF5cz2m9kYSFdsL4/nBcobjv6Z/dQ/deg0JE8+ha6mvd2VTcL0VtOK4nMp
         LrJl4LiR22bpq0Ix2FZrUX5oAq2JvUTpbDqG8Stxufl1twW7Y6GxsLOJ76WF5FVazP
         dSRx1UUFo2WYmBLtHDMfOwpqG0wahniby6HuiuM4kp4kOl4cwO7YTI2u19Cj8F2RUS
         kpKely6rQgpig==
Received: by mail-ej1-f69.google.com with SMTP id tx6-20020a1709078e8600b009343596918cso2334272ejc.16
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 03:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+6gxbvn4hYwO5enGV6t44vz4Ixp1BNaXg7ewl6XAKs=;
        b=m68t5ts0y+3QzmZlRmuuDk3VcHD2lsNEMsERXatSXD4EXPmjU3pfjtbPyEZlp6WbRM
         nwVG2qZQ+HIj3GLNR+Ko7n6fXWqLV9gGPLiTF6RH70epFyTVdnwN1DltXf9gMPbXEKUk
         Nio56Zv7SmfjTioEH7IdLxOGi00aVNxgHMxvvOywblYcFrccTIVRwQA8nASv8hfNfx9z
         Ebbq3mp/O5y2A+qI5ieTSMNcpcI1WajxMANpRfbq8Bu8UrB1xJlobnKfx71gw6TLqEeZ
         dJmBi8a7ixf+pkp2Ct52GoNenqvD7Qx1iQZxXdx5jtpFoEpC29RFXCNUwD8nGEDUokT4
         LrQQ==
X-Gm-Message-State: AAQBX9f9tONu4Q2SX4WlDAXdpT1isOgJCw4UO8cKzv/ackT6IWAKRrhq
        wnd0r4CQB6JAnBEfTfJt6SHZKBrOiNVbC99mEJ7Z8jKIjroWqYiXEIlSP5vt/QjFx1VBhpMd+xM
        UvUO6QLo59H8hPWWgxiN/VbEdi9rt2NEmAp8QwDE=
X-Received: by 2002:a17:906:a859:b0:94c:784f:7569 with SMTP id dx25-20020a170906a85900b0094c784f7569mr4265427ejb.30.1681209800371;
        Tue, 11 Apr 2023 03:43:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZqUXeqS9O98LMdWi8cTD/jnZQD62JAh31WY6ycJqD3j95xAzxzQ0fKW3ItweqMjoUkTG9epQ==
X-Received: by 2002:a17:906:a859:b0:94c:784f:7569 with SMTP id dx25-20020a170906a85900b0094c784f7569mr4265406ejb.30.1681209799970;
        Tue, 11 Apr 2023 03:43:19 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id ne7-20020a1709077b8700b00948c320fcfdsm5921805ejc.202.2023.04.11.03.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:43:19 -0700 (PDT)
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
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>, linux-arch@vger.kernel.org
Subject: [PATCH net-next v3 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
Date:   Tue, 11 Apr 2023 12:42:28 +0200
Message-Id: <20230411104231.160837-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411104231.160837-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230411104231.160837-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
but it contains pidfd instead of plain pid, which allows programmers not
to care about PID reuse problem.

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Big thanks to Christian Brauner and Lennart Poettering for productive
discussions about this.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Tested-by: Luca Boccassi <bluca@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	According to review comments from Kuniyuki Iwashima and Christian Brauner:
	- use pidfd_create(..) retval as a result
	- whitespace change
---
 arch/alpha/include/uapi/asm/socket.h    |  2 ++
 arch/mips/include/uapi/asm/socket.h     |  2 ++
 arch/parisc/include/uapi/asm/socket.h   |  2 ++
 arch/sparc/include/uapi/asm/socket.h    |  2 ++
 include/linux/net.h                     |  1 +
 include/linux/socket.h                  |  1 +
 include/net/scm.h                       | 14 ++++++++++++--
 include/uapi/asm-generic/socket.h       |  2 ++
 net/core/sock.c                         | 11 +++++++++++
 net/mptcp/sockopt.c                     |  1 +
 net/unix/af_unix.c                      | 18 +++++++++++++-----
 tools/include/uapi/asm-generic/socket.h |  2 ++
 12 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 739891b94136..ff310613ae64 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -137,6 +137,8 @@
 
 #define SO_RCVMARK		75
 
+#define SO_PASSPIDFD		76
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 18f3d95ecfec..762dcb80e4ec 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -148,6 +148,8 @@
 
 #define SO_RCVMARK		75
 
+#define SO_PASSPIDFD		76
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f486d3dfb6bb..df16a3e16d64 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -129,6 +129,8 @@
 
 #define SO_RCVMARK		0x4049
 
+#define SO_PASSPIDFD		0x404A
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 2fda57a3ea86..6e2847804fea 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -130,6 +130,8 @@
 
 #define SO_RCVMARK               0x0054
 
+#define SO_PASSPIDFD             0x0055
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/net.h b/include/linux/net.h
index b73ad8e3c212..c234dfbe7a30 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -43,6 +43,7 @@ struct net;
 #define SOCK_PASSSEC		4
 #define SOCK_SUPPORT_ZC		5
 #define SOCK_CUSTOM_SOCKOPT	6
+#define SOCK_PASSPIDFD		7
 
 #ifndef ARCH_HAS_SOCKET_TYPES
 /**
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 13c3a237b9c9..6bf90f251910 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -177,6 +177,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
 #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
 #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
 #define SCM_SECURITY	0x03		/* rw: security label		*/
+#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
 
 struct ucred {
 	__u32	pid;
diff --git a/include/net/scm.h b/include/net/scm.h
index 585adc1346bd..0c717ae9c8db 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -124,8 +124,9 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
-		    scm_has_secdata(sock))
+		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
+		    test_bit(SOCK_PASSPIDFD, &sock->flags) ||
+		    scm->fp || scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
@@ -141,6 +142,15 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
 	}
 
+	if (test_bit(SOCK_PASSPIDFD, &sock->flags)) {
+		int pidfd;
+
+		WARN_ON_ONCE(!scm->pid);
+		pidfd = pidfd_create(scm->pid, 0);
+
+		put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd);
+	}
+
 	scm_destroy_cred(scm);
 
 	scm_passec(sock, msg, scm);
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 638230899e98..b76169fdb80b 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -132,6 +132,8 @@
 
 #define SO_RCVMARK		75
 
+#define SO_PASSPIDFD		76
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index c25888795390..3f974246ba3e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1246,6 +1246,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			clear_bit(SOCK_PASSCRED, &sock->flags);
 		break;
 
+	case SO_PASSPIDFD:
+		if (valbool)
+			set_bit(SOCK_PASSPIDFD, &sock->flags);
+		else
+			clear_bit(SOCK_PASSPIDFD, &sock->flags);
+		break;
+
 	case SO_TIMESTAMP_OLD:
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
@@ -1737,6 +1744,10 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = !!test_bit(SOCK_PASSCRED, &sock->flags);
 		break;
 
+	case SO_PASSPIDFD:
+		v.val = !!test_bit(SOCK_PASSPIDFD, &sock->flags);
+		break;
+
 	case SO_PEERCRED:
 	{
 		struct ucred peercred;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b655cebda0f3..67be0558862f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -355,6 +355,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_BROADCAST:
 	case SO_BSDCOMPAT:
 	case SO_PASSCRED:
+	case SO_PASSPIDFD:
 	case SO_PASSSEC:
 	case SO_RXQ_OVFL:
 	case SO_WIFI_STATUS:
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fb31e8a4409e..6d5dff4dfe83 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1361,7 +1361,8 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			goto out;
 
-		if (test_bit(SOCK_PASSCRED, &sock->flags) &&
+		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
+		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
 		    !unix_sk(sk)->addr) {
 			err = unix_autobind(sk);
 			if (err)
@@ -1469,7 +1470,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (err)
 		goto out;
 
-	if (test_bit(SOCK_PASSCRED, &sock->flags) && !u->addr) {
+	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -1670,6 +1672,8 @@ static void unix_sock_inherit_flags(const struct socket *old,
 {
 	if (test_bit(SOCK_PASSCRED, &old->flags))
 		set_bit(SOCK_PASSCRED, &new->flags);
+	if (test_bit(SOCK_PASSPIDFD, &old->flags))
+		set_bit(SOCK_PASSPIDFD, &new->flags);
 	if (test_bit(SOCK_PASSSEC, &old->flags))
 		set_bit(SOCK_PASSSEC, &new->flags);
 }
@@ -1819,8 +1823,10 @@ static bool unix_passcred_enabled(const struct socket *sock,
 				  const struct sock *other)
 {
 	return test_bit(SOCK_PASSCRED, &sock->flags) ||
+	       test_bit(SOCK_PASSPIDFD, &sock->flags) ||
 	       !other->sk_socket ||
-	       test_bit(SOCK_PASSCRED, &other->sk_socket->flags);
+	       test_bit(SOCK_PASSCRED, &other->sk_socket->flags) ||
+	       test_bit(SOCK_PASSPIDFD, &other->sk_socket->flags);
 }
 
 /*
@@ -1922,7 +1928,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out;
 	}
 
-	if (test_bit(SOCK_PASSCRED, &sock->flags) && !u->addr) {
+	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -2824,7 +2831,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			/* Never glue messages from different writers */
 			if (!unix_skb_scm_eq(skb, &scm))
 				break;
-		} else if (test_bit(SOCK_PASSCRED, &sock->flags)) {
+		} else if (test_bit(SOCK_PASSCRED, &sock->flags) ||
+			   test_bit(SOCK_PASSPIDFD, &sock->flags)) {
 			/* Copy credentials */
 			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
 			unix_set_secdata(&scm, skb);
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index 8756df13be50..fbbc4bf53ee3 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -121,6 +121,8 @@
 
 #define SO_RCVMARK		75
 
+#define SO_PASSPIDFD		76
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.34.1

