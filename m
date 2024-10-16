Return-Path: <linux-arch+bounces-8234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88B9A0C46
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DC7B21836
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA5420ADEA;
	Wed, 16 Oct 2024 14:10:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236DB1DAC9C;
	Wed, 16 Oct 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087806; cv=none; b=KMm5RM2luqr9obedx+vjRsIi4zhhIy1qKlOc6fWgh6RQf0OjfKZ/icLnoGRMszw0jplOR20Ve4OojeWZ4Yjup/s+d1e/j9MwdT0vf7Ynz8zMGfG/H29IYSd6V9MpxOhQvObI+wQyBZDT9zXuX6lkjDEYLbeYYzWTQcHGscL8I+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087806; c=relaxed/simple;
	bh=X/tEEDsGfLTMHjhr3LF9eAdGJNQDfr/bv5t1Y7vkSEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SegBlVgCTV2oZA0o2flGosFWHAwr7ro1VDu4u6iNNKDKVX2jXpyDGi2OfavydIqGF3rhEEFcCpEZp58+vchD9uFsgI0S9SVXrgLOX3armpLAJywi3Vjd6o7i9Vh4lwoQ4rfO3vDtoMtNz0cJdu+gypNmosJyVpQhhCF/Jr0gDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57F4C4CEC5;
	Wed, 16 Oct 2024 14:10:01 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:10:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <20241016101022.185f741b@gandalf.local.home>
In-Reply-To: <yt9ded4gfdz0.fsf@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2024 14:07:31 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> > +/* Return reserved data size in words */
> > +static inline int decode_fprobe_header(unsigned long val, struct fprob=
e **fp)
> > +{
> > +	unsigned long ptr;
> > +
> > +	ptr =3D (val & FPROBE_HEADER_PTR_MASK) | ~FPROBE_HEADER_PTR_MASK;
> > +	if (fp)
> > +		*fp =3D (struct fprobe *)ptr;
> > +	return val >> FPROBE_HEADER_PTR_BITS;
> > +} =20
>=20
> I think that still has the issue that the size is encoded in the
> leftmost fields of the pointer, which doesn't work on all
> architectures. I reported this already in v15
> (https://lore.kernel.org/all/yt9dmsjyx067.fsf@linux.ibm.com/)

=46rom what you said in v15:

> I haven't yet fully understood why this logic is needed, but the
> WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
> has the upper bits of the address set on x86 (and likely others). As an
> example, in my test setup, fp is 0x8feec218 on s390, while it is
> 0xffff888100add118 in x86-kvm.

Since we only need to save 4 bits for size, we could have what it is
replacing always be zero or always be f, depending on the arch. The
question then is, is s390's 4 MSBs always zero?

Thus we could make it be:

static inline int decode_fprobe_header(unsigned long val, struct fprobe **f=
p)
{
	unsigned long ptr;

	ptr =3D (val & FPROBE_HEADER_PTR_MASK) | FPROBE_HEADER_MSB_MASK;
	if (fp)
		*fp =3D (struct fprobe *)ptr;
	return val >> FPROBE_HEADER_PTR_BITS;
}

And define FPROBE_HEADER_MSB_MASK to be either:

For most archs:

#define FPROBE_HEADER_MSB_MASK	(0xf << FPROBE_HEADER_PTR_BITS)

or on s390:

#define FPROBE_HEADER_MSB_MASK	(0x0)

Would this work?

-- Steve

