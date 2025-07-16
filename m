Return-Path: <linux-arch+bounces-12807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7FB075CB
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABC41770B5
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97E2F5086;
	Wed, 16 Jul 2025 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhkCVSLq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C92F4A0F;
	Wed, 16 Jul 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669403; cv=none; b=nQChGlH25PnSodEdy9sFiCza5F0LbewI8qIrNNztjqMDn17RZr9kvZBx73/qrYFmmNkSgAhmkSwKiWDjCfRT0qAly3hMuSbkVwBLem45tKwmGSzu+2cJenkoK6EbRPg+ZxNVQeLNYB+GQsQUqPBmLbMtNpGY9t7oLF/M6EBYYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669403; c=relaxed/simple;
	bh=wzq636UmBmkRt5jx0MGIBDFLizgfD0NqkzU8lhycQFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuCZ7j/RbD25hbPTN38GC8eLR84y4e7L77duvKZPGNBki8htWC9M7s0ojcXcCu4BtSQ/cYjSfJHd+4y4+uRznKx4MiYaFQPLEEF4TF8/G0jspudJKO12eYDHHmRc7rc0pB3xYPS8wSQTRGhBr0zBSR2uA+PNGOuQi4tmuRdjjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhkCVSLq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313bcf6e565so898529a91.0;
        Wed, 16 Jul 2025 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752669401; x=1753274201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbtdeD8Wnwaq/vjh/JXA9wDabfJkPgVSH5AlF8yNHxE=;
        b=IhkCVSLqIkUZ8ExhGeSas/7WHtV7RR4GsW2trfvstcVvnSMWbtSC3mdwgljk9eGmxM
         9xFFcVm7V1TYLzgi2HLOkH4aAzS6EwJW4g05JlWtfFciomTHN/VXM1BwJHMjLqYk01vA
         8sWf62uVzZRXvsxX4irCdii8nI6RsfEi9lUmjEMK4uk7cEiWpIH2Tm9RtbUO8oWGIvSb
         2uUmfxUoOE+DTavxehEqmBSwKalucuBnQiIgisp7gb1SRfbmvnOnT7UjISaRvYAseCuB
         wEMoqO3pJPpMFYOT7+XVU/r+FUdsTjyISN50UACq6+bTjyNE80Pc0HGlgAxvz3vGeQ19
         IqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669401; x=1753274201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbtdeD8Wnwaq/vjh/JXA9wDabfJkPgVSH5AlF8yNHxE=;
        b=nLuCaWr3xUa8a5DHv3BIFCPO9ewksl4H8W0c4El2B7oOrkHuKmkZhahsIB6JoKWDQh
         ZhszEzbfRIO85PUJ+JILuTP1Wjr8QcazyR6Mk9bturSvVd+qtHX4A+mD60JsgtiziiKU
         rDH58LK8dUuKWpZKqGOjhob+urtQUby4yHsIVy6lqAE1oa4jlWLYP9VLvUoZufo8OL1G
         pF4fX2eJghYlSgaO6TpG4s6xWYriIVOfWXYQF0kCl9bDCBUuTEU3yP7lq3C3Pt3kK7dz
         wB8BttrPB/NGfmlVadr/7RMYIvzVvD25phAnZQkwSuX2L/GRlRz64XB4F30rwSIqEqOe
         KoJA==
X-Forwarded-Encrypted: i=1; AJvYcCVaiUwjc0GsHe6r7b29XYQEKlEs67BmAUQc0mDCjAQ9bcv271m2aV3NF1xjpvBb0P7Swdritt7BDM748Z4m@vger.kernel.org, AJvYcCWh7WSMEXLgF2CFpQGupeA8WZQAG6Ma96F3EiwI28imFau++LnlMM05x+i/anvGGbl6DW5BsqLLFbgS@vger.kernel.org, AJvYcCXxVfU47xAw9sY08A+e6QSl9W6Njb7O3ShiE/tsjHms6vb8Vhh6uOah0jLGbYlN4uUJgLKe9oxZK0WgNMTdSFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9lkjl1r4WlIEiq9D5Z/zry+po92TcAyiAYHcz1sBhKziZY1uW
	NeJ0enijG6KOjQItmXLc6Cj3nkJrnfQV+3y/IKLQoZal82/TMRrwhpqesz9QOPDJ3on5MywRdVz
	AgNljPuWHthJCrbsAoOTaLIXhAXk+hOE=
X-Gm-Gg: ASbGnctAKWKsAabKNPPbaXSXXp7Zvf4SW6AUQBI+XYvFLdjLCfVfc1d55BdrtpHSkN8
	agf+kmIfDqkjs71B59VZa8iQJ5Q3M3eock+QEp5rn8vcefZEabFhP5ReKaPB5zuJmeKjZg/zMdj
	fqHrGlXQR7QGHFmY2aT/pdKOUTJzdkkOni4rtuADakLdB9AzqJ5WrpUfHUmQ4ywdapbgRziNpmt
	hLSyA==
X-Google-Smtp-Source: AGHT+IH1AfpX3+Ds/zOoz9tipktkM9wtu5kQ1XtmEodOHlUJdQwaip1Keu+KmvTAMMyBv0JDYAk8CTYSo9R9mjAWmxY=
X-Received: by 2002:a17:90b:2d4c:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31c9e760e02mr1521980a91.3.1752669400814; Wed, 16 Jul 2025
 05:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714053656.66712-1-boqun.feng@gmail.com> <20250714053656.66712-2-boqun.feng@gmail.com>
 <2025071611-factsheet-sitter-93b6@gregkh>
In-Reply-To: <2025071611-factsheet-sitter-93b6@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Jul 2025 14:36:27 +0200
X-Gm-Features: Ac12FXxU7t4f3TmDU6568W4lxU0yBWR1CBpL3V_9M0bVOSQeTwuke3j6Ee5kfVQ
Message-ID: <CANiq72nCm1-xELn=Z1x1LidKHtjhMtz4FNnakunQ9BqzcS89ew@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] rust: Introduce atomic API helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lyude Paul <lyude@redhat.com>, 
	Ingo Molnar <mingo@kernel.org>, Mitchell Levy <levymitchell0@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> As this is auto-generated, how do we know when to auto-generate it
> again?  What files does it depend on?  And why can't we just
> auto-generate it at build time instead of having a static file in the
> tree that no one knows when to regenerate it?  :)

If Boqun confirms that there is no reason not to do that, then I can
take a look at that.

Cheers,
Miguel

