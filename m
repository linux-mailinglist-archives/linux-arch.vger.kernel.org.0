Return-Path: <linux-arch+bounces-11965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8092EAB91BA
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A6C1889405
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2325A2C4;
	Thu, 15 May 2025 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MxLafy8E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78F225A50
	for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344050; cv=none; b=VvzNwWc7eKhoGw+iqDi/iHHH7e2kz611HculnImZUkoqNXssXf/UgOUKCE4YHVRoDg+5XV+Z7Qu0SWLL4Hh/Tm/FuYCzt0Kz0hh7ZsTsapw3A5v3LIO5d3JRK5uvUsBqupNk6AEUugGQpkl82iRxlU4RTbnCe3xwm8aj8Gcaf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344050; c=relaxed/simple;
	bh=QOm3m/r0dyEo2Mfa7umeu+ruloxr/DK67GsqoXNotWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRK+jq8p390SoAqXMo57WC9QAI5Uuyr8kP8AUSdezlJOjd5BbILM7DqKslKv79d80zJnHzDOsBSuLGfheTfFEqNB7o62kF9cx/ILBEkK5OTcRGqesss6iRmfFIl1pEMRAelI3xretzWuge7iEkF/HhCzzmeoHpmkSM0rKBz/2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MxLafy8E; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fd0d383b32so2353908a12.3
        for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747344046; x=1747948846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBR1eDOR9aCst/oayM8CR1mluYptr7n0p9+2J85ynlw=;
        b=MxLafy8E8iqQ5lgWlpYcoGzbiZPRAexp0uA9BJZ/N3ylYtyyZsMxITSSXWApTBv0dP
         GOPzzLyH4/Dm0OiyRJLjOrvLeci3X2UJZsQNI5FQG8mbJywQBTighY19678rCPPDOTWh
         cCjmK9/JUbOoPb74X5vfD/YNRVksUgzZH55xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747344046; x=1747948846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBR1eDOR9aCst/oayM8CR1mluYptr7n0p9+2J85ynlw=;
        b=iJtyZUDpgNJXDSaUpPq64zpiLxYcl9VmfPPEVJFn330BvITb5mmBAr6HEqyNk7n+Ek
         d4WEaRUM7YGCs1C39hi2CUHNu7LZR7rdkpa8wW/RUvFgeL77LyPjBRjr/rjBgCEjMBnN
         LH1kRgYkR7kPNh1V0YcbqPQkJS6IssfH6Cit3QHOH8Pp0THABXpJPLISka0cPOrzsSxv
         MTnXxBcL+yGeKMnNcRmUdFC8phX175r25XPOFAKBU0/C4yHBBWJaBf52MoNr2zrPqJDX
         7lpiNmB3askXPYdqpOV+4zCRV0bQLDVqaVpg6p87xUCEcIrvZkPDwUe8JnCnwbOUfqnm
         qhbA==
X-Forwarded-Encrypted: i=1; AJvYcCVsiob/paVMMD6l9He9ppIKQ0ny3kBW88Qf0QW26LrrBy15DxHBWoFEU8UiGsI6k+B4vRrSpoWs+mPe@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzX1lbaJxbLPG7533Npz0/4AaxJBSyVySKlhNLvc1dRNbyEx4
	ahlrLYj9ifEGJx/7AkFCoEedke0dvTEdx0WFFjoARYbsLJ+G2676gXjOcvW5eVTRV2gP9pxPkI3
	7C/L0
