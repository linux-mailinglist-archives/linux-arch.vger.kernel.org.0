Return-Path: <linux-arch+bounces-7729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB3992098
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 21:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9547628178C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 19:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E92189B9C;
	Sun,  6 Oct 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqJZAGjG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB2154C08;
	Sun,  6 Oct 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728242276; cv=none; b=X4y1XklkJQ1AO/GduMJsSpM+e6bc+mrNDskKhdjv7U9NM+ZIM7525ickjTSvRa/jluZN7Xe5lZxCJQCwyMjSUkNjm+KW31W2RcycSZi9KfYLH+V2lZmuYryaZ0I9gU3oaGMc/99h1D4pqQjSXaO9xuqDkVX2EHBdrgY8RvwOBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728242276; c=relaxed/simple;
	bh=tbSrHUSflgwuD4ZHPRPJ5BZRTLC2CQwiCglTSKbl7rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1cK9hNjyECDEz7JV4Oh697bXVyFU64nq4KwverqiNQCxy5m2CqNOlCyha2H/edosyVir8fz9F61BztWlHzR+Gar/nraYJ77sTANv3ULzefpC8NGr7q3iR30HmVvRS4jEyI9IbKtX70PE8jo+j9GN4mcWhVW9tYNXducxGF6FL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqJZAGjG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2facf48166bso42281771fa.0;
        Sun, 06 Oct 2024 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728242272; x=1728847072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbSrHUSflgwuD4ZHPRPJ5BZRTLC2CQwiCglTSKbl7rw=;
        b=nqJZAGjGx4QcYHx6vtJxdlCgaOAcMSe2jDOuWHn7czwwT+rukTwbEcCBdrZb+MDYce
         El3eWXMD1/08x4k1Od9IUZ8oK/RcGIGZ5QNKthpSkza3lqahfX8I1sZv74tt3hDwPEd4
         4EQiBqEUsf/rVh2JRXzPTYkpewLwya6FRpgs+LbeZsJhPilczYHE6xl1/RH6YK85JYcH
         kDC4aQ2I6g6oSMm4fauCGs/0fGwbb1Jg6yANtaSTpoRTVeClRvmY7vu1dtQqukRlCNzc
         fpbpoWPuQadmUKa3TlzIYdrBBTbg/4gvWFCjZMMy02t+j9l6vmEO1OydmyTHSAPXzvpa
         H0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728242272; x=1728847072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbSrHUSflgwuD4ZHPRPJ5BZRTLC2CQwiCglTSKbl7rw=;
        b=GzRMpVNBvc9glGmyWj4o9UUc10D8dCBg8l0oG6WVYX9JtF7eLxX7leZ/1xBUONXo7R
         QhDdbjkE71s8xAUubb+cJWzcMb0Yj50y3qKtoTcY77MeWwgkgEx0fOdfLdb+nM42Wgw+
         18HtIxWHSpS8FsLrARclB/D4UxWsm1lBu6iDM5nGKe1v/I8zhHhtKUPkvlCXtnuGgiNC
         XIxixDMD3GJsStm2f0aDWRaLDxbZJwX1x9MysqIRGojC6WcMvxmG6hODDr8byDrX7QOI
         RJ5lNu72p2G9fd4q9As2yjl73GXKE+gXZTMhU2bKOQFEbEtwMqTaHZfyOLImPZoza9qD
         khFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX54RdEo4+WCVcc8shQTb0S89bqx/sVnxmktgouSGhEV3pxNCAa3ZEn8bz3iOyxJQm79BTvXbjcNPOBR+K@vger.kernel.org, AJvYcCVHk2TldaaYr18KXMm9rYtsCiKAsyuglqfq7IlhlJqE6mdYszqGcLn+H5IBdMOR0DcjMEvb22482oJO@vger.kernel.org, AJvYcCVI8K1PFq1oB09cfvBDlPvGZurDwyHUwBj3OMK8FpmrxEApeypcR1k8FS9C9irb3aZoVrGhOKURGmdRkRrv@vger.kernel.org, AJvYcCVNwSnfA8IA5LrhPAzsDB/p4xY1eD7HtBwI8asvuDmAmI9SjbDx6oSCyT0ESJETaYlhcKrWP4SRSsY=@vger.kernel.org, AJvYcCVPPASJxbzGb8Z7kDar7JpPIQBrvvoNN6PH204DIzLb2bAVt1ccMiVx+yCJCu+6+guFBHCl5CykeLcQzQ==@vger.kernel.org, AJvYcCVwGk2t0Quv217Bm8ubzE1qGIR5WJ4hFL1qeUtS4F0h9eIzYcyDa7uhiwymJ8nJzfSZ5YQPHCl3WvzN@vger.kernel.org, AJvYcCW+zerJslmiB5lCj92zqbzd/LjOBpCk5p+7oMNebxsDG0GdfBTJQP3w3ibl78tmblqk5Bg/h6kB4zXkhjCJ@vger.kernel.org, AJvYcCWtZvfXzjS7lwmZxxgsdMnDcTK/XGKTYAHs0TYG97zCt9oUCyvY57OxvfrNQNPf0b4wMSSAm/wnhur2wWZ8tDBodg==@vger.kernel.org, AJvYcCX1pl5bQAlCjt7UqIW5IpvCZmJWg8O0kx3vYRzpAenh2r7U3QunDX32lXnlJY2RiWqEKJy3+gLv9zfmsZrn/Z8=@vger.kernel.org, AJvYcCXIF6brVLDy
 2oh4bcSpJ5wR1Bmcp4jeYVALCNJZsO/HLiaGLDv0lGtzo/IDaQfNg5Izuz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1K/eoLNaL7AHnszPzsfpP9yR4RmYvRQRJuYIXyJ+Ho7OPuoB
	IHFfEVqTjdMmMBs+zFZTr0PzFYWAoXTCLuJoa1cRD1WfzX4ULpCPwc3rD7wf4t2mb2T+U6wFL7G
	4n+S9HBrqAwMt+2PTM0QbwIjj2TM=
X-Google-Smtp-Source: AGHT+IGRTqhJhTusYfDXEbEiyI+dDRincUEm84afE7n1AFszrvf4EDsRGd1dnnPyUdXRuJKezOE3wzgwR0sUUmJI06c=
X-Received: by 2002:a05:651c:548:b0:2fa:cdd1:4f16 with SMTP id
 38308e7fff4ca-2faf3c150bdmr36366491fa.14.1728242272173; Sun, 06 Oct 2024
 12:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
 <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com> <CAFULd4b==a7H0zdGVfABntL0efrS-F3eeHGu-63oyz1eh1DwXQ@mail.gmail.com>
 <bfa1a86c3e4348159049e8277e9859dd@AcuMS.aculab.com>
In-Reply-To: <bfa1a86c3e4348159049e8277e9859dd@AcuMS.aculab.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 6 Oct 2024 21:17:40 +0200
Message-ID: <CAFULd4awNUm8MpZQ6XhPTRs6+2ZLtfnr=6vkK5DrY9L2rGR-5w@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: David Laight <David.Laight@aculab.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ard Biesheuvel <ardb+git@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 8:01=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
>
> ...
> > Due to the non-negligible impact of PIE, perhaps some kind of
> > CONFIG_PIE config definition should be introduced, so the assembly
> > code would be able to choose optimal asm sequence when PIE and non-PIE
> > is requested?
>
> I wouldn't have thought that performance mattered in the asm code
> that runs during startup?

No, not the code that runs only once, where performance impact can be toler=
ated.

This one:

https://lore.kernel.org/lkml/20240925150059.3955569-44-ardb+git@google.com/

Uros.

