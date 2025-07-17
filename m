Return-Path: <linux-arch+bounces-12833-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE836B08BB2
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD26558605C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7B29A31C;
	Thu, 17 Jul 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw8P4cZb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485A28D8F8;
	Thu, 17 Jul 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751619; cv=none; b=rlFycLJboADhHV9XuXV+C/I/lj9WkzwzvqVzPN65QmDM39QtqGFat50MbfcJs+xpen6HhwMdQZqqILHHoocrFpCkRizgrwLRbzfvdukFIASbCE+6oFDJQMwIkHXtnCEJg9wfvYTPYKGLumCadaMg5K3Ucb2XhwK/iMrgRiaKV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751619; c=relaxed/simple;
	bh=n5lz0P7zqJhekiegT2JchABpgJQ16TCu5PSuMlnO1/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0OCDgt6myRyY62nxUSuan037OxPdRQPdnMd8QcwmwbV21eRLueuOjQvkZIc4ut8l70Wk2eDFi5pMEjxcf0Wbv57ox4x6iVBEJM4icVQOogoYKRGaiIYVnM+0FL61+DXZzJF0aD2wJx24oqfFyccam97cMfxYFLHdfrSFzVz7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw8P4cZb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so717916a91.1;
        Thu, 17 Jul 2025 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752751617; x=1753356417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mamQmxuSC1gLOH8NTWGobgALudQdb1hsjmYCRHW0pFo=;
        b=Dw8P4cZbvvqxoTHoaGVSgRCA1IesPO8Yc6gCmC7HTlpDbjxo5ohDlCA1FjS5DoR/TK
         tNkgJKcREb7QJ3Xfe+BZqeaHx8QQo3tcDC56jDgLNQ46AWDXQTVXBM9EyEM/aG1kykNo
         piD0Tx9exBx63V9qLnNfq7Ssx18RZ6Ux91WSr09VqjCViG3Wvch76RwOWPP0pcPVWnF+
         xKbh5VXYHhI417Uu1IwwjcA1eDwMI7c9TUKGzQJBhbE8lQZw6EUf97G4pa9c6Md2z20k
         iZmVY92z2AOilczo6f5ZeOVebu9gRgbQ7GMpamfsCor3gjISWJ9r4cxU1/qN4sm76M6C
         s9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751617; x=1753356417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mamQmxuSC1gLOH8NTWGobgALudQdb1hsjmYCRHW0pFo=;
        b=bGAo4cZXJW9h22JnP7P35tKYEP8rEzXH8eaWq+n+XzJtAgF5PMJJE0XXMHDNy32ZSC
         5j0HWlZHH33APMTk638ihWGIMom986nOlgGWE2gaNeYni2i97mSO5ssCprya/0mk94yG
         UNKFEnHn+X3TkN0Ja8M4wfMRq/hO2yxNy/LK1A1Wue60EKpvNdXxxTOJHXCjylqxE4/x
         RCV6CQ/B0rw48nI05tFxGYes32V/dKgZKpSFo7cAbqFCy5PEDyZ4OmqnXQEvAp4lAoTX
         CDsISK8URyofQ6pbT/OF4o9y4AYLc+h1vqgxl8UqpkH4oNbY1NlQyHPiImxL13x5aG9x
         zlAg==
X-Forwarded-Encrypted: i=1; AJvYcCWYMnPcwXiITM/Yh4Wvxi6hWtwaZFpUuHU31S7odDLLc/OEP5dXJzG/27zNQIKKkxkSeFZ3@vger.kernel.org, AJvYcCXK2nBmco8ksTvRBzvP60rJVqOeRSWVxPvi+nIEE/sn/ocMTKAoeddCP4eLIXrbMrEVWFIkDF5dcev2sw==@vger.kernel.org, AJvYcCXrKfuYKFyhaKphZ9cY1Gs2xhL/19y8cADwtU0/pk9c6r2MxFHUCSlPHzvyLw4O9mFO6Sw=@vger.kernel.org, AJvYcCXxtIEryRAnRt08/WW6fObKubXP8VHUADPFvpqHxoiBrAu4lnTr84ZO8e563zM+p8fJjnMqXjsz17ka@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PX5fkihaoGHnI6xvZU2Tagw3Dqt5z0cLbgmmY2aoExlRwaLN
	qS9iEtD7U8jMSMOvpqCHTcR7HZfS5K7gprwoOeZKnjvIA5qQ8GXht6fH
