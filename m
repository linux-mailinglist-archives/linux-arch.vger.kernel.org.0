Return-Path: <linux-arch+bounces-1056-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D9813AF3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE6282E1B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20A697B3;
	Thu, 14 Dec 2023 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PsuERfSd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F37697A4
	for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso1997946a12.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702583233; x=1703188033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjcQO6QUwn6LlRQi3EB5uy3LvsThnC1DrE9jgfSqzKY=;
        b=PsuERfSdGuDU5lhFCmQoSm9jic/d3LYXgTJBEek1T7KsV4s/iqKeJXi8H/ove6wPVp
         JIG7YlgWEXhNDULWA12qLSEkr3+DZPjze4ta5/QX1ee90Y0agI8eI9apDfGxXPuSe5bq
         KKQSqVeUdByOTp6TCHDsRFKJJKrAO+h5kEEo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583233; x=1703188033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjcQO6QUwn6LlRQi3EB5uy3LvsThnC1DrE9jgfSqzKY=;
        b=G2+fUkID938ZJAk/Te9LsRZXrJUbyhjTuX+JPZhnrqY7w85yR3sFsvprqmyRrNhOT+
         VR7NOxXs6+z2obXKE62nFnm65pofIzvD+1KLsKSLEj9K5BBan39W0OH0HVM++eYEhlHV
         Ney1ymr/LcMsBZ4vMvklvhBapX63TNqNYtp4lxAsCxUN5hn1XRM5dwZHa8LbLIQWCrca
         K2/i9bmwfzp3CYVeAv384krLay7HnkU01m2CDWDd4YhKWMatuaOLW5Ej9ibySycsjvE8
         n5wAWDUxcB/S2xM3Eo50rJmB/QE/noC+YdJRZyRTvSIY404GZz0PTyPDgss3/p8lfAoa
         lCNA==
X-Gm-Message-State: AOJu0Ywztxgzlll++I9jTl1MnhYzWYyjR9BzaUAv9/yxRQklqU6V5MCg
	xcq12TgHEHAjVyLVDjBgogtsC8nLhTsVTAt+WAO/nQ==
X-Google-Smtp-Source: AGHT+IFW98M9l4EyfuQyvkTozZtpeh3k/7FQMrai4im7hMtvF4IspynH2gbayDE/9ktKW6Eiqro+1Q==
X-Received: by 2002:a50:d71e:0:b0:551:d733:2c2d with SMTP id t30-20020a50d71e000000b00551d7332c2dmr4514102edi.24.1702583233670;
        Thu, 14 Dec 2023 11:47:13 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id x63-20020a50bac5000000b00552375861d8sm1596822ede.77.2023.12.14.11.47.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:47:12 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso198152966b.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 11:47:12 -0800 (PST)
X-Received: by 2002:a17:906:109c:b0:a1a:5397:b67f with SMTP id
 u28-20020a170906109c00b00a1a5397b67fmr11674986eju.4.1702583232499; Thu, 14
 Dec 2023 11:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home>
In-Reply-To: <20231214125433.03091e5e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 11:46:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
Message-ID: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 09:53, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +       /*
> +        * For architectures that can not do cmpxchg() in NMI, or require
> +        * disabling interrupts to do 64-bit cmpxchg(), do not allow them
> +        * to record in NMI context.
> +        */
> +       if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
> +            (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64))) &&
> +           unlikely(in_nmi())) {
> +               return NULL;
> +       }

Again, this is COMPLETE GARBAGE.

You're using "ARCH_HAVE_NMI_SAFE_CMPXCHG" to test something that just
isn't what it's about.

Having a NMI-safe cmpxchg does *not* mean that you actualyl have a
NMI-safe 64-bit version.

You can't test it that way.

Stop making random changes that just happen to work on the one machine
you tested it on.

           Linus

