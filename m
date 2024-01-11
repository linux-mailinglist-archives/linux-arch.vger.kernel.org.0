Return-Path: <linux-arch+bounces-1340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFED82AA6A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 10:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A296A284739
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB610788;
	Thu, 11 Jan 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jzhSvAFt"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00710A03;
	Thu, 11 Jan 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WnWZQJddNOYwO4jIGWVJBNe/stvkO8djrsCMVObC998=;
	t=1704963815; x=1706173415; b=jzhSvAFtd7FbMWhuaS3fCEDPhOzGkVGqbBxGCCMowWyt5gn
	Vol40lHSaac2geRPlXcxPF4knMO2Epg2GOJNkAA52CQfq/gC2L/N9CZna0oCQ34nel7G7HieZMGax
	LyPMNLhfqhRfbEgtelwPMs4YB1QYNvzM/3kBOoLrfsxEQUJQUq3dd+wolhKujfFcTnaq5C749UcX4
	OsUAeeXT38bVNmjAwDnel8fXZCj4s6kfN8HEZjdSaMZd2ZLqTVRPxoOnSHdtFBEyh5X6MVaEdLRy6
	g6mkp6iqvEPYWW+QDJ/q3jS+9V/NHGIHwtMadsag2REH3ijjLQTzWcQ9qo1obfbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rNqxt-0000000Exm9-1jk6;
	Thu, 11 Jan 2024 10:03:05 +0100
Message-ID: <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
Subject: Re: [PATCH v5 RESEND 0/5] Regather scattered PCI-Code
From: Johannes Berg <johannes@sipsolutions.net>
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Arnd Bergmann <arnd@arndb.de>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 11 Jan 2024 10:03:03 +0100
In-Reply-To: <20240111085540.7740-1-pstanner@redhat.com>
References: <20240111085540.7740-1-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-11 at 09:55 +0100, Philipp Stanner wrote:
> Second Resend. Would be cool if someone could tell me what I'll have to
> do so we can get this merged.

I don't even know who'd merge it, but um doesn't seem appropriate...
>=20
> @Stable-Kernel:
> You receive this patch series because its first patch fixes leaks in
> PCI.

Too early for that, stable just ignores stuff before it hits mainline.

johannes

