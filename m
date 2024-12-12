Return-Path: <linux-arch+bounces-9372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82199EFE56
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 22:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86F016964B
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E711DB34B;
	Thu, 12 Dec 2024 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbPAyHGG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D61DACA7;
	Thu, 12 Dec 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039293; cv=none; b=eBriHIzDvWeZAOfdxhMs0Y/6Ad87eZpntBWBklAZwfFtgbqN8dCAxyB+50SJ+odTEM62P7bBkJYtd9hK9++FqNhPhS1BEjXMu/Wc9z4kGBU5vm3Ac/7aI3RNJqfUFfTUQL4/0eWE/m+e7prAuruO3hnMhzQyrCTGpGnXiG8xpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039293; c=relaxed/simple;
	bh=4LkxwGqf00KAkhuSMledCldtKtbR6Iw+UH0KM4N3Uc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF+pYLsRJM+X4+QiNR9DiQjmFWgyKiJTkxqTxcRp8kAblzVSbhanvWnGsYX4wpMm3JrowG/ASDaEJVkcgOXwlSAndMhdEyjI019ojwz1y915lQ68TufCtXhPZVelZZfnNv4WtqAhAjtMrWsfqItQmAWeUI/KUmDzQbcKz5khBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbPAyHGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E685C4CECE;
	Thu, 12 Dec 2024 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734039292;
	bh=4LkxwGqf00KAkhuSMledCldtKtbR6Iw+UH0KM4N3Uc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbPAyHGGWrZOMtIFlaC+ZA5ToBZoyVOIzH7lc6Ue+xzf2hvvAdTkzYYjrfmIoNo2U
	 0i7WoJzxbWimE7i8m81s40n/tClhXoceBcNzGNcLHT82EeESj3XsYEFpgfAfsYJKBj
	 Blm+py40ucS82FdaPIHjJohGYGDnk3udhhHN0eIcgdzw+Btf2/sHfgJSxqlRhne3mu
	 bB9WEukKV71nOY95/3nunnVFfA7weaToPqepzGiA3ZjSCBeravZn/ppwGYjPckMsmy
	 5eilvbFn79v3v3/UJEiCta/HvHqCiKJnyQu9n/JXZ4bfFx0CXLq3NN1eug6P+7VLgI
	 qU7267NR6CK5w==
Date: Thu, 12 Dec 2024 14:34:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>,
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
	Yabin Cui <yabinc@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	Stephane Eranian <eranian@google.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Peter Jung <ptr1337@cachyos.org>
Subject: Re: [PATCH v7 7/7] Add Propeller configuration for kernel build
Message-ID: <20241212213448.GA865755@thelio-3990X>
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-8-xur@google.com>
 <c0a6ae91-c925-40d6-8f95-59a9144d203b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a6ae91-c925-40d6-8f95-59a9144d203b@linux.dev>

On Thu, Dec 12, 2024 at 01:20:46PM -0800, Yonghong Song wrote:
...
> > +5) Use the create_llvm_prof tool (https://github.com/google/autofdo) to
> > +   generate Propeller profile. ::
> > +
> > +      $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file>
> > +                         --format=propeller --propeller_output_module_name
> > +                         --out=<propeller_profile_prefix>_cc_profile.txt
> > +                         --propeller_symorder=<propeller_profile_prefix>_ld_profile.txt
> 
> Prevously I am using perf-6.8.5-0.hs1.hsx.el9.x86_64 and it works fine.
> Now in my system, the perf is upgraded to 6.12.gadc218676eef
> 
> [root@twshared7248.15.atn5 ~]# perf --version
> perf version 6.12.gadc218676eef
> 
> and create_llvm_prof does not work any more.
> 
> The command to collect sampling data:
> 
> # perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 500009 -- stress --cpu 36 --io 36 --vm 36 --vm-bytes 128M --timeout 300s
> stress: info: [536354] dispatching hogs: 36 cpu, 36 io, 36 vm, 0 hdd
> stress: info: [536354] successful run completed in 300s
> [ perf record: Woken up 2210 times to write data ]
> [ perf record: Captured and wrote 562.529 MB perf.data (701971 samples) ]
> # uname -r
> 6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39
> 
> The kernel is a 6.11 lto kernel.
> 
> I then run the following command:
> $ cat ../run.sh
> # perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c 500009 \
> #       -- stress --cpu 36 --io 36 --vm 36 --vm-bytes 128M --timeout 300s
> # good: perf-6.8.5-0.hs1.hsx.el9.x86_64
> 
> # <propeller_profile_prefix>: /tmp/propeller
> ./create_llvm_prof --binary=vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39 \
>          --profile=perf.data \
>          --format=propeller --propeller_output_module_name \
>          --out=/tmp/propeller_cc_profile.txt \
>          --propeller_symorder=/tmp/propeller_ld_profile.txt
> 
> $ ./run.sh
> WARNING: Logging before InitGoogleLogging() is written to STDERR
> I20241212 13:12:18.401772 463318 llvm_propeller_binary_content.cc:376] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is PIE: 0
> I20241212 13:12:18.403692 463318 llvm_propeller_binary_content.cc:380] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is relocatable: 0
> I20241212 13:12:18.404873 463318 llvm_propeller_binary_content.cc:388] Build Id found in 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39': eaacd5a14abc48cf832b3ad0fa6c64635ab569a8
> I20241212 13:12:18.521499 463318 llvm_propeller_binary_content.cc:376] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is PIE: 0
> I20241212 13:12:18.521530 463318 llvm_propeller_binary_content.cc:380] 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39' is relocatable: 0
> I20241212 13:12:18.521553 463318 llvm_propeller_binary_content.cc:388] Build Id found in 'vmlinux-6.11.1-0_fbk0_lto_rc19_612_gb572dfac1b39': eaacd5a14abc48cf832b3ad0fa6c64635ab569a8
> I20241212 13:12:18.521611 463318 llvm_propeller_perf_lbr_aggregator.cc:51] Parsing [1/1] perf.data ...
> [ERROR:/home/runner/work/autofdo/autofdo/third_party/perf_data_converter/src/quipper/perf_reader.cc:1386] Event size 132 after uint64_t alignment of the filename length is greater than event size 128 reported by perf for the buildid event of type 0
> W20241212 13:12:18.521708 463318 llvm_propeller_perf_lbr_aggregator.cc:55] Skipped profile [1/1] perf.data: FAILED_PRECONDITION: Failed to read perf data file: [1/1] perf.data
> W20241212 13:12:18.521718 463318 llvm_propeller_perf_lbr_aggregator.cc:67] Too few branch records in perf data.
> E20241212 13:12:18.554437 463318 create_llvm_prof.cc:238] FAILED_PRECONDITION: No perf file is parsed, cannot proceed.
> 
> 
> Could you help take a look why perf 12 does not work with create_llvm_prof?
> The create_llvm_prof is downloaded from https://github.com/google/autofdo/releases/tag/v0.30.1.

I think Peter may have reported the same issue on GitHub?

https://github.com/google/autofdo/issues/233

I wonder if this is a kernel side or perf tool regression?

Cheers,
Nathan

