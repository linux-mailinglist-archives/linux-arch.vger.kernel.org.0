Return-Path: <linux-arch+bounces-9032-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB789C4FE3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 08:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FFAB29096
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B2C20C028;
	Tue, 12 Nov 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbwDuuvz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF320BB59;
	Tue, 12 Nov 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397509; cv=none; b=S8YR5awIOLR/kpwHY7AjPuTD+PSfabDUFdamKQ3SdGWjWuOqdZboXPfOM5GDDHSr/c/XXhXYLCC0rAblxR07tGf0MA3VUUipgIMV+0snU9pNUzKw07R4HLWoC0ROBwaHNiAkC6xBlE9jRpnDZ9+31DnDOKEMajOyXsXdTRnPCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397509; c=relaxed/simple;
	bh=6Co9+HFhkrAyybpuUDGbybmXfat+6GD47OYnwCaf5jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khCgzn1DwhJ/2/ScmIljzz4wRoLNrOFMFwwalWt2Fs9PukjqM42xIhLnB46ns9GP5H8Koj7UU1r0q3IbPNbc5o8ZG9TH/OCERduh4rrdoHVCzt3dSDRnH18U81vsoFfK5Gcb8vRjQSrWd2BQxD8IobN3foJN+xu+cIZpHf07KBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbwDuuvz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fe02c386so6067220e87.0;
        Mon, 11 Nov 2024 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731397506; x=1732002306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvuH9yhCeBMlG36zLRmS+IcsMk1yHd7W71vxP6lAfWA=;
        b=CbwDuuvzV4zy5kimXk75YgkfJQfN4NC8aZCxb1pViLSJmbuWG7koEY7PVMsoH55Fqo
         cDumSaWy/Bh8onpRtGYGHgaM+3a3hns2A+JRPOY47Ph0dnoG/QNGbfKKjZG/l8KNloFe
         qFzWl2WQUK+cCT3ErRTjU7fqsKS2rOnfDqVQgDg8Uansnjgti8rJzCAgkmHzuCW9HxFz
         dqwNNn2F6pHJ/PKxDVZM9mvIcf/EyyBcbqhQG38Nn8OwC3YRPHYIan1y9ZBI9jF37ANc
         QIJ2ci0TG3MrrCyGbC28DHoLZmZmSz2NsZpetDBggatJQIU7M15xXr1LReGQUUObwYxe
         HUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397506; x=1732002306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvuH9yhCeBMlG36zLRmS+IcsMk1yHd7W71vxP6lAfWA=;
        b=bHg2YLROEfmcHqF+VwIF9FvD6ZKvo1XQupNgCjf6q0wy8xSfZS/7cZXwiqNzRNff+5
         kM0dYlxFVPZfd/i1PELG8SbwHWBoVnYTTSR+EarZXiODi/hBhcdL8bxDXQN4LZGu4ZHE
         YGsJpIfUESEzZtGdDmcFFHyCftKTU5RnBEad9wzYlVxeRQbjrBLOj1Jw/WTjuzvKRtk1
         +0c3pMmq8z0i1QKO2thKyOgjbrv2/+QpSPB53mRvYC1oN5tXhv0pngUkIZNbv+Viebiy
         yq6Oubn6qhc5LNqc58/h74txmJUVCzTiDkn67YYIN2/yuEDRWpzi8aKFVla/dTVaEApF
         YWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWLnTIHkfhrzoU5in2PZqZO/GPetbQMyqyjYObu/sY08pxCwKKYMsafqPxjX0yNsc4kBhn3O42QBzU@vger.kernel.org, AJvYcCVybPZQ6UErfO4gK0phn4ZLzb9r1rxBcMtVgi4Q8Edo4WJ2f4/8d6lsT0K9KeoEhbVs6YzDGl/+mpOO@vger.kernel.org, AJvYcCW7x8MFfaRF6EFUGvgyL+0t1H6OLUA1ycmpHLusCfNIfaJULWHNlxJQAaCmqE7sJhzGKCZX0U/uIehMTw==@vger.kernel.org, AJvYcCWuSlSGniHIDQJnjTIiBW0ehQ0AY2KUl7XMOFNGqHZvHrCWkAkclpXQa5j7AcYTTdikhpK8lL//LyQsjT8y@vger.kernel.org, AJvYcCX0CsxxeeUCQ3NR0xn0Y5fhOrgccNODGaZSpzf3MyVK8OHisH2wsGkfk2eC4w9fEcfvxMipvj83v9b3@vger.kernel.org, AJvYcCXZHkqqYK+tkDN40Vzb/VXMI3Wdm8RoOtPbMWqrUygUdHXeJCXZWFMRMDsjQvAIrLgNniubLG35GNydM0nG@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+1j8Fy/EMjQ9+OFLKXd7feNnC9fYyCJ4Drm4B7SxbRnLFj1p
	QNGq9NoXmD7Q4UoSDYus6knan4PgYUp854vw37T56ELEzN4eLihe
