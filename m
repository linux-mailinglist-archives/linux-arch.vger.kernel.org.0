Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C369D5A15E9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiHYPio (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiHYPim (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 11:38:42 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 08:38:41 PDT
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77834B7EC4
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 08:38:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,263,1654588800"; 
   d="scan'208";a="84691156"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 25 Aug 2022 07:37:38 -0800
IronPort-SDR: gqfyrLBj4obLayYIodUELOeYAABsqQvo8uOyOawchBB2Q8+w5UxlnjBrn460q3ycd6wHjJqmjd
 gh7T7w/QcDRQ6tORaMlE5kUTFcOMmSI30/IrpvCk5Qd/qmt7O9jkSwCyju+AieGSqCOkgrFf0W
 SQJu/53xgPnTrY4XPza5ZHuv1txMaVQqNKYA+Dwut3Ev6jvZD46k0K/9jtxIlvngRv31VMDc5g
 PzxQEqscK8aPSncjQkN92X4fOOyz2DX2qWOKXKw1t+6Wr0Z6OmFLRCVUkUOLkHjinfKI7N5oFW
 iBQ=
Date:   Thu, 25 Aug 2022 15:37:27 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     David Laight <David.Laight@ACULAB.COM>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alex Colomar <alx@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: RE: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
In-Reply-To: <5e10ac07e63e41639b3113d12c264447@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.22.394.2208251533340.108545@digraph.polyomino.org.uk>
References: <20210423230609.13519-1-alx.manpages@gmail.com> <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com> <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com> <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com> <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk> <5e10ac07e63e41639b3113d12c264447@AcuMS.aculab.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-15.mgc.mentorg.com (139.181.222.15) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Aug 2022, David Laight wrote:

> From: Joseph Myers
> > Sent: 25 August 2022 15:39
> > 
> > On Thu, 25 Aug 2022, Linus Torvalds wrote:
> > 
> > > That's a small detail that yes, we've tried to avoid the absolute
> > > humongous mess that the C standard library has with their horrendous
> > > 'PRId*' mess, but honestly, it's just a tiny detail.
> > 
> > I've not yet implemented it for glibc or for GCC format checking, but C23
> > adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> > with printf to print an int64_t and won't need those PRI macros any more.
> 
> Is that meant to work regardless of whether the type is
> int, long or long long provided the size is correct?
> 
> Or does it require the compiler know which type inttypes.h
> uses for uint32_t and uint64_t?

The type passed needs to be that used for the relevant stdint.h typedef, 
not another of the same size.  (For format checking, that means the 
compiler needs to know what the types used in stdint.h are.)

It's now required that if int32_t exists, int_least32_t must have the same 
type, so int_least32_t can also be used with that format (and there are 
'wfN' formats for int_fastN_t / uint_fastN_t as well).

-- 
Joseph S. Myers
joseph@codesourcery.com
