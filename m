Return-Path: <linux-arch+bounces-1172-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823E381D4A5
	for <lists+linux-arch@lfdr.de>; Sat, 23 Dec 2023 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DE11F22002
	for <lists+linux-arch@lfdr.de>; Sat, 23 Dec 2023 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F109CC2F7;
	Sat, 23 Dec 2023 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk1Wi//n"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B7DF43;
	Sat, 23 Dec 2023 14:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45808C433C7;
	Sat, 23 Dec 2023 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703342155;
	bh=JtZLz9TI0CnhAAr9iQ0DG7xZfhkmww3v6Das3G2CNcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hk1Wi//n8F0kmrn0BjEISg17LnJBN2HQAY/oSViXjnz0gfNk5pynkjLLeGCDn0+bC
	 +nCyuPRQl+NG9fXFPCF6L8NeIBm6m00mZgBDPZwnBnHoTpwVgO9XzyzO0YzfmERtLP
	 Xhl6VyJqhhgroBkXRnWOeJIzJV1UenOFHmK7LQC5Qz0fvSTYIiobH6NuVvGrTbY5VI
	 HIdQIJ+vkr6MGyAoF3cvum9eWfaxsqect72lv6++Q90SMKZt7LK/2GSGsC1tppWvWf
	 ZIKi6ARtrABv1bky8qFNReT2k4Vb3UeleEpZo3g8Hw94OskJkzVxRrUwQsolgkVomm
	 iytBLHo8L1tPQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-203ae9903a6so1609543fac.0;
        Sat, 23 Dec 2023 06:35:55 -0800 (PST)
X-Gm-Message-State: AOJu0YyPgeYmXzj3GP4uI33mYHAXUE4HkN/Yv3QXTNXT2juaCipXAfmI
	dNNB0tWsYWRtZGpgqfmZz0Nh5EA0tjwOCkIHbXE=
X-Google-Smtp-Source: AGHT+IFQlEV1DjfOY4Ml/3t8Nm99PoykO684pjo/DKV3c2i9KroDA8agX3ZBo5GiW7nJ9eiVSIeJKFgt5OyDxzPQoS4=
X-Received: by 2002:a05:6870:9720:b0:1fb:75a:77ba with SMTP id
 n32-20020a056870972000b001fb075a77bamr3158653oaq.107.1703342154680; Sat, 23
 Dec 2023 06:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <20231122221814.139916-2-deller@kernel.org>
 <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
 <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
 <ZYUnkSF6hcyPq9tG@bombadil.infradead.org> <ZYUn9c4z9yFWMeH4@bombadil.infradead.org>
 <CAK7LNASg+Z0Vx+9ORpuv_5RdgzH4RDfGNEz5nEz71S_j7H18eQ@mail.gmail.com> <ZYXtbRM6AsnWP1fG@bombadil.infradead.org>
In-Reply-To: <ZYXtbRM6AsnWP1fG@bombadil.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 23:35:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQVEh=CbZ1+BJZCVquCk9Jj-iV4Bm-OpnG4XbVY4p3wEA@mail.gmail.com>
Message-ID: <CAK7LNAQVEh=CbZ1+BJZCVquCk9Jj-iV4Bm-OpnG4XbVY4p3wEA@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab entries
To: Luis Chamberlain <mcgrof@kernel.org>, deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-modules@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 5:11=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Fri, Dec 22, 2023 at 04:01:30PM +0900, Masahiro Yamada wrote:
> > On Fri, Dec 22, 2023 at 3:08=E2=80=AFPM Luis Chamberlain <mcgrof@kernel=
.org> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 10:07:13PM -0800, Luis Chamberlain wrote:
> > > >
> > > > If we want to go bananas we could even get a graph of size of modul=
es
> > >
> > > Sorry I meant size of number of symbols Vs cost.
> > >
> > >  Luis
> >
> >
> >
> > But, 1/4 is really a bug-fix, isn't it?
>
> Ah you mean a regression fix, yeah sure, thanks I see !
>
>  Luis



Now, I applied 1/4 to linux-kbuild/fixes.

Thanks.



--=20
Best Regards
Masahiro Yamada

