Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9054F9CE
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382807AbiFQPCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382695AbiFQPCG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 11:02:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4922341308;
        Fri, 17 Jun 2022 08:02:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB97321E1A;
        Fri, 17 Jun 2022 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655478122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPx6aFu2+C8m/s4I7i764IkxIpymMdXz3MEbjj3vaT0=;
        b=oATsqTy3tWG8Ye+OffaNGYq3oEgZNgmCNzza7t3ngrO1yGVyypI7yt2ZirBjSr64rnPsZN
        MiHEKYDroCoqvAJrUhXooL3TtOE1FOvf+qTsMQM97PhAhUH7kWhk/5PUjdsHIbdN/odghh
        plZA8x1CptqK4GLO1FXyfzp6DaSp76s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655478122;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pPx6aFu2+C8m/s4I7i764IkxIpymMdXz3MEbjj3vaT0=;
        b=DEw9fjGnI3YFS2Qar0UQ2i6XX8xUnKrGi548MpVPHdzQMbwoCyfx/htX8EycNF2hVzziS1
        PkrETsjvUBzFRzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8A151348E;
        Fri, 17 Jun 2022 15:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7OoAKGqXrGLnPQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 15:02:02 +0000
Date:   Fri, 17 Jun 2022 17:04:12 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        libc-alpha@sourceware.org,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zack@owlfolio.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        David Howells <dhowells@redhat.com>
Subject: Re: Ping: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Message-ID: <YqyX7E954/b+yKS3@yuki>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki>
 <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
 <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
 <913509.1638457313@warthog.procyon.org.uk>
 <YbDQW6uakG3XD8jV@yuki>
 <fe7c52f9-5ff3-95a5-2692-20f81d6decf7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7c52f9-5ff3-95a5-2692-20f81d6decf7@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!
> >>> I could be persuaded otherwise with an example of a program for which
> >>> changing __s64 from 'long long' to 'long' would break *binary* backward
> >>> compatibility, or similarly for __u64.
> >>
> >> C++ could break.
> > 
> > Thinking of this again we can detect C++ as well so it can be safely
> > enabled just for C with:
> > 
> > #if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
> > # include <asm-generic/int-l64.h>
> > #else
> > # include <asm-generic/int-ll64.h>
> > #endif
> > 
> 
> I'm very interested in seeing this merged, as that would allow 
> simplifying the man-pages by removing unnecessary kernel details such as 
> u64[1].  How is the state of this patch?

I guess that it stalled because I haven't posted it as an actual patch,
I should do so to get this back on a track.

-- 
Cyril Hrubis
chrubis@suse.cz
