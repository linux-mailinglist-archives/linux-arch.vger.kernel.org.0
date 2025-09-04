Return-Path: <linux-arch+bounces-13383-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4350CB442DD
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D551CC2BBC
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8F23B63E;
	Thu,  4 Sep 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Yd28Riq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gyQgnZDP"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4003227B95;
	Thu,  4 Sep 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003649; cv=none; b=KCpWWuJxgjpmwWhj+5+CmSDv2BbgQiQufm90nPGmNi+/1F85XKZ26GiqN30OylLKqeKlrspq+uGEy17YwpcPADEcaofKZc+MZFXxGhOA02gkecUbNGTY3QlZsHJ5Tbq6bFwbKgozF1WHbRB4rKTf5uW1t15Gg/sNShGIhHQ2QsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003649; c=relaxed/simple;
	bh=R0pVTuR8XFFiwekf2xW7l1I3HsrVSJeQPTqpqy9L/ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHJ8VfSa3OAKdgyBKuVunuAN40crM+gEb9sSnmh4rfvnkY+4RAfzVfTaTWN44lWZB6mForS+Sgo6Ohp8TKV0OPfZP9nAP7Kt07XAZSLdIicDiATrcyqFkBAclgcNs3dtY6wVk7AQY0sZD1e2ZSE9sc03mBJxkzzusrVZiehIjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Yd28Riq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gyQgnZDP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Sep 2025 18:34:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757003645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DW7QyjKsD9gIIEK+oSA7dQswnR3XHOcfWwnzN8KOPYk=;
	b=2Yd28RiqUIFzCyYc6w5y4Pym9ms4H9Y9d3vObwIJIajcLz/DH+fHqqeRplaLhmg5CzPLlt
	6oZfmi7jCELcB8yfINLOVhOWQSYTSIXnW+MDNeoCSx25Fb8KFnGj0sgXMwwcI0zmsDq3Zz
	sOG3UXsjrqi8y5cNxKelQ9GsSNkEOMT3HSqnWYaBezmCzOdEJVzaCChnrXCe368i+l1Lph
	Vr5/C35slS5vrsCIpWPmJZMtlLSSfz/IL6956u1p+2xsn+N8nrnpncTnZLB12aj6Z5nwNU
	V/WoC7IiIiwM9pv0B0XkfPsVkH9yN5pnaE9J+vqWer3vsxhNGZPzTQqdnr9E6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757003645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DW7QyjKsD9gIIEK+oSA7dQswnR3XHOcfWwnzN8KOPYk=;
	b=gyQgnZDPrf3XGflAFShZR/O2EF8Ty4cZR7lJVnmV8T7BXm5czpXo0+TerGDssTh9Wgljqr
	mNC9cgOoVEYI4YAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Matthias Klose <doko@debian.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Binutils <binutils@sourceware.org>
Subject: Re: [RFC] Don't create sframes during build
Message-ID: <20250904163404.QMU7nfbA@linutronix.de>
References: <20250904131835.sfcG19NV@linutronix.de>
 <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>

On 2025-09-04 16:02:42 [+0200], Matthias Klose wrote:
> [ CCing binutils@sourceware.org ]
>=20
> On 9/4/25 15:18, Sebastian Andrzej Siewior wrote:
> > Hi,
> >=20
> > gcc in Debian, starting with 15.2.0-2, 14.3.0-6 enables sframe
> > generation. Unless options like -ffreestanding are passed. Since this
> > isn't done, there are a few warnings during compile
>=20
> If there are other options when sframe shouldn't be enabled, please tell.

No, I think this is okay.

=E2=80=A6
> > We could drop the sframe during the final link but this does not get rid
> > of the objtool warnings so we would have to ignore them. But we don't
> > need it. So what about the following:
> >=20
> > diff --git a/Makefile b/Makefile
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -886,6 +886,8 @@ ifdef CONFIG_CC_IS_GCC
> >   KBUILD_CFLAGS	+=3D $(call cc-option,--param=3Dallow-store-data-races=
=3D0)
> >   KBUILD_CFLAGS	+=3D $(call cc-option,-fno-allow-store-data-races)
> >   endif
> > +# No sframe generation for kernel if enabled by default
> > +KBUILD_CFLAGS	+=3D $(call cc-option,-Xassembler --gsframe=3Dno)
> >   ifdef CONFIG_READABLE_ASM
> >   # Disable optimizations that make assembler listings hard to read.
> This is what I chose for package builds that need disablement of sframe.

I think this would work for now. Longterm we would have to allow sframe
creation and keep section if an architecture decides to use it for its
backtracing. While orc seems fine on x86, there are arm64 patches to use
for as a stack unwinder.

Sebastian

