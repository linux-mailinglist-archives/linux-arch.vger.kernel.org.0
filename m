Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB47722B257
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgGWPTa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 23 Jul 2020 11:19:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57267 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727885AbgGWPTa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 11:19:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-189-nrFZn9lFNFWn8m8ncEqV_w-1; Thu, 23 Jul 2020 16:19:26 +0100
X-MC-Unique: nrFZn9lFNFWn8m8ncEqV_w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 23 Jul 2020 16:19:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 23 Jul 2020 16:19:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Topic: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Thread-Index: AQHWX51MlcPCEWebQUuN/OB/armWnKkTU0FggABJU4CAABlpkP//+uQAgAAU8xCAAAgogIABYH9ggAADowCAABSesA==
Date:   Thu, 23 Jul 2020 15:19:25 +0000
Message-ID: <08f183dac3144384b28d297bc6da4e69@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
 <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
 <20200722173903.GG2786714@ZenIV.linux.org.uk>
 <02938acd78fd40beb02ffc5a1b803d85@AcuMS.aculab.com>
 <20200723145342.GH2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200723145342.GH2786714@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro
> Sent: 23 July 2020 15:54
> On Thu, Jul 23, 2020 at 01:54:47PM +0000, David Laight wrote:
> > From: Al Viro
> > > Sent: 22 July 2020 18:39
> > > I would love to see your patch, anyway, along with the testcases and performance
> > > comparison.
> >
> > See attached program.
> > Compile and run (as root): csum_iov 1
> >
> > Unpatched (as shipped) 16 vectors of 1 byte take ~430 clocks on my haswell cpu.
> > With dsl_patch defined they take ~393.
> >
> > The maximum throughput is ~1.16 clocks/word for 16 vectors of 1k.
> > For longer vectors the data gets lost from the cache between the iterations.
> >
> > On an older Ivy Bridge cpu it never goes faster than 2 clocks/word.
> > (Due to the implementation of ADC.)
> >
> > The absolute limit is 1 clock/word - limited by the memory write.
> > I suspect that is achievable on Haswell with much less loop unrolling.
> >
> > I had to replace the ror32() with __builtin_bswap32().
> > The kernel object do contain the 'ror' instruction - even though I
> > didn't find the asm for it.
> 
> First of all,
...
> static inline __u32 ror32(__u32 word, unsigned int shift)
> {
>         return (word >> (shift & 31)) | (word << ((-shift) & 31));
> }
> ; cat >/tmp/a.c <<'EOF'
...
> which ought to cover _that_ question.  Takes a couple of minutes, but that's
> a trivial side issue.

I did find that function. Typing __builtin_bswap32() only took seconds.

> Said that, what you've printed for 1-byte segments (and that's going to be
> seriously affected by the setup costs in csum-copy.S, sensitive to calling
> convention changes) is time to run the 16-iteration loop divided by 1 * 16 / 8;
> IOW, your difference for 16 iterations here is 37*2 = 74 cycles.  With
> per-iteration diff being a bit under 5 cycles.  Which is not implausible,
> but
> 	1) extrapolating to other compiler versions, flags, etc. is not obvious
> 	2) the effects of calling convention changes need to be taken into account
> 	3) for copying to/from userland the effects of calling convention changes
> are be even larger, and kernel is certainly not going to issue kvec iters of _that_
> sort, TYVM.

Agreed, I used 1 byte fragments to make changes to that particular
code fragment stand out.
Running the program with different sizes shows just how much the
code around the inner loop costs.
It isn't as though buffers are a nice multiple of 64 bytes.

For x86_64 the user/kernel calling conventions are much the same.
Most modern ones pass a few arguments in registers so passing
the old 'csum' in is probably ok.
It may even save a register spill to stack.
The extra two arguments for saving the fail address are horrid.
As is passing the csum by address.

For efficiency you do want:
	csum = csum_copy(dest, src, length, csum);

And it does make sense to use 0 for 'error'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

