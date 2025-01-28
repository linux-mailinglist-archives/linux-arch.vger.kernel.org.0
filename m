Return-Path: <linux-arch+bounces-9930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CFA204E7
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 08:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D79218885CF
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A924198842;
	Tue, 28 Jan 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ8xdxRg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D74430;
	Tue, 28 Jan 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048280; cv=none; b=WdzrOddrnKr3mCNTxVwoVc8sP+wa+ka6sRpbUXNIKMv+XYeO6wJkRgLzrIO+KOUCMMiQVbylFU8wgk7exl138e41Czvgidg7ToCXLbI5M+bLAh0AFClUTfSgSbiahCETl8Mi8pC4sQwgbQ4JJKpiE866WDrnzlyQA7TXDtcXFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048280; c=relaxed/simple;
	bh=qb59MYWuc/ZGTCFVDZKupCVYcsTZ0gfflndQPHympkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+ioL6gYA1yOaKiRoe+sQmMMymswJEDvserjmbZU0RH8Ue/mRcUoZfxP8bX+doaKeCX/7b7n/GVwDN5ZV2BFr6OlDuFC3Nin+yRSwYp2HzRDg3tOMrgj9aZXmqucoT/vTLTCoozFiQO5zokqbFSZzriqYlF+Xx34BtMPwzvSLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ8xdxRg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162c0f6a39so112610875ad.0;
        Mon, 27 Jan 2025 23:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738048278; x=1738653078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOee54Vjfy8Zgf+CeinxDwBoPyWlYWwKO8jqEGetSk8=;
        b=QZ8xdxRgHM7ePzcFEBTE7Be5LanC/KCS3OyYBEXgk2cBAgP9cyrMwInb+j10Y/hXV+
         HhsP7JoZxxrNiG6MStylph6HtBemXejz9f083dHY61OfnHY4kadwnJ+UmVYVB9QtmoQb
         V61W4YKZrKXgDsTtDqv39wc40wXSKU7OtKzWP9mNn7tCBNXdav0hPZtjxnaVmcBZllxf
         J1l6wg1mhY70traQrdJ+MYjosjolerr5WIe5V1RH8Zikj5RYfv+6GMIlHyIceOczl/jO
         IhNn/abkWOz6aC9OzlpMcsrLnyJH6KNpTiqPpMO4ufTeV7O4rjdp6QYCue0SE990VYNT
         /Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738048278; x=1738653078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOee54Vjfy8Zgf+CeinxDwBoPyWlYWwKO8jqEGetSk8=;
        b=Tws8NEUyAz9i3yRCERzLiEhBvn7tzPe7mmwL9grs/V/qwYN706J+jahttCvuSQrF4O
         Srw/qUru6cQsIwyzBv2VGurEybhGJ8Ck3zmsONVY3FJ++UFrEVBFVnkwoeQAa2lRZHhC
         ify3O1Bkoacgaj58+FYzqeOJbtAZb6DfJkYx4KR2Q29fjWeI/MOCe69M8CkAim8vRvSv
         9K4jJ46kiCd4edYOReu6Nwgv6iG9yPFtsMn+NLZDlfVDtjRVK5t9Q4zp+Y3Gge9kYN5W
         0gOe0ZCSw2gj48CHst2t9YsMhqX+s+xct34E3nR2s7eCzEV+U6N9TOVt1eqAjdx7Ymiv
         O90w==
X-Forwarded-Encrypted: i=1; AJvYcCUTR64Py5IvMz580YT44JsEpXmpn4Elo5BUKqnWiTQ0ZBBzB2fYgPV7WCNOfMR8OZICLLaagFPeM9S1wA==@vger.kernel.org, AJvYcCWP7MNLqGh8lweQGu69sxx0DdKdhq+KW0+X9kqOt3VV5RhBFw4ja2kaxqNegm9bmq1A1ZjtVfJL@vger.kernel.org, AJvYcCWzwS6RFLS0BlzlIipomMHTBRXI0KKR/QzcOcvf8NwdKBlMG7IWTcv5fEbMUA7eq4izl4FZAqel9wx3vBre@vger.kernel.org, AJvYcCXRxpAsd4vmGU0eddEnv3VU4IQmwi5VgzAmTAXr2Z9MmMgFUPLcNOuCjd1qRHr8s5L/YosCzpgXc6B6@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnBWTCUSpEJA0N1LcsrxCkVk4KDUqH1ml+EUcwlZCNy4Mf6wp
	mBlv+Qe8ja2z0ssBGMQx7hG73DIprN48wtAK1u0LTICif7cUaz5a
X-Gm-Gg: ASbGncshd1/MEIz7d0n0lTkmBlzvOtNmRdJu8u4tcWP+Ys+dN8FiVpDD1BgbivuYulA
	/KgqjDJUHbnr9tZ0V5zv/XsaS8Q05skQjGQ3LLWElQl4e2BUNraWdkj7KOp1cs/eUfPBuJukLqa
	mxeKTgzpLj7Ap/pxG0WuBZqn5ZBCmevFjqAjIDmcMgofhlxpcJq1GnC1UCkEwt5GmWUUWV1xc5A
	Mjr4fp7M4+a5djxj5dJJM4QkVtbN+QG+EiRWOUdnFOwvgNN+67pj/CCR5HcCyNLW7K8p04M7qDu
	dyNBR1pDGSMUh9w=
X-Google-Smtp-Source: AGHT+IGte3XzP0hcbMME183b4Iq4zR/+73//Bdw3Gahd7QTH6jLtMBx6u5GrLhR7l+kdchY4YAXEKg==
X-Received: by 2002:a05:6a21:7885:b0:1e1:ad90:dda6 with SMTP id adf61e73a8af0-1ed6e6db70bmr3622280637.20.1738048278128;
        Mon, 27 Jan 2025 23:11:18 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a760e35sm8457899b3a.89.2025.01.27.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 23:11:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CC20B420A74B; Tue, 28 Jan 2025 14:11:14 +0700 (WIB)
Date: Tue, 28 Jan 2025 14:11:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, akpm@linux-foundation.org,
	willy@infradead.org, markhemm@googlemail.com,
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: jthoughton@google.com, corbet@lwn.net, dave.hansen@intel.com,
	kirill@shutemov.name, luto@kernel.org, brauner@kernel.org,
	arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
	mingo@redhat.com, peterz@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tglx@linutronix.de,
	cgroups@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
	vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
	neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH 00/20] Add support for shared PTEs across processes
Message-ID: <Z5iDEpaEPynnW4s5@archie.me>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdmPF3+wO5kdxqKn"
Content-Disposition: inline
In-Reply-To: <20250124235454.84587-1-anthony.yznaga@oracle.com>


--vdmPF3+wO5kdxqKn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 03:54:34PM -0800, Anthony Yznaga wrote:
> v1:
>   - Based on mm-unstable mm-hotfixes-stable-2025-01-16-21-11

Seems like I can't cleanly apply this series on the aforementioned tag.
Can you give me the exact base commit?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--vdmPF3+wO5kdxqKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ5iDDAAKCRD2uYlJVVFO
o+/KAPsGv924ZYZ6/UMFVH433PGVmgZOkVswFu3KjB9IDSSvFQD+IsVII6smVoXN
3z9RVSqI01TZwsI9dsMsU/9ccHsK1gE=
=y22C
-----END PGP SIGNATURE-----

--vdmPF3+wO5kdxqKn--

