Return-Path: <linux-arch+bounces-9738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD3EA101A0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 09:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679607A2369
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C5243348;
	Tue, 14 Jan 2025 08:02:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926820459B;
	Tue, 14 Jan 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841774; cv=none; b=SoMGdu2KTa8cKPFHUKTseWThF4k2KbItL+1Qbl4Wb8VQHtMsKzOqHtdusJDRwdsFzAi3vN7bp6Bi8Jm7ZWswlzlmlXbzNplL932oEzrDlVhCpAV73mlCvZNqSmylKUYWnTasVwHIQ2nhpVKyeV7522gqLerR88hc/Avu9MyHsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841774; c=relaxed/simple;
	bh=Zll63eXNO2QAvFmvmN75gt1cRJvBd423Bw7F6vPWp2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrgWsiT5i2KqXs3TOdO9W9aP72AlGtXRAemaBLN72xOeuL3mRvVAKch06nzIvBWGQgHzUI6CT/iiTDsu4HR46rliZWFcdhYxEVdes44RSM4rQimW1CK8GnIiHeyqhnuoOgBTpA2w2IbAO5lXtSDUWWfi/uPquHrvu7PBdPSLZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afe1009960so1537122137.0;
        Tue, 14 Jan 2025 00:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736841771; x=1737446571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPH3xmnrAQMKppWrHm6XEQ0hv6/uq+sic9r21HtZWcU=;
        b=nhCo+n5NPuilK1ByGlearoau6J4i1o+XX9FdhNXPLqX63RLE40BAXx12iWVS/a0BUX
         EU0cSHJ/P7XiOsHTo569fUDWyL1p7C7BKwsYkwiKHp4CeV5a5nugJXExF2yRdHxPffH1
         E2VGVwNxhSlb8pp9xfbaGBw05xwfVfkDSI/8DuznfZ1KYeIosGdQhubvrIERSE/TJe7q
         g88QMY6TBdd0Cw49G9GhiWr9V96wQoLGcmhZV2rJmsDK/VxFWjvE4t0q0/ZyC4l31I0S
         rDkp68a7pVBWk14NGZavCgA8Nj2nZfQZO6v3hyapw8Kqrb3+6tAuK9MIO1ndnKvaFfTw
         AGDw==
X-Forwarded-Encrypted: i=1; AJvYcCV4dqRBj2dA5aWuW29yHcStu+7T7BmdjIVK2c+LRvfA09c2YAp297S4yxVAO0dsn3vp1DtsKMcohJkwtg==@vger.kernel.org, AJvYcCWVOLMaVZTDmoUMafY/MPDdyrtnk+Tj8u2q/n4peeWXNQ9zZKclx+uS1FBMTjNwuy5koHw5JJxJicd3rAJn@vger.kernel.org, AJvYcCWi+Vuz0FzRsSkfSv5imkx6REiA9YhmwHl9mrdaM2Aipz6N21sT4SX/zXRd3G5EDmzPCTW0n2f573Oq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywguaht4dyve/q/s4pljH6SiwBum3v3D3gEHgHpfVmpYKOUFzeN
	/1kV4vwsTr0Qo+JIzGkPp+DbnZma4MF7Cknw2gL1R+JSHdeZDGcYNkH5NrdZUvo=
X-Gm-Gg: ASbGnct/7Uun+6MMFl8iot2NXwd36DH45XY2EvqfHEsG6b+yooE86Agm0bWcj5l/nyr
	4ciEwt1cRUokO4ayw/Pv7bi3fKBQibiO4ckZ5s5Fdkpc0dT17fJgR3hksmtmF3P6Yi79zp6xVGe
	BRnnl7zEJVW+LhUzGZ4KKEkrp9FkDllGtZWgiYo2lprxEQo3M2LAXdjkoNUN4W7rrSymEZ8lRBV
	rWXneuY3e6UfZ0dgUevdwiAlZVlDyZ9gclNc/trpEccLefUoDOJo4bm1zb+nJM6hmaVHLjLocuL
	pVCpBX+4U7T3gpOTtDM=
X-Google-Smtp-Source: AGHT+IG8lcgcasrcHkYCLVoAkJzm7C8eAX2ly+r3sXBOHVHDBx+UDCkCVDvk3aMGoO5a7aC1YW0K8A==
X-Received: by 2002:a05:6102:c12:b0:4b1:1a11:fe3 with SMTP id ada2fe7eead31-4b3d0f15e35mr19990471137.8.1736841770743;
        Tue, 14 Jan 2025 00:02:50 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623138542csm5191705241.16.2025.01.14.00.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 00:02:50 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4afdf8520c2so1712778137.2;
        Tue, 14 Jan 2025 00:02:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeTw56XlKsWO50UxREh6509Zyf5aA23wZNWzsw91V7m5qpGJwvDGzVLWCfJUHq4Ws5EcNJdt8vYj7eJFuE@vger.kernel.org, AJvYcCVm6IQnbcfsR7fCEKPl5g/4pcaCAmdQzYlak9DEfvVgHf9Ak4PLhYk0YqvN37FjFIdF/vs/zUL01zKV@vger.kernel.org, AJvYcCWV9ScbPKUEKDBiS/x9xyTyxUChc0G3jtkeSUqmBQycf7dQma9GRc9ev/LqOZlaGGYAZZPQzAsKzzX5BQ==@vger.kernel.org
