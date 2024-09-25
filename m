Return-Path: <linux-arch+bounces-7429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC814986518
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977191F26001
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CD4965C;
	Wed, 25 Sep 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onMHF/g0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7247A62;
	Wed, 25 Sep 2024 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282719; cv=none; b=Ax++ce/B/oySvRIQ5nNSLv1xLmd2gmeRbkO20AHZYA7/jjTlQI3BXMIL+eDgIyWm0jJGJDy6tDHBdjWtc7k2knWycQrNGHNcwlGIrGmI+U/di1fcl3nwbdo1SvEeN4dYZp4O0kdbABUvK8imneP4dXGqecuGPIuVIf9/PIe3HJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282719; c=relaxed/simple;
	bh=qgOwvX93MJaNEr7OQzS/TNQMPiUPOBpt0ph4xzwCx1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AziAgYNVvwboynEcgkaYY5LVkkFiI1lr6p5Is101RhyjKuqts3xxLYLa41S01kO6fJ8mdW0Xa0Ug7aF9dOnBIfnBuW81mtuCeJm3X9MMEK748Bm6A2R2Z+qA8AKIp3mKu6FzMX4dpftl5EnHXQVMo0cz3ITpUsjkoeuoXy+AMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onMHF/g0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5925C4CECE;
	Wed, 25 Sep 2024 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727282718;
	bh=qgOwvX93MJaNEr7OQzS/TNQMPiUPOBpt0ph4xzwCx1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=onMHF/g0D43HW6aMXQhcIu1A27RFbkhoDeVTu1IsE3Dr45prf9Gt/b9XTbLxkLRdc
	 tp+sKb+2tVL2RKsH7zt7pedqKxbxASz7T6hHTvkigsDpqXaREORqbOHeHr1WNosC80
	 8oqjuX47b/9IC6c9ciSn6WciiPIOmDd4sLFsDQ49EcS7F2y6hlJlFootPDIZyx6tV1
	 nZWbOIv6XsJEj83cV3qJkPJFVqvvPhr7TNk6o6VoBEYUa0GNLZHRv55RTy27voXKfL
	 S1kfkqExZO+yREPbbJkOthV308A1sBbwWyv5+7Rufb9Ltpojr4m1MeoarzGHGNAwS0
	 hJW9ST3pclReg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so192291fa.2;
        Wed, 25 Sep 2024 09:45:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZrVQFyfp3OROznK55Rykut0Vq4VzJw2zcFPgidFv6NsTIp5igjymbOi7x1ALJHZNX8dOA5JfLR94CsQ==@vger.kernel.org, AJvYcCUz+23C1CHv7iFrXAI2PEAOlsl3nKy4zCkgdpCzjVR+PZG/lT5iVlyfrYYV9edM8i+u5iKA7NZGYK+3MmbD@vger.kernel.org, AJvYcCVDkfKF4Wf1/S72iFv6+6GmsbTOzeH0z7QS2u4HE/mUpjgxlqabatrtoHE5damQ3TxOLgU=@vger.kernel.org, AJvYcCVv+ineSpy35ISvR/o04URA/heKwgTJwY6lwUmkbod4vH2jws/WdAr65sQcYJlRJ12uqvuvjxdiHDpM@vger.kernel.org, AJvYcCWJTF2NgETPwYnZC1l04iimVEYaciRTWWIYCqoca1IKqvoQthkXc4epr2xaSNGnA3pGtjbGYhBfxPN5@vger.kernel.org, AJvYcCWy+l3uwmBwVhKoQ6/pF6D3xkpICniLemWxfUq5kfXXMwCDkVtPh5Lhh5ALyLRylrh2TQCx1ZjWSYGfSytIJzpOpw==@vger.kernel.org, AJvYcCX2J8m9RLcuSRmneFctGBeIMH74AifQm5JUDjOfc6yxZKtYnNuLp3FgjZK0yTB/JPnYnhbm6XjfzZj48YLW@vger.kernel.org, AJvYcCXEjsV+TRobG1afondrysMpUh2I+xFjlDATIRV3KSx8PO6QqDEHMgTdTCXFuUizAKxBmZWbK162qUz9p2vy@vger.kernel.org, AJvYcCXMOrBwLsF12s7wQCENUNmqXoDWgmdI17sBCmGlAqja+tWcQOVOBNzH9VglDke1UwZ7ifo5UVf/oA8=@vger.kernel.org, AJvYcCXgNLhP3y+nNGHVlPY1jLREbsxB
 YjNh9qop0QTGyGMESUJ8dlVFgH1pgDGtuFrK2DfuZYNhfWM/Q8HWL3eDwxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONOvlF79P2t0wIUAmL20ZGykKkiWT5lNNd+sBvz9HZ7Inrfys
	4TcpN3U4YNbgn8s2N1quoivpCJkA1bc6Ev5v0LTEwAS5YynzrkOT+4Va4bACVxalIE8l8Yug4qT
	aAC7qlbvbMKu8ISAB34QPfGJ2e6A=
X-Google-Smtp-Source: AGHT+IHztXYzAiMagygAhzDxKwnY8wOFDul9cLbEROanbEnmGDGU1AJFUfvHaHhmJ6jyIhgnmNtdOygZ3lKoSkpCLq0=
X-Received: by 2002:a2e:702:0:b0:2ef:20ae:d113 with SMTP id
 38308e7fff4ca-2f91ca64507mr16954501fa.40.1727282716715; Wed, 25 Sep 2024
 09:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-44-ardb+git@google.com> <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
In-Reply-To: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Sep 2024 18:45:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH1xqYwhG16XxoBpoedTkBvt72xBjO259174jHirdf47A@mail.gmail.com>
Message-ID: <CAMj1kXH1xqYwhG16XxoBpoedTkBvt72xBjO259174jHirdf47A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/28] x86/rethook: Use RIP-relative reference for
 return address
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 18:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 25 Sept 2024 at 08:16, Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > Instead of pushing an immediate absolute address, which is incompatible
> > with PIE codegen or linking, use a LEA instruction to take the address
> > into a register.
>
> I don't think you can do this - it corrupts %rdi.
>
> Yes, the code uses  %rdi later, but that's inside the SAVE_REGS_STRING
> / RESTORE_REGS_STRING area.
>

Oops, I missed that.

> And we do have special calling conventions that aren't the regular
> ones, so %rdi might actually be used elsewhere. For example,
> __get_user_X and __put_user_X all have magical calling conventions:
> they don't actually use %rdi, but part of the calling convention is
> that the unused registers aren't modified.
>
> Of course, I'm not actually sure you can probe those and trigger this
> issue, but it all makes me think it's broken.
>
> And it's entirely possible that I'm wrong for some reason, but this
> just _looks_ very very wrong to me.
>
> I think you can do this with a "pushq mem" instead, and put the
> relocation into the memory location.
>

I'll change this into

  pushq arch_rethook_trampoline@GOTPCREL(%rip)

which I had originally. I was trying to avoid the load from memory,
but that obviously only works if the register is not live.

