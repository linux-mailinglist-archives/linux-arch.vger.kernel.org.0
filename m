Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCB7204AD
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjFBOkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjFBOkl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 10:40:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B51BD;
        Fri,  2 Jun 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=csXHyTVxkO+EGfVGUkTCJ6dG3JVY9wkWTgHzblW+1z8=; b=SkQmNVOGlL8AQWBC9GS+DAhOCy
        pofqCKOFBuExSWYSUk1GOFt2m62JU8NEtYoPUUfMMqQ0Tvi3EJsHfNqSp200ooaTXY3PTzxOlEQx6
        hi6KhG2M0AEguimnvfwFgRjrDAvrv2QoVKzAWqxP0rpemSCRkLCdxugTW/2YQ1/pytbyyJaEsm9Pe
        9fF8rqccSYOqcoqSnuyarEBqbcWLdOeZyGMTbYC1Yo4yux9gcXUpErSi7OVplE7ALO5MRwva9+CqF
        /GgutI8B0hYBrP2dcBrjvb6Ay3CWgXFc24hfBxmA3Q5N4iL4PvgjqQKKMoMxbpDLjeMpfcsPrfrFt
        gFDjAmFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q55vz-001Lw5-1U;
        Fri, 02 Jun 2023 14:39:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3BB5300188;
        Fri,  2 Jun 2023 16:39:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6982E22BA6445; Fri,  2 Jun 2023 16:39:12 +0200 (CEST)
Date:   Fri, 2 Jun 2023 16:39:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
References: <20230531130833.635651916@infradead.org>
 <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com>
 <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
 <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 01, 2023 at 09:29:18AM -0400, Linus Torvalds wrote:

> Right now we have that "minimum gcc version" in a somewhat annoying
> place: it's in the ./scripts/min-tool-version.sh file as a shell
> script.

Something like so then?

---
Subject: parisc: Raise minimal GCC version
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Jun  2 16:33:54 CEST 2023

With 64bit builds depending on __SIZEOF_INT128__ raise the parisc
minimum compiler version to gcc-11.0.0.

All other 64bit architectures provide this from GCC-5.1.0 (and
probably before), except hppa64 which only started advertising this
with GCC-11.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/min-tool-version.sh |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -17,7 +17,11 @@ binutils)
 	echo 2.25.0
 	;;
 gcc)
-	echo 5.1.0
+	if [ "$SRCARCH" = parisc ]; then
+		echo 11.0.0
+	else
+		echo 5.1.0
+	fi
 	;;
 llvm)
 	if [ "$SRCARCH" = s390 ]; then
