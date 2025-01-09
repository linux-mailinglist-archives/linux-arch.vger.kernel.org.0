Return-Path: <linux-arch+bounces-9653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481ADA073BE
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jan 2025 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5DB167856
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jan 2025 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAFB215F4C;
	Thu,  9 Jan 2025 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b="qs6XAYPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWZqs6uC"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F221518C;
	Thu,  9 Jan 2025 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419956; cv=none; b=qgk4R5DLLO8X2M0oZv0b3o0G92XPz00yDmEciZGHs+QLp8o0heL4cDF8BWdEnZI8KPfo5yYJnoSOCP3FTlX0Q/KZMFbl79zL/nAJBhblTshQBxKevHMNsHV+rlQaom65jDWc7NQ/bUYjI2F+b3MQe0xqAaUNZPwYh6anrYuoPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419956; c=relaxed/simple;
	bh=0Kk7HYgdqKsT6Lkza+YhbUZPhCeM+pIpPHtXmY2BxSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkSw+cQLXofKYW2SQ3w5294rJFm3TxKeSGUaF3dCu1D6yAhpEMTQz6uJbPD1yN7hewHhIguETV0ZHhuWVkEdO20HshBrEzJJglMi8aTZOM7dfvVK5HegbEK34ExNiUDHkIJluQJ/XKCucxy/kDT/GE4JdkVbWKNnr8RDh8AsUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net; spf=pass smtp.mailfrom=bzzt.net; dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b=qs6XAYPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lWZqs6uC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzzt.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 067C5114013F;
	Thu,  9 Jan 2025 05:52:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jan 2025 05:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bzzt.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736419952; x=
	1736506352; bh=0Kk7HYgdqKsT6Lkza+YhbUZPhCeM+pIpPHtXmY2BxSI=; b=q
	s6XAYPzKBCBjqqOdz5/p51QDezFlR4f8kSiGFNYEGg5vEFZjvB4Hta9j0AZPEjLd
	J5WrYgr4PWh8xgmnub/PHP0UCXQEb7E9cxn8Qeyh8CY2eL/klOGjn+9iYMgC2oHv
	WgLACbsgT0RM03bJPcUQt2a6CsPhNjUL9fU11UZGbmEivbovz6NzSI3/UCGY3mHE
	zxelcnqnVyN8HSaforauaX5WmigOx88zGdQ9oSbHez4D0RsmjzDE/NW0gTNZcFUu
	FXpjhXvCSyxy5E1mldOImx1mzKIBmJis+/aVgoliwT8p0B5ECksdxPFdOUEHH/jr
	DUj59EqcOXID0d4TQESiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736419952; x=1736506352; bh=0
	Kk7HYgdqKsT6Lkza+YhbUZPhCeM+pIpPHtXmY2BxSI=; b=lWZqs6uCGyR2e6Ct2
	erxoR8ZhaG0aX9zaddmwiQq3MulqZxIvbbB1Q6gOHhfDS37DHLth562MJjxUG7ZY
	MLkc9KiGp3+ONrw/J1ilUsS1/9cKGQPwsxbsx77bPAU89faU5OOrUup7ogij1Obb
	gB7bvKJ/idbtcumDyjCRPgC57CF0jjSmXuFUihIdEE4Gvu19MfFrA7q8zfn7tuIa
	99fAXFY1f1k2qQwbeEOlCO2LxiGPeX3yc3aXcUPCiWOPWBffjNCC+0zFUH8ZQsHL
	6IwoZlLgywvRwtu9uNtvyyfroTljH+DV4VhTIymPZjqkarKiEKOBQmVwcqJx7NNp
	RNrUg==
X-ME-Sender: <xms:bqp_ZwSeWdhWqtywrSnjUO3eQI6M4BA6phCQQhZ9uASRFCu3KQ0IMQ>
    <xme:bqp_Z9z7xQ2autj-d-G7-XmazD4knM8swQQjhoojKMr53x-NxKZsxnfas9_KZvfE2
    KQpE4Z1Ql5kWehAxBg>
X-ME-Received: <xmr:bqp_Z908xKtwoL5qpcWw9b4mp6g7Sww9LjJn8gMpG2kNrr71fRvKMdWuXbqELGTaSaRPz9Tc2WZLE_qZ-b9T4Q99tYRSxjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetrhhnohhuthcugfhnghgvlhgv
    nhcuoegrrhhnohhuthessgiiiihtrdhnvghtqeenucggtffrrghtthgvrhhnpefgiedutd
    ehffehfeevieelhfefueejgfehveeljeettddugeehvdekjeetveehgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnohhuthessgiiii
    htrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhinhhugiesfigvihhsshhstghhuhhhrdhnvghtpdhrtghpthhtoheprghrnh
    gusegrrhhnuggsrdguvgdprhgtphhtthhopegurgdrghhomhgviiesshgrmhhsuhhnghdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhksghuihhlugesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhmohguuhhlvghssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bqp_Z0Dk23fMFhiDqy_Cc2coLs40rI-v0QZoCACMG2qRm_hlftwFkQ>
    <xmx:bqp_Z5hz9b4EDtjewMTL8V4O0IiaBmYJSshUTKl35WIc5Iv6INRhEg>
    <xmx:bqp_ZwpkY7UUJlhUomwHsuYzcRJTsBG3K8VLG5oHmqxJuIbTv0h8hw>
    <xmx:bqp_Z8glCN_IXqIFv6MeQM4CcPHp3TLYel23nAaPK8q1ffgkThZewQ>
    <xmx:cKp_Z8S3geGCAJdB4xKDWZbjtN3MVgtLJnud2BWBQIRJTnwU6u6s8FMm>
Feedback-ID: i8a1146c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 05:52:28 -0500 (EST)
From: Arnout Engelen <arnout@bzzt.net>
To: linux@weissschuh.net
Cc: arnd@arndb.de,
	da.gomez@samsung.com,
	linux-arch@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	masahiroy@kernel.org,
	mcgrof@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	petr.pavlu@suse.com,
	samitolvanen@google.com
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
Date: Thu,  9 Jan 2025 11:52:27 +0100
Message-ID: <20250109105227.1012778-1-arnout@bzzt.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
References: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 3 Jan 2025 17:37:52 -0800, Luis Chamberlain wrote:
> What distro which is using module signatures would switch
> to this as an alternative instead?

In NixOS, we disable MODULE_SIG by default (because we value
reproducibility over having module signatures). Enabling
MODULE_HASHES on systems that do not need to load out-of-tree
modules would be a good step forward.


Kind regards,

Arnout Engelen

