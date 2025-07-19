Return-Path: <linux-arch+bounces-12871-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6336AB0AE54
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 09:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8807A1956
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 07:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133D22DFB8;
	Sat, 19 Jul 2025 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN4uofE8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4261C84AE;
	Sat, 19 Jul 2025 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908928; cv=none; b=WgpTXrhOgo/5yWv5MAeJWzAAzrh6sf3LKJsWYgAGUyuf51pUQT3DxyqtHqcCHbmJUUuKqGfL18aoKSW9gik1HoskayumnnuDJbLXOW7HJFuTv8PplKMZ6Dz8D1Ll/7/+hAcZ1PxTzNgNQ36p2Y2AX0YSi18WGCBswBTfyhsMlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908928; c=relaxed/simple;
	bh=vufT61B0JmqwAIxP7VPqMs0HC4W5rnfofR5tYibjGiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuepfvtDx32JoxNpqspd/m5q2xPTwQdONgHoWXkla9/qKcHGxihOQ/dn23IzI+hhVnWC6+nlcsX/Dp0SHC/CyMbzKBP0GfYmPdXIIFQci05F43rIIccOwZcOY0AiGhfF/o0rTiENpl6CifP218MYqjfLVXEAkhr42XGSVJHF+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN4uofE8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so5874643a12.1;
        Sat, 19 Jul 2025 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752908925; x=1753513725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UT5HypfoUTQWMwocYzVj5Hl5OahvJzyO3VxVcUyzP0k=;
        b=aN4uofE8GRR5bClzmAAzfAjJ4IqoFNwk87Zd16hCDrK+TeQI+TfCOVOXoyW+kw0Dtd
         wXckNn0WFttAPxJ1QZm+Gle//IrUPGWUXJ2qYyjx8Elp2XVTEsH+Tr65BeDFM1hoHc0j
         a78mMUh4+TpZQR/hHY1uXANngzUH+820wZiPr1gcwdo82FVUEVjxhveoh6VoB2q3vNaz
         IgQL0tpJEFHzN48yKpqiwYN/AJPg6byjS02k6Ryw6QGJHXgYOcJzK3O/5qoLvusQlwPz
         jkLG1LJ0jmOx5Lu+nl9kTrLnhjf/piLLKwwyINDg4yrdHYPI8CHvcfJC7ledNgt/f/Xz
         vCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752908925; x=1753513725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT5HypfoUTQWMwocYzVj5Hl5OahvJzyO3VxVcUyzP0k=;
        b=o3skrOENsRZATVyPmI/7TmtC9uuHI+VLteEw7Rd+APQRRWjI+vXcWqe3oktNkIAP0z
         waYnJ+Q+4zQKwWIz/BN3VuSqfnBbU2m9Mr6wtVOS5shXiOe/3wg50H3A3ZwCv5vXAbjw
         YkwYZ/pAORdZyVmaWPDSBUaH0D992ak06y/A9w5s/CHr7QutjziA38Z6gEtnVf4qyuvY
         +PE1s6Ak9dl+Q37ruStNRFjm4jg83aHQiVzF4qfMTcAWV9UKKqufbCNf+tlOW9Xdk8S1
         FfCXOrfsCZ51NdLy9WEo1GishpL0ZvaUIzXx5JtdtJWTqfMWwNCnAKandXVjnCrNpDD/
         pxcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0x8SY/PlcfTq4MArPY49h6N9n7QhucmIgYiwTyQqEEppNdWfzhH8XM8sHQccJX6+4vsCJ@vger.kernel.org, AJvYcCVP8xQ0/l7NlHuzn/Tm9IFT0WePBJf+JBjBKuhdfWToWiu6IenaJrpz34ZPic79PaPRKjajfJN0W+TctQ==@vger.kernel.org, AJvYcCWGHQxmXXdYvNpimdN27ndINoZ8bYOcx+wuYvpur0jZokL5tLlVAJ0IOMozJBm6YtX2xwT2FyYFBsVO@vger.kernel.org, AJvYcCXzNKLlnaCfkVCDLv9o/tYI5xtI5cyZ1hGQPBMN89TVzMA+eI4Bp4ySvko0q0ten58LYF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAi1zLGwQhWdE+v/nrhVN1DXlJclOVaOdFrbM+GQdg/UmxDPfA
	oEe6k7Jue5vqVGSUSJxJuL18g1iiLhzmZb3CpX5lq2F+JZYcvC3I1/FB
