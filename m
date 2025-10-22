Return-Path: <linux-arch+bounces-14275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33692BFE54E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5344EB99D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B41D301027;
	Wed, 22 Oct 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNWwA7uT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59302F8BF4;
	Wed, 22 Oct 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169176; cv=none; b=Nd6mzo3pvc+3m8uP25P46Bb9eO2YRwbGGn4OTJjhwfXa46/9BoBw9co3DODRWGUVMVW8NqN7O6Z1kK2G7rbnnrF/K+tM3C3PA40ZYHYhhGvELPrnxBgV1N6Gne++Qr//hEQGN1uC5sWbziqXUk/ksDB7cPZ3+CJ2qT9SGn3Cx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169176; c=relaxed/simple;
	bh=fMnDUsh++hTRlW5dn4gfNo7HgWB7+StricBM3MTmevE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPKWhbc7ToUAMDwOjbTGEdl/xRVVCwr94fnLlPVXh+NdBxL8uUVRWat3DdNW8ZTVOGuUJuS5aaVGOxfCgm85CIkCO2lWPvG8XtOzfsNdYEyrviR8XLgBVWBLE6zn1w5oCqRxXCyYBc5QfAxWyanYZnh5duV5VG9Zwi/Nu2oylUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNWwA7uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0F7C4CEE7;
	Wed, 22 Oct 2025 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761169175;
	bh=fMnDUsh++hTRlW5dn4gfNo7HgWB7+StricBM3MTmevE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNWwA7uT41H1QeC3nDJKzxGOAYopyZyz8wtaReHnMFNDClB7pEowhjPcwr/h555lQ
	 jVxtk2LwgDfOBrV2C1kpcI5K4L/QQTXZdNgUl0O4FXSwDIIJZ6hxJeud2yNdpiq/+M
	 8EJBosY1IHyBF2qbURoZ+X8CZjQ1U95UUYYKemkTqV1JzCIfJyset7oaAlrfKF4mF4
	 WbVDphXvbnCpZ3IipJhwoV0ZsefssffeUcgsW59U02F+Q8u5G2n+rXOzbnD6+eMX57
	 jtCI+BMlMh63VWOMWxICaIOtULATYu3+pTOojxsVyRsl+O/sHbxAPjROCsiuLpTAhk
	 +aIwx9oysP7iA==
Date: Wed, 22 Oct 2025 22:39:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, james.morse@arm.com,
	Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 6/6] cache: Support cache maintenance for HiSilicon
 SoC Hydra Home Agent
Message-ID: <20251022-kite-revert-2c2684054d05@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
 <20251022113349.1711388-7-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hs5fF3jxcDKPxATt"
Content-Disposition: inline
In-Reply-To: <20251022113349.1711388-7-Jonathan.Cameron@huawei.com>


--Hs5fF3jxcDKPxATt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:33:49PM +0100, Jonathan Cameron wrote:

