Return-Path: <linux-arch+bounces-7676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA698F8C7
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 23:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557FA283BC9
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075921B85C2;
	Thu,  3 Oct 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="MgUTrxX5";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ukm3MEFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuoX+tN8"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF71AC429;
	Thu,  3 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990316; cv=none; b=NbWTrteLGTSu0Pgz6FSJPOmIdw8xeC6afiB3sA855uxWIiLXMpwxOilyAHZazC0yutPQRN4r/muD8nvHOkV0zc6+Y6pUdDRCrWhPsu8+bAg9O7NaX/7mxpHwaId/N44Dmxwbn6IMububREO2ptOWEllvRbA66m+enbL6bzLRsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990316; c=relaxed/simple;
	bh=LmRkPEtetlt/EtZRgE8oBBdUuhM04htPeZvlXdE7Ps0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oaj5c/UvTrN6m7RdrnDrdaGvQRr58p/4bcj8tGR2cb2WIb16Ch53u8FEbb0D+A21jaQNIMELI7j5rC+s9K/79Ev0Cuntt+qUrrER0AnRi/LGZ4rw3zI//CCVjunIX93UteOFM5jWBKBYMyKKHy2F9JuGMgmvjI8UO0Yx6sCB9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=MgUTrxX5; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ukm3MEFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MuoX+tN8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F06F9138027D;
	Thu,  3 Oct 2024 17:18:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 17:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=2016-12.pbsmtp; t=1727990313; x=1728076713; bh=e57WkNCw2N
	btjgn0XJeGOncEvSeD4r7iE/OdJO8XpKo=; b=MgUTrxX5ee1jj/8bC2ioFQAUqb
	J5KPn6q/hN8bEFVjBjB70XMvm58a+3rr4e/MEG6Oy6ERE+yIxMbbaY4Kc+xPNJ+9
	mWxlJErOnnSrik0633sFBqcO3UhyyKSKjZb8X43dczhrnB0a/Fj5zagtbd9U/cCm
	v2kVcoVSLqS92Ij0Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1727990313; x=1728076713; bh=e57WkNCw2Nbtjgn0XJeGO
	ncEvSeD4r7iE/OdJO8XpKo=; b=ukm3MEFV7275SzLEX3J/aFZZNS+2QHY8nVC15
	atwSW+AFIpfD0TQF/dy869Ni0EmwSUkTVm6xFX+8KahndCVaozsDn3NlBglAd98T
	AEdnsFkvKZrqO7hVJ1FKZjr7tl3GKjrPg7mKKA0p0kgFMAex6sbmbyJWKcVEyfvK
	XFjOwG+BhfEYra8jRoidJnMlPfcVFPeBQGheQoPZu+b+JqVRwQYIaUzTKFkOHE1T
	Rm+Nby8/rhOlqcCT2LNXTqOVtt77/snxU4AUcLntxk9M3/q/u/UIgZ8Z88N7JFVV
	eO+S0f+LukLSQ8iA67+GESXdcJLjUG4uLOAa6kvzg0rwnUb7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727990313; x=1728076713; bh=e57WkNCw2Nbtjgn0XJeGOncEvSeD
	4r7iE/OdJO8XpKo=; b=MuoX+tN8fujn8nfgJk2lvyqI+0dQHfUqu96Oc/z5hWuP
	jDhV+su84RGeDxNYL3T7V4wrkB1iMNH4RsC0ul6vLhjYJvW04M1kCoqTW6YlUdgN
	kMvm9MI79KCdkFqOV9Xzm/EXogOvHCOZ44lZUw8XCL/vpO6xerr7hpN2BQbFW2it
	BDzFGeDtUiWPucn1Y6oKxAypaTdfocw8XxYnj81CPQaiDAA1A9jcmr6Ln958i8Od
	H1zwUlSX/rOCpXPOG6QmJ7e7guT/ov+CxQL1+pfuBfC+rQe150ybxSzZjHjoPPJe
	6YEKmX3bEnOqlFiHioSTIFWDKS5x7nmMAvljhj5hOQ==
X-ME-Sender: <xms:KQr_ZkewgwB7hMgTQOISo7x3gqcu37oAseGzFsNmlYm2kXC4x5h2ow>
    <xme:KQr_ZmP02-PiBk3at19onqPaC8ZLhc-g4jBjIoQ8ldZr7PCcxpZhiWBAnnnouRUFU
    noCua81aRKTDopy6s0>
X-ME-Received: <xmr:KQr_ZlhY3L6hjm6Oj_093HnlZAudI9axeOFh7yT1ctyzd6XJ3u3VV61yEo6lFk5krSA9dF0FhGU6jKQ8RJ4aJTz4ljwu8ubxaeNmtd59Pvj73rfvEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeduhfdvlefggeeugfejiefgtdekjeehkeevveegiedt
    ledviefhveefteffieegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhu
    gihnihgtrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohep
    rghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrh
    gvrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:KQr_Zp8ZNEH1eWl2JwGVRNUha0YIBXBLQPupp6msDA-6KcbewkthBA>
    <xmx:KQr_ZguHC08c5HklB2MOffd7C3yG-ZWthDwX7JcmnAIAF_MLBbI2uA>
    <xmx:KQr_ZgH-Roz9f_Pn16v8-fyt16L57BpUAsebNIo7_Hhg4rX4bUNGog>
    <xmx:KQr_ZvOd-PvDxHlnIYrfyrITVGTTAJ1Z-qKjZDo0XCP-bZWRf-7ROg>
    <xmx:KQr_Zki1aVQdq3CgMzPVF7sQNn3wGJ9ng6dvkWWuwaINjGPgMuuQSEuM>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:18:33 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 7A224E3CD82;
	Thu,  3 Oct 2024 17:18:32 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] simplify do_div() with constant divisor
Date: Thu,  3 Oct 2024 17:16:12 -0400
Message-ID: <20241003211829.2750436-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on mul_u64_u64_div_u64() improvements I realized that there
is a better way to perform a 64x64->128 bits multiplication with overflow
handling.

Change from v3:

- Added timings to commit log of patch #4.

Link to v3: https://lore.kernel.org/lkml/20240708012749.2098373-2-nico@fluxnic.net/T/

Change from v2:

- Fix last minute edit screw-up (missing one function return type).

Link to v2: https://lore.kernel.org/lkml/20240707171919.1951895-1-nico@fluxnic.net/

Changes from v1:

- Formalize condition for when overflow handling can be skipped.
- Make this condition apply only if it can be determined at compile time
  (guard against the compiler not always inling code).
- Keep the ARM assembly but apply the above changes to it as well.
- Force __always_inline when optimizing for performance.
- Augment test_div64.c with important edge cases.

Link to v1: https://lore.kernel.org/lkml/20240705022334.1378363-1-nico@fluxnic.net/

The diffstat is:

 arch/arm/include/asm/div64.h |  13 +++-
 include/asm-generic/div64.h  | 121 ++++++++++++-----------------------
 lib/math/test_div64.c        |  85 +++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 85 deletions(-)

