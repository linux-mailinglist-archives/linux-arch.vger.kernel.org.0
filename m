Return-Path: <linux-arch+bounces-800-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9C80A766
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469971C20503
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4A3035C;
	Fri,  8 Dec 2023 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A7AsbWlP"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D6FB;
	Fri,  8 Dec 2023 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zys2RTvczhHBrTilI40fr1weYiUwJQ9jBZynoNtrbro=; b=A7AsbWlPHxXQuLZcVgdzdcgsCq
	Y/uiZuV7gP6bvdnUaEsdtkwIgNjhyuu02fcT//c4pnl4MeS/r+Mm/PDUGhhus/EuoDCAeLPvFpK5s
	Tw+qMxHxrDr3Th8nUVj/gCpINgflX6CWbhc/jFZBFETBT2Q+uJdlIru/CtlacS2a+8ul+p8DOhd4P
	v6km0MPmNvFExOmqDKge9HyAnO+u33zS5nAHz+N83SKdo49Gb8JJ4KfHlNFM7fz5fnVCfXkeIEPbs
	LXfqKLMYmLGLctp4U/k+XPBATy10kNBMxYVFu+VFjnST2raLHBaemEfP8CTH8whxx6Wf9JSG+KPTv
	/A4WmzXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rBcmu-008w3V-2p;
	Fri, 08 Dec 2023 15:29:12 +0000
Date: Fri, 8 Dec 2023 15:29:12 +0000
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
Message-ID: <20231208152912.GB1674809@ZenIV>
References: <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
 <20231206224359.GR1674809@ZenIV>
 <46711b57a62348059cfe798c8acea941@AcuMS.aculab.com>
 <20231208141712.GA1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208141712.GA1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 08, 2023 at 02:17:12PM +0000, Al Viro wrote:
> On Fri, Dec 08, 2023 at 12:04:24PM +0000, David Laight wrote:
> > I've just read RFC 792 and done some experiments.
> > The kernel ICMP checksum code is just plain broken.
> > 
> > RFC 792 is quite clear that the checksum is the 16-bit ones's
> > complement of the one's complement sum of the ICMP message
> > starting with the ICMP Type.
> > 
> > The one's complement sum of 0xfffe and 0x0001 is zero (not the 0xffff
> 
> It is not.  FYI, N-bit one's complement sum is defined as
> 
> X + Y <= MAX_N_BIT ? X + Y : X + Y - MAX_N_BIT,
> 
> where MAX_N_BIT is 2^N - 1.
> 
> You add them as natural numbers.  If there is no carry and result
> fits into N bits, that's it.  If there is carry, you add it to
> the lower N bits of sum.
> 
> Discussion of properties of that operation is present e.g. in
> RFC1071, titled "Computing the Internet Checksum".
> 
> May I politely suggest that some basic understanding of the
> arithmetics involved might be useful for this discussion?

FWIW, "one's complement" in the name is due to the fact that this
operation is how one normally implements addition of integers in
one's complement representation.

The operation itself is on bit vectors - you take two N-bit vectors,
pad them with 0 on the left, add them as unsigned N+1-bit numbers,
then add the leftmost bit (carry) to the value in the remaining N bits.
Since the sum on the first step is no greater than 2^{N+1} - 2, the
result of the second addition will always fit into N bits.

If bit vectors <A> and <B> represent integers x and y with representable
sum (i.e. if 2^{N-1} > x + y > -2^{N-1}), then applying this operation will
produce a vector representing x + y.  In case when the sum allows
more than one representation (i.e. when x + y is 0), it is biased towards
negative zero - the only way to get positive zero is (+0) + (+0); in
particular, your example is (+1) + (-1) yielding (-0).

Your bit vectors are 1111111111111110 and 0000000000000001; padding gives
01111111111111110 and 00000000000000001; the first addition - 01111111111111111,
so the carry bit is 0 and result is the lower 16 bits, i.e. 1111111111111111.

Had the second argument been 0000000000000011 (+3), you would get
10000000000000001 from adding padded vectors, with carry bit being
1.  So the result would be 1 + 0000000000000001, i.e. 0000000000000010
((+2), from adding (-1) and (+3)).

References to 1's complement integers aside, the operation above is
what is used as basis for checksum calculations.  Reasons and
properties are dealt with in IEN 45 (older than RFC 791/792 - TCP
design is older than IP, and that's where the choice of checksum had
been originally dealt with) and in RFC 1071 (which includes
IEN 45 as appendix, noting that it has not been widely available).

