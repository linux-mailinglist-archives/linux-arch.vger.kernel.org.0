Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EECC429E00
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 08:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhJLGwD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 02:52:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:33309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhJLGwC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 02:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634021352;
        bh=qcxbPgYwYNOPXhi8uA9LBfQfNRLANqOpsJt37ueaW6U=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jnO4bua4tKR3wNr4691cb3hfADr/sgNncr5tWuA3FByszBPfZJZ80M24ZpfLOsNsZ
         MapioCR391nAvpEsCm0TXR8qZRpBwUJbzpZWlv13Tr8j0OpqR84sSUyoSeRqz4FGJa
         bQLE5KGsq5q5D2SQzkOEuvLmKnYX1A+uz3VRkMGw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.128.177]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1mNcWw0798-00McUz; Tue, 12
 Oct 2021 08:49:12 +0200
Date:   Tue, 12 Oct 2021 08:48:56 +0200
From:   Helge Deller <deller@gmx.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 04/10] asm-generic: Use
 HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to define associated stubs
Message-ID: <YWUv2ABSKK4ySJ+h@ls3530>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <8db2a3ca2b26a8325c671baa3e0492914597f079.1633964380.git.christophe.leroy@csgroup.eu>
 <91b38fce-8a5c-ccc7-fba5-b75b9769d4fc@gmx.de>
 <09bcd71a-baae-92b7-4c89-c8d446396d1c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <09bcd71a-baae-92b7-4c89-c8d446396d1c@csgroup.eu>
X-Provags-ID: V03:K1:GGD3b71ZagZDZuIj3zWfXRFjtufuIwJxDDyEbPbWInjg/A0lodr
 AXKsmCGVIqLG4NJKhiGmBWbMCIdHaVLxRJfgxiHIgDillGBJKi6mlQtY1bBSdNu3T5M7kMK
 0H4arv5sM8blvmSHMaR1gxdbIBxQ0EF+FclcfoUzkmi4Quo+fFwCvuWj3ABpVzbZAEhooRW
 cdAcHzy9O8Sc/hGX8Nmrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+07Y0LZ1zoM=:4pOkrNB4rtkdUg7mSjOTiN
 YkM5WXjiEpaf1T1ubxFeR8mh8UwEoicCxh+GTeYB6VEkt//9Fis/eOy6ll6OECfEzkcyhOo/7
 r2dKJQIXR8QHUNquV/BaegZUaLHJ0fCbrbLay457S+kMSUTuB5yhO25Zt6EbkV+3VutRPUlAZ
 zudv0kbVIsJ7WFteocWSTP5tu3R5Rszr+ywpr9Ezbp21HopPLhJUcugg2IzHZ8A7Oji3syO7K
 JT+mxx1BF/3rY1OhQ6ibjUyFz/jgL5SpfcHq9x9SGVehUjFoNce4mp6KBHoB1LG0VtYmXGMdT
 0zFhFODEa0OfxMRm92KbUZ2ydvCiY/v1V+S8M5g98NIc9F33t9qwjjJ4o/Ca2V7ejQ9retNc+
 9WQYi+FfjceF5nTCs8H7epn/C6Tx1A8+huKy7dT+Tx8nr4ZWbtvB1PviSSlV+M4WjQOOS4WJv
 k7y5VMRjW361auSGMX5MJEIyoyiUpj+o8vf0u0/kXnLTk8GRqi3TlDGEYIL5sjSOxTy6SaqCQ
 367zx7zOvflHzfh5fRmaJFveKEueLhpdNSpbZzAh8Yx5eltX84YUL31U8BlF63DwLMdkj8gOm
 e7laVhkGspH58pK4wZgmoXo5M14w+4FCbPizWL5B8weim+HRFgo5RuI/z8MLPGNW7lq4cSHvr
 0dDpst5r66tsbGbhlnim2O2zlyPg1DvRYoqdB6nOasSsAFqC+2cyGmfDtqNm7/gUQYMLZBXEO
 ib85LoRjtQi8rjo1na2DA9+3Wi1IeR+uNGr0EnI959/aDPZnC6BAdU0iDMMVaCzoi3RhnOd2g
 gR60LJewYsXDLaUqp3oNYah45gGQ8H4/+avLB2cMztPSOM8h9+tl8gDzTKSepgvLf4G7kS8k1
 DJ80N7ylZeVSMcgsoc1QToFQKbgi7ODCCawRnCif5UuadAZMjiDxY0MutCGpt5vNlmno4rk6i
 t+0/zI89xtR1wq1fgsZ/D82EWYBtlJv8d1pGEJkOkQ7qsdsYk3K/AcIvkVaNpt8jvxQHpD5XS
 cFZwmKmbpBlHoDeRb3kboY5jmxeVQn2EH6K+EIoIsGKBgAnu8PHQB1bNyvw5MzBxzNCkYwOAO
 tJoy0ptVc8dY5w=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Christophe Leroy <christophe.leroy@csgroup.eu>:
