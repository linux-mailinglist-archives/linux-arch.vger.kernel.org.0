Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3393E70BFA3
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjEVNZL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjEVNZD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 09:25:03 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E614121
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 06:24:59 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 409923F22C
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684761898;
        bh=APd4+p03lFcA5hUMjpaAHam/1HBLDUFobHfEuue1bOE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=A+ZOI2NbO2matLmJ/sAx8zutIyQCplEzPPjCKlkWOhhOsMbWLIMgf3UKXjjM7jrz+
         FvhENsyNDcgZ/oVFyYY1YGNm/1BLSmklO6j6IFW8s4kxyhUUO3SJw/UalqoIYj4afT
         G383Dsi1G2Rn9iZCYwhiyedhINdi1VP/SnJbCPfQA+V4RZtKQtBfYiHGlE//Rfg00H
         vL52hg9VZVakhxPBVHFkRjAojjc2IbTANTTZKvbxxxmJ2v12oAU6fEd7zCBHaky5bZ
         W1PP+HnE5Cu7T1Pe7a13YK9kwrYWIIVwxZ8dCAWT5BbN7r6Iqq5oA8xVPXtx/q0FjP
         HFNpOSusrqePQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-513ddd8e39cso1409276a12.2
        for <linux-arch@vger.kernel.org>; Mon, 22 May 2023 06:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684761895; x=1687353895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APd4+p03lFcA5hUMjpaAHam/1HBLDUFobHfEuue1bOE=;
        b=hX1q9RxZMe1TmjWczkiTlrw4+o0KMm3VIDw+q0Zykbn5hwxsk10tqHWJasA0eT9trP
         +WbdjAzHsKPeRamDviTccKIxYB/Ufk4mPezazqyOMeWDFvPJvWJ3m+7OmVKuDsMn2peH
         7RyR4rusva/4v4IEuBM2En5zunps9zTkDUp+xTMm0bCVvHU+E4KZ3j+R0tH4wL5FM+XU
         BX6pLCDqz1NvORnpkFEIXiMBzqiF8sl/FEiLbCUBZyeYTpwFJ+/+Ol8CXd4LTbFt2pEO
         LsVElwiUZnJ+OaAPWQq+R+onwrzd8Ot9OIa43++Aq1aB78Lp1i3LE9gNFQk+s+gYsvC3
         aIjA==
X-Gm-Message-State: AC+VfDzW8VwvB59Hva6QAUT5G/qStA8uCzekND9/et+6vm8oq9DtGV0R
        jCGyq413KVGYel2u1v6n76iFj0kA2G56T8r8sGbNUND3YIW3+t/rRRmnwZUD9TMo//7GJXpbvlV
        OPLw97vs6TKBYk16G2WnNN6YPIWwZEE1fSpqkCrg=
X-Received: by 2002:a17:906:fe42:b0:957:48c8:b081 with SMTP id wz2-20020a170906fe4200b0095748c8b081mr8406789ejb.24.1684761895236;
        Mon, 22 May 2023 06:24:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/qTYfVAKZUkCTwAqqG1fOWr5H9XdxT7euSBmD6hEtXbIfiJl+4rO8epmjh0+WsHyZoACd0Q==
X-Received: by 2002:a17:906:fe42:b0:957:48c8:b081 with SMTP id wz2-20020a170906fe4200b0095748c8b081mr8406777ejb.24.1684761895050;
        Mon, 22 May 2023 06:24:55 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709060dd000b0094f698073e0sm3044509eji.123.2023.05.22.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 06:24:54 -0700 (PDT)
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
        Luca Boccassi <bluca@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH net-next v6 2/3] net: core: add getsockopt SO_PEERPIDFD
Date:   Mon, 22 May 2023 15:24:38 +0200
Message-Id: <20230522132439.634031-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Reviewed-by: Christian Brauner <brauner@kernel.org>
Tested-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v5:
	- started using (struct proto)->bpf_bypass_getsockopt hook
v4:
	- return -ESRCH if sk->sk_peer_pid is NULL from getsockopt() syscall
	- return errors from pidfd_prepare() as it is from getsockopt() syscall
v3:
	- fixed possible fd leak (thanks to Christian Brauner)
v2:
	According to review comments from Kuniyuki Iwashima and Christian Brauner:
	- use pidfd_create(..) retval as a result
	- whitespace change
---
 arch/alpha/include/uapi/asm/socket.h    |  1 +
 arch/mips/include/uapi/asm/socket.h     |  1 +
 arch/parisc/include/uapi/asm/socket.h   |  1 +
 arch/sparc/include/uapi/asm/socket.h    |  1 +
 include/uapi/asm-generic/socket.h       |  1 +
 net/core/sock.c                         | 33 +++++++++++++++++++++++++
 net/unix/af_unix.c                      | 16 ++++++++++++
 tools/include/uapi/asm-generic/socket.h |  1 +
 8 files changed, 55 insertions(+)

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
index f6c415ef151f..dee8438985dd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1762,6 +1762,39 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		goto lenout;
 	}
 
+	case SO_PEERPIDFD:
+	{
+		struct pid *peer_pid;
+		struct file *pidfd_file = NULL;
+		int pidfd;
+
+		if (len > sizeof(pidfd))
+			len = sizeof(pidfd);
+
+		spin_lock(&sk->sk_peer_lock);
+		peer_pid = get_pid(sk->sk_peer_pid);
+		spin_unlock(&sk->sk_peer_lock);
+
+		if (!peer_pid)
+			return -ESRCH;
+
+		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
+		put_pid(peer_pid);
+		if (pidfd < 0)
+			return pidfd;
+
+		if (copy_to_sockptr(optval, &pidfd, len) ||
+		    copy_to_sockptr(optlen, &len, sizeof(int))) {
+			put_unused_fd(pidfd);
+			fput(pidfd_file);
+
+			return -EFAULT;
+		}
+
+		fd_install(pidfd, pidfd_file);
+		return 0;
+	}
+
 	case SO_PEERGROUPS:
 	{
 		const struct cred *cred;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index aac40106d036..ea24843fb017 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -921,11 +921,26 @@ static void unix_unhash(struct sock *sk)
 	 */
 }
 
+static bool unix_bpf_bypass_getsockopt(int level, int optname)
+{
+	if (level == SOL_SOCKET) {
+		switch (optname) {
+		case SO_PEERPIDFD:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
 struct proto unix_dgram_proto = {
 	.name			= "UNIX",
 	.owner			= THIS_MODULE,
 	.obj_size		= sizeof(struct unix_sock),
 	.close			= unix_close,
+	.bpf_bypass_getsockopt	= unix_bpf_bypass_getsockopt,
 #ifdef CONFIG_BPF_SYSCALL
 	.psock_update_sk_prot	= unix_dgram_bpf_update_proto,
 #endif
@@ -937,6 +952,7 @@ struct proto unix_stream_proto = {
 	.obj_size		= sizeof(struct unix_sock),
 	.close			= unix_close,
 	.unhash			= unix_unhash,
+	.bpf_bypass_getsockopt	= unix_bpf_bypass_getsockopt,
 #ifdef CONFIG_BPF_SYSCALL
 	.psock_update_sk_prot	= unix_stream_bpf_update_proto,
 #endif
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

