Return-Path: <linux-arch+bounces-9197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305E9DF5F0
	for <lists+linux-arch@lfdr.de>; Sun,  1 Dec 2024 15:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B0C16309A
	for <lists+linux-arch@lfdr.de>; Sun,  1 Dec 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F31D14E2;
	Sun,  1 Dec 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMtj5vAD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE613AA38;
	Sun,  1 Dec 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733063497; cv=none; b=B85V8Dx9VHtAK5coTRpwlVMoLfM24L+bkEnBsGX7rV2SN+Z6drST0HdW3N6Q2k54jnZHpsbqmoR7Cjai69Nx0G3WtrWHO9myRWUSAvWW8caIQgzXZ2N889KDE8I+VX3Ea9inzgOgp2kwI0CF3bM8BFV+e58ZmEE2IdJoJIYXdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733063497; c=relaxed/simple;
	bh=cs07FUKuBT285LCr8xyS8sJE5bAzCSjYVFNiRrNf6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSCn2J9aFPPMAU7ESKldf+8hT2xX/W+AvLBxSRQb+u9D7zeLHqn/sUamwoofx2eUds0SVovQnqFD+xgMcYivWDEuyRhJUZu/0Z9h4/ADAq506VBBXzdiAG1OwtHbjwPf9cXmIIB3GM0ZPQGgdkKbZYgDrFFCjHiQl/3+OIQ0PyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMtj5vAD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21288ce11d7so28866735ad.2;
        Sun, 01 Dec 2024 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733063494; x=1733668294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSs1okWPJ9Uo0V4mm18+tBBS4yF0aCTku8uJEQLNf9w=;
        b=UMtj5vADnGfyt/yIUlrivvbkTUZvB6d2NgK9bjovReJP5qxF1MCs+sp5DKzIMyfxd1
         kdsCCAZmrySq/x0SFumMcr7GVs9iPwiN5gHJvFXrEc7+huErAdbBWcDocSKuy8Gjuj7X
         hvl16YZHBdfmAQ+PUJoKe2MnFdJRgOpe6V2tXJeBbnichnPIe5JY6M00PRu7w4kHq6Kl
         S1weHkyir8NLy2R7hWw1FILZYA56MVU6a0K7N/jP7ldyYxSL/gNOPaCrUb0iPLVVVqiM
         +cp8FCZWKFTDQf2K1IuaW8l5eHxbCtvu9G7CRF/s2tYyrQwn5GdPJ5/WWWjmNHUfBDvE
         2QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733063494; x=1733668294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSs1okWPJ9Uo0V4mm18+tBBS4yF0aCTku8uJEQLNf9w=;
        b=aTlpy9bD5WdF5jC3fdyLfH7CbmldWqTDywY8YqsuPw/kC1t53CkY8RTGAWapy0Cl1F
         axoLkSsHuA5ymGUxqyJQxE96TOUQwsXfGO1shs24goLfpDZeRj6eJw4wO5m4AfOv1udx
         0ys2IAj5fbIt8saSfYfS/Tmt0fUi4Ji27W1gcUrwIgBiOXmzKfzNOMWhBrFiMhee4B/N
         IkG56N7uCaiWm9CxtcQ+eWKq9eotL/sohlN8JMxTnl12if6Ip9TpGKheIdF223flGA+m
         oz2VabcKoLiu6lx6IwVdb0Ikx3dUhVkBg+NDRQlcm7fju8owRmFNrFiddC0sKRWQEW3a
         waZw==
X-Forwarded-Encrypted: i=1; AJvYcCUYnFJ2X/bIHnRT3YzxPasik6AYnSsD8LI39RY889aYmy03GXm8aLDOvFOQUTI0jbl7/eea+dFNJ+iD@vger.kernel.org, AJvYcCUZTrRWv5Wu6tpE7d/FFKGq2V4V7NNL+kRBljGTvuqOml+EKCswd6A+aOpOoP8IyWjcXHJr/HvZGhb5LZIB@vger.kernel.org, AJvYcCUjQ79PVQOfeM2IBaxMjyE24ANhTuvRJNqrYXrxfUPGIrtBU0RScoNln71qAoWBstCB6tQ7IzRJJ7yAnV1H@vger.kernel.org, AJvYcCUnpovNeYCm7aX2Vovn9cE27i7NUiNvfRrqWhc5KVKoFiTv+lKJ4mAhV9OhVlUC45xaadIxh6y4oFD5+DjXgUY=@vger.kernel.org, AJvYcCVFg1kSJnupBOE9hChk7QXlpngzc6x61Vf8G8G0wjWDgycjDpebJ4VUZKpTBySGjVPwybmG093K7Lk9@vger.kernel.org, AJvYcCVVDT/qT5ly/Y9XsDyR/dVoajBNw4o6HtRhzxaPGj/e/kp3FPxTWMJ7R+SwXiDQ3DuDYSwGEkqfLjtf@vger.kernel.org, AJvYcCXRKezgB4VLLDUBvMZb4/xAJryewxipFRmgwhCfDMYlWRXEY+xTjg0MR9OZdHj0o73g5Nx8k6okneEDLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3kxSiphgopXUBAUbvB4dNtAHrIo8xZTAwa4st/CbKLzFjmcz
	05DbHNkyPJkrJVvslahYMJBgHSuatR2FNHzPnTa28LFLNv4ddV47
