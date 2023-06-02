Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE097204DF
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjFBOvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFBOvB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 10:51:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 095F9E40;
        Fri,  2 Jun 2023 07:50:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C92851063;
        Fri,  2 Jun 2023 07:51:43 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 628663F7BD;
        Fri,  2 Jun 2023 07:50:52 -0700 (PDT)
Date:   Fri, 2 Jun 2023 15:50:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        suravee.suthikulpanit@amd.com, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        John David Anglin <dave.anglin@bell.net>,
        Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of
 __SIZEOF_INT128__
Message-ID: <ZHoBx7Tk5qK2X+UA@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
 <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
 <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 02, 2023 at 04:39:12PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 09:29:18AM -0400, Linus Torvalds wrote:
> 
> > Right now we have that "minimum gcc version" in a somewhat annoying
> > place: it's in the ./scripts/min-tool-version.sh file as a shell
> > script.
> 
> Something like so then?
> 
> ---
> Subject: parisc: Raise minimal GCC version
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Jun  2 16:33:54 CEST 2023
> 
> With 64bit builds depending on __SIZEOF_INT128__ raise the parisc
> minimum compiler version to gcc-11.0.0.
> 
> All other 64bit architectures provide this from GCC-5.1.0 (and
> probably before), except hppa64 which only started advertising this
> with GCC-11.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  scripts/min-tool-version.sh |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -17,7 +17,11 @@ binutils)
>  	echo 2.25.0
>  	;;
>  gcc)
> -	echo 5.1.0
> +	if [ "$SRCARCH" = parisc ]; then
> +		echo 11.0.0
> +	else
> +		echo 5.1.0
> +	fi
>  	;;
>  llvm)
>  	if [ "$SRCARCH" = s390 ]; then

I gave this a spin and it looks good to me:

[mark@lakrids:~/src/linux]% usekorg 10.3.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
[mark@lakrids:~/src/linux]% usekorg 10.3.0 make ARCH=parisc CROSS_COMPILE=hppa64-linux- generic-64bit_defconfig
***
*** C compiler is too old.
***   Your GCC version:    10.3.0
***   Minimum GCC version: 11.0.0
***
scripts/Kconfig.include:44: Sorry, this C compiler is not supported.
make[1]: *** [scripts/kconfig/Makefile:94: generic-64bit_defconfig] Error 1
make: *** [Makefile:692: generic-64bit_defconfig] Error 2
[mark@lakrids:~/src/linux]% usekorg 11.3.0 make ARCH=parisc CROSS_COMPILE=hppa64-linux- generic-64bit_defconfig
#
# configuration written to .config
#

FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.
