Return-Path: <linux-arch+bounces-8441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA19ABF20
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F2CB22715
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDCD1531E1;
	Wed, 23 Oct 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR7m1RFy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E11531C5;
	Wed, 23 Oct 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665915; cv=none; b=opbT6rziSREOjDL71BNMibQ8Al3XVgOPa7D7r2HmWNLmVBX6G0hwvEZCIsOpZZkONvOY2ZBkvgbI/5G0TvbnAPozQrOdfVi1S6lXNvLwujgtSFEfG/01xjXuZTngtILtz3DXOmbign1YOfHkxgP49juC1Pz7JnuTo/w0Zpb4oVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665915; c=relaxed/simple;
	bh=I7HURHb0jCDc0kIUBqb3ZlkZEa1kppE4AOFUaP/oNIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0NBCKugI27/eoKJ9NSa6afn/qUVNQf0cYEqTOARbkO82RfOV2E4CmMZPbEwY54hkPI3EGzavf+Rv5ZRDMQ9sAWFz/F2D4SphrMFR08bK+TqS/2kzfwUhYMnthEUlzHXyRBjQ2NyZeFWg3r1420ArY0B+XJLe9go26abyqwfPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR7m1RFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6960EC4CEF1;
	Wed, 23 Oct 2024 06:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729665915;
	bh=I7HURHb0jCDc0kIUBqb3ZlkZEa1kppE4AOFUaP/oNIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jR7m1RFy3k/JtGEh47vE7LPzi2GeHCR5lkbbcDxiOZMX1zCz+OxgenXccdQZsZ5tc
	 r/uS+tdYOx2bLeQMw+iM5xZTs/inq7CiOX7bL/1EZLnFvYg/ocJeaw5aNYCdLTxApN
	 nPJ+PuGyUr2/+JwB4zdz9pLBHdMj+dTu8BnntI293Vp5Fxc8jWVNL5OZFci/9fxNDg
	 SrO0ZIyi1iaN4sItRju6ZixkcrkPmQ+Q6DFTav76cSLg1LwrqmOou8FSl+0f3jg+ea
	 q2uHDW1z/3WW3u0y1Yqf4dw0Tbu6AorpfCq8PqUxReGxMnOfrqdiKebZcfSQMfggis
	 55KbZ2K9f60fw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e63c8678so7787899e87.0;
        Tue, 22 Oct 2024 23:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1+BEX4dxVqg1SbppqJVnEDvLo9G2HYKxILn9rHdrDQGFEXDHt6qEcD7qAJaEJ1O3yt6RZWZveoDhD@vger.kernel.org, AJvYcCUNsitBlr9diKEzCJNUvtL+o9IMj7tvj5mvtrm7UpjQnQTf0rWg4yN0qlIa/dfIbHY6i/cqcFEABKIHUm2r@vger.kernel.org, AJvYcCUXa6g9Hx/0Ljpj4M5wHLNI2PI0cJnFODetbhfSGxnEjUrPi2kQkibXMv9elTpra9+ZjwB0vQrvO+9U@vger.kernel.org, AJvYcCUfOezWtKDyLczDLR8hOSJhpsrnhddgVq7yOhkS+ApUV4baY03WaJjVZi6JtuakswpCD8niMufkuieVcWu5@vger.kernel.org, AJvYcCWfLuhVnopOsEelp2j7bMa2DZTMO+IoOCQ5VpMJFAFhb0Nis/AP0an7kOKeutNuZeYdLg1rp3jQUhl6@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrTw8Af2cdfZEiAz6neSIi7fc0b5oHrKz+obsStyetLsJDgq1
	EWuE11iWFm+PN88MJXGW3cOic/1EQqkGzyXSt4iejO1ezGxmSitUuSsj1G6dFFXFLEoDR4VONOW
	CJbZb4ijLU5TyfYwjQpzGns5yB64=
X-Google-Smtp-Source: AGHT+IHEvYi+Z/VPXkv+py9OIcduE18rSIWRaBjdPYTUVd4Nwadxm+HeVibO9YguSrlAUzfHANBhouSoAElTMeiubJs=
X-Received: by 2002:a05:6512:31d1:b0:539:8d2c:c01c with SMTP id
 2adb3069b0e04-53b1a36b785mr647872e87.41.1729665913964; Tue, 22 Oct 2024
 23:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-2-xur@google.com>
 <CAK7LNAQ5yNKvZDtJuvo9Lt4rZwLSv0UN4=Ff=WcCDy1CCEpQ7Q@mail.gmail.com> <CAF1bQ=Syxi46xnGbpZWhYfqKhQZqrBPPh5FGaqzmJTg6MMDJSA@mail.gmail.com>
In-Reply-To: <CAF1bQ=Syxi46xnGbpZWhYfqKhQZqrBPPh5FGaqzmJTg6MMDJSA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 23 Oct 2024 15:44:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARD2HKhgLCxiY77usLhRsgTQ2L1aTSbNmXFbZz0-AxeYw@mail.gmail.com>
Message-ID: <CAK7LNARD2HKhgLCxiY77usLhRsgTQ2L1aTSbNmXFbZz0-AxeYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] Add AutoFDO support for Clang build
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

On Tue, Oct 22, 2024 at 7:43=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Thanks for the detailed suggestions! My comments are inlined below.
>
> Best regards,
>
> -Rong
>
> On Sun, Oct 20, 2024 at 9:33=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> >
> > > +Customization
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +You can enable or disable AutoFDO build for individual file and dire=
ctories by
> > > +adding a line similar to the following to the respective kernel Make=
file:
> >
> >
> > Perhaps, it might be worth mentioning that kernel space objects are
> > covered by default.
> >
> > Then, people would understand ':=3D y' will be less common than ':=3D n=
'.
> >
>
> Good point! How about I change to the following:
> "
> The default CONFIG_AUTOFDO_CLANG setting covers kernel space objects for
> AutoFDO builds. One can, however, enable or disable AutoFDO build for
> individual file and directories by adding a line similar to the following
> to the respective kernel Makefile ...


Sounds ok to me.





--
Best Regards
Masahiro Yamada

