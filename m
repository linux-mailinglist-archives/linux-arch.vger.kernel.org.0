Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909F5A0AAA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 09:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiHYHrw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHYHru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 03:47:50 -0400
X-Greylist: delayed 596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 00:47:49 PDT
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B30C9C204;
        Thu, 25 Aug 2022 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661412519;
        bh=9K2f0e10ZANjjOudPs4B7euHG9H2+iiRuaYv5ZJbA1k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nmfnx0FO7b7ckLx4wu28ch41hPeeFb8cw/Rec9LmSdOzvBzyZRKWr29E2ij+mZidq
         p+PyBUS94RPQ8ZVOQohv/ssSTzNWvFVIBOAK2oXYYvF8PxE+ncWh8Qc0BRBwiC+nYu
         1x1J2Ybes6HSKUHLHDFj3IlLEWTGqKVW0tWQGC4U=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1A8FD6684B;
        Thu, 25 Aug 2022 03:28:33 -0400 (EDT)
Message-ID: <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
From:   Xi Ruoyao <xry111@xry111.site>
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Zack Weinberg <zackw@panix.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alex Colomar <alx@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyril Hrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
        Florian Weimer <fweimer@redhat.com>,
        glibc <libc-alpha@sourceware.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Linux API <linux-api@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Date:   Thu, 25 Aug 2022 15:28:32 +0800
In-Reply-To: <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
         <20220824185505.56382-1-alx.manpages@gmail.com>
         <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
         <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
         <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
         <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2022-08-25 at 09:20 +0200, Alejandro Colomar via Gcc-patches
wrote:
> I don't know for sure, and I never pretended to say otherwise.=C2=A0 But =
what=20
> IMHO the kernel could do is to make the types compatible, by typedefing=
=20
> to the same fundamental types (i.e., long or long long) that user-space=
=20
> types do.

In user-space things are already inconsistent as we have multiple libc
implementations.  Telling every libc implementation to sync their
typedef w/o a WG14 decision will only cause "aggressive discussion" (far
more aggressive than this thread, I'd say).

If int64_t etc. were defined as builtin types since epoch, things would
be a lot easier.  But we can't change history.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
