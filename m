Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20C368453
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 18:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVQBw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 12:01:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:36763 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDVQBv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 12:01:51 -0400
X-Greylist: delayed 36434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 12:01:50 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1619107256; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p08xucsc79c7YwfwHDwDriyxDLhleGMcxJ+93tArEIE6s4NII3ezUj4xlLxWHzZCFr
    1woN6AuD+FtLVNI4UWoqSUkZUeCdrlpR29pk3q3IGvtZsXynthsKmP3bMPO2pemOm1aV
    Xd/QDsPtzlfKUcM1WoxHN12qRsGj4xOCeYa/noS+VElqSMkJi1PVeIMf7HzDctZrbAyx
    MvZ3Tu+41Exe5KWC6VoPBdqmk7qrg8CufIDF29OEePYjcGK0wVGCh1JbhfaD/NV9Yl1s
    J78pcGgmFwvLGfdQgcUTYPYD+n2EAhGwoa44Zy3ZYui6Kxk7Hurxz+A7NMutvSWRbNH1
    mCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619107256;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZyNPkTwiV2jIS8aDjRLvGkiqHGZxdhiz3b1aL19REv4=;
    b=oMyrFc1g2nxPO5d+r48w7SnUrdZkAS6CMDaBCOKdHU+5POLc23/ixvfGbB6BXczMug
    B2fucr239d/hODdkpUWVIZjf62tdpSDgC+z4ZrIEtjc98fgUFMJFft0iDCO3c1oKqx6e
    FjLichMf27AOIOnupg3UwPnGIl/p6nt8mXTkPrOKPXMgkQNSQquPAAVIDiVClEOKvWTE
    aI2tmLWv15KUEM/h4buEdIye6HmWZhGfb6YGkxA4COBE82gizEEIkuW5Xp/92r+IZBoh
    mbEpRXZ2LUp39BYIGUSdxgXK57LbM9NUGsBqYxM9C33NAGtvHwCooGd69lYf109begKz
    uTsg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619107256;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZyNPkTwiV2jIS8aDjRLvGkiqHGZxdhiz3b1aL19REv4=;
    b=pIPaEtDr8/G2QyvR/eszHcaETXjirAVn8BnS57we+Xsfgl4cFFlI1uiR2uKwfojf0B
    0HUvXu077kz3bovCdhnr1vmg4XnDX53FQKMvwaduKmN7u4jwZtq/DR3JHJAJnX0UI92M
    CKdVLyRA4YY+vzEhSJ5nBcvzOdR67PXZdzR4tm5xPVpTGOzm6FkAfHpLW2xzCRRE5B+y
    Yb/QzDLDzX+9WJbnsiMaYkSiThZ51ptC7YEvxnYIn6x1yivWDw7OHPPIQvxaJeiQLAOu
    SXqMUxP5rOyl6i+0VjOduBHTv8vOD0YonAKaKYk66DiapWdj1Z2qIGt1iS9fBIqmjhIY
    yhJA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMhw43rAaY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.24.3 DYNA|AUTH)
    with ESMTPSA id Q01a92x3MG0tYG8
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 22 Apr 2021 18:00:55 +0200 (CEST)
Subject: Re: [PATCH 0/4] Reinstate and improve MIPS `do_div' implementation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com>
Date:   Thu, 22 Apr 2021 18:00:55 +0200
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <895956F9-4EBC-4C8A-9BF2-7E457E96C1D7@goldelico.com>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <51BC7C74-68BF-4A8E-8CFB-DB4EBBC89706@goldelico.com> <alpine.DEB.2.21.2104211904490.44318@angie.orcam.me.uk> <E6326E8A-50DA-4F81-9865-F29EE0E298A9@goldelico.com> <2d636696-35f0-4731-b1c3-5445a57964fb@www.fastmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

> Am 22.04.2021 um 15:39 schrieb Jiaxun Yang <jiaxun.yang@flygoat.com>:
>=20
>=20
>=20
> On Thu, Apr 22, 2021, at 1:53 PM, H. Nikolaus Schaller wrote:
>> Hi,
>>=20
>>> Am 21.04.2021 um 21:04 schrieb Maciej W. Rozycki =
<macro@orcam.me.uk>:
>>>=20
>>> On Wed, 21 Apr 2021, H. Nikolaus Schaller wrote:
>>>=20
>>>>> In the end I have included four patches on this occasion: 1/4 is =
the test=20
>>>>> module, 2/4 is an inline documentation fix/clarification for the =
`do_div'=20
>>>>> wrapper, 3/4 enables the MIPS `__div64_32' backend and 4/4 adds a =
small=20
>>>>> performance improvement to it.
>>>>=20
>>>> How can I apply them to the kernel? There is something wrong which =
makes
>>>> git am fail.
>>>=20
>>> I don't know.  The changes were made against vanilla 5.12-rc7, but =
then=20
>>> the pieces affected have not changed for ages.  FWIW I can `git am' =
the=20
>>> series as received back just fine.
>>=20
>> Please can you point me to some download/pull/gitweb? It seems as if =
the series
>> also did not appear at =
https://patchwork.kernel.org/project/linux-mips/list/
>>=20
>=20
> You may try download raw from:
>=20
> =
https://lore.kernel.org/linux-mips/E6326E8A-50DA-4F81-9865-F29EE0E298A9@go=
ldelico.com/T/#t

I simply tried again and it seems that I had tried to git am it on top =
of the
patches from Huacai which of course fails.

Now I could run the tests:

from [PATCH 4/4]:

> This has passed correctness verification with test_div64 and reduced =
the
> module's average execution time down to 1.0445s and 0.2619s from =
1.0668s
> and 0.2629s respectively for an R3400 CPU @40MHz and a 5Kc CPU =
@160MHz.

test only [PATCH 1/4 and 2/4]:

[  256.301140] test_div64: Completed 64bit/32bit division and modulo =
test, 0.291154944s elapsed

+ [PATCH 3/4]

[ 1698.698920] test_div64: Completed 64bit/32bit division and modulo =
test, 0.132142865s elapsed

+ [PATCH 4/4]

[  466.818349] test_div64: Completed 64bit/32bit division and modulo =
test, 0.134429075s elapsed

So the new code is indeed faster than the default implementation.
[PATCH 4/4] has no significant influence (wouldn't say it is slower =
because timer resolution
isn't very high on this machine and the kernel has some scheduling issue =
[1]).

Anyways the JZ4730 can boot and works with these patches included.

BR and thanks,
Nikolaus Schaller


[1] we are preparing full support for the JZ4730 based Skytone Alpha =
machine. Most features
are working except sound/I2S. I2C is a little unreliable and Ethernet =
has hickups. And scheduling
which indicates some fundamental IRQ or timer issue we could not yet =
identify.

So if anyone happens to have such a machine and can help debugging, =
please contact me.

