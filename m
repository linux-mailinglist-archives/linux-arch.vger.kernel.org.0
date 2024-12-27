Return-Path: <linux-arch+bounces-9519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F109FD5ED
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621E81885CA3
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD841F76AE;
	Fri, 27 Dec 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OnIfwTpi"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC41885AD;
	Fri, 27 Dec 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735316548; cv=none; b=n0F81wFwI+NYaoNFkQjTntvGGYXvBBAHU+BsMmr80RuNni7Jt7+Iz9xV3q77MQELnfysTTgs7BkCrvWpKC4og+WMNO1iP4t1C2p9/KC9u3K0x4gG8zDWAgImZcvwkDDDc/A119LaiHKvS8qB4vKRMHXVaQYLcJRjb1ls5OhL0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735316548; c=relaxed/simple;
	bh=JC6Z/K/2O/bt7StL+SOpfvQdDfRs46BTtm14neBh5HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Luv2Ks3bZcW292qGbNLGa4sryG5/FRLyC3+EfbGBinQUnrhUmNWHjcP531TD8i0FeZOSl3fhrfjDb9m+n7n+qKclspTxiJtX/Cb4jsmwSDaTG/OtPlpBYvcNRDAptNB7KOVU0xcQ/MhMYefKGotpfQ9YSO4YhZNV/vE4mixAr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OnIfwTpi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JC6Z/K/2O/bt7StL+SOpfvQdDfRs46BTtm14neBh5HU=; b=OnIfwTpijmYQ9N7UaFF+2R1MS8
	EI/8P8IwGO14KPY/8ADLokKcZ9tjbsn1IQ0/AMWVDWOI38a5tA+6PHfYJO3gszjjxxoc2qSRo/lld
	cugLEPOI4QvuYSzEcdk7BKDXlp9DD+qeAFUg42gcRX617zk0c4AWH65aMDD/bJn3iroSKm4tQTcwV
	rV2/OBk3JO2xpz7o5mfr+hOPl/E4itN1Ge60NxjUSqErVbDCE7tzSsvzJ8AnwCXv+RrFqsfeu06D8
	ajCSkbo/fv39JzPWmnOdkaWULwI5KBEqfE5OCJH7CT58ANSYrLPmXkRm6X3/+1qFEVDKouoHKv+8q
	/R4oKISg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRD6U-0000000CtK5-122A;
	Fri, 27 Dec 2024 16:22:22 +0000
Date: Fri, 27 Dec 2024 16:22:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] sh: exports for delay.h
Message-ID: <20241227162222.GX1977892@ZenIV>
References: <20241222222259.GF1977892@ZenIV>
 <CAMuHMdVpTtcT9LVGNvFLm4cvrNF=fe1dVsi2zo73Yee3oYrJYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVpTtcT9LVGNvFLm4cvrNF=fe1dVsi2zo73Yee3oYrJYQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 27, 2024 at 04:58:58PM +0100, Geert Uytterhoeven wrote:

> Please do not export __delay, as it is an internal implementation detail.
> Drivers should not call __delay() directly, as it has non-standardized
> semantics, or may not even exist.

As the matter of fact, it *does* exist and is either exported or a static
inline with everything used by it exported - on every architecture except sh.

