Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25897D4687
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 05:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJXD4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 23:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjJXDz5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 23:55:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FC30E9;
        Mon, 23 Oct 2023 20:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CVSXNcUpUTxl/nBT2LczxGdrQxY7bHQZW/3Wv9WHsEQ=; b=itlaKAC5qL9u6+/kbcFJg0RlPF
        c5++gmOs1K0IhWwICRlAgZy6LvNGvHRMkc7kJUDRaWVSwJOuRxLxBPTeKry1qLfQbwKJveIo8BurO
        DJCSIH6qXEwfXq1ZrcxALijEW6e+/EVRZG9IaeYmRx8ntD9JRMDtyQpxX5vcb0Atsmhu6b4T9RCc2
        ktUXFAxVyTGiDSjmn7gVeCkfmARMa0tA4X73zJjlMk9o3rO7T5QWYFdBO/wwvLfmWhNexrKGazUaw
        NVZhelf4Ud399ANIMhnT/Z/wha93UnbkFjiLBznW0Ptjnni9H4HdgbiBtU3V17Etws3tSoxMATVaM
        e/9l9Rmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qv8UI-004kZl-32;
        Tue, 24 Oct 2023 03:53:51 +0000
Date:   Tue, 24 Oct 2023 04:53:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC][PATCH] fix csum_and_copy_..._user() idiocy.  Re: AW:
 [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231024035350.GE800259@ZenIV>
References: <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
 <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
 <20231022194020.GA972254@ZenIV>
 <83a6e7e00f824f1daef01ad599aad663@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a6e7e00f824f1daef01ad599aad663@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 23, 2023 at 02:44:13PM +0000, David Laight wrote:
> From: Al Viro
> > Sent: 22 October 2023 20:40
> ....
> > We need a way for csum_and_copy_{from,to}_user() to report faults.
> > The approach taken back in 2020 (avoid 0 as return value by starting
> > summing from ~0U, use 0 to report faults) had been broken; it does
> > yield the right value modulo 2^16-1, but the case when data is
> > entirely zero-filled is not handled right.  It almost works, since
> > for most of the codepaths we have a non-zero value added in
> > and there 0 is not different from anything divisible by 0xffff.
> > However, there are cases (ICMPv4 replies, for example) where we
> > are not guaranteed that.
> > 
> > In other words, we really need to have those primitives return 0
> > on filled-with-zeroes input.  So let's make them return a 64bit
> > value instead; we can do that cheaply (all supported architectures
> > do that via a couple of registers) and we can use that to report
> > faults without disturbing the 32bit csum.
> 
> Does the ICMPv4 sum need to be zero if all zeros but 0xffff
> if there are non-zero bytes in there?

No.  RTFRFC, please.  Or the discussion of the bug upthread, for that
matter.

> IIRC the original buggy case was fixed by returning 0xffff
> for the all-zero buffer.

YRIC.  For the benefit of those who can pass the Turing test better than
ChatGPT would:

Define a binary operation on [0..0xffff] by

	X PLUS Y = X + Y - ((X + Y > 0xffff) ? 0xffff : 0)

Properties:
	X PLUS Y \in [0..0xffff]
	X PLUS Y = 0 iff X = Y = 0
	X PLUS Y is congruent to X + Y modulo 0xffff
	X PLUS Y = Y PLUS X
	(X PLUS Y) PLUS Z = X PLUS (Y PLUS Z)
	X PLUS 0 = X
	For any non-zero X, X PLUS 0xffff = X
	X PLUS (0xffff ^ X) = 0xffff
	byteswap(X) PLUS byteswap(Y) = byteswap(X PLUS Y)
(hint: if X \in [0..0xffff], byteswap(X) is congruent to 256*X modulo 0xffff)

	If A0,...,An are all in range 0..0xffff, \sum Ak * 0x1000^k is
congruent to A0 PLUS A1 PLUS ... PLUS An modulo 0xffff.  That's pretty
much the same thing as the usual rule for checking if decimal number
is divisible by 9.

	That's the math behind the checksum calculations.  You look at the
data, append 0 if the length had been odd and sum the 16bit values up
using PLUS as addition.  Result will be a 16bit value that will be
	* congruent to that data taken as long integer modulo 0xffff
	* 0 if and only if the data consists entirely of zeroes.
Endianness does not matter - byteswap the entire thing and result will
be byteswapped.

	Note that since 0xffffffff is a multiple of 0xffff, we can
calculate the remainder modulo 0xffffffff (by doing similar addition
of 4-byte groups), then calculate the remainder of that modulo 0xffff;
that's almost always cheaper - N/4 32bit operations vs N/2 16bit ones.
For 64bit architecture we can do the same with 64bit operations, reducing
to 32bit value in the end.  That's what csum_and_copy_...() stuff
is doing - it's memcpy() (or copy_..._user()) combined with calculation
of some 32bit value that would have the right reminder modulo 0xffff.

	Requirement for ICMP is that this function of the payload should
be 0xffff.  So we zero the "checksum" field, calculate the sum and then
adjust that field so that the sum would become 0xffff.  I.e. if the
value of the function with that field zeroed is N, we want to store
0xffff ^ N into the damn field.

	That's where it had hit the fan - getting 0xffff instead of 0
on the "all zeroes" data ended up with "OK, store the 0xffff ^ 0xffff
in there, everything will be fine".  Which yields the payload with
actual sum being 0.

	Special treatment of icmp_reply() is doable, but nobody is
suggesting to check for "all zeroes" case - that would be insane and
pointless.  The minimal workaround papering over that particular case
would be to chech WTF have we stored in that field and always
replacing 0 with 0xffff.  Note that if our data is e.g.
	<40 zeroes> 0x7f 0xff 0x80 0x00
the old rule would (correctly) suggest storing two zeroes into the
checksum field, while that modification would yield two 0xff in
there.  Which is still fine - 0xffff PLUS 0x7fff PLUS 0x8000 =
0 PLUS 0x7fff PLUS 0x8000 = 0xffff, so both variants are acceptable.

	However, I'm not at all sure that icmp_reply() is really
the only place where we can get all-zero data possible to encounter.
Most of the places where want to calculate checksums are not going
to see all-zeroes data, but it would be a lot better not to have to
rely upon that.
