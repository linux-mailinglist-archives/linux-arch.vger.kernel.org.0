Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0060D2F3F2D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 01:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438264AbhALWR1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 17:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437162AbhALWPu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2021 17:15:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76697C061786
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 14:15:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j13so2614741pjz.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhnukL1HPTPi6q2zbr4puLoBhBCe2P2AwxIRemVRymc=;
        b=EJfTsZQKHuUylDhc2a3L26Ufj9285XUugVAQBnkxKjexW9O9s9jCQsqSN+Di8cajY+
         c7zf2X9PChzEOYDb5ihMlYJAJkNVFbJX+cgll4R2E/kJcXtWbDgTTCedlwj+D6Fot1J8
         5hvCs8oFebwoO6xBhy1XAUhcZMgYBej1u7qxDWuqpwXbYmqk9vQ0ePwJs+rgbYQbVNKu
         7Eg2IQx1syKzhzr1Dwb7+hRRPxQlrMLR+gA7S+l/aZ+RH0xVLU4ZpJo4wlRw6VWZ+GMs
         a7yioK7QxGRgroGBRREad9QZDnXJPBFVme3fwJzb2NtfFMG8mZ0ewpcnUfpmo0snEWG/
         hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhnukL1HPTPi6q2zbr4puLoBhBCe2P2AwxIRemVRymc=;
        b=XtuT9P6JaAUzRkDAirQVwfJ5CAzDsIFZ/Iig2PtQVDKNegD4SmaDgOjnrcgLARQwVZ
         cuDRhA+DA5QUqflDe0s6wDmVxb16p3JEEGUMloOKLQ3ZPH4xvlblgke2NZSzq0Xg2Kjb
         ylN2tuYIEZpKEBJ7AILnirdQdkjJPkvMVzOvse24XSwlTbZmbtfW259Zt4UtRr/DQyIm
         Vq6wnGDab/g+buxS8+3A96De4C2CkdOWD4QUf/65j2K0THD5Mny+hrLTTBOuoCXC1tjj
         bEE/u3hThNzBgP9/+0k4/d8LV9EvxdwdvQcUjF+mCZAyorDaw8mddwj66Q8GdjdZTxD0
         tWJg==
X-Gm-Message-State: AOAM533BuLxXIcJy+T0a8P87K6LVaBwuV0KFaczZMstN+6EYC97G4VKJ
        7y4MdwV9IP5JhiHLGHjCeFaaQi0WK2//li5TVisWiQ==
X-Google-Smtp-Source: ABdhPJy2QAJbAV2gULeT4IYZ+//Gp1OU3DReT9cweqkVXaa0WY6uCsOD2rAaE5As7CWTtmSwMTJq5DiiYYV6nVum4h8=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr1257503plc.10.1610489709764; Tue, 12 Jan
 2021 14:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20210109171058.497636-1-alobakin@pm.me> <CAKwvOdmV2tj4Uyz1iDkqCj+snWPpnnAmxJyN+puL33EpMRPzUw@mail.gmail.com>
 <20210109191457.786517-1-alobakin@pm.me> <CAKwvOdnOXXaz+S1agu5kCQLm+qEkXE2Hpd2_V8yPsbUTQH7JZw@mail.gmail.com>
 <20210111204936.17905-1-alobakin@pm.me>
In-Reply-To: <20210111204936.17905-1-alobakin@pm.me>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jan 2021 14:14:58 -0800
Message-ID: <CAKwvOdnvd1NaBQEJ0fPsYiGff4=tUdrcuAR0no9FUMqnOZSu6Q@mail.gmail.com>
Subject: Re: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001150b305b8bb5be1"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000001150b305b8bb5be1
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 11, 2021 at 12:50 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> > The disassembly for me produces:
> >     399c: 3c 03 00 00   lui     $3, 0 <phy_device_free>
> >                         0000399c:  R_MIPS_HI16  .text
> > ...
> >     39a8: 24 63 3a 5c   addiu   $3, $3, 14940 <phy_probe>
> >                         000039a8:  R_MIPS_LO16  .text
>
> So, in your case the values of the instructions that relocs refer are:
>
> 0x3c030000 R_MIPS_HI16
> 0x24633a5c R_MIPS_LO16
>
> Mine were:
>
> 0x3c010000
> 0x24339444
>
> Your second one doesn't have bit 15 set, so I think this pair won't
> break the code.
> Try to hunt for R_MIPS_LO16 that have this bit set, i.e. they have
> '8', '9', 'a', 'b', 'c', 'd' or 'e' as their [15:12].

