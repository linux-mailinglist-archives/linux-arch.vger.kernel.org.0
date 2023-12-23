Return-Path: <linux-arch+bounces-1170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE781D0F6
	for <lists+linux-arch@lfdr.de>; Sat, 23 Dec 2023 02:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A131F1C21AEA
	for <lists+linux-arch@lfdr.de>; Sat, 23 Dec 2023 01:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A7ECF;
	Sat, 23 Dec 2023 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2JJTtJh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ABBEC2;
	Sat, 23 Dec 2023 01:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3538C433C7;
	Sat, 23 Dec 2023 01:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703295215;
	bh=s0BlMXbM0YXaay/9qOTSwSxk63kUVEMXfbyWTdHeVp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H2JJTtJhEcVnJgOfNVmLn4kJskF8GEJvD5F5tBPh2HnKRTMZm5+/uAcprVBhqGZiJ
	 paOXRdMftsNWM2MRT3jaNnO2YaG0iupgnUAY0xQigEcTH4B+vU1is4YNfA8jPNrsiu
	 8BGnb9SaYJV5ZNHS1Kd/37gXuJChmW2wjpbIeHVkrkOphwCvNy0EBQpulIZ1F9fCL/
	 biQDAFbKXTxkNZLrkG5M4OcItRm3YZ75Jl9oCX5ol3wxjXS5GjOm8Dmm2y7t9S96vz
	 mKisl2BUl5qwjxkkcxsVBU/aMsYOXS+CwxtBJN+X3FkdP6Nl8/IjxPLfrixr3pc7VP
	 T+8nsdGtbwpEA==
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b35d476d61so100638239f.0;
        Fri, 22 Dec 2023 17:33:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzfZCUyP8gns3OuIfp61FV3bg6kv56F6UkPDXbuFSG099k3jTYF
	Ers9ucHCilEb7ZohcLoIk6rUqjK8VdvZU4LxpcU=
X-Google-Smtp-Source: AGHT+IHpXq6YJJn719UeCoJ6XHaLYHMPxzuxUHuRdMuhzl7hdYfkh18oT1nuDpqYDf4gl2VsErMAIi+7VE3syZQdAjo=
X-Received: by 2002:a05:6e02:3041:b0:35f:de1d:11ac with SMTP id
 be1-20020a056e02304100b0035fde1d11acmr2383052ilb.23.1703295215227; Fri, 22
 Dec 2023 17:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <CAK7LNAQZO0g-B7UUEvdJWh3FhdhmWaaSaJyyEUoVoSYG0j8v-Q@mail.gmail.com>
 <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com> <bb34147d-4e67-456a-b0d6-965699cda596@gmx.de>
In-Reply-To: <bb34147d-4e67-456a-b0d6-965699cda596@gmx.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 10:32:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNATaGSPK8dpE=Vq2EgjQJXKn+Ui_3GAYKVz4-bc8pir-ag@mail.gmail.com>
Message-ID: <CAK7LNATaGSPK8dpE=Vq2EgjQJXKn+Ui_3GAYKVz4-bc8pir-ag@mail.gmail.com>
Subject: Re: [PATCH 0/4] Section alignment issues?
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org, linux-arch@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:23=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> On 12/21/23 16:42, Masahiro Yamada wrote:
> > On Thu, Dec 21, 2023 at 10:40=E2=80=AFPM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> >>
> >> On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
> >>>
> >>> From: Helge Deller <deller@gmx.de>
> >>>
> >>> While working on the 64-bit parisc kernel, I noticed that the __ksymt=
ab[]
> >>> table was not correctly 64-bit aligned in many modules.
> >>> The following patches do fix some of those issues in the generic code=
.
> >>>
> >>> But further investigation shows that multiple sections in the kernel =
and in
> >>> modules are possibly not correctly aligned, and thus may lead to perf=
ormance
> >>> degregations at runtime (small on x86, huge on parisc, sparc and othe=
rs which
> >>> need exception handlers). Sometimes wrong alignments may also be simp=
ly hidden
> >>> by the linker or kernel module loader which pulls in the sections by =
luck with
> >>> a correct alignment (e.g. because the previous section was aligned al=
ready).
> >>>
> >>> An objdump on a x86 module shows e.g.:
> >>>
> >>> ./kernel/net/netfilter/nf_log_syslog.ko:     file format elf64-x86-64
> >>> Sections:
> >>> Idx Name          Size      VMA               LMA               File =
off  Algn
> >>>    0 .text         00001fdf  0000000000000000  0000000000000000  0000=
0040  2**4
> >>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >>>    1 .init.text    000000f6  0000000000000000  0000000000000000  0000=
2020  2**4
> >>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >>>    2 .exit.text    0000005c  0000000000000000  0000000000000000  0000=
2120  2**4
> >>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >>>    3 .rodata.str1.8 000000dc  0000000000000000  0000000000000000  000=
02180  2**3
> >>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
> >>>    4 .rodata.str1.1 0000030a  0000000000000000  0000000000000000  000=
0225c  2**0
> >>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
> >>>    5 .rodata       000000b0  0000000000000000  0000000000000000  0000=
2580  2**5
> >>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
> >>>    6 .modinfo      0000019e  0000000000000000  0000000000000000  0000=
2630  2**0
> >>>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
> >>>    7 .return_sites 00000034  0000000000000000  0000000000000000  0000=
27ce  2**0
> >>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> >>>    8 .call_sites   0000029c  0000000000000000  0000000000000000  0000=
2802  2**0
> >>>                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> >>>
> >>> In this example I believe the ".return_sites" and ".call_sites" shoul=
d have
> >>> an alignment of at least 32-bit (4 bytes).
> >>>
> >>> On other architectures or modules other sections like ".altinstructio=
ns" or
> >>> "__ex_table" may show up wrongly instead.
> >>>
> >>> In general I think it would be beneficial to search for wrong alignme=
nts at
> >>> link time, and maybe at runtime.
> >>>
> >>> The patch at the end of this cover letter
> >>> - adds compile time checks to the "modpost" tool, and
> >>> - adds a runtime check to the kernel module loader at runtime.
> >>> And it will possibly show false positives too (!!!)
> >>> I do understand that some of those sections are not performce critica=
l
> >>> and thus any alignment is OK.
> >>>
> >>> The modpost patch will emit at compile time such warnings (on x86-64 =
kernel build):
> >>>
> >>> WARNING: modpost: vmlinux: section .initcall7.init (type 1, flags 2) =
has alignment of 1, expected at least 4.
> >>> Maybe you need to add ALIGN() to the modules.lds file (or fix modpost=
) ?
> >>> WARNING: modpost: vmlinux: section .altinstructions (type 1, flags 2)=
 has alignment of 1, expected at least 2.
