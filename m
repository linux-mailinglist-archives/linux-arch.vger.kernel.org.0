Return-Path: <linux-arch+bounces-8879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB69BF2FA
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0FB1F21FB2
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640222038DF;
	Wed,  6 Nov 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPCLy3Cn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B6189F5C;
	Wed,  6 Nov 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909701; cv=none; b=EYm6CDfzJFS0FdcNH9PJiYGev+8aXU0xVRV0Nx8RslrnDS1M29A5XFDjRT6Vz0rLoOIgKrZ5PXQrfb3PZFufHBT/x/kp15GqhVwvfxRlP0VXmvK1H/VcIXui2JTgtyEd7z7j5Pfd12WkGYriDqybzPFvUEsC0Kt/NhCE+ATohdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909701; c=relaxed/simple;
	bh=2L2KPeDDY1cDn036D9Ij9ZGhV0YgRwxwdrhtgK5vbtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2EzPrBW+OKcRC7BLfP/YuGIKOxj2sGEw6XGBftHmdQ+TvbZ9GizveUODvHAhiSV/pPYqK5jGQ+3NBeL/y+RrxzLaBUTZTBTWx6ZR0n7eIhzJRoWvruwhwMDvVX/ixW3fdsQflrrvaEPAOSt5DMbytjRJondyJtyiDUki3p82wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPCLy3Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2296C4CEC6;
	Wed,  6 Nov 2024 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909700;
	bh=2L2KPeDDY1cDn036D9Ij9ZGhV0YgRwxwdrhtgK5vbtM=;
	h=From:To:Cc:Subject:Date:From;
	b=jPCLy3Cn1ejfR/Oqs80JkzGiLv3SCxGNZ4ypNsRamXXfgbqqZcaWpxIfGhoQ2gG4T
	 HnSqcDcgtAupIFLbtTx8SgkRdAnqsYYM7b/YWqxQ9Z4Rq0J17D9onjpDG1vxkjPOE8
	 i279sAap4rqLk6l986/3nDR072mM3wsa4pS3TVdCr6jOKO6OX+Ui+cBA7dbRa7+AeJ
	 G6T9Ewm0aEfd87HNHkpxebzx+MN7PrSlpOFXXAImlq9xzXO3BZB89bk6+EyEHhACHK
	 EXdhit2XeH2rIyfhHM3QlGHCwx2umZ2kQY3Sqb2pWQGquABgQ9aYZKE3aszqbOIsL3
	 OIhMIeE4XUvjg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH 1/2] Rename .data.unlikely to .data..unlikely
Date: Thu,  7 Nov 2024 01:14:40 +0900
Message-ID: <20241106161445.189399-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7ccaba5314ca ("consolidate WARN_...ONCE() static variables")
was intended to collect all .data.unlikely sections into one chunk.
However, this has not worked when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
or CONFIG_LTO_CLANG is enabled, because .data.unlikely matches the
.data.[0-9a-zA-Z_]* pattern in the DATA_MAIN macro.

Commit cb87481ee89d ("kbuild: linker script do not match C names unless
LD_DEAD_CODE_DATA_ELIMINATION is configured") was introduced to suppress
the issue for the default CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n case,
providing a minimal fix for stable backporting. We were aware this did
not address the issue for CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y. The
plan was to apply correct fixes and then revert cb87481ee89d. [1]

Seven years have passed since then, yet the #ifdef workaround remains in
place.

Using a ".." separator in the section name fixes the issue for
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and CONFIG_LTO_CLANG.

[1]: https://lore.kernel.org/linux-kbuild/CAK7LNASck6BfdLnESxXUeECYL26yUDm0cwRZuM4gmaWUkxjL5g@mail.gmail.com/

Fixes: cb87481ee89d ("kbuild: linker script do not match C names unless LD_DEAD_CODE_DATA_ELIMINATION is configured")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/rcupdate.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c995474e4c64..3c9dc1fd094d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -357,7 +357,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	*(.data..decrypted)						\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
-	*(.data.unlikely)						\
+	*(.data..unlikely)						\
 	__start_once = .;						\
 	*(.data.once)							\
 	__end_once = .;							\
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 58d84c59f3dd..48e5c03df1dd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -401,7 +401,7 @@ static inline int debug_lockdep_rcu_enabled(void)
  */
 #define RCU_LOCKDEP_WARN(c, s)						\
 	do {								\
-		static bool __section(".data.unlikely") __warned;	\
+		static bool __section(".data..unlikely") __warned;	\
 		if (debug_lockdep_rcu_enabled() && (c) &&		\
 		    debug_lockdep_rcu_enabled() && !__warned) {		\
 			__warned = true;				\
-- 
2.43.0


