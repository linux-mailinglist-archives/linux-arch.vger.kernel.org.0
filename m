Return-Path: <linux-arch+bounces-4221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E108F8BCF46
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 15:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808331F216BD
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744AD7B3E1;
	Mon,  6 May 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vll13l5h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1E86AEE;
	Mon,  6 May 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002590; cv=none; b=jqf3s1uJHLy/xsPldDVJzq5wZH+wU05WOm8ygVQmK752WQpE1AuB75BiRhoCXSd/suAVdVzF1BWwRR3KHw4CIrhLy4OKXDWVPG0ddDvpCpdq3r2oYhnZiWLAAnjUF0o5OPIhB/Fd0vXUroXl+npVoTb5Yw4AFL91CFVN0ZZyHZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002590; c=relaxed/simple;
	bh=IU0butsrYNaU1Rn9/Rhr8P9pxnhR+xc2irmkL7gk71M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lta+9OJw24Gdg0JRfaLJHcJ8VdkiFNaSK0tqYoRI5qC2N/++EG4KpF7cDwou06sZFxQnEBdn5yOr214iB6f3j/Lu6/0R2Bq3VgrZ1QusOUGmbS10XthpF3BfwoYBo42ldpJKEeaXii4B4PKWn65P5S0wnflyEilnASf4Up5ovqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vll13l5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18219C4AF67;
	Mon,  6 May 2024 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002590;
	bh=IU0butsrYNaU1Rn9/Rhr8P9pxnhR+xc2irmkL7gk71M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vll13l5hMbESecAEa6zpZucFAHqic9XvexGbDayahesEpFFqZbj2iGntS5bPMiCAu
	 PLTrS+W2G+s7awG3XXf+15z9qFQp8svkzgOMHW3Rzoemj2FqhI2ZuGUGqPkrdhbaoN
	 guIRMB95b7pT8PagUJ6pBCPzzox7aTTKkCnnsbTkNFT6+VJye3iNeWq9W3Rtlql91W
	 BWewJpKO8mGpzKVrsignptX2W08263xw6UO86j4hweW7MjKjlN+WR0QNSUjo7qStBt
	 irlPoDWyyy5tbvUcJqKW7IE63gmVc8QHxaIT+hDfCiYRPZ/0EkvciS69rxYucv6MpS
	 kEnTKAsHOfRhA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] kbuild: use GCOV_PROFILE and KCSAN_SANITIZE in scripts/Makefile.modfinal
Date: Mon,  6 May 2024 22:35:44 +0900
Message-Id: <20240506133544.2861555-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506133544.2861555-1-masahiroy@kernel.org>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of filtering out the GCOV and KCSAN flags, let's set GCOV_PROFILE
and KCSAN_SANITIZE to 'n', as in other Makefiles.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modfinal | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 79fcf2731686..3bec9043e4f3 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -21,9 +21,11 @@ __modfinal: $(modules:%.o=%.ko)
 # modname and part-of-module are set to make c_flags define proper module flags
 modname = $(notdir $(@:.mod.o=))
 part-of-module = y
+GCOV_PROFILE := n
+KCSAN_SANITIZE := n
 
 quiet_cmd_cc_o_c = CC [M]  $@
-      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI) $(CFLAGS_GCOV) $(CFLAGS_KCSAN), $(c_flags)) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(filter-out $(CC_FLAGS_CFI), $(c_flags)) -c -o $@ $<
 
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
-- 
2.40.1


