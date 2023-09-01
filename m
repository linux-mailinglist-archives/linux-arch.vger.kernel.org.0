Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86DD7902D8
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbjIAUeA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 16:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjIAUd7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 16:33:59 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046EEE7E;
        Fri,  1 Sep 2023 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693600438; x=1725136438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KbPxcQheKlbIma1v+CXRv/YGcjTBgwEwfdcn8d9KxC8=;
  b=Hj2WYSEuMgrClYgcX34j71TswG/2PsR5dD4P+EIQONWBz7qBLPZifjtc
   Cjn65fov5a52xxIbpsw0yC1g0yXibZCZvYM2Ype/0fUM4E0QzivsQsx+n
   tHorW7BT/R0c91JIpDDLwUshyrd0EVHcc88U9gvQFxRzOFNqlySiCVYI3
   U=;
X-IronPort-AV: E=Sophos;i="6.02,220,1688428800"; 
   d="scan'208";a="669960552"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 20:33:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id 5B451C28ED;
        Fri,  1 Sep 2023 20:33:44 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 20:33:37 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 20:33:33 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <hca@linux.ibm.com>
CC:     <aleksandr.mikhalitsyn@canonical.com>, <arnd@arndb.de>,
        <bluca@debian.org>, <brauner@kernel.org>, <davem@davemloft.net>,
        <dsahern@kernel.org>, <edumazet@google.com>,
        <keescook@chromium.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <ldv@strace.io>, <leon@kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mzxreary@0pointer.de>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
Date:   Fri, 1 Sep 2023 13:33:22 -0700
Message-ID: <20230901203322.56399-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230901200517.8742-A-hca@linux.ibm.com>
References: <20230901200517.8742-A-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.14]
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>
Date: Fri, 1 Sep 2023 22:05:17 +0200
> On Thu, Jun 08, 2023 at 10:26:25PM +0200, Alexander Mikhalitsyn wrote:
> > Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
> > but it contains pidfd instead of plain pid, which allows programmers not
> > to care about PID reuse problem.
> > 
> > We mask SO_PASSPIDFD feature if CONFIG_UNIX is not builtin because
> > it depends on a pidfd_prepare() API which is not exported to the kernel
> > modules.
> > 
> > Idea comes from UAPI kernel group:
> > https://uapi-group.org/kernel-features/
> > 
> > Big thanks to Christian Brauner and Lennart Poettering for productive
> > discussions about this.
> > 
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Luca Boccassi <bluca@debian.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Tested-by: Luca Boccassi <bluca@debian.org>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Reviewed-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> >  arch/alpha/include/uapi/asm/socket.h    |  2 ++
> >  arch/mips/include/uapi/asm/socket.h     |  2 ++
> >  arch/parisc/include/uapi/asm/socket.h   |  2 ++
> >  arch/sparc/include/uapi/asm/socket.h    |  2 ++
> >  include/linux/net.h                     |  1 +
> >  include/linux/socket.h                  |  1 +
> >  include/net/scm.h                       | 39 +++++++++++++++++++++++--
> >  include/uapi/asm-generic/socket.h       |  2 ++
> >  net/core/sock.c                         | 11 +++++++
> >  net/mptcp/sockopt.c                     |  1 +
> >  net/unix/af_unix.c                      | 18 ++++++++----
> >  tools/include/uapi/asm-generic/socket.h |  2 ++
> >  12 files changed, 76 insertions(+), 7 deletions(-)
> ...
> > +static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
> > +{
> > +	struct file *pidfd_file = NULL;
> > +	int pidfd;
> > +
> > +	/*
> > +	 * put_cmsg() doesn't return an error if CMSG is truncated,
> > +	 * that's why we need to opencode these checks here.
> > +	 */
> > +	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
> > +	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
> > +		msg->msg_flags |= MSG_CTRUNC;
> > +		return;
> > +	}
> 
> This does not work for compat tasks since the size of struct cmsghdr (aka
> struct compat_cmsghdr) is differently. If the check from put_cmsg() is
> open-coded here, then also a different check for compat tasks needs to be
> added.
> 
> Discovered this because I was wondering why strace compat tests fail; it
> seems because of this.
> 
> See https://github.com/strace/strace/blob/master/tests/scm_pidfd.c
> 
> For compat tasks recvmsg() returns with msg_flags=MSG_CTRUNC since the
> above code expects a larger buffer than is necessary.

Can you test this ?

---8<---
diff --git a/include/net/scm.h b/include/net/scm.h
index c5bcdf65f55c..099497ce4aee 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -9,6 +9,7 @@
 #include <linux/pid.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
+#include <net/compat.h>
 
 /* Well, we should have at least one descriptor open
  * to accept passed FDs 8)
@@ -125,14 +126,19 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 	struct file *pidfd_file = NULL;
 	int pidfd;
 
-	/*
-	 * put_cmsg() doesn't return an error if CMSG is truncated,
+	/* put_cmsg() doesn't return an error if CMSG is truncated,
 	 * that's why we need to opencode these checks here.
 	 */
-	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
-	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
-		msg->msg_flags |= MSG_CTRUNC;
-		return;
+	if (msg->msg_flags & MSG_CMSG_COMPAT) {
+		if (msg->msg_controllen < sizeof(struct compat_cmsghdr) + sizeof(int)) {
+			msg->msg_flags |= MSG_CTRUNC;
+			return;
+		}
+	} else {
+		if (msg->msg_controllen < sizeof(struct cmsghdr) + sizeof(int)) {
+			msg->msg_flags |= MSG_CTRUNC;
+			return;
+		}
 	}
 
 	if (!scm->pid)
---8<---
