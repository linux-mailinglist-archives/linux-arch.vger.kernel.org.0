Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6F1626BA
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgBRNEB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 08:04:01 -0500
Received: from foss.arm.com ([217.140.110.172]:51788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgBRNEB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 08:04:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB731FB;
        Tue, 18 Feb 2020 05:04:00 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2993C3F703;
        Tue, 18 Feb 2020 05:03:57 -0800 (PST)
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, 0x7f454c46@gmail.com,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>, pcc@google.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        avagin@openvz.org, Stephen Boyd <sboyd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        salyzyn@android.com, Paul Burton <paul.burton@mips.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com>
 <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
 <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com>
 <20200217164608.GA2708@willie-the-truck>
 <CAKv+Gu8Qh495twz-3UQrFiKfPq-Kt_o+JrCNwEcdMedV2DqPEA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
X-Pep-Version: 2.0
Message-ID: <19afd7ed-9a90-1d31-8cc6-33645cf8d3ec@arm.com>
Date:   Tue, 18 Feb 2020 13:03:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8Qh495twz-3UQrFiKfPq-Kt_o+JrCNwEcdMedV2DqPEA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------C1C579740ECB765CC136B609"
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a multi-part message in MIME format.
--------------C1C579740ECB765CC136B609
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/02/2020 22:39, Ard Biesheuvel wrote:
> On Mon, 17 Feb 2020 at 17:46, Will Deacon <will@kernel.org> wrote:
>>
>> On Mon, Feb 17, 2020 at 12:26:16PM +0000, Vincenzo Frascino wrote:
>>> On 13/02/2020 18:44, Nathan Chancellor wrote:
>>>> On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
>>>>> Enable Clang Compilation for the vdso32 library.
>>>
>>> [...]
>>>
>>>>> +LD_COMPAT ?=3D $(CROSS_COMPILE_COMPAT)gcc
>>>>
>>>> Well this is unfortunate :/
>>>>
>>>> It looks like adding the --target flag to VDSO_LDFLAGS allows
>>>> clang to link the vDSO just fine although it does warn that -nostdin=
c
>>>> is unused:
>>>>
>>>> clang-11: warning: argument unused during compilation: '-nostdinc'
>>>> [-Wunused-command-line-argument]
>>>>
>>>
>>> This is why ended up in this "unfortunate" situation :) I wanted to a=
void the
>>> warning.
>>>
>>>> It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
>>>> vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted her=
e
>>>> but I get that this Makefile is its own beast :) at the very least, =
I
>>>> think that the --target flag should be added to VDSO_LDFLAGS so that=
 gcc
>>>> is not a requirement for this but I am curious if you tried that alr=
eady
>>>> and noticed any issues with it.
>>>>
>>>
>>> --target is my preferred way as well, I can try to play another littl=
e bit with
>>> the flags and see what I can come up with in the next version.
>>
>> Yes, please. I'd even prefer the warning rather than silently assuming=
 that
>> a cross gcc is kicking around on the path.
>>
>=20
> Doesn't Clang have -Qunused-arguments for that?
>=20

Yes, this is exactly what I was looking for. Thanks Ard :)

--=20
Regards,
Vincenzo

--------------C1C579740ECB765CC136B609
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
OYXvLNoskiekAsw77EBPeBrrsMg88G/AtWUvyT3i2x0mIlbTDESk0WiL2ksdzcRW
AtZuC/55Ix7zMb0NrMC0eaLaP93+FSAnTiX7kUMQSbz9iAHak4xbzJNEg4+fNh63
vFvWNazfnnSKXMlZ0exYWZGUswxdqsg/p+zRcFwrKp2IrLxMXBTRMB5Pdtr9PvOI
TFa3jV1SfFp6CUCY1yOBG3Jvwxx7yUTis4Ap3qaTy0uQNgHbXvlP5CW0xL5GpBw0
W6gUwBeHtnquzJwO203qds37uq3V+U2jR4Zs0KcTBFpMRPBX+kwm2gwR8tkRpqtQ
zMgwjvz9VM+1pUoufUG3Gy/UBZRCamw84zKxkZS5/yIWQiTm7IMPUofgMe6P8Zk0
1pyna1ld4iURBrXlpfUaOn3sjmt6C2WOmud+WJMBeYmJHAF0Th0GQ0uijxM6sEGV
/8FYGnjWs8pFYNM4NcKJAjMEEAEKAB0WIQSf1RxT4LVjGP2VnD0j0NC60T16QwUC
XW0xNgAKCRAj0NC60T16Q/TDEADEKTdkGD+bR752abN0raUI6UZwH1D2sXIwiZhE
ezrwDoIe3ETAsV7Jh05yPOunWTBkDcjd3Xrf0ILwfIa76QWu1599AXl4nR62IBzM
4gkRcdNV5lzRrBLkG/e6drB36DTATUxgmDy6fCEjuhSMfHApi/9k1CcU/h+tCEES
sA/aS8TRbWbxSZb6MgUI1gNrAKzyEs/L8imvPbKR0JNc7IaK9oYSkhM4CXb6c+cx
/iNehNegf2LaOBBvmjbHXsT8HEnqU3QWSiV3JXDjZCvwkXOD4uJGbbGNpWj0/EJj
WC1c6FmzcXXq/6cnHNC6FlR0i8Au0eNEgDOUWPPL9hGv0Co3mT4++9QJwVtMY995
/DKBdgVFlvZ9w3RwUjKkzCQV6AsI3dTS3c7YEE/rjdQacZ28X5hJ3ySHYoMuQktI
72LluzC3YsHdfpgt4O6rtn1AE+oyVPRT2/3A8Axnd3PPEabIi4g2ROcU4fYjISh5
iP3hrl7F7jPe05NdfJ/Rn4dSWdrapdzbnuDY4wV9dTCVjXYHZLGeFc0TeamafUJQ
HOswZSorU2wt94/HGLb+Ps9PMpO1YD+TGwGWnJoGRwrXCpuxxDUB63twLyHU+zq6
PSq0MMza6Ssq5qHT96xbyED+MDJER5Lbtc7bTPbeb1xKzwlrUHHDYXOkrT1rpV13
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
GrFxzNOCDuNG1w=3D=3D
=3DVSiF
-----END PGP PUBLIC KEY BLOCK-----

--------------C1C579740ECB765CC136B609--
