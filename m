Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5A5657EA
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiGDNzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiGDNzk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 09:55:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00742720;
        Mon,  4 Jul 2022 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sFBRrsK/nUCO/qpurgOa37xWDf0Rw4TWhvCcPDzVFrw=; b=fGvBCBUUizUVOtp0n9eFyK6qEp
        BlBJ2LXAd0hh4Ac/kOInhtYaicGuP0Wm+9RpmeAcNCveOfiNg2HalpF71G6tE0sxRAOoJnnnJ8jDo
        LzrOgSbBh27d4lrinBT/6BTlPxLOemUmVcp9N08w+0hNimZQPMPk331algyiCyhqUh44lkkWpPmmY
        R0/v2bo6OqfBLfb3ZP66/skFycQymC2OCzUed8HfkyDvpKdX2Zugr38vE288P/qWfhzbrVpgSoItW
        lZComXKs5lJQWRJj/s21c22jLyTgHTbTtCNo+CUvRSFL+2Lib/Pig8sU6eh28YZ87NBq8C1awuPRj
        X1SbUxKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8MXa-0081o6-IG;
        Mon, 04 Jul 2022 13:55:06 +0000
Date:   Mon, 4 Jul 2022 14:55:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Potapenko <glider@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to
 step_into()
Message-ID: <YsLxOkApqKPQ8Bep@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
 <YsJWCREA5xMfmmqx@ZenIV>
 <CAG_fn=V_vDVFNSJTOErNhzk7n=GRjZ_6U6Z=M-Jdmi=ekbS5+g@mail.gmail.com>
 <YsLuoFtki01gbmYB@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsLuoFtki01gbmYB@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 02:44:00PM +0100, Al Viro wrote:
> On Mon, Jul 04, 2022 at 10:20:53AM +0200, Alexander Potapenko wrote:
> 
> > What makes you think they are false positives? Is the scenario I
> > described above:
> > 
> > """
> > In particular, if the call to lookup_fast() in walk_component()
> > returns NULL, and lookup_slow() returns a valid dentry, then the
> > `seq` and `inode` will remain uninitialized until the call to
> > step_into()
> > """
> > 
> > impossible?
> 
> Suppose step_into() has been called in non-RCU mode.  The first
> thing it does is
> 	int err = handle_mounts(nd, dentry, &path, &seq);
> 	if (err < 0) 
> 		return ERR_PTR(err);
> 
> And handle_mounts() in non-RCU mode is
> 	path->mnt = nd->path.mnt;
> 	path->dentry = dentry;
> 	if (nd->flags & LOOKUP_RCU) {
> 		[unreachable code]
> 	}
> 	[code not touching seqp]
> 	if (unlikely(ret)) {
> 		[code not touching seqp]
> 	} else {
> 		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
> 	}
> 	return ret;

Make that
 	[code assigning ret a non-negative value and never using seqp]
 	if (unlikely(ret)) {
 		[code never using seqp or ret]
 	} else {
 		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
 	}
 	return ret;

so if (err < 0) in the caller is equivalent to if (err).
