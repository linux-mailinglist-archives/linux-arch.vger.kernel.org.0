Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B17209B5
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbjFBTVe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjFBTVc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 15:21:32 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331CE41;
        Fri,  2 Jun 2023 12:21:31 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 352JK7fE2750506
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 2 Jun 2023 12:20:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 352JK7fE2750506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023051001; t=1685733612;
        bh=SMZguLjkAGwW1nnxkS45sNuwWaVSmMrNfx0ztcGGwoA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=M12klTJ5FYJ+X8CUS9C3VIpLDDMPTsKRZ0ndgBKVMmE7aVMV0MN0/y9Jvzn81tOqa
         8VYX8/bm9osGsG2ClUgVOyJj8lbUxvR+FH3nCAq2d658yulezFd25UFLxwFRhjtOS5
         IjlBfRN2e8q9yDkAuYcRFZPnJBPmhZVzw4981sWNvjYtM4oL0bb3Na6skyPzoQgIdo
         iCn1fDCEMrqULzSB9GRm5RmqDinfT0ZlP//XuPLwDhfhWBfc2pGRjLhHy9T2u4pvwH
         vQYmPBqCCoxSpJWpRZkrllXh+v8F6mpkhaRL54uoSHt6pPLFXvZrX+niKiXYDc8cPp
         mA9OLCSWYPRCg==
Date:   Fri, 02 Jun 2023 12:20:05 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
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
In-Reply-To: <20230602191014.GA695361@hirez.programming.kicks-ass.net>
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org> <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net> <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com> <20230602143912.GI620383@hirez.programming.kicks-ass.net> <E333E35E-5F9C-441C-B75A-082F19D37978@zytor.com> <20230602191014.GA695361@hirez.programming.kicks-ass.net>
Message-ID: <B432FCD8-2ED7-42B1-BC3B-34F277A1CD9F@zytor.com>
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

Ok=2E So the patch description needs to be fixed=2E Otherwise the solution =
would be far simpler :)
