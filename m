Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1F729AFB
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjFINFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjFINFR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 09:05:17 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9EF2D70;
        Fri,  9 Jun 2023 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1686315913;
        bh=hT63nSeqfXe+w/wcTH/EVqDDlEdDBDYjRZhYbxbpM9E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=npo+qrCHsIrTavth6RFp9whOgzBlVXmzRzYXUH+dxBlx16fsDq62B5M0BsrtN4VtJ
         1fdfpCWNVPfQBRPxlsk/T5jnywsDDxzlQF9T3tubgjW3v4DrYce6kTsX/rRJiWMx5i
         hBEItCRBrPuBf/r8DMY+d6WFyBryIiRnxabHdAlU=
Received: from [192.168.124.11] (unknown [113.140.11.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 48AE16638D;
        Fri,  9 Jun 2023 09:05:09 -0400 (EDT)
Message-ID: <5de9d69817138f2ccae0867b5ccb602dcfa007a3.camel@xry111.site>
Subject: Re: [RFC PATCH] asm-generic: Unify uapi bitsperlong.h
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        linux-ia64@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-parisc@vger.kernel.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongson-kernel@lists.loongnix.cn
Date:   Fri, 09 Jun 2023 21:05:07 +0800
In-Reply-To: <ca4c4968-411d-4e2c-543e-ffb62413ddef@loongson.cn>
References: <1683615903-10862-1-git-send-email-yangtiezhu@loongson.cn>
         <b9624545-2c80-49a1-ac3c-39264a591f7b@app.fastmail.com>
         <76d3be65-91df-7969-5303-38231a7df926@loongson.cn>
         <a3a4f48a-07d4-4ed9-bc53-5d383428bdd2@app.fastmail.com>
         <ca4c4968-411d-4e2c-543e-ffb62413ddef@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2023-06-09 at 14:50 +0800, Tiezhu Yang wrote:

/* snip */

> > > > In musl, the documentation states that at least gcc-3.4 or
> > > > clang-3.2 are required, which probably predate the
> > > > __SIZEOF_LONG__ macro.

Indeed, I've digged some history and __SIZEOF_LONG__ was added into GCC-
4.3 (in 2008).  And I didn't realize the bitsperlong.h in tools
directory is a copy from uapi.

> > > > On the other hand, musl was only
> > > > released in 2011, and building musl itself explicitly
> > > > does not require kernel uapi headers, so this may not
> > > > be too critical.

> Only arm64, riscv and loongarch belong to the newer architectures
> which are related with this change, I am not sure it is necessary
> to "unify" uapi bitsperlong.h for them.

At least it will stop the engineers working on "the next architecture"
from adding an unneeded bitsperlong.h :).


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
