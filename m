Return-Path: <linux-arch+bounces-5250-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029E92789E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6901C22292
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0E41B0127;
	Thu,  4 Jul 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScYDl+DM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372451DA58;
	Thu,  4 Jul 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103823; cv=none; b=JHoYU8C3u2LSDSLhg/hhQvLqLqn08oECY35C3rPLBAONZuDOVrNl6Aoa3Z6voMZw4z6ND6W+zygUybDcefRT4UuppIhP5raecrAO5rrP5kYqC8B1rjkR+SmR0uAJsSASFXxsAHqrfVRBfpER4USK1Yu6K6li6UgQImE0zyIZ7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103823; c=relaxed/simple;
	bh=6AvNCHIDCl2FJ0+iZjNz9fWIUodQR9KLWj8XWc9apE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIALpZSMBb6pCrsI90bhbpjwIiNmg0/ph60jnjKK6WeVgTjpw3MIw2YSr6rGZgMMvsG/S8u+4WjxPmGxR09Lt5Xj+rx1Zu0lCY7KFAEhPT4dObOD0V1ctzIHSa5lxm4thcohOk22W/2el+oUeTY6aAOWnizJHArgX7796bHiMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScYDl+DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0372C4AF0F;
	Thu,  4 Jul 2024 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103822;
	bh=6AvNCHIDCl2FJ0+iZjNz9fWIUodQR9KLWj8XWc9apE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScYDl+DMyUOLog8Ap5Cuip0pO3+A9qNjjqcju/yJgYyW05wqLt6SFyhe1dFfGExZC
	 0eEDTWOM2aqnzawCBctPnVBiwQ1VYyUAg4LITJjlPb784KeCW78yatBBlurmRHoo6h
	 0aWznGQ9KH5R84ZvK/TgZ+XzQQjfafyQh8oIzpNi4rBdoBBrJSQpqGFupi9rZsJti2
	 FLZK26mH4iNeWrrvAS+JLvL4/kJAWp53NnMlorLx/wpFcxCvMpNJLDx5uV0zMnlFce
	 dgg3bDMfhj2bnlsN1INV5j8CEn9L2U9wAHhdpBswa4oAeMMD0Xlf39a6XyOFL70xWm
	 RocQ5bfPRMiRw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 03/17] um: don't generate asm/bpf_perf_event.h
Date: Thu,  4 Jul 2024 16:35:57 +0200
Message-Id: <20240704143611.2979589-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

If we start validating the existence of the asm-generic side of
generated headers, this one causes a warning:

make[3]: *** No rule to make target 'arch/um/include/generated/asm/bpf_perf_event.h', needed by 'all'.  Stop.

The problem is that the asm-generic header only exists for the uapi
variant, but arch/um has no uapi headers and instead uses the x86
userspace API.

Add a custom file with an explicit redirect to avoid this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/include/asm/Kbuild           | 1 -
 arch/um/include/asm/bpf_perf_event.h | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/bpf_perf_event.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 6fe34779291a..6c583040537c 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += bpf_perf_event.h
 generic-y += bug.h
 generic-y += compat.h
 generic-y += current.h
diff --git a/arch/um/include/asm/bpf_perf_event.h b/arch/um/include/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..0a30420c83de
--- /dev/null
+++ b/arch/um/include/asm/bpf_perf_event.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm-generic/bpf_perf_event.h>
-- 
2.39.2


