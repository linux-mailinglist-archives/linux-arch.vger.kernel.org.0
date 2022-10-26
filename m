Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909960E631
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiJZRJ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiJZRJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 13:09:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D81E3EF;
        Wed, 26 Oct 2022 10:09:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 57E3B1F899;
        Wed, 26 Oct 2022 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666804189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqqP6Dxm/MenMy0jC9uBeRG4Y6goegyMzGhboeAYhMc=;
        b=GBy+EhssxqBv5fnX3Djku2r5jD+rDQIs04u+mr9+9tnoJAi7ZX0fMxgNM7KSwgrAvYa7KR
        nh/fVFjCtdFInhZCDGtBmsEM2FmOuUkc7DTQ72Rw39rmfjP75s/V7wkWtCEJ3y+iB5aAuV
        5jM5chKxGhN+JtxTIqQnMWkWiS6FHKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666804189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqqP6Dxm/MenMy0jC9uBeRG4Y6goegyMzGhboeAYhMc=;
        b=o4qjblqFXezmnNRfDo8rXRh5pZsneQmVNrbg/XNK98AQI99zcOedlpnsKf0WopNHM5/LmM
        fXIYzbLyEAksFwCg==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4842A2C142;
        Wed, 26 Oct 2022 17:09:49 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id 3A8A46462; Wed, 26 Oct 2022 17:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id 38F4162DC;
        Wed, 26 Oct 2022 17:09:49 +0000 (UTC)
Date:   Wed, 26 Oct 2022 17:09:49 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?ISO-8859-15?Q?Martin_Li=A8ka?= <mliska@suse.cz>,
        Borislav Petkov <bpetkov@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
In-Reply-To: <CAK7LNASs_8yjxLj-DxsFkej67b5JbHbRu9NgmtzT8+zdCcuPiQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.20.2210261653340.29399@wotan.suse.de>
References: <20220924181915.3251186-1-masahiroy@kernel.org> <20220924181915.3251186-7-masahiroy@kernel.org> <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org> <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de>
 <CAK7LNASs_8yjxLj-DxsFkej67b5JbHbRu9NgmtzT8+zdCcuPiQ@mail.gmail.com>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Thu, 27 Oct 2022, Masahiro Yamada wrote:

> > To be precise: I know of no linker (outside LTO-like modes) that processes
> > archives in a different order than first-to-last-member (under
> > whole-archive), but that's not guaranteed anywhere.  So relying on
> > member-order within archives is always brittle.
> 
> The objects in an archive are linked first-to-last-member for a long time.
> This is the assumption which we have relied on for a long time.

Sure, that doesn't mean it's guaranteed, for this I'm just devils 
advocate.  As I said, it's the mode of operation of all currently existing 
linkers I know, so for the forseeable future you can continue to rely on 
it.  But as soon as LTO enters the picture that all breaks down, as you 
see here.

Consider how LTO works, the granularity of shuffling stuff around is the 
functions of all inputs, not the object files.  So, even if you say
  obj1.o obj2.o
on the link command line, and supposed there are two functions in each of 
obj1 and obj2, then it may just so happen that LTO partitions the program 
such that it ends up with partitions
  part1 : obj1:foo obj2:bar
  part2 : obj1:bar obj2:foo
now, suddenly there is no order between part1 and part2 anymore that 
would faithfully represent the original order between obj1 and obj2 
functions.  Of course the partitioning algorithm could be changed, but 
that would limit the effectiveness of LTO.

> We assume the initcall order is preserved.
> The call order within each of core_initcall, arch_initcall,
> device_initcall, etc.
> is the order of objects in built-in.a, in other words,
> the order they appear in Makefiles.

If you rely on relative order of these, then you will probably see 
interesting effects in LTO mode eventually.

> So, this is happening on (not-upstreamed-yet) GCC LTO only?

I don't know.  As any kind of whole-program transformations is in 
principle cross-file on per-function basis (that's the whole purpose) I 
would imagine that you can see these effects in all compilers, if you try 
hard enough.

> > There are only two ways of guaranteeing an ordering: put non-LTO-.o files
> > at certain places of the link command, or, better, use a linker script to
> > specify an order.
> 
> The objects directly given in the command line are linked in the same order,
> even under LTO mode. Is this what you mean?

If they don't contain LTO code then yes, they are linked 
in exactly the given order.  If they do, they become part of the LTO blob 
whose ordering isn't precisely influenced by cmdline order.

> Any documentation about that?

I think so, but I can't point my finger to anything.  Several parts of the 
toolchain rely on that (so the kernel is not alone), but those are either 
carefully avoiding LTO or using other ordering means like linker script to 
achieve what they need.


Ciao,
Michael.