X-Gm-Gg: ASbGncuNEcLI4UvrABdBHhRusVtqjkQrqlB+DltdXUzvrUFLvTZco2TDyViEISO2Pbq
	9Q5WlHKlov5I50mbnG/lC5DWD5UrgCo8v7/EZTd3D1kSGumpvJoHDEUzIYoJmYz9/TJQ4J2nVj/
	/n4BvYjRfX+RmOw8S9/Pz7d2H+rZu3gNkm5e8nCwuzWZOC1KTweC9ZoSHHCtyjTulRl6i579JcC
	UhJIpJ7kP+N7fuOK74E1EBUbyaJtDXuk7vHrsivOSiF1WSj/EtQ0EfNWXpj1gg=
X-Google-Smtp-Source: AGHT+IHez05EYi6Jr4b/fsMBN/z//mvCD2nUHZ3frqiYhHt5hXzXEq52h6WucQvOD9jNiEl0syoZRg==
X-Received: by 2002:a17:902:f70b:b0:212:46c2:6330 with SMTP id d9443c01a7336-21501381475mr240993735ad.18.1733063494317;
        Sun, 01 Dec 2024 06:31:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521986004sm60223015ad.184.2024.12.01.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 06:31:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 1 Dec 2024 06:31:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Maksim Panchenko <max4bolt@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yabin Cui <yabinc@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	Stephane Eranian <eranian@google.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org
Subject: Re: [PATCH v7 3/7] Adjust symbol ordering in text output section
 [openrisc boot failure]
Message-ID: <5e032233-5b65-4ad5-ac50-d2eb6c00171c@roeck-us.net>
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-4-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102175115.1769468-4-xur@google.com>

Hi,

On Sat, Nov 02, 2024 at 10:51:10AM -0700, Rong Xu wrote:
> When the -ffunction-sections compiler option is enabled, each function
> is placed in a separate section named .text.function_name rather than
> putting all functions in a single .text section.
> 
...
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> Tested-by: Yonghong Song <yonghong.song@linux.dev>
> Tested-by: Yabin Cui <yabinc@google.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Kees Cook <kees@kernel.org>

With this patch in the tree, the openrisck qemu emulation using
or1ksim_defconfig fails to boot. There is no log output, even with
earlycon enabled.

Bisect log attached.

Guenter

---
# bad: [bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a] Merge tag 'turbostat-2024.11.30' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
# good: [2ba9f676d0a2e408aef14d679984c26373bf37b7] Merge tag 'drm-next-2024-11-29' of https://gitlab.freedesktop.org/drm/kernel
git bisect start 'HEAD' '2ba9f676d0a2'
# good: [831c1926ee728c3e747255f7c0f434762e8e863d] Merge tag 'uml-for-linus-6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux
git bisect good 831c1926ee728c3e747255f7c0f434762e8e863d
# bad: [6a34dfa15d6edf7e78b8118d862d2db0889cf669] Merge tag 'kbuild-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad 6a34dfa15d6edf7e78b8118d862d2db0889cf669
# bad: [e397a603e49cc7c7c113fad9f55a09637f290c34] kbuild: switch from lz4c to lz4 for compression
git bisect bad e397a603e49cc7c7c113fad9f55a09637f290c34
# good: [d6a91e28d11902e6cd5715633ed6f9b6df75de32] kconfig: qconf: remove unnecessary mode check in ConfigItem::updateMenu()
git bisect good d6a91e28d11902e6cd5715633ed6f9b6df75de32
# bad: [0afd73c5f5c606b0f8f8ff036e4f5d6c4b788d02] kbuild: replace two $(abs_objtree) with $(CURDIR) in top Makefile
git bisect bad 0afd73c5f5c606b0f8f8ff036e4f5d6c4b788d02
# bad: [db0b2991ae1aac5ca985ec6fd8ff9bd9b2126c9b] vmlinux.lds.h: Add markers for text_unlikely and text_hot sections
git bisect bad db0b2991ae1aac5ca985ec6fd8ff9bd9b2126c9b
# good: [315ad8780a129e82e2c5c65ee6e970d91a577acb] kbuild: Add AutoFDO support for Clang build
git bisect good 315ad8780a129e82e2c5c65ee6e970d91a577acb
# good: [52892ed6b03a14b961c1df783ed05763758abc73] MIPS: Place __kernel_entry at the beginning of text section
git bisect good 52892ed6b03a14b961c1df783ed05763758abc73
# bad: [0043ecea2399ffc8bfd99ed9dbbe766e7c79293c] vmlinux.lds.h: Adjust symbol ordering in text output section
git bisect bad 0043ecea2399ffc8bfd99ed9dbbe766e7c79293c
# first bad commit: [0043ecea2399ffc8bfd99ed9dbbe766e7c79293c] vmlinux.lds.h: Adjust symbol ordering in text output section

