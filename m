Return-Path: <linux-arch+bounces-13962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E2BC6D98
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 01:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5416E189A4B3
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5186F2C17B2;
	Wed,  8 Oct 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYkCLU0W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5222BE643
	for <linux-arch@vger.kernel.org>; Wed,  8 Oct 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759965630; cv=none; b=CgRGs+uKISJyasofYPWfUa0NlP06J+Ca8nXg+AH2ECQKh6wVlpetHqnvTAVndZHQphWAMD3k5pQ+d2fjTsqdVVige10YzkREoB/YbdznvAd01eDFYrU9lc3pdbpfMqdAHvnIwbFqxeYzul0G9PgMrMuWOtMO6GAvVBP9hf0jEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759965630; c=relaxed/simple;
	bh=L5J9SFJbxt6CC1AJGH6cLwr7pet8t8jfe01dPeD59us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGg8GGS9tgV9PVzLnH3V4mT5HN1ixCCTu1UA2foRpFah6EKpAIgU8xCFmHfnMu3Xzwg48R4W9Rs18tf6cYeQOSwA+JbCHUtIeZu4SPIN7YFcEeh/70SHEqUc2LEgqjFZnAygQLihpU/KzGsOJm+MIO9yHWrxywdayjN/knxBfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYkCLU0W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698384978dso2483415ad.0
        for <linux-arch@vger.kernel.org>; Wed, 08 Oct 2025 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759965628; x=1760570428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5J9SFJbxt6CC1AJGH6cLwr7pet8t8jfe01dPeD59us=;
        b=eYkCLU0WkNktpp4jLKV7h39Fh+oz8/jVxRbarBo5DBJA1+lg298DEOoMo5G2/CqBHg
         XV7zj5WQcsDRcULzxa2dFJHsbHWwuG4UJrHzckQhN/XBMPAU3axB8q0EHyih9FW225oo
         d+THtmwDKsami6HIRQgsUgAdFC3kt24AnS73GUyURtQopSqaErgpT+w43ttVj8wgAq/y
         O1810n6PPiRbOX4aDGjlKce0/2fNhqUz6dlfMEozJzOFF/H0mA77Vstqlh4Ya94JgRY0
         M6Sn5mQeBw/HPZ/ywE+XCuLeiTemwuz97NzbYYmqvbn4gFsztV+hmaGF/ifhKgZiU7j0
         pr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759965628; x=1760570428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5J9SFJbxt6CC1AJGH6cLwr7pet8t8jfe01dPeD59us=;
        b=cdWeDMvt+ARv52nSRQQ6s4h3gYZGLmVZq8QKbgkPfsAs7IRCxocHztW/aytbDewBPG
         CnXRF86Tf0A7Gy6iJ3rT7VZ9Z5wzDDoOQgF/h3p231wZA0UXJ3jfSDeHZK70EvOrZktD
         qdQ3TfdwkWr9rT5us8od50Vj19D5O5N8kpVbYduJ+lC7+NKrSKYN4+NZYN9dxyodIV8x
         /ZOzCl6X+qHVtB1YdqEOC4Q1mkAusuLDcTBUajUegfve+VukT1zsf3hxZMt9SGm5VNBo
         M8qAVU8jrtrFbvUF7HVRbSC1O59NZJ2LURf66EwuixNrspG1SOgrsRlN64ODrMuwQ6WV
         C3aw==
X-Forwarded-Encrypted: i=1; AJvYcCXmTLo14oFufGJbvgoYdPM+MP2kktSfpcGJv/lgQkT3DrbxM7qc1rTT565pPALnnLpLbj9eG1w8/BV5@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiVcT+kNnG0Lo7gEHDh1Nm67YFjZzT7BGkNNIVK1T+NCYva13
	JuSJjtcI02c/CmudwM+6dvW6IqcGzOCOiEuatjdtlS1Lv03ZXgRmKrZJ
