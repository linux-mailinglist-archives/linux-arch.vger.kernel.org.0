Return-Path: <linux-arch+bounces-7730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A09920C6
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 21:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D0A1C20932
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAA18A6C4;
	Sun,  6 Oct 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Lc9PbUpM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2A14A630;
	Sun,  6 Oct 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243588; cv=none; b=FRLOxwocPolZph5fv6JLhixrU+rsqdIrdr3xUJrGpwVYRpdBqz/x672ZYFiNpWID9ZAAq1qc96Qky3ugFfIqfV9ozWHN8TRiFTN5SCCdHVIZKGgqkPlBiSOU/xqmoGubULyucqqICILL49OXiVLLC83EvalqzZdBi356GzooDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243588; c=relaxed/simple;
	bh=9wpGerdLjrs32NAAxWuQr0Zn5/RQ55cLXb4OynSTbGk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DjH8RbgYutDhtr8v7dMYC0eFEn2vEo55Cn49HS6l7GYeAdkRz/lVq0BW54lmDuBv+XSkJLBR5EMxRCJG8/w8a3t6xEuw1d5Dh/MqO92+MdySIjPKccBAiSckns6nHleYJE7pdwXw49DLP8X/QfkwKflEc6naKNDF3tv6xlJfYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Lc9PbUpM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 496JcqMQ1925401
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 6 Oct 2024 12:38:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 496JcqMQ1925401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024091601; t=1728243536;
	bh=9wpGerdLjrs32NAAxWuQr0Zn5/RQ55cLXb4OynSTbGk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Lc9PbUpMwsnXTOWaJN9CXcxjSSWv5nTCaZBiscG/TQ3eHw4J2mI5nopG2gSeaI79L
	 vKMiLkZHfC5ubwiFJzuDuyB+F5uMgvtF2z0wUtlZmg4On1bnmVK4vei8WgNxba4q9u
	 muWB/vSp7UxaBGIboP+agmWEZxkTp81yyJwnS6yc0YXqeqxb0x7Ta7UpicAdHSSWND
	 7UPqiYheLQ57e2ykSnaWM8GW2tnbAX4B6xnsny8QXDU+qdSEJsjRLl9oDtWqQ/ecCq
	 0sAHRDWAdgyw5syyYB6N3mg/bKR+nVFfm3xWMRSeaGRrxOVCrWF7OfUMb2ogPNfF4Q
	 GIubVa2r9kh9w==
Date: Sun, 06 Oct 2024 12:38:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, David Laight <David.Laight@aculab.com>
CC: Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb+git@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Justin Stitt <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4awNUm8MpZQ6XhPTRs6+2ZLtfnr=6vkK5DrY9L2rGR-5w@mail.gmail.com>
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com> <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com> <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com> <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com> <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com> <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com> <CAFULd4b==a7H0zdGVfABntL0efrS-F3eeHGu-63oyz1eh1DwXQ@mail.gmail.com> <bfa1a86c3e4348159049e8277e9859dd@AcuMS.aculab.com> <CAFULd4awNUm8MpZQ6XhPTRs6+2ZLtfnr=6vkK5DrY9L2rGR-5w@mail.gmail.com>
Message-ID: <2E1160A8-3A0C-45BD-B729-D20EAE97A075@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 6, 2024 12:17:40 PM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote=
:
>On Sun, Oct 6, 2024 at 8:01=E2=80=AFPM David Laight <David=2ELaight@acula=
b=2Ecom> wrote:
>>
>> =2E=2E=2E
>> > Due to the non-negligible impact of PIE, perhaps some kind of
>> > CONFIG_PIE config definition should be introduced, so the assembly
>> > code would be able to choose optimal asm sequence when PIE and non-PI=
E
>> > is requested?
>>
>> I wouldn't have thought that performance mattered in the asm code
>> that runs during startup?
>
>No, not the code that runs only once, where performance impact can be tol=
erated=2E
>
>This one:
>
>https://lore=2Ekernel=2Eorg/lkml/20240925150059=2E3955569-44-ardb+git@goo=
gle=2Ecom/
>
>Uros=2E
>

Yeah, running the kernel proper as PIE seems like a lose all around=2E The=
 decompressor, ELF stub, etc, are of course a different matter entirely (an=
d at least the latter can't rely on the small or kernel memory models anywa=
y=2E)