I don't think any of my R_MIPS_LO16 in that file have that bit set.
See attached.
-- 
Thanks,
~Nick Desaulniers

--0000000000001150b305b8bb5be1
Content-Type: text/plain; charset="US-ASCII"; name="drivers_net_phy_phy_device.objdump.txt"
Content-Disposition: attachment; 
	filename="drivers_net_phy_phy_device.objdump.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kjujyfyf0>
X-Attachment-Id: f_kjujyfyf0

CQkJMDAwMDAwNGM6ICBSX01JUFNfTE8xNglrbWFsbG9jX2NhY2hlcwoJCQkwMDAwMDA4ODogIFJf
TUlQU19MTzE2CS5kYXRhCgkJCTAwMDAwMDk4OiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAwMDAx
MGM6ICBSX01JUFNfTE8xNglrbWFsbG9jX2NhY2hlcwoJCQkwMDAwMDEzMDogIFJfTUlQU19MTzE2
CSQuc3RyCgkJCTAwMDAwMTRjOiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAwMDAxNWM6ICBSX01J
UFNfTE8xNgkuZGF0YQoJCQkwMDAwMDFjNDogIFJfTUlQU19MTzE2CWttYWxsb2NfY2FjaGVzCgkJ
CTAwMDAwMjA0OiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAwMDAyMTQ6ICBSX01JUFNfTE8xNgku
ZGF0YQoJCQkwMDAwMDI5MDogIFJfTUlQU19MTzE2CS5kYXRhCgkJCTAwMDAwMmEwOiAgUl9NSVBT
X0xPMTYJLmRhdGEKCQkJMDAwMDAyYTQ6ICBSX01JUFNfTE8xNgkuZGF0YQoJCQkwMDAwMDM4NDog
IFJfTUlQU19MTzE2CS5kYXRhCgkJCTAwMDAwMzk0OiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAw
MDAzOTg6ICBSX01JUFNfTE8xNgkuZGF0YQoJCQkwMDAwMDNhYzogIFJfTUlQU19MTzE2CSQuc3Ry
CgkJCTAwMDAwNDc0OiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAwMDA0ODQ6ICBSX01JUFNfTE8x
NgkuZGF0YQoJCQkwMDAwMDQ4ODogIFJfTUlQU19MTzE2CS5kYXRhCgkJCTAwMDAwNTVjOiAgUl9N
SVBTX0xPMTYJa21hbGxvY19jYWNoZXMKCQkJMDAwMDA1ODg6ICBSX01JUFNfTE8xNgltZGlvX2J1
c190eXBlCgkJCTAwMDAwNWE0OiAgUl9NSVBTX0xPMTYJLnRleHQKCQkJMDAwMDA1YTg6ICBSX01J
UFNfTE8xNgkudGV4dAoJCQkwMDAwMDVhYzogIFJfTUlQU19MTzE2CS50ZXh0CgkJCTAwMDAwNWI0
OiAgUl9NSVBTX0xPMTYJLnJvZGF0YQoJCQkwMDAwMDYzODogIFJfTUlQU19MTzE2CSQuc3RyLjEK
CQkJMDAwMDA2NWM6ICBSX01JUFNfTE8xNgkkLnN0ci4yCgkJCTAwMDAwNjY0OiAgUl9NSVBTX0xP
MTYJLnNic3MKCQkJMDAwMDA2ODQ6ICBSX01JUFNfTE8xNglkZWxheWVkX3dvcmtfdGltZXJfZm4K
CQkJMDAwMDA2ODg6ICBSX01JUFNfTE8xNglwaHlfc3RhdGVfbWFjaGluZQoJCQkwMDAwMDk5ODog
IFJfTUlQU19MTzE2CSQuc3RyLjYyCgkJCTAwMDAwOWY4OiAgUl9NSVBTX0xPMTYJJC5zdHIuNjMK
CQkJMDAwMDBhNTA6ICBSX01JUFNfTE8xNglfX3N0YWNrX2Noa19ndWFyZAoJCQkwMDAwMGQ4NDog
IFJfTUlQU19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAwZTNjOiAgUl9NSVBTX0xPMTYJ
JC5zdHIuMwoJCQkwMDAwMGU0YzogIFJfTUlQU19MTzE2CSQuc3RyLjQKCQkJMDAwMDBlYTQ6ICBS
X01JUFNfTE8xNgkuZGF0YQoJCQkwMDAwMGViNDogIFJfTUlQU19MTzE2CS5kYXRhCgkJCTAwMDAw
ZWI4OiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAwMDBlZDA6ICBSX01JUFNfTE8xNgkkLnN0cgoJ
CQkwMDAwMTE2NDogIFJfTUlQU19MTzE2CS50ZXh0CgkJCTAwMDAxMWFjOiAgUl9NSVBTX0xPMTYJ
JC5zdHIuMTkKCQkJMDAwMDExYzg6ICBSX01JUFNfTE8xNgkkLnN0ci4xOAoJCQkwMDAwMTFmNDog
IFJfTUlQU19MTzE2CWdlbnBoeV9jNDVfZHJpdmVyCgkJCTAwMDAxMWZjOiAgUl9NSVBTX0xPMTYJ
LmRhdGEKCQkJMDAwMDEyODA6ICBSX01JUFNfTE8xNgkuZGF0YQoJCQkwMDAwMTNlNDogIFJfTUlQ
U19MTzE2CSQuc3RyLjE1CgkJCTAwMDAxNDA0OiAgUl9NSVBTX0xPMTYJJC5zdHIuMTYKCQkJMDAw
MDE0NDQ6ICBSX01JUFNfTE8xNgkkLnN0ci4xNAoJCQkwMDAwMTQ1YzogIFJfTUlQU19MTzE2CSQu
c3RyLjE3CgkJCTAwMDAxNDc4OiAgUl9NSVBTX0xPMTYJJC5zdHIuNjQKCQkJMDAwMDE0YzA6ICBS
X01JUFNfTE8xNgltZGlvX2J1c190eXBlCgkJCTAwMDAxNGM4OiAgUl9NSVBTX0xPMTYJZGV2aWNl
X21hdGNoX25hbWUKCQkJMDAwMDE1Njg6ICBSX01JUFNfTE8xNgkkLnN0ci41CgkJCTAwMDAxNWY0
OiAgUl9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAwMDE2MjQ6ICBSX01JUFNfTE8x
NgkkLnN0ci4xOAoJCQkwMDAwMTYyYzogIFJfTUlQU19MTzE2CSQuc3RyLjE5CgkJCTAwMDAxNjQ4
OiAgUl9NSVBTX0xPMTYJLmRhdGEKCQkJMDAwMDE2NjA6ICBSX01JUFNfTE8xNgkucm9kYXRhCgkJ
CTAwMDAxNjY4OiAgUl9NSVBTX0xPMTYJLnJvZGF0YQoJCQkwMDAwMTcwYzogIFJfTUlQU19MTzE2
CS5kYXRhCgkJCTAwMDAxNzNjOiAgUl9NSVBTX0xPMTYJZ2VucGh5X2M0NV9kcml2ZXIKCQkJMDAw
MDE3OTQ6ICBSX01JUFNfTE8xNglfX3N0YWNrX2Noa19ndWFyZAoJCQkwMDAwMTkwMDogIFJfTUlQ
U19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAxOTMwOiAgUl9NSVBTX0xPMTYJJC5zdHIu
NwoJCQkwMDAwMTkzYzogIFJfTUlQU19MTzE2CSQuc3RyLjYKCQkJMDAwMDE5NDQ6ICBSX01JUFNf
TE8xNgkkLnN0ci44CgkJCTAwMDAxOTVjOiAgUl9NSVBTX0xPMTYJJC5zdHIuOQoJCQkwMDAwMTk4
NDogIFJfTUlQU19MTzE2CSQuc3RyLjEwCgkJCTAwMDAxOThjOiAgUl9NSVBTX0xPMTYJJC5zdHIu
MTEKCQkJMDAwMDE5OTg6ICBSX01JUFNfTE8xNgkkLnN0ci4xMgoJCQkwMDAwMTliMDogIFJfTUlQ
U19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAxYTEwOiAgUl9NSVBTX0xPMTYJX19zdGFj
a19jaGtfZ3VhcmQKCQkJMDAwMDFhMWM6ICBSX01JUFNfTE8xNgkkLnN0ci4xMAoJCQkwMDAwMWEy
NDogIFJfTUlQU19MTzE2CSQuc3RyLjExCgkJCTAwMDAxYTUwOiAgUl9NSVBTX0xPMTYJJC5zdHIu
NwoJCQkwMDAwMWE1YzogIFJfTUlQU19MTzE2CSQuc3RyLjYKCQkJMDAwMDFhNjQ6ICBSX01JUFNf
TE8xNgkkLnN0ci44CgkJCTAwMDAxYTgwOiAgUl9NSVBTX0xPMTYJJC5zdHIuOQoJCQkwMDAwMWFi
MDogIFJfTUlQU19MTzE2CSQuc3RyLjEyCgkJCTAwMDAxYWUwOiAgUl9NSVBTX0xPMTYJJC5zdHIu
MTMKCQkJMDAwMDFiMGM6ICBSX01JUFNfTE8xNglfX3N0YWNrX2Noa19ndWFyZAoJCQkwMDAwMWI1
YzogIFJfTUlQU19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAxYjg4OiAgUl9NSVBTX0xP
MTYJJC5zdHIuNwoJCQkwMDAwMWI5NDogIFJfTUlQU19MTzE2CSQuc3RyLjYKCQkJMDAwMDFiOWM6
ICBSX01JUFNfTE8xNgkkLnN0ci44CgkJCTAwMDAxYmI0OiAgUl9NSVBTX0xPMTYJJC5zdHIuOQoJ
CQkwMDAwMWJjNDogIFJfTUlQU19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAxZDYwOiAg
Ul9NSVBTX0xPMTYJbWRpb19idXNfdHlwZQoJCQkwMDAwMWQ2ODogIFJfTUlQU19MTzE2CWRldmlj
ZV9tYXRjaF9uYW1lCgkJCTAwMDAxZGVjOiAgUl9NSVBTX0xPMTYJJC5zdHIuNQoJCQkwMDAwMWUz
NDogIFJfTUlQU19MTzE2CS5kYXRhCgkJCTAwMDAxZTkwOiAgUl9NSVBTX0xPMTYJZ2VucGh5X2M0
NV9kcml2ZXIKCQkJMDAwMDFmNzA6ICBSX01JUFNfTE8xNglrbWFsbG9jX2NhY2hlcwoJCQkwMDAw
MjBkYzogIFJfTUlQU19MTzE2CS50ZXh0CgkJCTAwMDAyMjE4OiAgUl9NSVBTX0xPMTYJX19zdGFj
a19jaGtfZ3VhcmQKCQkJMDAwMDIyMjQ6ICBSX01JUFNfTE8xNgkucm9kYXRhCgkJCTAwMDAyMjQ4
OiAgUl9NSVBTX0xPMTYJLnJvZGF0YQoJCQkwMDAwMjJkMDogIFJfTUlQU19MTzE2CV9fc3RhY2tf
Y2hrX2d1YXJkCgkJCTAwMDAyNjU4OiAgUl9NSVBTX0xPMTYJLnJvZGF0YQoJCQkwMDAwMjg3MDog
IFJfTUlQU19MTzE2CSQuc3RyLjY2CgkJCTAwMDAyYzg4OiAgUl9NSVBTX0xPMTYJJC5zdHIuMjEK
CQkJMDAwMDJjYTA6ICBSX01JUFNfTE8xNgkkLnN0ci4yMAoJCQkwMDAwMzIxODogIFJfTUlQU19M
TzE2CSQuc3RyLjY3CgkJCTAwMDAzMjIwOiAgUl9NSVBTX0xPMTYJJF9fZnVuY19fLnBoeV9wb2xs
X3Jlc2V0CgkJCTAwMDAzM2ZjOiAgUl9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAw
MDM0NzQ6ICBSX01JUFNfTE8xNglfX3N0YWNrX2Noa19ndWFyZAoJCQkwMDAwMzRjMDogIFJfTUlQ
U19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAzNTEwOiAgUl9NSVBTX0xPMTYJX19zdGFj
a19jaGtfZ3VhcmQKCQkJMDAwMDM2Mjg6ICBSX01JUFNfTE8xNglfX3N0YWNrX2Noa19ndWFyZAoJ
CQkwMDAwMzY4ODogIFJfTUlQU19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDAzNzc4OiAg
Ul9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAwMDM3OTA6ICBSX01JUFNfTE8xNgkk
LnN0ci4yMgoJCQkwMDAwMzdkMDogIFJfTUlQU19MTzE2CSQuc3RyLjIzCgkJCTAwMDAzOGMwOiAg
Ul9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAwMDM5MDQ6ICBSX01JUFNfTE8xNgkk
LnN0ci4yNAoJCQkwMDAwMzkyMDogIFJfTUlQU19MTzE2CSQuc3RyLjI1CgkJCTAwMDAzOTM4OiAg
Ul9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAwMDM5YTQ6ICBSX01JUFNfTE8xNglt
ZGlvX2J1c190eXBlCgkJCTAwMDAzOWE4OiAgUl9NSVBTX0xPMTYJLnRleHQKCQkJMDAwMDM5YWM6
ICBSX01JUFNfTE8xNgkudGV4dAoJCQkwMDAwMzliMDogIFJfTUlQU19MTzE2CS50ZXh0CgkJCTAw
MDAzYTE4OiAgUl9NSVBTX0xPMTYJJC5zdHIuMjgKCQkJMDAwMDNhMzA6ICBSX01JUFNfTE8xNgkk
LnN0ci4yNgoJCQkwMDAwM2E1MDogIFJfTUlQU19MTzE2CSQuc3RyLjI3CgkJCTAwMDAzYTc4OiAg
Ul9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAwMDNjODQ6ICBSX01JUFNfTE8xNglf
X3N0YWNrX2Noa19ndWFyZAoJCQkwMDAwM2U5YzogIFJfTUlQU19MTzE2CSQuc3RyLjMxCgkJCTAw
MDAzZWU0OiAgUl9NSVBTX0xPMTYJLnJvZGF0YQoJCQkwMDAwM2YwMDogIFJfTUlQU19MTzE2CSQu
c3RyLjMzCgkJCTAwMDAzZjA4OiAgUl9NSVBTX0xPMTYJJC5zdHIuNTkKCQkJMDAwMDNmMTA6ICBS
X01JUFNfTE8xNgkkLnN0ci4zNAoJCQkwMDAwM2YzYzogIFJfTUlQU19MTzE2CSQuc3RyLjYxCgkJ
CTAwMDAzZjc4OiAgUl9NSVBTX0xPMTYJX19zdGFja19jaGtfZ3VhcmQKCQkJMDAwMDQwMTQ6ICBS
X01JUFNfTE8xNgkucm9kYXRhCgkJCTAwMDA0MDM4OiAgUl9NSVBTX0xPMTYJLnJvZGF0YQoJCQkw
MDAwNDBlYzogIFJfTUlQU19MTzE2CV9fc3RhY2tfY2hrX2d1YXJkCgkJCTAwMDA0MmU4OiAgUl9N
SVBTX0xPMTYJJC5zdHIuNjEKCQkJMDAwMDAwMTA6ICBSX01JUFNfTE8xNglnZW5waHlfYzQ1X2Ry
aXZlcgoJCQkwMDAwMDAxYzogIFJfTUlQU19MTzE2CS5kYXRhCgkJCTAwMDAwMDI4OiAgUl9NSVBT
X0xPMTYJLnJvZGF0YQoJCQkwMDAwMDAzMDogIFJfTUlQU19MTzE2CXBoeV9iYXNpY190MV9mZWF0
dXJlcwoJCQkwMDAwMDA0NDogIFJfTUlQU19MTzE2CXBoeV9nYml0X2ZlYXR1cmVzCgkJCTAwMDAw
MDQ4OiAgUl9NSVBTX0xPMTYJcGh5X2diaXRfZmlicmVfZmVhdHVyZXMKCQkJMDAwMDAwNTQ6ICBS
X01JUFNfTE8xNglwaHlfZ2JpdF9hbGxfcG9ydHNfZmVhdHVyZXMKCQkJMDAwMDAwNjA6ICBSX01J
UFNfTE8xNglwaHlfMTBnYml0X2ZlYXR1cmVzCgkJCTAwMDAwMDc0OiAgUl9NSVBTX0xPMTYJcGh5
XzEwZ2JpdF9mdWxsX2ZlYXR1cmVzCgkJCTAwMDAwMDg0OiAgUl9NSVBTX0xPMTYJcGh5X2Jhc2lj
X3QxX2ZlYXR1cmVzCgkJCTAwMDAwMDkwOiAgUl9NSVBTX0xPMTYJcGh5X2Jhc2ljX2ZlYXR1cmVz
CgkJCTAwMDAwMDk4OiAgUl9NSVBTX0xPMTYJcGh5X2Jhc2ljX2ZlYXR1cmVzCgkJCTAwMDAwMDlj
OiAgUl9NSVBTX0xPMTYJcGh5X2Jhc2ljX3QxX2ZlYXR1cmVzCgkJCTAwMDAwMGE0OiAgUl9NSVBT
X0xPMTYJcGh5X2diaXRfZmVhdHVyZXMKCQkJMDAwMDAwYTg6ICBSX01JUFNfTE8xNglwaHlfZ2Jp
dF9maWJyZV9mZWF0dXJlcwoJCQkwMDAwMDBhYzogIFJfTUlQU19MTzE2CXBoeV9nYml0X2FsbF9w
b3J0c19mZWF0dXJlcwoJCQkwMDAwMDBiMDogIFJfTUlQU19MTzE2CXBoeV8xMGdiaXRfZmVhdHVy
ZXMKCQkJMDAwMDAwYjg6ICBSX01JUFNfTE8xNglwaHlfMTBnYml0X2Z1bGxfZmVhdHVyZXMKCQkJ
MDAwMDAwYzA6ICBSX01JUFNfTE8xNglwaHlfMTBnYml0X2ZlY19mZWF0dXJlcwoJCQkwMDAwMDBj
YzogIFJfTUlQU19MTzE2CXBoeV8xMGdiaXRfZmVjX2ZlYXR1cmVzCgkJCTAwMDAwMGQ0OiAgUl9N
SVBTX0xPMTYJZ2VucGh5X2M0NV9kcml2ZXIKCQkJMDAwMDAwZjA6ICBSX01JUFNfTE8xNgkuZGF0
YQoJCQkwMDAwMDExMDogIFJfTUlQU19MTzE2CWdlbnBoeV9jNDVfZHJpdmVyCg==
--0000000000001150b305b8bb5be1--
