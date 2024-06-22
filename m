Return-Path: <linux-arch+bounces-5022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D969136B9
	for <lists+linux-arch@lfdr.de>; Sun, 23 Jun 2024 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8781C20B3F
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jun 2024 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800251C3E;
	Sat, 22 Jun 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HGGGwWwm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BCD524
	for <linux-arch@vger.kernel.org>; Sat, 22 Jun 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096413; cv=none; b=Sbt3nGfXpGrzqp5HO0K+m7WHrIAayBL506RL/hIsi3y/losmtgkB/W3NFa/egpXXefkYEmbWow33W6RGUsznOWHXyAu74Bx0n3vjY03J29mxpHjKFDI+YBlPVJqbl4diWlYPngjCuda/xmWxiD0VW43AcKU7/d1DFQNm2Abfbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096413; c=relaxed/simple;
	bh=kqyVjEgP3/7mXzKVNMbYCUNnf3n+IgnYTEx7zPeTiw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDAx9VznMv54rWyIIL1K29hXt/WJZNc3FnOsy81E0NKmQve/Bf9dwhCTuXqVO+fz+XQtLaV1t3Tdzc3nLj0sT20jrp82wpKbcGL37u4MXntN6wyLRXQWNmwnXAf3nhsk58ChFelrw2LjrBwXRc04L+4AoENlKYUAYvRQcycoLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HGGGwWwm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso13935011fa.3
        for <linux-arch@vger.kernel.org>; Sat, 22 Jun 2024 15:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719096409; x=1719701209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=HGGGwWwmkaDF31YSbU+52JRRKmV8jdMn0nVrqXtFg9HncnOfPTZBOGLRdDCuwc5hmt
         M5RU5367TPoloETrxxklz/lSbjDzBDdvQnvh8rGa9Ykoc/KHv2LUr1kiCp77fQGI4KAV
         4j5p34gAU2dl5vt6qxOW01ts7DuZibPlJ7x/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719096409; x=1719701209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=DJ7W+R3NhQEIqWFtnqBPpeyaRTnJLPW5VKun2T3EpNw+nper2w3h1eUdAedGT5nb/C
         hTWCSKPuV58cVr643+u7YNFeqFIS3iWK/RWEJz1qc7jDJLY4HddxGzWnrVC69ZCTmcim
         w3tT9HmHU9AVQfAyne7EsL/ouCkCcW9URpClN9y90PKzbCjjpUNatxMJbL2+/j2gtiVh
         ve05eHkKnDZFdqyWOoSKjze7fJgH8VsuHZZ+J65d5k4qvWUCZ9d0qbRw/vDoh/4sm+wN
         7yo2qS3w1ttCGJQzZm+0tath9pYKtTjphX4g9vmyOrMIyjm4EzhJ+oRqOu7iTNE/2qT9
         tneQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeH8UKd91I8yaTrmeUbblmOV2cQizKAMI3TIPwc2Oz3gKPxrGubh0jac5JmHbsAgLgWZJEpivJohzZ+Oq7F5pGAQEuWjod037/iw==
X-Gm-Message-State: AOJu0Yz6uWtT8cWMdiFyafsyYub9dEE0VhdeLQE/xA5vAZkmDTgPN3Me
	DCLxlcwL1LUOo/MFnXPuMboMlWisQWWj35MweP2StROV4WnjKuFrqo8ZAZAnA6qiecICpvDU/6n
	bAKc=
X-Google-Smtp-Source: AGHT+IGHpEmYERrSxBY8dfubFYvgGyR6xBdqBLPZgSXvELqvxP29Rp1aIEe07P8ArvnyPu00AT70mw==
X-Received: by 2002:a2e:b0f5:0:b0:2ec:53fb:39c8 with SMTP id 38308e7fff4ca-2ec5b2fc2a4mr5383681fa.10.1719096409042;
        Sat, 22 Jun 2024 15:46:49 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30474546sm2840244a12.50.2024.06.22.15.46.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 15:46:48 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3651ee582cfso1644901f8f.2
        for <linux-arch@vger.kernel.org>; Sat, 22 Jun 2024 15:46:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxpKBk+4M4aB1yMe1HJIWHu2yiKtlO3/rlkBV+ZdMSoiqj9KpzrO1zIds5gi3gttPMjNJvEr1O0sxyOLTcpmhCeiUKuwhkCdaQvg==
X-Received: by 2002:a50:d653:0:b0:57d:785:7cbc with SMTP id
 4fb4d7f45d1cf-57d4bdbfae4mr617930a12.26.1719096096671; Sat, 22 Jun 2024
 15:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622105621.7922-1-xry111@xry111.site> <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
In-Reply-To: <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Jun 2024 15:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 14:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> +cc Linus

Thanks.

> To sum up the problem: stat and statx met with "" + AT_EMPTY_PATH have
> more work to do than fstat and its hypotethical statx counterpart:
> - buf alloc/free for the path
> - userspace access (very painful on x86_64 + SMAP)
> - lockref acquire/release

Yes. That LOOKUP_EMPTY_NOCHECK is *not* the fix.

I do think that we should make AT_EMPTY_PATH with a NULL path
"JustWork(tm)", because the stupid "look if the pathname is empty" is
horrible.

But moving that check into getname() is *NOT* the right answer,
because by the time you get to getname(), you have already lost.

There's a very real reason why vfs_fstatat() catches this empty case
early, and never goes to filename lookup at all. You don't want to
generate a 'struct path' from the 'int fd', because you want to never
get anywhere close to that path, and instead only ever need a 'struct
fd' that can be looked up much more cheaply (particularly if not in a
threaded environment).

So the short-cut in vfs_fstatat() to never get a pathname is
disgusting - people should have used 'fstat()' - but it's _important_
disgusting.

This thing that tries to short-circuit things at the path level is too late.

              Linus

