Return-Path: <linux-arch+bounces-11968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7AAB922D
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 00:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F6A17A11B
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E1289823;
	Thu, 15 May 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W2lGOish"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CA21D3CD
	for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346823; cv=none; b=gYt0BZakXQOG55Wo1gHDibZuS/usyO7sd9WrwWm3Os9M66fygrZZd9G1TuYPyXPTmK1LWOFuOsWS58OFtIg5Dim74YWcsEai0Fy+jAUpHxYruVr8ofTsvBQF8RVxQNDyXY8ujUteAA//dMfeKpcmAMRvZ2FYryFF3VxbbkfH9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346823; c=relaxed/simple;
	bh=VOcjrs308B52KT52vs0HhqeVrWy1UWSL98594xsdx2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnHegwd+fPRVTCY0cvr1pzAxbwxD3BpPGlS+eaTjvOlj/EcuKcoOJmRHUgaPdZAp88G6piUWlbet1lqWKCLwl+oMFc+DQPq0PFznAlL2bOZwyGI5kXwG+b6T2BbnG9QKVc3e6BEp64VdNDnMO5QWAaLeNxA3UZ61CUj2zgFhAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W2lGOish; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad4ffb005d8so267047466b.1
        for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747346819; x=1747951619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhGwuGRW61usYD00HViI9ouZ/RQSyG12rMjq3gQRknY=;
        b=W2lGOishjVpKKoqBYtgB72QGgK6Y8b2vlBmNQh+QsgVwNGcqXCR/61ipqRUgRwjOvc
         6VX6Dbrtqvg9+igdWFnRX1Fkvu9JeXXk6dTpTLjr118d8gbCm8PCYIVWw39J1bzpSBmZ
         noK4VGzrNaSuIiSjYN1Fbklgt5dU0kYtVhFdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747346819; x=1747951619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhGwuGRW61usYD00HViI9ouZ/RQSyG12rMjq3gQRknY=;
        b=LTOuRTAiFlc4eUtLmk332q+siwursiT85XMrmtmWtUrWMGmInPQZfahtVhsVyIo0Zi
         a1ZqbIhGlI8A6X7S37bCVHWMPkZiwbuV107hYWkyQrVsAJFpl70cyC1aPnIi+UtLGS0Y
         XWrrzhPGl3G0JyNErbukDWnbYMBZmxzb+NL5306GxqbtPcMgRPfB0B0sYyVp9u86bX6l
         KinQ0PoUCTb5oqAkXHSOH21ByHu9a4YSAtg4BGdLeIFOPjT9VVyOVQBgHOL/qFi24MCi
         xY9D2aQbDwxvsqKtwJ2r0gIQnBiLKfYLfwACw/HdUjlaACThQz7MDsAsqe2nS2CCFRuX
         vhcA==
X-Forwarded-Encrypted: i=1; AJvYcCWjh/5q5E/XLReSTHdtDxhKgkw6QRgvRQZb2fDsS2I4OfFLCTlQoDex+OkJyAfeOZPJLpwLWWvk/5Kc@vger.kernel.org
X-Gm-Message-State: AOJu0YxNmUrrTlmVH8qtEM4W1csQHkTLOc5H+8RPW0KUGCrpm9EC1JS2
	WxjYeOUpDsHko/EHGBz7D70eJ+Ia1RPGmQCDQFQ9h0t2s3eeeKDBbfGKSoxupfvpMrqm8fYB0Fa
	yMh8+7Fk=
X-Gm-Gg: ASbGnctgBL0zvV8xZHTcs2n9r9Zh1iMegJ2WvjRJmGystEtYmpY6HDrECsMdQxMsAlL
	XYUgvP+jC4jxKd5+KIFX2YGi5pteMu7zlsN/6DEzQj1YH2clNhN8KpEs7zj3b1u8uBWFdz/UXFU
	fyjONDKHCFtgd1Qj6BZRGBGJhf9lznrjze0mIN4kWGn+Is7lr41uP7NN7SYUStmsCpxAqvQ7Pb6
	DMIs0nlvp2N28CA2NKK/1w3TsV1e4tXhSg8j3SUzF0z8qsBIfMpIT+s4Nr/uKNHepAWgV93tQOs
	wsErHC1C8/odwgiBcSn/PxQN4mfERUqBimNyA7J+L338/n4KpSZXfpFP94Eh9fT8m96tSGV657B
	Ol5gKsBQSZt4i37FDIIxTlegzZg==
X-Google-Smtp-Source: AGHT+IHLrfdsSuZQvbfHxJNJ8Hdc4uw7RLsM72qMLjP4yvP1gHKfYMrN4xX1a+eM1hnc4AufNyGdnA==
X-Received: by 2002:a17:906:ef09:b0:ad2:42f3:86e0 with SMTP id a640c23a62f3a-ad52d548672mr132282166b.27.1747346818935;
        Thu, 15 May 2025 15:06:58 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498544sm45548066b.143.2025.05.15.15.06.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 15:06:57 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fbfdf7d353so1874707a12.0
        for <linux-arch@vger.kernel.org>; Thu, 15 May 2025 15:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNy7HQsqCQoiQnFWhmRupnk3ExeFqwPGmAwOq13F4r0hroElSAf3ABLJxjFkrkHv4jecYopohLQZS2@vger.kernel.org
X-Received: by 2002:a05:6402:35d1:b0:5ff:b5f9:c646 with SMTP id
 4fb4d7f45d1cf-600900a5281mr695948a12.1.1747346817439; Thu, 15 May 2025
 15:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
 <CAHk-=wi7sLm+zHUkyFO8V6QNghLQn0yiWsHfm8WU=V15K7K07Q@mail.gmail.com> <425880dd-e694-4428-999e-a787a666de5f@zytor.com>
In-Reply-To: <425880dd-e694-4428-999e-a787a666de5f@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 May 2025 15:06:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whivBr0xME3h1Po9aJK8FE-+EhmL11ojT6hSLioGr4okw@mail.gmail.com>
X-Gm-Features: AX0GCFsqqthU2uUT1mopyAu0bi9uStWBYXDmLmZRvLj9PURyJOI3EnXwFtx9NyA
Message-ID: <CAHk-=whivBr0xME3h1Po9aJK8FE-+EhmL11ojT6hSLioGr4okw@mail.gmail.com>
Subject: Re: Metalanguage for the Linux UAPI
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, 
	libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 14:42, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Building it on top of sparse might still very well be The Right Thing.

You can look at the 'ctags.c' file in the sparse code, it basically
does a lot of this kind of thing: it parses the file, then walks
through all the symbols and #defines that it found.

It then obviously prints out filenames and line numbers rather than
converting the result into something else, so I'm not claiming it's
useful as-is, but from a "how to parse a file and walk the symbols it
declares" standpoint it does almost everything.

I just tested, and it looks like it hates the kernel headers because
it hasn't been updated to understand about the bitwise type and dies
with a

    builtin:0:0: error: unknown symbol __le16 namespace:0 type:13

but when I just made it not die it seems to actually do its thing, and
knows about how sparse considers preprocessor symbols to be symbols
just like C symbols are, just in a different namespace.

Obviously for things like ioctl numbers, you'd need to then make it
also actually *evaluate* the #define etc after you list them. You
could do that in sparse itself, or you could do it by just creating a
list of #define's from within sparse, and then have a separate pass
that evaluates their values. That 'ctags' thing doesn't do any of
that, of course.

              Linus

