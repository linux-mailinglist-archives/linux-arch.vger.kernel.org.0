Return-Path: <linux-arch+bounces-1153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CC81BB32
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFAD286BD6
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB4E53A08;
	Thu, 21 Dec 2023 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Lb/onC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71E627F6;
	Thu, 21 Dec 2023 15:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B74C433C9;
	Thu, 21 Dec 2023 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173382;
	bh=MWfBIeGV77ZPzBms8I8+8JYz2lrVS9wQV+KpBlK+plk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W0Lb/onCPnWS0E5hgE4x6WdFMxQ58Or6FUWxq/OSmNPXNwii2WmeCJnDV3xmnzq63
	 dpprRWXsgzVCexyIyzaPWn8RroSwdqs33A4Yc5+7rVEes8I3SGaorNATbQm5hndX1i
	 eVkALAkqwpcDyiJdeePD0xkX0ACVAohAzifciRfMu83zR2IYoNk6SGS91GF+ysh541
	 0pm9tAkmDo4i1mluLF5Epv+PGKSmSTPAZ+PjJXI/z10w2XapnKpB+EIjMF4UCFpogy
	 WIFpZjXCgriO3/tk56SjdZY6HSyyW3oSll3Vm75VVFwv/jQRTQknkzC6ggbRRlgI7G
	 jXrBAZlOF2L/Q==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso640217fac.1;
        Thu, 21 Dec 2023 07:43:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyLF3XeX/aTAwi4sUWyTANupZeBIQJDeyKllq2ZgmRyNryZVPUt
	j8EI99KGlUMcNhC0M9DnI0OCsflLWSg9ocYOk24=
X-Google-Smtp-Source: AGHT+IE9BVu0bYISlDv2Jpo0rVXJUqkiAdxu0n5k9dGj9xn/BXpl6sZnvHFWGFOmYDL9miXoXD3caFx9cnasgkIkpgA=
X-Received: by 2002:a05:6871:b0c:b0:204:31a1:9b84 with SMTP id
 fq12-20020a0568710b0c00b0020431a19b84mr950136oab.64.1703173381696; Thu, 21
 Dec 2023 07:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122221814.139916-1-deller@kernel.org> <CAK7LNAQZO0g-B7UUEvdJWh3FhdhmWaaSaJyyEUoVoSYG0j8v-Q@mail.gmail.com>
In-Reply-To: <CAK7LNAQZO0g-B7UUEvdJWh3FhdhmWaaSaJyyEUoVoSYG0j8v-Q@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Dec 2023 00:42:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com>
Message-ID: <CAK7LNASk=A4aeMuhUt4NGi5RHedcQ_WQrdN3r7S_x0euvsPUXA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Section alignment issues?
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	linux-modules@vger.kernel.org, linux-arch@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:40=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Thu, Nov 23, 2023 at 7:18=E2=80=AFAM <deller@kernel.org> wrote:
> >
> > From: Helge Deller <deller@gmx.de>
> >
> > While working on the 64-bit parisc kernel, I noticed that the __ksymtab=
[]
> > table was not correctly 64-bit aligned in many modules.
> > The following patches do fix some of those issues in the generic code.
> >
> > But further investigation shows that multiple sections in the kernel an=
d in
> > modules are possibly not correctly aligned, and thus may lead to perfor=
mance
> > degregations at runtime (small on x86, huge on parisc, sparc and others=
 which
> > need exception handlers). Sometimes wrong alignments may also be simply=
 hidden
