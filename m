Return-Path: <linux-arch+bounces-14342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F32C02CF7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9063AE6A1
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850B34AB11;
	Thu, 23 Oct 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDTdakLd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496F3446A3;
	Thu, 23 Oct 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242327; cv=none; b=ZH3B51zppXyP+j3rHB96y5BbIBrdrfE2XzAwYaDiDwKB0d+mJ2ez3iwnQeyZk2nR4DHTToaAkydOqG/MAABJo/E1hRr5x/hXgTmHYaOhrNHQ9ZFMIHlDzylOzQPu615NRB630+p5tWgUWZD651KrfOj4GweAt8fvuuWR5rpkfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242327; c=relaxed/simple;
	bh=5hAOPFF31Br87tc4UVkXvHPCgDvT6CIduQTFGMHxSPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIvQMUzVqQ2k0t37eECmIMnn8+LkWrWkFEu39lEs763N3qX+wO6CA9UFazu0sxxpzJJRNAeceE1o14518EaETDzbrcTOP186Nxf92rHkoINhZ65zydVu8c72LJx+tUv49bg55JoAGQpdsbSupqRhwPYy73w+zW45gHrHmeH0srY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDTdakLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA94C4CEE7;
	Thu, 23 Oct 2025 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761242326;
	bh=5hAOPFF31Br87tc4UVkXvHPCgDvT6CIduQTFGMHxSPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDTdakLd6r4OY/6r0TYwuTZhmdhNg2OhLQDP2C3uQ3XUgwySj+IJi+7+CmAL5hQ6w
	 y6iUK4JWwKvEI2UdtHgJS0luBhA6IuKpfjvOWBV/FuZkVajJupWdcYmMuw5As5SXG4
	 Br7la0e/j6E4l0QNp+6JsNe0yQj+pkGqBdGQwV1EqWmr40nMP/gRxeAGk7RaajnoOF
	 PweXScgF8r5sbFjuDud1HRNrPLLDYY5oHcORI5tcULj793gfN9R9ApMEijRBQLkhHy
	 2q9jr+HBXGRsm7/oSBXylk+xwb2ytkiIsneSJymDHwSgstU9gGPFylwtMl0Pq+oYtL
	 qpEn5iNE7k9sA==
Date: Thu, 23 Oct 2025 18:58:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
Message-ID: <20251023-deacon-freedom-91064dec93de@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
 <20251022113349.1711388-7-Jonathan.Cameron@huawei.com>
 <20251022-kite-revert-2c2684054d05@spud>
 <20251023124914.00001005@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wGeFqUtAjCRVjVMX"
Content-Disposition: inline
In-Reply-To: <20251023124914.00001005@huawei.com>


--wGeFqUtAjCRVjVMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:49:14PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Oct 2025 22:39:28 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> Hi Conor,
>=20
> > On Wed, Oct 22, 2025 at 12:33:49PM +0100, Jonathan Cameron wrote:
> >=20
> > > +static int hisi_soc_hha_wbinv(struct cache_coherency_ops_inst *cci,
> > > +			struct cc_inval_params *invp)
> > > +{
> > > +	struct hisi_soc_hha *soc_hha =3D
> > > +		container_of(cci, struct hisi_soc_hha, cci);
> > > +	phys_addr_t top, addr =3D invp->addr;
> > > +	size_t size =3D invp->size;
> > > +	u32 reg;
> > > +
> > > +	if (!size)
> > > +		return -EINVAL;
> > > +
> > > +	addr =3D ALIGN_DOWN(addr, HISI_HHA_MAINT_ALIGN);
> > > +	top =3D ALIGN(addr + size, HISI_HHA_MAINT_ALIGN);
> > > +	size =3D top - addr;
> > > +
> > > +	guard(mutex)(&soc_hha->lock);
> > > +
> > > +	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
> > > +		return -EBUSY;
> > > +
> > > +	/*
> > > +	 * Hardware will search for addresses ranging [addr, addr + size - =
1],
> > > +	 * last byte included, and perform maintain in 128 byte granule
> > > +	 * on those cachelines which contain the addresses.
> > > +	 */ =20
> >=20
> > Hmm, does this mean that the IP has some built-in handling for there
> > being more than one "agent" in a system? IOW, if the address is not in
> > its range, then the search will just fail into a NOP?
>=20
> Exactly that. NOP if nothing to do. The hardware is only tracking
> a subset of what it might contain (depending on which cachelines are
> actually in caches) so it's very much a 'clear this if you happen to
> have it' command.  Even if it is in the subset of PA being covered by
> an instance, many cases will be a 'miss' and hence a NOP.

Okay, cool. I kinda figured this was the mostly outcome, when yous put
"search" into the comment.

> > If that's not the case, is this particular "agent" by design not suitab=
le
> > for a system like that? Or will a dual hydra home agent system come with
> > a new ACPI ID that we can use to deal with that kind of situation?
>=20
> Existing systems have multiple instances of this hardware block.
>=20
> Simplifying things over reality just to make this explanation less
> messy.  (ignoring other levels of interleaving beyond the Point of
> Coherency etc).
>=20
> In servers the DRAM access are pretty much always interleaved=20
> (usually at cache line granularity). That interleaving may go very
> different physical locations on a die or across multiple dies.
>=20
> Similarly the agent responsible for tracking the coherency state
> (easy to think of this as a complete directory but it's never that
> simple) is distributed so that it is on the path to the DRAM. Hence
> if we have N way interleave there maybe N separate agents responsible for
> different parts of the range 0..(64*N-1) (taking smallest possible
> flush that would have to go to all those agents).

Well, thanks for the explanation.. I was only looking to know if there
were multiple, since it wasn't clear, but the reason why you do is
welcome.

> > (Although I don't know enough about ACPI to know where you'd even get
> > the information about what instance handles what range from...)
>=20
> We don't today. It would be easy to encode that information
> as a resource and it may make sense for larger systems depending
> on exactly how the coherency fabric in a system works. I'd definitely
> expect to see some drivers doing this. Those drivers could then prefilter.

Okay cool. I can clearly see how it'd be done in DT land, if required,
but didn't know if it was possible on ACPI systems.

>=20
> Interleaving gets really complex so any description is likely to only
> provide a conservative superset of what is actually handled by a given
> agent.
>=20
> >=20
> > > +	size -=3D 1;
> > > +
> > > +	writel(lower_32_bits(addr), soc_hha->base + HISI_HHA_START_L);
> > > +	writel(upper_32_bits(addr), soc_hha->base + HISI_HHA_START_H);
> > > +	writel(lower_32_bits(size), soc_hha->base + HISI_HHA_LEN_L);
> > > +	writel(upper_32_bits(size), soc_hha->base + HISI_HHA_LEN_H);
> > > +
> > > +	reg =3D FIELD_PREP(HISI_HHA_CTRL_TYPE, 1); /* Clean Invalid */
> > > +	reg |=3D HISI_HHA_CTRL_RANGE | HISI_HHA_CTRL_EN;
> > > +	writel(reg, soc_hha->base + HISI_HHA_CTRL);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int hisi_soc_hha_done(struct cache_coherency_ops_inst *cci)
> > > +{
> > > +	struct hisi_soc_hha *soc_hha =3D
> > > +		container_of(cci, struct hisi_soc_hha, cci);
> > > +
> > > +	guard(mutex)(&soc_hha->lock);
> > > +	if (!hisi_hha_cache_maintain_wait_finished(soc_hha))
> > > +		return -ETIMEDOUT;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct cache_coherency_ops hha_ops =3D {
> > > +	.wbinv =3D hisi_soc_hha_wbinv,
> > > +	.done =3D hisi_soc_hha_done,
> > > +};
> > > +
> > > +static int hisi_soc_hha_probe(struct platform_device *pdev)
> > > +{
> > > +	struct hisi_soc_hha *soc_hha;
> > > +	struct resource *mem;
> > > +	int ret;
> > > +
> > > +	soc_hha =3D cache_coherency_ops_instance_alloc(&hha_ops,
> > > +						     struct hisi_soc_hha, cci);
> > > +	if (!soc_hha)
> > > +		return -ENOMEM;
> > > +
> > > +	platform_set_drvdata(pdev, soc_hha);
> > > +
> > > +	mutex_init(&soc_hha->lock);
> > > +
> > > +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	if (!mem) {
> > > +		ret =3D -ENOMEM;
> > > +		goto err_free_cci;
> > > +	}
> > > +
> > > +	/*
> > > +	 * HHA cache driver share the same register region with HHA uncore =
PMU
> > > +	 * driver in hardware's perspective, none of them should reserve the
> > > +	 * resource to itself only.  Here exclusive access verification is
> > > +	 * avoided by calling devm_ioremap instead of devm_ioremap_resource=
 to =20
> >=20
> > The comment here doesn't exactly match the code, dunno if you went away
> > from devm some reason and just forgot to to make the change or the other
> > way around? Not a big deal obviously, but maybe you forgot to do
> > something you intended doing. It's mentioned in the commit message too.
>=20
> Ah. Indeed stale comment, I'll drop that.
>=20
> Going away from devm was mostly a hang over from similar discussions in f=
wctl
> where I copied the pattern of embedded device(there)/kref(here) and reluc=
tance
> to hide way the final put().
>=20
> >=20
> > Other than the question I have about the multi-"agent" stuff, this
> > looks fine to me. I assume it's been thought about and is fine for w/e
> > reason, but I'd like to know what that is.
>=20
> I'll see if I can craft a short intro bit of documentation for the
> top of this driver file to state clearly that there are lots of instances
> of this in a system and that a requests to clear something that isn't 'th=
eirs'
> results in a NOP.  Better to have that available so anyone writing
> a similar driver thinks about whether that applies to what they have or
> if they need to do in driver filtering.

Yeah, adding a comment would be ideal, thanks.

--wGeFqUtAjCRVjVMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPpszwAKCRB4tDGHoIJi
0jkxAQDKgL4QVcRIzCo6G66R++ICwhllMamNHAZf8jmI/CO/EQEAmiVSOKVdfzt6
NvldkccfoWmDymH3aGdE/6ZlJtdghQg=
=K+jA
-----END PGP SIGNATURE-----

--wGeFqUtAjCRVjVMX--

