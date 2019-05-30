Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48205302AA
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 21:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE3TQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 15:16:39 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:52112 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726031AbfE3TQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 15:16:39 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B83A3C00FC;
        Thu, 30 May 2019 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559243808; bh=1mbzGKOk5d05XHjdieSHAEOEoFv4IjB5bTqeWALND5c=;
        h=From:To:CC:Subject:Date:References:From;
        b=Aq/P2ZcLteluaESiZPUrLU6HEcuQoTe3TmnI3PjpngMso5jrE1NZDn6CU8ktbgzOX
         3iGz3Xc9E3Vbv1D6WKYakpP9CO98vMiY6YtluE7zcgi6Iqfn7cwe0sv9XzIJ5ob6el
         BWTGnsmxCXlck2RlIo8BpW59MLFKS/s6j3LvYeFjJ3zV9zD5OMFomRMZ82jJpnLFy4
         qL14ud7ieu0PWUu8XvML45AH1wgjP0oOr0ks1Z8Yf+2YrUTj3GeiaCVLPyrxZwBIQL
         Gw09T5AkfqWX/5jsBg2Mmn/DVUM9RRrV40XgbyCGv5CUZNDnr1WHEIO/29yqHUSJNW
         hUo01xTgYflPg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EAB1AA005D;
        Thu, 30 May 2019 19:16:37 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Thu, 30 May 2019 12:16:37 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Thread-Topic: single copy atomicity for double load/stores on 32-bit systems
Thread-Index: AQHVFxS3L0CUD1w2LkO7mj7CwLHhlw==
Date:   Thu, 30 May 2019 19:16:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2520D9C@us01wembx1.internal.synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190530185358.GG28207@linux.ibm.com>
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

On 5/30/19 11:55 AM, Paul E. McKenney wrote:=0A=
>=0A=
>> I'm not sure how to interpret "natural alignment" for the case of double=
=0A=
>> load/stores on 32-bit systems where the hardware and ABI allow for 4 byt=
e=0A=
>> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)=0A=
>>=0A=
>> I presume (and the question) that lkmm doesn't expect such 8 byte load/s=
tores to=0A=
>> be atomic unless 8-byte aligned=0A=
> I would not expect 8-byte accesses to be atomic on 32-bit systems unless=
=0A=
> some special instruction was in use.  But that usually means special=0A=
> intrinsics or assembly code.=0A=
=0A=
Thx for confirming.=0A=
=0A=
In cases where we *do* expect the atomicity, it seems there's some existing=
 type=0A=
checking but isn't water tight.=0A=
e.g.=0A=
=0A=
#define __smp_load_acquire(p)                        \=0A=
({                                    \=0A=
    typeof(*p) ___p1 =3D READ_ONCE(*p);                \=0A=
    compiletime_assert_atomic_type(*p);                \=0A=
    __smp_mb();                            \=0A=
    ___p1;                                \=0A=
})=0A=
=0A=
#define compiletime_assert_atomic_type(t)                \=0A=
    compiletime_assert(__native_word(t),                \=0A=
        "Need native word sized stores/loads for atomicity.")=0A=
=0A=
#define __native_word(t) \=0A=
    (sizeof(t) =3D=3D sizeof(char) || sizeof(t) =3D=3D sizeof(short) || \=
=0A=
     sizeof(t) =3D=3D sizeof(int) || sizeof(t) =3D=3D sizeof(long))=0A=
=0A=
=0A=
So it won't catch the usage of 4 byte aligned long long which gcc targets t=
o=0A=
single double load instruction.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