X-Gm-Gg: ASbGncu6YiBBn6ihodiROaFq/GdAC0Hd4nQAcxmyqjD55UI16VlbCEf0c6WWeZY6ZzR
	VZj1HP9G1tMK1nKjLZNokAbsJLopAauGyGC6/oWmpRIeAG3w2ITmE7s0ux2QlcTyyIEht2nw6my
	tgqbeUlGDSIMCQQrlC9ns0BHkUc0p/lgNDN+nW6i2xdj7ipj3bKarC9Wnz0+yqaVz3BFwRfSe+0
	S0xxQN5EH/DTK/Ex99ejrJnL1foAVCBlpDRGB4/OW1ePIGHNqSuxhqJ88Y4ydZw5N+yZmEgjd4V
	bzl+A23dLhC92NZcCOvkd5cskAciCGCjp4NUite9q+IYxoPh5HfqJUi/mD0F9CwBhtzDb4PKgzW
	K5iuslAbx+L3ofTs7eBdaMXSFk0idSzg0Q+GalG+0kDEaMN5EXA==
X-Google-Smtp-Source: AGHT+IGPI2MExiSfnnLPYD+tUnOJs0Zg7egrbTgL9CdVjSBxNVuUdrol/TpXRHHhafhK1jcIWh4STg==
X-Received: by 2002:a17:903:40c9:b0:27e:d9a0:ba08 with SMTP id d9443c01a7336-290272e3b3emr66288225ad.43.1759965627774;
        Wed, 08 Oct 2025 16:20:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ffd77sm4824305a91.7.2025.10.08.16.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 16:20:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0666D4233432; Thu, 09 Oct 2025 06:20:24 +0700 (WIB)
Date: Thu, 9 Oct 2025 06:20:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Message-ID: <aObxuPcUDHzcWoir@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
 <aOR5juzHnsK2E40z@archie.me>
 <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
 <aOWouGarxf0FB7ZR@archie.me>
 <f1cd86d1-3a59-4bfa-ae97-3ab092a1f3d3@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M44Aw6fd2pjuHLwf"
Content-Disposition: inline
In-Reply-To: <f1cd86d1-3a59-4bfa-ae97-3ab092a1f3d3@linux.microsoft.com>


--M44Aw6fd2pjuHLwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 03:11:35PM -0700, Roman Kisel wrote:
>=20
>=20
> On 10/7/2025 4:56 PM, Bagas Sanjaya wrote:
> > On Tue, Oct 07, 2025 at 01:38:02PM -0700, Roman Kisel wrote:
> > >=20
> > >=20
> > > On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
> > > > On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> > > > > +The data is transferred directly between the VM and a vPCI devic=
e (a.k.a.
> > > > > +a PCI pass-thru device, see :doc:`vpci`) that is directly assign=
ed to VTL2
> > > > > +and that supports encrypted memory. In such a case, neither the =
host partition
> > > >=20
> > > > Nit: You can also write the cross-reference simply as vpci.rst.
> > > >=20
> > >=20
> > > Thanks for helping out! I could not find that way of cross-referencing
> > > in the Sphinx documentation though:
> > > https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-ref=
erencing-documents
> >=20
> > That's kernel-specific extension (see Documentation/doc-guide/sphinx.rs=
t).
> >=20
>=20
> Thanks, got it! So far, in my experience, that doesn't work for PDFs.
>=20
> > >=20
> > > I tried it out anyway. The suggestion worked out only for the HTML
> > > documentation, and would not work for the PDF one. Options attempted:
> > >=20
> > > 1. vpci
> > > 2. vpci.rst
> > > 3. Documentation/virt/hyperv/vpci
> > > 4. Documentation/virt/hyperv/vpci.rst
> > >=20
> > > and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
> > > generated a hyperlink in HTML.
> >=20
> > That's it.
> >=20
> > Thanks.
> >=20
>=20
> I found in the document you referred to ("1.3.4 Cross-referencing") that
>=20
> "Cross-referencing from one documentation page to another can be done
> simply by writing the path to the document file, no special syntax
> required."
>=20
> From the document, that relies on some additional processing within the
> kernel tree (above you mentioned that, too), and that doesn't seem to
> work for PDFs. I'll stick to the :doc: syntax then used in the patch.
> I'll investigate separately why the additional processing that allows to
> simplify syntax works for HTMLs only.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--M44Aw6fd2pjuHLwf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaObxuAAKCRD2uYlJVVFO
o07sAP9qQrckotDpQU+Wf0v1I+327Okq0ZEldg97vKf558qkKwD/ecnMknqaTLqj
pTkwfBiapQdzY3ss+QylP9Vu4xQzpAo=
=zcax
-----END PGP SIGNATURE-----

--M44Aw6fd2pjuHLwf--

