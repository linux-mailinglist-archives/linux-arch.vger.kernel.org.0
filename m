Return-Path: <linux-arch+bounces-12055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A2ABF95D
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679A9160F30
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285281D7989;
	Wed, 21 May 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO97HBnT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FA9461;
	Wed, 21 May 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841545; cv=none; b=kSTDdfuHUc81LFT9JM5YFPnQ5274XLIP5oWk2MvGTdhU56GhJRu7ufuPAjPDXHtY7qrH9qqz+ORoqZ1C8/8kL1WsGhnmKuw3BoVZa8TYppW7D2A8GvM+RC3t7t5J62gBYXvmNQyIo0/APndMrrAuNxCN5aJUjwBCSlcUikyFcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841545; c=relaxed/simple;
	bh=15lq1dewDEmZRAi/ruAvpBBjnmaSB3upAZ1I3QpCEos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3CbqM9MzcemIm2u1EW5+5a828KkzqPNFqFT7oRk55fwf0y0Q4LbaqDgEl5KNEC856Kj6I92uudgThHt5extuFMAoQiiDvIEsgtqla4gWZE/sM/ZET/9J8RSmircr965H4L4/5lDBKnArDbGPs7yzSXiUhcCY4vDgVuAFp7Q+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO97HBnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FBFC4CEE7;
	Wed, 21 May 2025 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841544;
	bh=15lq1dewDEmZRAi/ruAvpBBjnmaSB3upAZ1I3QpCEos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO97HBnTEObO2AIvtdgC8emxlz1lr9zp7b4iPXwxerWkLxkekPoJwitnoknJe1USR
	 fpfiBSBUJohK9+gVttw2baTEaTfcvOrI8pQSXOU+bs8teKTPj+ut4dvuCNBkJGY9hO
	 uyGuZd1mWsegzAt+nqbiDaCbYq7Hi/9zFgqtmM3FhYS5LiiXAHSNdIzNAKFMqHYCXP
	 /DYx0xX4aBqvN2QZAF1dW2jJRSVdX1SNrxhhC7YdpOHkznmo5fAOQ1JypfKpdZEUif
	 qZ4wEGwbTzrroGuKA7qSarwm9Vp5olCSBqw2l/sQapHPN3RK2bcT9TRhTI4SGGj6fV
	 j+nnlwoiWhfiw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH v6.1 01/27] af_unix: Kconfig: make CONFIG_UNIX bool
Date: Wed, 21 May 2025 16:27:00 +0100
Message-ID: <20250521152920.1116756-2-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To: <20250521152920.1116756-1-lee@kernel.org>
References: <20250521152920.1116756-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

[ Upstream commit 97154bcf4d1b7cabefec8a72cff5fbb91d5afb7b ]

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
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 97154bcf4d1b7cabefec8a72cff5fbb91d5afb7b)
Signed-off-by: Lee Jones <lee@kernel.org>
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
2.49.0.1143.g0be31eac6b-goog


