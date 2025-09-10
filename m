Return-Path: <linux-arch+bounces-13474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC8AB51691
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B82B1C27E85
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59602857CB;
	Wed, 10 Sep 2025 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RV0la6SD"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760227AC21;
	Wed, 10 Sep 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506346; cv=none; b=DCVu4gjASMxyFbYuVnuVMyiPokj8szVCtEd610FPNNiHiCd63Qqqvgd73yLpGyR+ed15b3RT1bog1kfuFJ8oCdwp5HvGRcewTlW30wUCaSmmHLjVI/4y4484FkbgF9Qz7jhcL1LVlptlQOvYqhuCTUnTxT9X9wCCjHTIbmBfwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506346; c=relaxed/simple;
	bh=gEhz83X1fEdIoqgS02uWNCmDVXrCuar+j0FyE53NpqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9/jWbc3VdwsRrFziermcqp5gc3iDh2EfGCnAM9Rl7vMX5P2wx98tEYbFeqHxasSTH3+8v8ULHUcoagijIGfMUvDqia+c7WEZf9Pss5gcT1R0RbOqm8uDj/XKDLZYEFV4wlX7V8CWE9iVjBaSnEzReggdgW0UcHJpVkTNVJpGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RV0la6SD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gEhz83X1fEdIoqgS02uWNCmDVXrCuar+j0FyE53NpqA=;
	t=1757506345; x=1758715945; b=RV0la6SD1osoSOAJzKyVZ8s2SAbmm+AHm3g3JuP8xu8HsZo
	lmLiw3fvD/a77UX1mDx99sZkQ29MuOkuWCYc2AvCAbqsF42rTlmRa8X15oNz5ZF0JkgZN5vPaXRge
	4Uxd1vp5tiFikbD0UOTHyV10IODI3r0rBRnQYqbcU7siMsumVoFVkyafmvw6oWAjOJvwFgLozG0Fr
	4FLti/SlY6+f5dyAIDySCs15mfM+1NkzQYiQkn6VALkmIwX6cTwKL6DrELg236HWUpULDVcve3v0g
	kODNT83AcDcarh7kXE2vmfa4lthQhxAfrCiJtwGTfL76cq63PPbVSbKWnHnlLCkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJgP-0000000CoT2-1aUq;
	Wed, 10 Sep 2025 14:12:17 +0200
Message-ID: <ecb230a3384e22acf4fa6c03466c7db7092ad9f5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 09/10] asm-generic: percpu: Add assembly guard
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com, 
	linux-arch@vger.kernel.org
Date: Wed, 10 Sep 2025 14:12:16 +0200
In-Reply-To: <20250810055136.897712-10-tiwei.bie@linux.dev> (sfid-20250810_075308_080221_8093A5E9)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-10-tiwei.bie@linux.dev>
	 (sfid-20250810_075308_080221_8093A5E9)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> Currently, asm/percpu.h is directly or indirectly included by
> some assembly files on x86. Some of them (e.g., checksum_32.S)
> are also used on um. But x86 and um provide different versions
> of asm/percpu.h -- um uses asm-generic/percpu.h directly.
>=20
> When SMP is enabled, asm-generic/percpu.h will introduce C code
> that cannot be assembled. Since asm-generic/percpu.h currently
> is not designed for use in assembly, and these assembly files
> do not actually need asm/percpu.h on um, let's add the assembly
> guard in asm-generic/percpu.h to fix this issue.
>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org

Can we get an ACK from someone for this? :) Or a reject and we need to
find other ways of doing things?

johannes

