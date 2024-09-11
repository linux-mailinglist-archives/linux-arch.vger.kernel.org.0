Return-Path: <linux-arch+bounces-7206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E8975061
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A05B221E9
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3817F505;
	Wed, 11 Sep 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLjRBmjb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2248CDD;
	Wed, 11 Sep 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052647; cv=none; b=PRpptZBft9+8EGHmUn3k+/QAfSEbcpfVg/8bJ+nYmcKNtpAtD4wuEqWNNv7CuFHlvT20SzxQ01j0C2QNbeRXm0vqXL5BV5mhIHxRmOY41uIpj9bAtae7Js+7/GELn64qZzK8Y3JggrDgLHdonZ8HxoGevujS7EqhzPwnvM2Z+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052647; c=relaxed/simple;
	bh=1+IU6LatGUY8P8DoeAOBjptphnvD2Ge6sR2P5NNpFHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuiU+x1En9piTSyHCYjkguxESzBkGgTw6s1Wk70bJ26/zSLmWbhch8RPS1dBD2jf7gLGKXm5Dwev2amSDZqeAR4wJxTH8rVfxtT+l3AMJ2FmgXjn+SfE4bKTBf69tbGL7429ydwaMciKr2n6xfJhaOQQWnn5ZZY4HjxJudAnxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLjRBmjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2E2C4CEC5;
	Wed, 11 Sep 2024 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726052647;
	bh=1+IU6LatGUY8P8DoeAOBjptphnvD2Ge6sR2P5NNpFHs=;
	h=From:To:Cc:Subject:Date:From;
	b=sLjRBmjbdA058AD0mbvoAyeCAr3fsLhksbFfYgPua7cmTShzERKlWAAuCnnsLIGYO
	 KQL8SCzedWy/lRmz3nuRKhMPGpVT2drshBuDrzQtTjhD/tZOp5ZCQr3JiPbe0iFy3s
	 LdtSZZDM7kAOoIt0lYORsPE63rot5yT1eRRG0nYlHcJLIldiQEnRZt8/LN/+g1c6Y2
	 xPdpMSIe+v9PlcF70ZKvoBeRBZclcS65ru21nDqU7WbsyrPVObQb+ii2A3wusOx8KN
	 mLXRhPp+rP1xDM6efY2EQq3SoexrZn1yWBqV6lsS9evX20ddFYgQgGXxbf9DaYJi26
	 a+5ISXkWyZa5Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
Date: Wed, 11 Sep 2024 20:03:56 +0900
Message-ID: <20240911110401.598586-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
selects CONFIG_BPF.

When CONFIG_DEBUG_INFO_BTF=y, CONFIG_BPF=y is always met.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index bd196944e350..cfffc41e20ed 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -288,7 +288,7 @@ strip_debug=
 vmlinux_link vmlinux
 
 # fill in BTF IDs
-if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
+if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info BTFIDS vmlinux
 	${RESOLVE_BTFIDS} vmlinux
 fi
-- 
2.43.0


