Return-Path: <linux-arch+bounces-812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E41F580AC1F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 19:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9915D1F21223
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51284CB3D;
	Fri,  8 Dec 2023 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T8fPULZ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C9118;
	Fri,  8 Dec 2023 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iqgkejpa/rkBjVNHaS0A5K5PJBwcgcqylwReeoFCRMk=; b=T8fPULZ5vJHN49SgmCJX6fdWHu
	K2+z2sIwrEFOU7FxzoPXvlYTiVfVy/1kf0iqenNn+9+iFZtFhNYTldLX4Rr+NQ/HRQs4KWCwkossM
	Sc/dQJmTG6XvnTRHyU/gq4AnzkLGN0Avu0Di1LdozAE2/fG4QmSKzbGdau55xtyTEINys4KWTf2vB
	pGuVJ4uO49mMYJFsmlRnLCFJzYNBrGbaFa3GIhzxGl9ZZ/Y1+jCzll9OZJ+1Buc2kiuBss55jwjx2
	w/4+Hi3Jek0qA6w9PIuLzevHiFoNU9Yayvv1wbQJpivKSAE7ivt+SznrVQCd7cLDLlgxfBLEeYhhP
	xuZC4PGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rBfgr-0091iZ-2K;
	Fri, 08 Dec 2023 18:35:09 +0000
Date: Fri, 8 Dec 2023 18:35:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	gus Gusenleitner Klaus <gus@keba.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCHES v2] checksum stuff
Message-ID: <20231208183509.GC1674809@ZenIV>
References: <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
 <20231206224359.GR1674809@ZenIV>
 <46711b57a62348059cfe798c8acea941@AcuMS.aculab.com>
 <20231208141712.GA1674809@ZenIV>
 <ce18effbe40c47bfb48f87e7ee4f8141@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce18effbe40c47bfb48f87e7ee4f8141@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 08, 2023 at 03:56:27PM +0000, David Laight wrote:

> > You add them as natural numbers.  If there is no carry and result
> > fits into N bits, that's it.  If there is carry, you add it to
> > the lower N bits of sum.
> > 
> > Discussion of properties of that operation is present e.g. in
> > RFC1071, titled "Computing the Internet Checksum".
> > 
> > May I politely suggest that some basic understanding of the
> > arithmetics involved might be useful for this discussion?
> 
> Well 0x0000 is +0 and 0xffff is -0, mathematically they are (mostly)
> equal.

As representations of signed integers they are.  However, the origin
of operation in question is irrelevant.  Again, read the fucking RFC.

> I bet that ICMP response (with id == 0 and seq == 0) is the only
> place it is possible to get an ip-checksum of a zero buffer.
> So it will be pretty moot for copy+checksum with can return 0xffff
> (or lots of other values) for an all-zero buffer.

Egads...  Your bets are your business; you *still* have not bothered
to look at the callers of these primitives.  Given the accuracy of
your guesses so far, pardon me for treating any "I bet"/"it stands for
reason"/etc. coming from you as empty handwaving.

> In terms of copy+checksum returning an error, why not reduce the
> 32bit wcsum once (to 17 bits) and return -1 (or ~0u) on error?
> Much simpler than your patch and it won't have the lurking problem
> of the result being assigned to a 32bit variable.

In case you have somehow missed it, quite a few of the affected places
are in assembler.  The same would apply to added code that would do
this reduction.  Which is going to be considerably less trivial than
the changes done in that patch.

