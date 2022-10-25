Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6E60CBBD
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiJYM0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJYM0i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 08:26:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9311A95C;
        Tue, 25 Oct 2022 05:26:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E060522042;
        Tue, 25 Oct 2022 12:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666700795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPt7m2ZnSnU+qoKAuwn24AcvwL7oef2WOn+bYLufeh4=;
        b=N6LXlW9lyqmmCxP5okb4I3fCGFCnJku835czaiNTRFI5Edafm7dl3FCBGeNKKBW73gBFiK
        rJqOulq+TDAY3QMMnFjTayIibggOoY8ix8MONCBI5fY+lWmofOISdRpqLjFVdGzf8ccHGy
        HSLoNuUR+4UM3wCbf6YKfcrJmJeEG7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666700795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPt7m2ZnSnU+qoKAuwn24AcvwL7oef2WOn+bYLufeh4=;
        b=+BYq5nR74fQfcIAWf3bflqx3o7EU6Mp+se1/XJS8qRT/n3Wgw3WHgPM1zo1IE4fby9vxIK
        FJR1HWflfS0KrsDA==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D46042C142;
        Tue, 25 Oct 2022 12:26:35 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id C6EED6405; Tue, 25 Oct 2022 12:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id C581063BB;
        Tue, 25 Oct 2022 12:26:35 +0000 (UTC)
Date:   Tue, 25 Oct 2022 12:26:35 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?ISO-8859-15?Q?Martin_Li=A8ka?= <mliska@suse.cz>,
        Borislav Petkov <bpetkov@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
In-Reply-To: <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org>
Message-ID: <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de>
References: <20220924181915.3251186-1-masahiroy@kernel.org> <20220924181915.3251186-7-masahiroy@kernel.org> <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Mon, 24 Oct 2022, Jiri Slaby wrote:

> > Create vmlinux.a to collect all the objects that are unconditionally
> > linked to vmlinux. The objects listed in head-y are moved to the head
> > of vmlinux.a by using 'ar m'.
... 
> > --- a/scripts/Makefile.vmlinux_o
> > +++ b/scripts/Makefile.vmlinux_o
> > @@ -18,7 +18,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
> >   	$(PERL) $(real-prereqs) > $@
> >     .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
> > -		$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> > +		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> 
> There is a slight problem with this. The kernel built with gcc-LTO does not
> boot. But as I understand it, it's not limited to gcc-LTO only.
> 
> On x86, startup_64() is supposed to be at offset >zero< of the image (see
> .Lrelocated()). It was ensured by putting head64.o to the beginning of vmlinux
> (by KBUILD_VMLINUX_OBJS on the LD command-line above). The patch above instead
> packs head64.o into vmlinux.a and then moves it using "ar -m" to the beginning
> (it's in 7/7 of the series IIRC).
> 
> The problem is that .o files listed on the LD command line explicitly are
> taken as spelled. But unpacking .a inside LD gives no guarantees on the order
> of packed objects. To quote: "that it happens to work sometimes is pure luck."
> (Correct me guys, if I misunderstood you.)

To be precise: I know of no linker (outside LTO-like modes) that processes 
archives in a different order than first-to-last-member (under 
whole-archive), but that's not guaranteed anywhere.  So relying on 
member-order within archives is always brittle.

It will completely break down with LTO modes: the granularity for that is 
functions, and they are placed in some unknown (from the outside, but 
usually related to call-graph locality) order into several partitions, 
with non-LTO-able parts (like asm code) being placed randomly between 
them.  The order of these blobs can not be defined in relation to the 
input order of object files: with cross-file dependencies such order might 
not even exist.  Those whole sequence of blobs then takes the place of the 
input archive (which, as there was only one, has no particular order from 
the linker command lines perspective).

There are only two ways of guaranteeing an ordering: put non-LTO-.o files 
at certain places of the link command, or, better, use a linker script to 
specify an order.

> For x86, the most ideal fix seems to be to fix it in the linker script. By
> putting startup_64() to a different section and handle it in the ld script
> specially -- see the attachment. It should always have been put this way, the
> command line order is only a workaround. But this might need more fixes on
> other archs too -- I haven't take a look.
> 
> Ideas, comments? I'll send the attachment as a PATCH later (if there are 
> no better suggestions).

This will work.  An alternative way would be to explicitely name the input 
file in the section commands, without renaming the section:

@@ -126,6 +126,7 @@ SECTIONS
                _text = .;
                _stext = .;
                /* bootstrapping code */
+               KEEP(vmlinux.a:head64.o(.head.text))
                HEAD_TEXT
                TEXT_TEXT

But I guess not all arch's name their must-be-first file head64.o (or even 
have such requirement), so that's probably still arch-dependend and hence 
not inherently better than your way.

(syntax for the section selector in linkerscripts is:

  {archive-glob:}filename-glob (sectionname-glob)


Ciao,
Michael.
