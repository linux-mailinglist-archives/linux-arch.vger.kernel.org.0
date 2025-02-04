Return-Path: <linux-arch+bounces-9983-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F32A269EC
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 02:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9755E7A158E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8486330;
	Tue,  4 Feb 2025 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCDlAvAS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705325A640;
	Tue,  4 Feb 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738633943; cv=none; b=M+9Ls5WxmuVFLboBNB2ZZjzA9VynNIH2y7JcATHvLwnNeoBMVK4uwx9PHii+S3sHTwH9OT8MOE3X5ewUFYFoOlfsH8D8pLMfKqMvoG5LEGQWvA5JD1ZRIys0knnWMZG5HfenJYPAC/18tHVu/GqECyri15OOr9LZ9kIFvtAQv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738633943; c=relaxed/simple;
	bh=dkEe0rf8xrRmG2CnIsiqFJxOTFCCxjUzlTd4UQSHkQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDq7EJyYzmPhJTgYcD3J1xYnHC6dtEupULZov/rk/3jO8m4rQ0ROV4HK11nmgOd4ZLM5B9xOfKj/ZG+UaYav6EMt/CNzBzlxWN0zvsSjgaOUftbGtJmUR7ImyGDGj97Qym34s/qbywB43EbhmodeC0qIeuOL/ywx0rb4gWXGY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCDlAvAS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso117847505ad.0;
        Mon, 03 Feb 2025 17:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738633940; x=1739238740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbW52IjQiNxezbCPrYLHMxQsJPfF46sgw5UxFddLX7E=;
        b=CCDlAvASnGm544k1IUy8PWs61R8Xu1yq/O2EGC1oNnoPJsu6DlVaSAlnSTUAellPB0
         E6vXu8OmjNbJCwHB3Yp479sX3eUIGAiaWEMtm+gfTF96UzaR3x5QxwPC/0h6v0x44L44
         DmDzD75rb2kxmYHjiPJCUkUU9h31y2jtcobqr55gXC+CzL0pFQlInwkOqMcfderdUNVs
         /fHTv9P4pcJXQsMJ8BpJ5nUZaoWu9myjykk0UoobpGK1+9qFJSKzEHklqRvgWAZxLIvZ
         t4J9Xs5cuFQjiKfe6qDcsdSs4Pv2aeQFIUT2aUTGxRuMlvyWhcJzwo2WpzwFGUJa+yLz
         PUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738633940; x=1739238740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbW52IjQiNxezbCPrYLHMxQsJPfF46sgw5UxFddLX7E=;
        b=HpqZ51fRMd4WXCFf+OzU+OlZjAYPPxaqych5Oi0e5YhHWbRybq5E36Qip974pyqP7w
         HAF1nwqE42wapW6kdVe6eriLTnjXGDPSMtQa/wGeOkWmrU1uahxXjPCur+a1nkwnjHG3
         HEValjcWYqEL+2nHv2au1HztuCnRpj1iHwcLYv2Fd4QdEDHlMrDoSXBx+w3300516xdn
         o0K9V8H+pF3PeyyrY5XYvMs+JUNrbAHLuTsFl0C3e+fHE50IoKA1WBukS9PNulnTzIIb
         7Ikn9wNFO3pfHV1MykwY8UZA58olCfSH2WT6IB/XW5FdOuJSLcj6GIG5D2+QrSFNblse
         Fckw==
X-Forwarded-Encrypted: i=1; AJvYcCU3YlP3YAMLBD2ErlqOr4KUM2N+PgqfkEOO/ligNCOHc+PUi3xKzIoaGzAxPidwmUKbvrfxPxIDrnleNQ==@vger.kernel.org, AJvYcCUZz+8EGiHqYoCieePEYF/f4/OEHx25J9q3HCJYLXIDkH2a4Fiz2HkSMBowad/JbC40fkB59Ro1LLwv@vger.kernel.org, AJvYcCVADLwDep7GTUQzUfaZ00Kb4mGzkmaEjDZfDEuBZXAz4ILCqwa9O0CRdheMadWRTB/+WBo91mWk@vger.kernel.org, AJvYcCXfHQ70+lwD8htVdobCpA7kuVQTJsQlFoAH2D4qlft0yIFhdvYi20iHVWkiKrQql5Ni9q6+8XZ8QeFHnqmt@vger.kernel.org
X-Gm-Message-State: AOJu0YwodgoTcIRp3yMGnY1E4P6LbQ15sw1gWnwLf75+AonKI3FVdQ6C
	Ojrf/xp6UznMPflMpttYwDLuAPSCVsXE1bDykqCU60ejtkdW4bhu
X-Gm-Gg: ASbGncstHndcZ5AHm3/QxxKTUFZ++n7M6u6lhrYUgZuoH5oZ3Jo9Mw7laozb0eoMlyW
	62iz8fEbyZMbIAK6BZBi9SCioH7MZePiBk2xfDzPTG8N6pgXh0cGxYOYN0qgo2xitRpXmZ9nWPN
	vBKJK1kWIN4CbYCLaja2pcedlIyJ9JSsek9mQOE8r1ysZwLS5OP94uJByERHafcTyTDriVufBiO
	qepBQd0z70RYZRSB9yTauP0LtzEPAHX1t1cUALy63UnCDWxX8KMBf7TjzmJTAuVucpKhAGQb9bP
	NwPKgnHlTbdKhcY=
