Return-Path: <linux-arch+bounces-5680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB893FE0C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 21:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E570C2822A2
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06C1E86F;
	Mon, 29 Jul 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsEzOYWC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C9A1419B5
	for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279877; cv=none; b=MEMcMc/QY9UKCQHUqqCp6e8wTxPFaW2ZL7VAxssljvj0cmb8TMe3waQnI8Ahd1Bx5Zp8CMfyyex7ZWxnbnD1d7ERaEizqVu/IOH1oQa+zqEgHkDuFhJciJtH/LtLexjOaf7LqTI7GphbyJ1m7Vw1JgXTfZF3KuoYsEeAYizkfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279877; c=relaxed/simple;
	bh=L1orX8W8t+4D+yt5PRsHAL14sp158IQXG7CxaXNBJgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBvJwAdUNX9R2wgpnTItI/djpHZzR/7j8pW4K/t1aXeLCLQY0keYsh+wOnW3abhMmyzATMkPFoN78uRFQ/nukQ3tesoHphUrXxHO7Z6AJ7/Lh3yy+vJN6tgyIOmw9R6skw6Bl+n6RQTtGTxFtG+LjaBP0rK0efr/D+hQq7JM6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsEzOYWC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fed726aefcso25395ad.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2024 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722279875; x=1722884675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1orX8W8t+4D+yt5PRsHAL14sp158IQXG7CxaXNBJgg=;
        b=WsEzOYWCPNOVpvgpcmK2uy/h3GIaz95mpurto+XKLxQvowt6bYPpTMKsxrRqe8pChy
         g8SjKvIXflhrW/VmoOpKpTewSouN3A78+bVe3jtduMXwW+YiqWtrTkMxmyaPOLLXbuOZ
         YnqvWy8bb1XKkEGlFkhsPp2mqb3mJq0liq3XNPMMaEuUhT1U9cpT18TGiphxljiGqcVY
         ZTBoLrM9efdAGFtr0E/Am+IEl2x/tFao3ClwO6lBrhfMH+dtKLK/qjqVoyHwrC2sp6Ny
         OzoYlRbT2JDSERFRVocD5FJxoMiyTbY6Fj9rvn8S+kBgpQdafuyMpv0pY5pys9dlHgyl
         P9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279875; x=1722884675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1orX8W8t+4D+yt5PRsHAL14sp158IQXG7CxaXNBJgg=;
        b=fvsgOEvTOYyDm5oNIw9aEYTJ/by4PAjJxbHnqumkdRVWdtekky/tKMbcJzb+8J/5Gk
         I2Ut0+vb2oXc7Dk65j+60QcFZy5U8nhLCux1PCEZtKng9ooKF1Phr2TwgwwCaK84zxuN
         mDxnp8ifxVBF1RWAba8sjs3UphX2J3rLm8S5VoSYfha+YY9NavYruVpeTp00HrLeNs/F
         /fV+VyqRbJO49CsZfLSKJ7anVUqvxaJjpclTwaIm7CNgWRT+w1eRm3LxRpDFuYhS+lJA
         9ildyR8LgUsBuclPehj2dyEXWD9HzWYO1Hd5CRBfWxy/a1rpuPqJVhMVEswTEjr95AWE
         YTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZOaTIAPBm964fTkr7UvqiX0oGwJK9uKO/1/4zS2J9NL/E5HMaia6KNwftpyONXmVDgrW5733t7uuCxK5E9wMEi7yS8R8XzMWcaA==
X-Gm-Message-State: AOJu0YyHRSK28CYAMrASJJSzyNtkLpd+aQEJP4tGQRJAuIcOK+YU4Gkw
	HHVP71kLyyyjhail1KdFDatFtnmlTWUwWpdEsjSHnvaxEGxiq6PoeC74UZmO4HrUuaXtYN0+ciy
	tQhA6Qmf315de+PPxdANRTJcV1IWCm5f9XmE4
X-Google-Smtp-Source: AGHT+IGSiS6jqlSnj0RLELgjkwPLpiMKuNfOR/nYn5PJXuvkrmGGQlP2HpSPhdzULqqv4EphdM6bCtuCrTQNFk/JI1U=
X-Received: by 2002:a17:903:2350:b0:1f7:3764:1e19 with SMTP id
 d9443c01a7336-1ff34d590eemr1029195ad.20.1722279874404; Mon, 29 Jul 2024
 12:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com> <20240728203001.2551083-7-xur@google.com>
 <20240729095303.GD37996@noisy.programming.kicks-ass.net>
In-Reply-To: <20240729095303.GD37996@noisy.programming.kicks-ass.net>
From: Rong Xu <xur@google.com>
Date: Mon, 29 Jul 2024 12:04:22 -0700
Message-ID: <CAF1bQ=Ts1yoStfvsG-Q2BQmuRttTw03Yd4PnAU5MGQMCRRtbvw@mail.gmail.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
To: Peter Zijlstra <peterz@infradead.org>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, John Moon <john@jmoon.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Mike Rapoport <rppt@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Eric DeVolder <eric.devolder@oracle.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Benjamin Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
	Juergen Gross <jgross@suse.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Kees Cook <kees@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:53=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Jul 28, 2024 at 01:29:59PM -0700, Rong Xu wrote:
> > Add the build support for using Clang's Propeller optimizer. Like
> > AutoFDO, Propeller uses hardware sampling to gather information
> > about the frequency of execution of different code paths within a
> > binary. This information is then used to guide the compiler's
> > optimization decisions, resulting in a more efficient binary.
> >
> > The support requires a Clang compiler LLVM 19 or later, and the
> > create_llvm_prof tool
> > (https://github.com/google/autofdo/releases/tag/v0.30.1). This
>
> What's the relation between this and llvm-profgen? Is the above simply
> a google 'internal' proof of concept thing that will eventually make its
> way into llvm-profgen?
>
> It seems a bit weird LLVM landed propeller without the required profile
> generation tool.

AutoFDO historically required a third-party tool
(create_llvm_prof, mentioned above) in Clang.
AutoFDO in GCC also requires this tool (same source, different name).

llvm-profgen is a relatively new tool that was integrated directly into LLV=
M
(similar purpose, but different implementation).

AutoFDO and create_llvm_prof are not "proof of concept". They have been wid=
ely
used in Google for many years. Propeller currently uses create_llvm_prof as=
 the
profile converting tool. But there is an effort to move to LLVM.

