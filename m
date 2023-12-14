Return-Path: <linux-arch+bounces-1060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D64813B8A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35372835A1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6AA59E50;
	Thu, 14 Dec 2023 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="My6ZdEZ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96076A343
	for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso11647288e87.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 12:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702585829; x=1703190629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JS5aqGDyH1ekW0+NktEKhGSSqL1J+90vZeAFR9levjM=;
        b=My6ZdEZ7Jf21J3USf1CEIqz4HaqYBsmty6wkzLp8X8zFs6D3MLuEcD5K/CjumRzmgr
         azvyFHbDT088Rzl3WKeDOQ+2DRvOCnE2JBYVceFiomkZYXpRAOSkBJt6THZ5gSg5HHPc
         Jv9AwiTDRPODUK9VKQxp/yomn1YtJHHkpqv9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585829; x=1703190629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS5aqGDyH1ekW0+NktEKhGSSqL1J+90vZeAFR9levjM=;
        b=n80B0oJmGsd4HMUsV3l4BL+K/p8s5dIxouoM489rnUwjEzSSlLKht0KeoF0fu3gKUK
         qxZ7LY/GygPId6hTFYtk2GOG7bCUtx7uNoPnHQ5RY4Xo3YaOPEtw0VCmj3hBfBvfCugL
         BPY9WpKbH8T6HnkTR9MwzPFv9DfOMbQD0EKozJrq3250zze1cWyM0RgcR2LRhUvPe51g
         k5R3al+0jv1NdKRq8VBantpOcAuOMghaAJ+npKDloHp9E9FzRDBOnrLT+pmN6UvQPZhW
         7yWp5aNSfjmm2WBPlDooxJ2x+UQwnIoL1TE8oIb0RiufNRgmy/2LHiEcVC7rjnbTAXpp
         sZHQ==
X-Gm-Message-State: AOJu0Ywpisb0egbVf4iDtZw1Z8/YLXjppZvVe1MOUZjQjch8lZMhyCbT
	4d89ls64/+pf9uUgBMsaV1xhv5SAvZM/fwLFUyiiUDtf
X-Google-Smtp-Source: AGHT+IHL/OxVMK1eKP8GtN4LFNbPc8PRNHsDv2csg502VOtej3bNMWEUpfmr4aOsZi7RCI35c3LF7g==
X-Received: by 2002:a05:6512:2350:b0:50b:f3fc:1261 with SMTP id p16-20020a056512235000b0050bf3fc1261mr6618729lfu.1.1702585828861;
        Thu, 14 Dec 2023 12:30:28 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id vg7-20020a170907d30700b00a22fdf10c96sm2940970ejc.180.2023.12.14.12.30.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:30:28 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so8033635a12.2
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 12:30:27 -0800 (PST)
X-Received: by 2002:a50:cbc7:0:b0:54c:5d34:980c with SMTP id
 l7-20020a50cbc7000000b0054c5d34980cmr5413656edi.82.1702585827509; Thu, 14 Dec
 2023 12:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home> <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
 <20231214151911.2df9f845@gandalf.local.home>
In-Reply-To: <20231214151911.2df9f845@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:30:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
Message-ID: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> For this issue of the 64bit cmpxchg, is there any config that works for any
> arch that do not have a safe 64-bit cmpxchg? At least for 486, is the
> second half of the if condition reasonable?
>
>         if (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64)) {
>                 if (unlikely(in_nmi()))
>                         return NULL;
>         }

No.

Read my email. Don't do random x86-centric things. We have that

  #ifndef system_has_cmpxchg64
      #define system_has_cmpxchg64() false
  #endif

which should work.

NOTE! The above is for 32-bit architectures only! For 64-bit ones
either just use cmpxchg directly. And if you need a 128-bit one,
there's system_has_cmpxchg128...

                 Linus