X-Google-Smtp-Source: AGHT+IH+hoR48GnLXz302q1aM556oTJvCwUveYpSavJ/2CeH+HhtWnIFBYsSe5QkMUDQRF5BOaWY+Q==
X-Received: by 2002:a17:903:41c4:b0:215:bf1b:a894 with SMTP id d9443c01a7336-21dd7d73401mr438772395ad.24.1738633940158;
        Mon, 03 Feb 2025 17:52:20 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848ade8c2sm10863374a91.48.2025.02.03.17.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 17:52:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 009E74209E79; Tue, 04 Feb 2025 08:52:14 +0700 (WIB)
Date: Tue, 4 Feb 2025 08:52:14 +0700
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
Subject: Re: [PATCH 01/20] mm: Add msharefs filesystem
Message-ID: <Z6FyztBFs1Mwm2_K@archie.me>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250124235454.84587-2-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I4WrBx2o4SxYGPPZ"
Content-Disposition: inline
In-Reply-To: <20250124235454.84587-2-anthony.yznaga@oracle.com>


--I4WrBx2o4SxYGPPZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 03:54:35PM -0800, Anthony Yznaga wrote:
> diff --git a/Documentation/filesystems/msharefs.rst b/Documentation/files=
ystems/msharefs.rst
> new file mode 100644
> index 000000000000..c3c7168aa18f
> --- /dev/null
> +++ b/Documentation/filesystems/msharefs.rst
> @@ -0,0 +1,107 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +msharefs - a filesystem to support shared page tables
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +msharefs is a ram-based filesystem that allows multiple processes to
> +share page table entries for shared pages. To enable support for
> +msharefs the kernel must be compiled with CONFIG_MSHARE set.
> +
> +msharefs is typically mounted like this::
> +
> +	mount -t msharefs none /sys/fs/mshare
> +
> +A file created on msharefs creates a new shared region where all
> +processes mapping that region will map it using shared page table
> +entries. ioctls are used to initialize or retrieve the start address
> +and size of a shared region and to map objects in the shared
> +region. It is important to note that an msharefs file is a control
> +file for the shared region and does not contain the contents
> +of the region itself.
> +
> +Here are the basic steps for using mshare::
> +
> +1. Mount msharefs on /sys/fs/mshare::
> +
> +	mount -t msharefs msharefs /sys/fs/mshare
> +
> +2. mshare regions have alignment and size requirements. Start
> +   address for the region must be aligned to an address boundary and
> +   be a multiple of fixed size. This alignment and size requirement
> +   can be obtained by reading the file ``/sys/fs/mshare/mshare_info``
> +   which returns a number in text format. mshare regions must be
> +   aligned to this boundary and be a multiple of this size.
> +
> +3. For the process creating an mshare region::
> +
> +a. Create a file on /sys/fs/mshare, for example:

Should the creating mshare region sublist be nested list?

> +
> +.. code-block:: c
> +
> +	fd =3D open("/sys/fs/mshare/shareme",
> +			O_RDWR|O_CREAT|O_EXCL, 0600);
> +
> +b. Establish the starting address and size of the region:
> +
> +.. code-block:: c
> +
> +	struct mshare_info minfo;
> +
> +	minfo.start =3D TB(2);
> +	minfo.size =3D BUFFER_SIZE;
> +	ioctl(fd, MSHAREFS_SET_SIZE, &minfo);
> +
> +c. Map some memory in the region:
> +
> +.. code-block:: c
> +
> +	struct mshare_create mcreate;
> +
> +	mcreate.addr =3D TB(2);
> +	mcreate.size =3D BUFFER_SIZE;
> +	mcreate.offset =3D 0;
> +	mcreate.prot =3D PROT_READ | PROT_WRITE;
> +	mcreate.flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
> +	mcreate.fd =3D -1;
> +
> +	ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
> +
> +d. Map the mshare region into the process:
> +
> +.. code-block:: c
> +
> +	mmap((void *)TB(2), BUF_SIZE,
> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +e. Write and read to mshared region normally.
> +
> +
> +4. For processes attaching an mshare region::
> +
> +a. Open the file on msharefs, for example:
> +
> +.. code-block:: c
> +
> +	fd =3D open("/sys/fs/mshare/shareme", O_RDWR);
> +
> +b. Get information about mshare'd region from the file:
> +
> +.. code-block:: c
> +
> +	struct mshare_info minfo;
> +
> +	ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
> +
> +c. Map the mshare'd region into the process:
> +
> +.. code-block:: c
> +
> +	mmap(minfo.start, minfo.size,
> +		PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +5. To delete the mshare region:
> +
> +.. code-block:: c
> +
> +		unlink("/sys/fs/mshare/shareme");

Sphinx reports htmldocs warnings:

Documentation/filesystems/msharefs.rst:25: WARNING: Literal block expected;=
 none found. [docutils]
Documentation/filesystems/msharefs.rst:38: WARNING: Literal block expected;=
 none found. [docutils]
Documentation/filesystems/msharefs.rst:82: WARNING: Literal block expected;=
 none found. [docutils]

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--I4WrBx2o4SxYGPPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6FyxgAKCRD2uYlJVVFO
o3mqAP0WCRTp6aXVKc1BS+3edGdiVhX5X479v4h3aQF+JIOn/gD7Bh8TkCn4JACk
8nuEOzgt2CpenCSHZTG/7JiA4Rztnwg=
=hlZS
-----END PGP SIGNATURE-----

--I4WrBx2o4SxYGPPZ--

