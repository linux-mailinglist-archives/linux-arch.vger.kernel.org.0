Return-Path: <linux-arch+bounces-7376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B168497EFA2
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B890B20B07
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166E1991D9;
	Mon, 23 Sep 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qUUNPVBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChdCSZLl"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2413D625;
	Mon, 23 Sep 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110488; cv=none; b=msOzBHD8TG0+ahbNAjMc8h7V4eKTPySSPEaN+mUcnR+Szg8MITi2S8/x3jd5ns9fZSC0TFTKKYXBa5c0sS+6RGNMIIFx/CAJL5dUhEGvrLLk3nwuMUF1oPrYLN2a+3diFro4BuES/0YUVxGSviNPnzevYROovBe0Bz0ha2dagj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110488; c=relaxed/simple;
	bh=y/i2B1l4hOzXHp53pn4yoonYuXALZbLQj1+kIUT+vqc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E/pxnkgVMpVDaYeZ2mrKPAntflrd6/FC2/2/CkoJo7AWHF9gac5gO4zD6sZh30RAi+4ucQJ2y7+AzSvHywwxItj+nXFTfdONXZjw7/0d+N2BIo4SnlXT2g1bvy5bFl7belMiWkM0WsYuWpd0DAcKeXEx7/DQB1X4xEVH7fX0iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qUUNPVBI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChdCSZLl; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CFFC71380245;
	Mon, 23 Sep 2024 12:54:44 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 23 Sep 2024 12:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727110484;
	 x=1727196884; bh=kR6thF4mL5TK/tahzSYtD/0ZIm7FZeNAgdWnaPLLR6o=; b=
	qUUNPVBI9mFPBCOSguUktHvjsdT8BY7n0jAdIZ0kOHkkPQEeyWzbHrR6BqDbGwOb
	dy9cuUrnVFMr1OqueC5F2NWuvjMfX6ifm/M6rrUQIZcCvxDCFraGQKTUu+Xgtt7E
	vbPxt0i9oYBGANmO48vMGlLFurn2BL8dBS7a7Mo2Dpn7arMRdfNkQDS+v0vS515P
	Sl1Ofajg0dPZQaup9tc8u1FESR6yaCruxX84Oi394F9vqN6h8LYoJ+VT20s88OY6
	LAZHrgUmu8BTSgBE0MFv8Gpoyt3FBtvyA7PmhVzWuIecetV9Q17oCj0VYUNU2dwP
	TWbDLmy6Wwx75Zbzxi19cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727110484; x=
	1727196884; bh=kR6thF4mL5TK/tahzSYtD/0ZIm7FZeNAgdWnaPLLR6o=; b=C
	hdCSZLl2aZhq7L29NuYRMd+ymOY1Gh9MtMw4atgeDTAMi6/Ggu+KQIPl7sncv7Na
	30JjwJWsLlfl4MELF+2JFVOQapzcWGp11VpYpXBIDdJahtYbPmf8pSVIsdxT8Put
	YmqrxKF220y3X8ddvuLAo0s98/UhXLVm6BS3/TQP/otW+IL1WIu+yRordXNWdQ3O
	7ZA13Z/U7z3PW6DWKuoVM1rLPtoQ+SJbYokPrsmbRzdtBcXiVLjAVJQGkIDhb36+
	0FfMI5x+PNuklgmKAHbu/NaFiLaNvJwReXSMp/J9dNRL94QJL918+OcSx/UcW6oC
	e/4xsiZVFnns8FiMEFlaA==
X-ME-Sender: <xms:U53xZm3PpXgvnZ1vkH7RzXIu0gA0SusAfFmY7Ct2ZoMjEBjEoQxdKw>
    <xme:U53xZpFbZ125MCGq54XOIaeKDp_xiYBFtQHP0qSB9mswwQVKasWmHW5eteA1oC5PN
    wYCL2IcvszR2msg_fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgt
    phhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtg
    hpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
    pdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepnh
    hpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohho
    ughmihhsrdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U53xZu6aUsDlOm8aNIJMFYlxJXdWgF8Aq6TjPn5Sj0NJWamRNQ2DWg>
    <xmx:U53xZn03qZbMJOu5yZ9-zeHMd4G7i4-IRxlfG4Kb6pVEaNXkbDRFTA>
    <xmx:U53xZpGyZvdVPTzKv5F1VbgFiEroYN_sfEFx02DI9hsuIPho53Atdw>
    <xmx:U53xZg_qunc9ygzi29TV6Nb1jioAsajLN-CI8Y1wkO_7NHFyypRmEQ>
    <xmx:VJ3xZtISnmFwYEIk0OFl3w6tqGyDH_QgnIl6xRkOweoKS0NW7nmG1S5C>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2F95A2220071; Mon, 23 Sep 2024 12:54:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 16:54:22 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Naveen N Rao" <naveen@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <f8256ade-c17f-46d1-bd4a-4d01235be5a0@app.fastmail.com>
In-Reply-To: <20240923141943.133551-5-vincenzo.frascino@arm.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-5-vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 4/8] vdso: Introduce vdso/page.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 23, 2024, at 14:19, Vincenzo Frascino wrote:
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
>
> Introduce vdso/page.h to make sure that the generic library
> uses only the allowed namespace.
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks for the new version. This looks all good, just some
very minor ideas for how to possibly improve the new version:

> +/* PAGE_SHIFT determines the page size */
> +#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> +
> +#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
> +
> +#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_X86_64)
> +#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
> +#else
> +#define PAGE_MASK	(~(PAGE_SIZE-1))
> +#endif

I would open-code the CONFIG_PAGE_SHIFT in PAGE_SIZE
and PAGE_MASK, just to avoid the extra indirection in the
preprocessor. This mainly has the benefit of slightly
shorter compiler warnings when all the macros get
traced back but can also slightly improve compile speed
in case this is used in deeply nested macros.

Without a comment, the special case for CONFIG_X86_64
not very clear, and probably not needed. If you are
worried about introducing an architecture specific
regression, I would suggest instead explaining the
possible issue in the patch description but using the
more generic and simpler #ifdef check.

      Arnd

