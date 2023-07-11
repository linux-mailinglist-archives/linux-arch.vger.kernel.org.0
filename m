Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CCB74EF61
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjGKMvY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjGKMvX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 08:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DDE6C;
        Tue, 11 Jul 2023 05:51:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94D1D614BF;
        Tue, 11 Jul 2023 12:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555A7C433C7;
        Tue, 11 Jul 2023 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689079879;
        bh=v+qEn9CoklXqxP1Sa+MFkzpKjgr7E+g5iZSiirA+nSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUjSfsi7J0u/QQbtQMCDtiEKTIE7W5W0WBpPNSQMzTFUcRkYSb04jbHJs21fv800g
         EThrQaUqs7NsBFe05IcCLgYzLYXYWoW8KeI98C2YcabyFUIYGnWFvDeTxCtiBR76jr
         w/Zr0d0700gwvjaTe1JlnCUhU8AS5VndNnODqvgRp53hJh/zIs47unszqpTHBzrQaK
         1xiXUMMc6WfSsUWm4s9ZEif1kEg2vCGCmP2azN/sbKPrUei4Ggr2CXmDG8Mzu44IK0
         429B8vdVSRgfpn5E02EAVJjTXmzixyzoj9+S/Iq6iOYedIetr84v91WQhSf1jA/jj4
         7ALpPYBl5adoQ==
Date:   Tue, 11 Jul 2023 14:51:01 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Palmer Dabbelt <palmer@sifive.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        christian@brauner.io, Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Helge Deller <deller@gmx.de>,
        David Howells <dhowells@redhat.com>, fenghua.yu@intel.com,
        firoz.khan@linaro.org, Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, jhogan@kernel.org,
        Kim Phillips <kim.phillips@arm.com>, ldv@altlinux.org,
        linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>, paul.burton@mips.com,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, stefan@agner.ch,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, tycho@tycho.ws,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v3 2/5] fs: Add fchmodat4()
Message-ID: <ZK1QNRidZuGcfOSd@example.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
 <cover.1689074739.git.legion@kernel.org>
 <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
 <83363cbb-2431-4520-81a9-0d71f420cb36@app.fastmail.com>
 <20230711-demolieren-nilpferd-80ffe47563ad@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711-demolieren-nilpferd-80ffe47563ad@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 11, 2023 at 01:52:01PM +0200, Christian Brauner wrote:
> On Tue, Jul 11, 2023 at 01:42:19PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 11, 2023, at 13:25, Alexey Gladkov wrote:
> > > From: Palmer Dabbelt <palmer@sifive.com>
> > >
> > > On the userspace side fchmodat(3) is implemented as a wrapper
> > > function which implements the POSIX-specified interface. This
> > > interface differs from the underlying kernel system call, which does not
> > > have a flags argument. Most implementations require procfs [1][2].
> > >
> > > There doesn't appear to be a good userspace workaround for this issue
> > > but the implementation in the kernel is pretty straight-forward.
> > >
> > > The new fchmodat4() syscall allows to pass the AT_SYMLINK_NOFOLLOW flag,
> > > unlike existing fchmodat.
> > >
> > > [1] 
> > > https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=17eca54051ee28ba1ec3f9aed170a62630959143;hb=a492b1e5ef7ab50c6fdd4e4e9879ea5569ab0a6c#l35
> > > [2] 
> > > https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c?id=718f363bc2067b6487900eddc9180c84e7739f80#n28
> > >
> > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > 
> > I don't know the history of why we ended up with the different
> > interface, or whether this was done intentionally in the kernel
> > or if we want this syscall.
> > 
> > Assuming this is in fact needed, I double-checked that the
> > implementation looks correct to me and is portable to all the
> > architectures, without the need for a compat wrapper.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> The system call itself is useful afaict. But please,
> 
> s/fchmodat4/fchmodat2/

Sure. I will.

> With very few exceptions we don't version by argument number but by
> revision and we should stick to one scheme:
> 
> openat()->openat2()
> eventfd()->eventfd2()
> clone()/clone2()->clone3()
> dup()->dup2()->dup3() // coincides with nr of arguments
> pipe()->pipe2() // coincides with nr of arguments
> renameat()->renameat2()
> 

-- 
Rgrds, legion

