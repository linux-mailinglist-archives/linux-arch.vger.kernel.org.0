Return-Path: <linux-arch+bounces-8099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58599D59A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433782838FF
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A91C3029;
	Mon, 14 Oct 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S+rmVU81"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A621C2439
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926997; cv=none; b=OLGDKY6r5irkwhrfeznGgC4vKLH+vEq/zxJF7B1esLAcbCi5+1PHjxKc3XF+7Rqr66EgDbXOq6YgyXmDFiZSOpGUy/7bswFnP1kAazFy82Y1UtsjAQoXqZHGw2ANJ5K6V0gD2QLB8dJBBcasEnEZz7EAK+iqn9eTI7eIcT6BfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926997; c=relaxed/simple;
	bh=CSNMcFDDijo4DbM019qkbO66k2XIx9LLGy8ogcn3trE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvBk4zKkHBCS09Hrc2nmYDzzDXgWbhjs+AyLWnqt4LuiwZdRnf2Fwo5sUROXlhxQuxTd52SMBtH/9Mh8/xvB5rRI9NNhQt47V5Ldg6JTQmwJZM5kBL4j8gxRcvjWmk62cB0EavFP4Q+sMDu4yb5GkeGWsg7DspQQzcJsM7NybB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S+rmVU81; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1883805e87.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728926994; x=1729531794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvsjTSFhK62MPvXHA5L9zbPkhQe3PYzLzcOgzWx9lrk=;
        b=S+rmVU819F5HE6uIl+W3PJCCUqtgpCb7BVC2QPpk1rT9mr+e3oGzHQiHFekmdolY0e
         h8sTtUVyDO4XSjinq2aQmmRHcX/XMdirHdmDiL5Ex9q8l9arqrGvbXVPTffC5gQT+AvZ
         9v7oP8ec+xS/6pj8NsqUNMU1MfnQ5kOK6dxRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926994; x=1729531794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvsjTSFhK62MPvXHA5L9zbPkhQe3PYzLzcOgzWx9lrk=;
        b=Mnarfy4ahv3tcLMLPh6qpYIhgK34lFZhoHhjAgliJnRNiaEopCtJWKO5CZPFIbkC+w
         tnl6x/TFWtrfdHQJgLUiiPSuEWneDJKW94b5xoZV8PEkcISm2CLLL97HAmH3e4Jd6DEE
         va6TkMfcYppjYNskouk9KzVk9CVW7cI6St72vmpcer9ErCOCFAmfJGpuy/l6O/QX1r4P
         YITshra+Mlxfr/Fz4lCflAWDAR1/1onMVnMC64m7Xke27reMDSaammv78UTNaKbLgMXn
         d4Nz8dCVZLYpA7V6S95JTxrWQpZhUW25VQl0aTCiRwjTj0gERnt0rHwXEPZQg+pxZgBg
         +/5w==
X-Forwarded-Encrypted: i=1; AJvYcCUE3iBNGH6luTXZGEg4qthkTdTQTM1rzcs1c28GwUrr/bJo+2cLueUTNFCIofE+TLv6Un4wIK9LTSO+@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOC1Ib1lWen7sYbxXoc432SWtZ0XMLOaAsm7Zsz/MQDxP5JLp
	SHxEz9APMnHfDOSQENWRBh4awkWKlZk5i4lU/jat9yAFDML0mIrrrt2XgJxhFVKUhf5d/U9eyQu
	tgpyjNw==
X-Google-Smtp-Source: AGHT+IF8nQFmSD6ZgKX/vnQohDgOwwgYrLx8YEhqzdtNPj1Ysf2jnPmfj5A0J70r0jg3eZU9/cdBIQ==
X-Received: by 2002:ac2:4e07:0:b0:539:88f7:d3c4 with SMTP id 2adb3069b0e04-539e5514af3mr3034234e87.29.1728926993904;
        Mon, 14 Oct 2024 10:29:53 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93729a687sm5195955a12.92.2024.10.14.10.29.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:29:52 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so201712766b.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 10:29:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw/n9BiYcQ0oIQYV1v7PZKCbzfoxEQxVrr0NFB4l0/k022lbU93Hvf7kn30LEjRVvkB5ZxdP5C9vzb@vger.kernel.org
X-Received: by 2002:a17:907:3f23:b0:a9a:a32:bbe4 with SMTP id
 a640c23a62f3a-a9a0a32bcb5mr437123266b.12.1728926991727; Mon, 14 Oct 2024
 10:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014125703.2287936-4-ardb+git@google.com>
In-Reply-To: <20241014125703.2287936-4-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Oct 2024 10:29:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
Message-ID: <CAHk-=wit+BLbbLPYOdoODvUYcZX_Gv8o-H7_usyEoAVO1YSJdg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use dot prefixes for section names
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 05:57, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Pre-existing code uses a dot prefix or double underscore to prefix ELF
> section names. strip_relocs on x86 relies on this, and other out of tree
> tools that mangle vmlinux (kexec or live patching) may rely on this as
> well.
>
> So let's not deviate from this and use a dot prefix for runtime-const
> and alloc_tags sections.

I'm not following what the actual problem is. Yes, I see that you
report that it results in section names like ".relaalloc_tags", but
what's the actual _issue_ with that? It seems entirely harmless.

In fact, when I was going the runtime sections, I was thinking how
convenient it was for the linker to generate the start/stop symbols
for us, and that we should perhaps *expand* on that pattern.

So this seems a step backwards to me, with no real explanation of what
the actual problem is.

Yes, we have (two different) pre-existing patterns, but neither
pattern seems to be an actual improvement.

           Linus

