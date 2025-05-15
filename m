Return-Path: <linux-arch+bounces-11964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF77AB90CC
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 22:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DCA3BC14B
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706829B215;
	Thu, 15 May 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHqLerH8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33C29B78B
	for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340778; cv=none; b=NmnpXapz98q7n8l5mQW+w1jNfsqKY71CF2TgQL/pbsvD8amXKzcvj7sxXLO0Abhnc/8jEUUKjwawjpvd1qdksjgqIaD7da2hhsDo3pjucXhpd2X2qT7c2vxP6Oi0KttYGZ9xxKocW9TmTTC5vn2+zGPvxzNjHkmxSu/BBla7KTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340778; c=relaxed/simple;
	bh=brvaCNelc7YXahd2uSS/BOsPi6t29ydKF9hIF5TbmrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeWiOwtWJPWyJ0/FM37/qJPA5Y8t7XxScMi7VGHj6YLtbcBWZFIQ5q2oCzq3EN+pNXKBZLQpWvMGwNA0q5xQeoMF5I970iHFhxKlPnrywFTt8gvDcE/0+alOhwD/3J2SbYLXFE1+kcI40Y7LFyHA+FgO27Fvzjx05qpBbmwZ2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHqLerH8; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-604f0d27c24so928779eaf.2
        for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747340775; x=1747945575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74h5E53rBfGQx17SrKrpULSjitWvVTH9Q5HQnQfV+Vw=;
        b=OHqLerH8TE+d0L3uw0G7gDrquH1ZygYe21U1wPLMJioP9Gv+b7uqyjDc8bHj5JTv+J
         uRnLldfd4tgDzDFYmFPq6t+kzMVS2EU4Bwl6TXoo1r25I2nsLHWc381MCaQ6ZyND+1CH
         V2lZwoxnrdHti7/8Uatp5FwsO8Wg6Vk2LStE1CmvdgWTxB0vtaO7qLZi0E4yfZa+V7V6
         nRgPPvavsP/ieR8ctQsVhC+NfqPHBOHCMudPCCc797gUJvn2LqSlTtZ4xC8V0Ij2fJgK
         RrpltTY7GXvvpApP9QezF5x7az0evUtkuhip4cqHkbe+mjJ5Mbof9Z0Qza4C432JUXWX
         oy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747340775; x=1747945575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74h5E53rBfGQx17SrKrpULSjitWvVTH9Q5HQnQfV+Vw=;
        b=W7VyJkfkn9lFlKaD9LMGlonsDZyjWpQoKOTWYLg89DFiztaLz/EncIHKN8XvtJIa/3
         nfT86bXPXDh1b1x/wIuwOXyepFPsc/uZNvLdq94RVN6fXUIlJypEL965fxwQ7l4YjWss
         mcX5cVUP04QlljCAGk60AJIHenl5w0c8J04LYSkTF5pIIT340a4q7IHjKA+diCK9pMV4
         WGzsENyRwr81kYtCzWUTagEkkx1OF3uZBJfhRqZRHGH4eSkh3TfDrdI8lWao1Etvx27z
         kEc0QJDF9IoUWMRsD07ewO6ZLKZG5d8lmVK1hkZule0VBbvna+PqLKo3jWPD437UzgAP
         mpSA==
X-Forwarded-Encrypted: i=1; AJvYcCUCCdmHmRS+ekI0TZ38Cfyt6BT/Tgz6rhCwiiK72fcfaNtARQdC4gjjwp3zgtZnx/sgRC2tDk5GxDRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8F7xA+/vpxmqxSp5lDvHCyQuY2s0I2DIwB4r3E2FMwQlNLLD
	UHXXRBUtELTXBGomOvybu8HC4W/pIZkA6iVoCNGtUElyzh8boXP6gV0f5cErXBbDIQZccQmB8Np
	pT4bMq9Y8OioNIJ7QzhSxmQdgKW5JBj7VOiGKdy0GyjC4O9EKv8Ypj+XXCxM=
X-Gm-Gg: ASbGncvfOl7e3pONWgAx7g8bz8O6YYzVk5Q9DGQSi7PuZftj2ShBzOfQvIiiU3YfsMV
	STE7UUhkv2wuWlH4cLEl4zjWDST9C//O+iID2jLE4Y1fnOR53zgC8X1tuM2zM7V0t+NFFLs8bQy
	VnsHrTuJg9C0rOv0GbuHIM7Ecf95EX/A==
X-Google-Smtp-Source: AGHT+IEXPw1mbv5VbhoW1N6a196J92okdrerz4TsjkTsSkgfX0OvSJbP932k7D95OQvz7RPVN3rTJT+yoz8vRfxb1H0=
X-Received: by 2002:a4a:ec49:0:b0:607:dd61:9c33 with SMTP id
 006d021491bc7-609f48646b0mr78587eaf.1.1747340775360; Thu, 15 May 2025
 13:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
