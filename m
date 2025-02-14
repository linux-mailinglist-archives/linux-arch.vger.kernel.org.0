Return-Path: <linux-arch+bounces-10144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB77A35395
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 02:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFE17A3EBA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2025 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166C15464E;
	Fri, 14 Feb 2025 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxK4asBA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340793C17;
	Fri, 14 Feb 2025 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495897; cv=none; b=UxF6JKagtyBAouxSqhVLD/0UICn4DZL11jtFYo8ODOO2kYlEk0MgosxsBSeFUjJu1pXifBZwCV4UHpv37gqRw7MiOgnubtYwF654++BMKS2MfztmunOuRNpCnPxfRzOXb5Sea6M0P2SXP3PYXS0A9qfEW0pCLGGZYbyddz3Ow54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495897; c=relaxed/simple;
	bh=7KmvRdNkOB8Mr3YZotzrxWe4W/LaMjQF7NLNIhjtF3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJlJNQkODJOS5M45SewxB58lbGSQzyNo50P0rg6RqoaQBItMkcXjgV2NEsm/dSEjMYl98R/4DmbIGc5wEeoFzLtZjIoUKxdVgQnojzfs+cjB1ucUzoeBLt4ybQD911p6Gng3w9PN+KdBBx06S8wtlUq7jWSVOC0j8g2Q6gEEAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxK4asBA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so1298582f8f.3;
        Thu, 13 Feb 2025 17:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739495893; x=1740100693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZNgfoJpdQnnYrxgyLyaeefs7r2kSe1cqjB7lzYuaOY=;
        b=LxK4asBATP1MeRU6Tug/wM5pDWexWygZDRfTC/vbdHU3zlvgXNcHgoKtsv/N7i/QUi
         yHStzkJ9EXSAWeLe35ysovgUPeLF0lMz8BiU8Ei8q8NUF6CoRsoXbwZjD2CJGe1Jehep
         /YphwX+NCcwrkQc9M+tUL1orVmCND1wwWjN8dEsFw3+PrmnJS6PNxUzoQ7yPqtcn2Ys2
         noBbHtyL8GMwygxk/k5jiVcUDBi+oQ1ZUtR5qSpzis1AgBjt6vlXOZ7SUmcCySnsNSWD
         nOLKldd9c8X7fdnygej1AWYDwZoKHee5p6EGmreiir7QXwCsGysJuesfJ4cQpijobsyg
         BYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739495893; x=1740100693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZNgfoJpdQnnYrxgyLyaeefs7r2kSe1cqjB7lzYuaOY=;
        b=K9sz0Ifzh0KhZlYa/s2qoGXTbK1FnvCwvcIYJy3oVE9tUF98o6M4G/Ews2E/g/AS8T
         uFnaKe/IlooekVw4fR5MlQGgIdIJNLFccitP+/PLTqody4Ja6sFOlqNJiLQINsETeXZv
         RuR4alLglorvqnpUgpTefbtngDnp638g21a2+WrSH4ZnE/NW3R0AkKuPloje9pNWSVnA
         HG2As89iXIpEDnI1w17j5VWJNnQ/cfALT9Ozm5wM6t4+vcqy61O7CL2IukEf8geeBbnb
         8ypJcah44wWBP/Af9FVXMSJ10bxOWlDv20uD4RBOUvKISx+i07BZzHa8kfEp+5x9chOJ
         z2jg==
