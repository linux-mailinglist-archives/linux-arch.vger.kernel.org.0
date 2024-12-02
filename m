Return-Path: <linux-arch+bounces-9230-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D49AE9DF88A
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 02:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54436B228E4
	for <lists+linux-arch@lfdr.de>; Mon,  2 Dec 2024 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EC146A69;
	Mon,  2 Dec 2024 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhYadkzk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D513E40F;
	Mon,  2 Dec 2024 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733102494; cv=none; b=UtSFcPJx7GF9pRuCa77cuir3MYYCBhNRc3zFnMxk1FMSc6nDcjwdGPnY/xW3KnfEW1gginbMw+wmh0VA3HjK40e1tbQiNgpWsSnxzoRPQFEGuJuFWWW8BCteUT/rms8QcGvxPnNgWKZ5h/b+pNHiVTHZRaCbp3aeFYOC5BrKkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733102494; c=relaxed/simple;
	bh=tOkBM9OKj+QnnDmg3KXsNuWzGOUW1YaMaa8G27/37Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxeqPf+Bejk5DQUqv2rUvnGMnfaqMnESChFTYxx6bhs2ix+K8X4Xo1PeplWWGF6EDVZn8iDaWoseDWtFL3bM8CfeYfaK0lWVONuiv+KB3ZNhEpDZDo7ZVZSj60IjzvxdI5cy/JSljZ6Dx6juzS6RT4sizMpcGFsz+vPtkxZgQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhYadkzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496B3C4CEE1;
	Mon,  2 Dec 2024 01:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733102493;
	bh=tOkBM9OKj+QnnDmg3KXsNuWzGOUW1YaMaa8G27/37Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhYadkzk8Wpm1ITszh4LwCoo6RCymijkaws9sU9g/KGsy9DSpWRmbKngnVBniKYZv
	 ErPb16+qEvaUkykp4VtBfrvOfVTPr64cYgZw2glt62J0whPQAGvPo9CTqugNtHLf7c
	 bR6tfEyyt9k48DlViebHmXiT/K8l+bd6vLUVwdrY6vcmczq5K5kKDEUS4ny5en5mgQ
	 j5i62pwZxIzqgUh0vTPC6/rv0sbFcxGUkXFPlAfdlelqDdzIhTSlk643ODVxFPEpTW
	 UOUjKNwH5bTSyGAWLP2m00SXeKqdb65SxhRJUtEBjn+EfI5V1uAWfpK3gMgnUe3no5
	 t8LBK7cKrA3RA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 12/12] MAINTAINERS: add entry for CRC library
Date: Sun,  1 Dec 2024 17:20:56 -0800
Message-ID: <20241202012056.209768-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202012056.209768-1-ebiggers@kernel.org>
References: <20241202012056.209768-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

I am volunteering to maintain the kernel's CRC library code.

Ard has volunteered to be a reviewer.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..b7eb0c0a9c1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6054,10 +6054,21 @@ CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRC LIBRARY
+M:	Eric Biggers <ebiggers@kernel.org>
+R:	Ard Biesheuvel <ardb@kernel.org>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-next
+F:	Documentation/staging/crc*
+F:	arch/*/lib/crc*
+F:	include/linux/crc*
+F:	lib/crc*
+
 CREATIVE SB0540
 M:	Bastien Nocera <hadess@hadess.net>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-creative-sb0540.c
-- 
2.47.1


