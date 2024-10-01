Return-Path: <linux-arch+bounces-7506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F3C98B3A7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 07:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B487E1C224E7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 05:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BD193429;
	Tue,  1 Oct 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaVQMaga"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691306F31E;
	Tue,  1 Oct 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760802; cv=none; b=BL0VLi9yFXEC5LMZEsmumzNjHu0V55RlXFdHr2IEgAJU7qnpMHA5s8xQVbBig/kn0GwrAmY+F6cHJeddpLjqLMb1Ip4RMz1zXPaoKRj5eOwslvNFRuZeFCWKcmD0/Mz0JJGKglRezcuKtp0uRwJiwfLq+OIat/NJXUHOjcZal0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760802; c=relaxed/simple;
	bh=ALkA67D2rrKVC3yq6JegYHLnnbAgFq9HD2IAj9UHyx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7BxmBmhO7/ZglhuShcpiCvqTm/qmT5EU2gtNYLAG8zRfhJn+eRBEXrXg/MsualD1XPpv3tC4XhF2XvkvAl5QjOZb+mcSTQpZ8d6Xd2UxzL/g592Z+j5j3/1ml2tNMNn7WYIn3rD6tUWVKKvmJKMTS/WvuM3+wpFaHsz7jmMDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaVQMaga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746B3C4CEC6;
	Tue,  1 Oct 2024 05:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727760801;
	bh=ALkA67D2rrKVC3yq6JegYHLnnbAgFq9HD2IAj9UHyx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaVQMaga3ThzkwWDWuQk6rDB3RSXwRBcTwVGj8nhKaCxd8DGvY0nFCd3IYRsTljub
	 AZKP4ayTicXJrMtWGj3619WfldHuCsfWcGmrgx6E5KyTalkkIaPvDa79j8IX7+KCf9
	 tyL1xiG/I6r77qcfTBBo8IHr09HTVxQ5ElVlGqCP6PER85aneiWgpkfNVBK7/pOc2d
	 0IB7OJr+GBkkTfq3dlA5pz5ppoFJHfbV+YEe6fDprG8RfaDEijzbt4+Mc2WLN9Cu7U
	 G+M9qW3AxZz15VbiWMQ7LPrCzm4ijKVB3gpMkuSL/R/mT8sVLa15UwdAicPRjd0T7A
	 AapjojwaZZpvA==
Date: Mon, 30 Sep 2024 22:33:18 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Packard <keithp@keithp.com>,
	Justin Stitt <justinstitt@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 04/28] x86/boot: Permit GOTPCREL relocations for
 x86_64 builds
Message-ID: <20241001053318.elfwwiyluw6rlynz@treble>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-34-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925150059.3955569-34-ardb+git@google.com>

On Wed, Sep 25, 2024 at 05:01:04PM +0200, Ard Biesheuvel wrote:
> +		if (r_type == R_X86_64_GOTPCREL) {
> +			Elf_Shdr *s = &secs[sec->shdr.sh_info].shdr;
> +			unsigned file_off = offset - s->sh_addr + s->sh_offset;
> +
> +			/*
> +			 * GOTPCREL relocations refer to instructions that load
> +			 * a 64-bit address via a 32-bit relative reference to
> +			 * the GOT.  In this case, it is the GOT entry that
> +			 * needs to be fixed up, not the immediate offset in
> +			 * the opcode. Note that the linker will have applied an
> +			 * addend of -4 to compensate for the delta between the
> +			 * relocation offset and the value of RIP when the
> +			 * instruction executes, and this needs to be backed out
> +			 * again. (Addends other than -4 are permitted in
> +			 * principle, but make no sense in practice so they are
> +			 * not supported.)
> +                         */
> +			if (rel->r_addend != -4) {
> +				die("invalid addend (%ld) for %s relocation: %s\n",
> +				    rel->r_addend, rel_type(r_type), symname);
> +				break;
> +			}

For x86 PC-relative addressing, the addend is <reloc offset> -
<subsequent insn offset>.  So a PC-relative addend can be something
other than -4 when the relocation applies to the middle of an
instruction, e.g.:

   5b381:	66 81 3d 00 00 00 00 01 06 	cmpw   $0x601,0x0(%rip)        # 5b38a <generic_validate_add_page+0x4a>	5b384: R_X86_64_PC32	boot_cpu_data-0x6

   5f283:	81 3d 00 00 00 00 ff ff ff 00 	cmpl   $0xffffff,0x0(%rip)        # 5f28d <x86_acpi_suspend_lowlevel+0x9d>	5f285: R_X86_64_PC32	smpboot_control-0x8

   72f67:       c6 05 00 00 00 00 01    movb   $0x1,0x0(%rip)        # 72f6e <sched_itmt_update_handler+0x6e>   72f69: R_X86_64_PC32    x86_topology_update-0x5

Presumably that could also happen with R_X86_64_GOTPCREL?

-- 
Josh

