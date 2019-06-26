Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1D56EA3
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZQYl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 12:24:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38597 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZQYl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2019 12:24:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so1453538pgz.5
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2019 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k7Dlf8sx47uiTue1xW33w+LOIiPl1PRTBP6uQLvfmJc=;
        b=k3mbytoz0dKL1Q65aiUMJ84oAnT28g8nhrjtb58aw7ZFk7h8X9wymI8O133//OJ68X
         bBEthtOkO4L78sL0Cj9WuZnjyhQtcDErL5hsknDZrkDIrWg5YQoxy89c1fxbJbUUieQH
         AOGZP9mqNskDAia73Gcz0xD5dxv87TWHvAUJf6YCVpdtfRzt9+TeU1D/1z6UMH9W8m90
         YD42gXnBzrGW4fEfjdNQAIvwJk6If+KNFxk5gmVG6DtpIpUUeq+mD6+6tzFA5KXMIWWT
         8OM6bczW04DXflvarNxJklEgYcTlVc1qck7hCy0gIj26IPv05N9dzhdBKZ62PfxqUfY7
         7KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k7Dlf8sx47uiTue1xW33w+LOIiPl1PRTBP6uQLvfmJc=;
        b=fC7+QHQSs/3NqaLKfHdA5VHeVs587my8RclyrMntjop5jRwIyd2msvGC60gdrUMGXG
         J3e2KwW+2ePSKdqD+9h4B2H3I+7yiTaHHWEWPJ7caOnHvfoOucUNWSxxwgGLB1uat2Gc
         33fpTIjTpUTovFV7r5ckwq9NIXgHF7vxM6IabElqK2d4luYH2MRpHmuL3NfxveVj0eWW
         kIjzQTWnC0ul+4fwOyrt33U4ImWTy5XUVv16Osi8lgvjzxR875arQfHYkw+ly4kn9PTE
         YeyfQPE2azMlL5S4LcbzNt071sGIK3DtPeeycLhj84xcfRbN5U6OGJVp468/YMrlamJ/
         iALQ==
X-Gm-Message-State: APjAAAWsnV0/WxnCoAbq97+OpdGWOQVeQFQMHezGs6n8mVrKylHbdDkz
        xWZR8t5uOfIZQPjRYnjpBocDmA==
X-Google-Smtp-Source: APXvYqyrDnyRSdi6RpZML1/KC6mkQGLLxMhhVxyn2zHLP5GAtpZV7oVqmJYT0bFeex2r75nE4nwoGw==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr5730544pjs.101.1561566280920;
        Wed, 26 Jun 2019 09:24:40 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b0f6:cbb6:7def:b6a1? ([2601:646:c200:1ef2:b0f6:cbb6:7def:b6a1])
        by smtp.gmail.com with ESMTPSA id t13sm3460156pjo.13.2019.06.26.09.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 09:24:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Detecting the availability of VSYSCALL
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <87a7e4jr4s.fsf@oldenburg2.str.redhat.com>
Date:   Wed, 26 Jun 2019 09:24:38 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Carlos O'Donell <carlos@redhat.com>, X86 ML <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CECE9DE-51AB-4A21-A257-8B85C4C94EB0@amacapital.net>
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de> <87lfxpy614.fsf@oldenburg2.str.redhat.com> <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com> <87a7e5v1d9.fsf@oldenburg2.str.redhat.com> <CALCETrUDt4v3=FqD+vseGTKTuG=qY+1LwRPrOrU8C7vCVbo=uA@mail.gmail.com> <87o92kmtp5.fsf@oldenburg2.str.redhat.com> <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net> <87r27gjss3.fsf@oldenburg2.str.redhat.com> <534B9F63-E949-4CF5-ACAC-71381190846F@amacapital.net> <87a7e4jr4s.fsf@oldenburg2.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Jun 26, 2019, at 8:36 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> * Andy Lutomirski:
>=20
>> I=E2=80=99m wondering if we can still do it: add a note or other ELF indi=
cator
>> that says =E2=80=9CI don=E2=80=99t need vsyscalls.=E2=80=9D  Then we can c=
hange the default
>> mode to =E2=80=9Cno vsyscalls if the flag is there, else execute-only
>> vsyscalls=E2=80=9D.
>>=20
>> Would glibc go along with this?
>=20
> I think we can make it happen, at least for relatively recent glibc
> linked with current binutils.  It's not trivial because it requires
> coordination among multiple projects.  We have three or four widely used
> link editors now, but we could make it happen.  (Although getting to
> PT_GNU_PROPERTY wasn't exactly easy.)

Can=E2=80=99t an ELF note be done with some more or less ordinary asm such t=
hat any link editor will insert it correctly?

>=20
>> Would enterprise distros consider backporting such a thing?
>=20
> Enterprise distros aren't the problem here because they can't remove
> vsyscall support for quite a while due to existing customer binaries.
> For them, it would just be an additional (and welcome) hardening
> opportunity.
>=20
> The challenge here are container hosting platforms which have already
> disabled vsyscall, presumably to protect the container host itself.
> They would need to rebuild the container host userspace with the markup
> to keep it protected, and then they could switch to a kernel which has
> vsyscall-unless-opt-out logic.  That seems to be a bit of a stretch
> because from their perspective, there's no problem today.
>=20
> My guess is that it would be easier to have a personality flag.  Then
> they could keep the host largely as-is, and would =E2=80=9Conly=E2=80=9D n=
eed a
> mechanism to pass through the flag from the image metadata to the actual
> container creation.  It's still a change to the container host (and the
> kernel change is required as well), but it would not require relinking
> every statically linked binary.
>=20
>=20

The problem with a personality flag is that it needs to have some kind of se=
nsible behavior for setuid programs, and getting that right in a way that do=
esn=E2=80=99t scream =E2=80=9Cexploit me=E2=80=9D while preserving useful co=
mpatibility may be tricky.=
