Return-Path: <linux-arch+bounces-2582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D085E03E
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73C21C23771
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DA7FBB2;
	Wed, 21 Feb 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRDAvBZz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80423D393;
	Wed, 21 Feb 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527067; cv=none; b=aAszj4kCp4eYo5yRtxtfhyyJIUb0M0itx5JpMhAZnFODi5nIXZMyM0OQMFp+T7oSLSBz1n5pxV0NnGc/5/62JtR02oU742eAlrNchCXgbOw8V/+voP2In9dWKnQv/E5SwfJg7WZMlgo1lEUgd36tpkDBosWdELH4ZuFQS0zQb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527067; c=relaxed/simple;
	bh=jR116JpyfvNBm06wmEVLlKKRHi5BQ5NesCFPXL2SImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8NMgyJ86LFugkhLrRG3SWmC3mK1FTvsyPbrMAbGn4HSwZcypA83E5ON/WKRMvznHEjIgQ/ywGdSrfHTOjOomc/VYeiqU20bIcwsMZHd+vGOeMpAN85ZRLLAMCTXQ9R6XDb0XGChJBIKrMpniB59Z4vStVSymGjeffK95DOd/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRDAvBZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8107DC433C7;
	Wed, 21 Feb 2024 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708527066;
	bh=jR116JpyfvNBm06wmEVLlKKRHi5BQ5NesCFPXL2SImk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRDAvBZzYYuE5uEfs/DEtOe7zPNcnoZYbwSu75Up2HHOCiaYs3dPtA3OFeS3aPijj
	 cdCJEC4io72wTxOSQfnNvLnLW0c2gv6tih+AGJaN/cIIMfccENvgOGgW+Y4y73EviJ
	 /95XICjCmk7hF5YBUPHW0H5+53rvT5IPFuNh9DzIoo/B/iZuLVvbEAjqaT79MVu+SO
	 zoH5NBPAIyQheTU4QmU6vzAQxSV9MnS1mlP894VbFgkaw3S9I8y+HXI75doohUQtiO
	 LrWh102L8ZI7FGNYQCmOW2aK0zb6kqrnVpxfNYFRZM3L9sb8iFhtUia1zIniN3qzQ2
	 6qH0YCc10mUxQ==
Date: Wed, 21 Feb 2024 14:50:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	agordeev@linux.ibm.com, akpm@linux-foundation.org,
	andreyknvl@gmail.com, andrii@kernel.org, aneesh.kumar@kernel.org,
	aou@eecs.berkeley.edu, ardb@kernel.org, arnd@arndb.de,
	ast@kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org,
	brauner@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, cl@linux.com, daniel@iogearbox.net,
	dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
	dvyukov@google.com, glider@google.com, gor@linux.ibm.com,
	guoren@kernel.org, haoluo@google.com, hca@linux.ibm.com,
	hch@infradead.org, john.fastabend@gmail.com, jolsa@kernel.org,
	kasan-dev@googlegroups.com, kpsingh@kernel.org,
	linux-arch@vger.kernel.org, linux@armlinux.org.uk,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	lstoakes@gmail.com, mark.rutland@arm.com, martin.lau@linux.dev,
	meted@linux.ibm.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mpe@ellerman.id.au, mst@redhat.com, muchun.song@linux.dev,
	naveen.n.rao@linux.ibm.com, npiggin@gmail.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, quic_nprakash@quicinc.com,
	quic_pkondeti@quicinc.com, rick.p.edgecombe@intel.com,
	ryabinin.a.a@gmail.com, ryan.roberts@arm.com,
	samitolvanen@google.com, sdf@google.com, song@kernel.org,
	surenb@google.com, svens@linux.ibm.com, tj@kernel.org,
	urezki@gmail.com, vincenzo.frascino@arm.com, will@kernel.org,
	wuqiang.matt@bytedance.com, yonghong.song@linux.dev,
	zlim.lnx@gmail.com, awheeler@motorola.com
Subject: Re: [PATCH 0/4] arm64: mm: support dynamic vmalloc/pmd configuration
Message-ID: <20240221-ipod-uneaten-4da8b229f4a4@spud>
References: <20240220203256.31153-1-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r+os/L6iBAa0yd7x"
Content-Disposition: inline
In-Reply-To: <20240220203256.31153-1-mbland@motorola.com>


--r+os/L6iBAa0yd7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Maxwell,

FYI:

>   mm/vmalloc: allow arch-specific vmalloc_node overrides
>   mm: pgalloc: support address-conditional pmd allocation

With these two arch/riscv/configs/* are broken with calls to undeclared
functions.

>   arm64: separate code and data virtual memory allocation
>   arm64: dynamic enforcement of pmd-level PXNTable

And with these two the 32-bit and nommu builds are broken.

Cheers,
Conor.

--r+os/L6iBAa0yd7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdYNywAKCRB4tDGHoIJi
0gMuAP9F/qaVnaevMHMAFC79aMoA7T8MPtngzCYgeGKGkodjfwD+LfeSF0KgFWRs
XPWMo+0cR11PZYg4ErTvrYapXzyvsgY=
=uABL
-----END PGP SIGNATURE-----

--r+os/L6iBAa0yd7x--

