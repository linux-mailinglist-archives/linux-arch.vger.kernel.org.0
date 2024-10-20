Return-Path: <linux-arch+bounces-8297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206C9A5215
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 05:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B088C1C21194
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 03:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBD7FD;
	Sun, 20 Oct 2024 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeSAfr5+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BC28E7;
	Sun, 20 Oct 2024 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394728; cv=none; b=rHRtuskTVUSnPP5duoW2UmwZ/f+mdiQwm9izrY1VWmh+xS0Zx68RoGkPJo3Pw4NhRFnEAkbAAExCzYHLzvKI9ffGYG6MEgT3yKdleujq+T65VApuw6Ec+vpdbOwyC4hfKAcfExAYiZsla+zc7mEl1XTA9cU97f8wzA+Yp583F14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394728; c=relaxed/simple;
	bh=mz0/k4cJHWArxWFnNfCOwKgrevz3pP6WZwnhnKTk6Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTFlfeyFJUufoOAc0BOpbO8njFYTAOzHkzSQAOBGvUiAnXj8S7up1JHLF9MJuV60+MV6mcTroZ18f5/q/Z6Nzn8K+YhmBbMVAfeJu5f1Rd+ejBjGmIY7cZGlR1p0JC+ysNe7NVE7leKo8GNWTXvEdVmI6zbmDi8FDHQyprwYEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeSAfr5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D5DC4CEC6;
	Sun, 20 Oct 2024 03:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729394727;
	bh=mz0/k4cJHWArxWFnNfCOwKgrevz3pP6WZwnhnKTk6Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeSAfr5+PiWsU+bhzOrYzV8wCNwGkJE5AMtI8eH31cgGM/evvvxQhK81621jifHcI
	 7+UAWrrIxXlXWVpOHHwFe/M+kcL3UJLhG/+P57CSUrw16AgFzGOG3+le+33Tc7Q3RC
	 +HnY/TUl4XkbDkINSJPDYRAqgucEN2m0p3cQp7rdlfjr58dodiqhvvOx1j2S9C7M8z
	 7PYwk4ZgFGIVLOLJUwqUZAw3aA7WCUUDQXJAcUGd8V+DZ5ULGY3+2eBHf0Pb+Bqq76
	 5b42jU3kyqKmVwshtonKYUgDaUC/SoowtQBKgKIM4DYUGHxGEHoufHT/MP2GXSOkba
	 SQ2ecyRjsZ9/w==
Date: Sat, 19 Oct 2024 20:25:23 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Maksim Panchenko <max4bolt@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yabin Cui <yabinc@google.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/6] Add AutoFDO and Propeller support for Clang build
Message-ID: <20241020032523.GA3652325@thelio-3990X>
References: <20241014213342.1480681-1-xur@google.com>
 <CAF1bQ=SQ9rFdwRk_waQvn4PW7x6T1uJmJ8qNqj04oRKmujkCQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1bQ=SQ9rFdwRk_waQvn4PW7x6T1uJmJ8qNqj04oRKmujkCQw@mail.gmail.com>

Hi Rong,

On Fri, Oct 18, 2024 at 11:20:02PM -0700, Rong Xu wrote:
> Thanks to all for the feedback and suggestions! We are ready to make any further
> changes needed. Is there anything else we can address for this patch?

I will reply in a separate thread for visibility but I think one of the
biggest open questions at the moment is trying to find someone to
shepherd this code into mainline.

> Also, we know it's not easy to test this patch, but if anyone has had a chance
> to try building AutoFDO/Propeller kernels with it, we'd really appreciate your
> input here. Any confirmation that it works as expected would be very helpful.

I went to take this series for a spin in a virtual machine first as a
smoke test before attempting to boot on bare metal. This was done on a
server with an Intel Xeon Gold 6314U. The kernel booted fine but when I
went to run the command to generate the perf data from the
documentation, I get an error.

  $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 500009 -o /tmp/perf.data -- make -j$(nproc) O=out mrproper defconfig all
  Error:
  BR_INST_RETIRED.NEAR_TAKEN:k: PMU Hardware or event type doesn't support branch stack sampling.

Do you know if this is expected for a virtual machine setup? I will
attempt to test the series on real hardware here soon, it is currently
tied up with investigating a regression in -next at the moment.

Cheers,
Nathan

