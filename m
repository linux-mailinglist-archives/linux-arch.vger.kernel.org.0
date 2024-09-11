Return-Path: <linux-arch+bounces-7208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5621975068
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 13:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237941C22846
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F56187FFF;
	Wed, 11 Sep 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPCzarS/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9346187872;
	Wed, 11 Sep 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052653; cv=none; b=a+RwJlrBUyOMTPvwQbjikQlQRnIkuR5gGYOtilbBt84nUR2xjDCfvBRMGKGDLTas03Aqxi9V1CMd/rA9qZh8rYWOTDUBLxt5aVhSAGdT4eiEkxmjpQWgXCptcpbO6n+3dt9e3649FfCA+VQ6+F8M0I+Jh7qtGdCc7pgkyeFRNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052653; c=relaxed/simple;
	bh=thqMcdaspNIy4jxq3jBQbrvGsrz0EH5sU9B3enTaQ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZzMsWP044+0XnmC3MPLBPeFBeCRT4OJpUvldrbx6WA5qz5vIImgd59UCIq1/sIE8KqB6P0a5ub7rlSwfJvcY/Y9xrLWnNU14sJTrquFUpcQOyBTnFQO0+lmVVdNMByyeF8n+EinnZnztR3OBSChY5/3gveeGwA55GjhAePW9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPCzarS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089F0C4CEC5;
	Wed, 11 Sep 2024 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726052652;
	bh=thqMcdaspNIy4jxq3jBQbrvGsrz0EH5sU9B3enTaQ1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RPCzarS/BE45uF2Km6hgHp9uKmHYAM7noDzb46keOGzRFqw0wLTZWMZY1wz15MxUo
	 59O9KKiGs+t9MXo73trAMfj+1FrR5kgtdeQF0B8OwhH0Z9iTAJ5tjPv9CZVTcu9ZQY
	 VJUbF5V5DkerTk98t8fUQpBFLCrblxlAlWnqmzrl+rV93N3L4j6CAHlhQNIGvWhLdp
	 ZzCGXvlkwWsZvzyrpK6T1NictVhVg8dZX47ICyTANth+Htsrfhs82OvVqJHyugfp3G
	 7g0xjZ92QzuVaS4nD0Lu2dQVnSjUeyBlLNRTo4g7z43ZSCUQFrMWA9Xzkq1RFydiQf
	 uKRVHv10HnJjg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	llvm@lists.linux.dev
Subject: [PATCH 3/3] btf: require pahole 1.21+ for DEBUG_INFO_BTF with default DWARF version
Date: Wed, 11 Sep 2024 20:03:58 +0900
Message-ID: <20240911110401.598586-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911110401.598586-1-masahiroy@kernel.org>
References: <20240911110401.598586-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit 42d9b379e3e1 ("lib/Kconfig.debug: Allow BTF +
DWARF5 with pahole 1.21+"), the combination of CONFIG_DEBUG_INFO_BTF
and CONFIG_DEBUG_INFO_DWARF5 requires pahole 1.21+.

GCC 11+ and Clang 14+ default to DWARF 5 when the -g flag is passed.
For the same reason, the combination of CONFIG_DEBUG_INFO_BTF and
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is also likely to require
pahole 1.21+. (At least, it is uncertain whether the requirement is
pahole 1.16+ or 1.21+.)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index eff408a88dfd..011a7abc68a8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -380,7 +380,7 @@ config DEBUG_INFO_BTF
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
 	depends on PAHOLE_VERSION >= 116
-	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
+	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
 	help
-- 
2.43.0


