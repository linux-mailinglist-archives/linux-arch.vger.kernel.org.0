Return-Path: <linux-arch+bounces-13630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F5B580D9
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992703A81D2
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E84225390;
	Mon, 15 Sep 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H1O0tI4x"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F12080C8
	for <linux-arch@vger.kernel.org>; Mon, 15 Sep 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950213; cv=none; b=dw2XIdB7LQbu3+7RTxGAGleGHct79zksvGqEYAs+fs0LnPvAaSKPaMAUb2LC1rwEmVFhHbiEt1GW888F4D19j9/Anao/AvifcuesofQ7TICrp1Shb2SDPhLft+Wz+rDxvj6D1iMn6w1e04qnHfZr/Fy36bJuyVI+JsGbPY6jF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950213; c=relaxed/simple;
	bh=doAE2ILgQuPX9YH7TeVFo0qPLb2S4Z/Onec1bpEZZOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fixAnW+BQjNGd3YUj2bR225x4SBq42Ex+9RcnhE5CXafxn2OoC4Sh/HO8+4Aw+4BWEInlhGEEWxn7efjHNe0/qsA8ZZu6goCKqr3zAs2pGkfWnD/Olm/yon8ZWCmM2ztv4QvVU3TYWw95oKGfejK7GJokbHdDkOMN54MN2VA3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H1O0tI4x; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757950194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6dZCTCv0ekTvnB79bPrbUgTG6ZUXUIE32/eXsGwtiQ=;
	b=H1O0tI4xGB0N/hHGuYWlm1DaRSWuGnkMIm6DnAl5J4mhDHjS+7EWDUaD4DZDSAOMmEF2yi
	ERwuU8Uym25TORvIAdm2tn2Wr5rpUnP5r9oCj9xCj+6E/aYLxIdlooA/h+SGmYvNz8+2sX
	uK9o+HvEXVChBMrXpVRYAVSXcy9WxLo=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: arnd@arndb.de
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin@sipsolutions.net,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v3 6/7] asm-generic: percpu: Add assembly guard
Date: Mon, 15 Sep 2025 23:29:30 +0800
Message-Id: <20250915152930.2654981-1-tiwei.bie@linux.dev>
In-Reply-To: <a10395f7-6666-4bdb-9aa0-bdd873029cc9@app.fastmail.com>
References: <a10395f7-6666-4bdb-9aa0-bdd873029cc9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 15 Sep 2025 09:40:35 +0200, Arnd Bergmann wrote:
> On Sun, Sep 14, 2025, at 17:56, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> >
> > Currently, asm/percpu.h is directly or indirectly included by
> > some assembly files on x86. Some of them (e.g., checksum_32.S)
> > are also used on um. But x86 and um provide different versions
> > of asm/percpu.h -- um uses asm-generic/percpu.h directly.
> >
> > When SMP is enabled, asm-generic/percpu.h will introduce C code
> > that cannot be assembled. Since asm-generic/percpu.h currently
> > is not designed for use in assembly, and these assembly files
> > do not actually need asm/percpu.h on um, let's add the assembly
> > guard in asm-generic/percpu.h to fix this issue.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> Have you tried if you can remove the percpu.h dependency from
> the files that currently include it? In many cases it should
> be enough to use percpu-defs.h.

It doesn't seem to work. The indirect inclusion of asm/percpu.h
comes from asm/nospec-branch.h, which expands DECLARE_PER_CPU()
and thus requires asm/percpu.h.

> 
> If that doesn't work, I have no objections to this patch either.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks! :)

Regards,
Tiwei

