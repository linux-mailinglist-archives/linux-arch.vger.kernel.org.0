Return-Path: <linux-arch+bounces-7507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49798B4F4
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 08:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9451C23592
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 06:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030B1BBBD4;
	Tue,  1 Oct 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwBYHQaz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905C27468;
	Tue,  1 Oct 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765786; cv=none; b=WwI9bai10R1XdL5LvCdb60Ruj9EB4kX1IGGN+h9nI5NZ9qPbYpIkMeyT5OTlNhgLB+lgqIZpgiIEI0WnXPUoCP9QKPi8W28/awQxt9RFTUXWQc3Uys3Q+YAeHh9ufhWGPMP/5ka6xxDme+P+dyWtvbW0YkkoKpNk9j85/RXHcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765786; c=relaxed/simple;
	bh=D6cq+9W5AquN6Xivssj0gJ1Jk4JQ0mfYEn2CA9+npXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxADuRegO1vz5uNQcUlg99joUnxiXrQXHSTRxJYot8Pq1tCJjYCwa80x7P2k0gSL8iyvT71njphVgQkQUFvITGEgs2P6ZWUjgyIwZPPyDMOwVBXwoCR7wRBBsr2qb39kovT9ncNHFtza4nqLDn4umvNMnEPrpBLKwFThMo5Yxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwBYHQaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F4C4CED6;
	Tue,  1 Oct 2024 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727765786;
	bh=D6cq+9W5AquN6Xivssj0gJ1Jk4JQ0mfYEn2CA9+npXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XwBYHQazazbTC4OwId3vnrFAgc6CpLItRV3CT+Z8Gu23wph58CKcedFo7OLdarXFj
	 CfBr/fhizt+I319h5X05aQeNiGEwLpOlTkxFwdMvZp5tn26hL9grIrgluiUanZgVrj
	 0ryllcIGgHjRky7zD5Cq7OsKZqK4RkRI4/CJstCL2fYk+KBEVoQob6cme8zRgaORsv
	 8IC6faZd2aGl4jfIjpTmpGu86/o4/aahDo/ckVnRLhdwe1cSJTcyxtGmwBVe5kWta6
	 zAbfWFj5Dzv5UH3KDkLJ7Igmws7XQ8kbnjqJSF3yJWaphRu3BKFYLpSFA19jzUWCHz
	 4bi5hwVR6eikg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso60880411fa.0;
        Mon, 30 Sep 2024 23:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb5hyErHg8L+nlaYnCMwManPT29OgGG75N5SMSKloatCgBuklXXMSx2eV4yimmif3wUk8ctXjcp+vHOMVG@vger.kernel.org, AJvYcCUiBBqDH1Rk5CQ8vLslCmC/Xi7qfEu1NX1BRQKP+EkyP2E2Nxqt67MaUQJC2NBcMlkyWJ7BNb4szZUvsAtmjdo=@vger.kernel.org, AJvYcCUm6kZGpEHb76YAe/a1ZfTGVchBQlyX4EUgpNQJijcgQRPxvVg0m69emcfJL0xlA1ObScZoM0+UmgWo9PMd@vger.kernel.org, AJvYcCVR23sffSw7+s8WHHsh/QRWZqSUnBSfBzFlHy3NdQaSePyRp27+SUuWpX3dUSA+s7btKv4KtlpfYmsc@vger.kernel.org, AJvYcCVk7EvOcGbNafkzEELiaW0XX4/dAMKhzeaP9myUqJqYPUW+CaA72tq2XrwVjJcbalYY0KIWAQ2Ox6I9qrCtHBjbWQ==@vger.kernel.org, AJvYcCVkqg2FaRqXxkztdXl6Qg2ZLbyRAxc2++5Icc2R0fpNfIdY7w/OUH2F5t1fyxYuXRrjA9F6fJvJhWjB@vger.kernel.org, AJvYcCWJUthhIvNr4CBi7JTh00/Xf1hcUNTTMWspSCRlOgkq8BnBYIUFIahac9hC/CIWpK4L8K4=@vger.kernel.org, AJvYcCWMyKtbai3/+CMUxxUAWRaUoxT63Z6NiQHeXfwlK375Wkv/AXfBxKIUq9xOBgn0rLyBsG1TO3IKXQUHNQ==@vger.kernel.org, AJvYcCWazTJ/MRGwc1ZpLlQfAWrTj54guFFdiwwwZU2AwyRDc04z+N9tCqfvuKOXEKqEthvzJvjNPjXmmw8=@vger.kernel.org, AJvYcCWk4JcjjEkIQZslMHYb9A45
 qkunEL5rjByj2wasO2nknJYRCQbyly1eTO7stb84m02o0HvxOYqZAK3wIjIp@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCf21TVLxRAj0tdVi4muVfet14Czx+Po9K0dRbSUE3e13C7ZA
	FwfRn3JNAuGYoPW7FQfz3unhiD5XPLAeSVO+cjc6yjjLmGndQpraItuRkPFrv5+hLyJ1eBVfCej
	WbVPyB8lHYF9xlgLA6eI+GQreT8I=