X-Google-Smtp-Source: AGHT+IGMIr+lUOiAWgiLqS9sR2Hcfvkf2KB7t1d9QR2hVKbD3J5J6DiuP1/RdyjRc4cRHYP/8VQpkg==
X-Received: by 2002:a05:6512:3e17:b0:539:ede3:827f with SMTP id 2adb3069b0e04-53d85f231c6mr5858903e87.24.1731397505707;
        Mon, 11 Nov 2024 23:45:05 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff178eec81sm19427331fa.33.2024.11.11.23.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 23:45:05 -0800 (PST)
Message-ID: <70772ce5-9dca-418e-9714-80ba4ae28959@gmail.com>
Date: Tue, 12 Nov 2024 08:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] Adjust symbol ordering in text output section
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>,
 Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>,
 workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>,
 Krzysztof Pszeniczny <kpszeniczny@google.com>,
 Sriraman Tallam <tmsriram@google.com>, Stephane Eranian
 <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-4-xur@google.com>
 <44193ca7-9d31-4b58-99cc-3300a6ad5289@gmail.com>
 <CAF1bQ=ShjoEQZGPjDoy_B6wZdD_jr-RevVXwEDPA_-o-Ba0Omg@mail.gmail.com>
 <e7cd2746-0ad8-452f-aa12-e3a37e8a9288@gmail.com>
 <CAF1bQ=SYeeKLUTfbqw-KH1rHJCj_CfJBuk+mZUrnnb7aDjRV2A@mail.gmail.com>
 <CAF1bQ=R18HLC2vjCGj+M=VYidrVzz3RT=U8cckXgpgrxc0kG0Q@mail.gmail.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <CAF1bQ=R18HLC2vjCGj+M=VYidrVzz3RT=U8cckXgpgrxc0kG0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-12 06:38, Rong Xu wrote:
> I compared the System.map files from Klara Modin. The linker script is
> doing what I expected: relocating the unlikely executed functions to the
> beginning of the .text section.
> 
> However, the problem is with the _stext symbol. It belongs to the
> .text section, so
> it is positioned after the unlikely (or hot) functions. But it really
> needs to be
> the start of the text section.
> 
> I checked all vmlinux.lds.S in arch/, I found that most archs
> explicitly assign _stext to the same address as _text, with the
> following 3 exceptions:
>    arch/sh/kernel/vmlinux.lds.S
>    arch/mips/kernel/vmlinux.lds.S
>    arch/sparc/kernel/vmlinux.lds.S
> 
> Note that we already partially handled arch/sparc/kernel/vmlinux.lds.S
> for sparc64.
> But we need to handle sparc32 also.
> 
> Additionally, the boot/compressed/vmlinux.lds.S also the TEXT_TEXT
> template. However,
> I presume these files do not generate the .text.unlikely. or
> .text.hot.* sections.
> 
> I sent the following patch to Klara because I don't have an
> environment to build and test.
> ====================
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index 9ff55cb80a64..5f130af44247 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -61,6 +61,7 @@ SECTIONS
>          /* read-only */
>          _text = .;      /* Text and read-only data */
>          .text : {
> +               _stext = .;
>                  TEXT_TEXT
>                  SCHED_TEXT
>                  LOCK_TEXT
> ======================
> 
> If Klara confirms the fix, I will send the patch for review.
> 
> Thanks,
> 
> -Rong
> 

This does indeed fix the issue for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