X-Gm-Gg: ASbGncspYywC1NR4BR6V4E9dDLaFr8+qJheCAW3stLs2hpVLOErmQAfj41yZexbTRFP
	iBohiSgqJXWM96D6N1Zupk0D7w0KCWNf3+JBzcEtERQ1IoqRmZZBtplD9DF20HGP6I2gCmSAbAg
	WzEhpThefhIdVSD9g+UcYE7fRV7cEXk1EwtDs+vXfOVg9PKQEM/YEfP4OTNaWpc+Y8X1ZBkdrc1
	r63nIwQd0d2Y0YGCavmFBTGZQ/08DmfsRPB68KByDOWVXKxlwI0rlPpECe2mXGonkq312MsFCBQ
	vGXzNbaLytY44bunnxg+WgCPiSN+BHn0/Ki0Vg+M8NyGtk8loXulRat4Vu2Tc/PL+gBveLmsUtv
	NtO4zuMBOyzPyfDuOQZBUZ+KAtaZP7/0m
X-Google-Smtp-Source: AGHT+IHgByp/+dn0A3OWrLhB0GDZBc03RDMuL7JkWfT26AK/PVvD8T61v8pd5crnp3FDaRyCdZGR6g==
X-Received: by 2002:a17:90b:28cc:b0:311:b0d3:865 with SMTP id 98e67ed59e1d1-31c9e7931a3mr7920094a91.32.1752751617130;
        Thu, 17 Jul 2025 04:26:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7c3729sm1361493a91.18.2025.07.17.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:26:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DFA1D420A819; Thu, 17 Jul 2025 18:26:50 +0700 (WIB)
Date: Thu, 17 Jul 2025 18:26:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>,
	Linux CPU Architectures Development <linux-arch@vger.kernel.org>,
	Linux LKMM <lkmm@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Dan Williams <dan.j.williams@intel.com>, Xavier <xavier_qy@163.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/4] Convert atomic_*.txt and memory-barriers.txt to reST
Message-ID: <aHjd-oisajaKW_Z5@archie.me>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
 <20250717105554.GA1479557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JBAf7wDkA/Ps+xxf"
Content-Disposition: inline
In-Reply-To: <20250717105554.GA1479557@noisy.programming.kicks-ass.net>


--JBAf7wDkA/Ps+xxf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:55:54PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 17, 2025 at 03:06:13PM +0700, Bagas Sanjaya wrote:
> > Bagas Sanjaya (4):
> >   Documentation: memory-barriers: Convert to reST format
> >   Documentation: atomic_bitops: Convert to reST format
> >   Documentation: atomic_t: Convert to reST format
> >   Documentation: atomic_bitops, atomic_t, memory-barriers: Link to
> >     newly-converted docs
>=20
> NAK
>=20
> If these are merged I will no longer touch / update these files.

Why? Do you mean these docs should be kept as-is (not converted)? Jon wrote
in e40573a43d163a that the conversion were opposed but AFAIK I can't find
the rationale on lore.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--JBAf7wDkA/Ps+xxf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaHjd9QAKCRD2uYlJVVFO
o5gTAP9lBzNcAUcWTLaW0MwlnQrRBczAAM2O5+rQWHZiuprqawD9ETZgMoUlvAOY
cmL08HFZ09BvD9UIA2iITCiObHR22QA=
=vYMt
-----END PGP SIGNATURE-----

--JBAf7wDkA/Ps+xxf--