> >>> WARNING: modpost: vmlinux: section .initcall6.init (type 1, flags 2) =
has alignment of 1, expected at least 4.
> >>> WARNING: modpost: vmlinux: section .initcallearly.init (type 1, flags=
 2) has alignment of 1, expected at least 4.
> >>> WARNING: modpost: vmlinux: section .rodata.cst2 (type 1, flags 18) ha=
s alignment of 2, expected at least 64.
> >>> WARNING: modpost: vmlinux: section .static_call_tramp_key (type 1, fl=
ags 2) has alignment of 1, expected at least 8.
> >>> WARNING: modpost: vmlinux: section .con_initcall.init (type 1, flags =
2) has alignment of 1, expected at least 8.
> >>> WARNING: modpost: vmlinux: section __bug_table (type 1, flags 3) has =
alignment of 1, expected at least 4.
> >>> ...
> >>
> >>
> >>
> >>
> >> modpost acts on vmlinux.o instead of vmlinux.
> >>
> >>
> >> vmlinux.o is a relocatable ELF, which is not a real layout
> >> because no linker script has been considered yet at this
> >> point.
> >>
> >>
> >> vmlinux is an executable ELF, produced by a linker,
> >> with the linker script taken into consideration
> >> to determine the final section/symbol layout.
> >>
> >>
> >> So, checking this in modpost is meaningless.
> >>
> >>
> >>
> >> I did not check the module checking code, but
> >> modules are also relocatable ELF.
> >
> >
> >
> > Sorry, I replied too early.
> > (Actually I replied without reading your modpost code).
> >
> > Now, I understand what your checker is doing.
> >
> >
> > I did not test how many false positives are produced,
> > but it catches several suspicious mis-alignments.
>
> Yes.
>
> > However, I am not convinced with this warning.
> >
> >
> > +               warn("%s: section %s (type %d, flags %lu) has
> > alignment of %d, expected at least %d.\n"
> > +                    "Maybe you need to add ALIGN() to the modules.lds
> > file (or fix modpost) ?\n",
> > +                    modname, sec, sechdr->sh_type, sechdr->sh_flags,
> > is_shalign, should_shalign);
> > +       }
> >
> >
> > Adding ALGIN() hides the real problem.
>
> Right.
> It took me some time to understand the effects here too.
> See below...
>
> > I think the real problem is that not enough alignment was requested
> > in the code.
> >
> > For example, the right fix for ".initcall7.init" should be this:
> >
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 3fa3f6241350..650311e4b215 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -264,6 +264,7 @@ extern struct module __this_module;
> >   #define ____define_initcall(fn, __stub, __name, __sec)         \
> >          __define_initcall_stub(__stub, fn)                      \
> >          asm(".section   \"" __sec "\", \"a\"            \n"     \
> > +           ".balign 4                                  \n"     \
> >              __stringify(__name) ":                      \n"     \
> >              ".long      " __stringify(__stub) " - .     \n"     \
> >              ".previous                                  \n");   \
> >
> > Then, "this section requires at least 4 byte alignment"
> > is recorded in the sh_addralign field.
>
> Yes, this is the important part.
>
> > Then, the rest is the linker's job.
> >
> > We should not tweak the linker script.
>
> That's right, but let's phrase it slightly different...
> There is *no need* to tweak the linker script, *if* the alignment
> gets correctly assigned by the inline assembly (like your
> initcall patch above).
> But on some platforms (e.g. on parisc) I noticed that this .balign
> was missing for some other sections, in which case the other (not preferr=
ed)
> possible option is to tweak the linker script.
>
> So I think we agree that fixing the inline assembly is the right
> way to go?


Yes, I think so.



> Either way, a link-time check like the proposed modpost patch
> may catch section issue for upcoming/newly added sections too.


Yes. This check seems to be useful.




--=20
Best Regards
Masahiro Yamada

