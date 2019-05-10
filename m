Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686C119BFF
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 12:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfEJKxq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 06:53:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55121 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfEJKxp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 06:53:45 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so8606230ite.4
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6lmggy5LAhP6+/fqo3Cgjki+90sC2rjWaVQkUq7yfS0=;
        b=IiT+Y7M2bPSekDVZ0GorTiBcC3mahvOegfQRIUpm047z/E7ZQiYTEDyK99JCx55xzr
         IM2JqTWji/VnQeDAi8vHeZtehsL8/RZPpgt+97oinEPEz7LNZyirIW2pB99JSzwjzIHz
         vX1MlDYQZbErxiPOntUk+nrtqfnBcBD61PQOtQMfi0ixxTtB5n9OphDCFNYmWIQaXa2M
         554VgQPXpnXXfpRsDU/6EijWMNVV2DUYKmIbAAjAIbbfrtTeC2SB8DezrQ32Hfl9w3zJ
         CK5Zg50oSTq5MpWNxvpIofT8hYBIUn1z8D/FoU39PfQx6sEy0q8ZpTqfCH/lr8EXWewq
         pdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6lmggy5LAhP6+/fqo3Cgjki+90sC2rjWaVQkUq7yfS0=;
        b=X9BdY5toAPQiJGFQx+fDaBdEPgJSqc+hu2gNmNRQIV8ksss0H+El85/S1ASM5HgtdT
         g6+wo+pJgCJA2Oj6mOiLTEZvKPMDpjLMkfif2+hJCURsoNjeJxALCWhnrLWXl+/MWoKA
         Vpaya3THCBHgyrQmmo3R9XU+ynBT+JFnBz7FCt4muCt0xyDoZimVNJ7rRSXkcYjoudMF
         0uWldNHmb7oXOsA11gFXVfCTSzCUpJeCFFuRgcTX8dD8eWnP+93wNMeSoIEMHUMpHvOW
         xZ3NWSXJjkEbolnR/Zg3f7ten3S8ibKI1ZtlrKJQIP8+Uf3iNXwFRWiriKRSLElg8d+I
         ENUQ==
X-Gm-Message-State: APjAAAUZe1oLS96+w89bUxJBo8Twi/Rro3+72uAg54Nzfh9ztc/k2+bm
        AUyh6f4bUC+WJ+Yu7C2RE3XRjNl1bV7468avB6HA9A==
X-Google-Smtp-Source: APXvYqxTVIOAjkyrwAL7YrZ7nLzxhjxM+ec7fq3I6p+KVlTYd7N4iUs5cYNvoNrLNhNTB27bq9BGwTunV2kQhIubAxY=
X-Received: by 2002:a24:6c13:: with SMTP id w19mr238759itb.144.1557485624546;
 Fri, 10 May 2019 03:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr>
In-Reply-To: <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 May 2019 12:53:33 +0200
Message-ID: <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nick Kossifidis <mick@ics.forth.gr>
Date: Fri, Apr 12, 2019 at 6:08 PM
To: Arnd Bergmann
Cc: Christoph Hellwig, Linus Torvalds, Andrew Morton, linux-arch,
<mick@ics.forth.gr>, Linux Kernel Mailing List

> =CE=A3=CF=84=CE=B9=CF=82 2019-04-12 17:53, Arnd Bergmann =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > On Fri, Apr 12, 2019 at 4:36 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> When removing some dead big endian checks in the RISC-V code Nick
> >> suggested that we should have some generic sanity checks.  I don't
> >> think
> >> we should have thos inside the RISC-V code, but maybe it might make
> >> sense to have these in the generic byteorder headers.  Note that these
> >> are UAPI headers and some compilers might not actually define
> >> __BYTE_ORDER__, so we first check that it actually exists.
> >>
> >> Suggested-by: Nick Kossifidis <mick@ics.forth.gr>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Extra checking like this is good in general, but I'm not sure I see
> > exactly what kind of issue one might expect to prevent with this:
> >
> > All architecture asm/byteorder.h headers either include the only
> > possible option, or they check the compiler defined macros:
> >
> > arch/arc/include/uapi/asm/byteorder.h:#ifdef __BIG_ENDIAN__
> > arch/arm/include/uapi/asm/byteorder.h:#ifdef __ARMEB__
> > arch/arm64/include/uapi/asm/byteorder.h:#ifdef __AARCH64EB__
> > arch/c6x/include/uapi/asm/byteorder.h:#ifdef _BIG_ENDIAN
> > arch/microblaze/include/uapi/asm/byteorder.h:#ifdef __MICROBLAZEEL__
> > arch/mips/include/uapi/asm/byteorder.h:#if defined(__MIPSEB__)
> > arch/nds32/include/uapi/asm/byteorder.h:#ifdef __NDS32_EB__
> > arch/powerpc/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
> > arch/sh/include/uapi/asm/byteorder.h:#ifdef __LITTLE_ENDIAN__
> > arch/xtensa/include/uapi/asm/byteorder.h:#ifdef __XTENSA_EL__
> >
> > Are you worried about toolchains that define those differently
> > from what these headers expect? Did you encounter such a case?
> >
> >       Arnd
>
> The following architectures just include the header file without
> checking for any compiler macro:
>
> alpha: little_endian.h
> csky: little_endian.h
> h8300: big_endian.h
> hexagon: little_endian.h
> ia64: little_endian.h
> m68k: big_endian.h
> nios2: little_endian.h
> openrisc: big_endian.h
> parisc: big_endian.h
> riscv: little_endian.h
> s390: big_endian.h
> sparc: big_endian.h
> unicore32: little_endian.h
> x86: little_endian.h
>
> Of those who do check for a compiler macro, they don't use the
> generic macros (__ORDER_*_ENDIAN__) but arch-specific ones.
>
> Only two architectures (mips and xtensa) that support both big
> and little endian return an error in case the endianess can't be
> determined, the rest will move on without including any
> of *_endian.h files.
>
> I think it's good to have a sanity check in-place for consistency.


Hi,

This broke our cross-builds from x86. I am using:

$ powerpc64le-linux-gnu-gcc --version
powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0

and it says that it's little-endian somehow:

$ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__

Is it broke compiler? Or I always hold it wrong? Is there some
additional flag I need to add?

Thanks