In-Reply-To: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
From: enh <enh@google.com>
Date: Thu, 15 May 2025 16:26:03 -0400
X-Gm-Features: AX0GCFv-17pi2etCtr5en1wkSiXnNCapI8QapZ85yDA5wtpFlMHL3Xz2XtopVrs
Message-ID: <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com>
Subject: Re: Metalanguage for the Linux UAPI
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, libc-alpha@sourceware.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 4:05=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> OK, so this is something I have been thinking about for quite a while.
> It would be a quite large project, so I would like to hear people's
> opinions on it before even starting.
>
> We have finally succeeded in divorcing the Linux UAPI from the general
> kernel headers, but even so, there are a lot of things in the UAPI that
> means it is not possible for an arbitrary libc to use it directly; for
> example "struct termios" is not the glibc "struct termios", but
> redefining it breaks the ioctl numbering unless the ioctl headers are
> changed as well, and so on. However, other libcs want to use the struct
> termios as defined in the kernel, or, more likely, struct termios2.

bionic is a ("the only"?) libc that tries to not duplicate _anything_
and always defer to the uapi headers. we have quite an extensive list
of hacks we need to apply to rewrite the uapi headers into something
directly usable (and a lot of awful python to apply those hacks):

https://cs.android.com/android/platform/superproject/main/+/main:bionic/lib=
c/kernel/tools/defaults.py

a lot are just name collisions ("you say 'class', my c++ compiler says
wtf?!"), but there are a few "posix and linux disagree"s too. (other
libcs that weren't linux-only from day one might have more conflicts,
such as a comically large sigset_t, say :-) )

but i think most if not all of that could be fixed upstream, given the will=
?

(though some c programmers do still get upset if told they shouldn't
use c++ keywords as identifiers, i note that the uapi headers _were_
recently fixed to avoid a c extension that's invalid c++. thanks,
anyone involved in that who's reading this!)

> Furthermore, I was looking further into how C++ templates could be used
> to make user pointers inherently safe and probably more efficient, but
> ran into the problem that you really want to be able to convert a
> user-tagged structure to a structure with "safe-user-tagged" members
> (after access_ok), which turned out not to be trivially supportable even
> after the latest C++ modernizations (without which I don't consider C++
> viable at all; I would not consider versions of C++ before C++17 worthy
> of even looking at; C++20 preferred.)

(/me assumes you're just trolling linus with this.)

> And it is not just generation of in-kernel versus out-of-kernel headers
> that is an issue (which we have managed to deal with pretty well.) There
> generally isn't enough information in C headers alone to do well at
> creating bindings for other languages, *especially* given how many
> constants are defined in terms of macros.

(yeah, while i think the _c_ [and c++] problems could be solved much
more easily, solving the swift/rust/golang duplication of all that
stuff is a whole other thing. i'd try to sign up one of those
languages' library's maintainers before investing too much in having
another representation of the uapi though...)

> The use of C also makes it hard to mangle the headers for user space.
> For example, glibc has to add __extension__ before anonymous struct or
> union members in order to be able to compile in strict C90 mode.

(again, that one seems easily fixable upstream.)

> I have been considering if it would make sense to create more of a
> metalanguage for the Linux UAPI. This would be run through a more
> advanced preprocessor than cpp written in C and yacc/bison. (It could
> also be done via a gcc plugin or a DWARF parser, but I do not like tying
> this to compiler internals, and DWARF parsing is probably more complex
> and less versatile.)
>
> It could thus provide things like "true" constants (constexpr for C++11
> or C23, or enums), bitfield macro explosions and so on, depending on
> what the backend user would like: namespacing, distributed enumerations,
> and assembly offset constants, and even possibly syscall stubs.

(given a clean slate that wouldn't be terrible, but you get a lot of
#if nonsense. though the `#define foo foo` trick lets you have the
best of both worlds [at some cost to compile time].)

> There is of course no reason such a generator couldn't be used for
> kernel-only headers at some point, but I am concentrating on the
>
> Another major motivation is to be able to include one named struct
> anonymously inside another, without having to repeat the definition.
> (This is not supported in standard C or GNU C; MS C supports it as an
> extension, and I have requested that it be added into GNU C which would
> also allow it to be used with __extension__, and perhaps get folded into
> a future C standard since it would now fit the criterion of more than
> one implementation; however, the runway for being able to use that in
> UAPI headers is quite long.)
>
> I obviously want to keep a C-like syntax for this, which is a major
> reason for using a parser like yacc/bison.
>
> I have done such a project in the past, with some good success. That
> being said, the requirements for the Linux UAPI language are obviously
> much more complex. A few things I have considered are wanting to be able
> to namespace constants or, more or less equivalently, create
> enumerations in bits and pieces (consider ioctl constants, for example)
> and have them coalesce into a single definition if appropriate for the
> target language.
>
> Speaking of ioctl constants: one of the current problems is that a fair
> number of ioctl constants do not have the size/type annotations, and
> perhaps worse, it is impossible to tell from just the numeric value
> (since _IOC_NONE expands to 0, an _IO() ioctl ends up having no type
> information at all.) This is something that *definitely* ought to be
> added, even if a certain backend cannot preserve that information
>
> Thoughts?
>
>         -hpa
>

