Return-Path: <linux-arch+bounces-13569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827ABB56416
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 02:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315367A3897
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 00:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7380B1D7E42;
	Sun, 14 Sep 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2quywLS"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A211D79BE;
	Sun, 14 Sep 2025 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811540; cv=none; b=qRZT4rDYZyqlvfB4Q1in3zeiYEmuiDvWwWQd5KwnKYUBWa/Lx9nsMRsuD+tVzBZh7sU+JwFkBqZamGVuDEiLJutiFnqajPQES7wELz4+ux4Iij8S9M+FDpg47bo+qkPtd/vA22eR43CGsQWCJLWhTUEef8xeGK7xljtiYP2FS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811540; c=relaxed/simple;
	bh=o9lkQbbpBibFWvTNPnvl9IY8JEMBKOvXU3P9W52BYN8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=kiyFYveVwb45HRCgPysVQe1+z2jGVNI9SHlyQa+aMZBpU8Gaeuw7EHJReCYhXaXhanklBzPzKGaArWreiFKMNY6P+i72YOKQ6L9NoKD8t6O6gt5GUw6MIDI4avEb7YvfDuMVa1zMXyeLORt2anQp+uFV/0HOt//EDEngeSEV6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2quywLS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 230AA7A0089;
	Sat, 13 Sep 2025 20:58:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 13 Sep 2025 20:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757811536; x=
	1757897936; bh=deVHNxmHpB/t+ufTPYero2jLsQQUFKf8oNfpE3SPyRM=; b=G
	2quywLSy8P05Cf2fed0qs5bdKKaiUCmaXVvefMKUvIXi0OO2pGqAxgLUeQH9vlWh
	marBMH6sUwIE21EhTSias6kBzXdlbq55QOzOiXjvND5ZuaiLurqpkhwPj7iWgCzl
	1CT/l9k4wCdp3nj2Sk2RB66Q+XxM56m1Nx4Nn0kDN57ENpzXXHzgeV1CBuVI165R
	INlBjsePL5nOh5qxT6f4HzpirrWQyh/d0uOOyv2C6rygDHCn6QM/wRhYEa7ONcXj
	97wuiV8wej3Q1u92LM8vACzym9863lY2zkYR7K2JYehN5D9EakSCEKlr5R2KnFCr
	GIRie4tJB1E/Ok0lfqJhQ==
X-ME-Sender: <xms:UBPGaAFZMEVfa2T-9pULozITsmaihkoyXyP2ifnhcU2crQ2GGrDJ1Q>
    <xme:UBPGaPTsaE1ZBzLdOAIkPb8B7ii2kPnJ3dgggKLpb1JECfNc3EIDHYqKJOxmhOCet
    Tcs3Jb4JopPwn3CQnU>
X-ME-Received: <xmr:UBPGaHS77aiWxCQiKYmT6N2miVHurJfBGTxP4PNqDbSwIjt2CDJikfYQ-Qra8jP9AUfJ1YCPYMo17-ouZxia4po2m9ktAqVd7cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvefggfdthffhfeevuedugfdtuefgfeettdevkeeigefgudelteeggeeuheegffffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgs
    vghtsehlfihnrdhnvghtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtth
    hopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UBPGaC0TfYPA1DBy4sGOiM3J7ZYDKJR7z9mnWcpVyOrvlZBBlftpyg>
    <xmx:UBPGaBzkoRxn3bZ9bHCjnoCdvfZloRHXX6eeH_UaebQ0sjQUoA1llQ>
    <xmx:UBPGaOwqna9lGI027rcJSth62S9jjRCKENPVQ7Jmtyel_qnMZNAhuw>
    <xmx:UBPGaN9B0dHEoZZfv-y1pFo_77FM7FzqY6PCWhdnpGcb-H7FlWSQzQ>
    <xmx:UBPGaDgqLN3xzJjFV0GefhMV1qslwo_zH60gV3WQrEIYCdoL7Aq2OFN_>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 20:58:53 -0400 (EDT)
To: Peter Zijlstra <peterz@infradead.org>,
    Will Deacon <will@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    Boqun Feng <boqun.feng@gmail.com>,
    Mark Rutland <mark.rutland@arm.com>,
    Arnd Bergmann <arnd@arndb.de>,
    linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    linux-m68k@vger.kernel.org,
    linux-doc@vger.kernel.org
Message-ID: <53a8eeef7227391c1d4298b547386a027f23fb46.1757810729.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1757810729.git.fthain@linux-m68k.org>
References: <cover.1757810729.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [RFC v2 1/3] documentation: Discourage alignment assumptions
Date: Sun, 14 Sep 2025 10:45:29 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Discourage assumptions that simply don't hold for all Linux ABIs.
Exceptions to the natural alignment rule for scalar types include
long long on i386 and sh.
---
 Documentation/core-api/unaligned-memory-access.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/core-api/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
index 5ceeb80eb539..1390ce2b7291 100644
--- a/Documentation/core-api/unaligned-memory-access.rst
+++ b/Documentation/core-api/unaligned-memory-access.rst
@@ -40,9 +40,6 @@ The rule mentioned above forms what we refer to as natural alignment:
 When accessing N bytes of memory, the base memory address must be evenly
 divisible by N, i.e. addr % N == 0.
 
-When writing code, assume the target architecture has natural alignment
-requirements.
-
 In reality, only a few architectures require natural alignment on all sizes
 of memory access. However, we must consider ALL supported architectures;
 writing code that satisfies natural alignment requirements is the easiest way
@@ -103,10 +100,6 @@ Therefore, for standard structure types you can always rely on the compiler
 to pad structures so that accesses to fields are suitably aligned (assuming
 you do not cast the field to a type of different length).
 
-Similarly, you can also rely on the compiler to align variables and function
-parameters to a naturally aligned scheme, based on the size of the type of
-the variable.
-
 At this point, it should be clear that accessing a single byte (u8 or char)
 will never cause an unaligned access, because all memory addresses are evenly
 divisible by one.
-- 
2.49.1


