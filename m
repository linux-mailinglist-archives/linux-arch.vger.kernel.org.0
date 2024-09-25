Return-Path: <linux-arch+bounces-7450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876009868A9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C712843B4
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0D156236;
	Wed, 25 Sep 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur/3nHyr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498A4C91;
	Wed, 25 Sep 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301027; cv=none; b=VGVc129jLv2PqzKXFfKHM3XxPURPQ9RGxz/aoTSeVJZiVg6tollZFFCJkqcx/4rQT2esslVEH+NLTSUm2PbYgWgfUE7PiNk1UHkb1K+U4+ahomcFapX85YYnl8tOdrxRfGbSnWAI5YdQ0WlarDgymy/cwsgX9ro6dlUkGLyXJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301027; c=relaxed/simple;
	bh=1lEhoW6WR1MzdDMJddixyg5DPptKnPhIlRVYn7j8lQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OucniQHqheOaC1RUTwPT4jJywAApNqyp3aOkxNYHMQSMIYy+9UZq6Qc8V6f4fL97TeWKAvVgZ7LdNP6txqg547CaltGwfGaWGzy/WC7MRK6xalTHcQ4ff3ZUqBK+XSlVMwGig6fFF984H30Qc/c0xcphOXY1Qb1MAxtHUjv0G+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur/3nHyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFCAC4AF09;
	Wed, 25 Sep 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727301026;
	bh=1lEhoW6WR1MzdDMJddixyg5DPptKnPhIlRVYn7j8lQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ur/3nHyrhZZPu0Yh+dxx9IKm8wfPUcwkSUQRT5/24oDl5DsWgNcYT0e6Eea2tNJEj
	 e7kkusZnvqM4WaMdV8I/B88HrhGKrbpU1NmXjGCDHN50ORnxvzmOycJHLxIoyGwsDO
	 ExoHCIyOj9vlAWjwlo1VC3vyBOmMfPmkVdu53MKdw2rUvIg+EICDRFsYyGF/ME23Kr
	 OQb1mqpKJ2KcOIs7wkgcqQbNW9IxvVRHKG6I1vwEmJlaj0YC21mvFP8GdjxaBxyry9
	 jndDvY46F1MqAtmxQOq27Nb8WyvN+IBfi0EcE/uMfNIYvCFZoSopABS7dcRnOBsVSy
	 JHKCzVeyLclIw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so3504161fa.1;
        Wed, 25 Sep 2024 14:50:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU41Yl1sttTg6M09g6XFlPWgM6aKYUPcyKAZuJi1MFpolUjBY6EX3rjid7yiMuIPFvcxwtqxGDi8A1e@vger.kernel.org, AJvYcCUBjZa2k9ktNoszDdBbGsmUYkoo+UBysl/zvy9zEChTzav8UykXq5KYmPVktYLgeiDJYa8JdVW5Iahoig==@vger.kernel.org, AJvYcCUEhDAfbKmtW+zDQTSj8AFR1LX8pKPrayJ2WSXwEbHSJXbIRSWMLY+ST+VMmtIHzTHHMx3uO7FPSku0Gatc@vger.kernel.org, AJvYcCUWEzhuPr/DJK5KOA2tsWED2rzTCuDC8XPWG6Kmt+EtUzuFt4w/e0WCCiuvVO5U5g2SoVuADYMSTZy2n3t8@vger.kernel.org, AJvYcCV8+3qzx+hE0bn/8reGc0wt841uez3ElAs+KnYznZL0spqZvZYTjnETCbwmxGXO0JQahGzQHymsFQ7NJsOl3T1Hog==@vger.kernel.org, AJvYcCVil+zKdn6eUJiaXguneqD7UclkSAfYRhmSG6G04Z/HMf7GbyCdTAkhnba+IZsEwMuesIJU8qPBZCCR@vger.kernel.org, AJvYcCVqtgmdPe9Ln076tMvVEt+OM5yyog9qM/HupRRpc6WUb+6I976IxRiEWCESwprKDHBS1BccOVD4wX6wKbjc@vger.kernel.org, AJvYcCW/FNYUPHIWOKdbh/UZ+L/OmwCj4u8w5bDaQJaGJ8LFENeElMIVdgKoOQhW3fUcrE9aFsE=@vger.kernel.org, AJvYcCWCyAZNBGjwnxfsNNWHE4QLxncQYVf5ho6jd0xc8YuyNeyoJqOEJU/SB88FRn54XbVKBB0h2AVYZaI=@vger.kernel.org, AJvYcCX1eEHLdus66GmS/KJZX7ITtZ4P
 hpHnLhnuipufilF2AaNvFnZTir3rIUqqP8eyDxUB0v0K2px304CrLGEx+Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwC/c5a8nTdg728+loAEpIpQH2/3bfHpgP/Pb8IhyKv6zUgqkq
	4XO8JKXu/IlLKxQFKeqtk+quVTXt7z5G02PQrvFQqFzSkBcT9AUMWurT07LdmtiZlv6HEuTl5FW
	YMQHXC+TLhm8muCz6BoP/T4Im1m4=
