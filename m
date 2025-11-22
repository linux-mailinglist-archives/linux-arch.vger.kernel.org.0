Return-Path: <linux-arch+bounces-15054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A928CC7CF87
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54D37354F4F
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 12:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFAA2DA75B;
	Sat, 22 Nov 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="GA6Lnbxw"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0176277CBF;
	Sat, 22 Nov 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763814295; cv=none; b=RQYE1019KzDj/X+yKZKyWOcZgnoUMyxfH//oi5lMx1svcr2vDAiPrK5aBegy8Vx1IO7lbJT3s1rPITRUqPEtNHeit/0v31qUeH7ZoCLBHe6WfQ4V1FueBE0AvcGmD2DwsE38ADY65yxIpRLJwCUQ2ONl3IzIK8yMhc8Y9Fr+N74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763814295; c=relaxed/simple;
	bh=SLclUAtH7ageWRrtaU7kW+a95Ka7RjgLaXjSEpWa/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRVSDHbYKB4nqhUwhm6QC3HZhipcZkfUO5o/MNzDksY7w/CDTIZozM7bDuuT01pUEGfsqA8BmUz6/ui0j0Np8oahEBZk0LfR2G7TUk0apzHmdoWFkiHDkgm/fJHSj7tc0ap57ECEwCjsRu3TTlJ0KyKPMtaGiuWUCEZZJKflxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=GA6Lnbxw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1763814291; bh=SLclUAtH7ageWRrtaU7kW+a95Ka7RjgLaXjSEpWa/K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GA6LnbxwHYHrTqVgvL2SqLFSJTJBw6si5k9FykadC9O1xk121SCLnCksHfIlJu+Gc
	 AMTPGesv6fIjg7gMa4eo4HG8+C5YJyRbWf6JKnfals/7S4N5Jg37gQFKYBaaE6xWJU
	 1Xj4BBt9wx2kH4yVaZMyo9g02R5Pcs4mQQ/CKS5Y=
Date: Sat, 22 Nov 2025 13:24:50 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, 
	loongarch@lists.linux.dev, linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 13/14] LoongArch: Adjust default config files for
 32BIT/64BIT
Message-ID: <2f9f3c8f-d444-42b9-9c2f-66c8676e9565@t-8ch.de>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
 <20251122043634.3447854-14-chenhuacai@loongson.cn>
 <0b2bf90e-f148-46ad-92e4-b177d412fd11@t-8ch.de>
 <CAAhV-H4Vemxni8PrMCeubUwWcOFAV-j6AFJg4oPdxs-VNBiUGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4Vemxni8PrMCeubUwWcOFAV-j6AFJg4oPdxs-VNBiUGw@mail.gmail.com>

On 2025-11-22 19:58:24+0800, Huacai Chen wrote:
> On Sat, Nov 22, 2025 at 5:45 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2025-11-22 12:36:33+0800, Huacai Chen wrote:
> > > Add loongson32_defconfig (for 32BIT) and rename loongson3_defconfig to
> > > loongson64_defconfig (for 64BIT).
> > >
> > > Also adjust graphics drivers, such as FB_EFI is replaced with EFIDRM.
> > >
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/Makefile                       |    7 +-
> > >  arch/loongarch/configs/loongson32_defconfig   | 1104 +++++++++++++++++
> > >  ...ongson3_defconfig => loongson64_defconfig} |    6 +-
> > >  3 files changed, 1113 insertions(+), 4 deletions(-)
> > >  create mode 100644 arch/loongarch/configs/loongson32_defconfig
> > >  rename arch/loongarch/configs/{loongson3_defconfig => loongson64_defconfig} (99%)
> > >
> > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > index 96ca1a688984..cf9373786969 100644
> > > --- a/arch/loongarch/Makefile
> > > +++ b/arch/loongarch/Makefile
> > > @@ -5,7 +5,12 @@
> > >
> > >  boot := arch/loongarch/boot
> > >
> > > -KBUILD_DEFCONFIG := loongson3_defconfig
> > > +ifdef CONFIG_32BIT
> >
> > Testing for CONFIG options here doesn't make sense, as the config is not yet
> > created. Either test for $(ARCH) or uname or just use one unconditionally.
> > Also as mentioned before, snippets can reduce the duplication.
> Thank you for your clarification. But $(ARCH) also doesn't make sense
> because it is always "loongarch".
> 
> 'uname' is an option but I think it doesn't work for cross compile?

The default is not meant to work for cross compilations. ARCH/SUBARCH
can take `uname` into account. See Makefile and scripts/subarch.include.
But as Arnd mentioned, it most probably does not make any sense to cater
to native LoongArch32 builds. Just use the 64-bit variant unconditionally.
It is easy enough to override.


Thomas

