Return-Path: <linux-arch+bounces-5730-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBEA94194E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F471C2283D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BC18801C;
	Tue, 30 Jul 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fKW1XYqC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0D8BE8;
	Tue, 30 Jul 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357063; cv=none; b=RxdqcX0+45izs/YMtvAfQbWfKPo1NqtywoDKYQ2o+S7oj+z7BISEGf4tq1cneTyqFe4i3qaOtJnmz2FU8B/nq4RB7HgF53040zfpyB1cz/W+CoMUIZHeqmDTc+4vmxFPRTPGql/70nPFz8os9CX9T+/ILAl6BwgsVakmCAXx4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357063; c=relaxed/simple;
	bh=hpkTzTir1UIzqYFERoz4CAIIwheDvWkRwVQvt7qkb1A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ps5RPSKHozrLTp+/hurdHrmNNICwnSkbaZ4G0e42Q5YpL4HfnOTRq6ssVW3O+KZobxTO8fzifBY592w2+/nZfa83uW63fsmT4lku6EB+H9Bm3806KEk6PxU9uWVko0QAyahdlbNriwFAcTToySab3ybidd+HsTJRITtFlwv++mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=fKW1XYqC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 46UGSsN1081118
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jul 2024 09:28:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 46UGSsN1081118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1722356939;
	bh=IJHV4yrazRxuG4T6Hs72qR3GJj/8mbbgDoSvSaEnppI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fKW1XYqC57svXidJXfs/wpveNEPwkGRexcR4eo4qo82LwpzlRuHGbCLXCJBFKpg0X
	 /qidNA/gWwCnzrLRh7NWY1yWlrXBS0aHck0oteEOW8OGYN5Dxgzh+3GRWLUeDy0gtr
	 CE7fBfOm5D9LRDKVwbTzZ11mMyD8rlZAsPDLat38Q52E8qx2eE0hZhQa/v56t1/2bD
	 DVmQd7AzeJlew0vIMjb4hrwaNqLVc6TTfBd3f97MeQ9OWWfTniaVqoSWnJcBkUMEcs
	 6N1h62SkEVmKh1cKwsHdQvEfdOYOah+6K1/XCxJkVza8AhrDcBkiNWiRgXgXFxUdLq
	 +GOfXrd+zuD4A==
Date: Tue, 30 Jul 2024 09:28:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>, Rong Xu <xur@google.com>
CC: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
        David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, John Moon <john@jmoon.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>,
        Wei Yang <richard.weiyang@gmail.com>, Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>, Palmer Dabbelt <palmer@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>, Kees Cook <kees@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Krzysztof Pszeniczny <kpszeniczny@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/6=5D_Change_the_symbols_ord?=
 =?US-ASCII?Q?er_when_--ffuntion-sections_is_enabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240730084022.GH33588@noisy.programming.kicks-ass.net>
References: <20240728203001.2551083-1-xur@google.com> <20240728203001.2551083-4-xur@google.com> <20240729093405.GC37996@noisy.programming.kicks-ass.net> <CAF1bQ=Ta9MyoLhUjMTx479UWbHGK-cskbTTe_OudqeZRqV6w0Q@mail.gmail.com> <20240730084022.GH33588@noisy.programming.kicks-ass.net>
Message-ID: <AD6EAA8F-8B93-40BA-B624-1CBBAA93DE3C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 30, 2024 1:40:22 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Mon, Jul 29, 2024 at 11:48:54AM -0700, Rong Xu wrote:
>
>> > defined(CONFIG_LTO_CLANG)
>> > > +#define TEXT_TEXT                                                 =
   \
>> > > +             *(=2Etext=2Easan=2E* =2Etext=2Etsan=2E*)             =
               \
>> > > +             *(=2Etext=2Eunknown =2Etext=2Eunknown=2E*)           =
             \
>> > > +             *(=2Etext=2Eunlikely =2Etext=2Eunlikely=2E*)         =
             \
>> > > +             ALIGN_FUNCTION();                                    =
   \
>> >
>> > Why leave the above text sections unaligned?
>> >
>>=20
>> They are considered cold text=2E They are not aligned before the change=
=2E But
>> I have no objections to making it aligned=2E
>
>At least x86 has hard assumptions about function alignment always being
>respected -- see the most horrible games we play with
>CONFIG_CALL_THUNKS=2E
>
>Or is this only text parts and not actual functions in these sections?
>In which case we can probably get away with not respecting the function
>call alignment, although we should probably still respect the branch
>alignment -- but I forgot if we made use of that :/
>
>
>> >
>> > > +             *(=2Etext=2Ehot =2Etext=2Ehot=2E*)                   =
             \
>> > > +             *(TEXT_MAIN =2Etext=2Efixup)                         =
       \
>> > > +             NOINSTR_TEXT                                         =
   \
>> > > +             *(=2Eref=2Etext)                                     =
       \
>> > > +     MEM_KEEP(init=2Etext*)
>> > > +#else
>> > >  #define TEXT_TEXT                                                 =
   \
>> > >               ALIGN_FUNCTION();                                    =
   \
>> > >               *(=2Etext=2Ehot =2Etext=2Ehot=2E*)                   =
             \
>> > > @@ -594,7 +606,8 @@
>> > >               NOINSTR_TEXT                                         =
   \
>> > >               *(=2Eref=2Etext)                                     =
       \
>> > >               *(=2Etext=2Easan=2E* =2Etext=2Etsan=2E*)             =
               \
>> > > -     MEM_KEEP(init=2Etext*)                                       =
     \
>> > > +     MEM_KEEP(init=2Etext*)
>> > > +#endif
>> > >
>> > >
>> > >  /* sched=2Etext is aling to function alignment to secure we have s=
ame
>> > > --
>> > > 2=2E46=2E0=2Erc1=2E232=2Eg9752f9e123-goog
>> > >
>> >

The linker should always enforce the alignment of any input section=2E If =
we don't have proper alignment either the linker is broken or we don't have=
 the correct =2Ebalign directives in the code =E2=80=93 which is the right =
way to fix this=2E

