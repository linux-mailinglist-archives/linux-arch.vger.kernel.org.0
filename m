Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54DF4083C1
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 07:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhIMFSC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 01:18:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17194 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhIMFSB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2021 01:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631510195;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=tAfhz6QufKiLrm/ed7wZTVkjNN2LQnGrxYZQDIJXvMw=;
    b=AwntNUwXfkOP31jyIciNWYM9hbXPiKePY2V4yEj/QzJlHqJzQr82cXpl0fv7MxqH+G
    JQvM6yEZ4VCaTRvHDEmR24YVS7AZ9oZ1lST7Q+5LcgrsRZvjeiQRsTIw3o9d9nWW6RjA
    VyJ0BrHROsMlvDoSYIcr1814OHic8Mmy+scIggwOCDp+rhZt+rpN8iD5CtQTMJOZE3dr
    fXGcDfTy4BUSjC+UKbt78aZEV0uMOca58fngdizn92alPwL5r0BJUrrHcZcxv5ul/h51
    3YqWtS7xMP+P2BI8SubXDP2fWCazJkB02rJErKOLa5VGj8DyaVD8JSNYVpsNrqYUkk3U
    vfUg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43vUGE="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.33.3 SBL|AUTH)
    with ESMTPSA id e07e13x8D5GYFQ6
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 13 Sep 2021 07:16:34 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 1/2] mips: convert syscall to generic entry
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <7e2c0db1-bf5a-8f16-bc43-81830a30045e@wanyeetech.com>
Date:   Mon, 13 Sep 2021 07:16:32 +0200
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        luto@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arch@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2163252-3423-413C-8C35-B6E52C73E598@goldelico.com>
References: <cover.1630929519.git.chenfeiyang@loongson.cn>
 <ec14e242a73227bf5314bbc1b585919500e6fbc7.1630929519.git.chenfeiyang@loongson.cn>
 <59feb382-a4ab-c94e-8f71-10ad0c0ceceb@flygoat.com>
 <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
 <20210908085150.GA5622@alpha.franken.de>
 <13d237ab-0ef3-772d-6f21-ff023781efcf@flygoat.com>
 <7e2c0db1-bf5a-8f16-bc43-81830a30045e@wanyeetech.com>
To:     Zhou Yanjie <zhouyu@wanyeetech.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?utf-8?B?6ZmI6aOe5oms?= <chris.chenfeiyang@gmail.com>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,


> Am 09.09.2021 um 14:45 schrieb Zhou Yanjie <zhouyu@wanyeetech.com>:
>=20
> Hi,
>=20
> On 2021/9/8 =E4=B8=8B=E5=8D=888:41, Jiaxun Yang wrote:
>>=20
>> =E5=9C=A8 2021/9/8 16:51, Thomas Bogendoerfer =E5=86=99=E9=81=93:
>>> On Wed, Sep 08, 2021 at 10:08:47AM +0800, =E9=99=88=E9=A3=9E=E6=89=AC =
wrote:
>>>> On Tue, 7 Sept 2021 at 21:49, Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
>>>>>=20
>>>>> =E5=9C=A8 2021/9/7 14:16, FreeFlyingSheep =E5=86=99=E9=81=93:
>>>>>> From: Feiyang Chen <chenfeiyang@loongson.cn>
>>>>>>=20
>>>>>> Convert mips syscall to use the generic entry infrastructure from
>>>>>> kernel/entry/*.
>>>>>>=20
>>>>>> There are a few special things on mips:
>>>>>>=20
>>>>>> - There is one type of syscall on mips32 (scall32-o32) and three =
types
>>>>>> of syscalls on mips64 (scall64-o32, scall64-n32 and scall64-n64). =
Now
>>>>>> convert to C code to handle different types of syscalls.
>>>>>>=20
>>>>>> - For some special syscalls (e.g. fork, clone, clone3 and =
sysmips),
>>>>>> save_static_function() wrapper is used to save static registers. =
Now
>>>>>> SAVE_STATIC is used in handle_sys before calling do_syscall(), so =
the
>>>>>> save_static_function() wrapper can be removed.
>>>>>>=20
>>>>>> - For sigreturn/rt_sigreturn and sysmips, inline assembly is used =
to
>>>>>> jump to syscall_exit directly for skipping setting the error flag =
and
>>>>>> restoring all registers. Now use regs->regs[27] to mark whether =
to
>>>>>> handle the error flag and always restore all registers in =
handle_sys,
>>>>>> so these functions can return normally as other architecture.
>>>>> Hmm, that would give us overhead of register context on these =
syscalls.
>>>>>=20
>>>>> I guess it's worthy?
>>>>>=20
>>>> Hi, Jiaxun,
>>>>=20
>>>> Saving and restoring registers against different system calls can =
be
>>>> difficult due to the use of generic entry.
>>>> To avoid a lot of duplicate code, I think the overhead is worth it.
>>> could you please provide numbers for that ? This code still runs
>>> on low end MIPS CPUs for which overhead might mean a different
>>> ballpark than some highend Loongson CPUs.
>>=20
>> It shows ~3% regression for UnixBench on MT7621A (1004Kec).
>>=20
>> + Yanjie could you help with a run on ingenic platform?
>=20
>=20
> Sure, I can help with JZ4775, JZ4780, X1000, X1830, X2000 from =
Ingenic, and SF16A18, SF19A2890 from SiFlower.
>=20
> + Paul could you help with a run on JZ4760 and JZ4770?
>=20
> + Nikolaus could you help with a run on JZ4730?

Have not observed a negative effect on jz4730. Same for jz4780.
But I have not done performance tests.

BR,
Nikolaus=
