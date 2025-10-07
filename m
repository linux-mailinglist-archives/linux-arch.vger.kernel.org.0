Return-Path: <linux-arch+bounces-13952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95125BC3046
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 01:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B03764E30E2
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211527877B;
	Tue,  7 Oct 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLz8WOVG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AC246799
	for <linux-arch@vger.kernel.org>; Tue,  7 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881407; cv=none; b=aRrm4VmLJlGaAqxbQuISwhAzSptCmG+vPVjHszm32AL495H89WfveCYMEB5d/9NnsLwoNNeKSYf/BTAQ7kyjOf2EovUl4guoesX1JIhRTCT+wAsrepW8bVePvQEQDLxeIfAkJkTZw/atMKCKVZdq8YDd6/r2sEhlNISlcwkhmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881407; c=relaxed/simple;
	bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFgLkygfjKZbVvc+yiPt8n3FQIKk8TJhX0gOXIve2Q5sKe6rjM7rYdirlbQCfR3IdyvD4V7C19Jkud3d82yQnEPvawXq1hU0YdDqaPzOJoyvtelqRNtjym5980+jecCoar1oaKb6+jX8JAj5txHm8qC5B1r0f2ia2dRWrWF0PWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLz8WOVG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-28e7cd34047so57201635ad.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Oct 2025 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881405; x=1760486205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
        b=GLz8WOVGheFn3RBJaFY/U1JgK36OepF93uQJoRhispeXsiPtRsLqFhqs63Bjuk1uhM
         ophSCnysgbBUxf6QEwtyqHSxrQCtEuio0YUPZ+P75xhXzgPaYq8etiLstBJaMxfEazRO
         zfuWD1802NUI/eBlw3bkrVEP/DyiYAWp6rn8xoJEiJFUzxdCDUxGIU4quEP0CyJNfHzX
         AudNZqvRYPeEFilDQ8X4nsblrn8i5dGS3ryDCX/NZ9Ve6p6s8c++4i7gfGTF/QfR5pl6
         lFju8eVY8qejuOz/n7RtRApTpjUrMf9ZGDhBo9fhDg+wKnRsrC8zSWMNOUFuPrK7l+x3
         kTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881405; x=1760486205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqqqImyVX4Ca3i3a0FyZ/Awd7F5tA5oiYrQNUtG8eUA=;
        b=qV3vxFDoI1xMH8fBziRgtuVmZR4Pouanswt4XS6tmW2O39NxbC1NUPl970OXe5ECZV
         Be2lAgwPlMFpAnoYspBidDhDP5ZXjgeO3+BS0DpmYKBaLEK5hOeSYl8Ry/DHpgxyJj/2
         len6I+sbR+gVN3PmfoVaFTfrBKYeZYm9bN+7qIF0Abt1NrouEI3FzoC/HY2O+Yy0aLwa
         hbk3n3NvDCCpmBO5M7c4kYAA2eRPHjhTKH2c4qk2r6lLbhY/P125QeyT/E4Z21GUKX6G
         owwT4AZBczCRkM0zkmw+JOqyscxe+TVNxv330PL/WZF4HgBTTBg3NUaDYCH0oKuwLpjD
         YfGA==
X-Forwarded-Encrypted: i=1; AJvYcCWkLkNmffvHFU6jsqMfuAy2hWSzx482i1PF+hiQuIdkuqS/wNXdC0CGd65wdSsHdyG9b1MkzBzusWlP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0zghjkMqQO579bKQxIvg8jnls2HBKTUFWvFYuWPuoqsFPbmb
	MJ5uZddCkA+lf3lqoyNrKeCfcYYlXLtPD0MLZV1lAXTG+/YcCtUX3wyK
X-Gm-Gg: ASbGncsRWA5m38Uu4wGdpbMwJkjey9ObXUtFxGf+7Jw8K6TZPs+VPjcGfBvJ/5Hbu3w
	/Ph/xR+0anuTkjeJNTo/gK8o/xF/oKgaydu29HW05qg8u9OidCdtry7GEBCQsTH7UrlEYkRsKGu
	fBfyyudSWp/0ItcBBE85w5YNkL3D303Ms5uvJrJTBf0SI2COPOD/Ve8UZBo5P94p2YDPDTzfX3H
	rd7ZUzDNXZKNxsBHUvvPGeHMc2CwTVZ/Z0kLBkQh3INw0Vaw0wgcn0Esf2F5SJ/dVOGeE+GYPmj
	4qw1oaqGEftIbm5nXeORTW33fawC6OaSxUEpRajirxB41dxVTcuC2uCyLIxzpu0cEnfyfysrTkp
	3i/LbI2krayvhlepp/H4EqeBkZh7XEDZuAZ1v0lLGfq7gYahNIPs+rx0+28PG
X-Google-Smtp-Source: AGHT+IECR12KH7zCTIlL8PskN4SIrX86zChxhzZyqyWEAG+eeOOhmLw/P52uED83EK633yo7c2PQsw==
X-Received: by 2002:a17:903:298e:b0:26c:9b12:2b6d with SMTP id d9443c01a7336-290272b550dmr18677895ad.38.1759881405144;
        Tue, 07 Oct 2025 16:56:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b513ae7d9sm937031a91.24.2025.10.07.16.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:56:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 599D64233430; Wed, 08 Oct 2025 06:56:41 +0700 (WIB)
Date: Wed, 8 Oct 2025 06:56:40 +0700
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
Message-ID: <aOWouGarxf0FB7ZR@archie.me>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-2-romank@linux.microsoft.com>
 <aOR5juzHnsK2E40z@archie.me>
 <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DTXlXJKe31yrlnoK"
Content-Disposition: inline
In-Reply-To: <273e0882-24f5-465a-be18-d67b4249ce12@linux.microsoft.com>


--DTXlXJKe31yrlnoK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 01:38:02PM -0700, Roman Kisel wrote:
>=20
>=20
> On 10/6/2025 7:23 PM, Bagas Sanjaya wrote:
> > On Fri, Oct 03, 2025 at 03:26:54PM -0700, Roman Kisel wrote:
> > > +The data is transferred directly between the VM and a vPCI device (a=
=2Ek.a.
> > > +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned t=
o VTL2
> > > +and that supports encrypted memory. In such a case, neither the host=
 partition
> >=20
> > Nit: You can also write the cross-reference simply as vpci.rst.
> >=20
>=20
> Thanks for helping out! I could not find that way of cross-referencing
> in the Sphinx documentation though:
> https://www.sphinx-doc.org/en/master/usage/referencing.html#cross-referen=
cing-documents

That's kernel-specific extension (see Documentation/doc-guide/sphinx.rst).

>=20
> I tried it out anyway. The suggestion worked out only for the HTML
> documentation, and would not work for the PDF one. Options attempted:
>=20
> 1. vpci
> 2. vpci.rst
> 3. Documentation/virt/hyperv/vpci
> 4. Documentation/virt/hyperv/vpci.rst
>=20
> and neither would produce a hyperlink inside virt.pdf. Options 2 & 4
> generated a hyperlink in HTML.

That's it.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DTXlXJKe31yrlnoK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWotAAKCRD2uYlJVVFO
o/pSAP9eXlQLoQODQqZ+A48QpAAsl+hf9OhLGhdndl6X6JStvAD+OSXtE5WfHadF
FMFMiFdufdHXrrE7npbMx380tvu34Qs=
=nx3N
-----END PGP SIGNATURE-----

--DTXlXJKe31yrlnoK--

