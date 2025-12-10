Return-Path: <linux-arch+bounces-15318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D4CB1AB5
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 02:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 085A730039E7
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77FD199EAD;
	Wed, 10 Dec 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAWBzTuF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51529405;
	Wed, 10 Dec 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331734; cv=none; b=k0TNA1Kni8MXxfzVnWaiMAjUQQ3b69mIbzTGR0s/PaddG7u0KdC3KAC4c1PwVW9xH8dbrtIbZ2QllXmlEYEGk1bEBK6he7rYbvlWuzzTBmkCLfBivAuRabtd9CdeniY0XgG0+Fv3k1w+QMay3/Lt31w39lUEfihjbGinU3siBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331734; c=relaxed/simple;
	bh=UwTVV0EFb7hR2zKy1cCUefzgbcs3rhxfqSYW9AiQ4iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EohG7LFuus2+Aks1cEj+Wg08Zyqo7XHq/qGK1N72oxFgH3Fck2CTlo0kMvLAdBrY9zlbdzqymiBRjhl9u28OU8PaN8t8snBdfIcvwQqADGXvzrw2vcpZ9jEVgcNW7PWLmqY/pXd24TC4WewJCf8SVm6+QRaY/VYiNRV2U4MXr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAWBzTuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C1FC4CEF5;
	Wed, 10 Dec 2025 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765331734;
	bh=UwTVV0EFb7hR2zKy1cCUefzgbcs3rhxfqSYW9AiQ4iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NAWBzTuFe3psq0GAlEe2UtjfQY9AHgA+6/TfJvbJFr5fms/iz0mnOic70WPj+soD4
	 IbRRgPEC4jHi5eXyXExQMHFshp/0mGfzoVe2RgqUOEIeBMYSAo35946DTd5TdophGa
	 qe09I6Ne6nbPND6irHrN6jmFOU8PrcS/QoUYyjh/0jxLVD8SdEKE8ZWW2DsUO4qRyb
	 Qx25dIh80CrtDZj2YWbG6MZc7hzK4MGQdKgbyYrELEAcDw2pUH58jubn7CkZZWo0iG
	 0nDCtRgDKDAa1oUVeoiExeTVv1HLypEWpVrtyS8QxJKJq0tNmTBSAHCDx4IqaejywJ
	 oF0YccowViTWg==
From: guoren@kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v6.19
Date: Tue,  9 Dec 2025 20:55:23 -0500
Message-Id: <20251210015523.14737-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the updates for csky for v6.19.

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-6.19

for you to fetch changes up to 817d21578d51e801df58ab012654486a71073074:

  csky: Remove compile warning for CONFIG_SMP (2025-10-19 20:01:52 -0400)

----------------------------------------------------------------
csky 6.19 Release Notes

 - Remove compile warning for CONFIG_SMP
 - Fix __ASSEMBLER__ typo in headers
 - Fix csky_cmpxchg_fixup

----------------------------------------------------------------
Guo Ren (Alibaba DAMO Academy) (1):
      csky: Remove compile warning for CONFIG_SMP

Thomas Huth (2):
      csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
      csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi header

Yang Li (1):
      csky: fix csky_cmpxchg_fixup not working

 arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
 arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
 arch/csky/include/asm/barrier.h     | 4 ++--
 arch/csky/include/asm/cache.h       | 2 +-
 arch/csky/include/asm/ftrace.h      | 4 ++--
 arch/csky/include/asm/jump_label.h  | 4 ++--
 arch/csky/include/asm/page.h        | 4 ++--
 arch/csky/include/asm/ptrace.h      | 4 ++--
 arch/csky/include/asm/sections.h    | 1 +
 arch/csky/include/asm/string.h      | 2 +-
 arch/csky/include/asm/thread_info.h | 4 ++--
 arch/csky/include/uapi/asm/ptrace.h | 4 ++--
 arch/csky/mm/fault.c                | 4 ++--
 13 files changed, 21 insertions(+), 20 deletions(-)

