Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A882530E6
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgHZOHI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgHZOGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:06:43 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A736DC061796;
        Wed, 26 Aug 2020 06:58:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bc6sM3GcQz9sTY;
        Wed, 26 Aug 2020 23:58:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1598450328;
        bh=WtZvPT+tJcHfWDcB2bl5x2ifUWh9Vy9MLjlig77Klic=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gnDhYZccRghiauDXrDGdwkzPQT8Lplr8Ow6tPk6IjkE0F7M7ryNIJ92vrGMdNp+xF
         VPlukfvbrRP0N19FgbkYQGB5r7jctQXuFqoiSNqx3BDtTqn4wIzlx0jHzGz4M5x19W
         4Z/XUBMAVPeoFDNUjPp2iyZbUgtLc2RxbIg+TtDdV4Bfmh6/tHGU6i65muDGLqrr6V
         nkIZisdCjYJB2kW80GY9tALHAWFZtvIZLnCJdJxpjNul/UQP1J9a0SZLwkNi9qj+I0
         sYlHYPtS/Y3in5lLSDLRpNvfy4TgsAuntDK5dWlloid8c2U2ar2WcBXJPDGvjBbcky
         /YBhx7gThAFWg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com
Cc:     linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and simplify __get_datapage()
In-Reply-To: <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr> <87wo34tbas.fsf@mpe.ellerman.id.au> <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu> <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
Date:   Wed, 26 Aug 2020 23:58:44 +1000
Message-ID: <87imd5h5kb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 04/08/2020 =C3=A0 13:17, Christophe Leroy a =C3=A9crit=C2=A0:
>> On 07/16/2020 02:59 AM, Michael Ellerman wrote:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>> The VDSO datapage and the text pages are always located immediately
>>>> next to each other, so it can be hardcoded without an indirection
>>>> through __kernel_datapage_offset
>>>>
>>>> In order to ease things, move the data page in front like other
>>>> arches, that way there is no need to know the size of the library
>>>> to locate the data page.
>>>>
> [...]
>
>>>
>>> I merged this but then realised it breaks the display of the vdso in=20
>>> /proc/self/maps.
>>>
>>> ie. the vdso vma gets no name:
>>>
>>> =C2=A0=C2=A0 # cat /proc/self/maps
>
> [...]
>
>>> And it's also going to break the logic in arch_unmap() to detect if
>>> we're unmapping (part of) the VDSO. And it will break arch_remap() too.
>>>
>>> And the logic to recognise the signal trampoline in
>>> arch/powerpc/perf/callchain_*.c as well.
>>=20
>> I don't think it breaks that one, because ->vdsobase is still the start=
=20
>> of text.
>>=20
>>>
>>> So I'm going to rebase and drop this for now.
>>>
>>> Basically we have a bunch of places that assume that vdso_base is =3D=
=3D the
>>> start of the VDSO vma, and also that the code starts there. So that will
>>> need some work to tease out all those assumptions and make them work
>>> with this change.
>>=20
>> Ok, one day I need to look at it in more details and see how other=20
>> architectures handle it etc ...
>>=20
>
> I just sent out a series which switches powerpc to the new=20
> _install_special_mapping() API, the one powerpc uses being deprecated=20
> since commit a62c34bd2a8a ("x86, mm: Improve _install_special_mapping
> and fix x86 vdso naming")
>
> arch_remap() gets replaced by vdso_remap()
>
> For arch_unmap(), I'm wondering how/what other architectures do, because=
=20
> powerpc seems to be the only one to erase the vdso context pointer when=20
> unmapping the vdso.

Yeah. The original unmap/remap stuff was added for CRIU, which I thought
people tested on other architectures (more than powerpc even).

Possibly no one really cares about vdso unmap though, vs just moving the
vdso.

We added a test for vdso unmap recently because it happened to trigger a
KAUP failure, and someone actually hit it & reported it.

Running that test on arm64 segfaults:

  # ./sigreturn_vdso=20
  VDSO is at 0xffff8191f000-0xffff8191ffff (4096 bytes)
  Signal delivered OK with VDSO mapped
  VDSO moved to 0xffff8191a000-0xffff8191afff (4096 bytes)
  Signal delivered OK with VDSO moved
  Unmapped VDSO
  Remapped the stack executable
  [   48.556191] potentially unexpected fatal signal 11.
  [   48.556752] CPU: 0 PID: 140 Comm: sigreturn_vdso Not tainted 5.9.0-rc2=
-00057-g2ac69819ba9e #190
  [   48.556990] Hardware name: linux,dummy-virt (DT)
  [   48.557336] pstate: 60001000 (nZCv daif -PAN -UAO BTYPE=3D--)
  [   48.557475] pc : 0000ffff8191a7bc
  [   48.557603] lr : 0000ffff8191a7bc
  [   48.557697] sp : 0000ffffc13c9e90
  [   48.557873] x29: 0000ffffc13cb0e0 x28: 0000000000000000=20
  [   48.558201] x27: 0000000000000000 x26: 0000000000000000=20
  [   48.558337] x25: 0000000000000000 x24: 0000000000000000=20
  [   48.558754] x23: 0000000000000000 x22: 0000000000000000=20
  [   48.558893] x21: 00000000004009b0 x20: 0000000000000000=20
  [   48.559046] x19: 0000000000400ff0 x18: 0000000000000000=20
  [   48.559180] x17: 0000ffff817da300 x16: 0000000000412010=20
  [   48.559312] x15: 0000000000000000 x14: 000000000000001c=20
  [   48.559443] x13: 656c626174756365 x12: 7865206b63617473=20
  [   48.559625] x11: 0000000000000003 x10: 0101010101010101=20
  [   48.559828] x9 : 0000ffff818afda8 x8 : 0000000000000081=20
  [   48.559973] x7 : 6174732065687420 x6 : 64657070616d6552=20
  [   48.560115] x5 : 000000000e0388bd x4 : 000000000040135d=20
  [   48.560270] x3 : 0000000000000000 x2 : 0000000000000001=20
  [   48.560412] x1 : 0000000000000003 x0 : 00000000004120b8=20
  Segmentation fault
  #

So I think we need to keep the unmap hook. Maybe it should be handled by
the special_mapping stuff generically.

cheers
