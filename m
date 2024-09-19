Return-Path: <linux-arch+bounces-7357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8997C8C0
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2024 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEBF1C21F32
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49819CC39;
	Thu, 19 Sep 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhMpvkHE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDD193432;
	Thu, 19 Sep 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726746772; cv=none; b=KMxpVI7fr3XZ2j5VA3CmeB4f0uZpGx4GGXyRMx9XP8d47lS+GPb5fr/Rq4U2NvOMNVx7N4ktiDyOrAgYAIiG8R0dVoGO+vgS3OOKB5pu5l3THezXscSQLy+6hSLS11NsysliXO5bFrEoArvmmL03yurM+rmPmbkrxM1+luJ4rAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726746772; c=relaxed/simple;
	bh=n2c8rCWw8z/lpoN5wgFADrTYkKDIlTR04TekYHp1qSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt63beBM0aj2ubebMvzIMrutSZIMq8AmUTluj9W4C7fKf71PQjOBV5z+Cv7k04Y+j49DWWS8uq+iyx9DpMyJyDLfYCvICyWU5F7d2dTH3WcGwCH4r/wRHTUnNrFH56YXqZGAr8IymXLc33GBmkSLizSoXQwxHx8o1WM/HZ6cTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhMpvkHE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582face04dso6581531cf.1;
        Thu, 19 Sep 2024 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726746769; x=1727351569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2c8rCWw8z/lpoN5wgFADrTYkKDIlTR04TekYHp1qSo=;
        b=OhMpvkHEdrEcd46I9hl6lNb8nnvZuJRKYxN4HiaJdxe6d0ygRqYOAS7G/iusxZMkQn
         7QLJpWeGV0ryE6XQcZKPz+zzLkWEAttxQ2K5ZYZ+s5q6sC0Nt6IpvBscjof8qckmA5cu
         08WUcPs3LDwoMlCYwHkYh5GdHOguQQxpUAalcqMMGw7MjtKiK1rdfcCbAEd3/hruofdu
         IFYZ8bcQ4QLKbhg+D8Z9Vf3OWMzzl0kuX77LlUrVRFsgT2TSRBYu8qKYYSC135J2m1ov
         kywK6Xz2ac3GbhDY2+Xvc/aql3OHUH/L9Jo3YOM/bme0zFH+abHjtMYGCDIw/hOZXR6x
         oBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726746769; x=1727351569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2c8rCWw8z/lpoN5wgFADrTYkKDIlTR04TekYHp1qSo=;
        b=aX5zq4rlnrBzooFVkcwd0rLRfjhufIjtXS0gdJLll7sRuvGPgX79DTFKuQysP91nQU
         cwfdBMPIsR01T/5gonwYeUj36n+kuT90D4hpdfR2kfAiOt+4oSgo+pMelf1ECjxeB+Te
         4Ebz/Mt5bLfYSyqcA8VvoTXBtrc2VuAgjF/5WwZ5bAalFp7VynoQJ+VLqF7iW9AgEs2V
         74uZTiiX4FtIx5VWzbNzEH0qng7f1gTZhr9CPAzaSsLwXF2N0zL8E3wV5WTX6T4pM+Mc
         VSWPQlcHPjOGNI7m5yFeEo8xus3JtLkKYK2otMGaLZvjcgQD7k13gjH1hg5eFUJRd/dk
         gCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF8Bc4uToV/790BRj8gFf0ZTHII9mlflkYdSCJQ1DMSvhprBQlC4aUD5/wPNM5xf6JehIBdFkCPyqYQSiC@vger.kernel.org, AJvYcCVaCUIWkKv4QbiZVdrsonc55eG03oMGbfDGsAKiBtgfWivVbDV1j/ORNbj4LJwdY7eaxd4pTbu7DgXZ@vger.kernel.org, AJvYcCWbZsLkUGxQqVBMfQw4YAgFrBnQ/qPq8IUssmpCGJVr7xaFHljDVQYMjVgtpZLHN1+quxwJwbG4/qEo+Kgh@vger.kernel.org, AJvYcCXBuVylbFLlTiv3bEF3KNWwhWx6VzlnymIsDH1vL2gpyj1pepGIiu3sNTDf65mFbrFj8PP0PSap5j8A@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbgtUn6ov2J7WUeywtbzkxX0JxB/XTrwQF6u3oG9cA26qUV9+
	3Z5ivlK72GHRMMp5viOpHlfrSNsRkhEU53CqIGu7XrHcuhaO7CfX
X-Google-Smtp-Source: AGHT+IGQcZIp8iyJg2gTDfan3U3gpkE7chV5pJXxPcG09Udi1LvNQFGlfel4EdOFjiYN4XeQ62uD+g==
X-Received: by 2002:a05:622a:1ba8:b0:456:953f:6fe6 with SMTP id d75a77b69052e-45b1602db49mr44449971cf.8.1726746769446;
        Thu, 19 Sep 2024 04:52:49 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d1::1023? ([2620:10d:c091:400::5:4589])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b1788f56dsm6783921cf.56.2024.09.19.04.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 04:52:48 -0700 (PDT)
Message-ID: <c65a07ef-6436-4e04-a263-7cad9758e9be@gmail.com>
Date: Thu, 19 Sep 2024 13:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
 Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, John Moon <john@jmoon.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens
 <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>,
 Petr Pavlu <petr.pavlu@suse.com>, Eric DeVolder <eric.devolder@oracle.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Benjamin Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>,
 Wei Yang <richard.weiyang@gmail.com>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Kees Cook <kees@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev,
 Krzysztof Pszeniczny <kpszeniczny@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20240728203001.2551083-1-xur@google.com>
 <20240728203001.2551083-7-xur@google.com>
Content-Language: en-US
From: Maksim Panchenko <max4bolt@gmail.com>
In-Reply-To: <20240728203001.2551083-7-xur@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sun, Jul 28, 2024 at 01:29:56PM -0700, Rong Xu wrote:
> Add the build support for using Clang's Propeller optimizer. Like
> AutoFDO, Propeller uses hardware sampling to gather information
> about the frequency of execution of different code paths within a
> binary. This information is then used to guide the compiler's
> optimization decisions, resulting in a more efficient binary.

Thank you for submitting the patches with the latest compiler features.

Regarding Propeller, I want to quickly mention that I plan to send a
patch to include BOLT as a profile-based post-link optimizer for the
kernel. I'd like it to be considered an alternative that is selectable
at build time.

BOLT also uses sampling, and the profile can be collected on virtually
any kernel (with some caveats).  There are no constraints on the
compiler (i.e., any version of GCC or Clang is acceptable), while Linux
perf is the only external dependency used for profile collection and
conversion. BOLT works on top of AutoFDO and LTO but can be used without
them if the user desires. The build overhead is a few seconds.

As you've heard from the LLVM discussion
(https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-including-thinlto-and-propeller)
and LPC talk (https://lpc.events/event/18/contributions/1921/), at Meta,
we've also successfully optimized the kernel and got similar results.

Again, this is a heads-up before the patch, and I would like to hear
what people think about having a binary optimizer as a user-selectable
alternative to Propeller.

Thanks,
Maksim


