Return-Path: <linux-arch+bounces-7501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182B798AB67
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 19:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410B41C21A7D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1C198A2F;
	Mon, 30 Sep 2024 17:51:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA818C31;
	Mon, 30 Sep 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718702; cv=none; b=p5SPQp3lxUAEgb2nliLjt6waF4Xt1n7e70iJ7oPDUziP4U+Jnyxmi/zSFwADsbr1nIVHHZO08LGauUKmWDkSjmyqpTUwQ7++rbgFdXmTJ7M+qEOsUUdJ7SOr7cM0p3ZSG1HRmuMjX5BCd3JCK3qZhPmQH229W5Vjthh9WTj/8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718702; c=relaxed/simple;
	bh=PQ2VgHYe0Ngojxr8nNlQI/+nPbwGo4g+HQCTJc64GP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDh0bt9QIXwTqywyh9FOZzhpYeosZ+35wVVUcVKTyA0zwvCH6A7t2DjFK4q7c8Kgl4ujNDHdCCvBbEn/uo1FTgSuoevHsTgy+V/ntqM3ZatolbBXtVaitUx2s5i2iwb2uIt/ITOdALe0PIUxYnNkD3PjOUtYkOg+PKgQ++uldcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99eee4a5bso417475885a.0;
        Mon, 30 Sep 2024 10:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718697; x=1728323497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoyzlnnLRNj4i2u5Dgn44nDbhn4MB5fS72eP0TVQdtc=;
        b=O81Ppus9t8REbPpGcEtyXeb8y/xbWZk2CkPsqqsCGawxWH7Ddj6P0SSMdxjlOXh1N/
         RM3sUSnRqz/LwJgxjUMlwYjLXE7COf+ogR9qXFnzdO+MGQCy9Xofm/2p8p3f+/Z046Ev
         xCKy1Re+SXo17ZnX75KkEPzpBfsyOENXQTtJnf3XxWrBw6Jr8SG1mkX/5twuypZ5/Ncy
         3kA6CBVzf39W0v5XlPgcRE5ABzkQx94UPu5bvM1cofCEYqVBpizX+InR3dN2IU4T5g2g
         S23avZIP1DYaaONer6e0S0YhmAPLIizZlYDYRQ4tcsRPjxPaBh/1sg7176PJFdIjVwRs
         ouoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFs9Ik8AEiQB0iL4H5nmNncPPA+kd/F3NV3G6Co0gc++oOPNVBA78O1ZgJy3HxXcdnvojZY9xRYT36jQ==@vger.kernel.org, AJvYcCUiRdmrNtNGrTFZ4+SQae7Ig9CNQkvu42USZNLBkbiJ1cSWNJNDvhYgi99WdlZYjb8For2/Sgfgw0xJAQ==@vger.kernel.org, AJvYcCVr0iKjeZ7ujCr47hGQjEVR32yVBCjzR9/Y3pTQjDtxyaXAPTPeOOzzXjQVfiQ5H83qJufSggnyoxu+uOpA@vger.kernel.org, AJvYcCWXB+uM2TZkNG5Tot0CcREWJJfNZlTRkKe9+2D1UTCryH71Xx//oO+FK116SjCCtBayrxGL/s/KWgc=@vger.kernel.org, AJvYcCWb3mTL4edSQhE11aOrgEBCRNxxdJzfXKAYdqSjfKtPs7vrL7mWOsdoSLQcBwFAjT/xDDQiH/gLxNSaW2vX@vger.kernel.org, AJvYcCWr9ZafmlfD8tlXIHKaVFxBweKKNmqxrR4Br0Xw4cjeWXn884plcPwe58sQd8cecVcTtXxxHCGFnvuooA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6R3eRsYOufpOaO+ySb0WTWagO+wJschVEwRxjJbhdzC9CVAYq
	Sh0gNP+SEbQWvvmZOQGyBnx4AeetEVbdeoQ4YNHth625e/wOD5cdCrp/EboQ
X-Google-Smtp-Source: AGHT+IFrQXnUt9rGHYGl09CM7yMs469aVfJQ+cgoyxYWZ1x7U+9n59mLCbQBoUAY1g6J7P9AmAqIOQ==
X-Received: by 2002:a05:620a:28c5:b0:7ac:9c44:dde1 with SMTP id af79cd13be357-7ae3785615bmr2009444585a.28.1727718697333;
        Mon, 30 Sep 2024 10:51:37 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2e0cfasm38500391cf.43.2024.09.30.10.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:51:37 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a99eee4a5bso417474485a.0;
        Mon, 30 Sep 2024 10:51:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEVLRRqha2O1w1YOdq5YuGCYiw90qa3lUMoCIcGWOsmEZ9LnTrsNcsfVnKOEhNmgntrbJdgGJpqn+N0Wt/@vger.kernel.org, AJvYcCV3dEN6g+yN82R2wRAH9whin4y6QpEm5NRugt9uOvB4qKI/LYoyFBwIAq0/j3vi8CY8Zm7dvKG1eDjiOw==@vger.kernel.org, AJvYcCVIiD9Gvhpmg69fciM0PrBLv1KFPqV+fFUGmWVUAGZJW8qu5AkdaFm37Qf/ZBV8zdCtml49h7BTAT0=@vger.kernel.org, AJvYcCVmUrGeFtSlHc7FxMKS+Z/fOgUmBjXx5YEKkU4mVbBij9F82D/09gm1UkeUuFh2RWKCMkqD8n2wWVGDUQ==@vger.kernel.org, AJvYcCVw50OSr+HSXw7eSZMyzB+52cVEmWxyopjM90WUlOa3T03n/7+tsVdjGGxlIxwedAEnSOc9/DAUprPojQ==@vger.kernel.org, AJvYcCXYyWgfX86i/saQCZwASwKX+Om/zPtd/3ajAIsvTYnCkfolcUDMVGUCi2Oy83k+3DCQb163xiqBL8fj2uda@vger.kernel.org
X-Received: by 2002:a05:690c:60c3:b0:6dd:bbb4:bcc7 with SMTP id
 00721157ae682-6e2476334f2mr105898897b3.44.1727718393293; Mon, 30 Sep 2024
 10:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930132321.2785718-1-jvetter@kalrayinc.com> <20240930132321.2785718-6-jvetter@kalrayinc.com>
In-Reply-To: <20240930132321.2785718-6-jvetter@kalrayinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 19:46:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnb-fo2MP7ERwSj-sPNU3-QyikNinfhvgVa2DnR9jJrQ@mail.gmail.com>
Message-ID: <CAMuHMdVnb-fo2MP7ERwSj-sPNU3-QyikNinfhvgVa2DnR9jJrQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] m68k: Align prototypes of IO memcpy/memset
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:25=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.co=
m> wrote:
> Align the prototypes of the memcpy_{from,to}io and memset_io functions
> with the new ones from iomap_copy.c.
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v7:
> - New patch

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

