Return-Path: <linux-arch+bounces-1329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B182A12E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB8F1C223B3
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AA4E1C8;
	Wed, 10 Jan 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmyIgXFH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712194EB22;
	Wed, 10 Jan 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbedb1ee3e4so3791761276.3;
        Wed, 10 Jan 2024 11:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704915919; x=1705520719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zRr9k3M5lt1NLGiBm4LGGbEU76LPHiRlYHf6Ykn1Ys=;
        b=QmyIgXFHRA92s3vFtTVyO5j+k1gQkY68yBDL64620m6Qwqb9HZcY7isSAZYh9d5/tm
         9UuVfIyz8zVX1N/QD6Rw0cedIcVI2rcQW2CKDd/ZDzpeLDT3NWlddg3asTxBvog7x4i7
         OBJh0CbNwmvsjK8k6FgjMQp2TUoYeov7thXqGAfDQ7A6UUwb/waOVddFVryszWrIKJsR
         SnwDvpUHja4SNAiUhWyAiVAyXoxeFfShZ/jw/ut2Nz+c/IDHC1HZiydnW9JDa+oRd6aF
         nEeMDFbluTOu13sLop5hGJU1hJN9ov2dMNlkaDStCgmZLyX2RBHBQNHobsHlWB74SBU6
         Ae4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704915919; x=1705520719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zRr9k3M5lt1NLGiBm4LGGbEU76LPHiRlYHf6Ykn1Ys=;
        b=BKT2qwxmJ3wcOM0prF4WQo18C+H0ocKL+7dC3Ca7Y3ymf2CoC0HC+xy7HZ2fOSzVVe
         VgEqWi7suHfQ0JpWoM8OQ8djygt+agzfYOc1U4DSykAMIEOae2fWDLPTDihWirS0c5PI
         ZmIju8BKk11+ObmOxxciZ70zRkkL/M9Oy3v1/uNv2kx8MJtehFa+gN4J/5mH4vadHrs6
         igiMpVzED5tG969zLjwi0FxfTfeSRx2ytc3q89Xfcq8ak/dGb0JA39+wv5lv6960tzO0
         /zlvG6BQKxtB8Clg3WVyT1Zm5YYUPnYKyhi/cWOpukivOLSKT5jBp8aUwmA9PbObDDav
         5lVw==
X-Gm-Message-State: AOJu0YzrEFPgO5WkZ5wwUpvjvyfu7sblOh8X/+6BK0PFF20zeOlLHBp6
	7GBZ0F2ID/dOhzRSGdvRc3FSPgd22+VN3Q==
X-Google-Smtp-Source: AGHT+IHIC4STcmIVvHNojmmb+kWLZtF32D5cncsDs8Rdjedin7IsN3qjxeZAoMn26pYsOd81Vi25VQ==
X-Received: by 2002:a25:9f85:0:b0:dbd:5be1:1768 with SMTP id u5-20020a259f85000000b00dbd5be11768mr133994ybq.73.1704915919301;
        Wed, 10 Jan 2024 11:45:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i29-20020a25b21d000000b00dbccc57e9c8sm1615656ybj.56.2024.01.10.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:45:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Jan 2024 11:45:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Rich Felker <dalias@libc.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Kees Cook <keescook@chromium.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 6/6] Makefile.extrawarn: turn on missing-prototypes
 globally
Message-ID: <ab94f844-a4ec-4b4f-b67b-2b67347596d9@roeck-us.net>
References: <20231123110506.707903-1-arnd@kernel.org>
 <20231123110506.707903-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123110506.707903-7-arnd@kernel.org>

On Thu, Nov 23, 2023 at 12:05:06PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Over the years we went from > 1000 of warnings to under 100 earlier
> this year, and I sent patches to address all the ones that I saw with
> compile testing randcom configs on arm64, arm and x86 kernels. This is a
> really useful warning, as it catches real bugs when there are mismatched
> prototypes. In particular with kernel control flow integrity enabled,
> those are no longer allowed.
> 
> I have done extensive testing to ensure that there are no new build
> errors or warnings on any configuration of x86, arm and arm64 builds.
> I also made sure that at least the both the normal defconfig and an
> allmodconfig build is clean for arc, csky, loongarch, m68k, microblaze,
> openrisc, parisc, powerpc, riscv, s390, and xtensa, with the respective
> maintainers doing most of the patches.
> 
> At this point, there are five architectures with a number of known
> regressions: alpha, nios2, mips, sh and sparc. In the previous version
> of this patch, I had turned off the missing prototype warnings for the 15
> architectures that still had issues, but since there are only five left,
> I think we can leave the rest to the maintainers (Cc'd here) as well.
> 

Not sure I understand why this was so important that it warrants the
resulting buildtest failures.

FWIW, I'll disable WERROR in my build tests for the affected architectures.
That is kind of counter-productive, but the only real alternative would be
to stop build (and sometimes, such as for ppc, runtime) tests entirely,
which would be even worse.

Guenter

