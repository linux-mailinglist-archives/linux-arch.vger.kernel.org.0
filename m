Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66A954C43B
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSXzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jun 2019 19:55:45 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:48746 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfFSXzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Jun 2019 19:55:45 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2EEB3C00A1;
        Wed, 19 Jun 2019 23:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560988545; bh=4W80PkBNQNFiNESJ/g56Fr2c3B/k9lx1UKBqqZwspzk=;
        h=From:To:CC:Subject:Date:References:From;
        b=jS2k04uaA+b3hUsLQXtOZ15Qgl4cJSt82JMlSqdYCKesmW2IQW0zPmqH5TSg4Xl4U
         5uByiCE59zhM4ZMGEBMWXaMCTqrg9uzk6AxwcQJFUXS7hoV5D3DNhF95ixdHmCgJyy
         iVOFwY9jqneN4nA4reuJeRmE8/klODTTofeYURXNWkPybiOZKmJr54tu5tnZmu/Rcr
         fe2eBek0HAVLhernrPWJfOd1TJImNEvC8z1OP8J48k59kvmkW9kPL+AG/zY/dy5SJ7
         GwU+yWL9WudaaAoPG+kzsCRDZOz1CS7e2KznVxLhrPiZNMoJizuQST76YbwCnjI/jk
         S3SfLmlwi5Okw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0D71EA0079;
        Wed, 19 Jun 2019 23:55:42 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed, 19
 Jun 2019 16:55:42 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@akamai.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVIs/0NQVi79UXq0qOEJsJAVWA8w==
Date:   Wed, 19 Jun 2019 23:55:41 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/19/19 1:12 AM, Peter Zijlstra wrote:=0A=
> On Tue, Jun 18, 2019 at 04:16:20PM +0000, Vineet Gupta wrote:=0A=
>=0A=
>>> +/*=0A=
>>> + * To make atomic update of patched instruction available we need to g=
uarantee=0A=
>>> + * that this instruction doesn't cross L1 cache line boundary.=0A=
>>> + *=0A=
> Oh urgh. Is that the only way ARC can do text patching? =0A=
=0A=
Nothing seems out of the ordinary here. Perhaps Eugeniy's comment confused =
you, so=0A=
let me explain the whole thing - likely obvious to you anyways.=0A=
=0A=
I-cache is non snooping on ARC (like most embedded style arches) so self mo=
difying=0A=
code has to flush corresponding D and I cache lines. Instructions can be 2 =
byte=0A=
aligned and could be 2, 4, 6, 8 bytes long, so a 4 byte NOP can potentially=
=0A=
straddle cache line, needing 2 lines to be flushed. The cache maintenance o=
ps work=0A=
on region or line but coherency unit nonetheless operates on line sized uni=
ts=0A=
meaning 2 line ops may not be atomic on a remote cpu. So in the pathetic co=
rner=0A=
case we can have "other (non patching) CPU execute the code around patched =
PC with=0A=
partial old/new fragments. So we ensure a patched instruction never crosses=
 a=0A=
cache line - using .balign 4. This causes a slight mis-optimization that al=
l=0A=
patched instruction locations are forced to be 4 bytes aligned while ISA al=
lows=0A=
code to be 2 byte aligned. The cost is an extra NOP_S (2 bytes) - no big de=
al in=0A=
grand scheme of things in IMO.=0A=
=0A=
FWIW I tried to avoid all of this by using the 2 byte NOP_S and B_S variant=
s which=0A=
ensures we can never straddle cache line so the alignment issue goes away. =
There's=0A=
a nice code size reduction too - see [1] . But I get build link errors in=
=0A=
networking code around DO_ONCE where the unlikely code is too much and offs=
et=0A=
can't be encoded in signed 10 bits which B_S is allowed.=0A=
=0A=
[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-June/005875.ht=
ml=0A=
> We've actually=0A=
> considered something like this on x86 at some point, but there we have=0A=
> the 'fun' detail that the i-fetch window does not in fact align with L1=
=0A=
> size on all uarchs, so that got complicated real fast.=0A=
=0A=
As described above we don't have such an issue. I/D flushing works - its ju=
st that=0A=
they are not be atomic=0A=
=0A=
> I'm assuming you've looked at what x86 currently does and found=0A=
> something like that doesn't work for ARC?=0A=
=0A=
Just looked at x86 code and it seems similar=0A=
=0A=
>=0A=
>>> +/* Halt system on fatal error to make debug easier */=0A=
>>> +#define arc_jl_fatal(format...)						\=0A=
>>> +({									\=0A=
>>> +	pr_err(JUMPLABEL_ERR format);					\=0A=
>>> +	BUG();								\=0A=
>> Does it make sense to bring down the whole system vs. failing and return=
ing.=0A=
>> I see there is no error propagation to core code, but still.=0A=
> It is what x86 does. And I've been fairly adamant about doing so. When=0A=
> the kernel text is compromised, do you really want to continue running=0A=
> it?=0A=
=0A=
Agree, but the errors here are not in the middle of code patching itself. T=
hey are=0A=
found before committing to patching say because patched code straddles line=
 (which=0A=
BTW can never happen given the .balign, it is perhaps a pedantic safety net=
), or=0A=
the offset can't be encoded in B. So it is possible to  do a pr_err and jus=
t=0A=
return w/o any patching like an API call failed. But given that the error=
=0A=
propagation to core is not there - the assumption is it either always works=
 or=0A=
panics, there is no "failing" semantics.=0A=
=0A=
>=0A=
>>> +})=0A=
>>> +=0A=
>>> +static inline u32 arc_gen_nop(void)=0A=
>>> +{=0A=
>>> +	/* 1x 32bit NOP in middle endian */=0A=
> I dare not ask...=0A=
=0A=
:-) The public PRM is being worked on for *real* so this will be remedied i=
n a few=0A=
months at best.=0A=
=0A=
Short answer is it specifies how instruction stream is laid out in code mem=
ory for=0A=
efficient next PC decoding given that ARC can freely intermix 2, 4, 6, 8 by=
te=0A=
instruction fragments w/o any restrictions.=0A=
=0A=
Consier SWI insn encoding: per PRM is=0A=
=0A=
31                                     0=0A=
--------------------------------------------------------------=0A=
00100    010    01    101111    0    000    000000    111111=0A=
--------------------------------------------------------------=0A=
=0A=
In regular little endian notation, in memory it would have looked as=0A=
=0A=
31                  0=0A=
 0x22    0x6F    0x00    0x3F =0A=
  b3     b2      b1      b0=0A=
=0A=
However in middle endian format, the 2 short words are flipped=0A=
=0A=
31                   0=0A=
0x00    0x3F   0x22     0x6F   =0A=
  b1     b0      b3       b2=0A=
=0A=
>=0A=
>>> +	WRITE_ONCE(*instr_addr, instr);=0A=
>>> +	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);=
=0A=
> So do you have a 2 byte opcode that traps unconditionally? In that case=
=0A=
> I'm thinking you could do something like x86 does. And it would avoid=0A=
> that NOP padding you do to get the alignment.=0A=
=0A=
Just to be clear there is no trapping going on in the canonical sense of it=
. There=0A=
are regular instructions for NO-OP and Branch.=0A=
We do have 2 byte opcodes for both but as described the branch offset is to=
o=0A=
limited so not usable.=0A=
=0A=
-Vineet=0A=
