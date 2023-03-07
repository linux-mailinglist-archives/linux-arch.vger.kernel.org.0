Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9D6AD38B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 01:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCGA6g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 19:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCGA6f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 19:58:35 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB32ED72;
        Mon,  6 Mar 2023 16:58:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVxs332LJz4xD5;
        Tue,  7 Mar 2023 11:58:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678150712;
        bh=CHWXVrMkdiyq4zwPZtjE+TsoQPPFRbjP3aPXqFScr8M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KWVVCGW43d7K7bKL3+7NAS3VQRFJRrNz2O6qEQSCe3iM0mAGIBLB0wpEx+hq1cgob
         zWrSY4r1DMNDvtk/jqhxoZ30OwLv16WASzFeifWZILoHN3jHCWsvTtmBOnGX3qdRK6
         l1lpOlGCLel5N3Z1MvgzoxbYsYBqPF6aKYYqR7dABs1WFXYIYTtmKn0P0o/cEKa8ya
         lW8DcOqf6hegaMGqy2+XpmpZ19j9hAutwRaz8eg/A2Sun/lZdLj8UX1yrRseK7ub8j
         6WcXKAD8niU8B//ISRCJPfq1nUy29cV9iN/fMEEr0y6Zvit+Gu412hJF5m69g5zV8B
         6ECeucihx/xAg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some
 architectures
In-Reply-To: <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-3-bhe@redhat.com>
 <87sfej1rie.fsf@mpe.ellerman.id.au>
 <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
 <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
Date:   Tue, 07 Mar 2023 11:58:27 +1100
Message-ID: <87jzzt1ioc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:
> On Sun, Mar 5, 2023, at 10:29, Geert Uytterhoeven wrote:
>> On Sun, Mar 5, 2023 at 10:23=E2=80=AFAM Michael Ellerman <mpe@ellerman.i=
d.au> wrote:
>>> Maybe that exact code path is only reachable on x86/ia64? But if so
>>> please explain why.
>>>
>>> Otherwise it looks like this series could break that driver on powerpc
>>> at least.
>>
>> Indeed.
>
> When I last looked into this, I sent a patch to use ioremap()
> on non-x86:
>
> https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/

OK thanks.

Baoquan can you add that patch to the start of this series if/when you
post the next version?

cheers
