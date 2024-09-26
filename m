Return-Path: <linux-arch+bounces-7458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8219698748A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD234B270F5
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F2446A1;
	Thu, 26 Sep 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFpkbNET"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC353B7A8;
	Thu, 26 Sep 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357922; cv=none; b=WCQQi4vbwCkxQDml/CRvbeQDevm6pzMmgT8GZOr8FtNxmS4QoTRACLUN8ABTytP+SI/n91zc4zDvMyOCHunldtQdzoegVou12BwJv9jFH9HHg03FtbeEGrc6rMr9wO3QA3Px6cOLB0P2qSy2beFv8GAckQ/uvjjiI8sYPkzAL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357922; c=relaxed/simple;
	bh=OPIQS2t62p13UwMnk1FiF+unfRr5Zwe9MubLOeGiJyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWI4Ov3/hPpmp4ekefjXgITt1acMdx2JHaai2YW3K++Jlnhk++5i0P+tQeLR5cckoEm+Y8I8qPrbkPzhS/p3c9jXKyw8/v7oh6LfGDbNLRoKKEc5idpk11WTZtEEigmpwQj72fMED3moCd6l+C2DMO5b5F5TLYKA1fRV81s9rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFpkbNET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D596EC4CECE;
	Thu, 26 Sep 2024 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727357921;
	bh=OPIQS2t62p13UwMnk1FiF+unfRr5Zwe9MubLOeGiJyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tFpkbNET0czPRtMPovfI/tw3gSCaREnEFLqAxcDb3uZoTaN1MUsL6oFQbeAJWaXFI
	 CeZWZV2EQC3jkUVUyeFkJ+3vTNfdldDlcwSemGpaMMeK9dMpCn+eo3NwP7qHalae2l
	 VkYErS8T+eLlgBYIpVtrHU2I5PcdP6mhLc1DUl1KUsQKtRR5hqOVwbYWqQHd51bOSc
	 0RXX9eQm9K7Euav9Ek8BEAPCErl0m7IiVuV8uXmMnTrDNFw9GHP2lFmVOsqkL2L43u
	 cjWMgiSR1KtLVxjFC81BklSOZDD2JwvftlNBn0/eOD6Pyn0J+4KRnR0e//rfp7F508
	 d7FbSWxfvv7MQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so11868661fa.1;
        Thu, 26 Sep 2024 06:38:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXGse6vbc6FpYz4lgSlKDQJ3qHeN8YH1qg4ceNUpAOgf2a3chMjIK0ENodL3waku7Y6v9btiPZYwo=@vger.kernel.org, AJvYcCVHSf69uGrWCz6BRS1+JmcB0WwHMJusjUz5DzJz6OyyNCwKaGdkiV6aC7dllcXHLJDaeF58Iu+R6pkWfkE5@vger.kernel.org, AJvYcCVTuIuwxeKYKbgD/ed5IBfUTO7U1Ejx7RhUMhftttnafsBMVSpnvTc9K/Q5OeTJhgPJkdtAzjFih+qoU3yY@vger.kernel.org, AJvYcCVtRQGxusNOZWYtaUh1loOVtMx1E0c7HHDguIWYo9ealgtYxuWTRpJmBSWUo7f5zHlNPOM1Gw8mgXFiZ8mY@vger.kernel.org, AJvYcCWnzRX1k3MUWDUeu7WRrtNXnuRWLBPxMs1hH9mzwU5NkneQMn6dD/qskBYd2ZFzC5TMylmYyoNk3rnPXw==@vger.kernel.org, AJvYcCWwRwkLEtUjeqDHvxaVwTFatpqwvjxPRnP0dO3vppSWiwK189Ows6GwGumhRSpTmyH4CWEalcL0gdCD@vger.kernel.org, AJvYcCX2LMIhQ6EVmnkECm5H1xOqA26099cMKqZHDLb3snQOaHAII2I5pbbgC2ScvY2UAJCHWL9K3nvrFknz1qONp+CPMw==@vger.kernel.org, AJvYcCXc6rBX4B7tDEFX89zlzTTdnMaKavPMzO6FCLF0Fp51dWzHpePLktp9KpDsTPBEb2azHKHXUxYL49arAuSU2bQ=@vger.kernel.org, AJvYcCXgB42XCutcroFoVKxqmQ3xVd06k4oIAcHRUvkIUAQRtVdVKECbH9h9M9zw29dh6Av1J9g=@vger.kernel.org, AJvYcCXvi5cxeCUvrafei1Um
 rndmyryPFc3Yjd/XjPlDWE8wKBKBqfauz/iR5f6TXTsiAmqgA/04JIOBiM57@vger.kernel.org