X-Forwarded-Encrypted: i=1; AJvYcCUIpVd5AYtEBCT0qaPbKvkpNNo6y2wDNR2Degx/QbYsLqjsLeIt7zidDeqVOG6RYVQeEvg=@vger.kernel.org, AJvYcCUMKQNpgipCLbMF7bAhixEJtcfPA+8jMD0V/TkMFS/Kn8GgZVBIu7jktE0bY+LTtzx/nb9hpWdeFrAhlQna@vger.kernel.org, AJvYcCUsHeDl7o90oPtinSl3Jsnk9mIZUqnwOpDzJS29GzOe05vOIx1m8IVDZgXdrbMrY7Xb5Sbr5+Y4pUFU4A==@vger.kernel.org, AJvYcCVXkEp4S1oFJ9zTiEVpV0l0EAoB1w8909YK9AoP3/Bel/goHAOzdNfhwsoD7qySO9ve+wl9cnHge3FIDlPA6boy@vger.kernel.org, AJvYcCXg7blZmWnYhHKW73CD0ZBnEDFdt6uBmDkKUKZc7FtzNBcAsTEL5eh6bbfn7lxIEzPXdhUo+RFnniCbKh6x@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNqWKlSD3k+48L4bgacxvB5kK0HBa3VAeMGK41yAJQI80/kVK
	8YObXNpHJVK7k9H9t4AidUuJMCmwGaRJ+61tB5n0fCFlxV+G19LcoRsMeF1Th1TpM+Wii3PVWdp
	y+mOI7xBgxoMrIrhu3ye4Btjf5q+k6T/F
X-Gm-Gg: ASbGnctEuk7Q3/s571M2HWEEyj3kOZogI6Xaio0Us2yfa/wwO/xVXBsJwgMjwVARHzf
	03jwEodQFksPjZK2cmt7D2uU/B3yzvWuQIchF3TkiFr1fwKARAsbaOZCODbxBA/YFtStmn2lCCL
	Xr8lCWQRJZvPgAHkjpva6l6Fj4H4wM
X-Google-Smtp-Source: AGHT+IHjH3HbrV6sFGnOweivEcys63M8NcPKfcX22oOSM82lFAdrwn46q5GI7CB4DnW7A34GOs2t+/KwcM7+WXRkatg=
X-Received: by 2002:a05:6000:1f88:b0:38d:dd8c:51db with SMTP id
 ffacd0b85a97d-38dea2f982dmr10477713f8f.53.1739495893060; Thu, 13 Feb 2025
 17:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com> <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <87a5asghj2.fsf@oracle.com>
In-Reply-To: <87a5asghj2.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 17:18:02 -0800
X-Gm-Features: AWEUYZko1eBho3JB_JCiwey_VkI40uEQrrVuLZrlphS9FJjF_Fxjtl4z_U1OGOk
Message-ID: <CAADnVQKLykG3akdPRTDgHDey9FW1LpixZHjLcj+eG2rhXo7V1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Sami Tolvanen <samitolvanen@google.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:59=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > On Thu, Feb 6, 2025 at 5:21=E2=80=AFPM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >> When the feature was implemented in pahole, my measurements indicated
> >> that vmlinux BTF size increased by about 25.8%, and module BTF size
> >> increased by 53.2%. Due to these increases, the feature is implemented
> >> behind a new config option, allowing users sensitive to increased memo=
ry
> >> usage to disable it.
> >>
> >
> > ...
> >> +config DEBUG_INFO_BTF_GLOBAL_VARS
> >> +       bool "Generate BTF type information for all global variables"
> >> +       default y
> >> +       depends on DEBUG_INFO_BTF && PAHOLE_VERSION >=3D 128
> >> +       help
> >> +         Include type information for all global variables in the BTF=
. This
> >> +         increases the size of the BTF information, which increases m=
emory
> >> +         usage at runtime. With global variable types available, runt=
ime
> >> +         debugging and tracers may be able to provide more detail.
> >
> > This is not a solution.
> > Even if it's changed to 'default n' distros will enable it
> > like they enable everything and will suffer a regression.
> >
> > We need to add a new module like vmlinux_btf.ko that will contain
> > this additional BTF data. For global vars and everything else we might =
need.
>
> Fair enough. I believe I had shared Alan Maguire's proof-of-concept for
> that idea a while back for an older version of this feature:
>
> https://lore.kernel.org/all/20221104231103.752040-10-stephen.s.brennan@or=
acle.com/

Right vmlinux_extra was discussed in various context, so let's make it happ=
en.

> We can dust that off and include it for a new version of this series.
> I'd be curious of what you'd like to see for kernel modules? A
> three-level tree would be too complex, in my opinion.

What is the use case for vars in kernel modules?

> module BTF size increased by 53.2%.

This is the sum of all mods with vars divided by
the sum of all mods without?
Any outliers there?
I would expect modules to have few global variables.

So before we decide on what to do with vars in mods lets figure out
the need.