>
>
> Le 12/10/2021 =C3=A0 08:02, Helge Deller a =C3=A9crit=C2=A0:
> > On 10/11/21 17:25, Christophe Leroy wrote:
> > > Use HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR instead of 'dereference_fun=
ction_descriptor'
> > > to know whether arch has function descriptors.
> > >
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >   arch/ia64/include/asm/sections.h    | 4 ++--
> > >   arch/parisc/include/asm/sections.h  | 6 ++++--
> > >   arch/powerpc/include/asm/sections.h | 6 ++++--
> > >   include/asm-generic/sections.h      | 3 ++-
> > >   4 files changed, 12 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/as=
m/sections.h
> > > index 35f24e52149a..80f5868afb06 100644
> > > --- a/arch/ia64/include/asm/sections.h
> > > +++ b/arch/ia64/include/asm/sections.h
> > > @@ -7,6 +7,8 @@
> > >    *	David Mosberger-Tang <davidm@hpl.hp.com>
> > >    */
> > >
> > > +#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> > > +
> > >   #include <linux/elf.h>
> > >   #include <linux/uaccess.h>
> > >   #include <asm-generic/sections.h>
> > > @@ -27,8 +29,6 @@ extern char __start_gate_brl_fsys_bubble_down_patc=
hlist[], __end_gate_brl_fsys_b
> > >   extern char __start_unwind[], __end_unwind[];
> > >   extern char __start_ivt_text[], __end_ivt_text[];
> > >
> > > -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> > > -
> > >   #undef dereference_function_descriptor
> > >   static inline void *dereference_function_descriptor(void *ptr)
> > >   {
> > > diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/includ=
e/asm/sections.h
> > > index bb52aea0cb21..2e781ee19b66 100644
> > > --- a/arch/parisc/include/asm/sections.h
> > > +++ b/arch/parisc/include/asm/sections.h
> > > @@ -2,6 +2,10 @@
> > >   #ifndef _PARISC_SECTIONS_H
> > >   #define _PARISC_SECTIONS_H
> > >
> > > +#ifdef CONFIG_64BIT
> > > +#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> > > +#endif
> > > +
> > >   /* nothing to see, move along */
> > >   #include <asm-generic/sections.h>
> > >
> > > @@ -9,8 +13,6 @@ extern char __alt_instructions[], __alt_instruction=
s_end[];
> > >
> > >   #ifdef CONFIG_64BIT
> > >
> > > -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> > > -
> > >   #undef dereference_function_descriptor
> > >   void *dereference_function_descriptor(void *);
> > >
> > > diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/incl=
ude/asm/sections.h
> > > index 32e7035863ac..b7f1ba04e756 100644
> > > --- a/arch/powerpc/include/asm/sections.h
> > > +++ b/arch/powerpc/include/asm/sections.h
> > > @@ -8,6 +8,10 @@
> > >
> > >   #define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
> > >
> > > +#ifdef PPC64_ELF_ABI_v1
> > > +#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> > > +#endif
> > > +
> > >   #include <asm-generic/sections.h>
> > >
> > >   extern bool init_mem_is_free;
> > > @@ -69,8 +73,6 @@ static inline int overlaps_kernel_text(unsigned lo=
ng start, unsigned long end)
> > >
> > >   #ifdef PPC64_ELF_ABI_v1
> > >
> > > -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
> > > -
> > >   #undef dereference_function_descriptor
> > >   static inline void *dereference_function_descriptor(void *ptr)
> > >   {
> > > diff --git a/include/asm-generic/sections.h b/include/asm-generic/se=
ctions.h
> > > index d16302d3eb59..1db5cfd69817 100644
> > > --- a/include/asm-generic/sections.h
> > > +++ b/include/asm-generic/sections.h
> > > @@ -59,7 +59,8 @@ extern char __noinstr_text_start[], __noinstr_text=
_end[];
> > >   extern __visible const void __nosave_begin, __nosave_end;
> > >
> > >   /* Function descriptor handling (if any).  Override in asm/section=
s.h */
> > > -#ifndef dereference_function_descriptor
> > > +#ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
> > > +#else
> >
> > why not
> > #ifndef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
> > instead of #if/#else ?
>
> To avoid changing it again in patch 6, or getting an ugly #ifndef/#else =
at
> the end.

Ok.

Building on parisc fails at multiple files like this:
  CC      mm/filemap.o
In file included from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/interrupt.h:21,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/trace_recursion.h:5,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/ftrace.h:10,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/perf_event.h:49,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/trace_events.h:10,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
trace/syscall.h:7,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/=
linux/syscalls.h:87,
                 from /home/cvs/parisc/git-kernel/linus-linux-2.6/init/ini=
tramfs.c:11:
/home/cvs/parisc/git-kernel/linus-linux-2.6/arch/parisc/include/asm/sectio=
ns.h:7:9: error: unknown type name =E2=80=98Elf64_Fdesc=E2=80=99
    7 | typedef Elf64_Fdesc funct_descr_t;
      |         ^~~~~~~~~~~


So, you still need e.g. this patch:

diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/=
sections.h
index b041fb32a300..177983490e7c 100644
=2D-- a/arch/parisc/include/asm/sections.h
+++ b/arch/parisc/include/asm/sections.h
@@ -4,6 +4,8 @@

 #ifdef CONFIG_64BIT
 #define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
+#include <asm/elf.h>
+#include <linux/uaccess.h>
 typedef Elf64_Fdesc funct_descr_t;
 #endif

In general to save space I think it would be beneficial if the
dereference_kernel_function_descriptor() and
dereference_kernel_function_descriptor() functions would go as real
functions a c-file instead of just being inlined functions in the
asm-generic/sections.h header file.

Other than that it's a nice cleanup!

Helge