> > by the linker or kernel module loader which pulls in the sections by lu=
ck with
> > a correct alignment (e.g. because the previous section was aligned alre=
ady).
> >
> > An objdump on a x86 module shows e.g.:
> >
> > ./kernel/net/netfilter/nf_log_syslog.ko:     file format elf64-x86-64
> > Sections:
> > Idx Name          Size      VMA               LMA               File of=
f  Algn
> >   0 .text         00001fdf  0000000000000000  0000000000000000  0000004=
0  2**4
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >   1 .init.text    000000f6  0000000000000000  0000000000000000  0000202=
0  2**4
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >   2 .exit.text    0000005c  0000000000000000  0000000000000000  0000212=
0  2**4
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> >   3 .rodata.str1.8 000000dc  0000000000000000  0000000000000000  000021=
80  2**3
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   4 .rodata.str1.1 0000030a  0000000000000000  0000000000000000  000022=
5c  2**0
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   5 .rodata       000000b0  0000000000000000  0000000000000000  0000258=
0  2**5
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   6 .modinfo      0000019e  0000000000000000  0000000000000000  0000263=
0  2**0
> >                   CONTENTS, ALLOC, LOAD, READONLY, DATA
> >   7 .return_sites 00000034  0000000000000000  0000000000000000  000027c=
e  2**0
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> >   8 .call_sites   0000029c  0000000000000000  0000000000000000  0000280=
2  2**0
> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
> >
> > In this example I believe the ".return_sites" and ".call_sites" should =
have
> > an alignment of at least 32-bit (4 bytes).
> >
> > On other architectures or modules other sections like ".altinstructions=
" or
> > "__ex_table" may show up wrongly instead.
> >
> > In general I think it would be beneficial to search for wrong alignment=
s at
> > link time, and maybe at runtime.
> >
> > The patch at the end of this cover letter
> > - adds compile time checks to the "modpost" tool, and
> > - adds a runtime check to the kernel module loader at runtime.
> > And it will possibly show false positives too (!!!)
> > I do understand that some of those sections are not performce critical
> > and thus any alignment is OK.
> >
> > The modpost patch will emit at compile time such warnings (on x86-64 ke=
rnel build):
> >
> > WARNING: modpost: vmlinux: section .initcall7.init (type 1, flags 2) ha=
s alignment of 1, expected at least 4.
> > Maybe you need to add ALIGN() to the modules.lds file (or fix modpost) =
?
> > WARNING: modpost: vmlinux: section .altinstructions (type 1, flags 2) h=
as alignment of 1, expected at least 2.
> > WARNING: modpost: vmlinux: section .initcall6.init (type 1, flags 2) ha=
s alignment of 1, expected at least 4.
> > WARNING: modpost: vmlinux: section .initcallearly.init (type 1, flags 2=
) has alignment of 1, expected at least 4.
> > WARNING: modpost: vmlinux: section .rodata.cst2 (type 1, flags 18) has =
alignment of 2, expected at least 64.
> > WARNING: modpost: vmlinux: section .static_call_tramp_key (type 1, flag=
s 2) has alignment of 1, expected at least 8.
> > WARNING: modpost: vmlinux: section .con_initcall.init (type 1, flags 2)=
 has alignment of 1, expected at least 8.
> > WARNING: modpost: vmlinux: section __bug_table (type 1, flags 3) has al=
ignment of 1, expected at least 4.
> > ...
>
>
>
>
> modpost acts on vmlinux.o instead of vmlinux.
>
>
> vmlinux.o is a relocatable ELF, which is not a real layout
> because no linker script has been considered yet at this
> point.
>
>
> vmlinux is an executable ELF, produced by a linker,
> with the linker script taken into consideration
> to determine the final section/symbol layout.
>
>
> So, checking this in modpost is meaningless.
>
>
>
> I did not check the module checking code, but
> modules are also relocatable ELF.



Sorry, I replied too early.
(Actually I replied without reading your modpost code).

Now, I understand what your checker is doing.


I did not test how many false positives are produced,
but it catches several suspicious mis-alignments.


However, I am not convinced with this warning.


+               warn("%s: section %s (type %d, flags %lu) has
alignment of %d, expected at least %d.\n"
+                    "Maybe you need to add ALIGN() to the modules.lds
file (or fix modpost) ?\n",
+                    modname, sec, sechdr->sh_type, sechdr->sh_flags,
is_shalign, should_shalign);
+       }


Adding ALGIN() hides the real problem.


I think the real problem is that not enough alignment was requested
in the code.


For example, the right fix for ".initcall7.init" should be this:


diff --git a/include/linux/init.h b/include/linux/init.h
index 3fa3f6241350..650311e4b215 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -264,6 +264,7 @@ extern struct module __this_module;
 #define ____define_initcall(fn, __stub, __name, __sec)         \
        __define_initcall_stub(__stub, fn)                      \
        asm(".section   \"" __sec "\", \"a\"            \n"     \
+           ".balign 4                                  \n"     \
            __stringify(__name) ":                      \n"     \
            ".long      " __stringify(__stub) " - .     \n"     \
            ".previous                                  \n");   \



Then, "this section requires at least 4 byte alignment"
is recorded in the sh_addralign field.

Then, the rest is the linker's job.

We should not tweak the linker script.






--
Best Regards
Masahiro Yamada

