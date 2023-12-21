Return-Path: <linux-arch+bounces-1154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703381BB6C
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 17:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7769287730
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A06D55E4F;
	Thu, 21 Dec 2023 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCTcv5Cs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8D55E41;
	Thu, 21 Dec 2023 16:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980F8C433CA;
	Thu, 21 Dec 2023 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703174520;
	bh=OKgDkdEnpov+UvfKDBKdQoUoQ4Sl+DaH5TWz6flCPpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZCTcv5CsPENZkq9JLiDoG/D3fPbO24kgy6hv9Ux6CC/W8s25Yb7EUYXj1ecRmFmnv
	 8501VKY5VXXSL9r1RfUAtLMhp0c1ZXhALBSt6cF+oes9x046gI3T4V4nabtwBLIpIL
	 c1fgg/KT37STlAHLZE+0ODftic2H/pe2gJZo+L61AFpofyd6PBZMTkYQ9BPYnCGlMw
	 2uexQTrk/A2bdZ5Ja/mRfBAYozi4kbAQmdHb5sngNoP0o4YKh9tLwfYGCKnWL26Hgz
	 wDWzZnKN26y+Uv42jFlHJ9LtO6Dgkj73JVJsA5S6zIFoez0vmBQn3fRtvkWpM8RAQx
	 VIpgodQNtvYgA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso404935fac.0;
        Thu, 21 Dec 2023 08:02:00 -0800 (PST)
X-Gm-Message-State: AOJu0YzZqhtNmOpzkUpPWilv4YeC7B+Cwx4/N2TUlG8Nle8WtiFObL3G
	qciuq2/LxoLrf/l9QRXZJIfiZF4PUOzWF4zaXUk=
X-Google-Smtp-Source: AGHT+IG2GPu24vvuiHnYOK6G8Yb0JYZtPAu9NpeBuY/QQZYyLUBU8KcDqPKMJNfYEoPsh3Y92933hljB3VNlogNMhI4=
X-Received: by 2002:a05:6871:6a9:b0:203:f580:bd58 with SMTP id
 l41-20020a05687106a900b00203f580bd58mr1280073oao.76.1703174519707; Thu, 21
 Dec 2023 08:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <20231122221814.139916-2-deller@kernel.org>
 <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
In-Reply-To: <CAK7LNAQ4C66NZpOwM6_pzdFbTx7LHfv40vJsNu3spPCEJKfOFw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Dec 2023 01:01:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
Message-ID: <CAK7LNARN985trrbxnCY0+wv5q2ie9PO0TvKet1aLBzDdP-xHPA@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab entries
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-modules@vger.kernel.org, linux-arch@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:22=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
> >
> > From: Helge Deller <deller@gmx.de>
> >
> > An alignment of 4 bytes is wrong for 64-bit platforms which don't defin=
e
> > CONFIG_HAVE_ARCH_PREL32_RELOCATIONS (which then store 64-bit pointers).
> > Fix their alignment to 8 bytes.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
>
>
> This is correct.
>
> Acked-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Please add
>
>
> Fixes: ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
>
>


If there is no objection, I will pick this up
to linux-kbuild/fixes.


Thanks.





--=20
Best Regards
Masahiro Yamada

