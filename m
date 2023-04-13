Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC386E0F45
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 15:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjDMNxq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjDMNxp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 09:53:45 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4FE8
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 06:53:44 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62B993F485
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681392903;
        bh=pU+XkxxaqxIltFz6HAiJgXotXtTecmR/abIbMqTWsWw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eWaxANJNBIBIxE5cnU1hUSkKJdyh9w5wXbnn8JTTTmMf2V0HgxuaC3UV9zqrTwlzh
         cam3LzwWpSmx2eWx12tDcJGYDfm5QVIxTpuKjXF7CXMYiGJmb7aCIekA9K8NjxVqQA
         ZTVCQCVVrKHjcZgxv2eMYK1ROa43CGgwRSC1bmpZi/xHalfG3dMaAY8YJ00NnKzBaF
         qZviCEGsUmapOmUL67H+QgZVBhGN/z4QP0I5UquEkcbDCEeJ+DYM+R9T2NNb/vQOIU
         jWqjTGFcXeRxh7DBzfz47yHAJfCNM0z9FuoshmzvLoG4h+X38RHhm07JHPrmzJwr3U
         yfs+jTQ37SgNw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-506752f399cso1065834a12.0
        for <linux-arch@vger.kernel.org>; Thu, 13 Apr 2023 06:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392877; x=1683984877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU+XkxxaqxIltFz6HAiJgXotXtTecmR/abIbMqTWsWw=;
        b=RceeeAkBSJl3DAadohrKHIx5GrWgwg+q5GIIwwOx8FTiCJbudxfBCYAeB4oHaUYIZN
         SjLNj3Krsj19LsUpW4eENXAGtMoN3IaJ7RGrLY9Qag6T31bKF5XO/jBlPhwTNXfsvIr/
         Ak8q/9G47ue7i7O9q4nHPtmx3xluei9g7xY6dz68DP4hW9nx53SiWcDFc7FBUKh3QebA
         /EysJvcB+88TqbI3DPZjy+mm41WZ8S7/NjRegY7Ad8HpDUNV0DpFM5y4/b5aPQmhwGao
         arRbmcZxs/E/N3EZjZmnL2tR48oG2Qa1SespnyErLwTWqDZW9mKmpQLLEwP95g5zExC3
         rebQ==
X-Gm-Message-State: AAQBX9cv57A7swQ7o3pB8N6zAqUdVgXPN3LMBCAQcXuIVBnnbdhc1p7G
        h54F+xLOXPwF2sylLwmCWq8b3U3FuyIi3LH7UC8SAnV1NHPD4iGk6gWDIs2RAzjOGwXFu3FVh4x
        rrWlrl+9IiMo+SzTqa5hjzciSta73r4P1eSvpx5g=
X-Received: by 2002:a05:6402:49:b0:504:8a0f:13ca with SMTP id f9-20020a056402004900b005048a0f13camr1932414edu.10.1681392877052;
        Thu, 13 Apr 2023 06:34:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350aV7p0sn03LCerGeF3KPK9DDJyh86PbUa/oXNvIx8Ve9zsyvkpvXJUqxRJSvXrr+2BQLm/qeg==
X-Received: by 2002:a05:6402:49:b0:504:8a0f:13ca with SMTP id f9-20020a056402004900b005048a0f13camr1932387edu.10.1681392876801;
        Thu, 13 Apr 2023 06:34:36 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id et22-20020a170907295600b0094a966330fdsm976806ejc.211.2023.04.13.06.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:34:36 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        daniel@iogearbox.net,
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
        linux-arch@vger.kernel.org
Subject: [PATCH net-next v4 2/4] net: socket: add sockopts blacklist for BPF cgroup hook
Date:   Thu, 13 Apr 2023 15:33:53 +0200
Message-Id: <20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

During work on SO_PEERPIDFD, it was discovered (thanks to Christian),
that bpf cgroup hook can cause FD leaks when used with sockopts which
install FDs into the process fdtable.

After some offlist discussion it was proposed to add a blacklist of
socket options those can cause troubles when BPF cgroup hook is enabled.

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
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/socket.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 73e493da4589..9c1ef11de23f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -108,6 +108,8 @@
 #include <linux/ptp_clock_kernel.h>
 #include <trace/events/sock.h>
 
+#include <linux/sctp.h>
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 unsigned int sysctl_net_busy_read __read_mostly;
 unsigned int sysctl_net_busy_poll __read_mostly;
@@ -2227,6 +2229,36 @@ static bool sock_use_custom_sol_socket(const struct socket *sock)
 	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+static bool sockopt_installs_fd(int level, int optname)
+{
+	/*
+	 * These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
+	 * hook returns an error after success of the original handler
+	 * sctp_getsockopt(...), userspace will receive an error from getsockopt
+	 * syscall and will be not aware that fd was successfully installed into fdtable.
+	 *
+	 * Let's prevent bpf cgroup hook from running on them.
+	 */
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+#else /* CONFIG_CGROUP_BPF */
+static inline bool sockopt_installs_fd(int level, int optname)
+{
+	return false;
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 /*
  *	Set a socket option. Because we don't know the option lengths we have
  *	to pass the user mode parameter for the protocols to sort out.
@@ -2250,7 +2282,7 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 	if (err)
 		goto out_put;
 
-	if (!in_compat_syscall())
+	if (!in_compat_syscall() && !sockopt_installs_fd(level, optname))
 		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, &level, &optname,
 						     user_optval, &optlen,
 						     &kernel_optval);
@@ -2304,7 +2336,7 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 	if (err)
 		goto out_put;
 
-	if (!in_compat_syscall())
+	if (!in_compat_syscall() && !sockopt_installs_fd(level, optname))
 		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
 
 	if (level == SOL_SOCKET)
@@ -2315,7 +2347,7 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		err = sock->ops->getsockopt(sock, level, optname, optval,
 					    optlen);
 
-	if (!in_compat_syscall())
+	if (!in_compat_syscall() && !sockopt_installs_fd(level, optname))
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
 						     err);
-- 
2.34.1

