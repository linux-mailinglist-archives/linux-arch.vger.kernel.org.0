Return-Path: <linux-arch+bounces-8306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69C59A5537
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580C8280FE2
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D23BA33;
	Sun, 20 Oct 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRbis/Mk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC792119;
	Sun, 20 Oct 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442013; cv=none; b=GRyUcmgPO9D9D45FOmMCB+cbdwLAMtuVtjaQZXXztS5ZCl1OdburrvhCBLCIBEfO9gJ6Y7Ac3WdqMk67zQqkBH+maZ6aCVHdneHnddVvADnSaVDUokHAdhDsCW11kzF+z1pt0zJTG4TJvaCB7JQ3RemMesjscvCrZBsS+ZrLRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442013; c=relaxed/simple;
	bh=uPFnGWDTdB8fCmlssabZmdFxdbw/lBbpoj15YwsGW9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qv3naklDVJVWP2PeHI0b2H8uc+L3gHwWszz3qMPtZzTbhNAHmEq8sntmRwyrVhkeG7dQNQXj+6gnkKviGpKaytczlysWEw+VETUbnypLOO4OijypjT5Qk4X6H0ZHGxTXLqbSghM7foU/Yjzwcf+VwBkqHRUGH5r09VXoM6oVgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRbis/Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559A7C4CEE9;
	Sun, 20 Oct 2024 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729442012;
	bh=uPFnGWDTdB8fCmlssabZmdFxdbw/lBbpoj15YwsGW9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vRbis/Mk//J9/SPvA40etThDNfNL8tHSDZKqFMFM2zDDZxBYPnC3YUk2WUCdjsfWG
	 L64cwpZr2d1bWkypTu+Np8o1kpm1lFPYblGBWkBVBS7yUg6KYzOfzPUVxut+5PQmDC
	 kZDsqAJxykFJifng8Ea2od+ZEfHry93ZFKAiVl/Bbp7nvao9oB56FDsoJQQCvl3QAj
	 VI6/1Lp5XFNHVugkOrMpGdYqNTxF2ALHuOelVPrfh8OQ7M5ySz8JQ4atZxOp9d8yuv
	 6I0IGCFpahS58PR9Wufp3Vcx4vofvROubSrTT3XihI+mphJBiln4TWqUMTomnoqryF
	 3DfihlfemQO6A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e3f35268so1588542e87.3;
        Sun, 20 Oct 2024 09:33:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVFzH/xh+F7NdfaxMujavC9bWUEQwgm7ewrUObwtFMHYH1W7h+TESPjPz5SFTSGKEMJcYyWACsFVFQVALa@vger.kernel.org, AJvYcCVTrkU4PwsTCCNJk2Ca8kXEMBmimby86OR0tWg3+h4b+C2MfMMgAVMthCKwPMzlimqOG9ciEQfWjA1Ba5SM@vger.kernel.org, AJvYcCW7+x6iXhY/n9iZLuneQ8yJN6RmJRIzkChk9OBuUbWzS5MM2C4iDn+fa9SrPqgUFwP02p37rptd5i+F@vger.kernel.org, AJvYcCWYK6PMT8b+8FmcLrXjzvckOMM24mC2KahuMrOXdheeOU2DI9+eX04XXN1Nj/baVFTmGSZC5K6sCwm6@vger.kernel.org, AJvYcCXw5Jy63ztjjzgVH3zsmyKja+d3eq0Mp4FoKgwDEmWEKY80cfDfNf9ng6kO+1gXEjqXRjelhfwZlKqm@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrfCrpUtKEva8d0nfqUHVpruvjpoakqWTXuSzu9Q2p0dy0Co+
	JpfQPYZL1y++CRrNDtVMZiH7OwJ+qEvq6iOuUfdyoTABaf2PEyaE33sJD3skJ0t5QR64H0JwvFC
	rPBlLTMkjCiRQ3MS+Xmg5Qu076P4=
X-Google-Smtp-Source: AGHT+IHRsYlqxXcM1oQgzvk1BylM0N3VPuu21Dvx0mE0WPjx0yBxJBLh7hgIROlqIeEZugzFSYbXaalAxT8cwivhBwk=
X-Received: by 2002:a05:6512:3da9:b0:539:8fcd:51f with SMTP id
 2adb3069b0e04-53a1522aa5emr4507693e87.30.1729442010869; Sun, 20 Oct 2024
 09:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-2-xur@google.com>
In-Reply-To: <20241014213342.1480681-2-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 21 Oct 2024 01:32:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5yNKvZDtJuvo9Lt4rZwLSv0UN4=Ff=WcCDy1CCEpQ7Q@mail.gmail.com>
Message-ID: <CAK7LNAQ5yNKvZDtJuvo9Lt4rZwLSv0UN4=Ff=WcCDy1CCEpQ7Q@mail.gmail.com>
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

On Tue, Oct 15, 2024 at 6:33=E2=80=AFAM Rong Xu <xur@google.com> wrote:


> +Customization
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +You can enable or disable AutoFDO build for individual file and director=
ies by
> +adding a line similar to the following to the respective kernel Makefile=
:


Perhaps, it might be worth mentioning that kernel space objects are
covered by default.

Then, people would understand ':=3D y' will be less common than ':=3D n'.




> +
> +- For enabling a single file (e.g. foo.o) ::
> +
> +   AUTOFDO_PROFILE_foo.o :=3D y
> +
> +- For enabling all files in one directory ::
> +
> +   AUTOFDO_PROFILE :=3D y
> +
> +- For disabling one file ::
> +
> +   AUTOFDO_PROFILE_foo.o :=3D n
> +
> +- For disabling all files in one directory ::
> +
> +   AUTOFDO_PROFILE :=3D n
> +




> +3) Run the load tests. The '-c' option in perf specifies the sample
> +   event period. We suggest using a suitable prime number, like 500009,
> +   for this purpose.
> +
> +   - For Intel platforms::
> +
> +      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> =
-o <perf_file> -- <loadtest>
> +
> +   - For AMD platforms: For Intel platforms:


I guess this is a copy-paste mistake.


For AMD platforms: For Intel platforms:

   ->

For AMD platforms:






> +   (https://github.com/google/autofdo),  version v0.30.1 or later.


Please one space instead of two after the comma.







> diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> new file mode 100644
> index 000000000000..1c9f224bc221
> --- /dev/null
> +++ b/scripts/Makefile.autofdo
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Enable available and selected Clang AutoFDO features.
> +
> +CFLAGS_AUTOFDO_CLANG :=3D -fdebug-info-for-profiling -mllvm -enable-fs-d=
iscriminator=3Dtrue -mllvm -improved-fs-discriminator=3Dtrue
> +
> +# If CONFIG_DEBUG_INFO is not enabled, set -gmlt option.


Meaningless comment. It explains too obvious code.


> +ifndef CONFIG_DEBUG_INFO
> +  CFLAGS_AUTOFDO_CLANG +=3D -gmlt
> +endif




> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 01a9f567d5af..e85d6ac31bd9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -191,6 +191,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
>         -D__KCSAN_INSTRUMENT_BARRIERS__)
>  endif
>
> +#
> +# Enable Clang's AutoFDO build flags for a file or directory depending o=
n
> +# variables AUTOFDO_PROFILE_obj.o and AUTOFDO_PROFILE.
> +#


This comment would give the wrong understanding that this flag is opt-in.


The comment for KASAN correctly describes that it is enabled by default,
and can be opted out using KASAN_SANITIZE_*.





--
Best Regards


Masahiro Yamada

