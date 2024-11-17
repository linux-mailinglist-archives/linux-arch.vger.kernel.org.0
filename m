Return-Path: <linux-arch+bounces-9124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B609D01B0
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 01:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1741286497
	for <lists+linux-arch@lfdr.de>; Sun, 17 Nov 2024 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEBF13BAD7;
	Sun, 17 Nov 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH5o4nb3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0AB67A;
	Sun, 17 Nov 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803038; cv=none; b=Wcpz0YjbIJfZM27kNZq2ETDOir0OwX+XMXBUraB0aTbJe0YgFuc2ABFBw4aAI33BC4JO75lsYpq1XP/EuVI3rPNyueiNVEVCs5KrxoRGVOu09SUngvNxixTh+WbTB3tzsB1aXk7q+MMfZbbrQh6pvmGLO0JLfwNS4R5VAX5O2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803038; c=relaxed/simple;
	bh=gikOnfBjekSzGf6NqlY+odr2KqKVyYrQvBhQkTK3oqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLxA35XmX6dgM0pnFftC6KWURLljJStVltkVgt9hXsndcTe8Y3vViOYHnb/2XwEgwCKYAKBs92RBHUbkoLLBXUr6KL+fQMxqNa55gAEfQQunH76rO8SvkUg2WSuDIefD4yPoc/tzRsYZQTaAjHqnbRjSmY6QcPW/0kLMARn54JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH5o4nb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B1AC4CED9;
	Sun, 17 Nov 2024 00:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731803038;
	bh=gikOnfBjekSzGf6NqlY+odr2KqKVyYrQvBhQkTK3oqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UH5o4nb3MbDFI7VGAxCOF+o9Q9t+WxRpA1f2cg+TtQFgYl2KFizmYdfMVE/ji0Ho1
	 oqZZH0z849b0GxE15m+X8+SPEyrxdQQ+NKcxPOhPuiwBSda7WTDhym+vaORjmrHnfO
	 M0/I/j1Sisn3Eiu8zI97Pfn3z6gGRPkCAOMzzoz5CtWfG/0uPRqmsIHI1UDBn5NYY/
	 3qdx5aa+nLV0C0hj02e2R2X1zsNkrLUNRxmoiXoZxNPwyDC587XCRjvadQH/swR/gB
	 hoMkyTyVXupR++o8Sy4Ve/gXdMUC8n2JysUjzdX29ZwxeqbCQlkMyFRpRllM+OoO/k
	 9+XdVmWdtGYPg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 11/11] MAINTAINERS: add entry for CRC library
Date: Sat, 16 Nov 2024 16:22:44 -0800
Message-ID: <20241117002244.105200-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117002244.105200-1-ebiggers@kernel.org>
References: <20241117002244.105200-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

I am volunteering to maintain the kernel's CRC library code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a27407950242..2bfbdcad0282 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5982,10 +5982,21 @@ CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRC LIBRARY
+M:	Eric Biggers <ebiggers@kernel.org>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-next
+F:	Documentation/staging/crc*
+F:	arch/*/lib/crc*
+F:	include/linux/crc*
+F:	lib/crc*
+F:	scripts/crc/
+
 CREATIVE SB0540
 M:	Bastien Nocera <hadess@hadess.net>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-creative-sb0540.c
-- 
2.47.0