X-Received: by 2002:a05:6102:800c:b0:4b2:5c0a:98b7 with SMTP id
 ada2fe7eead31-4b3d0ef99c6mr19475014137.6.1736841770305; Tue, 14 Jan 2025
 00:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <90b5b76d-25b6-4cdc-91ed-07ac930dc519@o2.pl> <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
In-Reply-To: <99f75c66-4c2d-45dc-a808-b5ba440c7551@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jan 2025 09:02:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
X-Gm-Features: AbW1kvYWpDfd-Jt6OXPDpL-6dQwJj4vhkjQrnnr9n-FYlBXBkY9K_gokUiz_wXA
Message-ID: <CAMuHMdXbuRLgDP2JtmdhnJF=AhpPa88356KU1yF1f8GMirWrcQ@mail.gmail.com>
Subject: Re: [REGRESSION] mipsel: no RTC CMOS on the Malta platform in QEMU
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxun,

On Tue, Jan 14, 2025 at 12:32=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
> =E5=9C=A82025=E5=B9=B41=E6=9C=8813=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=
=E5=8D=8810:16=EF=BC=8CMateusz Jo=C5=84czyk=E5=86=99=E9=81=93=EF=BC=9A
> > On Linux 6.13-rc6 for mipsel in QEMU on the Malta platform, the RTC CMO=
S
> > driver does not load and /sys/class/rtc is empty. I have tested this wi=
th
> > "make malta_defconfig", which compiles this driver into the kernel
> > (CONFIG_RTC_DRV_CMOS=3Dy).
>
> Hi Mateusz,
>
> Thanks for tracking it down, this is indeed a huge effort.
>
> >
> > I have bisected this down to:
> >
> > commit 4bfb53e7d317c01f296b2feb2fae7c421c1d52dc
> > Author: Jiaxun Yang<jiaxun.yang@flygoat.com>
> > Date:   Thu Sep 21 19:04:22 2023 +0800
> >
> >      mips: add <asm-generic/io.h> including
> >      With the adding, some default ioremap_xx methods defined in
> >      asm-generic/io.h can be used. E.g the default ioremap_uc() returni=
ng
> >      NULL.
> >      We also massaged various headers to avoid nested includes.
>
> #regzbot introduced: 4bfb53e7d317c01f296b2feb2fae7c421c1d52dc
>
> >
> > I have tried to debug this.
> >
> > The fallout is apparently limited to the CMOS RTC driver, other
> > drivers that access IO ports seem to function correctly (e.g. the
> > PATA driver). Also, the read_persistent_clock64 function in
> > arch/mips/mti-malta/malta-time.c, which accesses the same hardware
> > works correctly.
> >
> > The CMOS RTC driver is likely special because this device is defined
> > in a devicetree (arch/mips/boot/dts/mti/malta.dts) and there it is
> > the only defined device on the ISA bus.
> >
> > That driver fails to load because the call to
> >
> > platform_get_resource(pdev, IORESOURCE_IO, 0);
> >
> > in cmos_platform_probe in drivers/rtc/rtc-cmos.c returns NULL.
> >
> > The mediator seems to be that this bad commit causes
> > arch/mips/include/asm/io.h
> > to #include <asm-generic/io.h> at the end. As a side effect, this cause=
s
> > the PCI_IOBASE macro to be defined:
> >
> > #ifndef PCI_IOBASE
> > #define PCI_IOBASE ((void __iomem *)0)
> > #endif
> >
> > That PCI_IOBASE value above is AFAIK incorrect for MIPS (it should be
> > defined to mips_io_port_base as far as I can tell), but this does not
> > matter much here.
>
> You are right, this is what should be done.
>
> A quick fix would be #undef PCI_IOBASE in arch/mips/include/asm/io.h
> just after including #include <asm-generic/io.h>, with ralink and loongso=
n64
> as exception.

Shouldn't arch/mips/include/asm/io.h do

    #define PCI_IOBASE mips_io_port_base

unconditionally, _before_ including  <asm-generic/io.h>?

> In the long term, we should scrutinize platform usage of mips_io_base
> following ralink's approach.

Currently ralink handles that in a mach-specific include:

    arch/mips/include/asm/mach-ralink/spaces.h:#define PCI_IOBASE
mips_io_port_base

Loongson does it differently:

    arch/mips/include/asm/mach-loongson64/spaces.h:#define PCI_IOBASE
     _AC(0xc000000000000000 + SZ_128K, UL)

But still sets mips_io_port_base in prom_init():

    arch/mips/loongson64/init.c:    set_io_port_base(PCI_IOBASE);

so defining PCI_IOBASE to mips_io_port_base in the main <asm/io.h>
should work.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

