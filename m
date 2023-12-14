Return-Path: <linux-arch+bounces-1061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A6F813B90
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 21:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453901C21ABB
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790416D1A0;
	Thu, 14 Dec 2023 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X4nPzm6F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D06A357
	for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so8185669a12.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702585976; x=1703190776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2BdSCgUChjTXVvCDYH0x028T7FO0mEYayRY84Xmsbc=;
        b=X4nPzm6FYrn6oYdiaRd9NKlkU78rNhH2qMFVcxn1ybaD6FHt9C4cd5zf3TJxn7/Z5/
         igdasLnn1teTQGI1rK2+6bmR8XBM5jzNCpfWvoV6KuQkR/yYyXYeAToe2405nDOIpe4c
         V75JMvz9xgiQQno6JrtTECQMlbKhqllbT41k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585976; x=1703190776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2BdSCgUChjTXVvCDYH0x028T7FO0mEYayRY84Xmsbc=;
        b=Yq94wMKoTqr8aGgARYWb27Mb4DffaDehVAHlus9l8R5D5ArEtUNH5xIKaaPsPWG5m3
         p+QG8RZbvkhmd4sEpauMk2pR+FeycCOt39xaDFXIYF5sdrDI1w5p/l2I6oXn+q43gWUJ
         VgCQwtTAUPXOoz6aqD7dXwVq9b14OZdURh4h5ckcTXAj0IMDkHhiQvsluqKMfWgyh5hM
         CDRwlE2QwfrwqYssFXTq/wlcNIXo2tYkbnsXK2jJDoGhxWTZf3zeOUIsqYbP7Mpu1ID3
         HDyJa24m6sVfNursFEOvvO4oCvi2DkY0Z0YAuoHwBw28RB90Poj0MMleb8Ijdp0DroKe
         4++w==
X-Gm-Message-State: AOJu0YxMsB+eqlXqVKO71k9gLxh3sRBjto3vB8JNmlubaIJ7gZDNgqWy
	UAMcspb1ITP3PaK98S6c7+M6JLhvXmtd2EnhwD9+XMXI
X-Google-Smtp-Source: AGHT+IHHPXITBpBK7aS6G2YXf5AkqnaSr+pQglqa5rWX45YTezb26fHNnRM7RLLm2YZ0B6Z15nc86w==
X-Received: by 2002:a17:907:510:b0:a19:a19b:78a5 with SMTP id wj16-20020a170907051000b00a19a19b78a5mr4670572ejb.104.1702585976264;
        Thu, 14 Dec 2023 12:32:56 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a1da2c9b06asm9864009ejc.42.2023.12.14.12.32.55
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:32:55 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso364266b.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2023 12:32:55 -0800 (PST)
X-Received: by 2002:a17:906:d8cd:b0:a19:a19b:78bb with SMTP id
 re13-20020a170906d8cd00b00a19a19b78bbmr4577583ejb.126.1702585975559; Thu, 14
 Dec 2023 12:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home> <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
 <20231214151911.2df9f845@gandalf.local.home> <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:32:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
Message-ID: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Read my email. Don't do random x86-centric things. We have that
>
>   #ifndef system_has_cmpxchg64
>       #define system_has_cmpxchg64() false
>   #endif
>
> which should work.

And again, by "should work" I mean that it would disable this entirely
on things like arm32 until the arm people decide they care. But at
least it won't use an unsafe non-working 64-bit cmpxchg.

And no, for 6.7, only fix reported bugs. No big reorgs at all,
particularly for something that likely has never been hit by any user
and sounds like this all just came out of discussion.

              Linus