X-Google-Smtp-Source: AGHT+IGjtx2HGlRUUxfHLsgxZrMc5HOLfFzS5jvtirjyIPXJpZcKEYpq6gBAXQaDQEq6eyp0Tbbah6SY1D/EzYnBAjs=
X-Received: by 2002:a05:6512:3b8d:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-5389fc6429dmr8367147e87.40.1727765784329; Mon, 30 Sep 2024
 23:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-34-ardb+git@google.com> <20241001053318.elfwwiyluw6rlynz@treble>
In-Reply-To: <20241001053318.elfwwiyluw6rlynz@treble>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Oct 2024 08:56:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFyd7zDqnFzHTZmcR+ktxRVdOnuF-VOW+E0PYPNaQGXzQ@mail.gmail.com>
Message-ID: <CAMj1kXFyd7zDqnFzHTZmcR+ktxRVdOnuF-VOW+E0PYPNaQGXzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/28] x86/boot: Permit GOTPCREL relocations for
 x86_64 builds
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 07:33, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Wed, Sep 25, 2024 at 05:01:04PM +0200, Ard Biesheuvel wrote:
> > +             if (r_type == R_X86_64_GOTPCREL) {
> > +                     Elf_Shdr *s = &secs[sec->shdr.sh_info].shdr;
> > +                     unsigned file_off = offset - s->sh_addr + s->sh_offset;
> > +
> > +                     /*
> > +                      * GOTPCREL relocations refer to instructions that load
> > +                      * a 64-bit address via a 32-bit relative reference to
> > +                      * the GOT.  In this case, it is the GOT entry that
> > +                      * needs to be fixed up, not the immediate offset in
> > +                      * the opcode. Note that the linker will have applied an
> > +                      * addend of -4 to compensate for the delta between the
> > +                      * relocation offset and the value of RIP when the
> > +                      * instruction executes, and this needs to be backed out
> > +                      * again. (Addends other than -4 are permitted in
> > +                      * principle, but make no sense in practice so they are
> > +                      * not supported.)
> > +                         */
> > +                     if (rel->r_addend != -4) {
> > +                             die("invalid addend (%ld) for %s relocation: %s\n",
> > +                                 rel->r_addend, rel_type(r_type), symname);
> > +                             break;
> > +                     }
>
> For x86 PC-relative addressing, the addend is <reloc offset> -
> <subsequent insn offset>.  So a PC-relative addend can be something
> other than -4 when the relocation applies to the middle of an
> instruction, e.g.:
>
>    5b381:       66 81 3d 00 00 00 00 01 06      cmpw   $0x601,0x0(%rip)        # 5b38a <generic_validate_add_page+0x4a> 5b384: R_X86_64_PC32    boot_cpu_data-0x6
>
>    5f283:       81 3d 00 00 00 00 ff ff ff 00   cmpl   $0xffffff,0x0(%rip)        # 5f28d <x86_acpi_suspend_lowlevel+0x9d>      5f285: R_X86_64_PC32    smpboot_control-0x8
>
>    72f67:       c6 05 00 00 00 00 01    movb   $0x1,0x0(%rip)        # 72f6e <sched_itmt_update_handler+0x6e>   72f69: R_X86_64_PC32    x86_topology_update-0x5
>
> Presumably that could also happen with R_X86_64_GOTPCREL?
>

In theory, yes.

But for the class of GOTPCREL relaxable instructions listed in the
psABI, the addend is always -4, and these are the only ones we might
expect from the compiler when using -fpic with 'hidden' visibility
and/or -mdirect-extern-access. Note that the memory operand
foo@GOTPCREL(%rip) produces the *address* of foo, and so it is always
the source operand, appearing at the end of the encoding.

Alternatively, we might simply subtract the addend from 'offset'
before applying the displacement from the opcode.

Note that this code gets removed again in the last patch, after
switching to PIE linking.

