Return-Path: <linux-arch+bounces-1162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FD81C55E
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 08:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315D02878AC
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E808F5A;
	Fri, 22 Dec 2023 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WARE7cr4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77261C2DA;
	Fri, 22 Dec 2023 07:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5085C433C9;
	Fri, 22 Dec 2023 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703228527;
	bh=FTZxNnsf5zRiACFErRkNpYCam0ADV2KU0KAdPIyArD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WARE7cr4SI4nRwr+FibrE4XaqQyPXSvSh0BH8uLSH4E7rl1kiGDMS3vYylaVSvQms
	 lfsKPT4QrPTMCjb6fDhjqLl+1bahCFHtOYd+Rg/z5vQNi7Mx3yLWFeqg9MWwwGJRni
	 j/AOOCApmsehwcpcQOHhMpRtHgHe2c33JtU6VPBLBVObchU8c5oKOEC60KBf8EeynQ
	 FQVZnW15GvHC8PTpjQxBUHQ00hWdadIjyPTVIKGl5j/yoLttL3VYBPw20ExLidrz5F
	 taHFEXUCDOFjUV+CyN+lH/THg0iQFv6Pb+nF5ejwGnzd2eNJ4EJuzP57P7FAioLNmq
	 lKsBBiEyEtoyA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-203ae9903a6so976440fac.0;
        Thu, 21 Dec 2023 23:02:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yw6gcHfDI1p+O6q7tRa89Z2NiFzFy42nuiuKWh5aEk0fhR9H3Du
	K66oHrupqIglVKJ7AKz52Z9+jHcxsk47T6zhbNs=
X-Google-Smtp-Source: AGHT+IGkwa8CuwfmLz0N3NHtxQ091wU9T5JJIVH9oOBTRBOeIAZ4CUElYeQjbP5d5WcnAdhODCvDSrpTWGt4lrZfYZY=
X-Received: by 2002:a05:6870:b6a4:b0:203:b191:aec2 with SMTP id
 cy36-20020a056870b6a400b00203b191aec2mr872650oab.55.1703228527244; Thu, 21
 Dec 2023 23:02:07 -0800 (PST)
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
In-Reply-To: <ZYUn9c4z9yFWMeH4@bombadil.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Dec 2023 16:01:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASg+Z0Vx+9ORpuv_5RdgzH4RDfGNEz5nEz71S_j7H18eQ@mail.gmail.com>
Message-ID: <CAK7LNASg+Z0Vx+9ORpuv_5RdgzH4RDfGNEz5nEz71S_j7H18eQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux/export: Fix alignment for 64-bit ksymtab entries
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 3:08=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Thu, Dec 21, 2023 at 10:07:13PM -0800, Luis Chamberlain wrote:
> >
> > If we want to go bananas we could even get a graph of size of modules
>
> Sorry I meant size of number of symbols Vs cost.
>
>  Luis



But, 1/4 is really a bug-fix, isn't it?


ksymtab was previously 8-byte aligned for CONFIG_64BIT,
but now is only 4-byte aligned.


$ git show ddb5cdbafaaa^:include/linux/export.h |
                              head -n66 | tail -n5
struct kernel_symbol {
        unsigned long value;
        const char *name;
        const char *namespace;
};


$ git show ddb5cdbafaaa^:include/asm-generic/export.h |
                               head -23 | tail -8
#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
#define KSYM_ALIGN 4
#elif defined(CONFIG_64BIT)
#define KSYM_ALIGN 8
#else
#define KSYM_ALIGN 4
#endif




In the old behavior, <linux/export.h> used C code
for producing ksymtab, hence it was naturally
aligned by the compiler. (unsigned long and pointer
require 8-byte alignment for CONFIG_64BIT)


<asm-generic/export.h> explicitly required
8-byte alignment for CONFIG_64BIT.





In the current behavior, <linux/export-internal.h>
produces all ksymtab by using inline assembler,
but it hard-codes ".balign 4".











--=20
Best Regards
Masahiro Yamada