X-Google-Smtp-Source: AGHT+IFAZ+6hWU7rSBzvDQXewHWYdV56nlJpCG7le3cONkuZamphf5guvKvreSQ+Lzis3ZFjbCnAEt7u29iA4vUB0Ko=
X-Received: by 2002:a05:651c:1991:b0:2f6:5f7b:e5cf with SMTP id
 38308e7fff4ca-2f915fdfea6mr30629271fa.14.1727301024993; Wed, 25 Sep 2024
 14:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-41-ardb+git@google.com> <81fb3f6b-4ded-41d1-be66-d86af4f22171@amd.com>
In-Reply-To: <81fb3f6b-4ded-41d1-be66-d86af4f22171@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 25 Sep 2024 23:50:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGj25bn2R9vWPqG5+SSSjJp6rzopssDbjk8uOvi=cAiUw@mail.gmail.com>
Message-ID: <CAMj1kXGj25bn2R9vWPqG5+SSSjJp6rzopssDbjk8uOvi=cAiUw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/28] x86/pvh: Avoid absolute symbol references in .head.text
To: Jason Andryuk <jason.andryuk@amd.com>
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

On Wed, 25 Sept 2024 at 23:11, Jason Andryuk <jason.andryuk@amd.com> wrote:
>
> Hi Ard,
>
> On 2024-09-25 11:01, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The .head.text section contains code that may execute from a different
> > address than it was linked at. This is fragile, given that the x86 ABI
> > can refer to global symbols via absolute or relative references, and the
> > toolchain assumes that these are interchangeable, which they are not in
> > this particular case.
> >
> > In the case of the PVH code, there are some additional complications:
> > - the absolute references are in 32-bit code, which get emitted with
> >    R_X86_64_32 relocations, and these are not permitted in PIE code;
> > - the code in question is not actually relocatable: it can only run
> >    correctly from the physical load address specified in the ELF note.
> >
> > So rewrite the code to only rely on relative symbol references: these
> > are always 32-bits wide, even in 64-bit code, and are resolved by the
> > linker at build time.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Juergen queued up my patches to make the PVH entry point position
> independent (5 commits):
> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/log/?h=linux-next
>
> My commit that corresponds to this patch of yours is:
> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/commit/?h=linux-next&id=1db29f99edb056d8445876292f53a63459142309
>
> (There are more changes to handle adjusting the page tables.)
>

Thanks for the head's up. Those changes look quite similar, so I guess
I should just rebase my stuff onto the xen tree.

The only thing that I would like to keep from my version is

+ lea (gdt - pvh_start_xen)(%ebp), %eax
+ add %eax, 2(%eax)
+ lgdt (%eax)

and

- .word gdt_end - gdt_start
- .long _pa(gdt_start)
+ .word gdt_end - gdt_start - 1
+ .long gdt_start - gdt

The first line is a bugfix, btw, so perhaps I should send that out
separately. But my series relies on all 32-bit absolute symbol
references being removed, since the linker rejects those when running
in PIE mode, and so the second line is needed to get rid of the _pa()
there.

