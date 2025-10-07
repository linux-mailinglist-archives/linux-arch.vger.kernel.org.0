Return-Path: <linux-arch+bounces-13943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABCBC0054
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8FEE4E406A
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B901A5B8B;
	Tue,  7 Oct 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsUbabb6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9557464
	for <linux-arch@vger.kernel.org>; Tue,  7 Oct 2025 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759803796; cv=none; b=Gesx5NNygsojMjjZvGxH8rSELFqQYpPhhuWJ19f6E7HKB3CLW1LDVaT3WEupTChbuwH0bO3y5x85EspyUknk3Rr/rGoicrx3u7gAnZToGcJpcgC2dOohqq3xXdQdHDRlU1oeixeuaJ+YGrx4RYTBDGK8qxtdqZdiUf33KmJ3LLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759803796; c=relaxed/simple;
	bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbOywl/as7jALi5uGtvvbs9ofpkoW3edNc4aXfcJDrV1WCfjgwOR/rNA+ptTLh+DbAUnDPbSQxdihw1eFhd1eF9uKQ1UAx/FtG75RTRf4jmErHjPeKGEFpX4yHLI65GCgcHW6l4Od3d8vIe2MWIK1+qEbd5X1c+h/qbcxBWvrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsUbabb6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso6608552a91.0
        for <linux-arch@vger.kernel.org>; Mon, 06 Oct 2025 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759803795; x=1760408595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
        b=dsUbabb6l06KJXGCdPtZiVMtWdwnBLSbSQsM1Rk5pumQuR/OkOgFCKVg4GQxwFDGMS
         mBWrQKCqrj0pK+6jFR6HWD52gXGSAgL2LOl6TDduNamn6NH8S18yyAaYDZlfizrvjU40
         1xSrp3nibSL+PF29vEbKn8tRaB6MQRLYzBXZaUZz1JKRwySPFYH3wOY1HAD/NOUrRXdc
         tpcpSns+N2l7Ky5dPi8MQldx1qpyQPsF1Aql9UOrjo8B6MIvnlIKSsQ36tKBuhNNvxms
         tV1r9M+Mh8Z4wY90kX54phHFNpUHHHKv9WPb2eSucGx312kuwHLTT/pBGA8a8q7p13g/
         OR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759803795; x=1760408595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFmeDcTP2xUAQewFWw/R0BKl+XcGbbncNDnV2L/OXN0=;
        b=q+hwGsOC/hP0fzBhgKRBXtOW3mP2YWx3gxtzgoaPvNYgJkCJbYvP/pWKWRJuZdXK+D
         ABjjUS2rGFQCwzfLfg3g/p2Gi8E5EK0ycensvS9wSnBsaWLHHpjD/XRBn84CWhHH8XNF
         Ec5ebTNFWF3XugzjVG4msyIe/W64J0BVmR7U4e0hsIQaqqnsN9BPq45iAUJCy1HTz029
         IjV7R1ZCBtIrOHWXmhSs0FF2mOyRc1h3QRvzMGiGErfpTSLEnsicbpEZTsG7W2b34p1L
         PBJnu8zyjX8S4f+VOEMEgxP93YkflR7OOQipfOEIt1iEVYXS3BzJeytB3ZQ53uWnK0Td
         EhRA==
X-Forwarded-Encrypted: i=1; AJvYcCXsVm2TzzT/GioyRyrWmDi9/BbC1+ewVCRxq3rFiwJON5Fu05FQ/1D5+SB7JGdpSmPqHxlIXkU8AiMI@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWuaVqBLSlk0XyTFRXyKEUcX9MzHZ62jclSE6eQFPFCvwITfA
	DE5bsdqbBOMz/ajAXYVcaK/y3zUrdW1TG3B8NnCX6Kobea8p1J18ZnR7
X-Gm-Gg: ASbGncvuC6eoGcNcmBraILDcoLnVP2jONreHvhXHt9yXq1f8wIzMeW0zi3Xm4B2KHby
	n0bqlov1Mqxjc9cCr7ODlD3xh1YbDSw2dUB48p+7Mh+VauwS65Qs+Lw1kR/Rjr22lWIxGOgFU7q
	+e+sFJu2Gfu0xWO5LFTlnisduc0ItNJPNFsNN/uc678X7Ao88YN+SXX44XG3IzPg/EhyzV0SXKK
	0CDSYGkdX8CInh21m9aTNDcb2EbJV7iiBabcZji6MAP2FSCMnfX4OZqJnEwSdtTv1PVqYwgL7EM
	KUtluSui/Ti1dJUrLHA5noDJ68flsuNpLhRO2DoKMk4d5dsYqmP4DgljZ3YCs4cGAQ+8Kwc9E9Z
	rB/Eb4UqtvzZ8Pienh4bDd/NTJkgHlHW9gdgyOoTTfOYhur8F4w==
X-Google-Smtp-Source: AGHT+IFOWjODpkm0RXk0UNQxPxlDwgwSSLwVcoAanx1LQC/FF/GVJT5hQh4wQ4RD5szE0at/zJ+BUA==
X-Received: by 2002:a17:90b:4a84:b0:32b:ab04:291e with SMTP id 98e67ed59e1d1-339c279971dmr17239314a91.25.1759803794482;
        Mon, 06 Oct 2025 19:23:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff26f8sm18166635a91.13.2025.10.06.19.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:23:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8DC154233432; Tue, 07 Oct 2025 09:23:10 +0700 (WIB)
Date: Tue, 7 Oct 2025 09:23:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
	corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	Tianyu.Lan@microsoft.com, wei.liu@kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v6 01/17] Documentation: hyperv: Confidential
 VMBus
Message-ID: <aOR5juzHnsK2E40z@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BxWMTnibnAgGT5v9"
Content-Disposition: inline
In-Reply-To: <20251003222710.6257-2-romank@linux.microsoft.com>


--BxWMTnibnAgGT5v9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> +The data is transferred directly between the VM and a vPCI device (a.k.a.
> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VT=
L2
> +and that supports encrypted memory. In such a case, neither the host par=
tition

Nit: You can also write the cross-reference simply as vpci.rst.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BxWMTnibnAgGT5v9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOR5fQAKCRD2uYlJVVFO
o7mVAP9gyGXv/aQVGaS5iH1wf6rUETBzEy69Mg8TYKRf5l2JsQEA5cnv0cPiT81i
pUA3Vos9PED8kntZHhKYkra64woP1wo=
=xXE5
-----END PGP SIGNATURE-----

--BxWMTnibnAgGT5v9--

