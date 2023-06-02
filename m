Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2C72080C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjFBRCQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjFBRCP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 13:02:15 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42828C0;
        Fri,  2 Jun 2023 10:02:14 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 352H0LaS2715581
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 2 Jun 2023 10:00:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 352H0LaS2715581
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023051001; t=1685725229;
        bh=V6iJrWJJDLQYjecCwNtSmfh10OvdV8TAJ4Liut90hTM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=uPFx05CyW1BpZXeT87CyY8RQtjp5NgyjdvmFkLaPOSkerjoOaX418Gxy0SEASWCfk
         6OU5WS8qq7OF0xdgiwBE1NGx8DbNIrczc+xjAUYuh6Hn3pYdiFuRnciKBhciDyJOOI
         PtbPbK/C+duRWrZe/QHzvXYYGpqts981bZKHmO/brXOBPs6W8JhS+672AOxS9JQcC0
         zfeYaYNkDjMGvk/RykG+GdjoUic+Ff92KZNfWXs887fhgkEFfZA1xodBxxkWZSynR4
         Lmzyg3qOQXOtRftEt+BLjXMoM8h9EoUz38KTt9lCKS8N9e1BPlhydYYPwGe4NZYCBA
         Nj8HY1VstDhAA==
Date:   Fri, 02 Jun 2023 10:00:17 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Helge Deller <deller@gmx.de>,
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
        Joerg Roedel <joro@8bytes.org>, suravee.suthikulpanit@amd.com,
        Robin Murphy <robin.murphy@arm.com>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_07/12=5D_parisc/percpu=3A_Wo?= =?US-ASCII?Q?rk_around_the_lack_of_=5F=5FSIZEOF=5FINT128=5F=5F?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org> <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net> <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com> <20230602143912.GI620383@hirez.programming.kicks-ass.net>
Message-ID: <E333E35E-5F9C-441C-B75A-082F19D37978@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On June 2, 2023 7:39:12 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wro=
te:
>On Thu, Jun 01, 2023 at 09:29:18AM -0400, Linus Torvalds wrote:
>
>> Right now we have that "minimum gcc version" in a somewhat annoying
>> place: it's in the =2E/scripts/min-tool-version=2Esh file as a shell
>> script=2E
>
>Something like so then?
>
>---
>Subject: parisc: Raise minimal GCC version
>From: Peter Zijlstra <peterz@infradead=2Eorg>
>Date: Fri Jun  2 16:33:54 CEST 2023
>
>With 64bit builds depending on __SIZEOF_INT128__ raise the parisc
>minimum compiler version to gcc-11=2E0=2E0=2E
>
>All other 64bit architectures provide this from GCC-5=2E1=2E0 (and
>probably before), except hppa64 which only started advertising this
>with GCC-11=2E
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>---
> scripts/min-tool-version=2Esh |    6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>--- a/scripts/min-tool-version=2Esh
>+++ b/scripts/min-tool-version=2Esh
>@@ -17,7 +17,11 @@ binutils)
> 	echo 2=2E25=2E0
> 	;;
> gcc)
>-	echo 5=2E1=2E0
>+	if [ "$SRCARCH" =3D parisc ]; then
>+		echo 11=2E0=2E0
>+	else
>+		echo 5=2E1=2E0
>+	fi
> 	;;
> llvm)
> 	if [ "$SRCARCH" =3D s390 ]; then

Dumb question: is this only about the cpp macro or is it about __int128 ex=
isting at all?
