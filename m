Return-Path: <linux-arch+bounces-5155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214E918E35
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542871C21558
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 18:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021519048C;
	Wed, 26 Jun 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzX7o0eg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C7190486;
	Wed, 26 Jun 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426138; cv=none; b=J+ZfrXUIs8oj6s6M+3edBn7P1oDRM/eSP2HIddUgZ8ewWajBVa8ezXAtpbozI6c91YboKLy6yTKWNwce2X1nQ9CbBxsdLIzu/WrdOBceKKE7NjPg/Zri6B4AuRlb1QAB0R9TgXpXlUq6faDuIyF7q+llmbzxdapfzvDns2fMnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426138; c=relaxed/simple;
	bh=ezxAwpy5sfag1PHrzWNLbB7gMnE9vmRE09RjO8mAUxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcU6id1X3wQGo7q0l/EitQ2xsseLDjqvC5nbQIGTn0z+HURRMV6scM6FmsiH7Dl9jF8UGWVCRriH691gD7HVniV/q0RTM5ffcoaJDrbvg19jLuMhQL2MsEfLc9+Zo9d7Ml3JR0TcgKGqPx+0mbwjhrjmsCcF7Ve5cf87HWlwqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzX7o0eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F00C116B1;
	Wed, 26 Jun 2024 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426138;
	bh=ezxAwpy5sfag1PHrzWNLbB7gMnE9vmRE09RjO8mAUxI=;
	h=From:To:Cc:Subject:Date:From;
	b=KzX7o0egzmRhz1/Tpo9zZOQ9wGRgxVmgoZmV8nL4NLyEHpyzoYOkt3NZXdOaEUBt1
	 SxML2PpFvJfWjjiqybsiGbkdqlDXX4brkGRtP9g802xLdvsouOj/xE9AnTfVfyL38b
	 PjbsRcJcHQkpNxqc4qTmituir//QYyG0QZw4sqbfTTb32nx64qgJ0LE6y0kSOeSr6n
	 XNATuir7bd9BlbSX5chNFbk9rb4I7HknP6RvfnScG5sfU6fEwCSFlr/uilNEnXAxLJ
	 9FYGajK8T1WeaXlr7hPabSbh9rWViykPe9eIeIG5j2hBJJMms47KrEOurcuOImZrgI
	 B7s1HFVCICnTw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/5] kconfig: fix conditional prompt for choice and recursive error messages
Date: Thu, 27 Jun 2024 03:21:59 +0900
Message-ID: <20240626182212.3758235-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit




Masahiro Yamada (5):
  treewide: change conditional prompt for choices to 'depends on'
  kconfig: fix conditional prompt behavior for choice
  kconfig: improve error message for dependency between choice members
  kconfig: improve error message for recursive dependency in choice
  kconfig: refactor error messages in sym_check_print_recursive()

 arch/arm/Kconfig         |  6 ++++--
 arch/arm64/Kconfig       |  3 ++-
 arch/mips/Kconfig        |  6 ++++--
 arch/powerpc/Kconfig     |  3 ++-
 arch/riscv/Kconfig       |  3 ++-
 fs/jffs2/Kconfig         |  3 ++-
 scripts/kconfig/menu.c   | 38 +++-----------------------------------
 scripts/kconfig/symbol.c | 27 +++++++++++----------------
 8 files changed, 30 insertions(+), 59 deletions(-)

-- 
2.43.0


