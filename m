Return-Path: <linux-arch+bounces-13338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96230B3C240
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 20:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1367E7A8AD9
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D93431EA;
	Fri, 29 Aug 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooi7zA7T"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A521019E;
	Fri, 29 Aug 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491020; cv=none; b=PW1RbyFm6pAlb8a+rD/IY1krM6TRHsBDRHPtN9L2g6fvl2XqOhE0K2ajXc66q4BwrBrW0zqqmwqw8GoxhTaqfD6YXbeF1pqAMS1jdN0Ayy4s5tcAo186lp5n6bcVptFkbsg7k0J3XhtZPAHrRYNIJdiVp8ZauRyAbpxvwUXX9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491020; c=relaxed/simple;
	bh=SXu3T17dYbp/ukZ8uJydGVdZ6zcCuFcjGzpDGMwa+Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKD1whapY09keBQKdviaQHsUdOtbcq2/nWQqUIfA+MBiClFxxigbachQOj6jlJA9Y7y4TZJ1fO9zlV5VDRkw3rfSFRk9i8jfFppsHaktJMqikvI6HRUqUDcy4VMbFdbyi/BmdApYw/Ho51oJK/GxkkaCav/QL+HCp1DPTuowxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooi7zA7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C02C4CEF0;
	Fri, 29 Aug 2025 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756491018;
	bh=SXu3T17dYbp/ukZ8uJydGVdZ6zcCuFcjGzpDGMwa+Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooi7zA7T9NmpAVf2EhalPYoUyuzdraHp5C4oj/l4tumul2weopj5FJ1utOM+alOHE
	 kKgusS+zU63i44OmypyAXKPtErTb3bB1GndFYFN2okuf9dT8hCaNdpoFVkJ5p8agh+
	 KkkEsMX5T3gC8JIm2Ov+5zT8s4L7tpEw7w/6ThgCsQL1Xlg6GXrAAbC6OLHWNTeh0w
	 FXzd4JTSiV52V1QufIh9KkzXjYT+hvbp3zSg4ylf/XGvXabRt4g7AwLZFCUhy7Zrgf
	 S8hNoGjWZuOpsjDmYOt//9aCCpoZgyxV/RwMeINevxHuMv5KmXpH/JQL39xFf9C15W
	 UspQvwHff7f7A==
Date: Fri, 29 Aug 2025 11:10:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>,
	Wentao Zhang <wentaoz5@illinois.edu>,
	Sasha Levin <sashal@kernel.org>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, johannes@sipsolutions.net,
	jpoimboe@kernel.org, justinstitt@google.com, kees@kernel.org,
	kent.overstreet@linux.dev, linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org, Wentao Zhang <wentaoz5@illinois.edu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20250829181007.GA468030@ax162>
References: <20241002045347.GE555609@thelio-3990X>
 <20241002064252.41999-1-wentaoz5@illinois.edu>
 <20241003232938.GA1663252@thelio-3990X>
 <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284fe8fa-c094-49b7-8e16-3318676d38e3@illinois.edu>

Hi Jinghao and Wentao,

On Thu, Nov 21, 2024 at 11:05:14PM -0600, Jinghao Jia wrote:
...
> On 10/3/24 6:29 PM, Nathan Chancellor wrote:
> > I seem to have narrowed down it to a few different configurations on top
> > of x86_64_defconfig but I will include the full bad configuration as an
> > attachment just in case anything else is relevant.
...
> > $ qemu-system-x86_64 \
> >     -display none \
> >     -nodefaults \
> >     -M q35 \
> >     -d unimp,guest_errors \
> >     -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
> >     -kernel arch/x86/boot/bzImage
> >     -initrd rootfs.cpio \
> >     -cpu host \
> >     -enable-kvm \
> >     -m 8G \
> >     -smp 8 \
> >     -serial mon:stdio
> > <hangs with no output>
> 
> This hang is caused by an early boot exception -- gdb shows the execution
> reaches the halt loop in early_fixup_exception().  Dumping regs->ip associated
> with this exception points us to the following instruction:
> 
> ffffffff89b58074:       48 ff 05 85 7f 4a 76    incq   0x764a7f85(%rip)        # 0 <fixed_percpu_data>
> 
> This is apparently an incorrect access to the per-cpu variable (the cpu offset
> in %gs is needed) and triggers a null-ptr-deref. Without CONFIG_AMD_MEM_ENCRYPT
> (one of the bad configs), it turns out the instruction is actually accessing
> the llvm prof-counter of strscpy():
> 
> ffffffff89b85a04:       48 ff 05 6d 94 7d fa    incq   -0x5826b93(%rip)        # ffffffff8435ee78 <__profc__Z13sized_strscpyPcU25pass_dynamic_object_size1PKcU25pass_dynamic_object_size1m>
> 
> This symbol is left undefined in the bad vmlinux, which explains why the
> faulting instruction is accessing address 0.  Tracing through the kernel
> linking process shows that the symbol is still defined (as a weak symbol) in
> vmlinux.a and vmlinux.o, but becomes undefined after the first round of linking
> of the kernel image (.tmp_vmlinux1).
> 
> After playing with it a little bit, we found the creation of vmlinux.o to be
> the problem. Specifically, if we use mold[1] instead of lld to create the
> object and pass it to the later stages of kernel linking, the symbol will be
> properly defined as a data symbol (and the kernel can boot).
> 
> It seems that the issue does not reproduce with LLVM-20. Nevertheless we have
> reported[2] this to upstream llvm.
> 
> [1]: https://github.com/rui314/mold
> [2]: https://github.com/llvm/llvm-project/issues/116575

Sasha pinged me on IRC earlier this week about this series and this
issue, noting that he was unable to reproduce it with a similar
toolchain version and the instructions above. I was able to confirm that
at 6.17-rc1 with this patch set applied (after fixing a couple of minor
conflicts), I no longer see this boot issue but it is still reproducible
on 6.12.

In attempting to narrow my bisect window to find what patch fixes this
issue, I noticed that this configuration actually fails to build with

  Absolute reference to symbol '__llvm_prf_cnts' not permitted in .head.text

in 6.15 and 6.14 as a result of Ard's commit faf0ed487415 ("x86/boot:
Reject absolute references in .head.text"). Bisecting between 6.15 and
6.16 reveals Ard's commit a3cbbb4717e1 ("x86/boot: Move SEV startup code
into startup/") resolves the build error and that kernel boots, which
seems to make sense to me given what code was involved here. It is
possible that arch/x86/boot/startup will want 'LLVM_COV_PROFILE := n'
since all other instrumentation is disabled.

I built v6.17-rc1 + this series with a fuller distribution configuration
and CONFIG_LLVM_COV_PROFILE_ALL=y. That kernel boots fine in QEMU but I
have done no further evaluation.

Cheers,
Nathan

