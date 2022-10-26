Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFB60E577
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiJZQal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiJZQaj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 12:30:39 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8626A46D;
        Wed, 26 Oct 2022 09:30:36 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 29QGUMnX001705;
        Thu, 27 Oct 2022 01:30:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29QGUMnX001705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666801823;
        bh=NrvbRYtl/1067H6DvXD0ajaJaqzKyNhsQ3VVzbuYtIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fToKyefdVizUawreZKFGF1YrVzT3PcCZbQTyp4hdualPypnjH/VoK9WF9lccZGWSa
         zDP6n04ZGymIejJIS835eFcbuNG//9T/EXDudopMrQnVw1jYWq5JUIuIpT6BuLMZVb
         +TBi+gm4oN5gmfEEUKzkUrTmL2ShizjFCosTz2Veto7sHAzUTuOwg2WCM2WOdrGokC
         gRiyIxq3Xl6CCTs8R8IirJoAc+P9/hUL+212KJdNeUykxKIQ2lts7SJ6mMF2zx9gJ2
         zaeK5BMxR4Qws1hX1P/7aWfpvdq7xmVL1ymAZDH/DPKh0YTpDMjCy8lfqiRnpavjUF
         pGzbSJzqICIag==
X-Nifty-SrcIP: [209.85.160.54]
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13bd19c3b68so10083373fac.7;
        Wed, 26 Oct 2022 09:30:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf1//ia/+w78FMoWiiUyThMSav+0RB64zBM6suu/v4cQ58gZCsZp
        lm0e6MhiN79uWgYT0p4HHOePHNw3LPCoudiyb3Y=
X-Google-Smtp-Source: AMsMyM6fhJ9zE5E7vKqdCmaGx4ywgewCAEvXQAKtojKZQfwTIw35e4RY5y0OVKweSkAgDyAXZ5pfsmrwhdJz0EPbEc8=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr2626872oab.287.1666801822177; Wed, 26
 Oct 2022 09:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-7-masahiroy@kernel.org> <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org>
 <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de>
In-Reply-To: <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Oct 2022 01:29:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs_8yjxLj-DxsFkej67b5JbHbRu9NgmtzT8+zdCcuPiQ@mail.gmail.com>
Message-ID: <CAK7LNASs_8yjxLj-DxsFkej67b5JbHbRu9NgmtzT8+zdCcuPiQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
To:     Michael Matz <matz@suse.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Borislav Petkov <bpetkov@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 25, 2022 at 2:26 PM Michael Matz <matz@suse.de> wrote:
>
> Hello,
>
> On Mon, 24 Oct 2022, Jiri Slaby wrote:
>
> > > Create vmlinux.a to collect all the objects that are unconditionally
> > > linked to vmlinux. The objects listed in head-y are moved to the head
> > > of vmlinux.a by using 'ar m'.
> ...
> > > --- a/scripts/Makefile.vmlinux_o
> > > +++ b/scripts/Makefile.vmlinux_o
> > > @@ -18,7 +18,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
> > >     $(PERL) $(real-prereqs) > $@
> > >     .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
> > > -           $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> > > +           vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> >
> > There is a slight problem with this. The kernel built with gcc-LTO does not
> > boot. But as I understand it, it's not limited to gcc-LTO only.
> >
> > On x86, startup_64() is supposed to be at offset >zero< of the image (see
> > .Lrelocated()). It was ensured by putting head64.o to the beginning of vmlinux
> > (by KBUILD_VMLINUX_OBJS on the LD command-line above). The patch above instead
> > packs head64.o into vmlinux.a and then moves it using "ar -m" to the beginning
> > (it's in 7/7 of the series IIRC).
> >
> > The problem is that .o files listed on the LD command line explicitly are
> > taken as spelled. But unpacking .a inside LD gives no guarantees on the order
> > of packed objects. To quote: "that it happens to work sometimes is pure luck."
> > (Correct me guys, if I misunderstood you.)
>
> To be precise: I know of no linker (outside LTO-like modes) that processes
> archives in a different order than first-to-last-member (under
> whole-archive), but that's not guaranteed anywhere.  So relying on
> member-order within archives is always brittle.


The objects in an archive are linked first-to-last-member for a long time.
This is the assumption which we have relied on for a long time.


We assume the initcall order is preserved.
The call order within each of core_initcall, arch_initcall,
device_initcall, etc.
is the order of objects in built-in.a, in other words,
the order they appear in Makefiles.


If this assumption were broken, the initcall order would be randomised.
(Somebody would have screamed earlier, if so.)



Clang LTO came up with its own workaround.
See commit a8cccdd954732a558d481407ab7c3106b89c34ae


So, this is happening on (not-upstreamed-yet) GCC LTO only?





> It will completely break down with LTO modes: the granularity for that is
> functions, and they are placed in some unknown (from the outside, but
> usually related to call-graph locality) order into several partitions,
> with non-LTO-able parts (like asm code) being placed randomly between
> them.  The order of these blobs can not be defined in relation to the
> input order of object files: with cross-file dependencies such order might
> not even exist.  Those whole sequence of blobs then takes the place of the
> input archive (which, as there was only one, has no particular order from
> the linker command lines perspective).
>
> There are only two ways of guaranteeing an ordering: put non-LTO-.o files
> at certain places of the link command, or, better, use a linker script to
> specify an order.


The objects directly given in the command line are linked in the same order,
even under LTO mode. Is this what you mean?

Any documentation about that?





> > For x86, the most ideal fix seems to be to fix it in the linker script. By
> > putting startup_64() to a different section and handle it in the ld script
> > specially -- see the attachment. It should always have been put this way, the
> > command line order is only a workaround. But this might need more fixes on
> > other archs too -- I haven't take a look.
> >
> > Ideas, comments? I'll send the attachment as a PATCH later (if there are
> > no better suggestions).
>
> This will work.  An alternative way would be to explicitely name the input
> file in the section commands, without renaming the section:
>
> @@ -126,6 +126,7 @@ SECTIONS
>                 _text = .;
>                 _stext = .;
>                 /* bootstrapping code */
> +               KEEP(vmlinux.a:head64.o(.head.text))
>                 HEAD_TEXT
>                 TEXT_TEXT
>
> But I guess not all arch's name their must-be-first file head64.o (or even
> have such requirement), so that's probably still arch-dependend and hence
> not inherently better than your way.
>
> (syntax for the section selector in linkerscripts is:
>
>   {archive-glob:}filename-glob (sectionname-glob)
>
>
> Ciao,
> Michael.



--
Best Regards

Masahiro Yamada
