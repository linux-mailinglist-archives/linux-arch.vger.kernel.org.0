Return-Path: <linux-arch+bounces-13827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B80BB1FF8
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 00:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53F219C51F4
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 22:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F112C3250;
	Wed,  1 Oct 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="T82ytJLm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+gtj5bR"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EF2749D7;
	Wed,  1 Oct 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358114; cv=none; b=Xpdzg2xMXndRg6Vu7PGifoBlCoNaZUXdbMMdodAlSVtEOq9C1Ou3lsTmj4yRdOMJjyIRbR4tns1UEjisNYxhurrVfSgi5i1fP9TyblXXuEFfCjWwrhfKVIAyCg3M6/CI9R1Ul4Ifu+iBTkrpZETZ0hFoeAtW2LN6Bmtz+g3I2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358114; c=relaxed/simple;
	bh=3P/nqNgE/qloPsH9biUX4y9yyNm5BrHEBH/Jo1ot9cE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=MilnuKZgs1wTGp8fJ4uPAzy09izuflDJVrvNITYonISOUkjE7NdEBtXptaskRBbcTm+aV1ECFqe5tb47ArGl2YkFYvG9liuBmz9MpcR5dUuXzpfSTdHTe22X9Dck4sTDtA1VsTcYbYyX30+sWUUE6K/TtEkxHf87eZZHyoLVx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=T82ytJLm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+gtj5bR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1288B140012E;
	Wed,  1 Oct 2025 18:35:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 18:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1759358111; x=1759444511; bh=xh
	fmxVYM3t7YQwjKuUI67MO2N05QMfEvlZDWh5/DqcI=; b=T82ytJLmx3PTSLJfRx
	5pNdi6/gmcOXYL7BvBfXGccljnJ/tvnkt0fP6F09UHI4svseyFufv4U2HuYngBJA
	V1OKMUKuHih1YbSs9SImUULNjxBst6JYtfbV6TPRx5WnPGlwmSwxhSaLNc2Y5OI4
	IyiMOB3tKkQjHKTEaSYHsqXbSKXT9uvwWo1m/0lSIUt5eP6RZDI5H5ap+8z0mOXN
	dbhvdxcagMacFo3MJfr8Lv3PdYNvuXKzoHlFgCYzEp2kxtBi2RdlWQUxpJqZJcEQ
	mk1z1s1qrrUS0wA+ZObF5rWx5AL7DhHgKzkaqWDXT9D9qsShF8VTI1Wj+OYzC2U8
	6/dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759358111; x=1759444511; bh=xhfmxVYM3t7YQwjKuUI67MO2N05Q
	MfEvlZDWh5/DqcI=; b=P+gtj5bRwGZe7HlVP2rsoiNg3HeyZzAZ8hBtEEfQnzxK
	RfRPyBIzH4Lm+XNc7Mb0EkHH6pb5ffejWOZLpsnQJlMA/vMB8FeWSnM5iZP3ylyA
	x5Eca2dq9WIXCgvdnoLssKAzfZ5LjcLLuE1qv0pKWHLQt6isKK2tPI2A226vLwix
	MP750hrApqWtUrWPzaVOqU8fI29sriaEH8GMVkcNiwoiTGZd5myr0Rf8kCoWKTUo
	fd5q7t22172uxJkJMLiebAiFDXqO9By+BmssabXI5wRjxvu9X9bHGLM4vyXhST4m
	yZ7akRAwgydXguLrAB2no/1VjJxlFR7Z7nQC5XBwvg==
X-ME-Sender: <xms:nqzdaM2Ar4ZrLDNJFEIlsTaeDeyKRUGWIm8ziJd22Kx4B7pxcM8Bpw>
    <xme:nqzdaB7Z_GSS3FR1ZAuJDUp71nO0ZRb1YzZ2vI2ttnZg673Cus10UnFCbhITbBO8m
    ccqSK1ho5VOU-rE6ZSsUqwKff4pITfjfRA02XSfhwnX-WXaXf1t9Ptp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegv
    rhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpe
    duleeigeekveeugeettdejtddtleeghefhvdfhueehtefhudelffduvdeuleevteenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrrhgrughgrghuthgrmh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepgihiqhhivdeshhhurgifvghirdgtohhm
    pdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:nqzdaJCU3VpYwsbisuYpJvA6EEOd9PgBiWntb0yxC8nqYRKZqJiUig>
    <xmx:nqzdaAf7jZxfHbkHllB_0U6X2mOOMmz5KQnoLFXDKFkLRUwLNbaXpQ>
    <xmx:nqzdaAJ0qQouv_BctbPLO3sGS-JwxZJJmx_wy_oI-KRW8dN5X8GjxQ>
    <xmx:nqzdaD1yqW3nvRXPAz4aUlCv6zAk8sK5MvZGwvWyMOsAHTadrUypdQ>
    <xmx:n6zdaAnQQmp9rbTbQB6NriVn0bMfYPcKIzSKU-dZ5h3Q_Au7nt0suBWI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F2FD700065; Wed,  1 Oct 2025 18:35:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Oct 2025 00:34:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Qi Xi" <xiqi2@huawei.com>, "Varad Gautam" <varadgautam@google.com>
Message-Id: <7617c200-a7a1-4957-bf5b-c1cc36487563@app.fastmail.com>
Subject: [GIT PULL] asm-generic: updates for 6.18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.18

for you to fetch changes up to edcc8a38b5ac1a3dbd05e113a38a25b937ebefe5:

  once: fix race by moving DO_ONCE to separate section (2025-09-25 08:01:16 +0200)

----------------------------------------------------------------
asm-generic: updates for 6.18

Two small patches for the asm-generic header files: Varad Gautam improves
the MMIO tracing to be faster when the tracepoints are built into the
kernel but disabled, while Qi Xi updates the DO_ONCE logic so that
clearing the WARN_ONCE() flags does not change the other DO_ONCE users.

----------------------------------------------------------------
Qi Xi (1):
      once: fix race by moving DO_ONCE to separate section

Varad Gautam (1):
      asm-generic/io.h: Skip trace helpers if rwmmio events are disabled

 include/asm-generic/io.h          | 98 ++++++++++++++++++++++++++-------------
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/once.h              |  4 +-
 3 files changed, 69 insertions(+), 34 deletions(-)

