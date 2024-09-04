Return-Path: <linux-arch+bounces-7003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C880F96BC49
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 14:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711FE1F21B40
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BCB1D88BC;
	Wed,  4 Sep 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC9R7Wtt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0E1D54DC;
	Wed,  4 Sep 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452925; cv=none; b=FrnhWQtG9FnF5z9Phdk/vFCpxfWHNu3k4+LS4Amn4ASvSd8+n5JTFFPO9A7k/nlnNj6K+y1/7Q2hIO6WZpPTueCrS+MzBX2gqiRRJs0oOMvrg18+UisX5NMj1IZkvUEU/wb23Wi1xKyWXFGke/UtMz3qPbg3yNELULyb9Jt8zfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452925; c=relaxed/simple;
	bh=Ep0kQQGTEblS4lA+NUsumwO9DQchEqYKJfJ3QPM3POU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzdj+e+rFZLX1AByJc15eLHhNvNmR/E0D+SMDXT8+P4dx/P73fR3rOaxrELB7k0D/YKBxpZdTqFs1Tv84eT0akw3JkL2RqXyeHPNIfeoCYg1wFU7wkw2TmoEd1p1gKb1lh0DmQX98GK5tN9U7XagkL8l1Y641QAlXH7RvudA+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC9R7Wtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511A9C4CEC9;
	Wed,  4 Sep 2024 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725452925;
	bh=Ep0kQQGTEblS4lA+NUsumwO9DQchEqYKJfJ3QPM3POU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EC9R7Wtt1yS5ulfHjVxCKNQ6wvgpc0P9mF6DtcY2d0OyMnKcXpOzYIa2bCbPEi0FO
	 Le5o8zlxONFkx7WmEcwXMqjxycbzYaajEyV3cR9WDGdkq4wnbmcrOcI2dJU62OwxDv
	 AL8X4/TbUT+NZ1PkKAg5MqgVIWMjhWWr+cDSgjDyoWwoTzyOQK7owJXrnqOcNsLtjd
	 zHCPE7AL4NNim/7DZGn13tJ+Jlzlaf9TEQHutDKOyZSeGolv170m5Em8sjb7Db8i13
	 MHgOiDyNJeFFyGQtDSjdqZ67U8jcyvUbBDyQkZ/AUFUaTrhukCQl0ySoFR7q+5V3nk
	 fPZvQvzmySgpA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53345dcd377so9000866e87.2;
        Wed, 04 Sep 2024 05:28:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWv+Dc1mjI8UmS9+VptJxB0egX3ZugFC/aTW1l55zk/Lzbgp9qOW1eHPf5NNYTMQUBJjw7DR0Q37hpq@vger.kernel.org, AJvYcCX1FHE+FA3q3XJOj3L57UOqbBW38fEGVnSieE9sElzEhLj+dQxDlevh+jOUZAl55+IyERcLsgE6V6XmhVl2@vger.kernel.org, AJvYcCXFopQVkIwkYvLRK1++YYG281khfwQkht8+V68VbtkeBRVTC7N4jMB/PINa24kJRbSh+zkvaeHIg8rmXrSj@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyZWpvPWhyf4q5O5jCpdq1QsglFUvLY0DZs35p0ukE+8RY2UV
	5PnhSs23jX6fe7hkUNRbCH2ZgqHbPJksmMuqUnX7eOYt1SouG17vOJ6hYEb+n8xIXVmPEddOi9z
	3XFzbUiQixWPXmXql1wc65nEQMP8=
X-Google-Smtp-Source: AGHT+IFnIZx/SDFkvhuT1T8cvL7l5Y8tgtZ8/IfSHFcmv8ZDbJZ0DiswjW2Y4RbkNu3ugqn0z+9QaL83QGABMTQXJI8=
X-Received: by 2002:a05:6512:3c99:b0:52e:9f17:841a with SMTP id
 2adb3069b0e04-53546af3048mr13795648e87.6.1725452923531; Wed, 04 Sep 2024
 05:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903120948.13743-1-adhemerval.zanella@linaro.org> <20240904120504.GB13550@willie-the-truck>
In-Reply-To: <20240904120504.GB13550@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 4 Sep 2024 14:28:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsfmaydb+RCxA1rJPs9K8o4y8LSMTO8sMH-pmAwrZ6PA@mail.gmail.com>
Message-ID: <CAMj1kXHsfmaydb+RCxA1rJPs9K8o4y8LSMTO8sMH-pmAwrZ6PA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm64: Implement getrandom() in vDSO
To: Will Deacon <will@kernel.org>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Eric Biggers <ebiggers@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 14:05, Will Deacon <will@kernel.org> wrote:
>
> +Ard as he had helpful comments on the previous version.
>

Thanks for the cc

> On Tue, Sep 03, 2024 at 12:09:15PM +0000, Adhemerval Zanella wrote:
> > Implement stack-less ChaCha20 and wire it with the generic vDSO
> > getrandom code.  The first patch is Mark's fix to the alternatives
> > system in the vDSO, while the the second is the actual vDSO work.
> >
> > Changes from v4:
> > - Improve BE handling.
> >
> > Changes from v3:
> > - Use alternative_has_cap_likely instead of ALTERNATIVE.
> > - Header/include and comment fixups.
> >
> > Changes from v2:
> > - Refactor Makefile to use same flags for vgettimeofday and
> >   vgetrandom.
> > - Removed rodata usage and fixed BE on vgetrandom-chacha.S.
> >
> > Changes from v1:
> > - Fixed style issues and typos.
> > - Added fallback for systems without NEON support.
> > - Avoid use of non-volatile vector registers in neon chacha20.
> > - Use c-getrandom-y for vgetrandom.c.
> > - Fixed TIMENS vdso_rnd_data access.
> >
> > Adhemerval Zanella (1):
> >   arm64: vdso: wire up getrandom() vDSO implementation
> >
> > Mark Rutland (1):
> >   arm64: alternative: make alternative_has_cap_likely() VDSO compatible
> >

This looks ok to me now

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

