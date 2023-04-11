Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDB6DD823
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDKKoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjDKKn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 06:43:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B594214
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 03:43:44 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11D473F236
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681209823;
        bh=pRf5xzGSUbwksyzKh9EFSxutG5TUV/lwNKq2bZMboXc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=oQ5CAUA5XLp4H0AMWn/3n9/+CjrnqZRPgOOcoZcxlOP4dgRPrvV+suah8Aj+Um3Pc
         01XalS4nfgYk9smqPEZZabrkzyiupaD20wJ8lacaoLtIMukbHWyx1E/X2PhphxCBOB
         zl1hkDcfohGfXiCLkU8vq4+z3V2W8J75fVuB+/Gb7qrVEvwX3NKnCn5/HEwrcctAZP
         8dwrJxWmnujSXmyzaAJ23SCwb4KJkNynnayAtGHtr7DfefywTliCWyTfLC3njNTx5h
         RNoxsQvplAB5BeD5hqJ7pOFGYa3bsvLk9pAcjNh2KkGyeSUaqw0e8ana39ENcZmRAZ
         N4fNzWZVz6LPQ==
Received: by mail-ej1-f72.google.com with SMTP id sz19-20020a1709078b1300b009497c250e96so3343950ejc.15
        for <linux-arch@vger.kernel.org>; Tue, 11 Apr 2023 03:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRf5xzGSUbwksyzKh9EFSxutG5TUV/lwNKq2bZMboXc=;
        b=zo28EYOAvq2ATh1//gEnJoxbiNJPjKLzHCUQIoX2HW+iOYdI/PjK3YMAeBuydf7seX
         YadfG13wCezXpVDxJwsFdvqNxlDDlEdlI1ty5LDqGUS3dfOkGS2P3Frf3V20/a+b2rfW
         /obv2Dpptn0kZnwJlkgvXmBdMJYI0b3WiKSPYfqBzs+r+ovwvRSaAMT35TS7Qld++mWU
         gkV4F/xqGFIm2dwYEQi9uG8V7Pypda+uZrq4W5TOdJpPasRijh1xBVpm9oJg1QtiYVx/
         VFYRnG/rPdJITadvL8fNzu4UWO/uWGjsO7Sn1NJKQs2JeMjORloxG4lz84g82SjuUdtG
         E6Tw==
X-Gm-Message-State: AAQBX9eWOZTZFvdX1Rb6sUabFrhwNreunHiIWevrPtO7NVIEmS4p1m/Y
        E4K8FhclbssdDZFGFoJcwwwg5B1sR1DAq5jgHRe3Hojy44Dcu/cTijkxPyHlOiFzfQr2SbmN+Qr
        95maOuHqy2DL75eTLQGDuX7uUvxT+dpYdamzRiFI=
X-Received: by 2002:a17:907:2ced:b0:8ee:babc:d40b with SMTP id hz13-20020a1709072ced00b008eebabcd40bmr9069383ejc.58.1681209820503;
        Tue, 11 Apr 2023 03:43:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y3a3e+i3YZE1zWCwJczevi7Xil2MO7ybttWW7IbAD0C/PVvpcEOpKeHeLj+dOjXcXoDH7LPQ==
X-Received: by 2002:a17:907:2ced:b0:8ee:babc:d40b with SMTP id hz13-20020a1709072ced00b008eebabcd40bmr9069360ejc.58.1681209820244;
        Tue, 11 Apr 2023 03:43:40 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id ne7-20020a1709077b8700b00948c320fcfdsm5921805ejc.202.2023.04.11.03.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:43:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/4] net: core: add getsockopt SO_PEERPIDFD
Date:   Tue, 11 Apr 2023 12:42:30 +0200
Message-Id: <20230411104231.160837-4-aleksandr.mikhalitsyn@canonical.com>
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
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Tested-by: Luca Boccassi <bluca@debian.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
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
 net/socket.c                            |  7 ++++++
 tools/include/uapi/asm-generic/socket.h |  1 +
 8 files changed, 46 insertions(+)

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
index 3f974246ba3e..2b040a69e355 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1763,6 +1763,39 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
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
+		pidfd = pidfd_prepare(peer_pid, 0, &pidfd_file);
+
+		put_pid(peer_pid);
+
+		if (copy_to_sockptr(optval, &pidfd, len) ||
+		    copy_to_sockptr(optlen, &len, sizeof(int))) {
+			if (pidfd >= 0) {
+				put_unused_fd(pidfd);
+				fput(pidfd_file);
+			}
+
+			return -EFAULT;
+		}
+
+		if (pidfd_file)
+			fd_install(pidfd, pidfd_file);
+
+		return 0;
+	}
+
 	case SO_PEERGROUPS:
 	{
 		const struct cred *cred;
diff --git a/net/socket.c b/net/socket.c
index 9c1ef11de23f..505b85489354 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2248,6 +2248,13 @@ static bool sockopt_installs_fd(int level, int optname)
 		default:
 			return false;
 		}
+	} else if (level == SOL_SOCKET) {
+		switch (optname) {
+		case SO_PEERPIDFD:
+			return true;
+		default:
+			return false;
+		}
 	}
 
 	return false;
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

