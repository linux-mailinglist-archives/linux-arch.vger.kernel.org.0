Return-Path: <linux-arch+bounces-13897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEFABB688D
	for <lists+linux-arch@lfdr.de>; Fri, 03 Oct 2025 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45131483903
	for <lists+linux-arch@lfdr.de>; Fri,  3 Oct 2025 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D672EB86F;
	Fri,  3 Oct 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFzKRkRA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32527EC99;
	Fri,  3 Oct 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491220; cv=none; b=PCztNRJGzLy2NUIwoOLg01XTAv1rbIGtDCFvul92yK6tjt/e/7ISwWFbyIuZ3Hm2wbhaLHb4iw/iUSAM6+dpiBgDy4/XAtwTu8xB/TlXnVZBpBKAwnt1Kdqvyfom2wYNdRZVmJjtYGLM+T/nqwiCbvLWc9L2FDYE5CZ4QcU8ZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491220; c=relaxed/simple;
	bh=8JvzZz+MrzjUmB/qmn12k1T1z8wI8NEqkWeYCArS4nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnZaFvAfyHdSfOhsi4zZO7HXEiqZ2z5JEhvwYIXKpeLTEPPEEXgkjdhswYZbOoRbbG0vI7lh5oUb3Wn3ol2puwzP7WwkfmmBQ7/Z9owv59PQsYgiqxh96PhXpd/qfsP+fv5K7qaVIPp8zPLV9dnq3BdpJfG1p+aibtaQLoNdFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFzKRkRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B48C4CEF5;
	Fri,  3 Oct 2025 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759491219;
	bh=8JvzZz+MrzjUmB/qmn12k1T1z8wI8NEqkWeYCArS4nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFzKRkRAagp0TVhUdTwIsW0EPgf7xwe5vUnZsgItAsbqWLbYcv7v2Q3oCdo6pdbpH
	 TxK4cHFxGzDDbQDQTmmTAALXtRce7awXslf/w51ZRllOlHQfykkv/S85tSAEJm9jFJ
	 GYwvA6uugwAlC/eFWM7ehADw13/t37TYV5luOUQD7lDrfqGG54YTKnaTyEWvTdRb0c
	 orc+Nn8y24EKqDs+XjojdkthXLkOB/CpwUkMKq+3hkvcz1Knd27dZO22vw3HIZH/oz
	 KeJJqGDMye/t+diEqfyZzsugo6eKkklnr+1Zd5LuUfHG/pa69kR/h1070kPLMeXwGn
	 kaCdIbmTIMmYw==
Date: Fri, 3 Oct 2025 12:33:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
	tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
	sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
	ngupta@vflare.org, linux-block@vger.kernel.org,
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
	djwong@kernel.org, dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
	hamohammed.sa@gmail.com, harry.yoo@oracle.com,
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com, boqun.feng@gmail.com,
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
	yeoreum.yun@arm.com, netdev@vger.kernel.org,
	matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net,
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, luto@kernel.org,
	sumit.semwal@linaro.org, gustavo@padovan.org,
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, mark.rutland@arm.com, ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com, wangkefeng.wang@huawei.com,
	kevin.brodsky@arm.com, dwmw@amazon.co.uk, shakeel.butt@linux.dev,
	ast@kernel.org, ziy@nvidia.com, yuzhao@google.com,
	baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
	joel.granados@kernel.org, richard.weiyang@gmail.com,
	geert+renesas@glider.be, tim.c.chen@linux.intel.com,
	linux@treblig.org, alexander.shishkin@linux.intel.com,
	lillian@star-ark.net, chenhuacai@kernel.org, francesco@valla.it,
	guoweikang.kernel@gmail.com, link@vivo.com, jpoimboe@kernel.org,
	masahiroy@kernel.org, brauner@kernel.org,
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com,
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 09/47] arm64, dept: add support
 CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64
Message-ID: <b69ab7d0-ba5e-4d22-88ef-53e0ebf07869@sirena.org.uk>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-10-byungchul@sk.com>
 <a7f41101-d80a-4cee-ada5-9c591321b1d7@sirena.org.uk>
 <20251003014641.GF75385@system.software.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CPEOfhRT6FsWLRqF"
Content-Disposition: inline
In-Reply-To: <20251003014641.GF75385@system.software.com>
X-Cookie: hangover, n.:


--CPEOfhRT6FsWLRqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 10:46:41AM +0900, Byungchul Park wrote:
> On Thu, Oct 02, 2025 at 12:39:31PM +0100, Mark Brown wrote:
> > On Thu, Oct 02, 2025 at 05:12:09PM +0900, Byungchul Park wrote:
> > > dept needs to notice every entrance from user to kernel mode to treat
> > > every kernel context independently when tracking wait-event dependenc=
ies.
> > > Roughly, system call and user oriented fault are the cases.

> > > Make dept aware of the entrances of arm64 and add support
> > > CONFIG_ARCH_HAS_DEPT_SUPPORT to arm64.

> > The description of what needs to be tracked probably needs some
> > tightening up here, it's not clear to me for example why exceptions for
> > mops or the vector extensions aren't included here, or what the
> > distinction is with error faults like BTI or GCS not being tracked?

> Thanks for the feedback but I'm afraid I don't get you.  Can you explain
> in more detail with example?

Your commit log says we need to track every entrance from user mode to
kernel mode but the code only adds tracking to syscalls and some memory
faults.  The exception types listed above (and some others) also result
in entries to the kernel from userspace.

> JFYI, pairs of wait and its event need to be tracked to see if each
> event can be prevented from being reachable by other waits like:

>    context X				context Y
>=20
>    lock L
>    ...
>    initiate event A context		start toward event A
>    ...					...
>    wait A // wait for event A and	lock L // wait for unlock L and
>           // prevent unlock L		       // prevent event A
>    ...					...
>    unlock L				unlock L
> 					...
> 					event A

> I meant things like this need to be tracked.

I don't think that's at all clear from the above context, and the
handling for some of the above exception types (eg, the vector
extensions) includes taking locks.

--CPEOfhRT6FsWLRqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjftG4ACgkQJNaLcl1U
h9AJAwf9GUZ8nquWa7D1no47c5NWSm5cMwwvmTjDaPtYC52seNgxT47rqiAa032b
rbQuOcdIvbMOoRrk3oOjch4rbo2VSgw1bzxKncoUyWrQ1rw9rhdfmdQpZZSbT1XQ
ZE3VcLNDV3bfjO2GU8cTjiUDwM29qIeTSzCIn9ubfHcuEvoaYes1/BrQYAwB6ghQ
7LjwZANFGJdatftOLPlVL8kKM/B5H6eSUlr8bUS9hlZE2g39/1LLb9UexVvnMj8u
6gPRXHiHF5Vzad2FqVmWKt4F1F39CJ4g1c624zJiIGAWP9iBONB8dIyQPlTmK4U7
mnXQy7USXtlxU+Xw5RCO9fy5x0Ahxw==
=LMdg
-----END PGP SIGNATURE-----

--CPEOfhRT6FsWLRqF--

