Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900F4144BEC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 07:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgAVGrt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 01:47:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVGrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 01:47:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5927972wma.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jan 2020 22:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=RlZojd1SiUbb/OeinLf3J4JHQYZOcdIDU8W+cj9iulk=;
        b=y3SDRICUNCTGVEfhGZo3blD0LEuV77fDMIPVvItjjaewXSwlnd2aurAbs4B6f2ZfO9
         noTpfd/TLhRPe73LaqAlVAlUpe9wyusPNWjzu6vJFZa2BynslasKCb7iA/W6a0OtVXEb
         YxA0s37yA5jB/OS9ued6UM66oYP0dbwc47AWnfGEFj34PV7BBCI0X7qn8Y7f4e2k3c88
         WOx8BMTixv+0jHe4TSUTmJYaLdx+0xE9RP3llvtF4/XJKNvYwpb6AqmKUOikzdnec5Bx
         i5iCXi2jcxrUBOHnA0Gzz3mt7fRahb+yu5yXcDkPoIYs2Ti6M32/nnTIP7g7e4wRI1D0
         7u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=RlZojd1SiUbb/OeinLf3J4JHQYZOcdIDU8W+cj9iulk=;
        b=KeCwK/HgwVDQrErmkjKyL3nuckidKF0HzxgLhZNfvNeiiCvblhalk8UTnaiz3VgcMB
         MF9eWGDF4avVexng2Pbrvb75Y6JzzS3tLkMWGJgLWAG8/ry00quHYB/aakMFRPKcdfpd
         72zqUSOd2CZ9rUihAoC9VgtaDcD+kqTkROk6y8aIM2G2SYw5jD7iFGrGHY6oKRx1WtOU
         pZPWRZwXHDmiKCWxNtJnjzqnkDAA3UrGGuNMCN6ONFW1TpwJQi9wtuXs8OLC7qDjrOwE
         Z2NO4TO3oiGSb5cPAEv/IYTlTFlz2WJ/fioPBpoT7Mn5PIFiXtigTPYtNRJH9Ldypj4q
         Ufyw==
X-Gm-Message-State: APjAAAWn3azJYu0oxJed8fWr2Ts8yNTbbwUwmTACWO20rT/4CgoRkFcl
        fu0/5aNu+ReHys5ydmtwkKXu/A==
X-Google-Smtp-Source: APXvYqxE0JBWhtarBcJMiWajDjZfirf67dUMAGz9LTC5QD8210pTuLsvsl7JRG+MChOSyTnzZODhrQ==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr1124469wmg.169.1579675665355;
        Tue, 21 Jan 2020 22:47:45 -0800 (PST)
Received: from [173.194.76.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id q19sm2532169wmc.12.2020.01.21.22.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 22:47:44 -0800 (PST)
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, X86 ML <x86@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Wesley Terpstra <wesley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <cover.1579248206.git.michal.simek@xilinx.com>
 <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
 <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <5dac2fdd-6e4e-dd16-a149-fbdd8117ac1c@monstr.eu>
Date:   Wed, 22 Jan 2020 07:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S
Content-Type: multipart/mixed; boundary="FbunjY3XOg7TLNQEYAVrl68e0gK20Tj5W";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, git@xilinx.com,
 Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
 Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, X86 ML <x86@kernel.org>, Guo Ren <guoren@kernel.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Wesley Terpstra <wesley@sifive.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Chris Zankel <chris@zankel.net>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <5dac2fdd-6e4e-dd16-a149-fbdd8117ac1c@monstr.eu>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
References: <cover.1579248206.git.michal.simek@xilinx.com>
 <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
 <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>
In-Reply-To: <CAK7LNARdiTxajZcXH0g7t6nEis-1ebv7Ta6wBdgGgS6O29O7+A@mail.gmail.com>

--FbunjY3XOg7TLNQEYAVrl68e0gK20Tj5W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21. 01. 20 16:43, Masahiro Yamada wrote:
> Hi.
>=20
> On Fri, Jan 17, 2020 at 5:03 PM Michal Simek <michal.simek@xilinx.com> =
wrote:
>>
>> dma-continuguous.h is generic for all architectures except arm32 which=
 has
>> its own version.
>=20
>=20
>=20
> Currently, <asm/dma-contiguous.h> is present
> for only architectures that select HAVE_DMA_CONTIGUOUS.
>=20
> After this commit, the other architectures will end
> up with generating the unused header.
>=20
> That would not be a big deal, but
> it could be mentioned in the commit message?

I have not a problem with mentioning it but not sure if this was done in
past.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--FbunjY3XOg7TLNQEYAVrl68e0gK20Tj5W--

--2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXifv/wAKCRDKSWXLKUoM
IVUkAJ9gJ/92v49cM3s26jCgIZyQ1BDZJwCggrGUMIoHH0J6KEp9UuM3wHKXoAo=
=zquH
-----END PGP SIGNATURE-----

--2dbNcSDggiI5dxMnAV22UCPQ9muiAKI4S--
