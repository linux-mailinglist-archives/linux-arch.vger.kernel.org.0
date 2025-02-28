Return-Path: <linux-arch+bounces-10470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20AA4A03C
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0185188ECA3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0161F4CB4;
	Fri, 28 Feb 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oP3njEla";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNujEEcy"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABC1F4C98
	for <linux-arch@vger.kernel.org>; Fri, 28 Feb 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763438; cv=none; b=s1oe1VYmX+XCRSBhJM5zTwgcLTpJPIY2qLtLsGC6PPm2l+M6L8FnuyPN9+ZheWBXRmAtB5Uc9sPVxAOcW+m+dYSQdu7JN4AYYh69dzYLxpqeMmPePZVYGXEjx6bdMfL3795GgDCxDRTLshi4BcBXvUK2WcMBDpSbV0bFH6vXmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763438; c=relaxed/simple;
	bh=qMgsQJzzJwhdfIm2FuoGlewapCBjicP9eHbxEMGbN7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dssc2rVT80ZfWbeo8g9p8VWZ+6XDJJ2NBexDxygVlieIInvzOXmQiRKb4Z830kancohsgUPLO55Lk5vCmr4NyvSZYRfsY+j+pUy3DlKb9F9FyjqaBGk/IXXylhGSbljf9jnjn6xtdBz7kW6nEsGtq4ehTe4Pd48PIr4/3DN1CIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oP3njEla; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNujEEcy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4036F1140132;
	Fri, 28 Feb 2025 12:23:56 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 12:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740763436;
	 x=1740849836; bh=KsNT0kZqfkthh/tOPMer9CehQgHH2fLyt/p8C55R7rA=; b=
	oP3njEla0tk+bqYgwkn7VGyjMvw/Hcjr/w6X2zvCGS1Av5xoVObmcC0mJ+OzFIPw
	/ofM7r+OdBGz9CSvgZqff/seBIl12tg4xfYlzwucd8nJtE9M97PT3mUDrq/fMiLI
	G9vBg4Ng+ep6TeKVqwB/BuyRr+28VyqHMJYiYoWF8yOyMXuSfXj5/lKyTeSvC7G6
	Z2riHIwpv2tZ4NjC0Sdz1lZD1jeJU1i1GLbhydIKZ5/lGzs077EWimNkXmqpmzKq
	TFKWIS9sUzSDpfqDznuSup+j42PttaS2QZPyW7tIotRzttu1suueSl/PhW7e56MX
	UEK1fk+ABFkzHSG6K5mhng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740763436; x=
	1740849836; bh=KsNT0kZqfkthh/tOPMer9CehQgHH2fLyt/p8C55R7rA=; b=X
	NujEEcyNeyhsO0LazG8expBEo8Ukm9Osa7Ig5n3fHEEOuHVtLCkJ1ftcU18t/PpN
	Cjreu+ObgYtsMytVxuDgN4/wIsdlarLIAkOUnrJTEawU26mnDSCVy6JGFHdIVOt1
	qyvsO97DeWhCjJ3eKKWQ1k7I7mt91ivBoonN8IkL6v+mX7+EGBpmrLNtIMxUNYN5
	+96Fzv/QHqPLCTHmxKQG22yCxSjogHjH/bCf82XQn6IOa39Pw9bT6fP95sIWb8ub
	BSw71Z6lkeuyQdiBgJ+GEFZsd6uLMlJMYM+Kg7B4fDpqx56O5kLECB18538CqpQk
	LCBY0go7/mqO/K/GGoJBg==
X-ME-Sender: <xms:K_HBZ3V58SEBJ25F0dT_lzHrFM3ntyR5qEMcsk5JJbdVIFz10qggRw>
    <xme:K_HBZ_nwwRzjQ0lYoSAWS2f0uPe3o08QV14z3Gzz3xlXslDOoTy3tVUe8rN98VQA-
    Jb1O4_VGSM_P9Kvib0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceuvghrghhm
    rghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhephfdthf
    dvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnug
    gsrdguvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlh
    hlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghh
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K_HBZzao_4eALlgdwdV5nqGd8VzqF10_AjzJVyeEWZTo9PMj7UgKKQ>
    <xmx:K_HBZyWPpsO1zGDS1pyiCpodv0McSv8kXOfI1EXj8Pz5esNn8HF2CQ>
    <xmx:K_HBZxn15TpG46VNQfA1MQaTHVWZgznO8YXel6Se5XnCnYUc40zwpg>
    <xmx:K_HBZ_dtENARofFDFJALLncVnsKwKFA2Vg_epsmc00zMunRXH9RZAw>
    <xmx:LPHBZ2wsRxtsc-AAdXVe0g_KGJqrrSGIzfoSeTp8ZMr4zC50vInOpVuN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ADD572220073; Fri, 28 Feb 2025 12:23:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 18:23:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <57aadd72-e3a4-4ae2-ba94-4f0d397787b4@app.fastmail.com>
In-Reply-To: <202502280814.ATzYxKLc-lkp@intel.com>
References: <202502280814.ATzYxKLc-lkp@intel.com>
Subject: Re: [arnd-asm-generic:master 1/3]
 include/linux/io-64-nonatomic-lo-hi.h:132:21: error: implicit declaration of
 function '__iowrite64be_lo_hi'; did you mean 'iowrite64be_lo_hi'?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2025, at 01:10, kernel test robot wrote:
>
>    In file included from drivers/vfio/pci/vfio_pci_rdwr.c:19:
>    drivers/vfio/pci/vfio_pci_rdwr.c: In function 'vfio_pci_core_iowrite64':
>>> include/linux/io-64-nonatomic-lo-hi.h:132:21: error: implicit declaration of function '__iowrite64be_lo_hi'; did you mean 'iowrite64be_lo_hi'? [-Wimplicit-function-declaration]

I had a typo in the patch, fixed it up now. Thanks for the report!

      Arnd

