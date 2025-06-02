Return-Path: <linux-arch+bounces-12181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45266ACB8CA
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB129E0882
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63246227BB9;
	Mon,  2 Jun 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILApTVGk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2D227BA4;
	Mon,  2 Jun 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877447; cv=none; b=D5wVfJa+6t0VTOngOHDC/FnKeeJI8IWF8rY6vT8UbFl+iwOkpiNqpcN9CnpY1uudJIG/XnNfqBfaSiS+BkDqbTLss9tHQQ/qizloWqn04LG7yLI5JTMhnewCta3AscswQ33LQRnvS2H6nUNvqAE/0btrhNRBhfF+HywsTgEVQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877447; c=relaxed/simple;
	bh=FErq8caRDsGalfNF0DYdA9CIP38xryHF2uZADafN/2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPcrRtn/ElzNzEXVW+iWOnUAkp5b//kU5llkokAgv1cpILn4v6Ntxbr2E61//5qdSh0u6AT3sTYOwh8uHJ+xVt5P8VHNL6eejYptitvXtYYjx/IlUynMXKeAvtlhyGUS5Sg4vWaND5DYQfIUJi0kx0R0lKB59T8OlXKUabxgyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILApTVGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79912C4CEEB;
	Mon,  2 Jun 2025 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877447;
	bh=FErq8caRDsGalfNF0DYdA9CIP38xryHF2uZADafN/2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILApTVGkAiZN6TM/wQcKBxT5abitoepqMTZmyrBRSRSX8zSbfOzPgIb+NXg0FmJwF
	 MMtFGC+aUCh+ABg+8wlL+DOLshDggQtA06qvOtD9Q4EZiJrA+1IFz2X4QhX4N2tIGz
	 ouTSREd71pJQ3M5g8cojt2TaKpS0VdH/c5yusCLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
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
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 281/325] af_unix: Kconfig: make CONFIG_UNIX bool
Date: Mon,  2 Jun 2025 15:49:17 +0200
Message-ID: <20250602134331.179674198@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

commit 97154bcf4d1b7cabefec8a72cff5fbb91d5afb7b upstream.

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
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/unix/Kconfig |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

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



