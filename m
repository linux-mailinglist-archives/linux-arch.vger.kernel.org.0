Return-Path: <linux-arch+bounces-8445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8539ABFC9
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 09:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC051F24F37
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC9156644;
	Wed, 23 Oct 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6mu6TY+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F70156257;
	Wed, 23 Oct 2024 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667200; cv=none; b=O3ywPD6RBjq7+pdNtMOH0KG5j4EqcE5PJ2bp3bgg1qGjKkc1TtBTqRiwQok3ymsmV67TEKhMtNvXTdrnAbgzlWkEvePsKGQMJopBVx+olicbW6pQri8WIu0pTm8wvk3r+N88ZoqN8tpGjgJ/hj2ANhlXvKi/KhGCIqGxH52DCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667200; c=relaxed/simple;
	bh=cUjvW1wTsKGH7I8VyS4QMqzWOtCeG2GqAEWy+jvkqjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgLSSjrIbdPrjcxIiWKA3FjLR9cQ+YBY0MEkvToHO88kC0njDg9EdvA+FD0FKK/3wIkLuNb+b4RAOIN7kcU9gp9NU9LYBhyYrGz7fqtCNsexK2/SS+iHXPVIl/ZsZXOS4TPf4/ritVcGoWSRzjSGJIe03IUQE11+wr3TloYtLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6mu6TY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD336C4CEEA;
	Wed, 23 Oct 2024 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729667199;
	bh=cUjvW1wTsKGH7I8VyS4QMqzWOtCeG2GqAEWy+jvkqjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r6mu6TY+k/tA38zp47MTMaUVE6oCizdBoZvZEiKtO65vJF+Fe58GmMna6LMXMvWnZ
	 JLLJel5kp+qxM+/inz3VBb7X4HfItgg3xN3Bfn2APhI1FxzhybFEjZ036jABotn2BS
	 xnGg3Nvy8b3zRWM2/JqYkHamghNxbldg3EtxGBgiYv4AbY+G6Ln7/wJTZ3B8Po9z6g
	 Z1i9hYsuxpzFqTOos1rsP/Edvmxbz0Z6/as5e8MmLjUx68R/EP0+oKbmI6z8gCWx16
	 dnK7YYBy8+KfEihEvLVt4OxOVkD8zblrncWw/SugBJStTVkU0z1FdWjMi8ceSFD5fL
	 bSrSAoezAATtg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f53973fdso493658e87.1;
        Wed, 23 Oct 2024 00:06:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFpGrrPoWU2xL3ixUed5/c9+M3VixjEIEuL4KIMEaD9yUVRxTqOOSGMFOjbDG0FQJRUuo2uIUf6i4WZKqg@vger.kernel.org, AJvYcCVOCw9rdZRVqk0wXXGExtG5wBWsEm2yEePkg6CGEm4ubIhBLKYq8ymCNwgZzJ5oO6uXiOJcA/2IXHj+@vger.kernel.org, AJvYcCVtpdiZmmM2SGAld1nEsu7+12Q76Gm7gnDU3RJCbbDXJWFZmp/t8G+ux7iNYKHZxOZYJceFC0jsD3O2Dgyl@vger.kernel.org, AJvYcCWZOtmj+AGY5oKroHp0msiRM9h1scBOGqgoxh2ntEerM5LLor0Hg2E+XwgUzD1JGBDMT96HQB+g8j7I@vger.kernel.org, AJvYcCXYwjgqSC2PnnH23vOsB5ItDhU2XSouRuLjOIcTYbP5zIBS7tfOvHjgQlfs1XCohPqKKl/rKiBxts40@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYoL0WLi+87SW8rJdIoaFm3evY6MXXyydcMR+OIau8v1I+ODT
	M0o9uqzRkJWGc1MILSkXEUaBt445cMyrgcOJdH/h2CC5Rv4bWTqCS3LCwLTAiXDPMTG0Xq+Ve8b
	91yK2sJfdytM+uJkpipsIoPiWq2g=
X-Google-Smtp-Source: AGHT+IHZZgwVgaRO2Hdyj/zbCtAei+RMhbCGrZN9DeetcAzH9eNLU1+5ofJFfDj8eJ/Gl5I1LCwT7/RZ/5W1ROK9gGg=
X-Received: by 2002:a05:6512:2812:b0:539:f6b1:2d05 with SMTP id
 2adb3069b0e04-53b1317f334mr2048779e87.9.1729667198330; Wed, 23 Oct 2024
 00:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-7-xur@google.com>
 <CAK7LNARfm7HBx-wLCak1w0sfH7LML1ErWO=2sLj4ovR38RsnTA@mail.gmail.com> <CAF1bQ=Qi9hyKbc5H3N36W=MukT3321rZMCas0ndpRf0YszAfOA@mail.gmail.com>
In-Reply-To: <CAF1bQ=Qi9hyKbc5H3N36W=MukT3321rZMCas0ndpRf0YszAfOA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 23 Oct 2024 16:06:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQr_EusZyy-dPcV=5o9UckStaUfXLSCQh7APbYh15NC3w@mail.gmail.com>
Message-ID: <CAK7LNAQr_EusZyy-dPcV=5o9UckStaUfXLSCQh7APbYh15NC3w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Add Propeller configuration for kernel build.
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:00=E2=80=AFAM Rong Xu <xur@google.com> wrote:

> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Configure the kernel with::
> > > +
> > > +   CONFIG_AUTOFDO_CLANG=3Dy
> >
> >
> > This is automatically met due to "depends on AUTOFDO_CLANG".
>
> Agreed. But we will remove the dependency from PROPELlER_CLANG to AUTOFDO=
_CLANG.
> So we will keep the part.


You can replace "depends on AUTOFDO_CLANG" with
"imply AUTOFDO_CLANG" if it is sensible.

Up to you.



--
Best Regards
Masahiro Yamada

