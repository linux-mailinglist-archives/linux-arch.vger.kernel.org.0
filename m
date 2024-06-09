Return-Path: <linux-arch+bounces-4764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF95901688
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9483A1C209B9
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871445BFD;
	Sun,  9 Jun 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LxgnvY1A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647A3EA98
	for <linux-arch@vger.kernel.org>; Sun,  9 Jun 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948075; cv=none; b=lKkUCrnega/ec2nyvm9bGJWaYNPb5Ex6s12nIOteHFS8i1leAXJq/7UHtfZpRpes/oX3kEmiKh8cTT2QOfiixbqUyB/q0XINaAsF3r6GgSDjU+mATHnLfTxpmCR+Fbc5nfcZ84lHxcVDe2+EflRqI+gPoq8YvHP8zm2QcBmWNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948075; c=relaxed/simple;
	bh=rWELLHoGeL+cuZcwTGrspQgmi3NpQFHoFf+sewYQBwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9RJRr73QqP1kpgb3PkvQFLYfIxF1Gud2HlhVBqQ5oZKehDhdFbWwMvHE797ddYWQNT9CZ6FGpi/J6Fblb1WaTbu/wZzondoduo3Pmz4aPo9CJFo7DRfm3mVblRIHrv2ON+F7b9YW2w1wDDilTyUlQpzaaXFNVdNDX6LT79sAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LxgnvY1A; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f1f67d7aaso18336666b.1
        for <linux-arch@vger.kernel.org>; Sun, 09 Jun 2024 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717948072; x=1718552872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj9Z56DW6+nSHM9dJZ7yiVMylhEQOTIVepZXRaOEBmQ=;
        b=LxgnvY1AW+uPe0hZIftB4T9Dtfg/9PATXMfq3sTpaREiNmTloQbkKPZHV7kwtb9+2a
         j+3hkaj8O6Y96lhUVxumQowuMol5OFWhrtnGpmFszaxb9dXrz9zd44spwSuH+ITAWYwl
         N0yzJQWS4pLqWsT4ogmITI2JjkUhJnUfuqkIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717948072; x=1718552872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj9Z56DW6+nSHM9dJZ7yiVMylhEQOTIVepZXRaOEBmQ=;
        b=nlYRxv+0qQxG/CKVlE36VosR8S8CCoW/EFbDHXGrcyYEcXyGI8QEXh44yvnaBmvYk0
         WPSWFUwu7qEnwm7iSJgpwklDbMx+HIww8EEA3NEidhU7LXn8Rumd/r9ThoAlwjz1cuIL
         uOXjabRaTZnXSSJyHRmiWN3VhjHGsODVJ23+A28n2pFpwmPdjMjN6XUNYZH6VnSiZmbP
         Azztpct4DxvlCK7iCiZY1NTCBhGaFJ8Q5ZqI0VhsvgrGjivWpmUDcp5qeDC2vKaaa8Zt
         Huh4IdF3AWSgIYLJI1De6TFaEDKl5/PX6kRsazpOFTT4k8MDozRsXo5TuoPKwsb1G/p9
         Xrzw==
X-Forwarded-Encrypted: i=1; AJvYcCW8sTCV1Vvdg200qK8HJWiAsY3cODoZoztFHV7AMmUBmNfAV7ZJ78BV7gNrZgVLxk56o8a7nmChlCEO59QPiJO8rMG16kSqMazsZQ==
X-Gm-Message-State: AOJu0YzNlBtZIjWpaeTkhIeiN0Dy3PF9nnFVXSLfScVRaTnsg+9Kf8Cy
	+/znWeJES7+MBVCqlZy+2dJtfucwyc5mnYYqHoN3sWsK8VYZaUx0dyrxAxky/wBD3ESdz1J6v3v
	2TLA=
X-Google-Smtp-Source: AGHT+IFj5g0VJOutNR8za9M1/Ce/Ma19tannWAAqsxRtscoTZYWLwfLflPCQrlG9ZdrdOBnwImF9yA==
X-Received: by 2002:a17:906:17cb:b0:a6f:1c02:c322 with SMTP id a640c23a62f3a-a6f1c02c39bmr103491866b.71.1717948072003;
        Sun, 09 Jun 2024 08:47:52 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0369399csm232468266b.3.2024.06.09.08.47.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 08:47:50 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6ef8e62935so189747966b.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Jun 2024 08:47:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOaxrD3uYAcQuNWzkE4Mixq16zWFh2VXdEF+MshLrdYxYLKkcJAXxBhBXoOhRJYDrJyTOTnV6MGrt751GjV8b3l8pBzkDLpqrRcA==
X-Received: by 2002:a17:907:3ea0:b0:a6f:1b3d:8e0e with SMTP id
 a640c23a62f3a-a6f1b3d9041mr125143666b.25.1717948070458; Sun, 09 Jun 2024
 08:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240609112240.GBZmWQgNQXguD_8Nc8@fat_crate.local> <00BA183C-4EE6-46AE-AEC8-94B612222373@zytor.com>
In-Reply-To: <00BA183C-4EE6-46AE-AEC8-94B612222373@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Jun 2024 08:47:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheiidA4Nib0kY9jje9D_eF05rt8Z36C-QKKpobVg3gRQ@mail.gmail.com>
Message-ID: <CAHk-=wheiidA4Nib0kY9jje9D_eF05rt8Z36C-QKKpobVg3gRQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Jun 2024 at 04:48, H. Peter Anvin <hpa@zytor.com> wrote:
>
> So the biggest difference versus what I had in progress was that I had
> the idea of basically doing "ro_after_init" behavior by doing memory
> references until alternatives are run.

Yeah, that would make it a lot more complicated, because now you need
to replace the whole asm, and you need to write it in a way that it
can be replaced with alternate code.

It's a bit akin to what Rasmus' RAI code did, but while I liked
Rasmus' patch,  I honestly don't think there is any advantage to
having that "load from memory" alternate version.

At least for something like the dcache lookup, the "before things have
been initialized" state is that the runtime constant pointer is NULL,
so the pre-init code would cause an oops anyway, even if it had that
"load from memory" fallback.

Now, there may be other uses for these kinds of runtime constants, but
I do think the main one - and the one I wrote this for - is simply a
boot-time allocation. So I think that kind of "before it's
initialized, it won't work whether there's a load from memory or not"
is fairly fundamental.

There are other constants this could be used for - particularly things
like "size of virtual memory". That

  #define task_size_max() \
         ((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)

thing really used to be a big pain back when we used it in every
get_user/put_user call. We replaced it with just the sign bit test,
though, and now it's gone.

(I still see it in profiles in strncpy_from_user(), but it's not
really noticeable, and it's fixable using a similar address masking
thing).

I'd expect that there are other cases than the dcache lookup that
wants this, but none that really show up on any of the profiles _I_
tend to run (but I don't benchmark networking, for example).

There is the security layer blob_sizes "constants" that could possibly
use this, but a part of the cost there is that since they aren't
compile-time constants, the compiler can't just use a common base
pointer.

So even if those were converted to runtime constants, it wouldn't make
the code generation all _that_ much better.

                    Linus