> +static int hisi_soc_hha_wbinv(struct cache_coherency_ops_inst *cci,
> +			struct cc_inval_params *invp)
> +{
> +	struct hisi_soc_hha *soc_hha =3D
> +		container_of(cci, struct hisi_soc_hha, cci);
> +	phys_addr_t top, addr =3D invp->addr;
> +	size_t size =3D invp->size;
> +	u32 reg;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	addr =3D ALIGN_DOWN(addr, HISI_HHA_MAINT_ALIGN);
> +	top =3D ALIGN(addr + size, HISI_HHA_MAINT_ALIGN);
> +	size =3D top - addr;
> +
> +	guard(mutex)(&soc_hha->lock);
> +
> +	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
> +		return -EBUSY;
> +
> +	/*
> +	 * Hardware will search for addresses ranging [addr, addr + size - 1],
> +	 * last byte included, and perform maintain in 128 byte granule
> +	 * on those cachelines which contain the addresses.
> +	 */

Hmm, does this mean that the IP has some built-in handling for there
being more than one "agent" in a system? IOW, if the address is not in
its range, then the search will just fail into a NOP?
If that's not the case, is this particular "agent" by design not suitable
for a system like that? Or will a dual hydra home agent system come with
a new ACPI ID that we can use to deal with that kind of situation?
(Although I don't know enough about ACPI to know where you'd even get
the information about what instance handles what range from...)

> +	size -=3D 1;
> +
> +	writel(lower_32_bits(addr), soc_hha->base + HISI_HHA_START_L);
> +	writel(upper_32_bits(addr), soc_hha->base + HISI_HHA_START_H);
> +	writel(lower_32_bits(size), soc_hha->base + HISI_HHA_LEN_L);
> +	writel(upper_32_bits(size), soc_hha->base + HISI_HHA_LEN_H);
> +
> +	reg =3D FIELD_PREP(HISI_HHA_CTRL_TYPE, 1); /* Clean Invalid */
> +	reg |=3D HISI_HHA_CTRL_RANGE | HISI_HHA_CTRL_EN;
> +	writel(reg, soc_hha->base + HISI_HHA_CTRL);
> +
> +	return 0;
> +}
> +
> +static int hisi_soc_hha_done(struct cache_coherency_ops_inst *cci)
> +{
> +	struct hisi_soc_hha *soc_hha =3D
> +		container_of(cci, struct hisi_soc_hha, cci);
> +
> +	guard(mutex)(&soc_hha->lock);
> +	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static const struct cache_coherency_ops hha_ops =3D {
> +	.wbinv =3D hisi_soc_hha_wbinv,
> +	.done =3D hisi_soc_hha_done,
> +};
> +
> +static int hisi_soc_hha_probe(struct platform_device *pdev)
> +{
> +	struct hisi_soc_hha *soc_hha;
> +	struct resource *mem;
> +	int ret;
> +
> +	soc_hha =3D cache_coherency_ops_instance_alloc(&hha_ops,
> +						     struct hisi_soc_hha, cci);
> +	if (!soc_hha)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, soc_hha);
> +
> +	mutex_init(&soc_hha->lock);
> +
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		ret =3D -ENOMEM;
> +		goto err_free_cci;
> +	}
> +
> +	/*
> +	 * HHA cache driver share the same register region with HHA uncore PMU
> +	 * driver in hardware's perspective, none of them should reserve the
> +	 * resource to itself only.  Here exclusive access verification is
> +	 * avoided by calling devm_ioremap instead of devm_ioremap_resource to

The comment here doesn't exactly match the code, dunno if you went away
=66rom devm some reason and just forgot to to make the change or the other
way around? Not a big deal obviously, but maybe you forgot to do
something you intended doing. It's mentioned in the commit message too.

Other than the question I have about the multi-"agent" stuff, this
looks fine to me. I assume it's been thought about and is fine for w/e
reason, but I'd like to know what that is.

Cheers,
Conor.

> +	 * allow both drivers to exist at the same time.
> +	 */
> +	soc_hha->base =3D ioremap(mem->start, resource_size(mem));
> +	if (!soc_hha->base) {
> +		ret =3D dev_err_probe(&pdev->dev, -ENOMEM,
> +				    "failed to remap io memory");
> +		goto err_free_cci;
> +	}
> +
> +	ret =3D cache_coherency_ops_instance_register(&soc_hha->cci);
> +	if (ret)
> +		goto err_iounmap;
> +
> +	return 0;
> +
> +err_iounmap:
> +	iounmap(soc_hha->base);
> +err_free_cci:
> +	cache_coherency_ops_instance_put(&soc_hha->cci);
> +	return ret;
> +}
> +
> +static void hisi_soc_hha_remove(struct platform_device *pdev)
> +{
> +	struct hisi_soc_hha *soc_hha =3D platform_get_drvdata(pdev);
> +
> +	cache_coherency_ops_instance_unregister(&soc_hha->cci);
> +	iounmap(soc_hha->base);
> +	cache_coherency_ops_instance_put(&soc_hha->cci);
> +}

--Hs5fF3jxcDKPxATt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPlPEAAKCRB4tDGHoIJi
0n5pAQCCL4y7CHzVqNXyyDfhRrqw9BjDlYs8MpqKde1NNQMUgwEAqS1sE14/IdwM
Du1yl5LVFN+kra14elaLoO7/NifKDQg=
=PAly
-----END PGP SIGNATURE-----

--Hs5fF3jxcDKPxATt--

