Return-Path: <linux-arch+bounces-13607-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3BBB571C6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E393744069F
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869402D73AA;
	Mon, 15 Sep 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mPtOxgNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6nKJ9MD"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF32D6E5E;
	Mon, 15 Sep 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922059; cv=none; b=r+Sls4UdHZ0nt9bli+5Ej3+nMm8kqlndpz7rD7D2HPKCgH81NFree7zAJ2rsJ9ZdGWEJ6UltpwAMYKMYEudlMPTgyeCvKg216aEDSarPgHFXyPsexgkYFHpc0j8ugnNFQPcaSiBY1vS5gTBprKpyq7U61VtY00XbyTWRQHsUzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922059; c=relaxed/simple;
	bh=59eiYpGD8uho8aeaQI+TTJPc1va7kDm+pwBNsNnHp4g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=smJDJL8ZqRAU2EfzhtmaanTo+qgHf1ZK84qTbTlF8G/sEPRECVhfkXwYKo+h1oNqvDLjyYngq6Ql7jmkQyC754OFsRUUTZPM76Izl3HQPjQS+HUqEGA4FsqIAM6r2VRWzpieOU2xbK8V6B9szZ9yX+6Bydw8HQ9mV6fOCS9VZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mPtOxgNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e6nKJ9MD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 85612EC0200;
	Mon, 15 Sep 2025 03:40:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757922056;
	 x=1758008456; bh=59eiYpGD8uho8aeaQI+TTJPc1va7kDm+pwBNsNnHp4g=; b=
	mPtOxgNjo3xL57GnKyn1Oub4BNkFSJTbQjrA25Qk7wTzXp7zgRDNdeT8mhDYYI58
	s1bMOIdnFtZQaX0bKa6dg7kgC5/JHn6Rc0WIqgDBPkaMxHMboJGQEee/2ScegseE
	Lzxa6o3nM9Pmwv/IFuTtr+36R5qtCvjNStI1sLzvRHXWFzCEYDrQtxST/wOfJkB1
	4MybNIYSAZaFPdaDXd/G39cAroG2loBR4tI2W6AE2e7mezsS7QsrN4AE9jWfdVUg
	ix1zg7v5A4Zj9+LkSSdfgwXRjngFCbu72+BKmASIaOqYfpyJkoNGFBjRcv0UxE7/
	di5FThC0cuz40ycMmVG8/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757922056; x=
	1758008456; bh=59eiYpGD8uho8aeaQI+TTJPc1va7kDm+pwBNsNnHp4g=; b=e
	6nKJ9MDSJz6fZT6mCvEDb+k714Y45hicwgsbF8CvrMEX+tcwzyOCTDyYno6mL5rv
	dZAOhYytgDsmlXsmFM/6V1YYsOrubfZ7NZWqJdDEfUU9waMYScxQS1O0aKjzXqYn
	LCvvAILtU31zg5ck5VYDOiCkPkRbTBo0yYVzwqZolWx8T+WHBpougBMXCAgtqfeT
	ATgwm0l+YXf32ESFdcP8m/uhkFHE5DDMG4LYXt9RupbRljhlevjJYQ8MG2IslFZm
	Y1BF4L5tvYYCm60V4at1igWuipiu2hZvF3WAa74naR/fYgruUoJSmDcOlbU71W0A
	2npYGA6bQbo/NqLEZrwEQ==
X-ME-Sender: <xms:B8PHaH9tbQsCrChGLgloB1_IAbGTWHh6o-5l9BiHWfHBkE_YAj2TgA>
    <xme:B8PHaDvVAYkskUkwS0SSDrhdO9IVfpfskdPqJT54PYyXn3ASFqpv-dQbG-vskBv2B
    7AC51zUs9mn-Mz6K5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehtihifvghirdgsthifsegrnhhtghhrohhuphdrtghomhdprhgtphhtth
    hopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhr
    tghpthhtohepthhifigvihdrsghivgeslhhinhhugidruggvvhdprhgtphhtthhopehlih
    hnuhigqdhumheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehr
    ihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopegsvghnjhgrmhhinhesshhiphhsoh
    hluhhtihhonhhsrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghssehsihhpshholhhu
    thhiohhnshdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B8PHaCPyj_mzqAbc_5mwxQSMBeUILdui4vNktCYRn6dr0e-fJ6CCZA>
    <xmx:B8PHaMrDv5ukvr64PMqBAQMBcwjTPZbxq3CbNz6BNDTVaKrguUhA-g>
    <xmx:B8PHaFvaOnUChVnwLUrgAv3eVEg_VN6Px7X0Ic6B7pqHbZCFQMy7SA>
    <xmx:B8PHaL2SPlwPyFq7zYl48_iYAe9T_srifWLyCIeHz9sCeiDtEYJOSQ>
    <xmx:CMPHaIfOY6scgdFUoqoin7pzKXtGNfmKJP5pr3kUM5gmcqshBSMSApf2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DC4B700069; Mon, 15 Sep 2025 03:40:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAxI7Qcv7s-k
Date: Mon, 15 Sep 2025 09:40:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tiwei Bie" <tiwei.bie@linux.dev>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 benjamin@sipsolutions.net, "Tiwei Bie" <tiwei.btw@antgroup.com>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <a10395f7-6666-4bdb-9aa0-bdd873029cc9@app.fastmail.com>
In-Reply-To: <20250914155658.1028790-7-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
 <20250914155658.1028790-7-tiwei.bie@linux.dev>
Subject: Re: [PATCH v3 6/7] asm-generic: percpu: Add assembly guard
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Sep 14, 2025, at 17:56, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>
> Currently, asm/percpu.h is directly or indirectly included by
> some assembly files on x86. Some of them (e.g., checksum_32.S)
> are also used on um. But x86 and um provide different versions
> of asm/percpu.h -- um uses asm-generic/percpu.h directly.
>
> When SMP is enabled, asm-generic/percpu.h will introduce C code
> that cannot be assembled. Since asm-generic/percpu.h currently
> is not designed for use in assembly, and these assembly files
> do not actually need asm/percpu.h on um, let's add the assembly
> guard in asm-generic/percpu.h to fix this issue.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>

Have you tried if you can remove the percpu.h dependency from
the files that currently include it? In many cases it should
be enough to use percpu-defs.h.

If that doesn't work, I have no objections to this patch either.

Acked-by: Arnd Bergmann <arnd@arndb.de>