X-Gm-Gg: ASbGncvMD7c5NnZCSj90clcPAR9eBptiiwGw02W1Snn27NK8xDfdV2pKyKYHPnGVC45
	37P4lB7egpRLJSPyuDeFS2KHFC1sz9uFKpDSisNCkwgCRZESNmXtkhSt3KfdYVZ/U5vdzBI+4uo
	BA1yldR1EyIAx6DVGCcAfiof+P2NL91VWbrA07AlO6Mz1hMKYHACm6K+vaVmrh1H8CDj4PMOkMk
	P2Up39Iw/FVmwN1SOTs+m4mq3BqyQp/bWNFaJ1DKgcGjEeU5Y/hGDz4B0ajzqX3yfC6AcclYBw0
	uF2VAoXJ+kFV6WHJn4aHiptYqMBrh16Jy/AAfjPOuZtMz6E7mYHKFv4cHFN19hiZnDfYZCSJ6HY
	BWrK2Yse66duK+1W5vUw23A==
X-Google-Smtp-Source: AGHT+IFThgtoJuSP5FXWdNpEpQ5czog6sgr2fMyqs2egrXeD+Pi/tn7lPVEjYiDM63dPY9Wul0I/mA==
X-Received: by 2002:a17:907:7208:b0:ad5:8412:1c9 with SMTP id a640c23a62f3a-aec6a674779mr480258166b.59.1752908924588;
        Sat, 19 Jul 2025 00:08:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8357sm253986566b.52.2025.07.19.00.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 00:08:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 87B73423BF32; Sat, 19 Jul 2025 14:08:38 +0700 (WIB)
Date: Sat, 19 Jul 2025 14:08:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aHtEdoj_qgpq9NNa@archie.me>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
 <20250717105554.GA1479557@noisy.programming.kicks-ass.net>
 <aHjd-oisajaKW_Z5@archie.me>
 <65735554-0420-4af7-881d-5243b83a3eb6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gLgncKtdrrHipxb"
Content-Disposition: inline
In-Reply-To: <65735554-0420-4af7-881d-5243b83a3eb6@oracle.com>


--2gLgncKtdrrHipxb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 01:56:12PM +0200, Vegard Nossum wrote:
> On 17/07/2025 13:26, Bagas Sanjaya wrote:
> > On Thu, Jul 17, 2025 at 12:55:54PM +0200, Peter Zijlstra wrote:
> > > On Thu, Jul 17, 2025 at 03:06:13PM +0700, Bagas Sanjaya wrote:
> > > > Bagas Sanjaya (4):
> > > >    Documentation: memory-barriers: Convert to reST format
> > > >    Documentation: atomic_bitops: Convert to reST format
> > > >    Documentation: atomic_t: Convert to reST format
> > > >    Documentation: atomic_bitops, atomic_t, memory-barriers: Link to
> > > >      newly-converted docs
> > >=20
> > > NAK
> > >=20
> > > If these are merged I will no longer touch / update these files.
> >=20
> > Why? Do you mean these docs should be kept as-is (not converted)? Jon w=
rote
> > in e40573a43d163a that the conversion were opposed but AFAIK I can't fi=
nd
> > the rationale on lore.
>=20
> Here's one:
>=20
> https://lore.kernel.org/all/20200806064823.GA7292@infradead.org/

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--2gLgncKtdrrHipxb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaHtEawAKCRD2uYlJVVFO
o1DEAQDTgA9l2rIBDAihhUg5LQsrzUGjdyEsn0EUAnvE5VwB3gEAorEAChqX8FzC
FkHus6Bb8Vr43ZFqoi0M5HJt4JCX5Qg=
=jzZz
-----END PGP SIGNATURE-----

--2gLgncKtdrrHipxb--

