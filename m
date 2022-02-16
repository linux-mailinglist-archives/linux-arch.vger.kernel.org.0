Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C54B8779
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiBPMWy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 07:22:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiBPMWx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 07:22:53 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D3D1D6A;
        Wed, 16 Feb 2022 04:22:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHCd2Q32z4xcP;
        Wed, 16 Feb 2022 23:22:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1645014159;
        bh=b5eBM0apAamYiz9FmsL/tdSBnGcg3AeLZmO6Sx4f7CI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TMxJSrmZkyabs6lKbBV2TP83SZhbStzLgUK6grRi9ZcKO7+n12nPpEJHnpP9OCnY8
         8/bVkXeSr4TuornxqhL4RcEJrh5rUkChWpyGLeNFcP3Fu87/lxk921secNCIk3zvXn
         BlugRQjvtHFZmPYTcTXBw7d7BsSBvevEK4rNDjwe4nPGbzuq+EGD1vma1jJ/4Dgehe
         sxUPxAJ2AFXp33B1HKQXCUuBwuY1vMQ9z/9K1vmjr0O+WWlzXUtQEA/4e7zkVvD8JR
         25CCKfBbyRgfLd8CdMrj1LnmkMIF+epDwaFgwNX5TeFYQN4QCzduAchXgnbefq4FDq
         CcGqmYN75RJWA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
In-Reply-To: <202202150807.D584917D34@keescook>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
 <202202150807.D584917D34@keescook>
Date:   Wed, 16 Feb 2022 23:22:33 +1100
Message-ID: <87y22bm25y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Tue, Feb 15, 2022 at 01:40:55PM +0100, Christophe Leroy wrote:
>> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
>> on those three architectures because LKDTM messes up function
>> descriptors with functions.
>> 
>> This series does some cleanup in the three architectures and
>> refactors function descriptors so that it can then easily use it
>> in a generic way in LKDTM.
>
> Thanks for doing this! It looks good to me. :)

How should we merge this series, it's a bit all over the map.

I could put it in a topic branch?

cheers