X-Gm-Message-State: AOJu0Ywss9HWQbBVgJHtvIqk1Wu4DkB/i43GOJbJ7pSBIffBAxWqmqfp
	RPSo3fNJedto7dlLNTrd34VBZVBaW6YphvSAysX7nCs1Y6E5lZVzu/a9j9jwmABqE2Bgu0nLqyB
	6em3OiiG3xXVqSuX9z1jAxXZ5Yl4=
X-Google-Smtp-Source: AGHT+IGDysp0zVaI/G56jPcUmenrli6iDQ7ZCklZUQ9W3MAWEI6d8p2NALI8I7dIlWV2Pg4Oztsl5Tqp++gl5gafuuo=
X-Received: by 2002:a2e:4a0a:0:b0:2ef:1784:a20 with SMTP id
 38308e7fff4ca-2f91ca68786mr32564001fa.38.1727357920170; Thu, 26 Sep 2024
 06:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-57-ardb+git@google.com> <4eca972d-a462-4cc5-9238-5d63485e1af4@oracle.com>
In-Reply-To: <4eca972d-a462-4cc5-9238-5d63485e1af4@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 26 Sep 2024 15:38:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEOFDwoYrLH9f-d46HRPMw7HjWRQGNdMu5_D_Ny3UtPxg@mail.gmail.com>
Message-ID: <CAMj1kXEOFDwoYrLH9f-d46HRPMw7HjWRQGNdMu5_D_Ny3UtPxg@mail.gmail.com>
Subject: Re: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core kernel
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 22:25, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
>
> On 25/09/2024 17:01, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Build the kernel as a Position Independent Executable (PIE). This
> > results in more efficient relocation processing for the virtual
> > displacement of the kernel (for KASLR). More importantly, it instructs
> > the linker to generate what is actually needed (a program that can be
> > moved around in memory before execution), which is better than having to
> > rely on the linker to create a position dependent binary that happens to
> > tolerate being moved around after poking it in exactly the right manner.
> >
> > Note that this means that all codegen should be compatible with PIE,
> > including Rust objects, so this needs to switch to the small code model
> > with the PIE relocation model as well.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   arch/x86/Kconfig                        |  2 +-
> >   arch/x86/Makefile                       | 11 +++++++----
> >   arch/x86/boot/compressed/misc.c         |  2 ++
> >   arch/x86/kernel/vmlinux.lds.S           |  5 +++++
> >   drivers/firmware/efi/libstub/x86-stub.c |  2 ++
> >   5 files changed, 17 insertions(+), 5 deletions(-)
> >
...
>
> This patch causes a build failure here (on 64-bit):
>
>    LD      .tmp_vmlinux2
>    NM      .tmp_vmlinux2.syms
>    KSYMS   .tmp_vmlinux2.kallsyms.S
>    AS      .tmp_vmlinux2.kallsyms.o
>    LD      vmlinux
>    BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
> FAILED elf_update(WRITE): invalid section entry size
> make[5]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
> make[5]: *** Deleting file 'vmlinux'
> make[4]: *** [Makefile:1153: vmlinux] Error 2
> make[3]: *** [debian/rules:74: build-arch] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess
> returned exit status 2
> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
> make[1]: *** [/home/opc/linux-mainline-worktree2/Makefile:1544:
> bindeb-pkg] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
> The parent commit builds fine. With V=1:
>
> + ldflags='-m elf_x86_64 -z noexecstack --pie -z text -z
> call-nop=suffix-nop -z max-page-size=0x200000 --build-id=sha1
> --orphan-handling=warn --script=./arch/x86/kernel/vmlinux.lds
> -Map=vmlinux.map'
> + ld -m elf_x86_64 -z noexecstack --pie -z text -z call-nop=suffix-nop
> -z max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn
> --script=./arch/x86/kernel/vmlinux.lds -Map=vmlinux.map -o vmlinux
> --whole-archive vmlinux.a .vmlinux.export.o init/version-timestamp.o
> --no-whole-archive --start-group --end-group .tmp_vmlinux2.kallsyms.o
> .tmp_vmlinux1.btf.o
> + is_enabled CONFIG_DEBUG_INFO_BTF
> + grep -q '^CONFIG_DEBUG_INFO_BTF=y' include/config/auto.conf
> + info BTFIDS vmlinux
> + printf '  %-7s %s\n' BTFIDS vmlinux
>    BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
> FAILED elf_update(WRITE): invalid section entry size
>
> I can send the full config off-list if necessary, but looks like it
> might be enough to set CONFIG_DEBUG_INFO_BTF=y.
>

Thanks for the report. Turns out that adding the GOT to .rodata bumps
the section's sh_entsize to 8, and libelf complains if the section
size is not a multiple of the entry size.

I'll include a fix in the next revision.

