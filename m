Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACE728969
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 22:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjFHU1m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjFHU1Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 16:27:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EAC3583
        for <linux-arch@vger.kernel.org>; Thu,  8 Jun 2023 13:27:02 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 91B4F3F364
        for <linux-arch@vger.kernel.org>; Thu,  8 Jun 2023 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686256018;
        bh=BjVOaOX+rOUwxqfCcfqaeBd3w4EjFD+d/9OSygYwXOc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wQK0hZhVfLcMxU4dlxzm2B9+jBCZKbCDPSbrR+s1fc8+Oh6xHJ+WqknKa0ztL23BR
         q5ebjyq/74YcPh0accPMv8Xunc1HJXWTOyZNjY8Uy4ty+duhKgFzPwc57CzcOlFiA0
         WiYNQu7a9PakROvBg4Qi7zKrXzfL2y19jzIvP9GgluqEwLncNCP+HewUs+kAxtdj59
         zCejD0j3jvHi4S5ylfEvV31ipqIGiv5epun07nOaYFdH83q0hvwA47r2K7GW9E+SA1
         HIMdyhzQZu0ct6XfutGI2vcnX6PuyZGnKjS0hnsFID/Hoznqfrd2x23BxX3yaV/t/A
         bdMIo/QjUZaOQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-974566553ccso116568766b.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Jun 2023 13:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686256018; x=1688848018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjVOaOX+rOUwxqfCcfqaeBd3w4EjFD+d/9OSygYwXOc=;
        b=hyZ9iVBydq70b+27C5qSMgSc+mnqEa1+anHqNAEZBM+IEScUPXuoy0JMNWWYG+JhpK
         Vod0QPamOWolXatN4K2RDzeLzy7FC37yMM2Pcm6NT4usQ/qluo4Yfxsfd9b7ss0JkXt0
         QxhR06P6wWIGbNL1mjfKPgsc5JpG++vMCU52qAeDEsk4eaowd8yJQzULlJlitCr5sDaq
         eG13a0AwgKpCNt5oN3UjRwq76FsoSucsaWOgagSAw0jvf7kafX8mXHzj8usuGRwTrQ9J
         ch3WU2cY17kV9FN/IHCTDisq1tJbResXc2qr8o2Ys7d1dboCShVeQHW9BjJkfsPSnL7Y
         MfZA==
X-Gm-Message-State: AC+VfDxGZi1KlQ4xUKsmygR1hYICemnjjQEE7s7yiCjkRawofZqYs+Bm
        NhZWZGLZ1RMPLCsz90rbi3uYZdLUVm6Inm7BzndLnQaDaee5XdxGEMWZUS/qy1KZSop5E1QXh1J
        siu+UxaMZzjS53LYTDjtKSumBzPcgPlLcLlrTRa8=
X-Received: by 2002:a17:907:7f23:b0:973:903c:35a4 with SMTP id qf35-20020a1709077f2300b00973903c35a4mr244242ejc.65.1686256018294;
        Thu, 08 Jun 2023 13:26:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64l2skizqYkkoGjgKsgZOunpklCFslHyfrAGzKKNXGIZ19vqFFoZ4QRgjtjzYgI/m2J585WA==
X-Received: by 2002:a17:907:7f23:b0:973:903c:35a4 with SMTP id qf35-20020a1709077f2300b00973903c35a4mr244226ejc.65.1686256018075;
        Thu, 08 Jun 2023 13:26:58 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906491000b0095342bfb701sm315592ejq.16.2023.06.08.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:26:57 -0700 (PDT)
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
Subject: [PATCH net-next v7 4/4] af_unix: Kconfig: make CONFIG_UNIX bool
Date:   Thu,  8 Jun 2023 22:26:28 +0200
Message-Id: <20230608202628.837772-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608202628.837772-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Let's make CONFIG_UNIX a bool instead of a tristate.
We've decided to do that during discussion about SCM_PIDFD patchset [1].

[1] https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/

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
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/unix/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index b7f811216820..28b232f281ab 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -4,7 +4,7 @@
 #
 
 config UNIX
-	tristate "Unix domain sockets"
+	bool "Unix domain sockets"
 	help
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and
@@ -14,10 +14,6 @@ config UNIX
 	  an embedded system or something similar, you therefore definitely
 	  want to say Y here.
 
-	  To compile this driver as a module, choose M here: the module will be
-	  called unix.  Note that several important services won't work
-	  correctly if you say M here and then neglect to load the module.
-
 	  Say Y unless you know what you are doing.
 
 config UNIX_SCM
-- 
2.34.1

