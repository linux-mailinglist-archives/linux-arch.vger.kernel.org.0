Return-Path: <linux-arch+bounces-799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B172180A53F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 15:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C35C28180F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EA1D546;
	Fri,  8 Dec 2023 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="skVoQXrk"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAF171D;
	Fri,  8 Dec 2023 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8lkpDrAVThUsmxNqiVZSV0lvTancyxHoyRE7xBofZjI=; b=skVoQXrkyyUv354Yat2EuGTJD1
	RhNsG3cttkbJH1Ktss/uTn03jI2GZOVLQRd2QfXlw/Vpe3boICyboJxkO19/LfDzJbd/EIqWtiz+H
	a0Evfy4l3ZD+Fwg8fgxTQy9wWjxi7ZjfDTEQ4tLh3y6fkLFol9FrUNMt2t314ptOP1cO8yWgmPfRc
	MQQ1RrXIqBx9e5y2rpIrqlXoPqzAJ8C+7U24B6zYyow/JFigdy0Sebs3fe32+t1UdyUg6B+8X5yJ7
	cSs4r908dmbi/Op7mAo5p2wpR+KvZk66BKoMzIrTR8Bh9Pl66KfRhOa7H1QXCav4kyrLUjq7JH0u8
	8XIRRkzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rBbfE-008u9e-18;
	Fri, 08 Dec 2023 14:17:12 +0000
Date: Fri, 8 Dec 2023 14:17:12 +0000
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
Message-ID: <20231208141712.GA1674809@ZenIV>
References: <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
 <20231206224359.GR1674809@ZenIV>
 <46711b57a62348059cfe798c8acea941@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46711b57a62348059cfe798c8acea941@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 08, 2023 at 12:04:24PM +0000, David Laight wrote:
> I've just read RFC 792 and done some experiments.
> The kernel ICMP checksum code is just plain broken.
> 
> RFC 792 is quite clear that the checksum is the 16-bit ones's
> complement of the one's complement sum of the ICMP message
> starting with the ICMP Type.
> 
> The one's complement sum of 0xfffe and 0x0001 is zero (not the 0xffff

It is not.  FYI, N-bit one's complement sum is defined as

X + Y <= MAX_N_BIT ? X + Y : X + Y - MAX_N_BIT,

where MAX_N_BIT is 2^N - 1.

You add them as natural numbers.  If there is no carry and result
fits into N bits, that's it.  If there is carry, you add it to
the lower N bits of sum.

Discussion of properties of that operation is present e.g. in
RFC1071, titled "Computing the Internet Checksum".

May I politely suggest that some basic understanding of the
arithmetics involved might be useful for this discussion?

