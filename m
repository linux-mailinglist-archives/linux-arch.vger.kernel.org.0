Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764295A1488
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiHYOm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbiHYOl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 10:41:59 -0400
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 07:39:57 PDT
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292C3A1
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 07:39:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,263,1654588800"; 
   d="scan'208";a="81807983"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 25 Aug 2022 06:38:49 -0800
IronPort-SDR: x1Ixj9xEowfDaxB+rCmYv+GSCPnGqKWu+UVR1/d2bXu884TLkcyorKTAOJ3GIdG2sZcAKPnr8C
 HrDpsKuUuy/7A3YVdzDaX/MsrZX96NDhq5JOA2b7iEqcFgR8p++itQnfXWYEalx8sudUp7WR3Q
 um6mcl43b7D6ol4iQIF2NVNDO6kFKAVM4x0sDavVBXMjnIhpFoTzJo4nALK+MjLYUthu9lkmIN
 xkDupHA97VMp7y+qdLBmrdVJnKzGutKQCtTsZdyiix3T/aUpRWC6kZou1GuriOnoXxFN8q1rQH
 aYs=
Date:   Thu, 25 Aug 2022 14:38:40 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Florian Weimer <fweimer@redhat.com>,
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
        David Laight <David.Laight@aculab.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
In-Reply-To: <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
References: <20210423230609.13519-1-alx.manpages@gmail.com> <20220824185505.56382-1-alx.manpages@gmail.com> <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com> <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com> <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-11.mgc.mentorg.com (139.181.222.11) To
 svr-ies-mbx-10.mgc.mentorg.com (139.181.222.10)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 25 Aug 2022, Linus Torvalds wrote:

> That's a small detail that yes, we've tried to avoid the absolute
> humongous mess that the C standard library has with their horrendous
> 'PRId*' mess, but honestly, it's just a tiny detail.

I've not yet implemented it for glibc or for GCC format checking, but C23 
adds 'wN' format length modifiers so you will be able to e.g. use "%w64d" 
with printf to print an int64_t and won't need those PRI macros any more.

-- 
Joseph S. Myers
joseph@codesourcery.com