X-Gm-Gg: ASbGncsJTnPIdQliwwrzDI3HXAXo/WZBe5hFoKaR57zD1BbwEn8JXJSslkHth1JN9S4
	JL7Vvh3RjZPn23B5nv+2pLF7J60NpBwD/X+ffTpklss2fQETBQJ1Baq2xJqvg0wo4gvRMe6Zj/1
	bHFylpPZIE5gDRxXXzYBBZrt4tXZCO+9PqO3A44KbU9xBIpq+NBuNN1GQ7PVNyb8cgLdryuyyCe
	Z+E58raZdgWrqZe28Wz590vJYuHH9bgQmhh7NDJ1zlE4HYAxXElubt3/ak8AtVG8iUF5oZt/VAY
	krTKfZkHetn2inRHJKHa7KhHZdvoFkBKmtpqyNWyqlQa3JxtkfIo1nQUmFc1lLhDxRzTJ5WcXqR
	c259T2IF6JS+LYgbOX4Jf9Q38mw==
X-Google-Smtp-Source: AGHT+IEOeZItPFAmCFm1uB4cD7ZTEALn8MaEm1EDXIUViLfLHJYAk96FGqC3h/PlM4w5OwudxhB8ew==
X-Received: by 2002:a05:6402:1e94:b0:5fe:8643:2c9d with SMTP id 4fb4d7f45d1cf-600991bc778mr743812a12.33.1747344046226;
        Thu, 15 May 2025 14:20:46 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d4f280asm327329a12.1.2025.05.15.14.20.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 14:20:45 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fd0d383b32so2353877a12.3
        for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 14:20:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9fYuXYwPMcGlfTJAbbkeMlTPo3dTzuTRYhCkdlvatc6KkwdsLxB5EcHJLqVmqKMXeleS+UdxVGL9O@vger.kernel.org
X-Received: by 2002:a05:6402:34d3:b0:5fb:e868:4d47 with SMTP id
 4fb4d7f45d1cf-600900a54a2mr778653a12.7.1747344044885; Thu, 15 May 2025
 14:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
In-Reply-To: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 May 2025 14:20:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7sLm+zHUkyFO8V6QNghLQn0yiWsHfm8WU=V15K7K07Q@mail.gmail.com>
X-Gm-Features: AX0GCFvQzChipAAsH_IbAZosPG5_B84g3tcv-qhuY1vOrrfycyiz9i-JpJtmDoM
Message-ID: <CAHk-=wi7sLm+zHUkyFO8V6QNghLQn0yiWsHfm8WU=V15K7K07Q@mail.gmail.com>
Subject: Re: Metalanguage for the Linux UAPI
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, 
	libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 13:05, H. Peter Anvin <hpa@zytor.com> wrote:
>
> We have finally succeeded in divorcing the Linux UAPI from the general
> kernel headers, but even so, there are a lot of things in the UAPI that
> means it is not possible for an arbitrary libc to use it directly; for
> example "struct termios" is not the glibc "struct termios", but
> redefining it breaks the ioctl numbering unless the ioctl headers are
> changed as well, and so on. However, other libcs want to use the struct
> termios as defined in the kernel, or, more likely, struct termios2.

Honestly, I *really* don't want to go down that rat-hole.

It's going to be full of random project-specific issues, and the
bigger projects - like glibc - wouldn't use the kernel headers anyway,
even with some generic language, because they have their own history,
they deal with lots of other non-Linux platforms, and it's just all
downside for them.

In fact, it's all downside for the kernel too. I do *not* want kernel
headers to be used by other projects, because I simply don't want to
hear about "we do Xyz, so the innocuous uapi header change breaks
Abc". It's all pain, for no gain.

So as far as I'm concerned, the uapi header split has been very
successful - but not because other projects can then use our uapi
headers. No, purely because it helped *kernel* people be more careful
about a certain class of changes, and was a big read flag in that it
made people go "Oh, I can't just change that structure, because it's
exported as an API to user space".

If you _really_ want to do a Metalanguage for these things, and want
to support lots of different namespace issues, several different
languages etc, I have a very practical suggestion: make that
metalanguage have a very strict and traditional syntax. Make it look
like C with the C pre-processor.

There are lots of libraries and tools to parse C, and turn it into
other forms. Making up a new language when we already *have* a good
language is all kinds of silly. Just use the language it already is
in, and take advantage of the fact that there's lots of infrastructure
for that language.

                    Linus

