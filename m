Return-Path: <linux-arch+bounces-1373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B582DCA1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54675283E5E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jan 2024 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C21774F;
	Mon, 15 Jan 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdZAE68O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19717BA1;
	Mon, 15 Jan 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so7005346276.0;
        Mon, 15 Jan 2024 07:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705333783; x=1705938583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL7TyLa6aUw4gCp8WNPrFTXBo1ubO4C/088ALvqvncI=;
        b=fdZAE68OFBp4GPejeD3x4tZhnc1JCB1IhT3IFWQgiBrlL5h1VsHznBc7VBg+1ZeLH8
         qrjbxPX7eZV1L1AD1qMJYQKjFqDETDjO61joQrfzwXuSKz/6ylxQdT4v+s4Nj6BJe/vn
         E/porRuOMaujnqEmxYJU0Jvw8fR2Hnbnk7NXkYFY8SkZ2M2EcdijdS9XfVs5ax2pw8Ny
         AbxIpKi+n3s1DdQTY7L/nTiTY/suC3AqOilH3ZjRhLISpya8DIo7dki2ryD9YjwGLqWR
         iPEz003Si2ZzzAvWw2+tmcaitYraYuMKwxczuoXXOnUc+C5Oycf7hcWGHSAAw99Ozcmx
         jygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333783; x=1705938583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL7TyLa6aUw4gCp8WNPrFTXBo1ubO4C/088ALvqvncI=;
        b=CS83+SMrmENV0G2exeyJDYQ7WWT7OsqybnKrt3s8cTjK/W62jwwPhZe4KzjW7WeqOP
         G7QsP52QgH7+Kx0IQYT4cUZbg1XIEgj5wVKJSYtEYf90xRO41rcrhQiVUbanSvYn4//N
         idzG+QQf4wSW5bqZkX3D/DL22H9DBCF1tOx/XvgKZYmytgpF7+Mjl6dkLfjF9uV1EKWd
         N3Am7d9Hi9PcHZobtbIJcYpJPix3nm3fXdK7659vrJfvMTa7RVCaeWDy25J8QlVDJKX1
         IPneGuw2jNaaSWVaBvIa4q33YEWSBprINe3L0aqXDFkBh3BYcw/qcurmIOTnyvrmtr75
         JcDA==
X-Gm-Message-State: AOJu0YyqUUij0LaN+TQBjFmDq9ll32MDNi08+V+MvjMCIJgP4sHzdLpP
	12tLPgiQqyED/tH/aZXo/9R4UdYAewEyeXD3Q4A=
X-Google-Smtp-Source: AGHT+IHRvjvqz812fgPuK5VrHIBc03d7H7tW5k/POpwadt/5R3fqa0Hh1ZXXjPW5NBRtuM6eFswRhIcAM5+PcEeg3oo=
X-Received: by 2002:a25:c503:0:b0:db7:dad0:76d2 with SMTP id
 v3-20020a25c503000000b00db7dad076d2mr2809380ybe.110.1705333783459; Mon, 15
 Jan 2024 07:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228122411.3189-1-maimon.sagi@gmail.com> <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
 <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com>
 <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com> <ZZ-ZNHgDsZwg9CaW@hoboy.vegasvil.org>
In-Reply-To: <ZZ-ZNHgDsZwg9CaW@hoboy.vegasvil.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 15 Jan 2024 17:49:32 +0200
Message-ID: <CAMuE1bF4sSeiDr-jyebF6F8oRxGs1b2gtT39fTJ2JeaFabr6Ng@mail.gmail.com>
Subject: Re: [PATCH v3] posix-timers: add multi_clock_gettime system call
To: Richard Cochran <richardcochran@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, tglx@linutronix.de, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Sohil Mehta <sohil.mehta@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Kees Cook <keescook@chromium.org>, 
	Alexey Gladkov <legion@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:31=E2=80=AFAM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Tue, Jan 02, 2024 at 12:29:59PM +0100, Arnd Bergmann wrote:
>
> > I think Andy's suggestion of exposing time offsets instead
> > of absolute times would actually achieve that: If the
> > interface is changed to return the offset against
> > CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW or CLOCK_BOOTTIME
> > (not sure what is best here), then the new syscall can use
> > getcrosststamp() where supported for the best results or
> > fall back to gettimex64() or gettime64() otherwise to
> > provide a consistent user interface.
>
> Yes, it makes more sense to provide the offset, since that is what the
> user needs in the end.
>
Make sense will be made on the next patch.
> Can we change the name of the system call to "clock compare"?
>
> int clock_compare(clockid_t a, clockid_t b,
>                   int64_t *offset, int64_t *error);
>
> returns: zero or error code,
>  offset =3D a - b
>  error  =3D maximum error due to asymmetry
>
> If clocks a and b are both System-V clocks, then *error=3D0 and *offset
> can be returned directly from the kernel's time keeping state.
>
> If getcrosststamp() is supported on a or b, then invoke it.
>
> otherwise do this:
>
>    t1 =3D gettime(a)
>    t2 =3D gettime(b)
>    t3 - gettime(c)
>
>    *offset =3D (t1 + t3)/2 - t2
>    *error  =3D (t3 - t1)/2
>
> There is no need for repeated measurement, since user space can call
> again when `error` is unacceptable.
>
Thanks for your notes, all of them will be done on the next patch (it
will take some time due to work overload).
The only question that I have is: why not implement it as an IOCTL?
It makes more sense to me since it is close to another IOCTL, the
"PTP_SYS_OFFSET" family.
Does it make sense to you?

> Thanks,
> Richard
>
>
>

