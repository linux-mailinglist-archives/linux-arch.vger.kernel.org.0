Return-Path: <linux-arch+bounces-15862-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C77D3A5F4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3121B300F70A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D7306486;
	Mon, 19 Jan 2026 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBtopyHM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u7K9TASj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E501EE00A;
	Mon, 19 Jan 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820196; cv=none; b=Yrc2ZaboMfFlvWxPuvJIYBkYQdad0708mtl42kjv9ydZ1nY7th1fLjabKxg0UCUB2VT2l/Qz/8r7WgNdSX1tiuWGcLSDP3B5o5Co5NdOK35wmH1WfVhY8mKE7LAysKs937hbL4k7aoZApg1dfOLP2aPAyz1nYeO2PCJib+938Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820196; c=relaxed/simple;
	bh=Qe36xxsayxzili9KvOuan72oG60zGsm7wCxbTI+pONE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCbIUKF+Thae1c8BLLGOucfyO1T+lTwJ2lknS2aO/BAscFY0kqiRswUkbESciGu9vAm7q9wiMguBCnDZpvTgc00wbbcr58sJBLEuCPSA5d4amhg3qx9EISFelduYpkG7F3p3uViVUHzjmEfC6B9P67dsAtFJGisNRw4b5H8wI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBtopyHM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u7K9TASj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 11:56:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768820193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US981aT1yOWgtxQBdKHnIdawJA/x+KBeaYSqijIuhE8=;
	b=nBtopyHMca4CWnNPtxDaHWzRTIdVDSukcOGB7SmXaZmQjoPjBpxFiiGScGdP4oufflGS79
	DXQ3alypPSNrp0K4OdjMOMyJLtDIt7pQj823TxvOt9KfIufPoYXmlIyPup8SQ2cymcIbp4
	tajj/QKjzQ8YBJDk+JBojjF1JO3Z3aIKLArD9nQ/UN1SmC+TM30LeUCOBiYPsmk4UKZS+d
	GWPatq1MOJJ4ZbFGUFpiV542DSUtxAmEMPJM7Swz+R5wUi/KGSggUCSsIF9xL0iJfYVww0
	BeTlfZUmSVU6+XeGdO33litM4b299u8wItMpIhuVO0cIjkE9Mx+Wg0i7RE9lAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768820193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US981aT1yOWgtxQBdKHnIdawJA/x+KBeaYSqijIuhE8=;
	b=u7K9TASj3v7TkS74Pata02ESy9TL0w6e4KlWv/yylOtf0M7czd+Lv9bGa46LYNgzsvKLKz
	jlEzqhxT6/Tny6Bw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <20260119100619.479bcff3@pumpkin>
 <20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
 <20260119103758.3afb5927@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119103758.3afb5927@pumpkin>

On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote:
> On Mon, 19 Jan 2026 11:13:08 +0100
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> wrote:
> 
> > On Mon, Jan 19, 2026 at 10:06:19AM +0000, David Laight wrote:
> > > On Fri, 16 Jan 2026 08:40:27 +0100
> > > Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de> wrote:
> > >   
> > > > The value of __BITS_PER_LONG from architecture-specific logic should
> > > > always match the generic one if that is available. It should also match
> > > > the actual C type 'long'.
> > > > 
> > > > Mismatches can happen for example when building the compat vDSO. Either
> > > > during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> > > > correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> > > > when mismatched CHECKFLAGS are inherited from the kernel build.
> > > > 
> > > > Add some consistency checks which detect such issues early and clearly.
> > > > The tests are added to the UAPI header to make sure it is also used when
> > > > building the vDSO as that is not supposed to use regular kernel headers.
> > > > 
> > > > The kernel-interal BITS_PER_LONG is not checked as it is derived from
> > > > CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> > > > deactivated check in include/asm-generic/bitsperlong.h.
> > > > 
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > ---
> > > >  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
> > > > index fadb3f857f28..9d762097ae0c 100644
> > > > --- a/include/uapi/asm-generic/bitsperlong.h
> > > > +++ b/include/uapi/asm-generic/bitsperlong.h
> > > > @@ -28,4 +28,18 @@
> > > >  #define __BITS_PER_LONG_LONG 64
> > > >  #endif
> > > >  
> > > > +/* Consistency checks */
> > > > +#ifdef __KERNEL__
> > > > +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> > > > +#if __BITS_PER_LONG != (__CHAR_BIT__ * __SIZEOF_LONG__)
> > > > +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> > > > +#endif
> > > > +#endif
> > > > +
> > > > +#ifndef __ASSEMBLER__
> > > > +_Static_assert(sizeof(long) * 8 == __BITS_PER_LONG,
> > > > +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");  
> > > 
> > > nak...
> > > 
> > > You can't assume the compiler has _Static_assert().
> > > All the ones that do probably define __SIZEOF_LONG__.
> > > You could use something 'old-school' like:
> > > typedef char __inconsistent_long_size[1 - 2 * (sizeof(long) * 8 != __BITS_PER_LONG))];  
> > 
> > This is only used when building the kernel, it never actually reaches
> > userspace. And all supported compilers for the kernel do have _Static_assert().
> > As indicated by other users of _Static_assert() we have elsewhere in the tree.
> 
> Don't you need a check that it isn't wrong on a user system?
> Which is what I thought it was doing.

Not really. The overrides defined by arch/*/include/uapi/asm/bitsperlong.h are
being tested here. If they work in the kernel build I assume they also work
in userspace.

> The earlier check can also just be:
> 
> #if defined(__SIZEOF_LONG__) && __BITS_PER_LONG != 8 * __SIZEOF_LONG__
> #error Inconsistent word size. Check uapi/asm/bitsperlong.h
> #endif

The if defined(__SIZEOF_LONG__) is also unnecessary as that is always present
with the supported kernel compilers.  So we can drop one level of ifdeffery.

Testing __CHAR_BIT__ == 8 would again test the compiler implementation and not
the UAPI headers, so I'd rather not do it. Using __CHAR_BIT__ in the test is
done for consistency with the generic implementation.


Thomas

