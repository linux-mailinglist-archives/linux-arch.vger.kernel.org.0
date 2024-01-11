Return-Path: <linux-arch+bounces-1342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5E82AACB
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 10:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929B31C269B1
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D11094E;
	Thu, 11 Jan 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kJTPamY8"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965714F7E;
	Thu, 11 Jan 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qb7VEPoWO8ajGU/TxkKVc2YmRBYx8R6ZQDgTNtF9mho=;
	t=1704964934; x=1706174534; b=kJTPamY8DNarEBm2RWGesZ5jW4iP9wf44X+LNS+tn8nPvrp
	I3oP3EuDaGCsTfjz8a2+IXmfM4ga/ZxEa797xj11jtcBVR5FSHSmb5n7odZ6FxrpXbw6lXf8cOxFm
	PtoR86e93QBGjcfZWqsT6/B8zYDQhU0SX+g/xfm24ZBGPd8LXCzpXVrfbQTTSBH+xX5+XFlxLdRTg
	EPfvlo7VtLPdEIMfEiy1niek4Ezo/q26AnfCS9qcF8EkgM3bV/Gn5hxxO6Cj9rDLiS8mJnk54fQ9+
	0+0o1QhEBoCrnbrhvJmDF3cIGKWxb2BogEyPFvl4b4WppqP3GjfmYU7FcddM23Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rNrGD-0000000EybY-2U0Q;
	Thu, 11 Jan 2024 10:22:01 +0100
Message-ID: <2cedb42a9eca23c37f03938cbccbd8489d0130d7.camel@sipsolutions.net>
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
Date: Thu, 11 Jan 2024 10:22:00 +0100
In-Reply-To: <42cf5ca70c940b3e68c8ad0e4bab6f14f87d4486.camel@redhat.com>
References: <20240111085540.7740-1-pstanner@redhat.com>
	 <43478eb70cf5f1120316739803c7622ab5f9e16a.camel@sipsolutions.net>
	 <42cf5ca70c940b3e68c8ad0e4bab6f14f87d4486.camel@redhat.com>
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

On Thu, 2024-01-11 at 10:14 +0100, Philipp Stanner wrote:
> On Thu, 2024-01-11 at 10:03 +0100, Johannes Berg wrote:
> > On Thu, 2024-01-11 at 09:55 +0100, Philipp Stanner wrote:
> > > Second Resend. Would be cool if someone could tell me what I'll
> > > have to
> > > do so we can get this merged.
> >=20
> > I don't even know who'd merge it, but um doesn't seem appropriate...
>=20
> UM isn't a recipent, I'd guess it's some mail filter which might make
> it appear that way :)

Oh. I guess I thought I was CC'ed as UM maintainer :)

> The lists I sent this to are
> linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
> linux-arch@vger.kernel.org, stable@vger.kernel.org
>=20
> Anyways, PCI is for sure who should merge this, since it's 100% about
> PCI.

Sounds good :)

johannes

